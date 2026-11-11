Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405746;
	b=b3zQmmy55RbJ2fWt6xKeCsi/SPIk2IaLmueJaMQRrXzxGykKrROZWapT1ebE15lM81gC
	 0NO/s18BHng0FG53JCDZCkPX0VTTX3nMGjtpWdbUg3At8hgq3nKO0fbQjTrwKMnww3tIH
	 v12nlxyapIF9aDT08b+C5bFdVPW20jQuVgtsMSsOKHyOrdR0fT2KCXwIi1NkAHLgK3xV/
	 vduhTOgXpCxJNnGQ/Ev3ZOP9R0/qz68U7cxYToCee1BNgb+Qv+ImtggUAS4MuGbti2NiZ
	 GNnsWURmbVNN6/sDUi5H7+EBjd67FG/XMO2so1E8LrzoYMMPNo7KxZ3ekWQnp2nZKlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405746;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=ySc4lWRGLhEifVHfYRuTPvVI7k8b4IwRMmgWC3tUZXY=;
	b=J2ZvMOyC0549Lvz+YVyYXa/Cq+UqTwGPwLJ1XDc5snt0jYKkkeOtSjEYGnPDnsFUj7l6
	 5Kus/Eipnbx6lvyyy7lzVRkYcxExWzk+kAw0nWwz5pC1gdylxHQ1Z4mW3JEdfG//QLDQs
	 Ut42hQvJXleAty8XddU7k4GmTs1JRJANc9aQeIDwxZZiGAj+8uiZtxn2B+p0KU033kRwD
	 9v5bIVD426WtoOi+iyPSyyH02xj/Bo6A18eF6hrs0ag2phDjDrMfgLAoOO2Qnuywm+CMb
	 VnoOYkvZKTgAlXBfMjMeNlrkqMtwn/JY996fYEiAZ2o/utnQlwDPipJUMeeLSQtxFmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=G3vYyh12;
	arc=none smtp.remote-ip=95.215.58.235
Received: from mta1.migadu.com (out-235.mta1.migadu.com [95.215.58.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82B606A326
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD82B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=G3vYyh12
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XJdkdZlBZ9Sqo3aP6nj+HWSucmUgNS09j30eePiiMp4=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794405742; v=1; x=1795010542;
 b=G3vYyh12fatbsNNojYus8oXpG4EQbxT2+gYERA/PfoBFq5llkBhMkv44zZp4j+4TZ0XpucOf
 IC6ETRylApYSCypk9iBvlYS2+iaOO1lEn88Jbg40BZD6GCsSvGGUtzynGwp21bEGGQoGjwX5Bg1
 xIwj1XJWNQeY8eLfBibF6PxM=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id ee4f997432083673;
	Wed, 11 Nov 2026 14:02:22 +0000
X-Mizu-Trace-ID: ee4f997432083673
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Todd Zullinger
 <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Linux Kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git 2.56.1 and friends
In-Reply-To: <e12a9cd6-d61a-4e80-a459-954c4b26724f@gmail.com>
References: <xmqqh5hosgw5.fsf@gitster.g>
 <20261110221253.DBFncUIG@teonanacatl.net>
 <e12a9cd6-d61a-4e80-a459-954c4b26724f@gmail.com>
Date: Wed, 11 Nov 2026 15:02:14 +0100
Message-ID: <874idn5uvt.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

>>>   * CVE-2026-113408:
>>>
>>>     It is possible for a server to advertise an unborn HEAD that contains
>>>     path-traversal characters (e.g., `refs/heads/../../../TARGET`). With
>>>     the files ref backend that can lead to ref-updating actions to write
>>>     to unwanted files.
>>>
>>>     See <https://gitlab.com/gitlab-org/git/-/work_items/809> for details.
>> 
>> FWIW, this and the other GitLab work item links appear to be
>> inaccessible to normal users.  I'm guessing that's not the
>> intent.
>> 
>> I added Patrick to the Cc as one of the folks who may be
>> able to poke the right folks at GitLab to open them up?
>> 
>
> Thank you for pointing it out. It was indeed not the intention. Those 
> work items are accessible now.

Yeah, I was planning to open them up ASAP, but I wasn't around my
computer around the time this release came out. I did open them around
midnight CET. Thanks for pointing that out.

-- 
Laters,
Toon
