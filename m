Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EF60B8C
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929873; cv=none; b=EVriLI9vUIp+Lub/zGLBMmWdvyCiNUMTvUTSElCLHZsK/16no0w7ddgbcaQDpiU/6G9VeKRzEnQIcS7vMlM27nrZSQ2ilXC+9Dz5AbvrwV5s33dewIljD4xH0vIuXJPtKwxA8w79QEiyQLEvg984yrTCzBAqM6iObLCdhDXLHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929873; c=relaxed/simple;
	bh=Zckh61M7Zf0ACfZnriskhGOt2r2mXXRLevGvjWVXNzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6ZzGeiLSnyxu+EIahpi0Y+DAZ+j6gY/+F559z719cjc/imrmv6ZWDPLHXPUtY5khLc3v7sgNjOFc345ob2dlpps189Zf3TJVVLI2rHVwpN7d87i6xF/7A0VXRmgfwRMIEAVKhs35/YEa34Xe5t3/MNUFpJv2jTCBDJEubK1BuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jzQRkPsk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jzQRkPsk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E42B522393;
	Wed, 14 Feb 2024 11:57:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zckh61M7Zf0ACfZnriskhGOt2r2mXXRLevGvjW
	VXNzc=; b=jzQRkPskSTmmCF0ePoQpIwKHvaszrTd+hbYGeSzfkHRIcsiIOgrSFz
	1dYjJsPnnMvNG+XTYx09GoBQiH1J52HklhB0bk+fYl4t1u8ClrEPVuk365UJ3V8H
	HulOODDF/c56fAsVNhhdVn+faBrg4T3BUw73waN2U4E6Ydr6TvaQU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DBFE922392;
	Wed, 14 Feb 2024 11:57:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 836F422391;
	Wed, 14 Feb 2024 11:57:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2024, #05; Tue, 13)
In-Reply-To: <CZ4WA9QJXMX2.3BK6C9ZGOSN7A@gmail.com> (Ghanshyam Thakkar's
	message of "Wed, 14 Feb 2024 20:38:31 +0530")
References: <xmqqo7cjzhl0.fsf@gitster.g>
	<CZ4WA9QJXMX2.3BK6C9ZGOSN7A@gmail.com>
Date: Wed, 14 Feb 2024 08:57:47 -0800
Message-ID: <xmqq5xyrx9tg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2EAB4A8E-CB5A-11EE-8393-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> I see that it is already in 'next'. However, I have rerolled it for a
> single line change. If find it is worth it, here it is: 
> https://lore.kernel.org/git/20240213000601.520731-2-shyamthakkar001@gmail.com/

The usual procedure is that once a topic hits 'next', it gets
improved only by piling incremental updates on top with explanation.
The idea is: if all of us thought it has seen enough eyeballs and is
good enough for 'next', yet we later find there was something we all
missed, that is worth a separate explanation, e.g., "The primary
motivation behind the series is still good, but for such and such
reasons we missed this case we are fixing."

Unless it turns out that the approach was fundamentally wrong and
such an incremental update boils down to almost reverting the
earlier one entirely and replacing it with the newer one.  In such a
case, we do revert the earlier and replace it with the newer, in
'next'.

But as the development community members work across timezones on
their own pace, mails cross and mistakes happen.  I've reverted the
merge of the previous one from 'next' and queued the new one (I do
not recall offhand if the updated one is already in 'next', though).

Thanks.
