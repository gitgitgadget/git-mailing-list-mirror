Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C983820401
	for <e@80x24.org>; Tue, 27 Jun 2017 15:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753641AbdF0PWU (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 11:22:20 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36589 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdF0PWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 11:22:18 -0400
Received: by mail-pg0-f67.google.com with SMTP id u36so4678285pgn.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ASR/Zulun2zeIBtWG6GW1E2GTL5sNSYh0OxM8z7Jlv4=;
        b=CSmAF9vtt0uzbglujlah3CXCZ9wEiF3TtsGmUp3ZFtwSzcvDpdqVY4t32JZ108wYz0
         gjZjrgETWNjWyFRNBWGNjPS851NuGkws3LvilaMRSBjDhB0NHukIYpHcpA0wzOkpps2b
         qRoR/eAHxmlGk6v8cuO2DH4wrEApm4Nzst8/T7IHj7j8y18R3Mae2qlVc5NmzSh+DuDf
         Jttq7PuYtGtiaK0z+A6vwKgS3BS0x+SQ9WWoBcMU1ShMZfT/BKuJlQJq/kBQbRUshXMr
         LZUWs7Q09fB4yeVvsFK+A3GLRS56cSFPFrtfyddoyXT2fQ8FUHIpbQexxFM2M/iic1K5
         pjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ASR/Zulun2zeIBtWG6GW1E2GTL5sNSYh0OxM8z7Jlv4=;
        b=H6mmRhWEWZNyE5qjzn0IJvXKe6+hIQ9Sa4rxV+8HHcsnggOCXtwsu+M565cjjRM93V
         l9Wdc6PzPk8r9leH6a6GopyTIPVpcTP5rKIE+a0yK9seyiFaTfQ8ioQezJSNqNCJGl4F
         MWQNsfRS9U2gq2NpPjGr/MaXdAcMkSTXn8z5Rvo08zb/Y7XfmXj3CuWG+al8/kMQia0j
         Tv7E3rn9xwVuMQqmZBtkvmtOgJN2iZqRSlTp0pdMW5C7lv4ALPBQ5bIxSW2Wo+lb80Yh
         OK0iGbjRA1r1ZdbAtIfTnY+cWsEUufm71eNBLrQ/EDSW0v70CTMKxXPqCblCFBcGUdJz
         q4yw==
X-Gm-Message-State: AKS2vOyJgXBpsfkERBgOHuU13d8qDRKD/srELk1slgYxitr/Q2gEezcO
        Z6kG9mrH4mr1RQ==
X-Received: by 10.99.131.193 with SMTP id h184mr5993716pge.80.1498576937380;
        Tue, 27 Jun 2017 08:22:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id d24sm8128937pfk.43.2017.06.27.08.22.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 08:22:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
Date:   Tue, 27 Jun 2017 08:22:15 -0700
In-Reply-To: <20170627121718.12078-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Jun 2017 12:17:16 +0000")
Message-ID: <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Update sha1dc from my PR #36[1] which'll hopefully be integrated by
> upstream soon.

Please be careful about the title of the patch.  "log --oneline"
does not even let you tell your readers who calls this as "my"
change, and readers would be clueless what PR #36 is.  Something
like

    sha1dc: correct endian detection for Solaris

may give us more relevant information in the oneline output.

> @@ -23,6 +23,13 @@
>  #include "sha1.h"
>  #include "ubc_check.h"
>  
> +#if (defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
> +     defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
> +     defined(__i586__) || defined(__i686__) || defined(_M_IX86) || defined(__X86__) || \
> +     defined(_X86_) || defined(__THW_INTEL__) || defined(__I86__) || defined(__INTEL__) || \
> +     defined(__386) || defined(_M_X64) || defined(_M_AMD64))
> +#define SHA1DC_ON_INTEL_LIKE_PROCESSOR
> +#endif

It is good that you made this orthogonal to the rest.

> +#else /* Not under GCC-alike */
>  
> +#if defined(__BYTE_ORDER) && defined(__BIG_ENDIAN)
> +/*
> + * Should detect Big Endian under glibc.git since 14245eb70e ("entered
> + * into RCS", 1992-11-25). Defined in <endian.h> which will have been
> + * brought in by standard headers. See glibc.git and
> + * https://sourceforge.net/p/predef/wiki/Endianness/
> + */
> +#if __BYTE_ORDER == __BIG_ENDIAN
>  #define SHA1DC_BIGENDIAN
>  #endif

Note that this part of the file considers it a valid way for a
platform to define a constant BIG_ENDIAN that can be compared to
BYTE_ORDER to determine the endianness, implying that such a scheme
would also define LITTLE_ENDIAN and a port of such a platform to a
little endian box will still _define_ the constant BIG_ENDIAN; it
aill have BYTE_ORDER defined to the same value as LITTLE_ENDIAN,
though.

> +#if (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
>       defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
>       defined(__sparc))
> +/*
> + * Should define Big Endian for a whitelist of known processors. See
> + * https://sourceforge.net/p/predef/wiki/Endianness/ and
> + * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
> + */
>  #define SHA1DC_BIGENDIAN

These look sensible.

> +#else /* Not under GCC-alike or glibc or <processor whitelist> */
> +
> +#if defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
> +/*
> + * As a last resort before we fall back on _BIG_ENDIAN or whatever
> + * else we're not 100% sure about below, we blacklist specific
> + * processors here. We could add more, see
> + * e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
> + */
> +#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
> +
> +#ifdef _BIG_ENDIAN
> +/*
> + * Solaris / illumos defines either _LITTLE_ENDIAN or _BIG_ENDIAN in
> + * <sys/isa_defs.h>.
> + */
> +#define SHA1DC_BIGENDIAN

This makes readers of this patch wonder why we assume platforms
won't define _LITTLE_ENDIAN and _BIG_ENDIAN at the same time, just
like we saw in the section with __BIG_ENDIAN above.

Thanks, but this is starting to feel like watching a whack-a-mole
played while blindfolded.  At some point, somebody upstream should
declare that enough is enough and introduce the "SHA1DC_FORCE_ENDIAN" 
macro.
