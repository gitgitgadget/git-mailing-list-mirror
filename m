Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBA3B7A8
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070206; cv=none; b=nyiUku8whp59x7fvCOnrhRP8Y0En57dPySS8et/JplIzvsnD5exKUTPDA3qFeynagAdNunYP7urLSZg6pZOGOGRTRBBH56FIFwtw4O1jdeBoPV1bO183FLO2jDQh53Yoxg0Osn7JG7t5sNEnWPdbcsQTLUODz7icTSd9VdvbWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070206; c=relaxed/simple;
	bh=rhEzM/+42qNCj9OenlggNoNOY15tscoU3AdN0SFcMr4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dXAj21SOZU4jIUJtq029vdxtlwSTn0cUU1ysGFBq//tAgQPWT8lwHN9/KMElEDCIB4696Vo5bAxq9mZxzqvVRvTLkggx2N3oIbwdvRNQiZIKaClnqGS6JF5ZKkICwvrNmHFLZjQ9g/eZVKcp2LRd8N4nct8EljUmxRcZPAXpgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46FJ3HIb462359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 19:03:17 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>	<xmqq8qy4adl4.fsf@gitster.g>	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>	<xmqqttgr9aeb.fsf@gitster.g>	<ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>	<004501dad61b$b35b7f30$1a127d90$@nexbridge.com>	<ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>	<xmqqv8167kd8.fsf@gitster.g>	<00af01dad6cc$41f10d40$c5d327c0$@nexbridge.com>	<xmqqh6cq4ngc.fsf@gitster.g>	<00c001dad6dd$f336c3e0$d9a44ba0$@nexbridge.com> <xmqqsewa33pc.fsf@gitster.g>
In-Reply-To: <xmqqsewa33pc.fsf@gitster.g>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Mon, 15 Jul 2024 15:03:12 -0400
Organization: Nexbridge Inc.
Message-ID: <00cb01dad6e9$a73085b0$f5919110$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1AglWfbcCCOoxCwFeXAgQAPqT5zMCVerbsANm6pyfAUDhh9oCbYW5kgI2/J1PAdQcdhmvHnaTcA==

On Monday, July 15, 2024 2:34 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>As I speculated earlier in an earlier message, the breakage you
>>>reported
>> may have to
>>>do with interaction between "local" and use of a subshell, and perhaps
>>>we
>> can also
>>>check that pattern in the test.
>>
>> That is that I am also suggesting but did not say it as precisely.
Thanks.
>
>Oh, I see.  Are you volunteering to come up with a minimum addition to
t0000.1
>then?

I'll have to give this some thought on the best way to verify local that
does not break the various other shells. I only have a limited set (ksh,
bash). Maybe someone with a linux system might be in a better position.

