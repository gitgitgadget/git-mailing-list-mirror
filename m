Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85117383A4
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741862; cv=none; b=HlD3GikvB577CFypcg1K9188BX4AWP8dxHWm4KmolAg5qnNbOE1B6axxz3qiVpVlVZNU/PqG1czIRGcpGySBb6LG9+E1BxHWm8C0MpL4NP4HOTNAthzaAUOVFdR1xQI5gP+HSVKLB6O85O/LJJtLw9H+wmBjyfccpTNSjOvLZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741862; c=relaxed/simple;
	bh=63v9+ZD+IoIz7wR/55QnxMnJC2bsP17L1DcvGYRli3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOjCl1EpTu4EEhCjkJLMBN9ukoxvDqAzWBe2I7ZvUKXD8ml7020dyhM8gTBfylanFRwTl//2tHsIqF7F7ejGVWYaZmttxasIrxx804Tv9/O3DmvK4R8yX2RfzqlggR0M4UZspfBbhceDKDgDSoYhqgPutso+nh+QiVgTf3yGHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w2T8fLey; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w2T8fLey"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E54FE1D951E;
	Wed, 31 Jan 2024 17:57:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=63v9+ZD+IoIz
	7wR/55QnxMnJC2bsP17L1DcvGYRli3g=; b=w2T8fLeyjvaQ5zvYIGDyF3SHC3ry
	W30dCfoOzZKjsxL2S7ShS9ZzIefPaj6tVEAi/XQTFHDwNwrgcsfLV1FNYnv7qtV+
	wDKgRk3R4+mPcTTiplBeg/d8g776u4OOUPba3dDyZ5mtwAuUKtOk9u2pK6GN2hCo
	XEwQpWbWhOXKOQI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC7031D951D;
	Wed, 31 Jan 2024 17:57:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 464931D951C;
	Wed, 31 Jan 2024 17:57:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] ci: update FreeBSD cirrus job
In-Reply-To: <20240131191325.33228-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 31 Jan 2024 11:13:25 -0800")
References: <20240131191325.33228-1-carenas@gmail.com>
Date: Wed, 31 Jan 2024 14:57:37 -0800
Message-ID: <xmqqzfwl2jry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2161E4BA-C08C-11EE-9BD4-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> This will be upgraded again once 13.3 is released to avoid furtheer

I've typofixed this to "further" while queuing; no need to resend
the patch only to fix it.
