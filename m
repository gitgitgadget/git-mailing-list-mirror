Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA034C90
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911483; cv=none; b=nZ89pEchckRHcKG0kFYhL21Ib5a0TMXZsV8XDgOUXJfQRns0VIyZt4wRFv58wrF/QcG2+2IxnpPqDNn2BK4EtiAqT+vE3QexXANEgogMkcWxEZR3ORVYlZ9BTYDX0myGlc2eDj/GsjDajrLXl4cll1kv4XcTdw+1JtelvYbZHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911483; c=relaxed/simple;
	bh=WCixOwmWEeJStQ7bPmZSGmciEzJJMZ911SMCK03TvYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtSETXWE0Z+Can5RKMqvXJsTZcBHtotKG9BSAQLgAr6a+3r5dLCNhghvTGnEMN4bOoOhKgPLMr/seWp0sjRWFiCRW2qY1XhZ3bgPbM98rvHPToV5lXjr+wk76Dp5kPDKc8nyXJHeGBIFvp2TT1248tg0eq/sydK8tvAy/t8N71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P2BVHz/G; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P2BVHz/G"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78FE81DF854;
	Fri,  8 Mar 2024 10:24:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WCixOwmWEeJStQ7bPmZSGmciEzJJMZ911SMCK0
	3TvYA=; b=P2BVHz/GyCBUvAtAWyTS5vhQf/8VerVf7+Q9T15ku18jOI7amTkHbr
	sYE2wFvgvJ6TAlVeTI2V80QUc11Y+I1HPq2ItCSTQJM2FCzqepBzrzGUeCPb7nGi
	2LmtND/oay0QONFg52u9oL9puwZjYk1VfFveAd52J1U+OK3jjSJC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F6AD1DF853;
	Fri,  8 Mar 2024 10:24:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDD9A1DF852;
	Fri,  8 Mar 2024 10:24:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation/user-manual.txt: example for
 generating object hashes
In-Reply-To: <ghbk7p43xq.fsf@gouders.net> (Dirk Gouders's message of "Fri, 08
	Mar 2024 07:45:37 +0100")
References: <cover.1709240261.git.dirk@gouders.net>
	<a3902dad424983a4f0dfcda68e0b8bf64a0b2113.1709240261.git.dirk@gouders.net>
	<xmqqil27c5p1.fsf@gitster.g> <ghbk7p43xq.fsf@gouders.net>
Date: Fri, 08 Mar 2024 07:24:38 -0800
Message-ID: <xmqqil1wiw5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB0C4512-DD5F-11EE-8A1B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> May I ask what you meant by "modulo coding style", e.g. where I should
> look at to make the code of similar style?

Documentation/CodingGuidelines would be a good start, but

 * A here-doc for a single liner is probably an overkill.  Why not

    echo "Hello, world" >file

   In either way, in our codebase a redirection operator '>' (or
   '<') has one whitespace before it, and no whitespace after it
   before the file.

 * printf piped to "cat - file" whose output feeds another pipe
   looked unusual.  More usual way novices write may be

    { printf ... ; cat file; } | sha1sum

were the two things I noticed.

> I would also add that git-hash-object(1) could be used to verify the
> result if you think that is OK.

git hash-object can be used to replace that whole thing ;-)

> In addition to a suggestion in another mail, the commit would
> consist of substantial content you suggested and perhaps, you could tell
> me how to express this; would a Helped-By be correct?

I think many may prefer to downcase B in By, but if it is
"substantial", probably.  I do not think I gave much in this
discussion to become a substantial addition to the original, though.
