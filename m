Received: from mail-107163.simplelogin.co (mail-107163.simplelogin.co [79.135.107.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24661334C38
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=79.135.107.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058753; cv=pass; b=c3jbn+o1sZYAwveeY9M10JVq7lfLCM0pdYzP5JuYHEsH3hMTch/pWAYBeRK7JFyUmtqdISLo8k8R9kTDjzIPrOeiCa84VQ+/p1UWd6ZdXV86NVEsVLakbvplJLm8Ng1QBygjeUd+eraO2WqPtaVQugSENWpbhX0h9klU+rywTxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058753; c=relaxed/simple;
	bh=/G79bSCWFcxUDdmgNv9ktGI2tlYRvsiRd067dn0fNPY=;
	h=Date:Subject:In-Reply-To:MIME-Version:Content-Type:From:To:Cc:
	 Message-ID:References; b=a2E32g/oe0ZvLkHHP/127Q8FEMS98ziL4jS8t572CAJGphaQ/TQOlV4HOMBVhZXcx4QxDXzMas5HRnANIE0XAhGO/69HKlwq2DrBLDeR0GDLGEqOQBJE69XoVCeUu3iRcRbkaG0poWhKmWizQcUGxVUJxKT0YTgiPQWsDUiIwoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net; spf=pass smtp.mailfrom=passmail.net; dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b=kAAZZ6oa; arc=pass smtp.client-ip=79.135.107.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b="kAAZZ6oa"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1761057725;
	cv=none; b=Nmt2andEq9Qtt8ozzfo1xOJv52wMozWlSDDdFx1Ysmy54Z6eHVtbHs7OVuKoMOOAwQjhcgA/1eOWG+XnK1/8sLoe8kSJ4oi/+KfsuAYgUsHxxPtbf1RP9l19JXEJqGgd4LpQgnjNoMs/KfwBgPBcij0EJfLMpxdAvl3OYEhf49WuUbk1XSFRwurftFgE1qv1GgIGaQOfRF84hSzIoCLegc4ZKztUFYXWOYErHqImgHNwbDEOdMdXKhReY4WUlJTftTe1V0QmCWPtBTAv59G1AVUIz41SAlGo0t9xC5RN6a1h7EAoEDiHmALrkSrwiyVknhDXf4St9vKLJ9oKxofqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1761057725; c=relaxed/simple;
	bh=/G79bSCWFcxUDdmgNv9ktGI2tlYRvsiRd067dn0fNPY=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=xvYE6KV+c87ojt/BTuwdj9IYExKxfuaMIhCplWI9kxz6bTPkgwx0sNM+MxDQShbvqFxNObizvneYFVfCQomVcemq8H+SnLB7U64h4wqWVYLo69Y0Lc7bPmcEEWy2A5Ya2Rkqof/2IJW85TezSh9L7PQutlUIgl2UEdZH87EGyF478DfEZDv1rIdtqXVZAceBdez4VqMqIN/rEfrHhoPQev4KYDxbo0l7939s/J5/Pn6B8AWU9qkhL9nfQlAZKg1kNIpDuyH2B5bY+l7wLmKdSiksy7iV5NSeboQxeVz1XOXbGiUxUpV8NboYdJpWXWRbfa031kjWgyekbO2CxDeSJw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=passmail.net;
	s=dkim; t=1761057725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/G79bSCWFcxUDdmgNv9ktGI2tlYRvsiRd067dn0fNPY=;
	b=kAAZZ6oazHUpjBv/Yi+bxDZDC2jwjaqWkH4aVTFYsxtEND3ezrhj5kYihZRVEU4TEq1ou2
	IxR4R5ogdxDJcZr92pS7leYL+FOGOlbT12K9a0VYHKel6Ud+EeNBPiTFyzcpTWhVJVRUiU
	9l2DpuHCfvicVOGBKOpRG0meKilZulU=
Date: Tue, 21 Oct 2025 14:41:55 +0000
Subject: Re: [BUG] protocol.file.allow=always not honored when --local
In-Reply-To: <20251017071532.GA4073661@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: fence.borrowing375@passmail.net
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Message-ID: <176105772451.7.13453872556381855079.964553330@passmail.net>
References: <176066758616.6.12811000416591629223.957743298@passmail.net>
 <20251017071532.GA4073661@coredump.intra.peff.net>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 964553331
X-SimpleLogin-Want-Signing: yes

(I apologize for resending this, the first time I forgot to CC the
mailing list.)

The -c flag works for my use case, but this raises a couple questions:

- If submodules were ever to use the local config, would it be the
right thing to honor the protocol.allow and protocol.<name>.allow keys?

- Manpage GIT-SUBMODULE(1), under the add, init, and update
subcommands, notes that the local (superproject repository) config may
be updated when running these commands. In addition, the local config
is used for certain purposes, such as determining the default remote of
a new submodule. Readers know the local config is used in some way.
However, the manpage does not appear to state anywhere that, in
general, the local config is currently ignored. I found this confusing.

Is this a documentation bug?

On Fri, 2025-10-17 at 03:15 -0400, Jeff King wrote:
> On Fri, Oct 17, 2025 at 02:19:38AM +0000,
> fence.borrowing375@passmail.net=C2=A0wrote:
>=20
> > Created an empty directory, then initialized git:
> > `mkdir ~/test && cd ~/test && git init`
> >=20
> > Ensured file:// transport protocol is default/unset value (file://
> > is
> > disabled by default):
> > `git config --list | grep protocol`
> > # no output
> >=20
> > Enabled file:// transport for local repository:
> > `git config --local protocol.file.allow always`
> >=20
> > Then, attempted to add a git submodule:
> > `git submodule add /path/to/module/.git`
>=20
> I don't think this will work as you expect, because of the use of
> "git
> config --local". When we run git-clone under the hood to clone the
> new
> submodule, it is a new repository, and does not look at the config of
> the containing repository at all[1].
>=20
> As you noted, setting it in the user-level "--global" config file
> would
> work. You can also override the config via the environment like:
>=20
> =C2=A0 git -c protocol.file.allow=3Dalways submodule add ...
>=20
> though note that anybody cloning will need to do the same thing (and
> of
> course have the submodule available at the exact same local path!).
>=20
> -Peff
>=20
> [1] There have been discussions in the past on whether submodules
> should
> =C2=A0=C2=A0=C2=A0 receive some config from the superproject repository. =
But there
> are
> =C2=A0=C2=A0=C2=A0 a lot of complications, as it is the right thing for s=
ome config
> =C2=A0=C2=A0=C2=A0 keys but not for some others. I doubt we will change t=
he behavior
> =C2=A0=C2=A0=C2=A0 anytime soon.
>=20



