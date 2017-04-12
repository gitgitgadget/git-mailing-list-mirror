Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A330520970
	for <e@80x24.org>; Wed, 12 Apr 2017 00:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbdDLA1H (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 20:27:07 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:32786 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbdDLA1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 20:27:06 -0400
Received: by mail-vk0-f54.google.com with SMTP id j127so198363vkh.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 17:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tAshw8Y4ghBPhkTsQM1IV4n0OzZm2gqn9NriUJXoXe0=;
        b=CSMfRO4UtmEZHRKJ3g4EcMM7hjEpG3IoH+eIRpSH04kj9Cqu7kZ0CkUfgrvFparcm8
         g3sYnIOkZeYPZlDIWzOl3Rqg1gSJ5vcyQiyDcjcF+ne4ZU6G7fMMwgbZD97l+Gynkpm+
         Y0ewzgOdsgxfNgBm3qwMLTWqghMux9pjpgKS/IeWPfPTUdznC3Fs4NVuKdueHM3SX0k5
         rCNAJr5g+HjAT/iIwNQOYlzAG5M7XA+wLk0Y0Zi75R+5G8aim6OlkZ6ZynvjnZFp6HOb
         uh/I22nDygveJu35KE6BFJcCi5S+cPF2cZRvzArJdzf49NOWB7pWGHdn+pg7Hq46yRco
         CYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tAshw8Y4ghBPhkTsQM1IV4n0OzZm2gqn9NriUJXoXe0=;
        b=CaS9/ATzHag8GkSFbGkhZwWsG+H3q3igeKqr4NqDrX7YJsQ8AhkmEQ0MRELyaQwI/f
         bLieKsdaYp4Apzsk1PxxFrtwB5v3sKdxw3rSaKAMotqtZ7B3LGU49ELM/+lX8RNckGsx
         WNaJcNhbEmh0wygAfFQTtfQvAxglN9HZ53cfY2pxia0p6fYHmif4UFbk6WOipT8iY9F+
         8ga8FmQ1nUmbKous23rVo3702nXi4vHJ0zbj2eA0EdnvfbFsx3IJISn3BkKPMgq5omG8
         4fBNOT5q2IY81RE3SU6u/5WcgHeSnGk7VPrfH/kIiT4/uw+Z0AIFlOGUdNgZ1x5WaKp9
         S+OQ==
X-Gm-Message-State: AN3rC/4bGkkVTy5iICUZ9cOnopI8v8/5zBkGK4NKV0HAnCdFWKYd9DdKHz5O8ku2JEE6GcSj6s80MDyO0dvxdQ==
X-Received: by 10.31.182.141 with SMTP id g135mr145966vkf.32.1491956825385;
 Tue, 11 Apr 2017 17:27:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.1.236 with HTTP; Tue, 11 Apr 2017 17:27:05 -0700 (PDT)
In-Reply-To: <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
References: <20170410125911.6800-1-szeder.dev@gmail.com> <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
 <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
 <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net> <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net> <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 12 Apr 2017 02:27:05 +0200
Message-ID: <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 11:32 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 10.04.2017 um 19:01 schrieb Jeff King:
>>
>> I wonder if you could make it a general test-lib function, like:
>>
>>   run_and_wait () {
>>         # we read stdout from the child only for the side effect
>>         # of waiting until all child sub-processes exit, closing their
>>         # fd 9.
>>         does_not_matter=$("$@" 9>&1)
>
>
> I'm afraid this won't work on Windows when the invoked command is git. FD
> inheritance between MSYS (bash) and non-MSYS programs (git) is only
> implemented for FDs 0,1,2. That's a deficiency of MSYS, and I don't think
> that was improved in MSYS2.

Oh, that's a pity, I was almost ready with v2...

Unfortunately, this makes the general helper function unworkable, of
course.  Though in this particular case it wouldn't matter, because on
Windows daemonize() is basically a noop and 'git gc --auto' remains in
the foreground anyway.

I think we should stick with my initial patch, then.
