Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51A181B8E
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231339; cv=none; b=plekyHSpwso3V3hd3eH0+1SdRfWBDMiMPbqxhrh26tbnY946+IE9y16k+imLn7YlGvQHjfhnmsbIXBV2FRsKUF28NAeDX61iCXcHWZrbJO9v/qzQ8xI+yebibfuCbaFhJ4H20EqnA1/yFJ6C8AWEWVuOQpbkmjJ68KSmtQwUpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231339; c=relaxed/simple;
	bh=0Z7R2cfi1w/S711e0sJLo7iHixrhi5Fl15KsxU9edFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ox2iMC2ig3m/WAkE3LLtzLdrl1efVGHfAkNY5oexBNJJXPrxSajaSgQem9qPjSwBamWUuLm7/AZfo7jt61MarjJkpeYJtab/bRVQ46SfcKsjKe28bvTEX3aZbD4MLzT8zAey/VDlbf5xJIFvoESY+Z4BY4RTXli4BASUGWg8Be8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nhR7Knyi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nhR7Knyi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B37920406;
	Wed, 17 Jul 2024 11:48:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0Z7R2cfi1w/S
	711e0sJLo7iHixrhi5Fl15KsxU9edFU=; b=nhR7Knyi7bhlGikzKpijfy9VRoDQ
	Qg4SM/ZJYfIgm7pWr9GwNCNXY5nQP17JVKGofYa90KH3FTJiUbNqqJblwgRfhCpG
	ElnfqSCoz2yWchjsHLh+PAyEnv4FP9Mq2xJruAjGlLobgp+CuXlcSuw9DkNNPjIt
	TiZk2EJ+sDQpeR4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15EB820405;
	Wed, 17 Jul 2024 11:48:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FC5320404;
	Wed, 17 Jul 2024 11:48:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation/gitpacking: make sample configs listing
 blocks
In-Reply-To: <20240717105432.2801097-1-martin.agren@gmail.com> ("Martin
	=?utf-8?Q?=C3=85gren=22's?= message of "Wed, 17 Jul 2024 12:54:28 +0200")
References: <20240717105432.2801097-1-martin.agren@gmail.com>
Date: Wed, 17 Jul 2024 08:48:55 -0700
Message-ID: <xmqq4j8o589k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1355E91A-4454-11EF-A378-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Martin =C3=85gren <martin.agren@gmail.com> writes:

> To address this, wrap these listings in AsciiDoc listing blocks. Remove
> the indentation from the section headings. This is similar to how we
> handle such sample config elsewhere, e.g., in config.txt.
>
> While we're here, fix the nearby "wiht" typo.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  These buglets were introduced in faf558b23e (pseudo-merge: implement
>  support for selecting pseudo-merge commits, 2024-05-23) as part of=20
>  tb/pseudo-merge-reachability-bitmap.

Thanks, will queue.
