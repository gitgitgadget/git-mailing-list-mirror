Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D923C516
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579006; cv=none; b=u7OelbxpMMszS4HyHlLbw7n8W3RqXIPQIrREfdnJZcM5F6jpCf0bb3ImTDMBeD3/gWsG2hEcrEHjIlU7g23MIlUGLTXqHoJlDlgbzHyzv/YxD74gHr4s8ofileU3dJCBz7VZIXuV3a9G1gue9fuOPXQg21FfpN9NyxmFxFrnyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579006; c=relaxed/simple;
	bh=x9HiwmFpzphER5nF4IBOtqGVxnovaJ+wGpGkN+BwftE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVOt+gn7GhVglMl635Tzbp5k830o9XumX5NOv8numHZcQldx6sZtgwH4Si8XCojI59k76xhBwUFQ9XI1WgkUwmXIVhczDVUfli6lI+OKx3eHE+0cLr72mC4F/PKmAagl87pBFsaYW1Kz+YiWTgEIqxGQtWfMQrvwjn88eVibH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=Sym/vzcv; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="Sym/vzcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail3; t=1758578988; x=1758838188;
	bh=x9HiwmFpzphER5nF4IBOtqGVxnovaJ+wGpGkN+BwftE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Sym/vzcvSwIEnEG73pgA02kAGg73+1jBkA2MbMLRxsNwH/ExyoIPJv8zLHOHAeGBO
	 inFGxlFevP/QHwvk4wouVpZTmEeg0QK957HybKHJbpQu4QkDI0+nMoWslUc2DRoRT/
	 mIYEY7XpzaN3DzChSaPfjluUpGPF4viIXP/6T72Uo8v+Bhg+71iDt7ywmBrXw4IlKc
	 tTutHnZnVOf0vqi4wMAukGaj3q5QOMMm3PgxhQdtDuKC0ev6vKoVuxHOeDxJz0rM5h
	 HqueHHRNsvA6f7sxfggbouwnAJo1ugdhbRPU5Q+g7QmH83WnhY9sEe6fcqzaz7iFaF
	 nyCM4EijRjydA==
Date: Mon, 22 Sep 2025 22:09:41 +0000
To: Jeff King <peff@peff.net>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Sainan <sainan@calamity.inc>
Subject: Re: Could Git be smarter about object reuse?
Message-ID: <ZURUr5sfXi0wsjBeXiwAxyNgalVa2ZveXDgoTcexUNOAgcP_JscHvFFDIss4stpsiB2MzUQ_Z30tFrPSgr8W8V02ecfCj4BFFwQqWwJpba4=@calamity.inc>
In-Reply-To: <20250922200510.GC2205919@coredump.intra.peff.net>
References: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc> <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de> <2RWL_muy24EPDZ9wWFx-WZfu4Br_F2LenvcVJbKewfSVYipYM3qmeEIgV-6o4EbL39ZjMXtLHbVFOCPcBdHHVAU-0BrgBtuQ9BdRjS_2niE=@calamity.inc> <20250922200510.GC2205919@coredump.intra.peff.net>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: 518b4bc1179f54ab2f5d076a12d9cebf4128b390
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> git repack -adb

Certainly got my fans spinning for a bit. :)

But I can indeed confirm that it does solve the issue at least when amendin=
g a commit (will need to do further testing and generally get a feel for it=
).

However, one issue that I'm immediately noticing is that if I do 'git pull'=
, I get a new pack that is bitmap-less, once again likely exposing me to th=
e same problems.

Repacking before pushing would be okay for me as long as it guarantees a su=
ccessful push, but it also seems a bit inefficient?

--=C2=A0Sainan
