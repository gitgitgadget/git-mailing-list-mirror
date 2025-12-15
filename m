Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942512ECE9E
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816163; cv=pass; b=rRLpL25o9NDxO07yK5jCbxJ+fSEA87r8sTbsSQHpreBxnSbeWz1Xwk5NYJYuwGrR1x+deUQN0o2VMGxfdKqpSGQM68lg2mxGGe/gq5FI2NfH2GQLCk18mNO4T5vFJpJGmwsmnOaPYbv+zbm1dZxLFWGxMV2H5/RvG/gzNWlP5UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816163; c=relaxed/simple;
	bh=GzbTgiDEDuhiG97hYCGFwOjAaid/ZjtOn2b2tCe3n2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKYkOp76pOCYq+qBkHmm1a0FVMmTy7aE3u//Ez+6x8yWPIT0MeRhrkiffguiMKKFNWqNgqjzDvRjLQlfP+Zw9bHTOJyXkM1cIDYG6m5jA6OBeoCbh++wt0ygWlX80AqAu0/8WmNDabaqBuTtDNePgRUmt8Bjog2MNoVt0hQ1KBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FYncMJkS; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FYncMJkS"
ARC-Seal: i=1; a=rsa-sha256; t=1765816145; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LI/Gc2Gl4ZyaIQjLOrtPuAH70BxKaDDqSLnAQqvefwRvbuydnvjte/WO8wDbUDES9njL17FO883+3lK3pT0OfVDrg0Acab3oVTmsqrzjzYidmpn5EntLIApneiwqhdCNOUG5XDOqBqtrInXPX1PN1+7nTpPe+SPX2aYN3YG7SdE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765816145; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h5wm5ybQ2XRjLN2nLMR0oMJqJiN9A0bN9iRV9tyG5Jk=; 
	b=S7Iw2wvprrjv8mzMtw3+uNqudfRDjNme04zhXl4QRzB+fI7aKfUNCQMG0/0vh9ePPWb6YI34b9wIBxX/kBSkvbDAyf/EYtpFatdp5T2dg6LpFcji6uxef4oiD8PfEQWMliGdM1mHBF2pHhq1XfRZGOmdxmHwE/LPp5PgqSY9mSg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765816145;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h5wm5ybQ2XRjLN2nLMR0oMJqJiN9A0bN9iRV9tyG5Jk=;
	b=FYncMJkSHgYCH5y190enthy8jtwDCXHAsmDMjlKGrNRMYiPZbNI3Bf/m9kWhhm8i
	akZWtm9ylm6kCWVhHa+rMkLWT4RqF01wiv4+E4FEdWgme5M8OWaSr/V9a5q9AvjzD7r
	DPPnptc7AUWoB6yyI2EUnvYA79UdtdjBUB/SJcBw=
Received: by mx.zohomail.com with SMTPS id 1765816142863800.6662817528367;
	Mon, 15 Dec 2025 08:29:02 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/10] Add submodulePathConfig extension and gitdir
 encoding
In-Reply-To: <34DD8798-5C69-4092-B6C9-6609E688FBE8@gmail.com>
References: <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <34DD8798-5C69-4092-B6C9-6609E688FBE8@gmail.com>
Date: Mon, 15 Dec 2025 18:28:56 +0200
Message-ID: <87pl8flnef.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Sat, 13 Dec 2025, Ben Knoble <ben.knoble@gmail.com> wrote:
>> Le 13 d=C3=A9c. 2025 =C3=A0 03:09, Adrian Ratiu <adrian.ratiu@collabora.=
com> a =C3=A9crit :
>>=20
>> =EF=BB=BFHello everyone,
>>=20
>> For those new to the series, we're implementing a submodule gitdir
>> extension which allows us to have a unified way to determine gitdirs
>> and do things like encode submodule paths to avoid FS conflicts.
>
> Hi there, I admit I haven=E2=80=99t followed this series closely. I use s=
ubmodules quite a bit but haven=E2=80=99t yet peered into the depths of the=
 implementation.
>
> I read over the documentation changes in this series, and it=E2=80=99s no=
t clear to me how or why I would use this new feature (I don=E2=80=99t mean=
 there=E2=80=99s no benefit! Just that I=E2=80=99m having a hard time parsi=
ng it out.). By =E2=80=9Chow=E2=80=9D I mean: I can see how to set config a=
nd run the migrator; what does that unlock for me to now go and do?
>
> Does one of the previous cover letters explain how this is useful to subm=
odule users? If so which, and perhaps the docs could also contain a =E2=80=
=9Chere=E2=80=99s when/why you might want this extension enabled and what i=
t allows you to do=E2=80=9D?
>
> Or maybe this is meant to be not too user-facing, in which case I=E2=80=
=99m curious who would turn this on and why still :)
>
> Again, I am mostly curious, so please don=E2=80=99t read this as an attem=
pt to hold the series hostage! :)

It's perfectly ok to ask, no problem. :)

This series is for the minority of users who either:

1. Encounter errors like the following in submodule.c:
   die(_("refusing to create/use '%s' in another submodule's "...)

   These errors can happen due to a number of factors, like
   case-insensitive filesystems or submodule layouts.

2. Need to specify non-standard gitdir repository paths, different from
   the currently hardcoded .git/modules/<plain-name> location.

   With this series, the gitdir config becomes the unified way to
   set/get the gitdir paths, so you can move them around as needed.
   It also helps other git implementations who don't need to exactly
   match git's behaviour: the config becomes the standard interface.

If you are not in one of the two above cases, then there is no reason to
enable this and it won't affect you.

Hope this is clear, maybe we could spell it out better in the
documentation (suggestions welcome btw) or even tell users in the error
messages to enable this extension.
