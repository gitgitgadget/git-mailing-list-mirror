Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74515EA2
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370602; cv=none; b=omqMcqmJp3EjYTZKiHFcoaF4eaQM7kzzdorCQYkMjEGcCOU6xWYrJrlWurhm4fLPEVk3V5blDDQJQAYfwzLL+HMHZRnICS4PDBK2GJE4hM+pMcKS6o7i/yKcuBDOs4ogaWmRVI89K/el/6CYVdWGkkThYylIT+F+dvMcaU1GzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370602; c=relaxed/simple;
	bh=dtpR9+hz32kbB3XfgiSPL+K5QI1dHTe044VYHAHs3Qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vEG8A5OlTZTADdziXisK2+mrJvqLp/AJy44nT+baUJ/+Mv/Gy3gKv1NouoKeL5/qhCqEmtGq58owODhxI4dXQj/rO4r88EFeph74wD3YnzeAlBl1hhn2frekUuXNluMCm4tAJzrFZ1bQWEOfPHlDJh10zg9HPIpVRbAViXG9Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oPR5aLLR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPR5aLLR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FBC628983;
	Fri,  5 Apr 2024 22:30:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dtpR9+hz32kbB3XfgiSPL+K5QI1dHTe044VYHA
	Hs3Qs=; b=oPR5aLLR3Fwi1XdQMbD+mrmcdIBZSwVdxxIb3xigR29B8nUjoPoypK
	t+IISNbC+Pqe8EENy5yYSxley+IWm8mhmarUXClrI4L56BbTnyKqEmwOZn+Jdi2d
	t3Qx+/9Gu8ZJ5lY7p5A+kajK8XSfc+kgTd4dv11bv15GfBi2PQWP0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 089A628982;
	Fri,  5 Apr 2024 22:30:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79AE82897F;
	Fri,  5 Apr 2024 22:29:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 2/6] CodingGuidelines: quote assigned value in 'local
 var=$val'
In-Reply-To: <02c801da87c1$eac025f0$c04071d0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 5 Apr 2024 21:29:44 -0400")
References: <20240406000902.3082301-1-gitster@pobox.com>
	<20240406000902.3082301-3-gitster@pobox.com>
	<02c801da87c1$eac025f0$c04071d0$@nexbridge.com>
Date: Fri, 05 Apr 2024 19:29:53 -0700
Message-ID: <xmqqplv3p6ji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8E32FA70-F3BD-11EE-B05E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

>>  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
>>    "\xc2\xa2") in printf format strings, since hexadecimal escape
>>    sequences are not portable.
>
> I can confirm, at least for the set of platforms I work on, that printf with
> hex values is definitely not portable.

Sure, that is why we have that rule that we see in the context.
