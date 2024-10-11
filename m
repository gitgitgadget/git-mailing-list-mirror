Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680F1CC88F
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619439; cv=none; b=M7Op13uSWvpCk61Lu/xkHYagz0bgULTRsv1bsQrppxVnEjjWnUcWXRC6GknmVxKANNJL089k1k2VNgtG4O6b0i5JbdSWXpeKbYuCDGQQ/6LAQCfzaBZH6bSZvi6D4TH5vm1gKzFVyFQSW5kNznhotvqYLgQXK7N5yipG237XUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619439; c=relaxed/simple;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKG8YL5f1V42ZG8tCCc52AJ+OaByK3wn9h0u+8Mm1NRSjpjQ2QKkX5lcbga57FNZf6vMwmZ68h96gwCtsQr1px0SRfxqYJ4UpZ+jRGG1HlHv/FTWl53jecErgSr5w/FTUGYdAAyAzMi3xaiAwoRKcfXU2d2I/YBQZbLbm+4qYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=omGi8Uq8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="omGi8Uq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728619429; x=1728878629;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=omGi8Uq8p2q086jiM3c/+ASHeiKn70mqr6qEuBePDncLB8+n1SSG5cDADj/vKFl0h
	 4WANj3vxNKHsC1qpcOf0wXK+685GJ4J9c7v6JqvmprmjhWXj+WXSr+yupn716AnUKf
	 gN1u+8/NF91ikuK1HxHsosUiciovbB38B7NIcXrddKnw5FJbFMNLF5mkzMepEtxMpO
	 Juqd1As9xsJv75fKLHBB9nVmIdG8ecZOAswurkySHDSgLthSHohmNj2Ym8dHP1xCQv
	 t+grt6F8g0fSg4zn309URMTZ3v52W/+NhOGM/Rfp+hAm3WsnHPje1zY0KLFayuB0F3
	 ioqZKkHewHVYg==
Date: Fri, 11 Oct 2024 04:03:46 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
Message-ID: <D4SOG00CK1L8.E3J8BLFR3ACE@pm.me>
In-Reply-To: <xmqqfrp4onjd.fsf@gitster.g>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me> <xmqqmsjexkcg.fsf@gitster.g> <k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me> <xmqqy12xqehd.fsf@gitster.g> <oUBKv4JI3Bf1nqAFU_C-HDl5vkZC6mg8mb5F0HB7akXC6n0T1ddV0LiOCqY_AGHCyr9_W7gs2EyTGqIihz89ciBbL61UFwznnHcYRNzfGLI=@pm.me> <xmqqfrp4onjd.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 2250c167864d46e925858f66d5251b308aaa08df
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Empty Message
