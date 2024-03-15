Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015483F9EA;
	Fri, 15 Mar 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517297; cv=none; b=jlFXd7AR6qUTZcjDHszympcMQqUvIVxNBSciru3IXzzsmV/4IYeGjIsJR5Z3FUEBZRHUY+4pnmabzJdXObFuTVZ62bJjGrjawarpXjtfoQ7+t+ye1w1YgMAssDAKo0iFWKDi4XA4ene1BZHuIBpCQJ8vnOACZgoj47ct5itnSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517297; c=relaxed/simple;
	bh=AwcqUrrRldUwg/fZ1qQ/8sQz093FftCiU2Qe6vsKGxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GY8FFjsghaKnLuOj5lIcmohn8dAky5S8OeT/GqrdFtFC+EjlL3fMalbPAaWIiXc6WHNRnUP5H1TEI66MUdkC3MnfI+vGnHHsNZIh6Z/dR0nfw4eHTNmHbOW9S58YF92BrP8AmHDNeKkmg+cXzPQkAW5O2JR44T3IzVQOaDYyvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EY5FgVxy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EY5FgVxy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B9F72B650;
	Fri, 15 Mar 2024 11:41:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AwcqUrrRldUwg/fZ1qQ/8sQz093FftCiU2Qe6v
	sKGxo=; b=EY5FgVxyu3xEUbWCmc1QewxJsfWA79LjVLuO9q/JYdHZJg3KnEPsAk
	vr6LS3GqN8DqSuvIvaWcHISdRrZGE5J26pzbi5TpBjaEoMuKZrjPhbWRvZgh94aF
	MLFi6+CTWS65xzQSR5ebFIdQSTZhvWBT5joCIiHnrkFdw5w8uI7NE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 84A432B64F;
	Fri, 15 Mar 2024 11:41:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FBC22B64E;
	Fri, 15 Mar 2024 11:41:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Chuck Lever <chuck.lever@oracle.com>,
  git@vger.kernel.org,  linux-nfs@vger.kernel.org
Subject: Re: t0032 fails on NFS mounts
In-Reply-To: <ZfOXz81cpGZvq6Pq@tanuki> (Patrick Steinhardt's message of "Fri,
	15 Mar 2024 01:35:27 +0100")
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
	<20240313072052.GC125150@coredump.intra.peff.net>
	<ZfOXz81cpGZvq6Pq@tanuki>
Date: Fri, 15 Mar 2024 08:41:30 -0700
Message-ID: <xmqqmsqztsd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F45619C-E2E2-11EE-8B4C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Unless somebody else beats me to it I'll investigate this next week when
> I'm back in the office. Thanks for the report and for digging into this
> issue!

Thanks.
