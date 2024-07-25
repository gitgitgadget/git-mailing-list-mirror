Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73819CCE6
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921087; cv=none; b=WPLHlWPUy+fskU04pPUwE2PzVNLtArbTfBXzA0XXcHK7Tol0jRhSSMFYLm9en0vLdg/bCRRxGeV7G9PlJuiJbznBbbAnDTkiZqNGKwL2vVwXdNnfJ5GiHICbttT115hNjvCTa16l1Dsl/fIUb5HtydR5LZxtd3y57r/BBbr+D8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921087; c=relaxed/simple;
	bh=EOymXjqF0WzO3at2xLCH7rPCb1YKK8BkJ+xt+P6fBFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bKa7hj/irxVPG8BpUqZt2ky9ukwQfWt0C/eP58Hb291tKWZD01BJ8SG/0+abYWQdbU2w5e1c8KIA0HEbDYP3krULBRy7tEEoSVGQqxZz95NEGQ0j4Wa/W017Fd5clbti94Cl2f5uwNiQggHkWaJeFHDEwpghBKO5VJCKI8ZyaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gjlDXuDv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gjlDXuDv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B02A35865;
	Thu, 25 Jul 2024 11:24:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EOymXjqF0WzO3at2xLCH7rPCb1YKK8BkJ+xt+P
	6fBFE=; b=gjlDXuDvVwLaADvkMAh0PABNjn/3FQGnCB/O9FBH1GWRIX4w4ePpWw
	tcilZNwqnqxyb97Mm9qB/FxGsDWnzYfwl0F3Zn68OqFNOX15QjnBHhSBwS92Nl/P
	rPPGxk5+opa1IPeNseF2uX6Vstk+I/Klz9uIeWc/WOSCCY8AoQmeY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63CFC35864;
	Thu, 25 Jul 2024 11:24:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF64B35863;
	Thu, 25 Jul 2024 11:24:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] add-p P fixups
In-Reply-To: <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> (Phillip Wood's
	message of "Thu, 25 Jul 2024 10:45:04 +0100")
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
	<62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
	<2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
	<5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
	<a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
	<97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
Date: Thu, 25 Jul 2024 08:24:43 -0700
Message-ID: <xmqqcyn1lcjo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0573E1B6-4A9A-11EF-B368-BAC1940A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... We
> can add a comment about the dash problem to the commit message when
> this fixup is squashed. Also the problem is now documented in
> Documentation/CodingGuidelines which is more likely to be read by
> other contributors.

That is a good thing to take into consideration, indeed.

