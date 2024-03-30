Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356A3BBC2
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830892; cv=none; b=RZmZLZFjyCbw900bR/zOCHdKXMtPFuwVcKIwgCacF99x83jdmLyFHajj8Q52v7Ss8nib81dIi98GM2zByT4HtgkV9gAl+t94+9qUhmwqedGqSDxsLNFBIG592kGfJBjCyUNpyFdyA9OxQtxeHKOUWvsoRnfHikpgPe0r++UZHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830892; c=relaxed/simple;
	bh=fUOSCWF+OgF7dk0apcooWpT/m/AwZ36y05tI+zAlQ2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yf1vFryM/0/t6F+++0iGFPOVbdXbRE3gpKqUSzX5DPKWTOUCx97TzBJr4p67IIQuZ2TqDAos0M4ovA1RDiRm3uEFOAqJMjOSjj4hWlH5Gi5OyPF81aq03E7dohCdoWKii36y3Dk0eQt6RUBhqp9a76jOEjvgYR4qNXY7nZWS6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xegcSknx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xegcSknx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FEEC2F483;
	Sat, 30 Mar 2024 16:34:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fUOSCWF+OgF7dk0apcooWpT/m/AwZ36y05tI+z
	AlQ2E=; b=xegcSknxIuBtcVQbEDb2iq40Az3A8Y9xtEHit0EpiHB/0s5Yjyt9Q7
	0z1C8SXAmmtiS9tEXEmH6bW6UIQtwnPJpoUMH2q0wNhKq2YN5eK9CVD4ULsn4Epn
	f5lS+jdHLfF98u5Pl3+0x7He2n6fSobf9q23jD/2hmhBnchTfzDj0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5833E2F482;
	Sat, 30 Mar 2024 16:34:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D9A342F481;
	Sat, 30 Mar 2024 16:34:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config: fix some small capitalization issues, as spotted
In-Reply-To: <6f6f821fc090fb59f632fcdbd061154b897b1244.1711772691.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sat, 30 Mar 2024 05:26:31 +0100")
References: <6f6f821fc090fb59f632fcdbd061154b897b1244.1711772691.git.dsimic@manjaro.org>
Date: Sat, 30 Mar 2024 13:34:40 -0700
Message-ID: <xmqqo7avlaqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EFD26100-EED4-11EE-A80A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>  On some file system/operating system combinations, this is unreliable.
> -Set this config setting to 'rename' there; However, This will remove the
> +Set this config setting to 'rename' there;  however, this will remove the
>  check that makes sure that existing object files will not get overwritten.

Looking good, except that we do not want double-space after a
semicolon.

