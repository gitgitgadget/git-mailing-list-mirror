Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF13659E6
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630736; cv=pass; b=Uhur09F/vGNIU0efBscHSsVuzPy5yC7E0lDoLIcAsu1mDc6ov7As53olh+Rg/dmDt9SpUn8Ouraq73Lh/zxaYTDBFf26QgLQCWQ/+kEvYFRvmPsNYxWPXBuSUy6je+PfPhBgn+YlR09ZrLPJ7pUZpwKaimK9aoqcaUWd+mQ3i8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630736; c=relaxed/simple;
	bh=Pw6NEeyi7QbUskWLW5zHY4PN7SGw1ak1Kl/yQeYCRlo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2A7PWM5M2WLMTCu3/SrZPmAT78bQDni4y0vs46tZ1GxVB3NOYzse5bZIVhTVsddGwCkiqepfLIuPJj4RsaXKVal8GiBJCqYOjsQ2wBmY9k187DPA1hMxZ6fJfis0UOuyC6JdoDLUtAGKY2to4K6Ai1h9iDs1KwChuDjylySSOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Flu1QLJB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Flu1QLJB"
ARC-Seal: i=1; a=rsa-sha256; t=1770630732; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nYpRPAsMog0VkYkV+iiEI/AoWfX06/XiUS7lWstmdTs74aEoknRBWh9V4ccoZ63gj076jcrwqE0nkeAv+f6246ZlHIeR5DsiyROqqBLLP63bBOp7NhEnIAtNagpUBqkCJ2pxI5l5Hsv/22pf0iqr+dK1Bs9Qy+cmfCRS00CEhT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770630732; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Idx/knAGhyhc1wzDGXMvLvrVIvs7AACQwL613QKoseE=; 
	b=PUq8zHMMNb5YHJhcsTF6qW0dnS7EfijDqraeHffHWckMtexCtm2uxX5waub0MYSY3VkZN4ycCpOhXL5rgmRzZ+zLaAB3XHNsPwBixqFeHmdtBuQpCaqsKaUZ492O9AwLaVazKEAvQ+CbGEqT7nnDG3lOTJgCVqaFntsqJCNiWhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770630732;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=Idx/knAGhyhc1wzDGXMvLvrVIvs7AACQwL613QKoseE=;
	b=Flu1QLJBD75btcK9R/T7i0F5u4RMuTD5skHT8teZhCN3VIKc9Ag4l/AkAS7/wVlR
	P94nFJROMHOhEErJpJ143j8bkaaJIc0fhCCZRfK0hTQecsDQdfw1ZfLval1XCHnuPln
	JtKts029ZQP9KesdJajFIf8jZG/DA6fIC+RuIrdQ=
Received: by mx.zohomail.com with SMTPS id 177063073035853.984346594668864;
	Mon, 9 Feb 2026 01:52:10 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #03)
In-Reply-To: <xmqq7bsob0wo.fsf@gitster.g>
References: <xmqq7bsob0wo.fsf@gitster.g>
Date: Mon, 09 Feb 2026 11:52:06 +0200
Message-ID: <87v7g61by1.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sat, 07 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
<snip>
> * ar/run-command-hook-take-2 (2026-01-28) 12 commits
>  - receive-pack: convert receive hooks to hook API
>  - receive-pack: convert update hooks to new API
>  - run-command: poll child input in addition to output
>  - hook: add jobs option
>  - reference-transaction: use hook API instead of run-command
>  - transport: convert pre-push to hook API
>  - hook: allow separate std[out|err] streams
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook API
>  - hook: provide stdin via callback
>  - run-command: add stdin callback for parallelization
>  - run-command: add helper for pp child states
>  - t1800: add hook output stream tests
>  (this branch is used by ar/config-hooks and ar/parallel-hooks.)
>
>  Use the hook API to replace ad-hoc invocation of hook scripts via
>  the run_command() API.
>
>  Comments?
>  source: <20260128213927.3026875-1-adrian.ratiu@collabora.com>

If no one has objections, maybe we could land this to make the other
series, which depend on it, easier to test?

Many thanks,
Adrian
