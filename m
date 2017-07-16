Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762B42027C
	for <e@80x24.org>; Sun, 16 Jul 2017 21:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdGPVbn (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 17:31:43 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35823 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdGPVbm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 17:31:42 -0400
Received: by mail-ua0-f172.google.com with SMTP id j53so76964361uaa.2
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qWOc1XnhNwvmL/nNYAh7BA2SvGKogNnoGXluBVx3WUI=;
        b=MO3gjSd2xJi+JlE0ecPmJgLlr90DVZG0FrajAL5ityu2fUC1+IR4Lme4d7MsmlCw6O
         HTLXGlWPH4aO43Lg0Y7KIQbFL9/gGvG0yj0nq6e3c3MmeSlVRBF1Dcwz84t4t+NWzniM
         w5lOD+7EEgB8j0H0EJGMyASEHRkZB6Uw9RhtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qWOc1XnhNwvmL/nNYAh7BA2SvGKogNnoGXluBVx3WUI=;
        b=hToikZFWS7cCWWhbZfETRgwj2eaeO/yw5jzS7o3cK4JVxWYLbJIvlvHlKgutdrhcT1
         p90G0Kh4oWvfik54UH9/BkVYLQeRlVZMnss4dcGTcmFjZzyMLSO7c3Ztgs2xgxRes6Wg
         vzstIQcbFiep+zDoBjnqx7bHysSvsQHFAmTMU61jR6cOkBqRIz6jSRZqrklHT3oJ0weu
         pyszIiQMUffFh+wQ3r/nnLEv29lgm3i0y/YO0Hy1/VIEDp4oMaDlEcTWUSLuKUrBxR1o
         APKTtGcsSkRr3jP8ebynYjaAbvTD8ydSeCl39jSF90xzKh/5kRSiTrh6nT/kr5yMLZgD
         YtHA==
X-Gm-Message-State: AIVw1129g6qIQU6goArqMEzcROT39qtLkV2GKJJkuC6uTHXyrYeBimm3
        EkJnMsPZq9CccLdJ/5R8sr3yp83jje4l
X-Received: by 10.31.199.193 with SMTP id x184mr10925170vkf.105.1500240701577;
 Sun, 16 Jul 2017 14:31:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Sun, 16 Jul 2017 14:31:20 -0700 (PDT)
In-Reply-To: <CAD0k6qSpNTWkn-97nQQ1DJrh=sd3dppTXytfbafqj-eVsWDTFg@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
 <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com> <CAD0k6qSpNTWkn-97nQQ1DJrh=sd3dppTXytfbafqj-eVsWDTFg@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sun, 16 Jul 2017 14:31:20 -0700
Message-ID: <CAJo=hJue2MYcE-xc9qjRXfMCf5f5+QPzmZQwHtqgr_zALeQziA@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Dave Borowitz <dborowitz@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 2:13 PM, Dave Borowitz <dborowitz@google.com> wrote:
> On Sun, Jul 16, 2017 at 3:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> True... but... in my "android" example repository we have 866,456 live
>> refs. A block size of 64k needs only 443 blocks, and a 12k index, to
>> get the file to compress to 28M (vs. 62M packed-refs).
>>
>> Index records are averaging 28 bytes per block. That gives us room for
>> about 1955 blocks, or 4,574,700 refs before the index block exceeds
>> 64k.
>
> That's only a 5x increase over the current number of refs in this
> android repo. I would not be so sure this repo doesn't grow another 5x
> in the next few years. Especially as the other optimizations for
> working with large repos start to be applied, so it won't be
> prohibitively painful to work with such a repo.
>
> Are we ok with increasing the block size when this eventually happens?
> (At least I think that's what we would have to do, I haven't been
> following closely the discussion on scaling limits.)

I think I'd try letting the index grow to 4 blocks (256k) before I
considered increasing the block size. Remember pack idx files are much
larger, and are loaded wholesale into memory by JGit. A ref idx at
256k might not be problematic.
