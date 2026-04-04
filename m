Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252C330651
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775330967; cv=none; b=gGLc7q7P9/gzt+3nHmjsVzOMLH6GxZcWId+ufVvqJpG8VJVIpw4e2n8tzmncGCxc7T9fPKsElUYd/7IV8+kdulVG1wYZNt9RPNZoRa2iD54PWLCMPgHlU8GXKHJe60lwqYNdZ9QITK7/zKnSRwPo+1YWxpBPtvVmPwlcpk0cDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775330967; c=relaxed/simple;
	bh=SMuWdrcdd79po8A8n8619vCevNyGQvvSBOfQnCrWYn0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E2Mr18b/DEBIIuA8VHa289moi0JhmK8O6R3aVcbyxErWBQSt94ziEMIkgwDzaZjy85IQBmoq5lnM/0J26GzKLklTF2Pa0G7DYYGv35yr+3CD7BNL2jCh8njmcFp7UNWCeNQ92JbYv8z4n2X0CCDCnOIDgplgiGrjYjbpfQTmag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Vcw/GKif; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Vcw/GKif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775330962; x=1775935762;
	i=johannes.schindelin@gmx.de;
	bh=zCfqp5tzAMg9GIZa/WO/gLfmk5Eos1xIF+eG7KrXFXI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vcw/GKifFwtF00X6TFgug5zdJ2QApr470LidrSnQZLyMFBVUr8hlR13tbBxica/X
	 LdlszVvNxQiDRaaBoJOmRQJX5QkR4A1VOU7XfDPvUvbkp3jsbCav9dmWWR8xmESVy
	 GN/k0RE7DCfnT0GxrxkpD5Vfqmt3wjQhKAagyKCxgNyGocxZGlo4WtQW71yRxRyjD
	 lSNGI5xbYQ/Q4BwECZ4SnK+UkNFXCBuvrg6TdCcZXajB8kimdmoiRHkz9xQR0eh++
	 nMOXC00yT4nCBe6MXcAzB/ZwrcHiHmhoSIqnJfwoxu97lIXHcJG50PinQkmTcR2/X
	 3Odisg4zJNswclPUxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1w2Pfu25E0-00RTNS; Sat, 04
 Apr 2026 21:29:22 +0200
Date: Sat, 4 Apr 2026 21:29:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 11/17] t5509: specify bare repository path explicitly
In-Reply-To: <xmqqqzovnc25.fsf@gitster.g>
Message-ID: <67a9157c-37f5-282f-4566-0f6c55226571@gmx.de>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com> <f6fc807af627701bf7f9ea413c7714e9bc01aea4.1775140403.git.gitgitgadget@gmail.com> <xmqq341dozxc.fsf@gitster.g> <f43a7add-6a0c-2368-1b4c-655dfa6361e7@gmx.de> <xmqqqzovnc25.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+WbrwucQUr06C4Tbr8wNEB+brJvBXNUHpmS1FLb1WpwZ+/Ze3aZ
 OMHCcCdlGpwZmBRxgZjyiuPn97KkvGFFXdEwjqCNcAaf9ItZDvpT6qNAo9AcyoMEnfcyeIh
 3G6QrSLf+AofGQYcMjyibXaonfqC4JjX1L3wkiRtFyoGRCXguxBIgepm5Iwe0jdAT1tXeTv
 +DYl9W7U/939XwWGzpG0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g8nbq14eCFc=;J0BYmP7owvE1xjwbdAPgGXV/L8I
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 3 Apr 2026, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > It would be indeed more conservative, and it even results in less chan=
ges
> > when done in a more elegant fashion, by appending `--git-dir=3D.` afte=
r the
> > `-C pushee` [...]
>=20
> Makes sense.
>=20
> Assuming that we want to tighten the rule and prepare for the tightening
> before it happens, that is.  I personally do not think it is a bad move,
> but I do not recall we had much discussion to gain a community consensus
> to go in that direction.

Well, I wanted to contribute a patch to that extent, as a discussion
starter. And then the CI build broke. And then I found myself almost
overwhelmed with the changes required to let the CI build pass. And then I
thought I'd go through the effort of making those changes just to gauge
how much of a problem changing the default would be for affected parties.
And then I split up the preparatory patches into multiple sub-branches so
that reviewers wouldn't get overwhelmed. And you're looking at the first
sub-branch broken out from that PR.

Note that this here patch series, while it would be a necessary
prerequisite for changing the `safe.bareRepository` default in Git 3.0,
does have merit on its own, and I do not intend these patches to make such
a change of default behavior more or less likely in Git 3.0.

By introducing that setting, we declared that while not necessary at the
moment, it is better, really, to specify the location of bare repositories
explcitly than to rely on the implicit discovery. And this patch series
addresses a couple of places where Git's own test suite does not follow
our own advice.

For that reason I consider this patch series strictly a spring cleaning.

Ciao,
Johannes
