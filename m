Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746FA1BF2A
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413490; cv=none; b=o3m5dJctc3X2HRzOIqf56i2z/yzbeMY6+2hrXmIdBacb5Y+Ax2jv4p8OZsQ7kiNzd2+Y/r73DKHzLFSJXKsFCWboqrpvaLECFgpJaPsiCYBPiU7Ffp6HzzwA/6zzNMelsDIJjNfX127UUOQhGF4dWIc/oxiW9UNdD7SfDnnMos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413490; c=relaxed/simple;
	bh=ZF6TEPiAeg8siUU62pc8clm3v02QmZkzrCAyACO4n5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBrCSlxzGhwSUZiXHZr3dD0qfnPwe0YIyIwWEJ4GxIi1XvHoci18qBlssg6/5metR4k2l3QFgy+WioZbvyT80a2MLmg+FMHYdriElowE3LXfMUkfGatiKHEOR4wIFfOZmUMhtPRTsl9/K+1BrT5oEzE4TYKxENgzBFAWQFMebik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=edqsCn2u; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="edqsCn2u"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F27D1A1BC;
	Wed, 22 May 2024 17:31:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZF6TEPiAeg8siUU62pc8clm3v02QmZkzrCAyAC
	O4n5Y=; b=edqsCn2uGsNW/Sn/PcbyeGzr3Ke+5qdj/HAZBBez1hDAUiZ8Ahi7m/
	aIdHuvYO5kwqmhPaVHmW2QR/Dtbv01Bwum6T4hXrSe1/p8I6QRHS1ewb5XL2/3Ry
	N4EUHqbqxcHB6dMsAkqsHCZdoPh07vioHn0JWYRxFraIwsEY5geJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3728B1A1BB;
	Wed, 22 May 2024 17:31:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 994E51A1BA;
	Wed, 22 May 2024 17:31:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rjusto@gmail.com,  sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Wed, 22 May 2024 23:24:43 +0200")
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
Date: Wed, 22 May 2024 14:31:26 -0700
Message-ID: <xmqqy1811qkx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5B143CA-1882-11EF-82F9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> 1:  3141fe9f7328 ! 1:  7da73f15a018 doc: note that interactive.singleKey is disabled by default
>     @@ Metadata
>      Author: Dragan Simic <dsimic@manjaro.org>
>      
>       ## Commit message ##
>     -    doc: note that interactive.singleKey is disabled by default
>     +    doc: imply that interactive.singleKey is disabled by default
>      
>          Make it clear that the interactive.singleKey configuration option is disabled

Heh, "note that" would probably be better, as we are going to say
"Make it clear" anyway, no?  That is stronger than just to imply.

Keeping the original version of the log message probably was
sufficient.

> +	When set to true, allow the user to provide one-letter input
> +	with a single key (i.e., without hitting the Enter key) in
> +	interactive commands.  This is currently used by the `--patch`
> +	mode of linkgit:git-add[1], linkgit:git-checkout[1],
>  	linkgit:git-restore[1], linkgit:git-commit[1],
>  	linkgit:git-reset[1], and linkgit:git-stash[1].
>  

The resulting text reads well.
Nicely done.
