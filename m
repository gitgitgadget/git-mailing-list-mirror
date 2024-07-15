Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB918E767
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054814; cv=none; b=I23OluZCJWFK5b1KIEx0+1aYw6ef9Lt3e/0ITJ5mbigIMfjIFSHsAFrr8QjSN/u4/o51+gnKZajriPPOyWVry7bQKnuLgqXWGdYB+duuDDMAlnvSv/py6eW68nJShsXL5aCT2HQkcfFcU++W2Vv3+8ijS+Ur3BdIdplmYb5mdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054814; c=relaxed/simple;
	bh=SpaylEs469LVDb+An13Rs+/EU/swPfp3s0WmSTEME0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmsQbCow6YuFBUSwtDOrvjzpFTuCUkuEXC2OdP3iuICkjq9D7NI0ZrMdP9Xj84YIF60h8rD0NV6MN75OpKA+1RnoqTEzPOllrbz2k8uhbEZWhvZOxePf8FV1yCotv3pJKLQXppJiwgj1RYoP2LHkS5xsFWQDDHCBH/9c8cIPmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bsmSsUab; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bsmSsUab"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA1981ED77;
	Mon, 15 Jul 2024 10:46:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SpaylEs469LVDb+An13Rs+/EU/swPfp3s0WmST
	EME0s=; b=bsmSsUabdXJvUgZTJnZw+GjzDeWSG8K0+DlgACoCRbmRlODsyaYiTi
	d7S7lhRf7doMoo4XiIn6uGpjVw6u9f7uaUuAhyG6o9HshuVTjC33EOu8Nuum2WOd
	3kKmB3cCYqMAWVKjq5zF9VTIh4PwKMbkJROE3wocB/nUbuf+Bq1Xg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C25081ED76;
	Mon, 15 Jul 2024 10:46:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E6761ED75;
	Mon, 15 Jul 2024 10:46:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  chriscool@tuxfamily.org,
  git@vger.kernel.org,  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to
 '.clang-format'
In-Reply-To: <CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 15 Jul 2024 04:10:49 -0400")
References: <20240711083043.1732288-1-karthik.188@gmail.com>
	<20240713134518.773053-1-karthik.188@gmail.com>
	<20240713134518.773053-9-karthik.188@gmail.com>
	<xmqqa5ilcngi.fsf@gitster.g>
	<CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
	<cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
	<CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
Date: Mon, 15 Jul 2024 07:46:44 -0700
Message-ID: <xmqq7cdm90h7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E93EBE4-42B9-11EF-A727-965B910A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Providing a path does work indeed. But we were discussing the option to
> provide an additional path apart from the default '.clang-format'.

But that is not a requirement.  The requirement is to allow us to
use what we have in .clang-format plus one other rule.

And if that requirement is met by copying the entire contents in
.clang-format to a temporary file, adding the other one to the same
temporary file, and then using the temporary file instead of
.clang-format, that is fine, isn't it?

