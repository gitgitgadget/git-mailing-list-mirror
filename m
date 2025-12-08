Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD02D6409
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765183486; cv=pass; b=Ax013JlhEJCnJfKCHAYGMz9ueJl0sijjb3vTxYr4mwYql5ENA67sN5qUkcF5bKCV5S47KCiokIfu1nftG1Foz/t5JVcSCT1bA2E9EP+K/SZVXhCCY8j0707VgxGGjJnV9twmnN2I5u0fjnJd0b+mIuKm2kIuAsB1PmfB7WA51oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765183486; c=relaxed/simple;
	bh=WAeJ1J6wn33NfSJzCbExKcMa852qDGyL8bwwAgtrLF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCUch8r6vNl3xNIFl+eJCa7VjC30i0O3UNFA9SOznKXbrBlOeq6iWe1cpvBdCX7x1yVYYKhpspgGBuvOJiOw9QcIUHA6G61oUPH4MICrAAh5QnWSUMtI2LptVZT/k+/avSMn9QBWi1yy2ULeYAnuZgZP/VLT2F862JMtnn8qaIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=V1i0d5Vo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="V1i0d5Vo"
ARC-Seal: i=1; a=rsa-sha256; t=1765183473; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mUWdJaLcMjmMEYIGXkM/35xHzD/gzplegFNN0YT+qW1iGS8HlzQ0EO4YlnU9Uo7EHZgCddRBB01qbmQ4xfNhwN+Y0lkx3z7EhBq8/RP04WkfZPWa3tUtA9p4PoBWWZTLFk4LF7GrpCzg5RObLYuYDF1xm90Npq3R8yjYnnDnAPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765183473; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LXg0Kk4CEDOxfRNGKZfp9GMExX23UQ4tmUmnFXR0/Sc=; 
	b=ET1Ubv3410aLUF3QK2wTX05gcAPsgemQwO/nxIuE7i0v8aakEJMq7tatlLQqDaUFl0ZTCGJw13GMeJ9qXp3ZPvj5IYUHKwv9SdcH8HZsI4habKySo8Ou8Q3eA5wVqNSdqHcp5UWTx3o5S7ZnjYVHg75A35mzIWpbTcFmc0VxJFA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765183473;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=LXg0Kk4CEDOxfRNGKZfp9GMExX23UQ4tmUmnFXR0/Sc=;
	b=V1i0d5Vos/gFaKhH5a38ocrRGxI//TgI/m4TbIywsXzTWZQA9fDm9Uy7yl3awVBz
	4mio6KtYAbtXwKD7+AqOR042VVU+p/21IZrbbLGL63Lmp0GkG08j5g8C7sSsJywHpUb
	QP+sWR5XwbHokYhgXXtUfFZCCC3/k5sQXvBGReJQ=
Received: by mx.zohomail.com with SMTPS id 17651834712781020.2088196172223;
	Mon, 8 Dec 2025 00:44:31 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #10; Sun, 30)
In-Reply-To: <20251201114336.GA1559453@coredump.intra.peff.net>
References: <xmqq5xaqbxmk.fsf@gitster.g>
 <20251201114336.GA1559453@coredump.intra.peff.net>
Date: Mon, 08 Dec 2025 10:44:26 +0200
Message-ID: <87wm2xuzv9.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 01 Dec 2025, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 30, 2025 at 09:05:07PM -0800, Junio C Hamano wrote:
>
>> * ar/submodule-gitdir-tweak (2025-11-19) 7 commits
>>  - meson/Makefile: allow setting submodule encoding at build time
>>  - submodule: use hashed name for gitdir
>>  - submodule: fix case-folding gitdir filesystem colisions
>>  - submodule: add extension to encode gitdir paths
>>  - submodule: always validate gitdirs inside submodule_name_to_gitdir
>>  - builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
>>  - submodule--helper: use submodule_name_to_gitdir in add_submodule
>> 
>>  Avoid local submodule repository directory paths overlapping with
>>  each other by encoding submodule names before using them as path
>>  components.
>> 
>>  Will merge to 'next'?
>>  source: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
>
> This topic seems to introduce a race in t7450. Running:
>
>   make && (cd t && ./t7450-bad-git-dotfiles.sh --stress-limit=50)
>
> usually fails within 10 or so iterations, whereas without this topic I
> can reliably get through 50 iterations (since it's racy, nothing is for
> sure, but it seems to trigger pretty easily).
>
> The failing test is the parallel one added by 9cf8547320 (clone: prevent
> clashing git dirs when cloning submodule in parallel, 2024-01-28), which
> is making sure we catch nested modules during a parallel checkout. The
> race seems to be in Git itself, and not an artifact of the test (so this
> isn't a race we want to wave away, but probably a real bug, perhaps even
> one with security implications, according to that commit).
>
> Bisection points to 099fe37397 (submodule: always validate gitdirs
> inside submodule_name_to_gitdir, 2025-11-19). Which seems plausible,
> given that it tries to move those same checks from 9cf8547320 around.
>
> It's also possible that the race was always there and this simply makes
> it worse, but I wasn't ever able to trigger it on a pre-099fe37397
> commit.

Hi and sorry for the delayed response.

After a conversation I had with Patrick on the patch series, I think I
understand what caused this: we need to keep one of the validation
checks outside submodule_name_to_gitdir(), to prevent the race.

Will fix in v6.
