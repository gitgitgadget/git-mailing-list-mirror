Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180C1CDA16
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346668; cv=none; b=s+Y9OSVwUMNTLi5/Bxa6aKY7jjL9fbZecmgVPer4+KUglrWY9/+2hD1eQes8ukxhGqZ1IwMszxZeahwwxP1OTPJ23XZqXi4KS0aEAY+32DoonCKSGQmRXA3KDWywUJXyrxVJlBu0sPAuoLIVUuaWGmzuqKMEk2hjOturRBuElK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346668; c=relaxed/simple;
	bh=sNMCd+DT65AKjE4kitDhnfFn7mHbeHB2Swp+qJCzHRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtJo8S3j7P0JKzM7q7YTK0q3iCopORVOONztImv/ZCP99hJOdwU0NnQaWJYXoi19odFZ9TpBCYdkU4AJ7ZPsnqZ0X94xSv9slKtgD9G1kpb+arDWXaoeS2CAwzJFLYNUAenRdLOYd/BYcFFONqNFnOWLlvo/0VlJ2dWNFpUq+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GsbmK/ff; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GsbmK/ff"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3BE221848;
	Thu, 22 Aug 2024 13:11:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sNMCd+DT65AKjE4kitDhnfFn7mHbeHB2Swp+qJ
	CzHRs=; b=GsbmK/ffSZ32u4Y2k+lL6BTXf6N2GaTBWJra6CTC0OjTBkzUCK2rQo
	aJiu1+7dX4cs1Ugxcms0xp11pbzTxKJOFdKEIetb63805peHQdPMvSsFPqn67g93
	2fEjWFY6UqGewxeQu/LmqkLJ0oCv1/JDaXmFkxIxnQs//DdOTThFE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8843B21847;
	Thu, 22 Aug 2024 13:11:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1550021846;
	Thu, 22 Aug 2024 13:11:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/15] reftable: drop generic `reftable_table` interface
In-Reply-To: <cover.1724308389.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 22 Aug 2024 08:34:36 +0200")
References: <cover.1723640107.git.ps@pks.im> <cover.1724308389.git.ps@pks.im>
Date: Thu, 22 Aug 2024 10:11:01 -0700
Message-ID: <xmqq7cc8sct6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 82BE9844-60A9-11EF-A36D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the third version of my patch series that gets rid of the
> generic `reftable_table` interface. It made it way harder to understand
> the reftable code base and is not really required nowadays anymore where
> we have generic re-seekable reftable iterators.

Looking good.  Let me mark it for 'next'.  Thanks.
