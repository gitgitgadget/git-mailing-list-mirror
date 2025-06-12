Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC61A5B92
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700455; cv=none; b=Jv2Gih+4IJIYreZN/gkfIqdhkIOz29VqfrjvRLzvPIB0opSDKyNirgJgx8wHCPxewccuePZOWy/6prwxomCqwVEZqO/51QxUwq8QIPpCQd6Tcd6dT3Wzq2hU5HLAlvzj1dPc2EyT/zps/gx8ccCki80YrCye9fKBJSlFYqmQRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700455; c=relaxed/simple;
	bh=me6QaOoj0cLux/bFAu1x9f39a+h/mXvyzU4xkkiqjiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/c64OWE8rhshw4ghrIq8QGnSCTlQW+PS+9dyBZZ1SCr0Yk0ao4jNP2SWSXqO/KcuccE4MoRiaf2VxsAmlSTfrCFvB0XBRm6ejNyFk5Wa1XgyD31LeHKu/rq9KZ1uvBFwVvF6LfCYWfNerkwLgL+BwqofW6B8fQCK2N5Lsz5Q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=Dc8GmxT1; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="Dc8GmxT1"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHpYc70m4z8PbP;
	Wed, 11 Jun 2025 23:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=me6QaOoj0cLux/bFAu1x9f39a+h/mXvyzU4xkkiqjiQ=; b=Dc8GmxT1JaPz
	rTRFuTAItlUYuxIKk8HLeril9B19cjTqufoAWiIAPtAFMUqNoe7cNAWr8KLEz4Id
	JcSUvzXsXUnPMyzsyqVFCuE9TXl/iXS3/oNNSjYjlWqvURlDMDnOcfGpSt31G7/r
	StP4TUgaGlQ00TjLGVIXhPwR2uOvSQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=U44
	4NgkYsE6soDNN1yy3ngoweB8xHsvsx4srxSxBgK0IKoGvLk+9lF7sww1//826VNF
	zmqHHQK+CYj79ycjkAOLL5Keb1hlnbC3Ur94xvOqKxZ8AXTKXIZ5D2CSoUo8HH8p
	PXUqL/2yJrPNcq93fFXBsg7zZ3oJqA41huDdQ1Pw=
Received: from [IPV6:2001:470:b050:6:142d:4b81:8fea:90b2] (unknown [IPv6:2001:470:b050:6:142d:4b81:8fea:90b2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHpYc6QnRz8PbN;
	Wed, 11 Jun 2025 23:54:12 -0400 (EDT)
Message-ID: <ddb50b73-8f98-48e5-880b-b991508edea3@comstyle.com>
Date: Wed, 11 Jun 2025 23:54:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: update settings for FreeBSD
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com>
 <xmqqsek5fwnu.fsf@gitster.g>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <xmqqsek5fwnu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-11 11:47 p.m., Junio C Hamano wrote:
> Brad Smith <brad@comstyle.com> writes:
>
>> FreeBSD 6.0 has memmem().
> And anything older than that no longer matters?

I look at is as so. 6.0 is 19.5 years old as it is.

> That may indeed be true (6.0 was from Nov 2005), but if that is the
> reason why we simply lose NO_MEMMEM (instead of conditionally losing
> for 6.0 and newer), that needs to be explained in the proposed log
> message, together with the reason why we no longer do anything
> special with version "4.x" (which could be "We ditch the support for
> anything older than 6.0").
>
> Assuming that our stance is "anything older than 6.0 no longer
> matters", the patch itself looks good.

This was my intent. I'll update the commit message.

