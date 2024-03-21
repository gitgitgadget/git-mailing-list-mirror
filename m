Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104F17CD
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061947; cv=none; b=Nz4hMJNS2T+sQ7xTOKR3Y0LZQXeMgRie6qeAas/lmQxCiHArbb9Sn1Ag38+NSZ6mw3kLWp8guWz0O+KNbDZ3ovR9IwytZVLRXyUmBWKqhr67Am2g0pUOxP5gSdVL4W/ye83rYpOhztXJ6ucA1NV3+RS2BKoRII3A+sDJhmZIW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061947; c=relaxed/simple;
	bh=DQPVIjTk7CN31Ib0pEto2u4fqFFFlvXTDVkjgUcEeiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lqXCMU53UnkY+eMuA6YsZDyko+lqk0emuzsse8H5IqxOAGJRVnMoPLaVquYr7fQuj2+IZnjYPtCYvEdPTuERpFqEj5uBe8oQf4wMLJ8D6t2G28T2uw0TFzijXwSEje3bAQGEyL/WiqrJtGV5i4pAEBYQdHUuLlXT381GkFqpcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cdkOH8Z2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cdkOH8Z2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A6A13BA94;
	Thu, 21 Mar 2024 18:59:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DQPVIjTk7CN31Ib0pEto2u4fqFFFlvXTDVkjgU
	cEeiM=; b=cdkOH8Z21z9SmjBhCeddVZ8tWbOhdc0wGZt1qvYTf8HYGoeKGY2kDQ
	W1sEF/LSxF53jbxKePe5xWimNidDYuXAUGVFR3jbBqpRdUQbsDFkeTvbI9JeuMAV
	XeC4sOkYro88mx8ZVYZ5Dy/4ETLNiCP7NpRxxvWZCvi1AJnEZ7Fis=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0150D3BA93;
	Thu, 21 Mar 2024 18:59:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 720A43BA91;
	Thu, 21 Mar 2024 18:59:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org,
  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH v5 4/4] config.txt: describe handling of whitespace further
In-Reply-To: <CAPig+cToaiCzj2XwNSeStx7p7ZPn7=a2nKZBFLwX12Uj=hJ7cw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 21 Mar 2024 02:22:54 -0400")
References: <cover.1711001016.git.dsimic@manjaro.org>
	<a75a5eb8793f4ae6eb6e7cf0e2fd017471fefd0e.1711001016.git.dsimic@manjaro.org>
	<CAPig+cToaiCzj2XwNSeStx7p7ZPn7=a2nKZBFLwX12Uj=hJ7cw@mail.gmail.com>
Date: Thu, 21 Mar 2024 15:58:59 -0700
Message-ID: <xmqq1q836vkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B9CEAC4-E7D6-11EE-ABF2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks. I find this discussion clearer than v4.
>
> I don't have any further review comments on v5.

Thanks, both.  Let's mark it for 'next' then.
