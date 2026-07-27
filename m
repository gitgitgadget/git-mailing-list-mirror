Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5483DCDA7
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143931; cv=none; b=ZHnVI4jvRI/tMtjERPwp9fuz3u5mNEFD5tuPWw7xG19NMi7OgHcsqrwKOWr79fYhNjT6tBlwg6SOZpDrSa08goKiwvaDGDHr2ectXJtJIl+H/fHDaVNiN6gVAxPq/EM/HaI5+dBxNWgT2KuS4b6vAecRHvc/QweAd4QPgP5VnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143931; c=relaxed/simple;
	bh=ZsvE7FfXYVG2MRnwCwO30qITWp4Odo5NsS7rxd3snZg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1fIOARMDw/5U8gduxzsJ5WAUCTWIJO+6VzxdDnqxXh2OW61AWxK6fK1FybcAF1HWJw4W/5OkMm+EuuAqVHRcYHEzwPvftrAow6r3JEjNhlO4SZQVEO2VIqVug6dW3wCGLQPpHUtQ6OMNJJrwbvdyxNOKOT8ynmD3GA43BYakdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OVyoX41T; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OVyoX41T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1785143909; x=1785403109;
	bh=k4R7XiAo4B6QSIRLKzdsoRCPuApVq7qLT9T4OZ4Et3g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OVyoX41TjKZid/m88cCZ5ouDJHEnKghLtKJTjbhyEijZd5PTT9Y3oSqxNY5goUMKQ
	 n2KWuCVth5AhjZ03x+G/yYw0cHL4yvd7TEJdIvu2taTrMh4xN4SMJ0Vsz0yZQw3ggt
	 yGUnTuuDPz7BQ7pea6OOI3HhzYyujz9dc66SLG+4lpitEIqchbESaz9RSofEplT7il
	 Ks03X2np7UgB1YNWCHqU9D2l7cBDRwFrNYX4kI8hXxep6CO443/y057+1kuivAs2XY
	 VhOehyJwPHoU2VRR+c/KEOffw2ktEdzbn6IZliP0GiLPxowPGWjOwU9RivM79g43GK
	 ypibAkVI4NyXQ==
Date: Mon, 27 Jul 2026 09:18:25 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Emin <eminozata@proton.me>
Cc: erik88 <erik88@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Emin_=C3=96zata_via_GitGitGadget?= <gitgitgadget@gmail.com>, git@vger.kernel.org, Greg Hewgill <greg@hewgill.com>, Micheil Smith <micheil@brandedcode.com>, Michael Haggerty <mhagger@alum.mit.edu>, =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH] stash: add 'rename' subcommand
Message-ID: <eMj51mk8rqcQ7OawqFMB15gzO_MX5ScmstepOBExhu0fqazg_6uNi-2Uw1ONg-JULoEu3MzY3kq2fUkQVK_NR36nF1bMVUeg6UHEnJ0BuPE=@proton.me>
In-Reply-To: <xmqqtsplouii.fsf@gitster.g>
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com> <alitkCsplW_DIaRw@pks.im> <xmqqh5lyhlp6.fsf@gitster.g> <allISNh-b6Sc6y5-@fruit.crustytoothpaste.net> <xmqqpl0mbetb.fsf@gitster.g> <amXJcVadL8btF_gh@vader> <xmqqtsplouii.fsf@gitster.g>
Feedback-ID: 142804409:user:proton
X-Pm-Message-ID: 594468ec1eaab050818af79c4672f4f83103ee12
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> OK, so editing the log message for each stash entry is already a use
> case.  In that case, I no longer object to the feature in principle.

Thanks, and thanks to brian and erik for describing the use case better
than I did in the original message.  Mine is the same: entries pile up
with the default "WIP on <branch>" message, and the ones worth keeping
are the hardest to find again later.

I will send a v2 shortly that addresses Patrick's review.  It renames
the subcommand to 'reword' and rewrites the reflog in a single
transaction.

Thanks.

