Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE912B158
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486806; cv=none; b=JLqWWKwLch7Qy3ShkfymbAfUgTDsDYC6ZJB0fOvCliverJ9P0sARlYPJ1cFh/4akqMIl+QA6yuaKG9g8FUwKUJ2P54f4OpNym3baSRxq6pXUZXCzlSnUjHyVmwe3/yVb+vLgWHURT6bMGerQkLZze4VTqFgRfFwxODScx5NDhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486806; c=relaxed/simple;
	bh=tBadLIB3IVGssNHhtmXHGfXBM3wJW0RVrczEtJ7ciSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGV2tbnfi6lNHmkJ7pZ06nQWNSs5ZDfrx3WYByQgThuuVtEJvr66NVtRn/nheQMLfFdAjANRbnbQNqnRo8SDssWkWgvgy4xVahIUHOqLqv7yZdN1fhnsXQez9cIyiAQ45WKf/rL6hk9+GeyLIRbvJOpCUOj8bn80+wgsyNZUPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GjYTsXFM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GjYTsXFM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CC7C1F2AB2;
	Tue, 26 Mar 2024 17:00:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tBadLIB3IVGs
	sNHhtmXHGfXBM3wJW0RVrczEtJ7ciSM=; b=GjYTsXFMlNoR8/AGksLLc5RpxDVN
	9bgauel/klBEhJSK4TRdcUCzLLN4KgHy+Qb14Z7KSzl9oxwpJV4pJc4RtCOUANp7
	fh9jZ32rnrH7sTLAJrjKpJi8Yo10TH0lBQUgUCVLv+7jz4YLSIivyItLgoJN23Nc
	HpFLhAuZtgH0Vg0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F1F81F2AAC;
	Tue, 26 Mar 2024 17:00:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 722CC1F2AA1;
	Tue, 26 Mar 2024 17:00:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,  =?utf-8?Q?Jea?=
 =?utf-8?Q?n-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc: git-clone: apply new documentation guidelines
In-Reply-To: <3285532.aeNJFYEL58@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Tue, 26 Mar 2024 21:49:17 +0100")
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
	<CAN0heSoSNxuoObvO_xtu1fXb+XYH+gBvVOWfJVBkpXouR0cmWQ@mail.gmail.com>
	<xmqq8r24agov.fsf@gitster.g> <3285532.aeNJFYEL58@cayenne>
Date: Tue, 26 Mar 2024 13:59:59 -0700
Message-ID: <xmqqsf0c90a8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CFE8D8C0-EBB3-11EE-936F-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> For now, we are stuck with the compatibility with the existing tools. I=
 will=20
> try an propose something else. Would preprocessing be accepted?

Pre-processing will be hidden inside Documentation/Makefile and
would be invisible to developers, so as long as it is cleanly and
robustly done, that would be fine, I would say.

