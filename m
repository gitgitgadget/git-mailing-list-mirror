Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220512BEA4
	for <git@vger.kernel.org>; Wed,  8 May 2024 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199129; cv=none; b=q25Ma2dsqr2VQO1SFrpS5L1A/MxQEhwWB+3GJkNkJhW8GbhXgRuwZhGfnwF8NAr1+h2fGCLkWZ764Y28JASCNFVzvLU97Ff00D6Vc7s3fvjYEvahNn/HgVeKz4eFel2cJI3Odtwyiy/85HC0DqmCaG7fYJJghVCekUJwHMU0/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199129; c=relaxed/simple;
	bh=M1aCk1JW6ouuGB0Yq6Z/WllBgfol3LL8wSq6XlBstDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcKGz/4QUhpfkj4R7Z/jg9vbprq5C/HI70CACKQV2FeL90gVXU/sKlGcj2LWKRMmAthXOdxmU6Di3bXmcUS/OxnXWVlGzStiWWWphIfG4cAYqYA73GtAE+ZMCx0N2pWhY8TadoC9wxOc5/pY5uGdYGOFayYHC3D0IX+YmKEvuVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dJPy5m1O; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJPy5m1O"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 122A81FF38;
	Wed,  8 May 2024 16:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M1aCk1JW6ouu
	GB0Yq6Z/WllBgfol3LL8wSq6XlBstDo=; b=dJPy5m1OZVKmHa8YDAqZ57X3G8HM
	G6duJmwsugis5rGq+1vMSGnJNCJKFMNHHdM7Hr8e/wdQCEc1oddJt3m2uuDXngCE
	gpswtjvKBzVJxPVhgJp9OhJ3VPdk3sIVAa50bXkx68SmTsFBgcmgH1lVbX+Jr1jT
	GRKLeA4Jy7gaSoE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A4291FF37;
	Wed,  8 May 2024 16:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 944851FF36;
	Wed,  8 May 2024 16:12:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Helge Kreutzmann <debian@helgefjell.de>
Cc: Peter Krefting <peter@softwolves.pp.se>,  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA
 <avila.jn@gmail.com>,  git@vger.kernel.org
Subject: Re: i18n of git man pages
In-Reply-To: <ZjvHoykzIo34YJaT@meinfjell.helgefjelltest.de> (Helge
	Kreutzmann's message of "Wed, 8 May 2024 18:42:43 +0000")
References: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
	<xmqqjzk4xlis.fsf@gitster.g>
	<ZjvHoykzIo34YJaT@meinfjell.helgefjelltest.de>
Date: Wed, 08 May 2024 13:12:02 -0700
Message-ID: <xmqqedacxdv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3C546E18-0D77-11EF-B828-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Helge Kreutzmann <debian@helgefjell.de> writes:

> This mentions https://github.com/jnavila/git-manpages-l10n, so I can
> point our translator to this source.

That is a good move.

Perhaps we should make the manpage l10n project easier to discover
on our end to help volunteers.

Possible places are the "SubmittingPatches" document in our tree,
and "the Notes from the maintainer" letter that are sent out after
major releases.

Jean-No=C3=ABl, how does the following look?

Thanks.

 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPa=
tches
index 384893be1c..b36b3d9919 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -562,6 +562,13 @@ repositories.
=20
 Patches to these parts should be based on their trees.
=20
+- The "Git documentation translations" project, led by Jean-No=C3=ABl
+  Avila, translates our documentation pages.  Theire work products are
+  maintained separately from this project:
+
+	https://github.com/jnavila/git-manpages-l10n/
+
+
 [[patch-flow]]
 =3D=3D An ideal patch flow
=20


