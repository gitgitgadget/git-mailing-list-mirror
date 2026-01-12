Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188133C50A
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251107; cv=pass; b=T1Roz75t9PZBdaBVVRT2CKadkp4ISEM5cWoZ9q46cEhCzY3CSM+s8LEPGOU+J/ML67RZksAMaFGACz9QN1fxkRTO8qguy3wrCASh7sGHJI5/X5yeo6Fw2yQ10fKQM7YzgmSB/DvZ4sUhfeogR6KAQlza3HV8InJObFm9QCN9tdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251107; c=relaxed/simple;
	bh=qLvwXvLTJ9yE0L6P4tjXwuS38/sRqCKFEivpGnUWIvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVdRgbcyovc8HSpqjc+um8SmQ1z8U49bgrLb9U/xp+tXtUoBgnG3h3p6dk8+VkgEtC4imQ/mebB9SOk8sZHxWdpc1fiaFf1khqf5EROXXoiAVbCwNaYpjdpzgX1b5LpwI42Y3UdUEQvN0a6yipmMWmg7fyrofuLmkfQJAHiWQYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=P7mW0b9o; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="P7mW0b9o"
ARC-Seal: i=1; a=rsa-sha256; t=1768251090; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XkbLyrOoamo4QYU55C98xkfma1sdMJ+j7fq5XufuQKE6Kyr++PMusLNalLqnvyTAwoUGxQD0ALSjVoOytIf1QZeWOv4NVD49bfE8+jHBQr5cKFVop1wbhUYjOqICftvZhZ6gCJ88yNEmcxhglZpFjwsSTeiHNgAMM7MnUHMKcYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768251090; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AmmOVmrtT932aKSHTjE2sI4ry2lY+235puegu2X+s1A=; 
	b=IlFewMAFJgcLxr7tOffK2CW9u3FLx0gkHJqqP5h5Se7w+wJG9gHfpw/BZNF0kOJpb5WpPDJJtHnM2b0oPKo4rsXMamSAFhyG9pfGOxRslJAS0FL9euwjcPIAAmNoI/2RaySGvnset23y8UB3Qwm9ywx/KtNMBjo0l4zH9P8bxHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768251090;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=AmmOVmrtT932aKSHTjE2sI4ry2lY+235puegu2X+s1A=;
	b=P7mW0b9oWNfFrj2MqbUcNwAW9Kqb0vxsb+oqiCI8Qx+WA+IpHEAlN6kP4g8GzHgp
	2nZalMwxPOfRmEVWnPZyzw+RyVgXBcPO1VtcCCWkzzgKWRn9M4JNXYBI0aUKjEpgdi8
	vPqclBOrd2l5UHJLSChyRwqtOhs+0nZqN51hERfc=
Received: by mx.zohomail.com with SMTPS id 1768251088508286.1766042533202;
	Mon, 12 Jan 2026 12:51:28 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 00/11] Add submodulePathConfig extension and gitdir
 encoding
In-Reply-To: <xmqq7btmmvqn.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
 <xmqq7btmmvqn.fsf@gitster.g>
Date: Mon, 12 Jan 2026 22:51:23 +0200
Message-ID: <87344ad06s.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 12 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Changes in v9:
>> * Replaced git config --global with test_config_global (Patrick)
>> * Split die() messages to multiple lines (Patrick)
>> * Moved some of the whitespace fixes added in v8 to the commit
>>   which actually introduced the whitespace problem (Adrian)
>
> Thanks.  It appears that we are getting to the point of diminishing
> returns, perhaps, in which case we should declare victory and plan
> to merge it down soonish.
>
> Again, a report like Josh did previously about this not breaking the
> users you care about would be very much appreciated.

Agreed. The logic is basically unchanged since v7, so I think we could
go ahead and merge based on Josh's report on v8.

A big Thank You to all who contributed to this series,
Adrian
