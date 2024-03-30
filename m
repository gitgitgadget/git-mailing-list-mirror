Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F691E898
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711835050; cv=none; b=HoN6xQX8pP2NFLMeqqkZYgHY7XShN+ZnVfL+ntfueZSP4/RKd/YvsYuBKQv9MuCnfanjCsQUI/jdkR26HrcXAB3/VzvQiU2Ylf6Z9sohlZz8hb6gxz3uzCt0KdJ0/IZiSiEi4TkZMW7AYdOT810BnkI88lMS4K+3naUBMVKrqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711835050; c=relaxed/simple;
	bh=SP3MBmxCiBJbzyt6T22D0Izf8OMrSU9k3UGjHg8SyNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=swjNhhZ4taEFTIyQy+E3ImZ5g4f0DszMdyG8ERlQzIN1dDGBPonw9Uj3mYqfYOfD0ZPUWfm5KaVUyZg0fprgtYIcsTkDKIHer0OJqPin2kfXp1nAW/GowFXrT4HKV8C+KQskx4GDi06FaTxzzkDeSMept1o8ogBtajlhPoAp62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rsq0zGzI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rsq0zGzI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C1B1818E91;
	Sat, 30 Mar 2024 17:44:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SP3MBmxCiBJbzyt6T22D0Izf8OMrSU9k3UGjHg
	8SyNk=; b=rsq0zGzIhabXai7RXwy67cfFqMcMtS7Nq/2p5/JZpgxQQMdyAxM50s
	Kg4j59KBWDuAw2SCqev0JvhBjDkPQmmwMBYKOkpsubkHj1cRMor6v5MA9p/Z0DPR
	IGq19k/7lwqwQ6ULra2zyppDw+XyJgjoMDAXa2BoeTpQ51If55pQk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B922618E90;
	Sat, 30 Mar 2024 17:44:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 21AC118E8E;
	Sat, 30 Mar 2024 17:44:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] RFC: add MAINTAINERS file
In-Reply-To: <owlyr0fr61hy.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Sat, 30 Mar 2024 11:03:21 -0700")
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
	<xmqqsf0gvjrg.fsf@gitster.g> <xmqq8r27nhwo.fsf@gitster.g>
	<ZgPIEgFGVokYWc-H@tanuki> <owlyr0fr61hy.fsf@fine.c.googlers.com>
Date: Sat, 30 Mar 2024 14:44:03 -0700
Message-ID: <xmqq5xx3l7j0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A14EDC8E-EEDE-11EE-B414-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Sun, Mar 24, 2024 at 07:51:03PM -0700, Junio C Hamano wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>> [...]
>>
>> I would thus reformulate the proposal from "MAINTAINERS" to "REVIEWERS".
>> Instead of saying that person A is a maintainer of subsystem B, it would
>> say person A has a keen interest in subsystem B and would thus be a very
>> good candidate to Cc in all your mails touching this subsystem.
>
> Good idea!

Seconded.
