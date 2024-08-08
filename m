Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E3154C17
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134295; cv=none; b=U0Gp529jTIXJ7kLxCboVw73krkeesjxmuxQ4f8jr65Tvbqn5LRBQerOojZGCicaNlYa5bmXJORvddoDTiJVltHry1DJL+VYMIH967+Q7bd1dpzoGo4i1e9lQbTrbd02IBWCun4+ULYum4FAS5OmIvjGqvv7nOBxwt65lSxRA2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134295; c=relaxed/simple;
	bh=Y7MafQYx4xphBmM93Lpr/n2rTgS1gXv92JGJo6zEdjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KjxM0lS70tx3FwUMMWXesaRqE3TAoTdvmfFg6zY/xFQwWv8SEgvEfFQLS+jVugkC+hoGK1hFzrfRWfgh11njL7vBald5vLUsz/BYqBzYmY8eMvFr6jAGSYlVLz6rOGYYEzNyEVjk0a5W17J7GssxXdNjPLs0X8J8Ul9jMV3PJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BODxkyjV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BODxkyjV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 57F4733B13;
	Thu,  8 Aug 2024 12:24:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y7MafQYx4xphBmM93Lpr/n2rTgS1gXv92JGJo6
	zEdjw=; b=BODxkyjVecWiLek7lClGMp4mi+sv6b2yUBPpHMpVw4UqaeWRaKqf4u
	GkoGLECR63Mn5SOEnRpqoWNN36LKVdvIjINKFWtUniHH2MlU/QX1udNj8M653S/m
	phHmNol8SV5PdlZ90o3qycNiq1mN93zbH39ayZGbmF8Dnoxh2bRGo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 519F233B12;
	Thu,  8 Aug 2024 12:24:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 577D233B11;
	Thu,  8 Aug 2024 12:24:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Jeppe
 =?utf-8?Q?=C3=98land?= <joland@gmail.com>
Subject: Re: [PATCH v2 0/8] Improvements for ref storage formats with
 submodules
In-Reply-To: <cover.1723102259.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 8 Aug 2024 09:35:21 +0200")
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
	<cover.1723102259.git.ps@pks.im>
Date: Thu, 08 Aug 2024 09:24:47 -0700
Message-ID: <xmqqsevfhtio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BBB07012-55A2-11EF-B30C-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>   - Add a preparatory refactoring that wraps overly long command lines
>     in "git-submodule.sh".

This is very much appreciated.
>
>   - Wire up support for `--ref-format=` in `git submodule add`.

Good find.  Thanks.
