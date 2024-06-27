Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A91770F9
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477827; cv=none; b=afBReDAfySe7HXmN48R15a8zA5gkZnxmxroImSsfm2dfVtceiswlbLBAoabohmwoGPbrhzMsnmTb/717fvahRVd04ZrKJkzEo7txRlpkxGPmB4RvTmHkHrdUBimXFdqpOkldhpEVBmnc7z/IgPbnDAZlADrDkfw5sQnXPciNcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477827; c=relaxed/simple;
	bh=juvkEcOSS3uiRcLdu/Y3vGLPTfFlEsWzs0DEMuyp63s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UuAXQ0qoFVbwCyNbHjFn00R0rv5BleAItSR4ADWkrKXuYqZJ3tx/Sub0P+c/nKIoGyX2avowX9CLjNm2eJlBX3Cz52ut/YPm6xvcJ2DLAcoVWPCr6FplPCRp1wgjiqtFhf3PwsoMaBW3Llb3sLtEg0+0eLiKZuujIDfJRnydhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=EYdz/u2v; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="EYdz/u2v"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 53159A03B7;
	Thu, 27 Jun 2024 10:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=0zoJ0qWb28M+vS/ma168
	5T2iVWng+6dSJK3twuteox0=; b=EYdz/u2vxNIQjj04mh0RY7Pi3nd8SfS9zX20
	Gp2Fx9QufI7oL2kLTbGeVi6qI929/0u9nn0ZDP4vcuFe5vo7+gc/lanc2un47suC
	qiu70eWXEHlKx4malJITxmKh9AIjZgQHHqJ1n43tL1RHxBm9QnY3sTKigzEkjyCG
	xQgSc8YFRlgjQj5Kb16vVm5oQiw/+hwk21BNwr/Op7HPfJMJh9S9buIFuZ0Fgxp6
	8UCnIby9H76vQHP6EDVEAFPeiA+VWS4IiWsvMAq6W8jZ6CDgFOf+8WZW+vsEsIhC
	PaZuN/KjXFQA0y0PpkF0sufBL0aAVC1SFGx1rEDKsT2ON/QPuoZPsHoyZKoosQJr
	PI1WQKaFbNgk2k0nSUy2X7FX3KPfFBdL82WMS1F5iMjMwdVNaJsLoecjJZIG4/m2
	JL0Fot2DV9PEZiZTtOXFUlUbEx+/itpHtTKHYMmLanhjGrua7uk0FGxQD/bnfbh+
	19GVRM7dRHBvJz9yg8pPZooh1yfQTvdHO8M+yefRgmcMjHFtPtJrWFv2bDh6k5Lh
	yasNblEBNnrKcCp+rICIGPb8JO2iFZ4VAyd4AACWxgzISe7XR3OGJu/NO9gip/rv
	W5Ab+ecFUToHWUR0EFIsfny0uTnInpg39x0u1sLTvKW1GC89MmFIKsWSOAYEM8F7
	JeDgXZk=
Message-ID: <f245c5e8-b986-49f1-91fe-7e24593e8e85@prolan.hu>
Date: Thu, 27 Jun 2024 10:37:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-send-email: Use sanitized address when reading
 mbox body
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
References: <20240626132440.3762363-2-csokas.bence@prolan.hu>
 <xmqqy16r1ulu.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <xmqqy16r1ulu.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576C736B

On 6/26/24 19:28, Junio C Hamano wrote:
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> index 58699f8e4e..7e0b8ae57c 100755
>> --- a/t/t9001-send-email.sh
>> +++ b/t/t9001-send-email.sh
> 
> This test uses mixture of test_grep and grep, so use of "grep" below
> is fine (but in the longer term we should make sure the tests use
> the former for better debuggability).

Ok, I'll use test_grep everywhere.

> As I always say, we should resist the temptation to write our tests
> just to demonstrate our shiny new toy.  In this case, the test is
> too focused to show that the system will give a best-effort output
> when fed invalid and/or malformed addresses, but it does not see
> what happens to a well formed addresses (ideally they are passed
> intact, but is that what happens with the new code?).  Perhaps add
> one or two trailer lines with valid addresses (and non-address, like
> "BugId: 143421", that should not appear at all in the output) on
> them?

Valid addresses are already tested by former tests. I don't immediately 
see any tests that would cover non-Cc, non-*-by and non-email-address 
tags, so I might add them; should they be a separate testcase or part of 
this one? Or maybe even a separate patch?

Bence

