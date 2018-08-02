Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34331F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeHBXKn (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:10:43 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44306 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeHBXKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:10:43 -0400
Received: by mail-wr1-f41.google.com with SMTP id r16-v6so3447243wrt.11
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=48QrGfIEQyb6tjRCQJLFBlicOSG3vtPT0kkMciBFec0=;
        b=F8oOPiwmp6iBACGQwNN+5L5RnWBxU6rA8L4rJsSr8MkvGRQUJu1EJTxJeO9dZCtz6/
         5EztJ02rr7RhZuZgTvPqHEK9sJnoisjkj0d9nrWESbXW8DQp6vUQVi3CYIa0/yppgApZ
         Ly26NVY2kSOhubeID114yfgba5brZ5m3NTY3ZkpMV2yjrTC1d56cKLfiP0NVIEs15qkQ
         sLoKaiQm+u6nPhb8lco+IQNzQIbAnDif2f4G8JyJJ9hwI3OC2/fI7OjaHOewmIdar0AT
         oa7+07ApCKWAcOJJiCUS5dIFn982rmdV0srXUPYfr9ISDhSR1Vv6gA89IIpcBxNSdILE
         H8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=48QrGfIEQyb6tjRCQJLFBlicOSG3vtPT0kkMciBFec0=;
        b=Cj+QzjRtbrDCa3Jca5qPuwLR8Wl77LCvz+JJVIy8i7ATHBQufF8AFxtSpczbyiSBau
         SOY++4pnx/k/SUeLldxwfbRTAb32AGbozXrcc4aLKPUcMIrbC5T8Kx9idJKEcorkRbit
         ApKhZ0avn1Z8vncmDGMhqeUbr9xxvNayazK35Qnw56apwdQJskqtLKykJnX+54aVZgzP
         iL+Ps612hN5gacWqHR0iiGmkUFh9jDo7t4hIOZvp0gVjvecMFdlIzoYVG7t6pfiA1AJS
         gfs04vqZJhjSoV3AJTzVXNbnQL3UOaUVI6YxcuDf+dGMtTeR7YDQ01G6pdzMrSmbubTe
         iX1w==
X-Gm-Message-State: AOUpUlHsDH3LTpc1gWtUIyX+uKk9lu+DRGVdefpa/ggDKk7L9EqRY+8t
        Wj+OU1S5agMZbLG1UfRaC84=
X-Google-Smtp-Source: AAOMgpfLt7Qrzeso41jVIat4FOMm0mrphfQSaC0fqwkjYU0Rx2QWSlGb29ldF0qr2MhZiDZBQsm0Bg==
X-Received: by 2002:adf:ac66:: with SMTP id v93-v6mr696418wrc.7.1533244667453;
        Thu, 02 Aug 2018 14:17:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w185-v6sm4091977wmw.6.2018.08.02.14.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:17:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/6] add, update-index: fix --chmod argument help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
        <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
        <20180802165457.GC15984@sigill.intra.peff.net>
        <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
        <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
        <4b6fa9ca-97ad-74e8-f252-cc62470f5946@ramsayjones.plus.com>
Date:   Thu, 02 Aug 2018 14:17:46 -0700
In-Reply-To: <4b6fa9ca-97ad-74e8-f252-cc62470f5946@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 2 Aug 2018 21:59:44 +0100")
Message-ID: <xmqqeffgzcw5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>  	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
>> -	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
>> +	{ OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",
>
> Am I alone in thinking that "(+x|-x)" is more readable?

I think I am guilty of that, and I agree yours is much easier to
read.

It can of course come on top of the series.
