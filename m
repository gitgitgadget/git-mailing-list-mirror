Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED078F48
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773978255; cv=none; b=tX5p6KN23wg8vJoyoFVueO+LroW3fIs3pTcBgJ0JKqafnAwoE1wORwL8/yegRb0t8KQOZBIhHeGwEBdZ1AsoRGHvJI09mBuVuy2dqQvr2qzus49tX7iAE0Km2eYH0b5ZWobhFR+8UNoIQOT+NRnV8olYAX8QVxsMM6dx5zYgnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773978255; c=relaxed/simple;
	bh=KO+5c+2vx2CiVvM9IXe5rC3xNoUwxIbhvu1u0orsIBY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s6OeAtOkfl9FiV/7Y9B3tN2ckP38S1rx11va2P88wYLl52aG0KGxKaOU8r+1ombeDilsHMNBpYo1cMezPce1MZKnX3MFtGgpx9ygnL7qfbRfnDBP3BbfrGvYb9TU0BK2W7Z7choqulsbm/J1arO4f4aTHNOzHunrIF2Fu3myxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=W7jZ7yx/; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="W7jZ7yx/"
Received: from [192.168.1.75] ([80.189.83.109])
	by smtp with ESMTPA
	id 3QmPwlfrn9QrZ3QmQw2LIE; Fri, 20 Mar 2026 03:44:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1773978250; bh=9iupao1OBtVhGTvhIGtFcfG1aAdvz/Z+FhT1HnuRdyY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=W7jZ7yx/Jks9SASHuNCPlPdxJUALIMRCkXcsFW61VZUv3Vjo1UnaFDOoGpxilLkl6
	 IqmQxnfXmFKQDfYd1DS9Y1PSKFoYH5hrz2ROdsftQAVyew8aZgOOPW+VH1eADeOdcV
	 3A0CC5YXhp/M3IyZKh6NESaDbcaWN5NlfbPH5fwsIjf80CN/QsVS0I9GoF3aRH5zkn
	 S3UQ374CsfMONOaIkJBsdEeM1ZWOTanU0TyUFE12n6R4zrfWwNHiWL3KU3YTMWkQsY
	 9cNsavDZ/s1kJvSE54wlVlnJz9AF8pMxz/x4nGfx/xIw4GY1H0FBiccSMNmacepn7F
	 Z8Jlu5L2ZAGdQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=C9tKyhP+ c=1 sm=1 tr=0 ts=69bcc28a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=rxMHnOnVEnHJyY_EC4cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <12187836-0b2d-4e82-ae0c-4da972aee7e7@ramsayjones.plus.com>
Date: Fri, 20 Mar 2026 03:44:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [PATCH] object-file: fix sparse 'plain integer as NULL
 pointer' error
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>
References: <97c623fe-4e03-4fbe-a6af-9c01c101bae4@ramsayjones.plus.com>
 <xmqqqzpfgu5s.fsf@gitster.g>
 <b2656d8c-7878-489e-a78b-ecb441570bf6@ramsayjones.plus.com>
Content-Language: en-GB
In-Reply-To: <b2656d8c-7878-489e-a78b-ecb441570bf6@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHpfLer8JO+KHE0UalI/WPULxn/ZKhyDE2uygOPkzj9q0LEjLPk1U95/8by0mvneZuZbcMKxn+8wBub9T5hUzSwzXp4Gmz3Xmr+R1siJL53YwLeuyEgk
 726yU/52QvXRXVR4nUk7zqUf+wRxPuP4jDkQxgYyDZAMgLPum1sadpYpwuhgn3XJiOyr5eRoBETMu+Tyzxd4ACl8zrPHFHXEAQw=


On 20/03/2026 02:04, Ramsay Jones wrote:
>
> On 20/03/2026 1:35 am, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>> ---
>>>
>>> Hi Patrick,
>>>
>>> When you next re-roll your 'ps/object-counting' branch, could you please squash this
>>> into the patch equivalent to the commit 2b24db1110 ("object-file: generalize counting
>>> objects",2026-03-12) in tonight's 'seen' branch.
>> The topic being in 'next' since March 17th, that is a bit awkward to
>> arrange.  I can queue the fix on top instead.
> Hmm, odd. I didn't do a 'branch --contains', obviously, but this only started tonight
> (and I built git yesterday - master, next and seen), so I just assumed ... ;)
>
> Sorry about that.
>

Heh, I could not sleep, so took another look! :)


The problem was actually caused by the 
'ps/odb-generic-object-name-handling' branch and commit 936c2bfecb 
("odb: introduce

`struct odb_for_each_object_options`", 2026-03-19). In particular,  that 
commit changes the type of the last parameter of the

odb_source_loose_for_each_object() function from 'unsigned' to 'const 
struct odb_for_each_object_options *', without

changing one call site from '0' to 'NULL'.


OK, I can go to bed now!


Thanks.


ATB,

Ramsay Jones


