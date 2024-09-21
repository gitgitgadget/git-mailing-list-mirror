Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A3257B
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726882724; cv=none; b=IU7Sx4n5Ewr5ggIHS3wz10GUzaDGgov+4yysjn4vQ7LdVRdYYfTSKQsAgmBRujmTpqC58I9DN86XC6xDxAS6A15H+kFwKa03uxGYqNmpbRXleE75JuUiyat/YDDgnTQvdoto/vfray4QoUDatmFPj79+hSGfUgLLHyWb9/GO/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726882724; c=relaxed/simple;
	bh=7uVcpEbnTuKRHFs+qcfJk5w9L5EHYGYZExHqqg1avNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENALKcsRK1hM8rJwUTemHZbaRj8h49FEOX0Osqk7d7ORI96KogRrbAn4z3p5IYLB/3/TRKDjATYZ+Jnuxyv82x0VDzhhBaqmcOHYlN9+V8aiBdM43DJ0rjAU3xqukr7eNQVq8phYXOLRFIiNCjwz4gvw84ZedVi1TMfnb9OANj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G2Yb6DQ3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G2Yb6DQ3"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 141CB22E5E;
	Fri, 20 Sep 2024 21:38:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7uVcpEbnTuKRHFs+qcfJk5w9L5EHYGYZExHqqg
	1avNI=; b=G2Yb6DQ3VOLxUIjrq7yG09LGW9sO18SwaoiXm8gx6ES1m9Pr95JGi0
	U57wVZb1C/s7AGjHTKP93PaczCYQQhGKBdl2KeOBjXL86t621Lb9777qpvobRMEe
	APyJTNJlsRDZh0IaFS9HQFJmjZkfc0EWGlJFQlGKYtJ93ym7mi3Uo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C84C22E5D;
	Fri, 20 Sep 2024 21:38:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72AAC22E22;
	Fri, 20 Sep 2024 21:38:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
In-Reply-To: <4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
	(Josh Steadmon's message of "Fri, 20 Sep 2024 16:14:26 -0700")
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<xmqqo74rxvw0.fsf@gitster.g>
	<4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
Date: Fri, 20 Sep 2024 18:38:40 -0700
Message-ID: <xmqqcykxbxb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B55F736-77BA-11EF-BBB5-9B0F950A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

>> So, unless there are objections and people want to discuss it further,
>> I'll mark the topic for 'next' soonish.
>> 
>> Thanks.
>> 
>
> This still breaks on MacOS, as `sed` doesn't understand the '-E' option
> there.

Thanks for a report.

What is sad is that we are seeing this after the topic gets very
close to 'master' (it has been in 'next' already for a few days).

Perhaps nobody builds documentation on macOS, in which case the
breakage may be totally acceptable?  Is that the message we are
hearing from mac based developers?

Grumpy...

