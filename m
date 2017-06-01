Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEAEF2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 11:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdFALxD (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 07:53:03 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38017 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdFALxC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 07:53:02 -0400
Received: by mail-it0-f41.google.com with SMTP id r63so32430874itc.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GgnbOBJCICveKSFhU0RATspBQbhYWueFDGQ1BvKuBXY=;
        b=cF5/Hx1n6GM2dlSWDaNjdKjrJRFBmSVto7PC+htUl3jlgBGG49QqazKLVpG4UUfO6X
         vr3W+PZGn3fYSFHAzcH/99FjpFo/5NGzguN982MRj25G3RGmTjGLl47v+R/6TI3uv37s
         BBxeUhpwZtM611wV4KcQPRiq9Dvcm+XMx1RrDy0kzklKU8WYrEsvahFGxA3y1zF/9ZjU
         xe8RtJWY8/9LRXqAOVInSZYaTKjI2KcesSNLCVsbvIAxDEMN2WJC1f+/eCq6KllQlkw7
         kIfuPGG1wJEMCElDE+m10+ifZZcjx+Jyq22bBtMlUDfSuKnxuu74iM/N5O4/ifWfoESf
         RFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GgnbOBJCICveKSFhU0RATspBQbhYWueFDGQ1BvKuBXY=;
        b=Cvf15f5ORqoWz3RMkSJaN1GcUrSAjjyhz/0QVFGCShMjbXpTLcUGm3yFGkHuSKkDvH
         MDvNa5Mg8I8AtYzsYWpMcElzwqvBwDFFp6K845EF5bpQ5VBWCaoI68+aKX5KlShW7pyj
         BG0AjnhwX+FcCvPZpkfKd9hKOgASFhM9EyLdjAw70FvNTt3STAJu0VO3aLliDuKZATph
         tWypG8etZ1AGPKT5dWmc2J5AKmFqQZjVqbVdi70gFukKfBf+qdaSuVOYNuUlkQ+XhGat
         1AfQdgxxc7UnilOKDcA+prZ6iWP1a++dGPRndrk8z4v4j8P2VjzH2VxPvogrVe+QHGp8
         9dWA==
X-Gm-Message-State: AODbwcCsO1z9TPd/chs9boe2JhDxBhr4TG/KhRwEF25NSQ404jBLlB/J
        wC92v70DjNkiTIHsz3LxQX73ZT/LPQ==
X-Received: by 10.99.55.88 with SMTP id g24mr788751pgn.176.1496317981383; Thu,
 01 Jun 2017 04:53:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.137.233 with HTTP; Thu, 1 Jun 2017 04:53:00 -0700 (PDT)
In-Reply-To: <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com> <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 1 Jun 2017 13:53:00 +0200
Message-ID: <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Andreas Schwab <schwab@suse.de>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 June 2017 at 12:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> On Thu, Jun 1, 2017 at 12:26 PM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> On 1 June 2017 at 12:08, Andreas Schwab <schwab@suse.de> wrote:
>>> Even if the architecture implements unaligned accesses in hardware, it
>>> is still undefined behaviour, and the compiler will (eventually) take
>>> advantage of it.
>>
>> I tried to optically follow the macros and ended up on line 87/89 in
>> lib/sha1.c of the sha1dc-library, where there is undefined behavior if
>> the address is unaligned, which it seems it could be. Maybe Git uses
>> some particular combination of macro-definitions and I went down the
>> wrong path... There might also be other spots; I haven't thrown UBSan
>> at the code.
>>
>> Using memcpy on those lines should not be a performance problem on
>> platforms where unaligned access is ok, of course assuming the
>> compiler sees the opportunity.
>
> This is what the upstream version of sha1dc now in the next branch
> does, i.e. just does a memcpy() on platforms which aren't on a
> whitelist of CPUs that allow unaligned access.

Ok, now I get it. Undefined behavior can occur on line 1772 in
sha1dc/sha1.c on "next", but only if SHA1DC_ALLOW_UNALIGNED_ACCESS is
defined. I don't think the macro does what its name suggests, though.
To me, it behaves more like
SHA1DC_RELY_ON_UNDEFINED_BEHAVIOR_TO_DO_THE_RIGHT_THING_BY_CHANCE...

So it seems the call chain of commands and macros could be redesigned
to work with "char*" instead of "uint32_t*"... Then the lines I
mentioned earlier could be converted to memcpy and "should" be
compiled to efficient loads where possible. Yes, I know, patches speak
for themselves, and no, this mail is not a patch.
