Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8B6FB8
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936070; cv=none; b=uwaYq87Ol6RpJ1FnsgCWXZlWmMnMbm1eTTAxZnglBlcgEi0P+E6bx+DME2c8oT4FrPdlMUNrOK4c16Z+brVeS1W+x4+fKoH8Dc23io51uo7HIPuRQJC+S81kyUr1IAhbIZdCJZK3lYTBxui1SJo+9qP4QoC2+VdK6g7k/vhcQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936070; c=relaxed/simple;
	bh=FhzqvPDPZ6GqIhPkLDPgcQvHEkzfCFgg7qlwVHXthL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mE1bnfWCOrK+vquwC2kDTVzXbH2YFspwMpqYq5rjMhvHlBHVCe/KvJ1/VmCwIMnuLSsTwbG1y/kthJGN6NP8yVS3oJP8y5qVoDHPy7U2xmBsmRQB1YdIhdzrY7R1ofdAjqA8Q0PWBiNOAROBjsGycdLAWWRlQ5JMn1qHcWBEySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r37oyNUt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r37oyNUt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 244B426A8E;
	Thu, 25 Jul 2024 15:34:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FhzqvPDPZ6GqIhPkLDPgcQvHEkzfCFgg7qlwVH
	XthL0=; b=r37oyNUtZx2L1GpNzCmUcpos9OyzwN0hF8xhn8/zRJeXIAYePfgPOu
	xDrSv9PWSzigw9Z9TOHNdFkWyt4RbNwwORvKpHPBYmDrCiQZfCDS2XsNah55uaih
	z5R39QhPMsnZiT6mqDxWffy5S4w2JYJ0g0y40St7Lzt5PbT71p6oI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BA6426A8D;
	Thu, 25 Jul 2024 15:34:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 773D926A8C;
	Thu, 25 Jul 2024 15:34:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
In-Reply-To: <CAJoAoZmKD5su=1-kw7x590zVdkqT1xPMs1VumH1j=aMHtD4mcg@mail.gmail.com>
	(Emily Shaffer's message of "Thu, 25 Jul 2024 11:52:50 -0700")
References: <20240718173843.2411415-1-emilyshaffer@google.com>
	<xmqqh6cmmi8n.fsf@gitster.g>
	<CAJoAoZmKD5su=1-kw7x590zVdkqT1xPMs1VumH1j=aMHtD4mcg@mail.gmail.com>
Date: Thu, 25 Jul 2024 12:34:20 -0700
Message-ID: <xmqqjzh9fepv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E439D5BE-4ABC-11EF-837A-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> It's not quite my favorite, still, because I guess that LTS distros
> could get to a point we don't want to support (do we really want to
> provide cutting-edge git features to a 25-year-old LTS distro, for
> example?). Plus, "just look at everyone else's homework and use that"
> feels a little weird.

But essentially that is what we end up doing anyway, no?  If a
platform is used heavily by some of us, they get more attention
because we would be the first to notice breakage on it.  Like it or
not, the population distribution of development community members on
different platforms would not align with the population distribution
of general public, but without access to and familiarlity with the
platform, and without motivation and time we can spend on it, none
of us would feel compelled to look into an issue that only surfaces
on an unfamiliar platform.  So it is inevitable that "you'd have
better chance of being helped by us if you make it as similar to
platforms that we are familiar with as you can" holds true.

> Will keep thinking on this, I'd welcome other suggestions for phrasing.

Likewise here.
