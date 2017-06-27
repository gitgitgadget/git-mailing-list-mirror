Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DAA20401
	for <e@80x24.org>; Tue, 27 Jun 2017 19:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbdF0TfO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 15:35:14 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36268 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbdF0TfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:35:12 -0400
Received: by mail-wm0-f47.google.com with SMTP id 62so33924642wmw.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qmEw0DXOb9nzdZzCybujd6TGkdVx5dodP1onpQPi2eQ=;
        b=pACPad6LxLAEWZ0DArHu88uQfttm+rtYUR+E8eT74ydwWh0E3Z3KlzsVMCDnnBLIhb
         mzHhh3fEdgL1OWxIyvbZ/RSg6Trj11SizeWKEFC2186qBHfpfFbyvZsmHvz/z8hdcDyF
         sqQFQegUSFfXbZK7urohR1xCoxGRNkKblr/AVpVxP3W5TlnO2WD94OKGRjSpp70IoL85
         e6XGA5ZzDoGYLCe21f0g/Ma7bKIMJsYrXMOnez7/Fy4skT6EUu0N9p0SmfJfiqEal30b
         pzlRW529LBCl+N2UlPH0uiTPqgxq1VpSxzYyBm6GNcbmTqNEwgarcnoiyTPcPYKxLq+j
         o9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qmEw0DXOb9nzdZzCybujd6TGkdVx5dodP1onpQPi2eQ=;
        b=LdkhBMLYDQEacJXwEgWOjhZ0TqU4O5mc3sJSgNxTJ3Isg5GZ/vZkA7mpGfZLJh2kxN
         M2v98tyv2dl1msRMx3PX8J98LIUj2Nee2US7WqqPtuSOsqX35T051w93QvrJxXMWRxcl
         0jzPiX3SntG7NJ+ycGmBvxOPfxh/b5NKvxSXX0BWKW+ioSrEnvm6v2ldsPCMllpsWzVo
         coUUPA2ka6PP8rddOhg1Zd1ET51b7f9SUvlZM/705qqklrxuM74eEXidHin/dfxE+apk
         JTlA21SqYBae/leQBek0TSV55ccxeHCBFnI33J63SJyXpFR9vr8ogjO2nPTQxb0tPvis
         xghA==
X-Gm-Message-State: AKS2vOzoq3QZlCHD1fUbFzOsIoAbkAkOBVkU9zrkcgzL3qCka/aHqrNN
        BLQnaQ+SoFY27cpDDWk=
X-Received: by 10.80.135.208 with SMTP id 16mr5088489edz.121.1498592111148;
        Tue, 27 Jun 2017 12:35:11 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id e22sm67924edd.26.2017.06.27.12.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 12:35:10 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPwGT-00072h-Ez; Tue, 27 Jun 2017 21:35:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <20170627121718.12078-2-avarab@gmail.com> <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com> <xmqqefu52znl.fsf@gitster.mtv.corp.google.com> <87wp7xjo5x.fsf@gmail.com> <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 21:35:09 +0200
Message-ID: <87r2y5jkb6.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> Because in the current code is, abbreviated:
>>
>>     #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
>>     #if /* byte order is bendian */
>>     #define SHA1DC_BIGENDIAN
>>     #endif
>>     #else
>>     #if /*some processor tests/* || defined(__sparc))
>>     #define SHA1DC_BIGENDIAN
>>     #endif
>>
>> And since Solaris defines _BYTE_ORDER we never get to checking __sparc,
>> and in fact the "/* byte order is bendian */" test errors out.
>>
>> This is fixed by my patch, where we first check gcc settings, then
>> glibc, then processors, and finally _BYTE_ORDER (but as discussed that
>> last bit could be adjusted to sun && _BYTE_ORDER, if we can find what
>> "sun" is.
>
> Well, if Solaris defines _BYTE_ORDER, doesn't that mean they define
> two constants _BIG_ENDIAN and _LITTLE_ENDIAN to compare it with?

No, under gcc/clang & glibc you're expected to compare them. Under
Solaris it's just defined(_BIG_ENDIAN), but as explained in another
comment this whole thing actually turns out to be not needed, on Solaris
it's sufficient that we fall through and check __sparc.

> that is the case, I suspect that the change to make "comparison
> between __BYTE_ORDER and __BIG_ENDIAN for GCC only" is going in a
> wrong direction, as it wants to take the same approach as GCC, but
> just uses a slightly different symbol.
>
> I wonder if the approach like the following might be cleaner to
> extend as we find other oddball platforms.
>
>     #undef __SHA1DC_BYTE_ORDER
>     #if defined(_BYTE_ORDER)
>     #define __SHA1DC_BYTE_ORDER _BYTE_ORDER
>     #elif defined(__BYTE_ORDER)
>     #define __SHA1DC_BYTE_ORDER __BYTE_ORDER
>     #elif defined(__BYTE_ORDER__))
>     #define __SHA1DC_BYTE_ORDER __BYTE_ORDER__
>     #endif
>
>     #ifdef __SHA1DC_BYTE_ORDER
>      #undef __SHA1DC_BIG_ENDIAN
>      /* do the same for variations of BIG_ENDIAN constant */
>      #if defined(_BIG_ENDIAN)
> 	...
>      #endif
>
>      #if __SHA1DC_BYTE_ORDER == __SHA1DC_BIG_ENDIAN
>      #define SHA1DC_BIGENDIAN
>      #endif

As explained above no, because some e.g. _BIG_ENDIAN don't have a value
at all.

But more generally we can't assume that we can just exhaustively search
for some ^_*BIG_ENDIAN_*$ macro and compare it with some
^_*BYTE_ORDER_*$ value and get an expected result.

>     #else
>      /*
>       * as the platform does not use "compare BYTE-ORDER with
>       * BIG_ENDIAN macro" strategy, defined-ness of BIG_ENDIAN
>       * may be usable as a sign that it is a big-endian box.
>       */
>     #endif
