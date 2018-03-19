Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA451F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966348AbeCSR1Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:27:16 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:42392 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965844AbeCSR1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:27:10 -0400
Received: by mail-ot0-f177.google.com with SMTP id v23-v6so2935810oth.9
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zTKOdIZkpsWSU0HTinu6ORChAQtL1rSb/bx7OpcmffE=;
        b=miNUNbem2tzaU2LMjUlR9oV1bovYlklZItdia1eTb8OcihvpF9l5W6pgWUdrC2ph5C
         rxtIqF5OkAFikZAGy6BQ4+SgF0+HBPCCEvNIgaGf2oPx41nzmuZb8ugqMC34wpXuSOhf
         m1GGuQqPnzHM4RafaNkTwH/XvIAayB04rsc2ZLfih0fjGgPCOgofTIvpWmNOyu720hJ7
         LGQQhzgi9k5egsoWW/RIRtrQuxXWhWIBA1URa3qckh5IXJ8l2J6nvkQkkCrrhGoIznK7
         Ap30fkfo3zCyFIlRWHtjPHESr8J94k/OgFzIaCX7baYstFwtJHCoNB2dGtBSKGKvtA0f
         FDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zTKOdIZkpsWSU0HTinu6ORChAQtL1rSb/bx7OpcmffE=;
        b=p90scy5cv/LeLSAQu6nf68rLTJkUZGlLCPFsdY7NKHDDKpvGBIpVYshwLD8JB/ItyP
         MNF2/Ov2aCD6UxXl9nhEgHV6PJ5Vp2REeBcD5v7JICBklGfuzclG6kwpN42pX+Wtk/QD
         mYPsZXHByulbrwdRYwz6pWewsY9EeTzlA9wccQ3MCLcYwdn5MN4ffX9oF3PV3Wg4CyHe
         N3I2OdOlpjo+dutxz6gIaCSdmp5eDxl1j3CQiWP0Uos7/KLqF3QlkDdtMq/ba5sxpsoZ
         ePIxWks+d9kcH3OCeM3AhWlcrqHlznu/c916ouDj873TrK30DcVKEVdUQdY613n/5fIP
         9kOg==
X-Gm-Message-State: AElRT7HCRoBSuga/PRFcZPX1AJAmdnrtzbPSGc7qwJOA6jaoNrhCtW1O
        qfa2Ffc4ZChGDxA/d3yddOnIihUsvdC7EoUMDPw=
X-Google-Smtp-Source: AG47ELtvY2LPBCfqRvrpoOiFCZknH2wm9e/xPst577hu0YrtiLTui+J3444volqcDgAOGqgnDtEXmuX7TGQUfOqPxOI=
X-Received: by 2002:a9d:182a:: with SMTP id b39-v6mr8847331ote.356.1521480429183;
 Mon, 19 Mar 2018 10:27:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 10:26:38 -0700 (PDT)
In-Reply-To: <87zi37d93w.fsf@evledraar.gmail.com>
References: <20180306104158.6541-1-pclouds@gmail.com> <20180316192745.19557-1-pclouds@gmail.com>
 <20180316192745.19557-3-pclouds@gmail.com> <87zi37d93w.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 18:26:38 +0100
Message-ID: <CACsJy8BoA7H+5nYigLRVTVAU70=WRiwQV2GkM10xhJWA2onvyA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gc: add --keep-base-pack
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 10:05 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Mar 16 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy jotted:
>
>> +--keep-base-pack::
>> +     All packs except the base pack and those marked with a `.keep`
>> +     files are consolidated into a single pack. The largest pack is
>> +     considered the base pack.
>> +
>
> I wonder if all of this would be less confusing as:
>
>> +--keep-biggest-pack::
>> +     All packs except the largest pack and those marked with a `.keep`
>> +     files are consolidated into a single pack.
>
> I.e. just skimming these docs I'd expect "base" to somehow be the thing
> that we initially cloned, of course in almost all cases that *is* the
> largest pack, but not necessarily. So rather than communicate that
> expectation let's just say largest/biggest?

Keeping the term base pack allows us to change its definition later
(something else other than "largest"). But to be honest I can't see
what else can a base pack(s) be. So unless people object I'm changing
this to --keep-biggest-pack (which could take a value <N> to keep <N>
largest packs, but I will refrain from doing things we don't need
right now).

>
> Maybe I'm the only one who finds this confusing...
--=20
Duy
