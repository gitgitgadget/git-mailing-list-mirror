Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E8A5F
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235217; cv=none; b=ammLQhhrTp4QtRA+JZSzb7l2FognXQqM8MpomaG7cNKlv5H1XWKTBgRKA7eVBgcFkXwYSzen/cvhVT7KgQCE2EFpEE2QUFaWSccVfg2QkrvL6tOkaNNePDxy1iEMlhPQzRUICruGjBo8mFmhLYzdPq20Yosp+TfSfuANWv23m2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235217; c=relaxed/simple;
	bh=a3EZfexxhGOU2FcCLUB9r3Iy/1JQDm9mszf2eKw5z1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8Vlag7hysQ74NXohQhlJHcv7BEWR6MpTbPTRFfMh2P6YnzqJopflFa6pSAmW2dM0zBL2b7Bn6tSzkYVipXthuxTuQTDYElbQxU0QjZ/GvfiUV69xhr2gTxpMt2aXiNYtQWSZAek9RKjO5QLipBK/65Nsor0M5KxTn8yD43vXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eA3E9/Ur; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eA3E9/Ur"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7391735F4D;
	Thu, 29 Feb 2024 14:33:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a3EZfexxhGOU
	2FcCLUB9r3Iy/1JQDm9mszf2eKw5z1Q=; b=eA3E9/UrGMcZ+gwX7gLKadbqmhVt
	/vMw8Tc7eEvwvASlGvQQRQXDUbWD6DUpDV0tYPDkmN4L3S5epXPrukaYhKjT7Pqy
	nYVnTMYZavEs5S6n7FMgj4QBB5zfmSoW9Q6y1trmHX74bibutXuWIzc8VGX2Xctf
	ImVGNQQwP67jPBk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6713635F4C;
	Thu, 29 Feb 2024 14:33:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 044AB35F4B;
	Thu, 29 Feb 2024 14:33:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org
Subject: Re: [PATCH] branch: adjust documentation
In-Reply-To: <cbaf17e7-37a6-4c2e-82ba-65fe41dd86b1@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 29 Feb 2024 19:56:05 +0100")
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
	<e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
	<xmqq8r3lnzp0.fsf@gitster.g>
	<2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
	<ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
	<c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
	<be91f3ad9305366c1385c2da4881537e@manjaro.org>
	<xmqq8r3g8caz.fsf@gitster.g>
	<35738a93f5cbace5b3235ce614b7afbf@manjaro.org>
	<xmqqttm3ouxy.fsf@gitster.g>
	<16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
	<96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
	<b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
	<d1f928b98238a60a96bee0d3f410deef@manjaro.org>
	<xmqqttlsld4t.fsf@gitster.g>
	<cbaf17e7-37a6-4c2e-82ba-65fe41dd86b1@gmail.com>
Date: Thu, 29 Feb 2024 11:33:24 -0800
Message-ID: <xmqqcysff4l7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 68701624-D739-11EE-8A35-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> If we wisely choose the placeholder, perhaps we can write:
>
>     -m [<one>] <two>::
> 	Renames <one> (the current branch is used when not given) to
> 	a new name <two>, together with its reflog and configuration
> 	settings ...
>
> And if <one> is _good enough_ then "current branch is used when ..."
> should seem somewhat redundant.  So it could be possible to end up
> having something like:
>
>     -m [<one>] <two>::
> 	Renames <one> to a new name <two>, together with its reflog
> 	and configuration settings ...

If you use <the-current-branch-or-a-named-branch> or something
awkward like that as <one>, surely you can.  But I do not think we
want to go there.  And neither <branch-name> or <old-branch> would
remove the need for "if omitted then the current branch is used", I
am afraid, even though there may be a way to rephrase it more
concisely, e.g. "Rename the current branch (or <one> when given)..."

> Are we going to say "the current branch is used when ..." in the
> description for the other options too?  The description for "-c|-C",
> "--edit-description", "--unset-upstream", ...  Perhaps we are, and it
> will sound repetitive.

Do not forget that the objective of the larger-picture-revamping of
this page is to make the description of each option self-contained.
Similarity between -m's description and -c's description does not
count as being uselessly repetitive.

>> Even though the choice of words Rub=C3=A9n made in the patch under
>> discussion may work well in the current document structure.
>
> My patch is mainly about CodingGuideLines:
>
> 	If a placeholder has multiple words, they are separated by dashes:
> 	  <new-branch-name>
> 	  --template=3D<template-directory>

Yes, and that will be something we want to address _after_ we pick
what word or phrase would replace <one> or <two> in the above at the
conceptual level.  If we picked a single word, say "branch", we do
not even need to worry about dashes, and spell it just <branch>.  If
we did not pick "old branch", then we'd use "<old-branch>", but doing
such a conversion based on the current text is a wasted work, if we
end up using say "original branch" as the phrase, for example.

So if your patch is mainly about that part of the guideline, it is
addressing the documentation update in a wrong order, creating
possibly a wasted work.
