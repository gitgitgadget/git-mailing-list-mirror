Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7E3A8DC
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MP4yFsAA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 00A0B36895;
	Tue,  9 Jan 2024 12:12:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I+JRCB0qiBDWxEXsKXGYolIb1d5YE1mkTlPxkW
	5A+QE=; b=MP4yFsAAjEpSyR1cBZ3eCCPoHuopIw4TZJDezXAsYBWi12b1icMaBL
	1G9riauFAit6baqtynGO1XQvNmHx0FYWn6Czkm98+WFUs8tsbqTULn9NI0yU9Hqn
	a//KntJ22EodOxfr5PCfcxMeI1eveGjT2+S7GBFz9Xh5PlPMC/fzI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ED38E36894;
	Tue,  9 Jan 2024 12:12:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F21936893;
	Tue,  9 Jan 2024 12:12:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Achu Luma <ach.lumap@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,  l.s.r@web.de,
  phillip.wood@dunelm.org.uk,  steadmon@google.com,  me@ttaylorr.com
Subject: Re: [Outreachy][PATCH v4] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
In-Reply-To: <33c81610-0958-49da-b702-ba8d96ecf1d3@gmail.com> (Phillip Wood's
	message of "Tue, 9 Jan 2024 10:35:11 +0000")
References: <20240101104017.9452-2-ach.lumap@gmail.com>
	<20240105161413.10422-1-ach.lumap@gmail.com>
	<33c81610-0958-49da-b702-ba8d96ecf1d3@gmail.com>
Date: Tue, 09 Jan 2024 09:12:01 -0800
Message-ID: <xmqq5y02juse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 34E3F734-AF12-11EE-A52E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> In the new version we only test the characters 0-255, not EOF. If
> there is a good reason for removing the EOF tests then it should be
> explained in the commit message. If not it would be good to add those
> tests back.

Thanks for sharp eyes.  Didn't notice the handling of EOF myself.
