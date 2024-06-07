Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B0D27A
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785197; cv=none; b=PsGzCcbxwmefiA74t+QpBKWC8B6Q3tD6yH6zmBRif2iiXStUhBCB2Bh5OUR/Pjf4FsUjMeEewXPJCd9468q02HTDkSZZkAfabfUT6sstMrxoBCCskj8qscWC60IO071GJQWhVrbL9RnTBnD9utXobZl1uOQgm2Sp/ChRhZmLjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785197; c=relaxed/simple;
	bh=Wa8nEKsZbnlCDWZP5EcqrOxrnoVHQeKaZffhuwRI+b4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pwkpb8BLQHrcAj4TZGi3fjj9aOlAPVMUNBPxJz5qZr+4tZPFU/yo8CfIAZirAJ0iyJfn566utvjQlpEEFfftvcJkLs0YTHLrL2uS97gTaSqJJbf43nCeMk1lY15qC0RWL1Lo8TpVSQSBAy1Z6SeiA7fMNeVBiXIEzhfhI7kiYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZDb26Y4y; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZDb26Y4y"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5844030377;
	Fri,  7 Jun 2024 14:33:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wa8nEKsZbnlCDWZP5EcqrOxrnoVHQeKaZffhuw
	RI+b4=; b=ZDb26Y4yuCVbRvJMy1v/Ff94sIxK/fPaVMVAarasdboG4AFLpg24Fc
	nYO9xJZEP+wlC77w1rcHpYHkOMEoUhY8W850To6Kl5t+U8NuViWOsR/FprAWoxt6
	cBhTPL3zhlwWMBYKYxwiML8TNtixsW0ghFgdsUVL2pXEOBc1uQKiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F88830374;
	Fri,  7 Jun 2024 14:33:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B855530373;
	Fri,  7 Jun 2024 14:33:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 00/19] midx: incremental multi-pack indexes, part one
In-Reply-To: <ZmJBAjraBh6O/G1d@nand.local> (Taylor Blau's message of "Thu, 6
	Jun 2024 19:06:42 -0400")
References: <cover.1717715060.git.me@ttaylorr.com>
	<ZmJBAjraBh6O/G1d@nand.local>
Date: Fri, 07 Jun 2024 11:33:13 -0700
Message-ID: <xmqqr0d8d2mu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 66DAD18A-24FC-11EF-A646-6488940A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I forgot to mention, this series is based off a merge with current
> master and 'tb/midx-write-cleanup'.

I think I saw "am -3" fall back to three-way at around [17/19] for
t0410 while applying on that base, but it wasn't anything "am -3"
couldn't handle.

Queued.

Thanks.
