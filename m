Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941D143C70
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392292; cv=none; b=mVCmhiJZzW9etbUtlXLbIob4nkhwGfPKYvKrXaj35rs+zGcb6IfdpA+G+M71NEN1EB8/p+8l8nR8am8DHWKO2VfPGevE42H2dSPPc7+cpG1+zdwoFSQ1Pr/sf4KC/8FDZ2xXqzqehR4+4DNCd+WrvrjyvVjgKJPK2L7QHa8l8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392292; c=relaxed/simple;
	bh=FkisA85Uso68H6i4UVEuj4f85YvpIZhv5IHtRoXXAqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cGwCWrRVAScecesJ2DL5zkQGYHFk0M0t7M/8b8xt1EYJV3HPEhWoQJxBxonVeE3yWYobXU/S/voI2uXVyXm6XAlmWvbloUO/EnS3NOLlTZtMyFGvmyPpPsW0Gw2/NLkLbvlwMfEG9j5KxWbdybGpQ9V+iX1jxxf7vuyymg78nSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=pjsc7RjR; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="pjsc7RjR"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C16BFA0403;
	Wed, 26 Jun 2024 10:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=uqK2HWZzU5ABDaPLjH9G
	30poCEIVKpieyUYzp5pmvRI=; b=pjsc7RjRRFgmnfh9zK5hRpNpeFBBo8W9075p
	UpTNbhapCmrPKTeqzH/+cySrQfS6kGGzRaUw/TuOTBd7dPuuAzZfQ/0hRjF4pcZm
	g3Fl/9qZqm3q3iCfp9l8/bYwGKDA2CFZaLHdiDHOb5H2CxabnTqRVTt7Q8QOdZcO
	jMYNXSSUlXqkzIUDSfsyWM0FESc15TrdhvwqTbraDPz03c+J6QPSSYQKy0JiRLdY
	l6LS0e5/bWc3x94RTNUgvZBCYSjl7e2+489bnkPdu16vEqkWH5h1TO/U6NnZX/mV
	fs0qjU6DRxdm0elW11abU9ESl2yXZKO5+EDIyMo9az/Pmyv+W8fgiBM5a5RCD8Nt
	kF9ptmdvXn5JpCKXU6wXjw89NgZLZsnHR62mvO5OfM/sIOnQ3dT/D33jQgDtwvGG
	bGu0Fcn4BgFDtnYlm+DedbSYMaJ95USlcgY6c1YzPJd+Yy4jzMs8XOMnEakUWw7T
	TYlhhxZgruMHmIcmOntTEUjbi4n7KeEOapGocwaJZyosRKflmNRxRn8+iFxI1OGd
	piN9CFZ/kU/EkI9IeNYo8aw+0nUJyOdy1dACLfBKgzN08WgV3DcekGq2Z4z2kICa
	i/0aPTVRCUMHu1T4dpDcyFXl+2+5K52R1/zvbg5XWPrEEUF5+me2nQ7eojLwVvAH
	iYHRYIA=
Message-ID: <202fc42e-c5be-4a4b-a135-302d8fbf6b2a@prolan.hu>
Date: Wed, 26 Jun 2024 10:58:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend] git-send-email: Use sanitized address when reading
 mbox body
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
References: <20240621092721.2980939-2-csokas.bence@prolan.hu>
 <xmqqr0cqmck5.fsf@gitster.g> <a55cc932-98b0-43cd-9dfa-ea21a4340bf6@prolan.hu>
 <xmqqy16ue3vl.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <xmqqy16ue3vl.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576C7065

Hi!

On 6/24/24 17:50, Junio C Hamano wrote:
> another sensible choice coming from that "strings on trailers may
> not even be addresses" position may be not to add the $c to the Cc:
> list, if $sc (the sanitized address) and $c (the original address)
> are different.  That is, "the simple regexp check currently used to
> trigger 'Ignoring ...' message thought that the string looked like
> an address, but when we ask sanitize_address, it turns out that it
> was not, really."

Maybe. Though we would need to run through the sanitized address through 
`unquote_rfc2047()` first. But I don't think it's necessary; if someone 
feeds us an "unsanitary" address (for instance, there is whitespace 
between the angle brackets), we should try to make sense of it, and 
worst case, the SMTP server rejects it, as it does now.

> In any case, if we were to move forward with this topic (whether
> "send to corrected $sc instead" or "$c is suspicious, do not add it
> to $cc" is picked as the direction), the motivation behind the
> design decision to treat the address taken from a trailer line
> differently needs to be explained better, I think. [...]
> Your proposed commit log message is the place to help them.

Okay. So in short, I should add justification for trusting mbox headers 
and not the message body, correct?

> Oh, before I forget, is this something we can test easily in t9001?
> We would want to protect a new behaviour from accidental breakage,
> so adding a test or two would be a good thing.

Maybe, I'll look into it.

Bence

