Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA7217F22
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895706; cv=none; b=i6/ebJIRWG2gXD6sKo3i/WVOpitVU/zmuXa3QShjvkuhvI7aLi3oE9+ZmYLQQR69xmsXF78+zWO/+Key2/KsZdIx/t/3iosevoPs8y3GXI8IRa03axUgjYiSk726MSab1SaLiTeWPF/KM7TlmCX74Upa8+ux4toaYGsgtKzU8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895706; c=relaxed/simple;
	bh=bohwqi+2gDed7skxbtLycbqJQ2CKNKH3lGmcnBE2ltw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmBOBeS28sk3uL1c69ouqacTHcoJSI31JtkVQCe0cplh2adlPd8U1pErgyq/Fo3H23WQ3g856ocm8XkOPT/sk9sPUA+JQC35Q80AMKwv2Z+YSJCVxVvoEQzRIlPfFrPomRM5rsymM993PnGhdhOEe3mox5+3XOpz/IpgP7GSYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mweVxtJX; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mweVxtJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729895701; x=1730154901;
	bh=bohwqi+2gDed7skxbtLycbqJQ2CKNKH3lGmcnBE2ltw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mweVxtJXFlx0gFimSl/9c7+ylPkl9l5KxiAd06OAv3cEHIYGf+jAIoX/ahFQny+BF
	 Mz7lI1BukMGanKN4/287UnrE5lvCZmGuuggrk8TX88URTr2/QK6FDSfOzStL3ImF+T
	 6kRJrK9L6hW3KxjHFptZ7W2uPHFQdCLDAyG1+O8gQxNb72af5ocSQqFJQLaayK2J9f
	 nh9QpCRHkCGC0VLeaCfcsVIj1O5mvsG1OgtSUICIWA1TnDB9+3yRD4vhZmwYah0Atz
	 U7xviLvLu4azb7S9opguxtfc7r1Q8x2a+X8BttVXy8kKVoPSQVC7B+sUeaUzRBlJ8z
	 w7Vma65qY61UA==
Date: Fri, 25 Oct 2024 22:34:54 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] Optionally link worktrees with relative paths
Message-ID: <D558UCES3M9N.2UUO7C08Y49DG@pm.me>
In-Reply-To: <ZxwPwfJnEJ8C/rkz@nand.local>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me> <ZxwIEcUKMELmxeMh@nand.local> <D5572ICCKQXT.3UQ8AJ2GSUZIP@pm.me> <ZxwPwfJnEJ8C/rkz@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: b2e084af60b558628e344cac6334dd44adda7f04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Oct 25, 2024 at 4:38 PM CDT, Taylor Blau wrote:
> On Fri, Oct 25, 2024 at 09:11:30PM +0000, Caleb White wrote:
>> Ah, I must've missed that---I was in the process of working on v4 and
>> didn't realize that it had already been merged to master.
>>
>> I'll send a new round based on the current tip of master.
>
> Thanks.
>
> Looking at the dates, I should have held the existing round in 'next'
> for a few days longer. But I figured that the existing v3 was already in
> a good state, and hadn't heard otherwise since the original thread[1]
> was quiet.
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c=
45eb@pm.me/

No worries! I had a busy week and didn't complete v4 as soon I would've
liked. Here is the new round:

https://lore.kernel.org/git/20241025-wt_relative_options-v1-0-c3005df76bf9@=
pm.me

Best,
Caleb

