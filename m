Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338049638
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155765; cv=none; b=GGLGiPHWsZOrmYrWiSLbZvIdXryJSSZ1wm3eUrmXnVrDjoCpKrCTuTxEyP8FgB/u15/CLkcQM3MJ2GAaEiQ/3MUQeZI73peD8GK5vaWYxMLpHFJFnbBNXH0S++Tw9jieU0ZiDaIjpap6fwInD0Io7cqwacGt8DuZ+SLS8QCqN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155765; c=relaxed/simple;
	bh=UAvj7vCK4x5PZhpXpfhW/VpEv8axXI89/Mypj+WdXJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUYqTB3m0xwzRfjpda/GRcGdOIbNCVP/bIzU0s/iumNFa7RHPhc0vlVv82Ows8WWQjaZjcqQONVNo6j6/00PVX4YUEcZN4avZrL8pznOnNbPgm9/OxAT48nGA90mtVFofJaTtsXq4sCaB6lorHfksvSX82JxpY18HVj0G0xB+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ljGEuA0G; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ljGEuA0G"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64983313F3;
	Tue, 24 Sep 2024 01:29:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UAvj7vCK4x5PZhpXpfhW/VpEv8axXI89/Mypj+
	WdXJc=; b=ljGEuA0G0VtD+4NKS9FLfUYaeURXsXivBta/riAR1zEz3sFdnwXVvi
	szZ3yxNcI8O1fWijD1MBJs25Nb5Dj/kyP5yLTGDKphpYKBjCb7eqa24ZiJKRVyhM
	0zhNRVIGb3ggU7Gzkit+8TAX/J+hYSS/fjRx04pNpiU9LFVUMhGZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D07F313F2;
	Tue, 24 Sep 2024 01:29:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2A33313F1;
	Tue, 24 Sep 2024 01:29:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-email: document --mailmap and associated
 configuration
In-Reply-To: <20240923222429.4102405-1-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Mon, 23 Sep 2024 15:24:28 -0700")
References: <20240923222429.4102405-1-jacob.e.keller@intel.com>
Date: Mon, 23 Sep 2024 22:29:20 -0700
Message-ID: <xmqqo74dwrf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F40DA7C4-7A35-11EF-886B-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> 241499aba007 ("send-email: add mailmap support via sendemail.mailmap and
> --mailmap", 2024-08-27) added support for --mailmap, and the associated
> sendemail.mailmap.* configuration variables. Add documentation to
> reflect this feature.

Makes sense.  Thanks.  Will queue.
