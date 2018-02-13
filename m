Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270191F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965408AbeBMSKu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:10:50 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55729 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965286AbeBMSKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:10:49 -0500
Received: by mail-wm0-f45.google.com with SMTP id a84so6423625wmi.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3ESUvtq2qtitUFw48zz1RRWH8ebF/+1Dt9jlVmJaTjg=;
        b=cFeFiOb3hVAb6RmQ5dQqcPSR7zFFX6Av38w6JTkf9w/QPpYX2+feyTC/LlELgvCYJA
         5u1ua6SB3gxZ27BNE8KR06Qz74Hu0lyVbduWCtdlCAdVgtCG/8fvm4Zi2Vm+tmb54qkJ
         lzo6Ph71E6jAcIeJnMPrkxTLea7zs6j8rDDS2mXNFXcZxaAuB4k2YPn0T9i4ZOsBOxN/
         3cc4Y2PoIieE1eSNQt37/dybx40P+x8/RWRSfaxoyqLbjPPbvKbCB4hvmi1YW6wa0XKB
         yyscx7ShWQgRvEM0Yb++iqp425PBuQx7UJxoNYr3/pzhBi9F8REaiNzvBts93S/TmbXF
         3F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3ESUvtq2qtitUFw48zz1RRWH8ebF/+1Dt9jlVmJaTjg=;
        b=jt8AOmaKRTqMtSKs8s+yvwc+1MCzh5HGeln1/LFMHgAMzsDa0nukUBVAi3ugqQo+xK
         s7FQsYK7m+cpQNy9lEFCpk4OFw7tDhDtJFFacsHTghE9f5K+uFXcBeCO1vVVNPpeWcQF
         j0XCfhtRMeRsewM+6WjTCt4PRQedHI56x0TalkzP/ZqHdoGYgzljiQJMC9UzJhq2cuMQ
         glKMK16WKvm4TPM3ta9rL3aY7SAZW3Mw6Czyq0g0ylFpwZG9AIuD7rI2OEmXma13Sxih
         s99AkU/Gxx9KjS+/bAdxhff+IWFXUpPwcpMZ36vbj45xdtPFp+spyIOir3UiWDLYhWKI
         5+lw==
X-Gm-Message-State: APf1xPCBeVQ56R9uYSZRX7zMTN+GAkEkZl1WnwsNK8aP8Ld7JiLIU2oB
        0PxMLvvEGellwlN+itjt2qs=
X-Google-Smtp-Source: AH8x2274yaiLyugSur8+hn0kT+gSpWMqQpV50TTl4a34fWJSxhkKIWN7HUBuky0bhp77RRHsy/lCHA==
X-Received: by 10.28.62.203 with SMTP id l194mr1938685wma.121.1518545447574;
        Tue, 13 Feb 2018 10:10:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t14sm9178691wmc.23.2018.02.13.10.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 10:10:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
        <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
        <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
        <20180213100437.15685-1-szeder.dev@gmail.com>
        <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
        <20180213172603.GA10062@sigill.intra.peff.net>
Date:   Tue, 13 Feb 2018 10:10:45 -0800
In-Reply-To: <20180213172603.GA10062@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 13 Feb 2018 12:26:04 -0500")
Message-ID: <xmqqeflorc9m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If I understand Gábor's patch correctly, it is using test_i18ngrep for
> the specific lines we care about so that we don't have to worry about
> other cruft lines that may or may not appear (including the hangup one).
>
> The downside is that we would not notice if a _new_ error message
> (beyond the ones we expect and the one we were explicitly ignoring)
> appeared. IMHO that's probably fine.

Ah, OK, I didn't notice how the multi-line one was handled.  Unable
to notice new error messages and undisturbed by possible "hung up"
messages are the sides of the same coin---I myself am unsure if it
is a good trade-off, but I'm inclined to defer to judgment of two
people ;-)
