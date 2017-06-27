Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7492120401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbdF0SXq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:23:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33983 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0SXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:23:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so5757048pfe.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5+riTaF+UeP13L11SvR86psTAdoffbuuSDZZqF4QW0Y=;
        b=KFBn6wlKOoCshnB8FrNh8vlInKdqYSGzOVcMd2mgYf0e7HXy27Y+yfg6/UrK1TuTrP
         Z0fIe4Y1Zsk8yS5jmYQjVAItLHCpJ1MsWxdo21D0LrZ/MlEyAazfE/gaC5zXHqgwXgbP
         Ax0Zt9Mv1RFo/mfniMOKmciiBFbhrp4zQgfaeN9MkANYIx3F4PGm7K74FTnrzRYKsXq0
         h6Yd91wSfA7VhCZKgLtENxxT4SfuE8K0ixJDXQQ5Qdq4+JYGLOMOTWhf8FqyLtieBd0f
         mbxaogOHP/Cp3MblLOfyutC0rZ8ve4rx7VRZlKOGhUCXMTzOn2YYghgccsaKK7P9PmbZ
         hrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5+riTaF+UeP13L11SvR86psTAdoffbuuSDZZqF4QW0Y=;
        b=n6/03C7dlGIvhdBIj6KjeAjcCYCT8p45yOcJigvCLD2nHG92XBj+mlJXd4v46tZNV0
         EfS8+OYbY7xNuAu0ker+gIx956qX9tHy5ztxcGDXa7fUCC4JoRsQ88Y7EtHAASyuThHJ
         JHPb63tJrVpHu0jmFP0vKZV6mVTncTfiM6H4fT7F2F11X7zUqQJdIHBmTXHr8kTr9Xac
         ZbfJgo+zb7ioXJK22M2m0RrnsnDorEcmObp1bD0Z0XoySmSAPu7ZMfRgYUHwQna4Mbtw
         WFNLThoe9Z+mbhJ87jYHnq+Syuy3iHAJfBSQ991jS6NdfI2tdP/We/XvfndQBfKiNlal
         CUoA==
X-Gm-Message-State: AKS2vOwqJA3lrjGPtUMiwwOYxcsV2PG5ZkfuR4uqg19naCMWZ05jgUOg
        vCed8mDnjBIXjg==
X-Received: by 10.98.13.219 with SMTP id 88mr6649164pfn.191.1498587824017;
        Tue, 27 Jun 2017 11:23:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id f24sm8454285pff.74.2017.06.27.11.23.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 11:23:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
        <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
        <87zictjoff.fsf@gmail.com>
Date:   Tue, 27 Jun 2017 11:23:42 -0700
In-Reply-To: <87zictjoff.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Tue, 27 Jun 2017 20:06:12 +0200")
Message-ID: <xmqqk23x1e8h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> +#if defined(__BYTE_ORDER) && defined(__BIG_ENDIAN)
>>> +/*
>>> + * Should detect Big Endian under glibc.git since 14245eb70e ("entered
>>> + * into RCS", 1992-11-25). Defined in <endian.h> which will have been
>>> + * brought in by standard headers. See glibc.git and
>>> + * https://sourceforge.net/p/predef/wiki/Endianness/
>>> + */
>>> +#if __BYTE_ORDER == __BIG_ENDIAN
>>>  #define SHA1DC_BIGENDIAN
>>>  #endif
>>
>> Note that this part of the file considers it a valid way for a
>> platform to define a constant BIG_ENDIAN that can be compared to
>> BYTE_ORDER to determine the endianness, implying that such a scheme
>> would also define LITTLE_ENDIAN and a port of such a platform to a
>> little endian box will still _define_ the constant BIG_ENDIAN; it
>> aill have BYTE_ORDER defined to the same value as LITTLE_ENDIAN,
>> though.
>
> This may fail if we have some non-glibc platform that's defining
> __BYTE_ORDER and __BIG_ENDIAN, but if it's glibc then __BIG_ENDIAN will
> always be defined, even on little-endian platforms.

Yes, that is exactly the point of my comment.  We want to be
prepared to see a platform that is not big endian to define
BIG_ENDIAN (with some underscore).

>>> +#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
>>> +
>>> +#ifdef _BIG_ENDIAN
>>> +/*
>>> + * Solaris / illumos defines either _LITTLE_ENDIAN or _BIG_ENDIAN in
>>> + * <sys/isa_defs.h>.
>>> + */
>>> +#define SHA1DC_BIGENDIAN
>>
>> This makes readers of this patch wonder why we assume platforms
>> won't define _LITTLE_ENDIAN and _BIG_ENDIAN at the same time, just
>> like we saw in the section with __BIG_ENDIAN above.
>
> At least on Solaris if we get this far that won't be the case.

Yes, but the remainder of world is not all Solaris.

