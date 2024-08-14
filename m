Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203A111A1
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656125; cv=none; b=XIM13IbHzQiaYJgX0A1E2bjyuk98AdjOS1n0SEZASGtQzEfGygQiIEDrOOnYjIGdAcx9DQeStWextdjsXuOY2s/CtqmjMt3RHeli2R/xO4+Z/7PxhNMBh68XIbRJJI7aRuCVZUh8a8pLIu/v/V2BQOIqpYBl+e2CRC+BlWSHvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656125; c=relaxed/simple;
	bh=xnZ2gdVY54+C4sxhIQ3b74w2yBLLCumIw3YYHeyVPus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lyD4IpcOD6PAGS8u/2joVgLBUAqrKGQ7l3Tj/+8BSONJ32GCjYPiG5oX1XCBJzEEG8leKNxMrow/0WkUCKIi8/QCp456v0YsUg/qjQH6nnTDovxHj0JOXfrThzwdbqeMZWRmObXdJy7P0cEHuDkl3BmsCsCnQxrMldVz+Rh7ZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eX4kjcKD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eX4kjcKD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C541018B9D;
	Wed, 14 Aug 2024 13:22:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xnZ2gdVY54+C4sxhIQ3b74w2yBLLCumIw3YYHe
	yVPus=; b=eX4kjcKD/iqMo1VrcvShpCpQ+9dqQdRo2Y9io18+OLzJNxq8eIL0s2
	FoQ24jr8+FvxkXVxXj1Pa4ZT0bc7Oqas6GQIHFuCHfaBecpF1l0zhILb79vbog11
	Oajp6etxgazlDhDIRodGvNsNmgMidjVUKUjbEewxSAR9g7eHDnDQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD6F418B9A;
	Wed, 14 Aug 2024 13:22:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F19CB18B98;
	Wed, 14 Aug 2024 13:22:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/15] reftable: drop generic `reftable_table` interface
In-Reply-To: <Zryxwirh2z4gOltc@tanuki> (Patrick Steinhardt's message of "Wed,
	14 Aug 2024 15:31:54 +0200")
References: <cover.1723640107.git.ps@pks.im> <Zryxwirh2z4gOltc@tanuki>
Date: Wed, 14 Aug 2024 10:21:59 -0700
Message-ID: <xmqqcymbyq88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B82D9E56-5A61-11EF-A742-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Oops, forgot to link this to v1, sorry! You can find it at [1].
>
> Patrick
>
> [1]: https://lore.kernel.org/git/cover.1723528765.git.ps@pks.im/

And on what commit are these patches supposed to build on?
