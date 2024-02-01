Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706E82C88
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813867; cv=none; b=m9Zm1hq0UqkFOiiCw3vWtIkeI/L3VU4cjBIraxdHomMQmKQF3EnM4+gL9qNqWTVv8+GjdVf70m+rCSeKHbiICo/ddstD4RMJV2dHPUYK5uWovkjqWcI5ACBeiVb575hyNBKT/GYHq4qgJjIgmfMiy0ya59PWInr1ssXo6VHvs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813867; c=relaxed/simple;
	bh=8seO5hkE2T5MDz3GzDqgCBwoniEjBlw/hgYx3XrefSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPhOy3K5kAgodfzbcjH8FD8Yhd9q6o/gbFaIQ3HkGf/TJNFe5wrh7aLE7NGzLzB85tSvAbYBlAAFXVUPcjdHoocPay/ZsqUb0at4Yl06f4qrI7pkPIcDVLNywu+7nmvFOqMJCOUtYKs04YnL8A2SHZAUkTrav5R69pYaFmGqXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NVsVObUH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NVsVObUH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 38E6B3BED2;
	Thu,  1 Feb 2024 13:57:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8seO5hkE2T5MDz3GzDqgCBwoniEjBlw/hgYx3X
	refSg=; b=NVsVObUHonCL0UEbtTD0QxDHhEl8jTg76sO8U3MT/kCldH55nsl4XS
	LloWaaOwow3/L/ojk2NCO2YuE0TpBI7nqiUPeIv/EDrfvDiip4MWG5+gHZrqViTH
	gnwkmq9VCsJdfRjD+RcKauvyQUV4zbRCT+1PUOJ+ekUPtszXZFX7A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3126E3BED1;
	Thu,  1 Feb 2024 13:57:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6981E3BECF;
	Thu,  1 Feb 2024 13:57:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 06/10] trailer: spread usage of "trailer_block" language
In-Reply-To: <0a9a7438c3ff39f1434087bf3ed6a9865758c803.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:20
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<0a9a7438c3ff39f1434087bf3ed6a9865758c803.1706664145.git.gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 10:57:39 -0800
Message-ID: <xmqqil38ypuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C6994E26-C133-11EE-B528-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Deprecate the "trailer_info" struct name and replace it with
> "trailer_block". The main reason is to help readability, because
> "trailer_info" on the surface sounds like it's about a single trailer
> when in reality it is a collection of contiguous lines, at least 25% of
> which are trailers.

Yup, "info" is usually a fairly meaningless word.  At least "block"
may imply it is a collection of trailers.

The naming would not matter as much to the API users, if the thing
is now opaque, though.


