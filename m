Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034622DEA73
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570238; cv=none; b=Yqs3JWywwWK1GbHENXQeCT0oT6kYIhx9cbrL7lXfNOW/HyjiQYSP/l9eBhUVBWsDapqCB/A9E40NzxuEoa3F8RT4szOCcUQZkEPllKtJHh5BohkqSuOzs0kXPJFo18etY0iCrzLBluLi5Mzxnq4gFJL1bPIWiTxj1Eur9Q8Fl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570238; c=relaxed/simple;
	bh=P8IMAboUaDbO3mkFwWDouTzgp3wExVlP8gAj/etLnAM=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=F9cKbAIoopT6XWfMx/0pdSt3zQQPDBhezOCafZ7LLFKYgRQerVjtPS/pCK5BGYo9yFglcKrnQCs2uFcTUTto70hI/V4vX6uWPVjkI2wFKBwxjlX83OSfhlwOwUuNoDpGzgfmXPO8WZjVlXs7AKb40C2ifb/fY91l262jTYgCna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5AJGbBbV1828453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 16:37:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        <git@vger.kernel.org>
References: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com> <94d81164-5af5-471e-a403-f2d544796d18@app.fastmail.com>
In-Reply-To: <94d81164-5af5-471e-a403-f2d544796d18@app.fastmail.com>
Subject: RE: [BUG] Test Failure 2.52.0, t8020.16,19
Date: Wed, 19 Nov 2025 11:37:05 -0500
Organization: Nexbridge Inc.
Message-ID: <004c01dc5972$c145e780$43d1b680$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFDHHm2se7imlkNauYXEvAe+CtXBwNzej23thEQa7A=
X-Antivirus: Norton (VPS 251119-2, 11/19/2025), Outbound message
X-Antivirus-Status: Clean

On November 19, 2025 11:25 AM, Kristoffer Haugsbakk wrote
>To: rsbecker <rsbecker@nexbridge.com>; git@vger.kernel.org
>Subject: Re: [BUG] Test Failure 2.52.0, t8020.16,19
>
>On Wed, Nov 19, 2025, at 16:50, rsbecker@nexbridge.com wrote:
>> The following two failures appeared on NonStop for the actual =
release.
>> I did not see them in -rc0 or after (doesn't mean they didn't happen =
after rc0).
>> To my eyes, this looks like a real issue not just on NonStop. It is
>> 100% reproducible and is not transient. The build is with OpenSSL =
3.4,
>> but that should not matter.
>>
>> expecting success of 8020.16 'cross merge boundaries in blaming':
>>         git checkout HEAD^0 &&
>>         git rm -rf . &&
>>         test_commit m1 &&
>>         git checkout HEAD^ &&
>>         git rm -rf . &&
>>         test_commit m2 &&
>>         git merge m1 &&
>>         check_last_modified <<-\EOF
>>         m2 m2.t
>>         m1 m1.t
>>         EOF
>>[snip]
>
>Also reported here https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-
>defa3a051087@mit.edu/

Thanks. Like ships passing in the wind =F0=9F=98=89=20

