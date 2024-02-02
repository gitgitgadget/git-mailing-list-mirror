Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9A14900B
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895605; cv=none; b=hD6U5CQxPif6j9PLPX4W/XIlwC2jePa6oXwQchEpQEnm+Mp0XVwzfzkCF9LJL43/WFCNZ0ur9+p13e9nHmPUwvy1q457JXf9+k3Rkp5N9iYu11G59Df8RvDy0VpsSi6oMp/t52i88OTXtI6QQjZVkKxagSYSR3T/22kS1sCfM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895605; c=relaxed/simple;
	bh=946CqXGfhvVQ3lfVnhGFAC1FHd2jPGVeRrUHyLAcanc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fi9UipWS5Om/FudBe4qKKTHQ94iJ4hy8W8PQIyM1EmSvlS57NCnxVGulooLmHbVO4jOcFBmZ/akXcfqX0MH+pzhe7eKMAohiEEcMoE50We5N7Z4jfsyao0Yc4CGSc4a4KnCwCaeAZqmrlnoEPwm+044+mJ9+QqosFUDWX+saibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VmXNA46r; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VmXNA46r"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 281D72562B;
	Fri,  2 Feb 2024 12:39:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=946CqXGfhvVQ3lfVnhGFAC1FHd2jPGVeRrUHyL
	Acanc=; b=VmXNA46rgiyNzXrkMi5R7I6ljDOJPcX4WGyPrn/ZfhDb3x5TXqbH1i
	Hv2fqN6mKR7/Jr9ExxTRkD0RQpFt3tXKzKVj413UKBRIRJHLPtaSSt+7zrGBueW4
	+SV16HuuIXA9AnvFTir3GJRe0iQKno7m6Vhm26j0EwSGpbaDuII3Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2017125628;
	Fri,  2 Feb 2024 12:39:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 581C825627;
	Fri,  2 Feb 2024 12:39:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <009601da55fa$1ecc9580$5c65c080$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 2 Feb 2024 12:06:04 -0500")
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<877cjm53bf.fsf@osv.gnss.ru>
	<008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
	<xmqqcytevmwq.fsf@gitster.g>
	<009601da55fa$1ecc9580$5c65c080$@nexbridge.com>
Date: Fri, 02 Feb 2024 09:39:51 -0800
Message-ID: <xmqq1q9uu5nc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 129FA284-C1F2-11EE-83C4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

> I should have qualified this with "free" NNTP. I have only been able to find
> for fee NNTP servers where I am. The search continues.

The NNTP server "nntp.lore.kernel.org" carries the mailing list
served by lore.kernel.org archives, including this list.
