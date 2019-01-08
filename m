Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736F71F803
	for <e@80x24.org>; Tue,  8 Jan 2019 07:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfAHH3q (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 02:29:46 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36952 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfAHH3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 02:29:46 -0500
Received: by mail-wm1-f53.google.com with SMTP id g67so3224424wmd.2
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 23:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NzYZ9t+fUrSkVvcX1mIZ5VgLQ3jiLqHYP9jVQsj8Iwc=;
        b=pBN1KhIHje99CATTa/OwBmlUUUYjsU+rr5sB27g8jxKBO3yJ/WPEMNTSnpS6/2FWlV
         chSMTfapOhypkC1wGT1HdZGI3LxGdhVB+BLkB5mJfAmEDevScex85YW3y5m9lIye+x3W
         Xyx54VfiHQvFQaECiLOo9dRMtMJQwT0uPqOhXWRKSeKDewUsOfa4esfYr3v/MS9UKzp5
         fimXcSA2ZVG0T5QMoi9MVyanalPoojPIOSyooxvlavhPDFKdq5/KI2jvX/dINdc0doHn
         gPzRJdLyTzyv5LX4h8z5aWFoxvvZ98YhU7sRb3jFUsl0J4O2BQdFpm++C3Gl/mbtl9nm
         vSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NzYZ9t+fUrSkVvcX1mIZ5VgLQ3jiLqHYP9jVQsj8Iwc=;
        b=K84Fs06zvUCxvrNJ+OKQEWYoOWuwykeZv3G1Wkf569zxiTJYu+x97/qUbqHqpZ2+84
         OqO/APo8jQeE82yDipWsteLAM0V4ixKnP1eMK1INTUODyXtSGXoejHzXv+eKGU0WvQO5
         bc1gPLbcMDZAR16HmmPhPElbk2s+F0t+FZ/rGjg3TewUIxfIl7tgADpXCxY0QWCIUKV2
         Phg/6RuYg7OIOcTSahG1rOJ76FkBtSReG3TaEmAhWXe4s6iGH3YNxsoTYtwYlZP/Rtr7
         UjOcwgwFbQGEb7Nic4omvRVhJcjt2Ip6RahccjXIMz8U/cT/ps9oHEE3dgLKkD4mNL8O
         bF2g==
X-Gm-Message-State: AJcUukdtU+5kGO46aRDL+2BJuhMXjZ5fj0V9g+lhmw/+t2ufAEzWIa4i
        oubAhkYA5v9JdSeI69rkeLp0nrh8DDSrWUP3lg3x5oyN
X-Google-Smtp-Source: ALg8bN6ATDd/AM7bIIqv4IOWSx2hvUJRiLvVVEXubF3w9YjJUjS4S6FapqW5JtDY+IX2qIExe+fE3hCLlSYSigm9mJA=
X-Received: by 2002:a1c:8791:: with SMTP id j139mr776653wmd.86.1546932584310;
 Mon, 07 Jan 2019 23:29:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEBmVQ8H78uHSPSBy+HqLXZ3xE5=jVdYDfPOVZ_53U8YA-A@mail.gmail.com>
In-Reply-To: <CA+dzEBmVQ8H78uHSPSBy+HqLXZ3xE5=jVdYDfPOVZ_53U8YA-A@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 7 Jan 2019 23:29:47 -0800
Message-ID: <CA+dzEB=fM_hD6P=fCvOtDrEAKa4eOgErmp8=nzRfoxOJHAG_zg@mail.gmail.com>
Subject: Re: `git reset` for delete + intent-to-add doesn't reset
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 7, 2019 at 11:25 PM Anthony Sottile <asottile@umich.edu> wrote:
> Even `git reset --intent-to-add -- a` or `git checkout -- a` don't
> seem to clear the `intent-to-add` state
>
> How do I reset the intent-to-add status in this case?
>
> Anthony

Pressed send too quickly, it appears I can use `git rm --cached -- a`
to undo that.
