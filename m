Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974471F453
	for <e@80x24.org>; Mon,  4 Feb 2019 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfBDS5I (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:57:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38568 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDS5I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:57:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so1026744wrw.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tw3/lE2CVM8h28faOpQmHVAOJA8G2H2JXqs7vFXuOMc=;
        b=uToVF68RIPXSE9tNEH4NoYbZSZfRJFErLgqhZtFue39d7TrYgUAmuXW337wP3jwIuH
         sQyJa1TsuXKDu2f/nlNsTCoJYXineeiaYiosI9LAv9jOG8oBRz4uPqOsK3wE4cE1H+jX
         F+gqqXcgcCmTO/oZqL8rv36oduNQUhVkHQKtTYOE+t/Tc+h0n0H+hQARimmwOkuLELlx
         DvClm8CiunE3TiLmGV7XnB3klHF1g7OvqYJSqzmz5GnPgTGbQ41I9DQ9RgqTI2Zr5eEM
         QSSP/Vc9tT+1fd3RbqXRtlns5y1WAR5n9vIp17WO6CTivzp5bo6JAXSRt0q9fLgrrVm+
         r6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tw3/lE2CVM8h28faOpQmHVAOJA8G2H2JXqs7vFXuOMc=;
        b=LCWCh/UdA9+B8JMt4kQlR3mWprutrO/iQ2DjfjFKX3WTaZ4dW1REJUxcAor93FEf4T
         cF3cp9fvCRbFVu7hiOss9TQ0x+VlfOnGlgMc68GFUjjZfffsc+5ErtJjFg1k1Ugi2I/P
         q4AAuYoS5n7exRz2AKuGA4PsTPrfPX5cMdVYDJCW1T6AshmI3fwhuhVzbgKkLKydOzal
         XGOeJyMw1xtRMP3gyI7exv9TcaqEQfGynS1PXhKZatGDOQJJqqeDAPdlsZs2q0kXC5Vk
         lmr7xolryOrZwaYImprUNPB1Mdv4uW47xgBRfTMhHsjkLIAsLMcbje09Sk2PoM5nhLAZ
         ZdmQ==
X-Gm-Message-State: AHQUAubr4Uq+Snhv8VOZGFBcCkox7gyffrTXhDVqTxEH+Y8LFoj4TG2D
        z+gTkXybFxlbUTJVkYQqZfo=
X-Google-Smtp-Source: AHgI3IYGVU02sM9Rn14UO3jQADiZhIz2TtBdAg3ReqV+5Ymu6FtchgfsXl2OMXX4VKq9jEhuYIvG0Q==
X-Received: by 2002:a05:6000:114d:: with SMTP id d13mr626927wrx.83.1549306625911;
        Mon, 04 Feb 2019 10:57:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f199sm14434769wmd.25.2019.02.04.10.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:57:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     William Hubbs <williamh@gentoo.org>, git@vger.kernel.org,
        chutzpah@gentoo.org
Subject: Re: [PATCH v3 1/1] config: allow giving separate author and committer idents
References: <20190129230806.5295-1-williamh@gentoo.org>
        <20190129230806.5295-2-williamh@gentoo.org>
        <xmqqfttb599s.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902041314160.41@tvgsbejvaqbjf.bet>
Date:   Mon, 04 Feb 2019 10:57:04 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902041314160.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 4 Feb 2019 13:17:35 +0100 (STD)")
Message-ID: <xmqqbm3rv0u7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I do not recall we crossed the bridge to allow trailing comma here
>> at the end of enum definition.
>
> In advice.c:
>
> 	enum color_advice {
> 		ADVICE_COLOR_RESET = 0,
> 		ADVICE_COLOR_HINT = 1,
> 	};
>
> In builtin/pack-objects.c:
>
> 	enum missing_action {
> 		MA_ERROR = 0,      /* fail if any missing objects are encountered */
> 		MA_ALLOW_ANY,      /* silently allow ALL missing objects */
> 		MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
> 	};
>
> In builtin/rev-list.c:
>
> 	enum missing_action {
> 		MA_ERROR = 0,    /* fail if any missing objects are encountered */
> 		MA_ALLOW_ANY,    /* silently allow ALL missing objects */
> 		MA_PRINT,        /* print ALL missing objects in special section */
> 		MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
> 	};
>
> ... and I will stop here. You are correct that the majority of our enums
> does not let its last item end in a comma. But we did cross that bridge.

Good.  Thanks for eyeballing.

I do not think any of these can be compiled out on a platform with a
picker compiler, and the one in rev-list.c is from late 2017, so it
probably be a safe assumption that nobody would mind the trailing
comma.

