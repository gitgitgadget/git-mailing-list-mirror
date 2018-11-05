Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084F51F453
	for <e@80x24.org>; Mon,  5 Nov 2018 05:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeKEOf7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 09:35:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38350 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeKEOf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 09:35:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id l2-v6so6710299wmh.3
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 21:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1H5EqEeOcoXsq15c1OFAHgTpNbSNeLLk/J3z8rXHAss=;
        b=rqhitGmLaKZDJg5EZajPxOAF3FmVAyyfOvRyV52OKr9DJX7qvk4WyhGwR8V7XIv1SS
         +bYAuxU34Tusmg6O/W5pCblPVlxEZXTUO9JUKXSFiSGEcQRBeMvIo7mO83Q2yaSDn3Iq
         7TIkK2Rs238HFL0B4Ls656MT73deFj6e5WMO/soeLA8g1o3WEeYtkhT5qaM313LfTTrp
         nt52Sv0fi/MMINAPzp73tsBUyR+GpgfAr/VnixvroJ1vaZwGYV8ItP/EOtMK+4VIrewi
         W/F0VC4GH+LzJzX49yoHF1oczZSAGkPfuygDepWEJ43+8EQxI/OdDj6QtMq3WY62UZnF
         9NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1H5EqEeOcoXsq15c1OFAHgTpNbSNeLLk/J3z8rXHAss=;
        b=Bzyv3iYcRAPi0G6g14mh3G3mP/QaQpVh2gFy2NFwKwJvUGrDb92FsInacVWj9f/Z2g
         e3UzLYC3RGVtOjCUkYAUBv7luMiPHnMAmAg6r3PHfIFL6HK6Iw2o+jDh3EdvKWB47bCW
         8l3mPZl4jPzODKTjjsXB8B06QZ+n4FUVle0MQJD8+mEceFs7MOauwTc/GyJaSH+QUmhH
         JljDwnPBMLDxXgM0hgV8vfUMCdIQqXA/iH3sAva7y3eg48jBV+41CN+GcfINeuDNLYqH
         IYPHKJCvZDdNE3Aay5fdpXnNmNHnLWcA/PVqlPJSE/lR5dheKJLqem+UkCJ3n9wOweNy
         k8Fg==
X-Gm-Message-State: AGRZ1gIJ9hsldfud8+un6ma7vB0pzHn9ZvRjQdr1t5HjqcvV/pph8v5Q
        672U4z6fLUvDzpeUkYi4zdc=
X-Google-Smtp-Source: AJdET5dd6tRcaoBgvB+MIrN5ZAsXA1Xftx7etL38OdwYRxgKdoaxm1yO0FdYpC7yT4qo5zm1VjW6pw==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15-v6mr4957963wmb.1.1541395087498;
        Sun, 04 Nov 2018 21:18:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t187-v6sm767108wmt.45.2018.11.04.21.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 21:18:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 5/5] pretty: add support for separator option in %(trailers)
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181104152232.20671-1-anders@0x63.nu>
        <20181104152232.20671-6-anders@0x63.nu>
Date:   Mon, 05 Nov 2018 14:18:04 +0900
In-Reply-To: <20181104152232.20671-6-anders@0x63.nu> (Anders Waldenborg's
        message of "Sun, 4 Nov 2018 16:22:32 +0100")
Message-ID: <xmqqr2g0hzlf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> +				if (opts->separator && first_printed)
> +					strbuf_addbuf(out, opts->separator);
>  				if (opts->no_key)
> -					strbuf_addf(out, "%s\n", val.buf);
> +					strbuf_addf(out, "%s", val.buf);

Avoid addf with "%s" alone as a formatter; instead say

	strbuf_addstr(out, val.buf);

cf. contrib/coccinelle/strbuf.cocci
