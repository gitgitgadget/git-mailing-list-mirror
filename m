Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A114A8B
	for <git@vger.kernel.org>; Wed,  1 May 2024 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593158; cv=none; b=kbvuCB4SmbiJd8ZyAUMYnSu1bNl6t9jczKhLKxbY9BP56336k3Ga0cz4H0RQtVpvxCAX+R/6+A53juzJgvpO/v/76Uo9/xKUTRzk5v4iqN1qwQ+Z0HxwDoXoUQOuMFXNxTgAlJ3KbFmlFK6gQoYzKE3wxEez6TVC683cXn9ZP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593158; c=relaxed/simple;
	bh=VawcSdkHa1c9t8670WfDFs1j9TmvFelN9vSFrT9r/0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pN+/rQ4TcWvke1T0yyU2KYVHxOkTnoWyuEaX75LyBxHExBjNFOaFIGKHNB6il+2AZrnyZ8ykHpifzQxQPNjtBzJ0jnoZT84b79IyoHd0feImlF/lH7E5BkU7mA3dJ4+BmO6aRCxpp53wrKYlRu6InqWOrO7UAGeXqF8xwIr3Ha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RQCev8AR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RQCev8AR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A1F0E293D8;
	Wed,  1 May 2024 15:52:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VawcSdkHa1c9t8670WfDFs1j9TmvFelN9vSFrT
	9r/0k=; b=RQCev8ARj2vFiHp07O2Gk/rtdr0CYFpnvXAr/Cf4js8JprZwNyCdUG
	h4QNVHOpF3AZ/B+1cgQiA9d2D9cH/DUYgkG6YYo48biEML6SxVyxARzpCPMnDBo7
	0aV6pNTfV8OfAsXPZ0eARQNkzUny86652dzUdP0EeIgqu8RuiTgZw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A460293D7;
	Wed,  1 May 2024 15:52:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A2AE293D6;
	Wed,  1 May 2024 15:52:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Toru
 Okugawa <castor.4bit@gmail.com>
Subject: Re: [PATCH] rev-parse: document how --is-* options work outside a
 repository
In-Reply-To: <zpttzdifoac5rcr2mzm353gdhuk52rqvtnldnxylnnzkplz2wp@fc6yrw74vatv>
	(Justin Tobler's message of "Wed, 1 May 2024 14:08:42 -0500")
References: <xmqqplu54fbg.fsf@gitster.g>
	<zpttzdifoac5rcr2mzm353gdhuk52rqvtnldnxylnnzkplz2wp@fc6yrw74vatv>
Date: Wed, 01 May 2024 12:52:24 -0700
Message-ID: <xmqqle4t48ef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55D46330-07F4-11EF-8153-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> Thanks for the clarification. Noticed a couple small grammar/spelling
> issues but otherwise looks good :)

Thanks for reading carefully.

