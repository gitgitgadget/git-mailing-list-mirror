Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6663FBB2
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141054; cv=none; b=KLVM4exD8U7ElCfXMno1Z+IpIBuQ6kM22OS9Bv5Q6nt34HMTkShPsvslbPngY9aGO2JH53sj4cETuzNUc707sYB1lwDntC+vH3/YoBg5nAKQ3CN3HuSuu49FSoWg6bvc7Vr98fTCIqGislAOYtZZ6gakTA6CdKYPk5G1j8nles0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141054; c=relaxed/simple;
	bh=yoQawzFn2cmtL9KpE0dcEPDkA9DT3ERej0c9VP7y4U0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i89iLwOcsgIYQMRmzUzYrkyymiB9HeKOfuUVZabsT+IQoreUtIqMOe6qpeeAsMfqqgwzELjq1MBcwb2dzYUiN9OeCE0y2YLraU17ZW11v9toARY7uennl5JJHGbk+cbTvsy/PQocAQv6Kauqb2M/rqm8g2kpGPlx+rP8fyXOcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YcBYJDGk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YcBYJDGk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D48552C75C;
	Wed, 28 Feb 2024 12:24:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yoQawzFn2cmtL9KpE0dcEPDkA9DT3ERej0c9VP
	7y4U0=; b=YcBYJDGkSugcANfOPiw1E9Ma5uRoQ5ATTgB+n8aZ8WJ3Ec5nVippuZ
	BQ030uU0UIlEDfE/UpM5RqPC89sc9Z1fhUhA088EArC+WibeI2Ip1DYUryHcfkIq
	BWDY5nQqW432ywg6aBbNu87zrDeeWglXJKJv+E2j6FqWEPFcMLQVU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CD1052C75A;
	Wed, 28 Feb 2024 12:24:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 649D42C759;
	Wed, 28 Feb 2024 12:24:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH] branch: adjust documentation
In-Reply-To: <xmqqttlsld4t.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	28 Feb 2024 09:20:02 -0800")
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
	<e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
	<xmqq8r3lnzp0.fsf@gitster.g>
	<2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
	<ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
	<c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
	<be91f3ad9305366c1385c2da4881537e@manjaro.org>
	<xmqq8r3g8caz.fsf@gitster.g>
	<35738a93f5cbace5b3235ce614b7afbf@manjaro.org>
	<xmqqttm3ouxy.fsf@gitster.g>
	<16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
	<96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
	<b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
	<d1f928b98238a60a96bee0d3f410deef@manjaro.org>
	<xmqqttlsld4t.fsf@gitster.g>
Date: Wed, 28 Feb 2024 09:24:01 -0800
Message-ID: <xmqqplwglcy6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2B266D44-D65E-11EE-85EC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The current description section talks about option and its arguments
> without showing the syntax, making it unnecessary to be extra
> verbose.  For example, we see something like this:

"unnecessarily extra verbose" is what I meant to say.
