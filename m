Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4043179
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167975; cv=none; b=nJvsdTfvVqnvL0AiV3U4S+ja+rH6y/m2IeStSWafZ78ddgZgdvclJiJ4iLXv2eLmsuOps70j4IRzJ9/ikcESznNOiqv37a3ILTEHgCBPB96u7IypBOlIpILVvNdwQaZFRpxx8wl4AA4O0VyeZm/RrRUOBMI1HCOD4y3/cczdtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167975; c=relaxed/simple;
	bh=/JhH1gPn+hUevQQzJk/Vs+wJDLymb25xpsIRIIMxv1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8D4bOBtR+gM1Xq+dvVVWm9kJs72tJ9vR6+PIgx1hhnZXvfMBVrvn3Wuo+J96QYF2loZ7zR39gETr12dexn9OtGLVtioJPSMOKzHY/fAiDqYGHHjvME45u5qSlSa9O6t4BXu5PSnPCS/8LZP+sA9UphRVqx1lwS3IFMDPvUvHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S4UVeKq6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S4UVeKq6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E107F2D92E;
	Tue, 20 Aug 2024 11:32:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/JhH1gPn+hUevQQzJk/Vs+wJDLymb25xpsIRII
	Mxv1U=; b=S4UVeKq6ImdiNiOXjBW+kPzX/kW0emEWhJ/xDiHWMEpxBrQ2IOY8CZ
	S7YxQgAUzYIYTowInF2vRZCyqayXenBngM0ALoyNBbUu9lqvMgsYThZGMkB+wFEx
	dfq9VMksoC3poEWS+Thy8E6Hg2M17e9jZBs7+V+v4J0mEvhrI7Crg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D899A2D92D;
	Tue, 20 Aug 2024 11:32:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E4E12D92A;
	Tue, 20 Aug 2024 11:32:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>,
  Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v4 0/8] git-prompt: support more shells v4
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com> (Avi
	Halachmi via GitGitGadget's message of "Tue, 20 Aug 2024 01:48:24
	+0000")
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 08:32:48 -0700
Message-ID: <xmqqr0ajb467.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75A22D66-5F09-11EF-B2AF-BF444491E1BC-77302942!pb-smtp20.pobox.com

"Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This addresses review comments on part 5/8 v3 (git-prompt: add some missing
> quotes) to fix minor wording issues at the commit message.

Good.  This exactly matches what has been queued in 'seen', as I've
fixed these typoes locally while queueing.

> Hopefully this is the last wording fixup.

;-)  Let me mark the topic for 'next' in a few days, then.

Thanks.
