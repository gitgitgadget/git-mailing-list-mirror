Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADEC1F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeEUSsC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:48:02 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33469 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeEUSq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:46:57 -0400
Received: by mail-yw0-f195.google.com with SMTP id g16-v6so4783466ywk.0
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hmEpC995BRcC2oPDjAjQKRZcmQhYmMGzqWI7vsOnzjY=;
        b=MkQZLcz74qgc8zlG1BBpmqPNh45IJWkLF+y0Z9QsbzLSu7D5fgI7jK9bKeK3crFsJ5
         V2QX9YZXtNNEA4eNZdVazVxkeKrg4AE2fzKmhbiWBNjYXvFeTxXe6AwA1RiZFZzVFihM
         O5T2Ge3apuqdvY20z1N8yNcPnXS5YiYEGunVml0yK27XNmTCliqd/WCquwrY+q37yhx/
         zSJ2+8rVhR0WafTCVxu6fYVS4l+rVLK4BSLiPUbATBvR0qEE6Rx9BkBo12xRou6BOGpF
         cqjrr73maQBOIgnaSwLc2CZ1SdQXjK/jPZYpZiAoTtvoOsjL/heOQnHLNeKPIWBB0CR8
         WF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hmEpC995BRcC2oPDjAjQKRZcmQhYmMGzqWI7vsOnzjY=;
        b=hYoFGBGkynDkJYr0KQKTqMF+DKDnaGc44HZuy93IzFwzd2tmGILe6xj6gLEemTj+Jr
         zrZNroa/VWszD76pln/EorXz19EdZVCPUh8xCoUJjwQVe9hmXCf/61v5Jcyp/Q59Xa9B
         U7txlzSN55YZ2U/YoNgPOx8t3QqAOiYAsxRJvNHUQ7XT0s4eAtb8rlyb9AepTkCKTUSJ
         UCbsYJW+xUPcoRMwAcpKtP9XAd/sDd1HeNv3uaZ9Osx2XW54aIAJKz3RfBhAvRP9CjzQ
         1799uYUqhH3z3HLsSFwuTwNOORVe0zoKa3Uwro+c0sA2Z9BOPav2bAu7I3zAVRLOjWh+
         08+w==
X-Gm-Message-State: ALKqPwcJKJDMnuDtbIXnUBjj7bSIMKmCFytozBTiXY8WMJCWnCFEIVYJ
        g2WWXn/f2PC6zNnYXYJdrlWvhiNcz835fmBxz7/FuQ==
X-Google-Smtp-Source: AB8JxZrWZdaeXlpFT5jR5nteb8A2Xk/9nrYwOCwfPdZbRPvbYYHqqgCEYIrRsPaJGBKImrjAdhCzcLUgcvhQ3wUw3lg=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr10669783ywe.500.1526928416433;
 Mon, 21 May 2018 11:46:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 11:46:55 -0700 (PDT)
In-Reply-To: <20180520174537.GA18193@hank.intra.tgummerer.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com> <20180516222118.233868-8-sbeller@google.com>
 <20180520174537.GA18193@hank.intra.tgummerer.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 11:46:55 -0700
Message-ID: <CAGZ79kYkon8n9adR8AxUK9DuHGCEzJ136wgj+_q7hYn9wy-Kmg@mail.gmail.com>
Subject: Re: [PATCH 07/11] rerere: use repo_read_index_or_die
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Antonio Ospite <ao2@ao2.it>,
        Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, May 20, 2018 at 10:45 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 05/16, Stefan Beller wrote:
>> By switching to repo_read_index_or_die, we'll get a slightly different
>> error message ("index file corrupt") as well as localization of it.
>
> Apart from the slightly different error message, and the localization
> (both of which I think are a good thing), I notice that this also
> turns a "return error(...)" into a "die(...)".  I thought we were
> going more towards not 'die'ing in libgit.a code, and letting the
> caller handling the errors?  Either way I think this change should be
> described in the commit message.

oops, I will to drop or fix this patch from the series as I think the
not die()ing is a good idea for libgit.

> Also all other messages in 'rerere.c' are currently not translated.
> I'm currently working on a series that includes a patch to do just
> that (amongst some other changes to 'rerere'), which I'm hoping to
> send soon-ish, but the textual conflicts should we still want this
> patch should be easy to solve.

I did not mark this series well enough, it was a mere attempt to
"see how it goes", but was retracted as a whole[1] after Junio
dreaded some merge conflicts.

[1] https://public-inbox.org/git/CAGZ79kbvjoTq5079Ks+h2HNb+D99RELYPcJk2=pvZf9-Y8dToQ@mail.gmail.com/

So do not feel bad about any merge conflicts in rerere, as this
series will not land any time soon.

Stefan
