Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3A41F461
	for <e@80x24.org>; Mon, 13 May 2019 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfEMQzB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:55:01 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41827 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbfEMQzA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 12:55:00 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CEB8820E15;
        Mon, 13 May 2019 12:54:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2019 12:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=mesmtp; bh=IGETVBWdtYXFLu8XJDJCdvfU
        iwXi+neXw3cQuoOrUGM=; b=14umwjN8UR/3AooDRDh/bm0Adxjss8CGrYnIAlNm
        sfLtBfNsR7yo/EhZ6t/R4YgmyLH1AgGAmkQ3S0IwaJp3hgngWSIWxM6khL5jzgbx
        xL4Nc5MB7cOgQC5g+Q7x6DrCONUzQi4gFYanuD3xbNdu47nHZqAL/XtOOoLQnNJK
        pR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IGETVB
        WdtYXFLu8XJDJCdvfUiwXi+neXw3cQuoOrUGM=; b=ppPG5+TuzDj/oUb3bBr976
        lflpr1JiO8cPNRG0d9oqKCGnsUF3H3MJaHoeYmQTEcNwcmMqWwt3XyPmiurMaHqF
        sMUwoBsfkwtFr0jEx3lbCDZe6k2/TPxjHWZTD6sSwGqPVOVLJNYgD/UjllSLpPo9
        yqLuoSE5tMN6fDO2sfMUXVX6cRsz1fhTvot5wpZwm3BHyJ6zo9iZ1v8BRSFfqc5d
        sy7V0woSpS2jdxbHBm1l6JB8PPwmkTOc68v7LC1gPxLkZ8vjXfRohiaqkWykzlDg
        Oj3dh3zpnjHUdNRcG4/FBDrsxQox8kdbqbuOYnMYo4uG1Is2opGkZ0X6v2XAwZFw
        ==
X-ME-Sender: <xms:Y6HZXInLvfVr0NjmSTpvPY64gsHnuvM84ojKsgd_s3Hw-83Qas0BLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhi
    sheqnecukfhppedukeehrdeiledrudeghedrudeigeenucfrrghrrghmpehmrghilhhfrh
    homhephhhisegrlhihshhsrgdrihhsnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Y6HZXLwGI2XhoZJ2GeJm6604jaT656lUARW572jFnX0ddGrhLTgigQ>
    <xmx:Y6HZXPIFBA6lIEM2_eqjRZ7MBkGpuu2fDhFUvJ-S1r3dsC2nMdPqlg>
    <xmx:Y6HZXOIEAl6WUnS43JtXDDMhuHZR0813LRzv_1sV3TEKsApuSbq4Ag>
    <xmx:Y6HZXO8QYW8xal0Xf13SbAal6Ad6Y4XAHYoeea-Rl1L5YGVjMSm7DA>
Received: from localhost (unknown [185.69.145.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id E580210379;
        Mon, 13 May 2019 12:54:58 -0400 (EDT)
Date:   Mon, 13 May 2019 16:54:55 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: explain why file: URLs and bundles don't mix
Message-ID: <20190513165140.vq225fscfvemol7k@x220.qyliss.net>
References: <20190513002355.25031-1-hi@alyssa.is>
 <xmqqv9yebwzp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iewqv3osc34ozlmf"
Content-Disposition: inline
In-Reply-To: <xmqqv9yebwzp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iewqv3osc34ozlmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > +- When cloning, the former implies --local option. See
> > +  linkgit:git-clone[1] for details.
> > +
> > +- The latter is implemented using linkgit:git-upload-pack[1], which
> > +  expects its repository to be a directory, and therefore does not
> > +  work for bundles (see linkgit:git-bundle[1]).
>
> Hmm, I do not think this is quite true.
>
> If "git clone /path/to/repo.bndl" implied --local, we would end up
> trying to hardlink into /path/to/repo.bndl/objects and would fail.
>
> I think what is closer to the reaility is that we check if the
> source is a bundle when the local filesystem path is used and try to
> clone from the bundle, before using the local filesystem path as a
> directory we can "clone --local" from.  On the other hand, when the
> <scheme>://<path> syntax is used, we do not even bother seeing if
> the named resource is a bundle, or if --local optimization is
> possible (because we do not bother seeing if the named resource is a
> local filesystem entity, either).

Would the following work better for you?

When cloning, the former will check to see if the source is a bundle.
If it is, it will clone from the bundle, otherwise it will behave as if
given --local. The latter performs neither of these checks, and
therefore does not support bundles.

> A possibly interesting tangent to think about is what would happen
> if we slightly tweak the above design.  What it would require for
> the code to take "git clone https://site/repo.bndl", realize that
> the named resource is a bundle file, curl/wget it and clone from
> that downloaded bundle?  And if it is feasible to implement, would
> it even be a good idea to begin with?  I do not have a ready answer
> to either of these questions myself.

I was very surprised to find that cloning from a bundle didn't even work
with a file URL, especially since the documentation seemed to imply that
it should. I assumed that file URLs not supporting bundles was an
oversight, and made some attempt to read the code with a view to fixing
it. Once I realised that file URLs went through a completely different
code path to paths, I decided it was better to just document things as
they were.

I think it would be nice if, at least for file URLs, bundles were
supported. I doubt supporting cloning a bundle over a network would
inherently cause problems (although I'm by no means qualified to make
such an assessment) -- if it's not clear whether it's a good idea to do
so, it could always be implemented without being advertised.

--iewqv3osc34ozlmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAlzZoToACgkQ+dvtSFmy
ccAbcw/8CdqSW6n4liLEsUVyAwoIdqpjxZbEoH+21Hx64tCizdsUV9C9xqzl4Npi
PMncgghkgOuIazB+73eXMFm2sCewQuMO49wvFNV/J8xsx+qexvL+nYb5xVn+Ssoe
kpP71OPfi74cks0LA0pJTWuzM2It8OtQnKXxEYriMVlzo1p38gR25Alt0eCsHiAp
Q6F6FFhPdR4mCCFiCfLwyMmYmqwAppL6xwV78ZoBznIGpeC1gC0ZW9oaehYTDWOR
6HP6UqubwMcmkzyuyPgCcK+iLJRjToJWj/Gv1nL7D865BqBl0f8O6fK+fvvgMsqt
t2APpHKtENXnE1a+/jiw/d4h8Qdf+uPb1ORbLXPdZvEmZV+84TqPSN0bNS9VweAW
gzr9TUXgK6Lk3IXQlaNYnE3OOtZlIs2+OZmVviY+068Tdjdssi+vzpmgd7jj16C1
VDO4pS8bz5mx0WCsf5UFneuurtky35hByNCXkBVD/jYEik63Q5OXW1vPwA2zYlc5
tFt87WseOLv40ZQ6jau7DPhkG6X3pBktkWuqf/sUsCC1AnM/DDI7yxSkXJCJAKo0
a/8ZuyBRG/yrw1Sk7iVG9SnBH5uua/xkcI3468nDnEB3XStBy3XBNqBk3up5spwU
rHCRE9tL8AcE5iTFJt9QlNrEybXgmMa1ebnQFLaO0RG8Szpz++k=
=ghEG
-----END PGP SIGNATURE-----

--iewqv3osc34ozlmf--
