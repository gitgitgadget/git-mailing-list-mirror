Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93113A862
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937797; cv=none; b=J646bU8y/OyIbvB6B2CGvseYT72fvN/b10bLcC/8eUgkquu7rw1tsW6yo8PmxNLiLme3kA1VzF7T1N05NcsUhy71CQdRHcw8qEyIOYggLO1vaB79ts3MvlyYIiBQMUgC6ZjbVtKHjodKTg+ypvZonTZ//JfBfFOVR0lwcQ89QcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937797; c=relaxed/simple;
	bh=krPw6OfnIMko8gSnjAmcbLeeH9PDO9jnDqmypcHzGLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tr4UUkpf3jmLklvGAWXCWEdak9ysWXidSdcPV+62foAqtIW2VBJfsPSbPz0+RcN9ODjD79BSz2I80Jys8KSAn/bjDKPPNh6AFqgtvFNhKsnmb6a2fFF/DtVNcn4KWo2cXfZVb+3Z66eCEz3+Sj8KBYAh7gx9H63UVzTbv49AiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VIIMmYE6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VIIMmYE6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E856233F7;
	Wed, 14 Feb 2024 14:09:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=krPw6OfnIMko8gSnjAmcbLeeH9PDO9jnDqmypc
	HzGLg=; b=VIIMmYE6uiUgDJIiDq2fJAPUPAHSeAvcBO/xn3dI5PkY8y5GHPuUyi
	MuOvQAeRpgZF/7rufsjeHbJ4oJHdehUVTmDoMjkI75g5B3zzhzOzdXXzBWiYJS83
	QNhs5TTsudFfPwqlpQGm4WdfXJayKzz5Z8O8IFkjfQhgZXPA8ToAE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1567F233F6;
	Wed, 14 Feb 2024 14:09:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1108233F4;
	Wed, 14 Feb 2024 14:09:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: add shortcut to "am --whitespace=<action>"
In-Reply-To: <c329d3ed43f852453ad78ba430363416@manjaro.org> (Dragan Simic's
	message of "Wed, 14 Feb 2024 20:01:06 +0100")
References: <xmqqplwyvqby.fsf@gitster.g>
	<c329d3ed43f852453ad78ba430363416@manjaro.org>
Date: Wed, 14 Feb 2024 11:09:50 -0800
Message-ID: <xmqqle7mvp4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A141B936-CB6C-11EE-959F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> @@ -128,6 +128,9 @@ include::rerere-options.txt[]
>>  	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
>>  	program that applies
>>  	the patch.
>
> It would be nice to, while there, move "the patch." to the line above.

It belongs to a separate topic.  These files are sources that will
be line filled by AsciiDoc, so there is no reason to make such a
change unless the topic of your change were to make the source
"prettier", which is not the focus of this patch.  Having such a
change in the same patch will be distracting.
