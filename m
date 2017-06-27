Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C1B20401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbdF0SwP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:52:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32786 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbdF0SwM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:52:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id j85so7449963wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MpKO+IzDOq1Zocqs5Dq23eh1zWJqZk5iD0M+j/8aLMA=;
        b=hYqfkwadBypTYM2EWlrfSha+FKYvcwC3/oup/66K1adqbrbBWlYcZaGYhC3MJWZmtB
         YXgp9u+wgN1fb7Ef68Vx/cne14OEyrcexX2PN+iLE+h9q0osGQujHzzD3xcPjb1GtOMO
         FbpZnFQHaq7Y6PJkoqzHYj3H+PPeoS5pxtJSWk2Uzp5Cqg3cRG0rJCc6QCDhCPcQXjyy
         N6vGC3IDK0jyiUZE/fJnb/uPreMDFD0mCR2vLQdSlczmdZYUb7BdL03uEYf4F7W9/CQU
         t1RXk03A1V9r2XCjICHuMZ+P1D5TGRd9/99ibk8xRbKgFzr2oeTUzAi+Lw5I3wwLsByh
         HNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MpKO+IzDOq1Zocqs5Dq23eh1zWJqZk5iD0M+j/8aLMA=;
        b=JD1c4mj5duKie91VKsBt0BHfK4UPoLtCy1ttdHATcy1WAHH4Oj9qS2dYZ8ccDOCNI5
         +cINlmbUXP/kw5Uxy2rGCL5CfliRBMhB+msG3G2Nq2duICNzwDqnGQdF+aAY9GChiyK4
         /psxSBn7eeId9Ylug2Mh7V4IpefnInpa5AVO+V1+WuDtLOAGtsGVX6EQnrpIay0v1V/v
         DhSayW5rFOsbrDzm/WJkb4i4sa198hYUBC/W4NdAvF5aFKInNFeB0Jf3priSrrIy9hYv
         9hz7jN3/jO3gtddsBwZ6GLvlO0R+FVWZyalkfWTi+EJMOLqdSq1vJfEi0FRdmilvGR2i
         4nnA==
X-Gm-Message-State: AKS2vOxLlOinybczmMqf6pgrUIAiAUIIMYXvAJTAVwoQPRx34jsZH8Ue
        3TdY78XS0iSYt908i3Y=
X-Received: by 10.80.181.165 with SMTP id a34mr4929637ede.167.1498589531417;
        Tue, 27 Jun 2017 11:52:11 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id h23sm2125681ede.56.2017.06.27.11.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 11:52:10 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPvar-0006ZW-48; Tue, 27 Jun 2017 20:52:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <20170627121718.12078-2-avarab@gmail.com> <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com> <87zictjoff.fsf@gmail.com> <xmqqk23x1e8h.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqk23x1e8h.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 20:52:09 +0200
Message-ID: <87tw31jmau.fsf@gmail.com>
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
>>>> +#if defined(__BYTE_ORDER) && defined(__BIG_ENDIAN)
>>>> +/*
>>>> + * Should detect Big Endian under glibc.git since 14245eb70e ("entered
>>>> + * into RCS", 1992-11-25). Defined in <endian.h> which will have been
>>>> + * brought in by standard headers. See glibc.git and
>>>> + * https://sourceforge.net/p/predef/wiki/Endianness/
>>>> + */
>>>> +#if __BYTE_ORDER == __BIG_ENDIAN
>>>>  #define SHA1DC_BIGENDIAN
>>>>  #endif
>>>
>>> Note that this part of the file considers it a valid way for a
>>> platform to define a constant BIG_ENDIAN that can be compared to
>>> BYTE_ORDER to determine the endianness, implying that such a scheme
>>> would also define LITTLE_ENDIAN and a port of such a platform to a
>>> little endian box will still _define_ the constant BIG_ENDIAN; it
>>> aill have BYTE_ORDER defined to the same value as LITTLE_ENDIAN,
>>> though.
>>
>> This may fail if we have some non-glibc platform that's defining
>> __BYTE_ORDER and __BIG_ENDIAN, but if it's glibc then __BIG_ENDIAN will
>> always be defined, even on little-endian platforms.
>
> Yes, that is exactly the point of my comment.  We want to be
> prepared to see a platform that is not big endian to define
> BIG_ENDIAN (with some underscore).

Indeed, but FWIW this is the very first test in v2.13.0, so this
specific logic has already seen quite a bit of testing/porting on
numerous systems without issues (except Solaris obviously), but we'll
hopefully fix that this time around.

>>>> +#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
>>>> +
>>>> +#ifdef _BIG_ENDIAN
>>>> +/*
>>>> + * Solaris / illumos defines either _LITTLE_ENDIAN or _BIG_ENDIAN in
>>>> + * <sys/isa_defs.h>.
>>>> + */
>>>> +#define SHA1DC_BIGENDIAN
>>>
>>> This makes readers of this patch wonder why we assume platforms
>>> won't define _LITTLE_ENDIAN and _BIG_ENDIAN at the same time, just
>>> like we saw in the section with __BIG_ENDIAN above.
>>
>> At least on Solaris if we get this far that won't be the case.

It actually turns out this isn't needed, since we can just check __sparc
and skip checking _BIG_ENDIAN, so no Solaris-specific code needed.

> Yes, but the remainder of world is not all Solaris.

Indeed, but either once we're this far in the checks we're past anything
that runs gcc/clang/glibc or <list of known bigendian processors>, which
is going to be a small list regardless.

Anyway, will fix.
