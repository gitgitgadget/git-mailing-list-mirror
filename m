Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8C250F6
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952810; cv=none; b=VyzXEHrQ1YkDGfNC9SfN+oHRBxojRs/cNsPAFFkfa1itKuCNpmG5kuWTDcejhk8yBLxVRez7kh4CAi798Mra8oQvOr9SF1JbRBMC9ykqurWw1GTc334a42RKiMkWu1TXOQWN6VlMd2Y85mQa4cPW2NirKlBZ2xLBWBI6KIUgAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952810; c=relaxed/simple;
	bh=Gsrln7/sAkCEZpHO9aIKQJWF6SeuQZ5iJ3X0xNjB634=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAL6goTk94hKbVONpTx4GdruBwGehTRJmlyn032no/auQ+a0wClJdhfo68qIfwp6aTHMHIjdcQzTacOsQTorD47d2Z1gBEqA8QlnJUISbuoM2aQfDg1kyQUYOsxnKRG+ms4p0g/638ncVQIOGlneyxC2bNNAkSaFYq/m62DI11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IzhSawtN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IzhSawtN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2945425364;
	Wed, 14 Feb 2024 18:20:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Gsrln7/sAkCEZpHO9aIKQJWF6SeuQZ5iJ3X0xN
	jB634=; b=IzhSawtNwVN6e1v/0dyQJic0KBgm0v65at55cavRNAkexMH6gMCh+q
	zeuhL1Xo0KFHCXVt6W3shWqEmHHGO8WZ5QnkjAVYB4KnO8jXRgd62pKQn4zMpHzU
	Z8vgShF8de4TIayFDOBxWkjOWIoUD8d70OaYSdRg+G5+LI/mmjWYU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 21DC125363;
	Wed, 14 Feb 2024 18:20:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8EF7F25361;
	Wed, 14 Feb 2024 18:20:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] t: drop more REFFILES prereqs
In-Reply-To: <cover.1707463221.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 9 Feb 2024 08:23:05 +0100")
References: <cover.1707463221.git.ps@pks.im>
Date: Wed, 14 Feb 2024 15:20:02 -0800
Message-ID: <xmqqzfw2skf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 95057612-CB8F-11EE-A469-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this patch series is another step towards less tests with the REFFILES
> prerequisite. Some of the tests are simply moved into t0600 because they
> are inherently exercising low-level behaviour of the "files" backend.
> Other tests are adapted so that they work across both the "files" and
> the "reftable" backends.

I've read this through, and except for one of them (I left a comment
on it), they all made perfect sense.

Thanks.
