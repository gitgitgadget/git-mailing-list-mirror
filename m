Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E86A29
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916333; cv=none; b=ZPO8bWThDjGL3XHcTihXpwrGmlv/Xgmvqmf80QOo+elw3War3pihzrnlKdOBpOgVQG9z6VhM8XwD5rC0TTpJEI9MNOLU87zjW//PEsZW7CSzrwpcIhOtcBQxedE/l2jQsWf/H0IsrIewQkmdAWBdQDEv7glzKVKjwQ2zTCkcW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916333; c=relaxed/simple;
	bh=HIh2b7+X+SJLZOMvINRN6o1BFUACNvi+cfpkhl6haSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZ9M1DHuwn8njGY82hURhHWN20c/ZgFqWDFfnabrup/pVqyVAIJ/b8OhWpARwl0LIY0Tq5sdrEyWTAD84FKtOdlyqZK2KuhVTfalSeYui4sDAGYmbDhJkDnlttBz86SsJ+ZzCIIZf6KqO0SZwmxEuVmWzGedwWD6AIIuDb1ZpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Coahedc2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Coahedc2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 880871DB85;
	Wed, 20 Mar 2024 02:32:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HIh2b7+X+SJLZOMvINRN6o1BFUACNvi+cfpkhl
	6haSI=; b=Coahedc2AM05zi4j2QMJWlg+moJXyCmKotvWQvbO01GUn0e1C9qI3x
	fSYhaKj3YghRNo0gJ2r7St33XO2wQtVI/H/aEI8j6X+mjfzENfYoH8U7vd5v9cR/
	yaNLXeKlXYNt5nVoIa8XRTTaPwBFqnjqkAgMcaSvX8EoWuo1zFwIg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8161B1DB84;
	Wed, 20 Mar 2024 02:32:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A48C1DB83;
	Wed, 20 Mar 2024 02:32:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/4] config: minor addition of whitespace
In-Reply-To: <2161355e5c9a8ca0c8c0d3e5115a8843be1f4111.1710800549.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Mon, 18 Mar 2024 23:24:19 +0100")
References: <cover.1710800549.git.dsimic@manjaro.org>
	<2161355e5c9a8ca0c8c0d3e5115a8843be1f4111.1710800549.git.dsimic@manjaro.org>
Date: Tue, 19 Mar 2024 23:32:03 -0700
Message-ID: <xmqq5xxhl8gs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9175E946-E683-11EE-82C6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>  		if (c == '"') {
> -			quote = 1-quote;
> +			quote = 1 - quote;
>  			continue;

Obviously correct.  Will queue.
