Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6381F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBHSVn (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:21:43 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:37962 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHSVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 13:21:42 -0500
Received: by mail-yw0-f170.google.com with SMTP id m84so3289283ywd.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4GifTN5tP5xhNtVyNoY31N4KBoaQrLxgnxvWPc3NUYE=;
        b=LJfyCgOcLIYh67CcxRE8LahvtZfnYpxNEqoxz0MCjPBUACSkD2PhR4LWIJYnrShE0Q
         Gikd6t1z8ITBG5LjiDVFdgCU9ffu3LTfz1Wz6AKJ2ARFQ1xJB6fWVBuKG6xR7oil8/ZM
         TEGalM1Gf3aTileQc3vTcibtE/52oNn/mG7RwbQIop2b20Yyp8gbMCZ+s1zuV9oDZsda
         Hc1+qOoRPt3lNBFkgMnWTkvQGaWWWDKJ69V5vsTE4tpxcST6gtlyK2q/dZtOufSYdgWr
         wMNF2psErfTRttjAshJ8tMJGatraTvfLSVSr4FKD9fd5Wq72rAcACcDAfeYVSEV80OFN
         M2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4GifTN5tP5xhNtVyNoY31N4KBoaQrLxgnxvWPc3NUYE=;
        b=qEs7+V9BY5QTBs+Hg5hWB8qjMJbFztyui8aM60iYuTR80iBvHuEIPqxtr5l04JKm4g
         tw4loGAwZYSjDjQGFkGcuiYOtCTxoSLkWACNt+6OQt+nJ222icFepYSeVHabnUSnXE4c
         fSlWT7YW+vKRq37m8rUvXQg7Uw7h/K5bndwegEFQCudA2Itgd4/2RWm/Eb+JM9HRvKZt
         uRdYgODIs9tLX784B9mJUu92zdzqc9y6D3nx0nGsm5htEseoLyN3Zmvayiuhd+4+tsFu
         U8SEb40MnWL8HNwcQjoFzxjDwjT1Hb1tMaiy1FI03KXaPdEmzVuOWczfcmA4KGu0SJ4L
         hlVQ==
X-Gm-Message-State: APf1xPBgP4QVWLozsorH/1YQu29o+cUBT3IlZyuG1aFHDH/XPxAxeako
        0Z/b/e19KNTNOFXGs51fzy1hrtZRjK0QcbeeL9NCbQ==
X-Google-Smtp-Source: AH8x225ggePzxyZP/RIhMtK4aagNIlOpY1Gq1jVoUas4xXiCN1BcqOwHh06NAGzNkFgc3bnc/aD7sny6a+Ft4ExBKsU=
X-Received: by 10.37.180.65 with SMTP id c1mr24370ybg.438.1518114101503; Thu,
 08 Feb 2018 10:21:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 8 Feb 2018 10:21:40 -0800 (PST)
In-Reply-To: <CAPig+cQejz+1ZWep31hw0pjxUoewRt+-2WATtw6PEusfvhn8EA@mail.gmail.com>
References: <CAPig+cQZr=UN3KC3LnaKy=oUYd1inbtDgi_pDuhPXf9HgFOdNw@mail.gmail.com>
 <20180207234359.31493-1-sbeller@google.com> <CAPig+cQejz+1ZWep31hw0pjxUoewRt+-2WATtw6PEusfvhn8EA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Feb 2018 10:21:40 -0800
Message-ID: <CAGZ79kZ1WA15cybgi9u5h2fh37TOjYmDpLdHgFfyLGBf8pUwpg@mail.gmail.com>
Subject: Re: [PATCH] send-email: error out when relogin delay is missing
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ramkumar Ramachandra <artagnon@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, mina86@mina86.com,
        mst@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jan Viktorin <viktorin@rehivetech.com>,
        xiaoqiang zhao <zxq_yx_007@163.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 12:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Feb 7, 2018 at 6:43 PM, Stefan Beller <sbeller@google.com> wrote:
>> [...]
>> Error out for now instead of potentially confusing the user.
>> As 5453b83bdf (send-email: --batch-size to work around some SMTP
>> server limit, 2017-05-21) lays out, we rather want to not have this
>> interface anyway and would rather want to react on the server throttling
>> dynamically.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> @@ -379,6 +379,9 @@ unless ($rc) {
>> +die __("When a batch size is given, the relogin delay must be set\n")
>> +       if defined $relogin_delay and not defined $batch_size;
>
> This only makes sense is 'batch-size' is specified but not 'relogin'.
> If the other way around, then the error is confusing. How about this
> instead?
>
>     "--batch-size and --relogin must be specified together"
>
> ...or something.

I like this for its expressiveness as it would have helped me a lot.
I dislike this because it is incorrect when you use the config options
instead of command line arguments.

Stefan
