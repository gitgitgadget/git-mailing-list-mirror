Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098576025E
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572750; cv=none; b=hdrOks63gV4uzq7kSjWT963JIraK95yi8ArU1CNQstcky8lOv1S8kMZbZvcmAlBRRxheDZSUjNsUJj4HncpS2289P29OyEs8i3uiaLAitzONBL5x1JYcFBBKtj36fkM/EiebkUflnsYR7q7bmXLQ+CQmGgzG88dB+mnhct7WXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572750; c=relaxed/simple;
	bh=uhnQir6dS+Y/Afnz3Sht+F4VIbGQ7EG7XN/bird4K0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k3dfTr2O/6s6uDaiW68XZJvRlaBKp36D5FjXp6buiEYyIj0jZMrYvRS2jj5XY89UywdokHJxSjnacEACsH2o4CNFCiV2bkef0VQLXR50fxsydSvo6YnVH0DNBQiCgm0LosXnBvSAe/J4ipoyMriN9vOrFGemJUam3vSntlFuh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yefuU+dE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yefuU+dE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAED51CE6E0;
	Mon,  4 Mar 2024 12:19:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uhnQir6dS+Y/Afnz3Sht+F4VIbGQ7EG7XN/bir
	d4K0I=; b=yefuU+dE+1PLJDW8JEWa14K/Ir6/7N4vTmCNmNS5rjBiuWW/8TFoUn
	ZIyG6gofPFDKrXLmgf7bvOrDkfeObQ3wNY9hg7SHoUydx0hfPXIfceEn2rLwi39y
	tfp20SeAVDkC8tNduCWYUUumDdn1SATnRrgRNVzcEr8GrhH49RkL0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A109D1CE6DF;
	Mon,  4 Mar 2024 12:19:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF1241CE6DD;
	Mon,  4 Mar 2024 12:19:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/1] Change commit message
In-Reply-To: <20240304095436.56399-1-shejialuo@gmail.com>
	(shejialuo@gmail.com's message of "Mon, 4 Mar 2024 17:54:35 +0800")
References: <20240301130334.135773-1-shejialuo@gmail.com>
	<20240304095436.56399-1-shejialuo@gmail.com>
Date: Mon, 04 Mar 2024 09:19:04 -0800
Message-ID: <xmqqjzmhrk3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4DD0E432-DA4B-11EE-AA35-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> This version changes the last version's error message.

A cover letter is way overkill to tell the above to those who have
read the previous iteration (which is minority of the reviewer
population).  A comment after the three-dash line in the main patch
would be more appropriate.

If you need to have a cover letter, its title shouldn't be about the
differences between the previous round and this round.  It should be
about the topic of the "series".

Thanks.
