Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99F139D00
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072708; cv=none; b=AgTPmeb91qsOcDEe7qKKMwSc1lBEzhciOxReeyBWaXTxDkCKyuZ/ap9NbRkd+P6RtqyZ5w3goi3MBdlbHD8JxMdrvs6d57qhFvNk4rwdlEKLPoBfp+owDupdS2AbMEWgZZTB1q2/frj0B7v0YUkZ2P/hT2ia5hiWj2uRNWGzoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072708; c=relaxed/simple;
	bh=vqKBOLFtcBvROcnn1SHiWb0DD14GeYHP/Q4trfIjKas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cq9wpS4BXJdfFA4YcSVw5B34OCenQvg3mjXyEK6neIzLRa1FT5DxdlMuwGPl37zxo345J7NzON2tvOk/c3nqpueD4n/ycAnncGxcpe4cE6BuN/rjwDU9moE/o5zyN0bbSy7dk8EuDaiH8GqB6bt6LiouwslbhosQxjM2sgDKzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bga8HETz; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bga8HETz"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E00623C4F;
	Mon, 15 Jul 2024 15:45:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vqKBOLFtcBvROcnn1SHiWb0DD14GeYHP/Q4trf
	IjKas=; b=bga8HETzZaHFyGi+qveBXBbE+o9IZp8xcfrrudRGUiY3mtzY1s7zGN
	BTLGcfQoOtJvIebbafu9uZ41dnBQYdvFmulIXdX66dvNW+rHmqVWs5mDknbh/gwE
	H59ulxOWbrkhBqe5CKLDxrkhUS/JQFLPomcJ+wsPOjxvl1deORyXo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 26A0823C4E;
	Mon, 15 Jul 2024 15:45:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD12423C4C;
	Mon, 15 Jul 2024 15:45:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  chriscool@tuxfamily.org,
  git@vger.kernel.org,  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to
 '.clang-format'
In-Reply-To: <CAOLa=ZQx4UKMfq7q2GMV6nYQGKeCj0dW_P4kG7yDTcdo--1HHQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 15 Jul 2024 12:31:19 -0700")
References: <20240711083043.1732288-1-karthik.188@gmail.com>
	<20240713134518.773053-1-karthik.188@gmail.com>
	<20240713134518.773053-9-karthik.188@gmail.com>
	<xmqqa5ilcngi.fsf@gitster.g>
	<CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
	<cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
	<CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
	<xmqq7cdm90h7.fsf@gitster.g>
	<CAOLa=ZTjHKX3EMbVu1_bjdDez=3aODZQYY4npKrCY-7ZRXN1hQ@mail.gmail.com>
	<xmqqle224npf.fsf@gitster.g>
	<CAOLa=ZQx4UKMfq7q2GMV6nYQGKeCj0dW_P4kG7yDTcdo--1HHQ@mail.gmail.com>
Date: Mon, 15 Jul 2024 12:45:00 -0700
Message-ID: <xmqqcyne30eb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B9BBCD60-42E2-11EF-A8A1-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> If we know we can write into /tmp/clang-format-rules file, then the
>> CI script can do something like
>>
>> 	{
>> 		cat .clang-format
>> 		echo echo "RemoveBracesLLVM: true"
>> 	} >/tmp/clang-format-rules
>> 	git clang-format --style=file:/tmp/clang-format-rules \
>> 		 --diff --extensions c,h "$baseCommit"
>>
>> right?  Then "git status" would even say "there is no untracked
>> cruft" (although I do not know we *need* to keep the working tree
>> that clean, without untracked cruft).
>
> Yes this is the best solution.

FWIW, I think an in-tree throw-away file is a better option, simply
because we _know_ that the working tree can be written (by the fact
that we can do "make" and have compilers write *.o and other cruft),
but we do not know if the CI environment allows us to write to /tmp
or /var/tmp or /usr/local/tmp and you do not want to run around and
see if there is a suitable temporary directory you can use.



	
