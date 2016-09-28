Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A583C1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 23:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbcI1XQG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 19:16:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36502 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbcI1XQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 19:16:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so8107717wma.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gZjXrm2lnakosuzUckPOZeka43KwVmlRsNyDy/I9JSM=;
        b=EiIlXlQXsOHRO5JymsGGOR0Xtt2T6b9YwlNsvYE79QtxYiOlcaRZ6ZaIHrmRfuhdug
         Hox2iQ15gaB8zGLqBrS0rUT63WU94FrxclgUCJLwyIuBCZ+GRDmpr362aD6oVTjIa8lH
         3bM/9gMvMl5HNiGQ8owRun4kI3hZxkvhlYhkdFybgZfmlSnvYTwlRcaUEJcYWqqjFxgY
         IalGgsgarHq8K/UaGD0PQOiHBzergcHcaHqrgsS4Nn/dQl3MSDhmk93Zm5tR69+PNhmr
         yug4dejXi+hzYgwU4z2A/8zXkTTi8p8UfZzlew+ZM/iKwWHOHazCidB4ODkKuSe8CZj+
         bu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gZjXrm2lnakosuzUckPOZeka43KwVmlRsNyDy/I9JSM=;
        b=gV+GmfWZ1AD5liNM3AnAjijoklSoWIpNdeQH7EXeiRYQ/nSjaap7713LOiccc/Bm5v
         2F/KkEfVDX6QATKhFvwXUZLC+TC3kGp61xfG2peHczOds2OcNUhRQHLtMw8nMoy7z977
         If7qkeI7EZnYvwmNWlT3bVRf8CKoi/T10+bgUDytt6Tw2FOt+XHdky1/v0Sl8pLnXmne
         51rOgJBdXJypeV7g4PSRZFZd8BVvlnw96bO/cUH2fLdILQ867ZOd7jXegRsb+Folsyb5
         QXwp4K6Lejr+SfukjfrwCMZ2rhSJxFB8kvQ/T/DaAS/CXCQtXlXmkdpt2n+F0PEJOYgE
         mBfA==
X-Gm-Message-State: AA6/9RnfA1p721HouhBHOs5g5TKoo3y/GUJZA0GR0a7Hb0IBAHjCS3d539Cld43dwIue2A==
X-Received: by 10.28.181.145 with SMTP id e139mr9963688wmf.114.1475104562889;
        Wed, 28 Sep 2016 16:16:02 -0700 (PDT)
Received: from [192.168.1.26] (ddj41.neoplus.adsl.tpnet.pl. [83.23.87.41])
        by smtp.googlemail.com with ESMTPSA id au10sm10665008wjc.12.2016.09.28.16.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 16:16:02 -0700 (PDT)
Subject: Re: [PATCH v8 01/11] pkt-line: rename packet_write() to
 packet_write_fmt()
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-2-larsxschneider@gmail.com>
 <592e18b7-ac2e-ed23-0321-57eb418d5172@gmail.com>
 <13E00B0F-41FC-4FBE-9ABD-2E9B11743E2B@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <62b5fd5d-51b7-36ef-fcc2-db1d53220abe@gmail.com>
Date:   Thu, 29 Sep 2016 01:15:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <13E00B0F-41FC-4FBE-9ABD-2E9B11743E2B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.09.2016 o 20:49, Lars Schneider pisze: 
> On 24 Sep 2016, at 23:14, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>>
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> packet_write() should be called packet_write_fmt() as the string
>>> parameter can be formatted.
>>
>> I would say:
>>
>>  packet_write() should be called packet_write_fmt() because it
>>  is printf-like function where first parameter is format string.
>>
>> Or something like that.  But such minor change might be not worth
>> yet another reroll of this patch series.
>>
>> Perhaps it would be a good idea to explain the reasoning behind
>> this change:
>>
>>  This is important distinction to know from the name if the
>>  function accepts arbitrary binary data and/or arbitrary
>>  strings to be written - packet_write[_fmt()] do not.
> 
> packet_write() should be called packet_write_fmt() because it is a
> printf-like function that takes a format string as first parameter.
> 
> packet_write_fmt() should be used for text strings only. Arbitrary
> binary data should use a new packet_write() function that is introduced
> in a subsequent patch.
> 
> Better?

Better.

> 
>>> pkt-line.h               |  2 +-
>>> shallow.c                |  2 +-
>>> upload-pack.c            | 30 +++++++++++++++---------------
>>> 11 files changed, 29 insertions(+), 29 deletions(-)
>>
>> Diffstat looks correct.  Was the patch generated by doing search
>> and replace?
> 
> Yes.

Good.

-- 
Jakub Narębski

