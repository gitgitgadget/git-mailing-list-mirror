Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEC35971
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759625339; cv=none; b=QJ+LMWMUhaoZ/kyPXeH4Y/FUxyMPWxXh4okNY9m1bB+DTxfbO2i/xOsqMzqg+MmSPFsEoOYw1W/KIpwmCoFG1Sd/Pw3bQnaUcckgsfpHh4onUUmCoNSpbo35CFHXVcA55FUquxPteqlkHq4mm0OcKb24fjAtfF1UKg6JMyKVzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759625339; c=relaxed/simple;
	bh=iiOb3Bzfk661KreTYzUj9tSi1sk8OOXpKcY0wVMR32Y=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=FpmeqqV/UVAxDyR6g9HwiCGT9A8z5u1k1+HtcmUOMzJwx6zwZDx0lE51iVYkYuvuQE9x6NiS7jkb/0MY201NPnpHeRg7Y5yOzyql08vkL/v/BmLPaS8hIj9wFZU2beHfPqMBAvcKO9drROsopK01le+VQkAFdTmadBUaw9P9SVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=l28bVtEL; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="l28bVtEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759625328; x=1759884528;
	bh=iiOb3Bzfk661KreTYzUj9tSi1sk8OOXpKcY0wVMR32Y=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=l28bVtEL7daQMs/VVnS3U9/D/WegaxUgUGVk1Q/u9o570hfVdCEhHOBsYjt50DzzE
	 vMnKTuzDLb7TOW2Us/fJ3d0OIZ/vWdU0YZnlM5+ISuEXASxX4JPv83mQ4h+VDawiic
	 gU8vqlKIjXIs1VZhLpnZQ9q5IGoxpNYLAAuR1pwzQywL2kJhSIGJb4Pq211HfjewhC
	 4SbvqwOB+ua40Hq4YFXX3aM/SE/PtyQNjkTCK0/1JB04aOa4000kV1cG54NpJXR8Wg
	 0pyldd6mwZRt2jaWLYXpAJBO4wYpxcxFsUU5yujt2APtO/DrD51psFCOAtCPThynZq
	 EsXjjJR4Z9FFg==
Date: Sun, 05 Oct 2025 00:48:43 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Langbart <Langbart@protonmail.com>
Subject: Git Status Short Output Color Inconsistency with -z Flag
Message-ID: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com>
Feedback-ID: 20607877:user:proton
X-Pm-Message-ID: 7e094b77f4371b4ef2272b08f3615a5bfced3c5f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

What did you do before the bug happened? (Steps to reproduce your issue)

1. Create an untracked file and modify an existing tracked file
2. Run: git status --short -z

What did you expect to happen? (Expected behavior)

All status markers have colors disabled

What happened instead? (Actual behavior)

- Modified marker (`M`) appears colored
- Untracked marker (`??`) appears *uncolored*


Related patch:

https://lore.kernel.org/git/cover.1260025135.git.git@drmicha.warpmail.net/T=
/#u

git version 2.51.0
