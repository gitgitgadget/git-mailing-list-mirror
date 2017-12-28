Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0306E1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbdL1Nrq (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 08:47:46 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:40428 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbdL1Nrp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 08:47:45 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so43800056wmf.5
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 05:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0bQjow0uU9mhu5pQAUHypcWLljt+SXfi7sufrXyZJRI=;
        b=JeHSh6JICjST7pXxnISuWYddOI8PpKNYSTH72vPLH4rpqZauVPVnRfMP27Ha2gshwH
         9wpF0d9U8NKtw1ALNJrGQZ048VrlywOOxSvpGn4o00qz8Fp3ahOFTXorsnK1gMg43Doo
         BR85fE/GJo9zZ37/ALpJPASWJr1Rj/SH1NcSzTkjXupLfPZCQfCHNnBNDDxErdi41ZXM
         gptZm+XSjnTSL5QLOn+lnUylQsjvOxLZjE4U12Mgoe73RwrPpcf//whxUljXcnaonRXu
         AlvFgBWiOUFb6nbqUR6BskUgO2wFY7h+9s9HX+XTmqQUyHX7ujlNOvy5qiF+l2+rxyQS
         8J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0bQjow0uU9mhu5pQAUHypcWLljt+SXfi7sufrXyZJRI=;
        b=SsNDJMRBu9D9eic7By8wD+mhIB6M6eL8HIh9vuVpYpsepRH7B8WG0DRdo05yLY1F3h
         HlmTRbQ+YLCKrsE7qgQASRBp7Hs30uRErtRwiaA45TL0sVHHhW3BgjMbPsqHKuu7mEy+
         GnnQ4ZRx/OT/Lmxq02VKBl6FCeONBPjDAiKG1vkRIBX4LRFNPYSgV85VGE4BEGl6ApF2
         42jQYIpI6af/RKcWHtVOQYSoczv6Maqa3XU3UYqTY2ve17Zn2CneEjzXURmxFoVb3Pza
         93n/zj6ONcBvdX7FPUTd0D/n9TY3nV/KfeZy7EJC7vHlQHc9ide7vvHu4LeQOOdF2oeD
         Uzlw==
X-Gm-Message-State: AKGB3mKgl9K09Zy56vsdhcl6NNeIPP/1McA7kDqDtJHpp3ofJPVuzXl9
        izHY3Y20gt4c3L2d9k7O6WY=
X-Google-Smtp-Source: ACJfBosIbpRw0ielGo6SSGXX02ISShLzzKD5z3y2PEwybuxEgA9OD5WEJN0YSBClsIaoBCug719NcA==
X-Received: by 10.80.172.77 with SMTP id w13mr40818378edc.305.1514468864537;
        Thu, 28 Dec 2017 05:47:44 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id q55sm30197070eda.43.2017.12.28.05.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 05:47:43 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Windows: stop supplying BLK_SHA1=YesPlease by default
References: <20171227230038.14386-1-avarab@gmail.com> <20171227230038.14386-3-avarab@gmail.com> <20171227234237.GC181628@aiede.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171227234237.GC181628@aiede.mtv.corp.google.com>
Date:   Thu, 28 Dec 2017 14:47:43 +0100
Message-ID: <87k1x7q800.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 27 2017, Jonathan Nieder jotted:

> +git-for-windows
> Ævar Arnfjörð Bjarmason wrote:
>
>> Using BLK_SHA1 in lieu of the OpenSSL routines was done in [1], but
>> since DC_SHA1 is now the default for git in general it makes sense for
>> Windows to use that too, this looks like something that was missed
>> back in [2].
>>
>> As noted in [3] OpenSSL has a performance benefit compared to BLK_SHA1
>> on MinGW, so perhaps that and the Windows default should be changed
>> around again, but that's a topic for another series, it seems clear
>> that this specific flag is nobody's explicit intention.
>
> I have some memory of performance issues on Windows when DC_SHA1 was
> introduced leading to interest in a mixed configuration with DC_SHA1
> only being used where it is security sensitive (e.g. for object naming
> but not for packfile trailers).
>
> Did anything come of that?

This was Johannes Schindelin (CC'd) on-list when the sha1dc discussion
first came up earlier this year. I.e. it's slower, so we could use
openssl on trusted data and sha1dc on untrusted data, but nothing came
of that.

> In any event removing this BLK_SHA1 setting looks like a good change
> to me, but I'd rather that Windows folks weigh in.

Yup, will CC them + Johannes for v2.

> Thanks,
> Jonathan
>
> [...]
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -361,7 +361,6 @@ ifeq ($(uname_S),Windows)
>>  	NO_REGEX = YesPlease
>>  	NO_GETTEXT = YesPlease
>>  	NO_PYTHON = YesPlease
>> -	BLK_SHA1 = YesPlease
>>  	ETAGS_TARGET = ETAGS
>>  	NO_INET_PTON = YesPlease
>>  	NO_INET_NTOP = YesPlease
