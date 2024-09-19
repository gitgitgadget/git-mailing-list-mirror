Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B704A08
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726705862; cv=none; b=nf7jXG+ppbMvgcfKTicbwAiLLUcRPdIcEbjaLtyyuqYCvqFUUBHb6ZE8UvUN7OWTGJt6bkQ792EUnLF7kWPRS5TycDFpRpgr4pZgkAd+KO0dIjofOexPX/4P6ESBhhZb2vERb8R8sdKcncizu4UJy1dVBquY/nFnJ/XXlZIK3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726705862; c=relaxed/simple;
	bh=Zec8uzx546fNabBPmJD0sCDmihluRRSa2p0gmp4W3qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xb0TJebqUN/LuV4QBh1AAFOuUsKlOrXFHNIRIFtWBsZG0psgaaR+l9rW++9C4pO2vcNP7FM+im8w0Hvm50KU2EYiCXZq8AEA6E/VOvKkcTL8/z8BPtkEqd0TZIbGHnGdbmoqNZpNJFNlPyVhpx4QYlLuaOjB0ahWltYVYWLuRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LO47Wo8y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LO47Wo8y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85A0C36146;
	Wed, 18 Sep 2024 20:30:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zec8uzx546fNabBPmJD0sCDmihluRRSa2p0gmp
	4W3qc=; b=LO47Wo8yjPg/mzZX/npBqRcsSMklTGJXJMkuuV3CurcwuylaGgi0N6
	GF++NmeIB09ORCb+wcoL9k+l2NW9lPLD906D/PnnEQ4vwM6i62HkSqv2XerxK0TR
	yopb2+glIDrPuh0Y/ON+sZtsmUIsnPyLpIfQQa8NQtKfoJXhyeCA4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BC7136144;
	Wed, 18 Sep 2024 20:30:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA25E36143;
	Wed, 18 Sep 2024 20:30:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: rename clar-related variables to avoid confusion
In-Reply-To: <pull.1795.git.1726687276169.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 18 Sep 2024 19:21:16
	+0000")
References: <pull.1795.git.1726687276169.gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 17:30:56 -0700
Message-ID: <xmqqa5g4a3i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 706D806C-761E-11EF-B23C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In c3de556a841f (Makefile: rename clar-related variables to avoid
> confusion, 2024-09-10) some `Makefile` variables were renamed that were
> partially used by the CMake definition. Adapt the latter to the new lay
> of the land.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     cmake: rename clar-related variables to avoid confusion
>     
>     This is an add-on for ps/clar-unit-tests to let it build with CMake and
>     Visual C.

Thanks.  

The base topic is expected to graduate to 'master' in a day or two,
so this is a very timely and welcome update.
