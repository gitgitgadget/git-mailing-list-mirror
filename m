Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C281F404
	for <e@80x24.org>; Thu,  4 Jan 2018 18:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeADSaG (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 13:30:06 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45881 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeADSaF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 13:30:05 -0500
Received: by mail-wr0-f196.google.com with SMTP id o15so2319803wrf.12
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YnxBA01Qix7LPjkI4hu6qPiMOi8Dl4T8KOMZAg0lhDY=;
        b=Q06AUQQINOCynQ1En/hA1PrqHIH7NMEiNUeW2HkbM9zjgIU66LUsXfq4j3NQfZ4mqz
         SyokY3f7S7OF3TbP68YULUIu9biu83QpFAW6tDXEnC5b+XGMCLPfDOVpbzk6rdLszVr1
         szDx6aUUwleMFvuVfXIFtXy5UE7UG7A8lD7DVE/c+EmTU0IH8FQa7r845dkK6rg9mq0f
         AH3to7x6ePnUe3RuA1Z/ILmQCWijRhLsRlU/2qGi4OpxKsmh/sYrPRYBCknDuZ2uhe0g
         X4e16Qi61Sf0/voFCvQo7pezK64XFOnS722TmNu93q0o/d2vGAN6PNVJH+KdkepIbsII
         +ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YnxBA01Qix7LPjkI4hu6qPiMOi8Dl4T8KOMZAg0lhDY=;
        b=dqgEBgDUdout7gKvcBl1XKYnW+o+6gRIV6RV3URFkrPk3MAvsJZLzHAgY6bROGwJGH
         EM9omQ0Hnqcy7MPF+0aTB4MCAn+1C5YR+Zv5gmKxEJeb0zlKf0R8tOGtOknrGovlGgUM
         aiFtysqAiSUjo8dHpbMyGeCOp1uBoqPtoBDelg42JTLaBdiBg4YIKacwXEPvRd7pQsZp
         8Ody4SI/ypjRHteGZCsdfNdjLxAuxwjn47tB4R77ScTQooEYW+YuDGYZy8C2B3V+Ciii
         P+3b+XX8j4f4hvLpi6pGaJCZoCXM3v6H7CEjgDAmykjRmO608WBQf05G1s5q3hpx8TeM
         AzXg==
X-Gm-Message-State: AKGB3mLvBliD/sEgvp+PF0jV1mX1/6+OSSx8s2Mc4m6TOEw5AlOe1qJq
        +aDK1AQMO49ez0WxqJo7s/w=
X-Google-Smtp-Source: ACJfBouHiVu9hy7RJnNzMxm6zvaEuBCyXZ4oQCe7vNAwi1WsLJLQkma7MfR+C5RyL6b6GQRM/ZXBJA==
X-Received: by 10.223.161.92 with SMTP id r28mr429007wrr.236.1515090604061;
        Thu, 04 Jan 2018 10:30:04 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c82sm3332521wme.4.2018.01.04.10.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 10:30:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com
Subject: Re: [PATCH v2 2/2] Windows: stop supplying BLK_SHA1=YesPlease by default
References: <20171228140742.26735-1-avarab@gmail.com> <20171228140742.26735-3-avarab@gmail.com> <alpine.DEB.2.21.1.1801041828540.31@MININT-6BKU6QN.europe.corp.microsoft.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <alpine.DEB.2.21.1.1801041828540.31@MININT-6BKU6QN.europe.corp.microsoft.com>
Date:   Thu, 04 Jan 2018 19:30:01 +0100
Message-ID: <871sj5cw9i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 04 2018, Johannes Schindelin jotted:

> Hi,
>
> On Thu, 28 Dec 2017, Ævar Arnfjörð Bjarmason wrote:
>
>> Using BLK_SHA1 in lieu of the OpenSSL routines was done in
>> 9bccfcdbff ("Windows: use BLK_SHA1 again", 2009-10-22), since DC_SHA1
>> is now the default for git in general it makes sense for Windows to
>> use that too, this looks like something that was missed back in
>> e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17).
>>
>> As noted in 2cfc70f0de ("mingw: use OpenSSL's SHA-1 routines",
>> 2017-02-09) OpenSSL has a performance benefit compared to BLK_SHA1 on
>> MinGW, so perhaps that and the Windows default should be changed
>> around again. That's a topic for another series, it seems clear that
>> this specific flag is nobody's explicit intention.
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  config.mak.uname | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/config.mak.uname b/config.mak.uname
>> index 685a80d138..6a862abd35 100644
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
>
> This patch is actually identical to 8756c75cd10 (msvc: use OpenSSL's SHA-1
> routines, 2016-10-12) in Git for Windows' master.
>
> I did plan to submit this, but it is part of a bigger effort to get Git to
> build in current versions of Visual Studio again.
>
> Before this work, the MSVC build could only use an ancient OpenSSL version
> from pre-built binaries hosted on repo.or.cz, and those are unlikely to
> get the performance benefits that you seek.
>
> So I would like to ask to skip this patch for now, and take Jeff
> Hostetler's patch as part of the MSVC patches later, once they have been
> matured in Git for Windows?

Sounds good to me. Junio, could you please drop this one and just take
1/2?
