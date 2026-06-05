Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3C42EEB0
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649720; cv=none; b=CZrGylGAfRNGFqKrLpZNTxK8Vr61pM0dWIDqFEfYaLKc5CMSBtxMLqHWB2FkLRaYiVbvi0/4ifaVc/STzTxFeIGKT0KJpnaWUc7wepBWgphH1aD9oeHYLlboDoagLx0Xj5LfcWZ7I0o639LE8gmkf91E3n0ZGGKi2a8XsGZEFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649720; c=relaxed/simple;
	bh=RiP7x0fhI+ry+stlhlDN2p0SgBPR8gvbPTILDJ5GBx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u24TM7btSygI0YqXMcYGrxPc24kHb1wJluptxYuyqIi270LBtVt9Ro2s1llnZsDmC5tyi9pavUVu1aeGs83jN7v1Giq5rySt+u2dZAZVIr/7VukVXcgYxhP6r+Z1KVYZ+uHNvGtZEHm7zXKyxslr+ph7msq4WtmmarJUajZzWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=Wgi6TewI; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="Wgi6TewI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9l7ugq4hoLlLO+p69Tgy/KOTOB11z/mRZuD1/RWtlxw=; b=Wgi6TewI8kDPjHFzrSiV4ZGMLs
	9yGuloVm1/4m4rZwDH8Tnk9b/t/YFCOUgc21OiCnxEDMnUry8J0xTlyLApEyj8z4i+tBLt2zHGZNq
	W8gyDCr/pN9fYmuhJET3HHoM6ey5uYXvLs85/p5TQtWSAkS2jHcyv7z2JHSXA7KdjSzuPpNXjTG1V
	j/FgRNjxmTcv0aHyMf5OG7BVWh+zhnJZfR43IfkgHDUc4oOr+P8LG3sRsIx0xWuPpAtQeoo8BGVeq
	E/oqT+ZwzzORdS8hbGR+qM2LZFNsP9M94yja49EpOnydCLGbhRHAWdPWFpxWRK5ZmyK7Isc0Ijal2
	h0sRilzw==;
Received: from justin.univie.ac.at ([131.130.3.111] helo=justin.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVQAu-00000007Clv-0NYn;
	Fri, 05 Jun 2026 10:45:08 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=four.local)
	by justin.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVQAt-00000003p0V-3yF8;
	Fri, 05 Jun 2026 10:45:08 +0200
Date: Fri, 5 Jun 2026 10:44:40 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Alejandro R =?iso-8859-1?Q?Sede=F1o?= <asedeno@google.com>,
	Alejandro =?iso-8859-1?B?Ui4gU2VkZfFv?= <asedeno@mit.edu>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] compat/posix.h: enable UNUSED warning messages for Clang
Message-ID: <aiKMeHXOCulPAaXq@four.local>
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
 <xmqq1pfsq8sd.fsf@gitster.g>
 <xmqqqznsossj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqznsossj.fsf@gitster.g>
X-Univie-Virus-Scan: scanned by ClamAV on justin.univie.ac.at

On Mon, May 04, 2026 at 10:41:16AM +0900, Junio C Hamano wrote:
> > Does this "drop support" because you force _all_ versions of Clang
> > to use the "deprecated" attribute, even though you _know_ some older
> > versions do not understand it?  Don't these versions identify
> > themselves so that you can do
> >
> > 	#if defined(__clang__) && CLANG_VERSION >= 2.9
>
> IOW, something like this, perhaps?

Yes, you're right. My original patch breaks older Clang versions for no
good reason.

I'll send a v2 with an explicit Clang version check, as you suggested.

Thanks,
 Dominik
