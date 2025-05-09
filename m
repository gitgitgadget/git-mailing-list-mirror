Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2020C030
	for <git@vger.kernel.org>; Fri,  9 May 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810524; cv=none; b=fGjcNaLpCLDMN6+YwlPtLfpqGnIo803lX9P8UICsAt15K/hXrpiuzCVtiW6tZE++Qs5/bE/B/gVmASy3cqE0HSroyMEG174P3GeyndcUawFxPvaUoQY7o/GGQOycaqlM3E4l7h7R07Y7tf98Usx6hPyA1HXQCxc3QU63Z+nIWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810524; c=relaxed/simple;
	bh=/cZb6Gu2uuP0gh5gM1z3oM8M1omaQnYsABO6V1eiErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DK6bhOs/GQDInCdpDvthywbo+TRatPlJ62P8N1i4XONTDfXLsxZ63V+iFWfvKkysPAJDub+IbS1qCQAXuNWPd2CvTIR7Z6k6uSiVspDMybD0SMAxJy/Ql7h1XFch97fRRr3pwwgXjtgNsJpmRZIUwYSK84FC58gXeH0DQQcwPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=CkmZtPsF; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="CkmZtPsF"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id B658B13F8BA;
	Fri,  9 May 2025 19:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1746810519;
	bh=/cZb6Gu2uuP0gh5gM1z3oM8M1omaQnYsABO6V1eiErE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkmZtPsFYZugTz1VrWimnKCEmgDtcrdSdl58r7XcdfSCvk1pw45HcZJYc/8CKWL6B
	 MbMc+S8M4EwlQgejgIo86TzMUvg5LBE09746tehMs2xO+IGWhstxDIue15VZhmoEZL
	 UhuKSTaBB4kiXlIYCXupArbPhgn8VaDWCiferjtjsiiQOcMhudBzO0lla/3jtua3hC
	 OGK3JH1IaMLH3Y8sqAFjboR52mnHB0Ao0vxTAO2CF6s2k4hMfDUcNxiO76yKpqCzXc
	 DGHtN3A46SLCGRPvxaxdvOq4TQrfeC1j/ynz5Nzt4/DYCfXEiSI0BiBxiNfZ8OWvyb
	 Ukuz/XrRCAgnQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Additional changes
Date: Fri, 09 May 2025 19:08:37 +0200
Message-ID: <13790247.uLZWGnKmhe@cayenne>
In-Reply-To: <xmqqr00x3l8h.fsf@gitster.g>
References:
 <20250503011537.3035416-1-gitster@pobox.com> <5040970.31r3eYUQgx@cayenne>
 <xmqqr00x3l8h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 9 May 2025 16:35:42 CEST Junio C Hamano wrote:
> Surely.  Are there particular things that you were either unsure
> about (which may lead to possible partial retraction) or want to
> stress on (which would help other developers and reviewers recall
> what they need to watch out for when touching the documentation)?
> 

Now that you're asking, the heavy additional changes to git-var's manpage are 
mainly targeted at clearing out some misuses of $ENV_VAR vs ENV_VAR as I see 
them. Others can disagree. 

Maybe these changes should go into a separated patch because they do not 
really fit with the "new style" changes.

Thanks


