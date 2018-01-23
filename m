Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6531F576
	for <e@80x24.org>; Tue, 23 Jan 2018 06:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeAWGbx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 01:31:53 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:39970 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeAWGbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 01:31:52 -0500
Received: by mail-wm0-f53.google.com with SMTP id v123so21214323wmd.5
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 22:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oflGRsIOikPADlTibzb+TXhPZdQPGS4n5WqTCKQ5iTU=;
        b=S0gHhRSJ/9En2viAnog/HcadhP8HS2AgpM4XyvxN4H1iLSXhtLpyFzGT6L5VDYpPjq
         hcJEuLuAjXjVKtBHsN7nULuJa+mK8c+gkaHbWgNeB0IIeBqF5i/GKc2weZblAswcPGGO
         rsUyn/o5pCSCLdMz4gJTHYmgXDXNWy+8dRNxLGPeJt06Ysh+e+Dz70m2R3ehJZNyZNHu
         /3VzyiAcWgWe7SsNlP+5tfGIc04qgVeZaWtu20GPjQO5S4DLJcmsskzq3C/8Fo2aLPDv
         jmAO/HCmRLoqVFrJuXTEqGSxeJ2zfdc2QxfNB0YZI0zYFWbs7UIrlVCjTDzoDyoEcBy+
         bJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oflGRsIOikPADlTibzb+TXhPZdQPGS4n5WqTCKQ5iTU=;
        b=LgBjWB6VT4xu5rQRlVlJOSbM6Gq1UV++XM2HClJziVSgnfP6NXERAUf73BW39iTLTK
         ezBkFznB+LlKOA0vHcPOs3iD21Dzc9a8sqM3AvLxP/QjA2Nxue90Ockeht5/4JlMbsXf
         qw+NmcaCbbN95st/Vm5Gt0VVhYeN2UsIokLHO5oaNw2JIhlumLw28BIk96cvd6Y5usef
         CG4wO3gozArOznVdgoVgtltCgb42oACYJn/QAuqWAG7eked2sw6PSn3HoLhgxxnIZ7qK
         AQS0CNCVw209Hu3740qnpmMJNAXSUObcifebBD5OSN4x5rTPXFaBPSuRZhpn+SGCcpT8
         D1lA==
X-Gm-Message-State: AKwxytfgVVKGTru8kXwjy/Zk+JbWZdFeMnj13PDvLYDo2c2meheNRiJL
        6LEzD4QPmvmjzJqqwiyAJEcckg3iLclbWEnkdk4=
X-Google-Smtp-Source: AH8x224wK6j+3gkW6rZWJjoZk8ufaIRe5nGTAHLBprv9Gy2jMoYm2aqS57qC/3RfDA2NQN2/ET9n/RWutU4C2OW2mHo=
X-Received: by 10.80.211.7 with SMTP id g7mr17724770edh.76.1516689110877; Mon,
 22 Jan 2018 22:31:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Mon, 22 Jan 2018 22:31:30 -0800 (PST)
In-Reply-To: <20180123005950.GH26357@sigill.intra.peff.net>
References: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
 <CAPig+cSuBRcM7BBw1MKOOVSZv+CVVrY-dWfSGj+31DA4QMrruA@mail.gmail.com> <20180123005950.GH26357@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 22 Jan 2018 22:31:30 -0800
Message-ID: <CA+P7+xqfHnsoOq8EPb-4feu8Q6gdRTCeOGRVkSyjNJNtmtiw=Q@mail.gmail.com>
Subject: Re: [PATCH] Fixes compile warning with -Wimplicit-fallthrough CFLAGS
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 4:59 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 22, 2018 at 07:54:18PM -0500, Eric Sunshine wrote:
>
>> On Mon, Jan 22, 2018 at 6:51 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> > This patch add explicit fallthrough compiler attribute
>> > when needed on switch case statement eliminating
>> > the compile warning [-Werror=implicit-fallthrough=].
>> > It does this by means of a macro that takes into account
>> > the versions of the compilers that include that attribute.
>> > [...]
>> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> > ---
>> > diff --git a/convert.c b/convert.c
>> > @@ -1554,7 +1554,7 @@ static int ident_filter_fn(struct stream_filter *filter,
>> >                 switch (ident->state) {
>> >                 default:
>> >                         strbuf_add(&ident->left, head, ident->state);
>> > -                       /* fallthrough */
>> > +                       GIT_FALLTHROUGH;
>> >                 case IDENT_SKIPPING:
>> >                         /* fallthrough */
>>
>> Why doesn't this /* fallthrough */ deserve the same treatment?
>>
>> >                 case IDENT_DRAINING:
>
> I can't answer that philosophically, but I can tell you why the compiler
> does not complain. :)
>
> Usually case arms with no statements between them are exempt from
> fallthrough warnings. So:
>
>   switch (foo)
>   case 1:
>   case 2:
>   case 3:
>      /* do one thing */
>      break;
>   case 4:
>      /* do another thing */
>      break;
>   }
>
> does not need any annotations for cases 1 and 2 to fallthrough. Which
> means that the original comment was not actually necessary for the
> compiler, though the original author considered it a useful comment.
>
> So there you get into philosophy. Should it be converted to a
> compiler-visible annotation, or is it better left as a comment?
>
> -Peff

I'd personally rather stick to the comment if we can, or use something
like "fallthrough;" to make it appear like a keyword, instead of an
all caps macro, since at least to my sensibility, the all caps is a
bit too crazy.

Also, I would not put one inside an empty case statement that just
falls through to the next branch and does nothing special itself.

Thanks,
Jake
