Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF074BF8
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726899837; cv=none; b=CznAHjjPkNBtpd8V8ZAbd9ES/LlvacjGpFQnl7NzBgbPp8nSuCoCOsNwAKOzimpJ67m60UOWFHZX4OE7JSqLFAtThjNa1+pGVo7pLnX1Js43Di0zv8gq2BFoA8hmefXxhGQghrrIRcMGScBJU/XkCgSQwAntSZ82NeLt9/CZl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726899837; c=relaxed/simple;
	bh=IHqfY/3PekVgPSaCkp5AoivYmnH9OEhAqL9sfmJYr0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuXrIxOY3QrQpbHxEtNF8Mx+IlU34ThiCv1EsCkf/BMPS49lcOydSTxhnGjTzd+bwXQfU6yzfcBLE1poz3isLiogHrqeT3M++8zPVPRBzeKhYQjQI/5CvDJO3D30z07CWi4xYQwDvOSjMyNjQZJ1FiPiJptmduTLP/Wxlz3YRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V3z3SEzJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V3z3SEzJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D50162047B;
	Sat, 21 Sep 2024 02:23:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IHqfY/3PekVgPSaCkp5AoivYmnH9OEhAqL9sfm
	JYr0g=; b=V3z3SEzJZfOQJhunLav+y5kDytI29TUrj4tAuhdDvGu1zQdlQ/LZRj
	noHf29n7gxG4ePcMHm0fSh3VKcQ2RLAY7e+fvPSm1XZW0S8e6U6Nn6weGW+D3BQS
	46t85VmCu35PmWBmngxE9472NrZLRsQLGepwklNTA9avuCWPNCuAw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE7EC2047A;
	Sat, 21 Sep 2024 02:23:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6B9220479;
	Sat, 21 Sep 2024 02:23:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
In-Reply-To: <xmqq34ltbkah.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Sep 2024 23:19:50 -0700")
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<xmqqo74rxvw0.fsf@gitster.g>
	<4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
	<xmqq34ltbkah.fsf@gitster.g>
Date: Fri, 20 Sep 2024 23:23:52 -0700
Message-ID: <xmqqy13la5jb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1329CF58-77E2-11EF-9936-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> This still breaks on MacOS, as `sed` doesn't understand the '-E' option
>> there.
>
> Can you try to see t6030 also breaks due to lack of ERE in the same
> environment?  It seems it uses "sed -E", so it should fail to find
> what it is trying to.
>
> Thanks.

The reason why I am curious is because https://ss64.com/mac/sed.html
claims that -E works.

Earlier I wrote somewhere whatever problem it is it would be shared
with BSD implementation of sed.  But apparently BSD's sed also works
with the -E option.  https://man.freebsd.org/cgi/man.cgi?sed(1)

So, I dunno.  Perhaps it is not -E but some specific construct used
in the pattern?
