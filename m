Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE20219E8
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765611736; cv=pass; b=ZVwhIVMZ/lqAmYV2k7aPuFYpsgWeBSLi/L9Dsnl+BCp4cqYzP4BcHOOrhupuzf5pHCmuWAGHSf0UjRVTumwv6D8qa/mpr528oV4IXNo2sraCk37my7RoE7FbBKSCBAPRviPRPADqhHd36Rb/q9925SbE0isEK/o8sQwMQaLHj0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765611736; c=relaxed/simple;
	bh=jvUKfky2duh2uN9mV+Umx4X2L0ul3dJFowc8bOPacSs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XxurzbWtQfomx0PQEeOwH88b2mC0bl+Lr2KNyYpIIUq55lm3QPbrXaWiF4CpKCc05EFSsW+Z626428FnH/BMNN/LxylmTh318qpmhPflga0vz00TWmVnZ700cVL/McqMzjDf4b6PAjuen19pD9Ywc9o40FCEu2foFZ3YWp83Ke4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cgGpD1bm; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cgGpD1bm"
ARC-Seal: i=1; a=rsa-sha256; t=1765611730; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cBGmBy7haTL6Z4wvlP2SWVRHkcA+9JrcM/9HxiIBLqGmXLYOUm3zyRbLRWZ618eshlD5Ve5+eTpNoGTqH8bLVoepw0Xe1uAXHIX1Gj53CSzyq4TjBnKK6jNp1XhVgP84ixwwvAXHJOKzX/kjnkcdQAwL5aAnP3V9DFC36yuZ7nA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765611730; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=QS8pMDwXMBKG/3HcnIRPRL2BnJoZCR5YpVd4z5bzzuw=; 
	b=Z9K6SO3KjBedBR9AAK5o1ILN0vdMWXpLj1j3VFNY/6OonT+145O0Qa7fukyCpnGn58CepnvRsoQ5rnUn/ErZhYRut3EmtN/rC9UYmNDxbENQotZXJ0hu4AHeI3cL6BG0OxvP4HQJHQy6E9MgAfHwD+dsEGEdGDk/G2Y2mzXq7aM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765611730;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=QS8pMDwXMBKG/3HcnIRPRL2BnJoZCR5YpVd4z5bzzuw=;
	b=cgGpD1bmRaynCyBDROfHHptYhQIUpoIHVWTyQZX0CATXEQAMdBr1H+9/1qQx5ojc
	CIdsqM8IOnIphW+SBRuvOgYYJGaRX2mt33J4khmZm2TjsMP4GAlVkc+hMvTgru96ZHY
	tCPrncZuUt9pkbqlg1IymTzzB/yzV8coA2uKQUQk=
Received: by mx.zohomail.com with SMTPS id 1765611727902656.3733529314513;
	Fri, 12 Dec 2025 23:42:07 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #03)
In-Reply-To: <xmqq4ipwc7y2.fsf@gitster.g>
References: <xmqq4ipwc7y2.fsf@gitster.g>
Date: Sat, 13 Dec 2025 09:42:03 +0200
Message-ID: <87ldj6x1ys.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 12 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> * ar/run-command-hook (2025-12-04) 11 commits
>  - receive-pack: convert receive hooks to hook API
>  - receive-pack: convert update hooks to new API
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - hook: allow overriding the ungroup option
>  - reference-transaction: use hook API instead of run-command
>  - transport: convert pre-push to hook API
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook API
>  - hook: provide stdin via callback
>  - run-command: add stdin callback for parallelization
>  - run-command: add first helper for pp child states
>
>  Use hook API to replace ad-hoc invocation of hook scripts with the
>  run_command() API.
>
>  Will merge to 'next'?
>  source: <20251204141535.1986263-1-adrian.ratiu@collabora.com>

I think this can be merged to next, since the latest iteration has been
sitting for a few weeks with no more feedback and all tests are green.

Landing this will also unblock my next series to add parallel/config
hooks on top of this one.

Many thanks,
Adrian
