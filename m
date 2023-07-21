Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86615EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 04:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGUEfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 00:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGUEfh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 00:35:37 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86F110E5
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:35:35 -0700 (PDT)
Date:   Fri, 21 Jul 2023 04:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689914131; x=1690173331;
        bh=I+oiV9ebkey/TvCjVz8gy2KSZfViK4SWjY19pCoN6S4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=fLoySbCp1W7tnJqPSZRVzJ2Tr2volfmS8WW0nqtuzAJb/3nbxGLkarhymKNFGsvCf
         lB+/odvfGZdHGRLB1g88JWKjGFI2I0ayKC7YG6pQcCgR4x92PQj3pXBSxNN62+bheZ
         APFofbi9IJNKoqwffhSlIr9KYNcFywj/HbcX6HlQ4SW3hVuVfnvxtp5Iy6NZBpHIzp
         oisJqQ1pKp873pixOO5EwfYzws+ox6QYLD+PbfIgzGU6VoXcMhlEBCRXnYV0DGA/C/
         9z61jh7ViyG7amqciORIhmCWI87O7WUdYjG/HDwH6XJ+zs8opmuhXJX7Z4Kw0V1qFW
         Y8B8kE/X5yBCA==
To:     phillip.wood@dunelm.org.uk
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Message-ID: <feeobdkifsgoo7rrx4r45qh3v5d2qgktmaggwhmdnh2h5hl7zw@k37fiqyh3irq>
In-Reply-To: <44671697-e9e6-d75a-30b9-7dccffcc792a@gmail.com>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com> <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk> <3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.com> <dyzkftugvd5b4f4wxsg6773fkrdrnbync6idvvi6h7cuuto36w@dbzjnkj3mh2l> <44671697-e9e6-d75a-30b9-7dccffcc792a@gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/18 02:36PM, Phillip Wood wrote:
> [...]
>=20
> The existing code is not consistent on this point but I think there are
> more instances of "    " than "\t". Using "    " makes the indentation
> consistent as the "hint: " prefix is translated so we don't know how far
> the next tab stop will be from the end of the prefix.

Agreed.

> > [...]
>=20
> In the test we are redirecting the output to a file so things like tmux
> do not come into play. I think it would be a bit odd for the system libc
> to convert tabs to spaces.

Understood. It was just a bit of paranoia on my part then.

> [...]
>
> > Understood. I'll start working on a separate patch to update that
> > warning once this patch settles then.
>=20
> That's great. I think just telling the user something like
>=20
>     branch 'main' does not exist
>=20
> when HEAD contains the dangling symbolic ref "refs/heads/main" and
>=20
>      HEAD is corrupt
>=20
> when it is not a symbolic ref and repo_get_oid() fails would be fine.

Noted. I'll workshop it a bit before I put v1 of that patch out.

