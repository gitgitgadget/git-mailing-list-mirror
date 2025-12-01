Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F355313E16
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595792; cv=none; b=ohSL0Y+l7wIeSuw02Y1ccMmVYu81ohItEFzzd2RBlygbMmH/3ZSPOl6MmZBzasVXj9HBwSBlif53TPl0nPjJcb2m0gvS3gctQ6tXa2+xEkRE75GNmCA1iMWocw7jT/M6g1mm1HvAaqARaeQcjpbhmrX/+XXhQdML4HlvL6VuGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595792; c=relaxed/simple;
	bh=6KwzPBZhfP23S2JDuKIOfP2NK1nI3iK2M1H7dAEn7h8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oCFRLfMHVmANraGshsK765Gn+RhbiR+TmKzl3YGDtdiPJ2RI218Vcn54VoY4AxgoAreWyK4ekLTKUP94yXX2IeTCMBCRkxc22jcTYBAdB0bhXPd9HdtumNMnYOhDNJ5ON0Pz45NdNdkRdGJZd3NcMSJk9pOs6xjrLmV6QKd/0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=lFvJh0Zr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="lFvJh0Zr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764595787; x=1765200587;
	i=johannes.schindelin@gmx.de;
	bh=5J2kf5xseAbF9gB1EY7LTmVgmbdL9MWDGLwhND9FbLA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lFvJh0ZrKBNN/IZ0xrCq63oy/RkoAM9kSonPPeP+J/hxOzgr2ryfQlHa9qtv8ZVO
	 PCyrPNxY9KJJRWuFMzZN8K8SFP3AJP4uT2WAgkEsLliwRsi1xV0hKSk58J5kp9sDX
	 fl4bFAYN8Ay/POVXE5LVBBO5mR7Q60HPlDLWj6W8e3JGx0fCkvo9ODyWFES62Xcmo
	 SkpjVkgnwK/5wEzTjlIkU6/vroGGFd2yLmmZRUBX0g/LcxeMmdeI4BvjXqBPlwh4E
	 qZCs1rLmPNaF5zkFBMkaBO5SJGclLoWIZ0xQH2Bws27uoeMZEv9dYxkoIpvWSr7ua
	 YrK0t9mf99KI0Y0zDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC34h-1vDii61W73-0002ON; Mon, 01
 Dec 2025 14:29:47 +0100
Date: Mon, 1 Dec 2025 14:29:45 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 07/10] t1006: accommodate for symlink support in MSYS2
In-Reply-To: <aS1kI0AR8TLVkm07@pks.im>
Message-ID: <fff2c7d2-acfd-7052-5e7a-e617bdd1d2e6@gmx.de>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <8a7c68b629f64a3fd8c08f54b5e8693f6568885c.1764440906.git.gitgitgadget@gmail.com> <aS1kI0AR8TLVkm07@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oKg/TbMsT+X3KsjsA+cXTl+Q1b/70WaBX780cbRLdEEu/FAi90x
 I9n16xMN/SrrXdjztrnDnTKjeUfOUU0FNzjQ5BEacy/bf7QWsXiAavoySb2U1QGVq7JVoYO
 KkC8RtQg8bP/aDSKYgjF0wRUrtbkknUbD89M6W9bWuvXFrTdlnU+DujdI29HCxHPKBBo4no
 sDuON+L2s5rlFPlAJGTlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o6Xp8iRNdBQ=;38+Khnsdheej+ZaXiOL7MlgKo7L
 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
 RYbghKoVUZg93lojs=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 1 Dec 2025, Patrick Steinhardt wrote:

> On Sat, Nov 29, 2025 at 06:28:23PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>=20
> >  test_expect_success 'git cat-file --batch-check --follow-symlinks wor=
ks for symlinks with internal ..' '
> > -	echo HEAD: | git cat-file --batch-check >expect &&
> > -	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >ac=
tual &&
> > -	test_cmp expect actual &&
> > -	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-sym=
links >actual &&
> > -	test_cmp expect actual &&
> > +	if test_have_prereq !MINGW
> > +	then
> > +		# The `up-down` and `up-down-trailing` symlinks are normalized
> > +		# in MSYS in `winsymlinks` mode and are therefore in a
> > +		# different shape than Git expects them.
> > +		echo HEAD: | git cat-file --batch-check >expect &&
> > +		echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >a=
ctual &&
> > +		test_cmp expect actual &&
> > +		echo HEAD:up-down-trailing | git cat-file --batch-check --follow-sy=
mlinks >actual &&
> > +		test_cmp expect actual
> > +	fi &&
> >  	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlink=
s >actual &&
> >  	test_cmp found actual &&
> >  	echo symlink 7 >expect &&
>=20
> I'm not quite sure I follow, so my questions may be dumb. Does this mean
> that git-cat-file(1) fails to follow the symlink in this case, and
> consequently we cannot execute it at all? If so, is this a bug that
> we'll eventually have to fix?

No, it means that the symbolic links are not even created in the way Git's
test suite thinks they are (or should be) created. The way those symbolic
link targets exist on disk (i.e. the way Cygwin's
`winsymlinks:nativestrict` mode constructs them), the expectations of this
test cannot be met, no matter what `cat-file` does.

Ciao,
Johannes
