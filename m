Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9112E7F
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244125; cv=none; b=O1KJii1ee8QbhWzo4CfGnlHuIn2GD58+ptjGbLUgBq8urs54WqPUvXK2HFlay+AXYt7gZ4yPdXPkzKyz7hyG92SffBz+OJHVJ+TdX5vyZ6app/O+UHdUxhioF9IZ5KejBy+0NVbTG5vsU5HYLby1pm2wJNtL5hnyW93W5k98LDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244125; c=relaxed/simple;
	bh=WuDw9aLt+cwjxkBprCrFSOtCPG6ipvomgMApi11NHYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EmoMWLLQQ/U0NPOHJEzP0O5sSxDU1LRa+2oqwZGOvn35G+O2ujI/11vHehuIhUT9GXH5XtkwewduhdeG/QJqi1fNKm1xTa/HbHW5uxylNhUtnpHposNQdg/pDMghQZ+UvSV/8jFMdAQrdRAGWAmqWgnAYlBtzxtgepqlfGrujjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eqsQ0w1t; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eqsQ0w1t"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EF951D342E;
	Tue,  6 Feb 2024 13:28:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WuDw9aLt+cwjxkBprCrFSOtCPG6ipvomgMApi1
	1NHYY=; b=eqsQ0w1tVtLka68ywyKmh54ks4E2qKCiIAWOH9KSfXaZVG3778lo7y
	o5GJVn/XTv1Nh/zX40H71KcqZ+DRI46UDmKDZWWe/JtyNNJt4Yirh2D8HqFnRxhz
	urOUWarVZPwFC8eKerl3rmEBsoocv6jxqtJtwLm6xGFNKvicMkejQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 274E21D342D;
	Tue,  6 Feb 2024 13:28:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89A281D342C;
	Tue,  6 Feb 2024 13:28:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kyle Lippincott <spectral@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH] branch: clarify <oldbranch> and <newbranch> terms further
In-Reply-To: <8f588db87929b063462dbf4ff134adc7@manjaro.org> (Dragan Simic's
	message of "Tue, 06 Feb 2024 04:32:57 +0100")
References: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
	<CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
	<xmqqttmmlahf.fsf@gitster.g>
	<8f588db87929b063462dbf4ff134adc7@manjaro.org>
Date: Tue, 06 Feb 2024 10:28:35 -0800
Message-ID: <xmqqle7xih0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8AA3DE02-C51D-11EE-AF97-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> I think I laid all this out and more in a separate message.
>> https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/
>
> I agree about this as well, but that will perhaps be handled in some
> separate patch for the git-branch(1) man page.

If you truly agree with the longer term plan, which includes removal
of the bullet points your patch updates, then reviewing further on
that patch becomes a waste of time in the larger picture, doesn't
it?

"Will be deferred to some later time, let's take this small update
as-is" has already been said back then.  Let's not do that again
this time.

Thanks.
