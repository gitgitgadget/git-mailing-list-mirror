Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781D4C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 22:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjARWrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjARWrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 17:47:05 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D54A1DD
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 14:47:04 -0800 (PST)
Date:   Wed, 18 Jan 2023 22:46:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1674082022; x=1674341222;
        bh=gqOkPZXtaR704VEM+gm7FpkIrgn0XIinw6kVznwhw6g=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Y3TkGso0hKnDfAnh/lhBWf4VAa03vaYiXTN+QyOiUe22gki2DQjCmG4a9B33A0J9U
         HkyHmH6AgRf+BBaNKJcmy29yMX87vl03jzxsTGzvAD37aoEC4G1TbmGOaRST93QZ1P
         1Strvp943l/uUC3ZTDfAAHwTHP3z7Dutg862yzXAzGYwK8F1AEoO5yCl7B2HlZ7T6A
         0S3CcZwKo02drCXR64L6PJ9ZFvmbe4U3IRmdlkxOycDIxSyE8B4emnpdGf8FSzZJYc
         Q26971SO+jFQI4+rKRHULuw3TAc2JHiv3QJcPMzgVnE3QT2th3m3F5OYpvWWgAIuBl
         r4/eeaHuOv/Wg==
To:     Junio C Hamano <gitster@pobox.com>
From:   'Jacob Abel' <jacobabel@nullpo.dev>
Cc:     rsbecker@nexbridge.com, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org,
        =?utf-8?Q?=27=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason=27?= 
        <avarab@gmail.com>, 'Eric Sunshine' <sunshine@sunshineco.com>,
        'Phillip Wood' <phillip.wood123@gmail.com>,
        =?utf-8?Q?=27Rub=C3=A9n_Justo=27?= <rjusto@gmail.com>,
        'Taylor Blau' <me@ttaylorr.com>
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
Message-ID: <20230118224639.d2kxrpgdidk7ez6f@phi>
In-Reply-To: <xmqq8ri4ihjg.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230109173227.29264-1-jacobabel@nullpo.dev> <20230109173227.29264-4-jacobabel@nullpo.dev> <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk> <20230114224715.ewec6sz5h3q3iijs@phi> <xmqqo7r0ijdv.fsf@gitster.g> <013701d92893$3fad5d10$bf081730$@nexbridge.com> <xmqq8ri4ihjg.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/14 07:49PM, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
>
> > [...]
>
> An orphan is not even detached, if I understand correctly.
>
> The state is what is called "being on an unborn branch", where your
> HEAD does not even point at any commit.  HEAD only knows a name of a
> branch that is not yet created but will be when you make a commit.
>
> While "(HEAD) being detached" means that you are on an existing
> commit---it is just that future history you extend by making a
> commit from that state will not be on any branch.
>
> So if we wanted to fix the misnomer, s/orphan/unborn/ would be how I
> would go about it.
>

I would support making this change (s/orphan/unborn/) as it's definitely le=
ss
confusing. Especially given that orphan already has a completely different,
overloaded meaning when referring to orphaned objects & commits (in the con=
text
of garbage collection).

