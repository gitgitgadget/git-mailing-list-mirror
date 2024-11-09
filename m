Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1A18FC99
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154134; cv=none; b=QZ789fa5Ec0HO4OMEpvhkjHV/LHTfPGeTanwXeJ+M/xcTn5nzH8X4+7XSsNUr8sQ86bJ0J0jeTKLweFR+Hqiz2DleHYm8Dps7nPdN+vh5Revw7TXr03aW//wFPU1/sFCh75dY4lRTtBTNCKUKIGGIXV/urWqAgfOksBp3UJIw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154134; c=relaxed/simple;
	bh=DCorfdDA2o+36/AwUaebqouFajTyTyUWmpN7DHg/Ah0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6xxjNJ06yzDIjoGlisSAZK4qxerkgO6DIW3bHYnpcj1VUIBsJ0hzB+/v8uoaU5+BBVSc7EnQA53maZxp2PIBwC/DUdtpdFrasb3+RKuvDsb7/HAsTM1VRyyKwc7kzJq5dTsShb7oPh+RB8FpPreeQTsgR9bH0Jykj0W5Sqf5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=i1BJKPei; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="i1BJKPei"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jf8QSel6Rl588hxKkXt87KL0R/DTdaNl2qREK68QB10=; b=i1BJKPeicdflfYHir6kVVWE31M
	jW7hZe47QqRh2MYCRpiRNafL3zlifRYlP7D2UXKHjwGjYWMl5/DC5ohV818urJcnSogZ7MyDgfjnE
	Vr3tHSrZXjESuZdkYu5V/8zJ7rK3umE9F2eloKkmEReFgOnr25AH+FkZuzFT4+MFDw0IIdgZAIffL
	kpnNAh2/XV3iI5Whks+LgIprt3pFGdh8ktviAJwQ2ML807ZlaLBBxNHLIbhjlSBGU8B1Q/h1d1pYY
	8Pugt2DFTvR9m7LKGwL8I6mZfnMK0/EZVYbU481nlda6CCjvgCMsWui8S4Nnq8BSnXfwBgPS7uHSj
	gUJmRryA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1t9kGi-00GXj3-2I; Sat, 09 Nov 2024 12:08:44 +0000
Date: Sat, 9 Nov 2024 13:08:42 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, jrnieder@gmail.com, 
	Anders Kaseorg <andersk@mit.edu>, debian-devel@lists.debian.org
Subject: Re: Debian packaging for git-credential-libsecret
Message-ID: <s3ropj6j7mg2gbvtsu7suxeafht7kw6utzwjfiw7apip7psh3i@yf4kf5np4odm>
References: <CAGJzqsmOu-2kcOOAoXWkk3W=RQkdTE_AgZiY6Cj10_DdEnUVGQ@mail.gmail.com>
 <CAGJzqsmF7DVHw81z-eKTTtMc62YWeG4OgQ-R3k-bwV-8nmETHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsmF7DVHw81z-eKTTtMc62YWeG4OgQ-R3k-bwV-8nmETHQ@mail.gmail.com>
X-Debian-User: zeha

* M Hickford <mirth.hickford@gmail.com> [241109 12:45]:
> On Mon, 1 Apr 2024 at 21:42, M Hickford <mirth.hickford@gmail.com> wrote:
> >
> > Hi. It'd be great to package Git credential helper
> > git-credential-libsecret in Debian. There's a patch prepared, but it
> > needs the attention of a Debian developer. Is anyone here able to
> > help?  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878599
> 
> Hi. Is any Debian developer able to please look at patch to package
> Git credential helper git-credential-libsecret?

I think Debian is mostly waiting for Jonathan to show up again, and
we won't disturb his circles, more than necessary, in the meantime.

Chris

