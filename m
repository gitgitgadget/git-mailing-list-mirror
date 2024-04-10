Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE015AAD6
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783742; cv=none; b=Hk9LE17Hv+0utS6BXgqqrI6SMMmLwMXB/PjT86MEYOfduL5CU90w5YWr2iDzhS8OUm+FGscAML/cUxWrfoWnTgmx1KAyBSyr1jC9P/73Ipq/SaZl3WhKbp9bJzzGfptYTFGQRwMdcrUKmRr+dHD2OlyXZg3ico52G7xpRo/20t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783742; c=relaxed/simple;
	bh=18e8TnVXv76+34HwhiFpaCbR3ObTt+F3n1Y8tlzJ+q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MrSgTuMagC4KlC/1dLZx63h69YjNolIBdn6WEyAcLf9wDPN6i2CNp2iFTeTdcCBFPKw0UuisxmRue5605sP7QL37f8Ker0L5VjGbf5wiunG/zGFxVkrjoqw4UHqOr+cKOTffweViwjPsEseL8to8bHyC9letmdqlTHuJsKJDYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=udYmlHuU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="udYmlHuU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14D8E1EFA72;
	Wed, 10 Apr 2024 17:15:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=18e8TnVXv76+34HwhiFpaCbR3ObTt+F3n1Y8tl
	zJ+q4=; b=udYmlHuU3ghWj7ZoLSMYrkQD65kreg70U+wqqIRVg6FOQGtneG9v4i
	Jy0hEq/Fp3Yk5v/60o6FcT6WX9fzO2yruK6XV2vhjQy32HMaW00v5UJT/SZHjJsl
	ZEzhecq95WSTKEUnqx2sNPYexw2eLoI2tzw72UPxEBO4LaLgeJc9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C5411EFA71;
	Wed, 10 Apr 2024 17:15:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71A5F1EFA70;
	Wed, 10 Apr 2024 17:15:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Pi Fisher <pi.l.d.fisher@gmail.com>
Cc: git@vger.kernel.org,  glencbz@gmail.com
Subject: Re: [PATCH] typo: Replace 'commitish' with 'committish'
In-Reply-To: <20240407212111.55362-1-Pi.L.D.Fisher@gmail.com> (Pi Fisher's
	message of "Sun, 7 Apr 2024 17:21:08 -0400")
References: <20240407212111.55362-1-Pi.L.D.Fisher@gmail.com>
Date: Wed, 10 Apr 2024 14:15:38 -0700
Message-ID: <xmqqcyqwsyv9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B31AFA0-F77F-11EE-B35B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Pi Fisher <pi.l.d.fisher@gmail.com> writes:

> Across only three files, comments and a single function name used
> 'commitish' rather than 'commit-ish' or 'committish' as the spelling.
> The git glossary accepts a hyphen or a double-t, but not a single-t.
> Despite the typo in a translation file, none of the typos appear in
> user-visible locations.
>
> Signed-off-by: Pi Fisher <Pi.L.D.Fisher@gmail.com>
> ---
> The function name was renamed to use 'committish', preferring to avoid a
> hyphenated word. Comments referencing this function were rewritten to
> match the new name. In the translation file, 'commit-ish' appeared
> multiple times, but 'committish' appeared only once, so I changed the
> comment to match the more popular option.

Sounds good.  Thanks.
