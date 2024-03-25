Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362076E5FE
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389012; cv=none; b=OGMYmdvZ55o57i2WB1+P5PsGshTdYUklwBgzlN2LDvYzpk0H3jqvCg8u4Ik5hlzkfzMHk5fS3HWp0aIi6b5MSejo+U7g+xmrepKFlYkgVxRSHSFg2c88ND+gj1+8o+7yjAOlilUu+4AJynkoe06I0Z/gvWZPB3pBpZXYywlJ+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389012; c=relaxed/simple;
	bh=78FTMMzIMIs8ju0ePQD3/PHDlWyAO2MHZuTd+xMbCAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=buglqJqlOtFsAI0BcyggwxaHEMgDf0lXJs+4jsreZ7tQyUKxkLoM4PR1OssOlA+0a1cVFH/sV+IRSQ3oVi1VEQTGG6bFiKlkq7wMuyKh3bfY+8tf3XPpG40oGOoZrFYwpD5U+rVeGHULF7o+EK96jK6a5MCSo9lwSqWrultARAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWD2p0mB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWD2p0mB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC4981E78A4;
	Mon, 25 Mar 2024 13:50:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=78FTMMzIMIs8ju0ePQD3/PHDlWyAO2MHZuTd+x
	MbCAM=; b=BWD2p0mBGBmJGOd53c6+kHDft0Yd6yHh5Zw7FXQg2iR9+GRQMShM/Z
	bo5zx9AiwhrM9sFxSx6l7+OHXx5sSF/Z04dUKoReuj1j1dqWh/4Nj8zuADzqf6r8
	5QKfW9yVZuwuZgCCYJ0bLJ3bouGCZGhnoylvFz1NJkU9VLG22Bg9M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C39191E78A2;
	Mon, 25 Mar 2024 13:50:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 739A31E78A1;
	Mon, 25 Mar 2024 13:50:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
In-Reply-To: <cover.1711368498.git.dirk@gouders.net> (Dirk Gouders's message
	of "Mon, 25 Mar 2024 13:33:31 +0100")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 25 Mar 2024 10:50:05 -0700
Message-ID: <xmqqsf0ekxpu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1EBFFCD8-EAD0-11EE-BC60-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> The 3rd iteration for this series.
>
> I tried to credit Kyle's suggestions for 4 and 5 with Helped-by tags and
> hope it was adequate to do so.  Actually, at least #4 was a lot more
> than a Helped-by, I would say...

It seemed adequate, at least to me, but I'll leave the final say up
to Kyle.

I left a few comments but overall the series is looking much nicer.
Thanks for working on it (and thanks for reviewing and helping,
Kyle).

This is an unrelated tangent, but I wonder if we can come up with a
way to find breakages coming from API updates to these "tutorial"
documents.  The original "user-manual" also shares the same issue,
and the issue may be deeper there as it also needs to catch up with
end-user facing UI updates.  In any case, we somehow ended up with
two more "tutorial"-ish documents (MyFirstContribution.txt is the
other one) that somebody needs to keep an eye on.

Ideally if we can have automated tests, it would be nice.  Perhaps
sprinkling some special instruction in comments that is hidden from
AsciiDoc mark-up to help our custom program to assemble the bits
into the state of the tutorial program that the readers should be
arriving at at different points in the tutorial document, and make
sure they compile, link, and test well?  Or "follow one of our three
tutorial documents to the letter to see if they need adjusting, and
come up with a set of patches to adjust them" can be listed as one
of the microproject ideas?  I'll leave a #leftoverbits mark here, but
what I want to see discussed (and eventually implemented) is not the
clean-up itself (which can go stale over time) but the strategy to
keep the "tutorial" material up-to-date.

THanks.

