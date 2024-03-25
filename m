Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABF1BF2F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398949; cv=none; b=BKGhb/Ge7a8RRmP1g0UxQVnqSiaZAb+MHie6sYAvdVARuypJNdCyliue86zVbrs0Ygli3MEz9RXLpAQj2rjffLZCNns6b+MSV6M4o42nqR/BVCkO7z8cz7p4U6xuVEKzn/aDU4+rafxaClqZB3tc/92Ch5LUClssrQLyUp4+gj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398949; c=relaxed/simple;
	bh=Wm+9p88Zc61ILFn15SmkKfKb7NHRsurT4CFfAbTb5Gk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQkYas597BJtx6pdMMUxfgUtSCjvaOXb3+gx+nrGa10qFjnMgMbVExfjSoyuGR/AnTviyzMscB7o0Jd7q6thTJdiNarRAbtvdHnUAX/TGdofpnlOeteLSqw6rJtm12y1qHAKLbouwb0lENwrCUjkrrEMNgUCyH/1cUtRshasgj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Cg6M1bBd; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Cg6M1bBd"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PKZb5c026594
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 21:35:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711398937; bh=Wm+9p88Zc61ILFn15SmkKfKb7NHRsurT4CFfAbTb5Gk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Cg6M1bBdPOlQTMccAxVL2Xyz/Xe48jTY5S7+vOdiI+1VbNRyhZht3iskS8exzxEzJ
	 R3Pqb5ojwIxirfDjWt24bjY8HBUaTcHozmK/kKtGMY8QK9oe4Pt7ICkjayAHQsx1YI
	 Rbuy1uvGqUR5pYZ4uv02pw+kP2ziAcmmSI9RK/r8=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 1/5] MyFirstObjectWalk: use additional arg in
 config_fn_t
In-Reply-To: <xmqqcyrimdtx.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	25 Mar 2024 10:16:42 -0700")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net>
	<0eeb4b78ac91c2bddf775fdea34ce5c0515ff205.1711368499.git.dirk@gouders.net>
	<xmqqcyrimdtx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 25 Mar 2024 20:50:32 +0100
Message-ID: <ghttkuks53.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth
>
> In your next topic, use "git show -s --pretty=reference a4e7e317" to
> show "a4e7e317f8 (config: add ctx arg to config_fn_t, 2023-06-28)"
> with dates.  It makes it easier to see how long what is being fixed
> is broken, giving reviewers a sense of urgency for a fix.  It is not
> necessary to reroll this commit only to update the reference, though.

Yes, thanks, will do.
(This means I read SubmittingPatches too fast and have to re-read it to
see if I missed more details.)

Dirk
