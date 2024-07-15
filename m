Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F223B295
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063033; cv=none; b=GCVYjuuLB7mba5rgd2IHmHREkRqnhES/uE77GUi+JEqKIFvCosRWrzLQ+iiFPMza/BE4Y8bGcUEsU/WWfiJT0Z76QnySOLGoKx8CuHlct2+8A4wj6+qkZSr2z1DTI28tjVVojLoV+2AuAMOkJ/LwA2Ehx1N1OFWHJZTL3160JAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063033; c=relaxed/simple;
	bh=UFIrWrK+C923CdvQophN6kSGDR3EDAcR5u+OPiTqjCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lsjtyNkOmb2Z4Qgcyg3ubtgipPuMihXvHMUV55ZiYhYglCZcE+5KHdgiGqXMyG0WgbeVqH509H+4zd8LZHJKBVtIcE5NHYVCKyFvJtnbOl3DOHtgOsHSQeli5UyK72+4MPDOnetsVKdGteEoM2RFm11j+aOZ/JCZbbzK1J2v9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Up2Y1tla; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Up2Y1tla"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 303842BD7B;
	Mon, 15 Jul 2024 13:01:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UFIrWrK+C923CdvQophN6kSGDR3EDAcR5u+OPi
	TqjCA=; b=Up2Y1tla6ZUcidk3+DeBa7juaX/79UVZ5c4viehn2zGGJ0Cp5ZoKqS
	0N4fghmMCEDnbJGPrlnGshwvrGSjHq0ZiPXVgLK4C9pT6U2TuQErjpDwz8C2CJ9h
	ZtYsdsgUmuT9SyaolYvOxIiCLrlBWiG7aLE1m7QzOd0OJoiQhQgxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2830A2BD7A;
	Mon, 15 Jul 2024 13:01:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A61822BD79;
	Mon, 15 Jul 2024 13:01:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v4 8/8] ci/style-check: add `RemoveBracesLLVM` to
 '.clang-format'
In-Reply-To: <20240715093047.49321-9-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 15 Jul 2024 11:30:47 +0200")
References: <20240713134518.773053-1-karthik.188@gmail.com>
	<20240715093047.49321-1-karthik.188@gmail.com>
	<20240715093047.49321-9-karthik.188@gmail.com>
Date: Mon, 15 Jul 2024 10:01:54 -0700
Message-ID: <xmqq8qy24mil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F0C40E60-42CB-11EF-866A-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> A more ideal solution would be if 'clang-format' allowed us to append
> rules to the existing '.clang-format' when invoked. But such an option
> does not exist. Since modifying the in-tree '.clang-format' is only done
> on the CI job for style-check and doesn't affect any other jobs and is
> not persisted in any ways, this hack should be okay.

I think our mails crossed, but I do not know why this hack is OK.
Are there other CI jobs that muck with tracked files in the working
tree?

Thanks.
