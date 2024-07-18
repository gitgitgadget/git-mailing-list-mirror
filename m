Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469212AEE3
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311513; cv=none; b=pjDbjtDZkMFjjmMWxw9m0O0gpZglQFsrbPwNx8G3Xs1/14y+u1Gjcb8rUgt8Rge0iHfDkgK531AZAO/hDQs3el7mtQgmneIC9JWJmluGCvYf7L4U1dQo2F8UnOLCmWErW7Q0O8dxIP9pQpSQF4LPB4hgDXe0VctBRbnG6ily1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311513; c=relaxed/simple;
	bh=Mp5lYsnqJgSeiRKYajPFoDoz5JmftwSD+zbJk6XAES4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nd9IYXoWCZbDZMol2LED7hdz4fvsAJ0Hc8Q0S0M1nKCOpNC4iM5tP4VjzUYyuYtQr0hZPs0gPltrngIdyASDSWFmF5z7Vn2SzqNRh8c9eh4hO8no4xgf3G3joWh7uR20+wpOarlFhd//XAJIlAXey8EL4y3SwsdLHNnZf4gODLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gysr4iDG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gysr4iDG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A7EA03C3C1;
	Thu, 18 Jul 2024 10:05:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Mp5lYsnqJgSeiRKYajPFoDoz5JmftwSD+zbJk6
	XAES4=; b=Gysr4iDGwDBlvRLLQQlSXH8yM0BpTFvBY+WzX8QV0ypGBggveTNF+B
	Pn/OgbwW1mKD9CZUT4dlESRJH3Z42yBRTTKnV/CbfBUc4vmTFnFNsyS80UTxjxcT
	YukGy95e5vUPnm1zskr3cWBKN4qy+g9X9eUzKCdL2rXEpxsTnYGls=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FAD13C3C0;
	Thu, 18 Jul 2024 10:05:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07A233C3BA;
	Thu, 18 Jul 2024 10:05:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  chriscool@tuxfamily.org,
  git@vger.kernel.org,  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to
 '.clang-format'
In-Reply-To: <CAOLa=ZQkxOTSMih+-sKuHRdRFdrzxgiJdzXdyesM3523t65RJA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 18 Jul 2024 04:18:02 -0400")
References: <20240711083043.1732288-1-karthik.188@gmail.com>
	<20240713134518.773053-1-karthik.188@gmail.com>
	<20240713134518.773053-9-karthik.188@gmail.com>
	<xmqqa5ilcngi.fsf@gitster.g>
	<CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
	<cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
	<CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
	<xmqq7cdm90h7.fsf@gitster.g>
	<CAOLa=ZTjHKX3EMbVu1_bjdDez=3aODZQYY4npKrCY-7ZRXN1hQ@mail.gmail.com>
	<xmqqle224npf.fsf@gitster.g>
	<CAOLa=ZQx4UKMfq7q2GMV6nYQGKeCj0dW_P4kG7yDTcdo--1HHQ@mail.gmail.com>
	<xmqqcyne30eb.fsf@gitster.g>
	<CAOLa=ZQkxOTSMih+-sKuHRdRFdrzxgiJdzXdyesM3523t65RJA@mail.gmail.com>
Date: Thu, 18 Jul 2024 07:05:05 -0700
Message-ID: <xmqqv812ztgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BCC25564-450E-11EF-B529-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Sorry I got a bit busy with work. But I did end up testing out writing
> to a temp file and it works on both GitHub and GitLab CIs. Also I found
> some of the rules are too new for the clang-format in GitHub, so I
> removed some of them.

Thanks, both are really appreciated, especially the latter about
checking the features that are available.

