Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57FF1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 14:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947766AbdDYOAX (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 10:00:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33955 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1430110AbdDYOAR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 10:00:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id g23so10623309pfj.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FE68Yf3+kjXQzoEesfPs111ViD9B7OhdxWbyDcGtqWc=;
        b=AnIPVkLVg0tgN9fKB2fd1Atn0SJy7ZWUN16J+c9pR1w/x6bKOAD2mj3LE4iCMs1Ipo
         cqdwKe2NeMp7+yVkjnljJ8HrkiPJCTI42cFiH77huA8wQXuCG+xscmaWjZNBy3qJji/6
         apNM15q0kAVMhdeBAJDjazrY/HvGVTZAQicT7rVwhjpyzCYNnWHI7X4t6AwKLLJfXNws
         tMQdfP/l2q48e1arE/eEthOAylsn51ohPGztZuSaHR5crYthnAIqQBwE/Ru8pxyuWVsD
         h5I0byjT7ludKHVCqo5Acp+Ux2fsKD9BTG8lt1SRqo5SfZM6l8aeu35Ev/nfegv75tBP
         81+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FE68Yf3+kjXQzoEesfPs111ViD9B7OhdxWbyDcGtqWc=;
        b=F6wpxQATP9Rjj0l47zKEr56Fb86lP13VpMbkXIxnnrcT15Xb4ngLHzriJVhRVrWRfI
         fTOshZGJFgGBJOirZ4rv1aHq8FJ6qvqfFQy7XlkeZXhty+fNiWiBEMJI4KJgsPBc9nbw
         Kf48HsaSoIfUn2X60LkdMeOspT/PB8/TycQiAMbIqM6SflQ5u8nJ9W6zH0aexaZ4hbn5
         +ajt0jLQBLQEgh8Hrmhg4AtUY18VJvInLHrGWrTR1jfVCAHFzVMulz3zehhNr0D1chG0
         kphOSCMWRMeKiyuCF0A4/kSoafuFOiXHKbd/4bdm3PFjMATlQhFcFasBNWPR6vbv24YH
         GaHw==
X-Gm-Message-State: AN3rC/4SvaN2fYuJ94zLHr9d3TSblQiQKk9d7/KWBUd7q1KSHagW48ji
        YVSixwKE1ZcBR0IpN14zvA8jx+N22g==
X-Received: by 10.98.11.13 with SMTP id t13mr29553218pfi.104.1493128816586;
 Tue, 25 Apr 2017 07:00:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.159.132 with HTTP; Tue, 25 Apr 2017 06:59:56 -0700 (PDT)
In-Reply-To: <87vapsq073.fsf@linux-m68k.org>
References: <20170424032347.10878-1-liambeguin@gmail.com> <20170425043742.15529-1-liambeguin@gmail.com>
 <87vapsq073.fsf@linux-m68k.org>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Tue, 25 Apr 2017 09:59:56 -0400
Message-ID: <CANoM8SUoMVL4TRGSPYRXOuj0-=QUOJPWss8Uy-pq5VYYEbjAzQ@mail.gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, Git List <git@vger.kernel.org>,
        Jhannes.Schindelin@gmx.de, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 5:57 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Apr 25 2017, Liam Beguin <liambeguin@gmail.com> wrote:
>
>> Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
>> to abbreviate the command-names in the instruction list.
>>
>> This means that `git rebase -i` would print:
>>     p deadbee The oneline of this commit
>>     ...
>>
>> instead of:
>>     pick deadbee The oneline of this commit
>>     ...
>>
>> Using a single character command-name allows the lines to remain
>> aligned, making the whole set more readable.
>
> Perhaps there should rather be an option to tell rebase to align the
> columns?
>

You _can_ set a custom instruction format using the config variable:
`rebase.instructionFormat`.  With this, you can align columns using
the normal git log format.

For example, I personally use this as my instruction format:

    [%an%<|(64)%x5d %s

While, this won't always align perfectly, it may help scratch your itch.
