Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262113F426
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452589; cv=none; b=IvELwbvSVYbHOJUnTsU2KbKP1NxXIAknP6me+ajqRRnlNBM7CMFr8t/k41+szGTGmpjSXWIaDXEPtq3U21xq+Dmobx4SzyOVWzSQYPeJP6L607Bk0jUwPOIR4lRdXkvvuRQP1h3DWhLDEyaPlp7m95rC+yCY8va8JtnHo2bEeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452589; c=relaxed/simple;
	bh=96Qe+XYM2YmYQdf44GUL5Nd1R51fQWR+U5lhTF5WqAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kum8Wy9IlAehT66mS9UFNoSmpt61ZmoJSRlvRT7nMTgFZtxgtR0xogJvbfLUUvU5F5ElLvPJ7xAhvLV5w0OWE1pz+fn2xMsWmmta6e29XUJkR2G1fpVW9El4+8HaxLYoF24qKdJVuAK5U4Oy9KcRwH2LsGvCgBSvGQUZsVhP8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cp3WhJD/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cp3WhJD/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 232F81A3CC;
	Mon,  8 Jul 2024 11:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=96Qe+XYM2YmYQdf44GUL5Nd1R51fQWR+U5lhTF
	5WqAM=; b=Cp3WhJD/gZ2tgwHSoKLxgdins6mUczogyyLfWv8T+9BzY1bYhHjS2a
	+avyYJWv/V9lJYhsquX7tlUAt/14O+QWEjs2DieeX79SelPugb2yw81bDUIZ19GV
	ZcK85/8UDLt5JpcfwSHzIHwX9VMIzgWeHnbw2YTGlAPK/Cj4wwM4M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BC541A3CB;
	Mon,  8 Jul 2024 11:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A21C11A3CA;
	Mon,  8 Jul 2024 11:29:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Rikita Ishikawa via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Rikita Ishikawa
 <lagrange.resolvent@gmail.com>
Subject: Re: [PATCH v5] doc: fix the max number of git show-branches shown
In-Reply-To: <pull.1757.v5.git.1720444080034.gitgitgadget@gmail.com> (Rikita
	Ishikawa via GitGitGadget's message of "Mon, 08 Jul 2024 13:07:59
	+0000")
References: <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>
	<pull.1757.v5.git.1720444080034.gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 08:29:41 -0700
Message-ID: <xmqqmsmrlx5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E6895A14-3D3E-11EF-B7C4-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"Rikita Ishikawa via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Rikita Ishikawa <lagrange.resolvent@gmail.com>
> ...
> FLAG_BITS is currently 28, so 26 is the correct
> number.
>
> Signed-off-by: Rikita Ishikawa <lagrange.resolvent@gmail.com>

Looking good.  Thanks.  Will queue.
