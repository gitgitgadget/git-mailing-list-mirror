Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02802082F
	for <e@80x24.org>; Tue, 27 Jun 2017 18:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbdF0SGR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:06:17 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38654 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdF0SGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:06:16 -0400
Received: by mail-wm0-f46.google.com with SMTP id b184so34953256wme.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6LYWGcQqKS7pDawb66EVrvc08+GQhkPBChnl/EgLLNs=;
        b=pvdvEGkF74wZB6NdAfFZ8dodtZUFRM+j30AdWXtTJt8ZPHznpzzhP/yLQzj+ieZJfL
         BJi2h4gndC+MEqxg7j76BLApP1qq1ciDkPVD+QLO4Jpwtgo3VZCgUoVpg6ttVk5mBYMc
         6FF0iTNkF+/SkGZV4Z5tk1FtRJVS7sXTUhYW9ubUCCsdvmzJeubGdTxzSM4wtUZFrzr2
         fw2pu2u4ud5PeSsncs2GMvczBjewoishgwxY2a6Xr9D9D1yt3DkD7ybxwclBNWtReyaC
         X5BGruG6NpJsYeMHtdwG5KKlqjkIRcr7jaBMJbntJa1HcP6++rsOJxrlMZAdkhwFeMOo
         O0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6LYWGcQqKS7pDawb66EVrvc08+GQhkPBChnl/EgLLNs=;
        b=fWCbL14WXV97xK80ACKTzm2ZJbj69At3HL2ZhBnMQdDMZ3txFe6dVcmDZK+S5mjrNQ
         zA/2gXnqy1FeS4KdQ+nGICl1FLHF6zF7vN2wTNc1yQ0yaU4e79JIjH03KqFl06Sp9jdH
         wxhkAeC5V1pHLfJUGOXDPUVbte3haPiJ2Hbdkxq99bgUX3Nt9mNSQ9+hZe/Z+eLd13zY
         dSjhFT5u8rDSw4VJubHi1gNkd30MY2Yrp8aEGtj5kCM0vo/J4UADT6oEsqp6MPQpKT5z
         sgyXSKgd09inZ3aY51SBKkMWCrxiLLl/jbbLzWoPum0j9LplTmtRsZ2d+IIum+mAhc1B
         k/HA==
X-Gm-Message-State: AKS2vOzObiZ2uHtPI/pBhwoeYuPlq2iPjPCfrdnsS0R1oQ+YaB+/iIHW
        j062K8ob0gMHLA==
X-Received: by 10.80.168.102 with SMTP id j93mr4941625edc.32.1498586774477;
        Tue, 27 Jun 2017 11:06:14 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id w26sm2131239edw.24.2017.06.27.11.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 11:06:13 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPusO-0005qs-Fc; Tue, 27 Jun 2017 20:06:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <20170627121718.12078-2-avarab@gmail.com> <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 20:06:12 +0200
Message-ID: <87zictjoff.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Update sha1dc from my PR #36[1] which'll hopefully be integrated by
>> upstream soon.
>
> Please be careful about the title of the patch.  "log --oneline"
> does not even let you tell your readers who calls this as "my"
> change, and readers would be clueless what PR #36 is.  Something
> like
>
>     sha1dc: correct endian detection for Solaris
>
> may give us more relevant information in the oneline output.

Will fix. Can you integrate it as-is into pu anyway? I'm going to need
to re-submit it regardless once we get some testing on it & upstream
merges the PR, but having it in Travis et al in the meantime would be
great.

>> @@ -23,6 +23,13 @@
>>  #include "sha1.h"
>>  #include "ubc_check.h"
>>
>> +#if (defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
>> +     defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
>> +     defined(__i586__) || defined(__i686__) || defined(_M_IX86) || defined(__X86__) || \
>> +     defined(_X86_) || defined(__THW_INTEL__) || defined(__I86__) || defined(__INTEL__) || \
>> +     defined(__386) || defined(_M_X64) || defined(_M_AMD64))
>> +#define SHA1DC_ON_INTEL_LIKE_PROCESSOR
>> +#endif
>
> It is good that you made this orthogonal to the rest.
>
>> +#else /* Not under GCC-alike */
>>
>> +#if defined(__BYTE_ORDER) && defined(__BIG_ENDIAN)
>> +/*
>> + * Should detect Big Endian under glibc.git since 14245eb70e ("entered
>> + * into RCS", 1992-11-25). Defined in <endian.h> which will have been
>> + * brought in by standard headers. See glibc.git and
>> + * https://sourceforge.net/p/predef/wiki/Endianness/
>> + */
>> +#if __BYTE_ORDER == __BIG_ENDIAN
>>  #define SHA1DC_BIGENDIAN
>>  #endif
>
> Note that this part of the file considers it a valid way for a
> platform to define a constant BIG_ENDIAN that can be compared to
> BYTE_ORDER to determine the endianness, implying that such a scheme
> would also define LITTLE_ENDIAN and a port of such a platform to a
> little endian box will still _define_ the constant BIG_ENDIAN; it
> aill have BYTE_ORDER defined to the same value as LITTLE_ENDIAN,
> though.

This may fail if we have some non-glibc platform that's defining
__BYTE_ORDER and __BIG_ENDIAN, but if it's glibc then __BIG_ENDIAN will
always be defined, even on little-endian platforms.

>> +#if (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
>>       defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
>>       defined(__sparc))
>> +/*
>> + * Should define Big Endian for a whitelist of known processors. See
>> + * https://sourceforge.net/p/predef/wiki/Endianness/ and
>> + * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
>> + */
>>  #define SHA1DC_BIGENDIAN
>
> These look sensible.
>
>> +#else /* Not under GCC-alike or glibc or <processor whitelist> */
>> +
>> +#if defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
>> +/*
>> + * As a last resort before we fall back on _BIG_ENDIAN or whatever
>> + * else we're not 100% sure about below, we blacklist specific
>> + * processors here. We could add more, see
>> + * e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
>> + */
>> +#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
>> +
>> +#ifdef _BIG_ENDIAN
>> +/*
>> + * Solaris / illumos defines either _LITTLE_ENDIAN or _BIG_ENDIAN in
>> + * <sys/isa_defs.h>.
>> + */
>> +#define SHA1DC_BIGENDIAN
>
> This makes readers of this patch wonder why we assume platforms
> won't define _LITTLE_ENDIAN and _BIG_ENDIAN at the same time, just
> like we saw in the section with __BIG_ENDIAN above.

At least on Solaris if we get this far that won't be the case.

> Thanks, but this is starting to feel like watching a whack-a-mole
> played while blindfolded.

Yeah for sure, I don't have access to solaris/cygwin or other obscure
platforms myself.

I do think this is fundimentally a better approach though since we first
check exactly what we know GCC / clang have, then glibc etc.

But yeah, by the time we're detecting Solaris I'm somewhat shooting
blind.
