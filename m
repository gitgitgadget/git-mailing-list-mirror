Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC641917C9
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482754; cv=none; b=jitf1NJ3jtGCpZT6aHZf6e3gaJ+92yI9ZS4X9qe0z5Hby5DDDxlD0klRKBPDczOY8EN1jybRr8qQb/SI0XoSL1Cn7rKsX0KMN9fRjOEo/mbHqnsM9EgRhJxrC8xuEpHQY6rzuYazySjz07wUiVFr6DqbciHOgWRZkBL4Prq5w9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482754; c=relaxed/simple;
	bh=FJ6Ub3ZLMiFLR7VBCESUByEb7MdDPXc4/PVqVFgq31g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qv9t3aaAj3bbKMxui4pGfpnp2VKeXLMVDXu1XzuhvoKUK/06kz+hWB/GBmcCzKNSwsH6z90PRAidcL/mu8bY1EIIJSf+IKRAbIrBsszbdDeXZ/rbkeUS/QY3j4tF3dhtvkJVFHkiZdoKZCQiJmZCcegk9NQz+wO0f/R1hbwpeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q8pdJiCH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q8pdJiCH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1312B1924A;
	Wed,  4 Sep 2024 16:45:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FJ6Ub3ZLMiFLR7VBCESUByEb7MdDPXc4/PVqVF
	gq31g=; b=Q8pdJiCH3P5MwnsfMxusav1vLXydljiZhg/Q+HnC38x6MFdQxUModn
	xYuSQW0/cLIIRVFw1bzL8q2FleI+F+0sd12lUjrjbMdAlbmJyMyWeB9G/kyfRSo/
	hA/WIBdBLUwSpi2ji7MccQgn2QzaBVmp+YmYYc6qRi/4Jqb7rJQ1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F410F19249;
	Wed,  4 Sep 2024 16:45:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FAFB19248;
	Wed,  4 Sep 2024 16:45:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Rene Kita <mail@rkta.de>,  Johannes Sixt <j6t@kdbg.org>,
  git@vger.kernel.org
Subject: Re: git log alias with --all and --exclude
In-Reply-To: <CA+P7+xo9DnTitgVjHzpW1ODwRdFruDf+g+isg5pSHT8f27ASvg@mail.gmail.com>
	(Jacob Keller's message of "Wed, 4 Sep 2024 12:58:34 -0700")
References: <20240904090614.GZ15670@t480>
	<0e0fb1c3-d4f7-413b-9985-d71cb1c300df@kdbg.org>
	<20240904180826.GB15670@t480>
	<CA+P7+xo9DnTitgVjHzpW1ODwRdFruDf+g+isg5pSHT8f27ASvg@mail.gmail.com>
Date: Wed, 04 Sep 2024 13:45:50 -0700
Message-ID: <xmqqjzfr87wh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AC069BC0-6AFE-11EF-9503-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.keller@gmail.com> writes:

>> > > 'gr = log --oneline --abbrev-commit --all --graph --decorate --color'
>
> You could implement this as a shell alias so that your options get
> included before the --all. I'm not sure how trivial that would be to
> do, but thats how I would go about implementing this alias.

True.  If I were doing this, I would at least do something like

    [alias]
	rg = "!sh -c 'git log --oneline --abbrev-commit --graph \
		--decorate --color ${1-\"--all\"} \"$@\"' -"

so that

 (1) "git rg" without any argument will default to "--all"
 (2) "git rg --exclude 'wip*' --branches" would work as expected,
     just like "git rg --first-parent master..seen" would.

Thanks.
