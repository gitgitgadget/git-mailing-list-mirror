Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5D15E5CC
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839285; cv=none; b=YVB04QOhzkj2FF/m5x9fMSjp29+ADSGmZ3FWvNdsRK0QaHj4Wr4nwDn3Az6931r2RfGQXywhe2nOp0uoWJzSdFZq4YYA90vEFo7KTDGG1scItD7F48opqdqDJA9i1I1CrcBS+ZP1AurirIWfTWR45C2jRTW2cuHQLjVYWJobiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839285; c=relaxed/simple;
	bh=rCa8eQM63ksxKNd9W5IpzAZcIhXUwNQ3kSCgz4FutT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UtPj4p04r+ksUNsLikfS7RcrVOHWHxiH1vnWYWKW4uRxnEXD+BV8PpkJe+qfWb7tEQKcmD3FtSMGKHWTFmRx3/4GxDqLkuDHdpZ65sIVRYOfyhidN3aSlWBZsMYmuS2eTuNjwG/55/OtbUqAjS8+y6myN0BUQngH28fMHPK/w+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vmGk9vgn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vmGk9vgn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84A9F1929C;
	Wed, 24 Jul 2024 12:41:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rCa8eQM63ksxKNd9W5IpzAZcIhXUwNQ3kSCgz4
	FutT4=; b=vmGk9vgn1SmOItWRieUsR1x1EhFk1yW0ra7sIlqM9dgrCChJLMLown
	lVt2bWvk9mXQu7WRbB/q7uZCLfe9F7OPCifyQzkth4p/BAoyJ9R05Qwc7JVgVOl+
	vKJ9mIKOja+SSkyv6t3/TcxJM3MGcaoBcrzxs1rUXzGuquMJbMbVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D2551929A;
	Wed, 24 Jul 2024 12:41:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6DB619299;
	Wed, 24 Jul 2024 12:41:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/3] Documentation: clarify indentation style for C
 preprocessor directives
In-Reply-To: <64e0b449936a6828ead98438d621f7e7684546c8.1721818488.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 24 Jul 2024 13:05:12 +0200")
References: <cover.1721818488.git.ps@pks.im>
	<64e0b449936a6828ead98438d621f7e7684546c8.1721818488.git.ps@pks.im>
Date: Wed, 24 Jul 2024 09:41:21 -0700
Message-ID: <xmqqv80uwxn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8FB7DF4A-49DB-11EF-BC44-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There has recently been some discussion around how C preprocessor
> directives shall be indented [1]. This discussion was settled towards
> indenting after the hash by two spaces [2]. Document it as such.

It was settled to have space after and not before the hash, but I do
not recall ever agreeing to two spaces.  I prefer to increment by 1
for each level instead to keep the whole thing less distracting
while carrying meaningful information.

Thanks.
