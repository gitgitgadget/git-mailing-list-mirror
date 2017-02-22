Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296B7201B3
	for <e@80x24.org>; Wed, 22 Feb 2017 06:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbdBVG2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 01:28:12 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36355 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbdBVG1y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 01:27:54 -0500
Received: by mail-qk0-f179.google.com with SMTP id x71so1535094qkb.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 22:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/c5iP3cJOD9nlUNMt8p9Kyorl55zyxAmqG64GvDmh/4=;
        b=sF/nR/oJYu6XEtAR+TztfMqEjQHkxDYB2ltuy/8Rsh6NC5HQrKEqX3YrwanuHbI+Qz
         xcEw1hIs3ZGC7WpT0kE/wd1663VBsOhsIoB3tv2/uMfSEYWwAn4U6o9YmSV357uW0KA6
         P/lorOYYaBbjmu7p70MQd/lv8nkxziwqrossBJP8gujCpJPdGcVD1kK38vaux9MTYJ46
         DuMNbNSeBsDl9So2SPgqzGM/U2g7MmEqGk+jD9UXVsN11xW8F6hHoCIxo5yOJvxfmJti
         CweZpRzV6RS0wzDcHFAzMuEQnEg9Lyd++e8mg7ZMzl7Vjp5FYn/zsXDpmwNbEsrPfnLL
         hEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/c5iP3cJOD9nlUNMt8p9Kyorl55zyxAmqG64GvDmh/4=;
        b=rnWdj/BTpwcex1dBBKXEHR7UO5xu2rkKH4RCGC7J0IYY5ZuDtRFqBKpz9QlU49S7Ie
         BEeCIoQSap7OsM4GOSBhNfxwZ37wxMEGAapPCJSWGf1jD8ETGe0JBsTYv05b+csfJ5Wp
         4enNN5x4TgzYLTzSiKj5Wdn2KTUJY2V5KeIO9JAoc2WiqazUaMPYvL+yo07u/F0XR0lC
         BQZFnkkhEspMvA9Sqc/r0PaEFSQ/n9+XtaBzeBnQZamuSP1G0b61MddcbdABvwV0sblk
         x5dATnVTgyb/wUzjVg4vhYQNLa3n2EgID6wsTkaoXnrUfGMgro7dVN/tsPego8Sjouzm
         Pvpg==
X-Gm-Message-State: AMke39nL+XSoMaI1tA2x80ybl3CH+ZeIm8IC8Hjy06WPkS7TASm8TaDmseheYfyYuaPqfLRfUv+vFSWGkjZjoA==
X-Received: by 10.55.137.69 with SMTP id l66mr30067243qkd.133.1487744873652;
 Tue, 21 Feb 2017 22:27:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.138 with HTTP; Tue, 21 Feb 2017 22:27:13 -0800 (PST)
In-Reply-To: <xmqqshn8ip0j.fsf@gitster.mtv.corp.google.com>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
 <1487258054-32292-5-git-send-email-kannan.siddharth12@gmail.com>
 <xmqq8tp6x8b6.fsf@gitster.mtv.corp.google.com> <CAN-3QhoXBnLWyfuUsuvvRMYNnoupMrQHxE_G=ysyA_14KX4Yrw@mail.gmail.com>
 <xmqqshn8ip0j.fsf@gitster.mtv.corp.google.com>
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
Date:   Wed, 22 Feb 2017 11:57:13 +0530
Message-ID: <CAN-3QhrAYJaVNf-4LKpT2uZQr1ubyxpd1Cpo-hVhGL8dh+_SXA@mail.gmail.com>
Subject: Re: [PATCH 4/4 v4] sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 February 2017 at 02:00, Junio C Hamano <gitster@pobox.com> wrote:
> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
> > So, is it okay to stop with just supporting "-" and not support things
> > like "-@{yesterday}"?
>
> If the approach to turn "-" into "@{-1}" at that spot you did will
> cause "-@{yesterday}" to barf, then I'd say so be it for now ;-).
> We can later spread the understanding of "-" to functions deeper in
> the callchain and add support for that, no?

Yes, this can be done later. I will send these patches again, with
only the changes that are discussed here.

I will keep the tests for "-@{yesterday}" as failing tests, if that
would help in finding this again and fixing it later.

Thanks for your review, Junio!

-- 

Best Regards,

- Siddharth Kannan.
