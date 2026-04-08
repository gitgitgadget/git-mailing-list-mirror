Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A613B19AB
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667548; cv=none; b=jQz4ZAp/fwplU1+9k8Yih8Kcm3RF6gZIcXJYHQx2Z14hZF9ojI86Go+WK5aDjlUV0gZUWzWJnaeoATFADloAZ56r6TgHmv8CqwgqXs3vjGNiar+/w7mis9qiv10fOtfhJPSi3gckPUiFBYl9ObD/AmQR1qp8FKNG2w+m4khi/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667548; c=relaxed/simple;
	bh=oJWMQ0gKDiKnATDIMb/nbzNa8ajsCqR9MjqXUb0q8zg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tHPI/j5dPL2JFO8JbiP+GL90h1H5LCA8rt2h2ozdCh6awpBQysztxpZBs0dtKl6kg0Fa1NqyWl5qAbVODjScvvhMiQryWkOrag72IbXnYLM6mKDW8VUSY2OX+GFlqZ2CtX1L2OGy8nNcMAj0waLXLpqjLcZ7MDrMIeL+QpAlLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638GwxZw3318776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 16:59:00 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Adrian Ratiu'" <adrian.ratiu@collabora.com>
Cc: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>	<20260408052031.GB1324339@coredump.intra.peff.net>	<20260408054347.GA2284358@coredump.intra.peff.net>	<871pgp3byq.fsf@collabora.com> <xmqqcy091jht.fsf@gitster.g>
In-Reply-To: <xmqqcy091jht.fsf@gitster.g>
Subject: RE: Help needed on 2.54.0-rc0 t5301.13 looping.
Date: Wed, 8 Apr 2026 12:58:54 -0400
Organization: Nexbridge Inc.
Message-ID: <013c01dcc778$ff106620$fd313260$@nexbridge.com>
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
Thread-Index: AQHvBjVJZsXG7N1gHKdCJ4V3u2kT9AFYabqHAkdaE8oCPPreZwKP8L39tW1/6yA=
X-Antivirus: Norton (VPS 260408-0, 4/7/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 12:54 PM, Junio C Hamano wrote:
>Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Thanks Peff for the in-depth analysis, fix and test.
>> It is very much appreciated. I missed this case.
>>
>> I agree with your assesement: this must be fixed regardless if it also
>> fixes Randall's case or not (might be a separate root cause).
>>
>> I would proceed like this (obviously crediting you for the fix & test):
>>
>> If it fixes Randall's case:
>>    send a standalone bug-fix patch, then integrate the test into the
>>    parallel series.
>> else
>>    integrate both the fix and the test into the parallel series.
>>
>> @Randall please let us know if the fix proposed by Peff in the other
>> response works for you.
>
>It sounds sensible, but a standalone fix early before 2.54 final, as the
problem and
>the fix shown by Peff here looked correct, without waiting for NonStop may
be
>simpler to work with.  Then, rebuild parallel series on top of the 'master'
that has
>the fix applied, perhaps?

The fix works on NonStop as previously supplied. So I'm good.

