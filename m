Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E23D966
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QEIGg6Kh"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F8131
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 15:31:57 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D0E1BAE15;
	Fri, 10 Nov 2023 18:31:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=roxgsi3Z/hlSONGiQAmM9kGdZ2UuGUqicmTZOB
	5p0oM=; b=QEIGg6KhqkRH5uXMYAXuUU3Nz0Btss8AoH5KILyFvzDAZShG1ARvtf
	KLgQqnToyAnYfCRLyYfx20uDsl5D3PumHXiPOfsDzsoX8QJBez8fGO8gYlGUgLUK
	ADfr22JHCvod41roruM2q3GLabc6HDrsn2r9/vUn8ljjOVnqa7Jgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ADAB51BAE14;
	Fri, 10 Nov 2023 18:31:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBFF21BAE12;
	Fri, 10 Nov 2023 18:31:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
In-Reply-To: <ZU4widBlHljjg9lL@debian> (Alejandro Colomar's message of "Fri,
	10 Nov 2023 14:30:49 +0100")
References: <ZUocFhmPHstwKCkZ@devuan>
	<20231107174803.GA507007@coredump.intra.peff.net>
	<ZUqDwnmu9d1dD1tb@devuan>
	<20231107201655.GA507701@coredump.intra.peff.net>
	<ZUv3gjjmuqvCaJEd@debian>
	<20231108212702.GA1586965@coredump.intra.peff.net>
	<ZUz6H3IqRc1YGPZM@debian>
	<20231109180308.GA2711684@coredump.intra.peff.net>
	<ZU1-l4PwMU5H4_VN@debian> <ZU4widBlHljjg9lL@debian>
Date: Sat, 11 Nov 2023 08:31:53 +0900
Message-ID: <xmqqh6ltuqvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5562620E-8021-11EE-B24B-25B3960A682E-77302942!pb-smtp2.pobox.com

Alejandro Colomar <alx@kernel.org> writes:

> [sendemail]
> 	sendmailcmd = mutt -H - && true

Ah, this is fun, an ugly but serviceable trick to ignore the command
line arguments.  I briefly wondered it would work equally well and
much more readable to simply append "#", but the above should work
just fine.
