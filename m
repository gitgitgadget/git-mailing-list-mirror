Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C234812
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707619359; cv=none; b=cSE4n9mb/Gqq39WvhcScJg2X461/6tHF8fe2iMu0/mDzHpl6TIIw2AtGl76vP4k3WzeVn98fZI7PHuBmxTvHULGDuKFLWjEHFeNlWFCPo9C1N3xy5wOCyP4C2vDB3Ey65GwM59hFDexHE2sV2V4XyT2bQ/yt7+XrFB2lGjsdJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707619359; c=relaxed/simple;
	bh=PEDNMzQtoOO48vhCyQM5jAHBgqXkaBCtr5tdrqbeUx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Km1kLSBqCNuGeV8q4mAz/wHu4AX9JVAk4J9p7hUmCiULDgH6CmTWsTGvsg0XBRKqFhkQt0tCAVO7TaHYhZ0DiT4jX3CiCD0FNyaKntZ3q83FMSqRbtppvMkDFE5KXe/ZRNphfFrG0zzyWzPs0bk0uVXweZteEKf3VEEJcdy2Wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=d8bV8eN5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d8bV8eN5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95FD61D05F1;
	Sat, 10 Feb 2024 21:42:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PEDNMzQtoOO48vhCyQM5jAHBgqXkaBCtr5tdrq
	beUx8=; b=d8bV8eN5nJCIl0Syu2XVF+uGsmg2LX+IDrFYH7nZVwst+blUykQdDt
	qIQ82OYNKSwU1WMP0Zguxy9IHvK2O8G4tMrEIfWO+YyVd0LP4v8gANZMzFy+AkQx
	7l6IEdV3B/sWZY7p35qnwtz6Rblqan6ZVIqEwCvhcTxxjQQvauKqk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E6871D05F0;
	Sat, 10 Feb 2024 21:42:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECAFC1D05EF;
	Sat, 10 Feb 2024 21:42:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Hesse <list@eworm.de>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>,  Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
In-Reply-To: <20240210210155.71fa163d@leda.eworm.net> (Christian Hesse's
	message of "Sat, 10 Feb 2024 21:01:55 +0100")
References: <20240209222622.102208-1-list@eworm.de>
	<xmqqil2xcl9e.fsf@gitster.g> <xmqqeddlckqa.fsf@gitster.g>
	<20240210210155.71fa163d@leda.eworm.net>
Date: Sat, 10 Feb 2024 18:42:28 -0800
Message-ID: <xmqq7cjbbu23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 332DE146-C887-11EE-8841-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Hesse <list@eworm.de> writes:

>> Oops, missing link:
>> 
>> https://lore.kernel.org/git/pull.1664.git.git.1706833113569.gitgitgadget@gmail.com/
>
> Sorry, missed that... Probably because the breakage went into 2.43.1, but the
> upstream fix did not. So sorry for the noise.

Please don't be.  Duplicated reports are much much better than no
reports due to "well, this must have been reported already by
somebody else".  Thanks for reporting.

> Anyway... does it make sense to move the include into the condition?

I do not think so.  The original breakage was because it implicitly
relied on the fact that http.h, which is included only when
USE_CURL_FOR_IMAP_SEND is defined, happens to include strbuf.h, even
though the code that does not rely on USE_CURL_FOR_IMAP_SEND do
unconditionally rely on the strbuf facility being available to them,
possibly combined with the fact that not too many people build
imap-send with USE_CURL_FOR_IMAP_SEND disabled.

So the conditional thing still rely on an implicit assumption you
are making, i.e. "http.h will forever be including strbuf.h", which
is fragile when people from time to time come and make sweeping
"header clean-up".  Which is a good thing.  But we need to be
careful, and one way to help us being careful against such a header
clean-up is to make sure you include what you use yourself, instead
of assuming that somebody else you include will keep doing so.

