Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43F11FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeAHWrZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:47:25 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40133 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeAHWrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:47:24 -0500
Received: by mail-wm0-f48.google.com with SMTP id f206so17093919wmf.5
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x19AVJg3pt42r2jTQCyd6/nkdEkJo0hCZLZKbKy1lh8=;
        b=Is3/Hg/zADjT7lvuslJDNFCCNYmLGj6vfjph0HVNmQSk5CAkIreLe9lv+8YivfbBfZ
         PkUQ6Yl3Cj+bC1cJFY0nOWQX5cEapV2CtqxiRZ1lIVxYYdgCfE7RiJ2/B8jydGniURkl
         tR8cdS8FCaep0OCFJy4qALGVdxl3N6+FCOVHkxaTegJeKt7e0+AwfY+L96zanO1Uh4wE
         q7KUzwJW5Rv8YmrBs3w5tJCoeJed7KlHRUQV14zXCBcm1Fy3o0MmpOmpRoyby+e1tUBK
         0Aa7KtipjNQX+jzvbXGk6+QaNpLr+saKQY0tcYJA3gzhWp13WeMhTcUvHdoZSjMqXpSU
         XIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x19AVJg3pt42r2jTQCyd6/nkdEkJo0hCZLZKbKy1lh8=;
        b=aqo8QPbneBzZDok+X6Rd78Wc/fSQbh4ZdWpSufhCmLRvlgH61tAtC4d+JesjB4XYN9
         yUuGIs99IwUFG0ErN3tK4uWY/veIMAkCnNMw+w1QyNX2j0FOoeVAF/2RaM2Ob4WHiRzD
         AFM9c13N2dutf3RH0tp9doh5fQaCOtYJFR+4cd6fTfPiD6cayrsFILMK61XO2an6hqmG
         fd37UwhxABoaFV+XCKwgKZTu1dWCUgxTxQ2gFcsp3u57uD0iFYVV8mUidvZ0vNUp3bZS
         zTmrux0/yoDsuZpbKJIIB3qoGau+IfyAWjjdyQwS+m5Tw2infCA7o7vU+3XuOMLAiLqs
         uGtA==
X-Gm-Message-State: AKGB3mLtEpgFFCq9VLiYMwDcu1/cWpfSL9nWdax9lCiU6/8/zlxmMsEI
        NsEWgow3ifTOGn7Fj8Ajfjo=
X-Google-Smtp-Source: ACJfBovRxRD50cY8lUotaKxGKfFfK7gcUsDwqBEBmpxHy7B9O55p9N0veiwPHkTAgLCqM88RD/DKPw==
X-Received: by 10.28.63.15 with SMTP id m15mr9917621wma.1.1515451643329;
        Mon, 08 Jan 2018 14:47:23 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB58C2.dip0.t-ipconnect.de. [93.219.88.194])
        by smtp.gmail.com with ESMTPSA id c19sm8386923wre.72.2018.01.08.14.47.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 14:47:22 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 5/7] convert_to_git(): safe_crlf/checksafe becomes int conv_flags
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4lnw82hi.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 8 Jan 2018 23:47:20 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFFF054A-6049-49A6-9B31-3E2D6585B21A@gmail.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com> <20180106004808.77513-6-lars.schneider@autodesk.com> <xmqq4lnw82hi.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Jan 2018, at 22:28, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> lars.schneider@autodesk.com writes:
>=20
>> diff --git a/sha1_file.c b/sha1_file.c
>> index afe4b90f6e..dcb02e9ffd 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -75,14 +75,14 @@ static struct cached_object =
*find_cached_object(const unsigned char *sha1)
>> }
>>=20
>>=20
>> -static enum safe_crlf get_safe_crlf(unsigned flags)
>> +static int get_conv_flags(unsigned flags)
>> {
>> 	if (flags & HASH_RENORMALIZE)
>> -		return SAFE_CRLF_RENORMALIZE;
>> +		return CONV_EOL_RENORMALIZE;
>> 	else if (flags & HASH_WRITE_OBJECT)
>> -		return safe_crlf;
>> +		return global_conv_flags_eol | CONV_WRITE_OBJECT;
>=20
> This macro has not yet introduced at this point (it appears in 6/7
> if I am not mistaken).

Nice catch. I'll fix that in the next iteration.

Is it OK if I send the next iteration soon or would you prefer
it if I wait until after 2.16 release?

Plus, is it ok to keep the base of the series or would you prefer
it if I rebase it to the latest master (because of a minor conflict)?

Thanks,
Lars=
