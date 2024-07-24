Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11B15ECEC
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841244; cv=none; b=NNkDMJUgrABXeO1bJqwmm6XSvWb0C/Sr9iVEkFNkGe/iPm+s7YB7KSluBoH9ZSIiReYcPu/CTFnG5uMKcxAKEBYbCPDj/6EOx1PSgkj9k6ULx6BX8jHKQ8IbngrE4v4mBUrL2tTg9TCHbXd5yKgEExt2HN6unM+J8wHGhTNxv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841244; c=relaxed/simple;
	bh=XAuUcBIr23E3hRsKCAS982JHQVdLkiwfv3p/vd9Mv1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzGm1/29UmyZPq/ebLVqnq5YUFuoChVFBZoIQYeFbTCS1rtjL7CGQbIdDhOL+cFRT+W4EAfbIWgJlUlmandLOmK8bzODz+HFa4EvzA0b+yn1dKYwLJlgc3nTLeyqdJgY1KBdOzWt1Dx+b8H4KGrzxsvs+IRsuKj1HRS43wjvnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M7ajt/Ea; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M7ajt/Ea"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6A59196E5;
	Wed, 24 Jul 2024 13:14:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XAuUcBIr23E3hRsKCAS982JHQVdLkiwfv3p/vd
	9Mv1o=; b=M7ajt/EaFg3z2mTTa4gIlPTP8gk7fAVJOhGGq46FET9AsgEyLsAz4S
	fBrV+9qaLxPFOYXFSEWK8yn7ks0YR5eVAa2W96hhKqg+ZeLqqwB5taBUB6IPZQLU
	g0bhSVlTAjt00Xf1QOwgxakzKTlL9rKA2qT06uOCUevw4HWRlDfEQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB2FD196E4;
	Wed, 24 Jul 2024 13:14:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A68C196E3;
	Wed, 24 Jul 2024 13:14:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] git-prompt: support more shells
In-Reply-To: <xmqq7cdazu4a.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	24 Jul 2024 08:29:09 -0700")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<ZqAzpYuTrK6L-uyN@tapette.crustytoothpaste.net>
	<992128710.1986532.1721788902932@mail.yahoo.com>
	<xmqq7cdazu4a.fsf@gitster.g>
Date: Wed, 24 Jul 2024 10:13:59 -0700
Message-ID: <xmqqjzhavhk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1ED66576-49E0-11EF-952F-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> For the purpose of git-prompt, I think it should be OK (without
> "local", it is harder, if not impossible, to clobber end-user's
> shell variable namespace with various temporaries we need to use
> during prompt computation) to declare that we now support shells
> other than bash and zsh as long as they are reasonably POSIX and
> support "local" that is dynamic.

"to clobber" -> "to avoid clobbering", sorry for the noise.
