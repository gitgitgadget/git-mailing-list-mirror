Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3591F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbeA3U66 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:58:58 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:43035 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbeA3U65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:58:57 -0500
Received: by mail-wr0-f173.google.com with SMTP id 39so4010854wrb.10
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fBuqSICVN1Tamh34xEV8NXwEVzdaUMng+59WK/5doa8=;
        b=D5o4gBoi1i6VpcS1uHQigdxWuk1XnS/uQL2HB7/iFlhS+N82g3Q2mHD3BbtgsBSjSt
         ACpwLB5g1emENFFzCSZEvSBwh0JfXw3ezM1mAFJgB5tmTszrUsLVNgxuX9Dgdikl4/Nz
         Sfs/b/rgMLI+wIefWCX1QzTGmke84DGAXnnmbpUxm9K/q6SCJC5eqC0gdb4Ju9CgP8B0
         W6tYGOkZZoFA+5KwEwr44I7IlT4qO/nJhMKgbfPRCqWDdQG7CdYDuxrTY9IqPPf217Yk
         jwd4GdLzSMb+VOvEAw4ZA+SUYo0icCWUTVITux4DRpxl3d/NP9y4Qke3PmL+LzrHc1If
         8m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fBuqSICVN1Tamh34xEV8NXwEVzdaUMng+59WK/5doa8=;
        b=qrApwJQwOLH2M14KJFVBfsha44/CSMF2pbGhQ0HKl2uiYCMD+Po/ohQslj1gbHm4DT
         q5pF8J/N2BQa05zPyGwK7qysRysCSKkxscqL6oF2KYl9+Il+D8+ip506olqwzMYRxjnJ
         vKHyYh2baZJTSiuATPwoWwhTJY29peQdHFyLK7eUslOngts35A6sCZEV0Ya4Fc2m4OCg
         ddW6Z7l+dpD4YEQ6RT3XknCpIYEE7/LQrweAR24TvUgG5dU6EfgVMApws0Iry5eYlgl/
         7zRqkj1iBzknEowjPiMbiiL9UyukUvL6U8Yzl6xPYtx9dvMo5/VjOhPKKPWRErK2AnHU
         VxDg==
X-Gm-Message-State: AKwxyteQXKCE69ics4dGApyrP1Xog4bQ3u9b6z5MGI8HL9K01AYrFgNw
        kgEuYOGGPxHp0ShynrFOhZ0=
X-Google-Smtp-Source: AH8x225IYpY+6Mrqv5sm76bNUt0GviBujPMuMUslLCCGmbOO9hFpKZRQjnXIXFvvjUmifh6Y4RVkGw==
X-Received: by 10.223.182.153 with SMTP id j25mr25379286wre.43.1517345936527;
        Tue, 30 Jan 2018 12:58:56 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5B37.dip0.t-ipconnect.de. [93.219.91.55])
        by smtp.gmail.com with ESMTPSA id 81sm13394118wmi.26.2018.01.30.12.58.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 12:58:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 4/7] utf8: add function to detect a missing UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4ln3upiv.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 30 Jan 2018 21:58:55 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <BEE9E5DB-AB1A-4119-90E6-700186739C59@gmail.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com> <20180129201905.9355-1-tboegi@web.de> <xmqq4ln3upiv.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Jan 2018, at 20:15, Junio C Hamano <gitster@pobox.com> wrote:
> 
> tboegi@web.de writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> If the endianness is not defined in the encoding name, then let's
>> be strict and require a BOM to avoid any encoding confusion. The
>> has_missing_utf_bom() function returns true if a required BOM is
>> missing.
>> 
>> The Unicode standard instructs to assume big-endian if there in no BOM
>> for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
>> in HTML5 recommends to assume little-endian to "deal with deployed
>> content" [3]. Strictly requiring a BOM seems to be the safest option
>> for content in Git.
> 
> I do not have strong opinion on encoding such policy-ish behaviour
> as our default, but am I alone to find that "has missing X" is a
> confusing name for a helper function?  "is missing X" (or "lacks
> X") is a bit more understandable, I guess.

That might be a german/english translation thingy but I think I get
your point. "has" implies there is something and "missing" implies
there is nothing :)

"is_missing_utf_bom()" might be even a bit unspecific as UTF-8
is usually missing a UTF BOM but the function would still return 
"false". Therefore, "is_missing_required_utf_bom()" might be 
lengthy but should fit.

OK for you?

- Lars


> 
>> +int has_missing_utf_bom(const char *enc, const char *data, size_t len)
>> +{
>> +	return (
>> +	   !strcmp(enc, "UTF-16") &&
>> +	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
>> +	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
>> +	) || (
>> +	   !strcmp(enc, "UTF-32") &&
>> +	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
>> +	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
>> +	);
>> +}

