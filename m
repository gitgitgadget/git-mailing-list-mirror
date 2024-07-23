Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C59157467
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753007; cv=none; b=gkR8kMagV3DewpnITnn9j6jodXUZSw6zP4ZMss4vAM5M4kblO+/n4GzvweZrHzlL+7JukuRrBjzRUe/upZlxrwvTuAv1pLJVT9+5A3dCY8BJpcaQk6/LmbRh9xjwdJndgs9LDal+Rn0aRIH++T3mUV9nnDlTP5e9BhPy6/rCCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753007; c=relaxed/simple;
	bh=S9Pp0jT5tO5rK3b/BEdbc60EFeOchnDnk990G87oqew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D0dpX2I3KnmgiOAddvhOLaENc0fmIJwjXf+iBtfqITNnvEnUzLd89r3RA50cIHZB3300FxjDC5d3KXI+ZS5PRUo4be9TdOVIUcd5qAl2QiV7zEuOPWy4D+AyGSKwuVohzZcAf6InzvF4FB7W0q+2RTsJhEeK1yNG26PCEB+YoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jy2QGy2Y; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jy2QGy2Y"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FCA52FFB5;
	Tue, 23 Jul 2024 12:43:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=S9Pp0jT5tO5r
	K3b/BEdbc60EFeOchnDnk990G87oqew=; b=jy2QGy2Y6ldeMtxR5HvP1XSbl1sp
	/C0G1uC/MjHn+ydIRylCsf/ynxPCkHYtMpaWDEcvopV+wOG6DsDQqm2lb6l55p/I
	2vlzNVsyV05DZoKh8cFXWmsq03CTlLAFarel4RUEuogmZaWzFzmcwAWjAne8c+Lf
	HZ4OL+W4LsVxwp4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6926E2FFB4;
	Tue, 23 Jul 2024 12:43:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC0EE2FFB3;
	Tue, 23 Jul 2024 12:43:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  Ramsay Jones
 <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] asciidoctor: fix `synopsis` rendering
In-Reply-To: <a1d70653-182e-e063-5438-2b3179d011f7@gmx.de> (Johannes
	Schindelin's message of "Tue, 23 Jul 2024 16:19:00 +0200 (CEST)")
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
	<pull.1749.v2.git.git.1721679949618.gitgitgadget@gmail.com>
	<xmqqplr59mvm.fsf@gitster.g>
	<a1d70653-182e-e063-5438-2b3179d011f7@gmx.de>
Date: Tue, 23 Jul 2024 09:43:14 -0700
Message-ID: <xmqqr0bk2h5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A8ABAA78-4912-11EF-AA93-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hmm. This adds a "template" for no other reason than to appease the rul=
e
> that all `.html` files in `Documentation/` _must_ be generated. Typical=
ly,
> templates are only added if anything in them needs to be interpolated t=
o
> reflect the particular build, which is not the case here.

Consider that we leave the door open for future enhancements (like,
lose the conditional compilation and instead make it an empty file
when AsciiDoc and not asciidoctor is in use).

> Have you considered one of these alternatives?

No, because I am not interested in anything more elaborate a few
days before tagging -rc2.  If this is not meant for the upcoming
release, then I am all ears (and eyes), but otherwise, let's just do
the simplest and the most obvious thing to unbreak users for the
upcoming release and leave a more elaborate engineering to next
cycle.

Jean-No=C3=ABl is planning to undo the overly elaborate mark-up and that
may eliminate the need to work around "<code> in <pre> is made into
a block element" behaviour of default asciidoctor style in the first
place, so the longer term plan should take that into account as well.

Thanks.
