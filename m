Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49B2BCF46
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462842; cv=none; b=Or1jBuvypxq3YgWVPr/pZB93bzgT1Dd33k0tDxAi7gWefrxhrDKkCpzFgpGmP5A4shYBU5+QMbkWvVP3SRvc1+nq/AR5nOmT5+xJN3DQsBIZrSfidhP5SmyRx5wKm1ko17vhgbsRi2rJQ1n4P1yue0fLTgU1uvfvYsHXoM2diu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462842; c=relaxed/simple;
	bh=j8gwG8LBVdHOJi26FoHRWM0ELj8/jLmGvWbtctAencY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqPtuuNGNC98N/5eao2Ky/EX9tYMbSpqOrzGiLMoYdeMWJY4tsqjTxQmiLhhrRbjenrZhx3ai6PjIgXVkc9T5xLWDxmry+oLOAL7GgIgI7KNeQ2ib/wUUEgRhjxXMHtup53B/1+iisXQj3nCzLP4sdOSYtT8AqLHXmL4HczRYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=rufAdBSN; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="rufAdBSN"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id H75uvHJUCYuioH75vvIXtj; Thu, 06 Nov 2025 21:00:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1762462836; bh=MwbGIjzoo0A9fIGTxth7TyB+e3nVgXPAW48xPnhfu3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rufAdBSNvUAj4fzPOtvu0EHJmyZejgGPKj30x48NrqwzdvJ7MUADxHmfzFAyfWn/+
	 52K6hAIhTAO0Xe1y6E2SkTJmzjFzWbHLcbly6YNd90NdKXBUq6ZnRiqPMCzo179ZvB
	 RTSi5V6gdK6RlKWfJfsMzMgjFgBvEquomSLpjHTRGo4tYHXj5/nGGPFAvQrkKx2gBj
	 fNplUjxcDWvZU9M7KTMFC1+cSncaHJ/eauB3LAdy0VzQKvZtCTDYXb0VLTktB9L1Md
	 9MOXwRwQ8bcRwv669uGmBO7sGC21gaejl2qpx1DmD6qXjK2/bj6Aje2UKz+YSsJ6us
	 1PWF2HoQy+CLw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HMRgFZtv c=1 sm=1 tr=0 ts=690d0c74
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=KVzj5TCqHZtvIDG7g-AA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <5450446b-c1b9-4701-ae21-26da6ae35f52@ramsayjones.plus.com>
Date: Thu, 6 Nov 2025 21:00:34 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.52.0-rc0 test failure on cygwin
To: Johannes Sixt <j6t@kdbg.org>, Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>
References: <f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com>
 <aQx-RnNX28BPU2cS@pks.im> <bdba6156-e286-492f-a64d-52bdcf074ea1@kdbg.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <bdba6156-e286-492f-a64d-52bdcf074ea1@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDOKJLm1hRfnVQdJg2a0tUSn7dmMkHEOf0xeTeWmVjjvNLelEHoQCAGqTAosPTJyCiueIUxmoQz5TwG508ta5oGj7lGpbS9Qp0R0q//ti8xgFf3w0rLa
 sQXybC5Y+Jg3h6TtFoaPKKSUZofHGvjHwTxajJFqTvEHUhj8B3wBSsmLJK8CVdYldqKWUvbyBxai3t6/VhcdnR/63bua6QKTM7E=



On 06/11/2025 6:27 pm, Johannes Sixt wrote:
> Am 06.11.25 um 11:53 schrieb Patrick Steinhardt:
>> On Tue, Nov 04, 2025 at 11:49:46PM +0000, Ramsay Jones wrote:
>>> So, not really an answer, but I have noted several times over the years
>>> that cygwin seems to delay setting some file attributes until after the
>>> process has exited ... [yeah, I don't see how either! ;) ].
>>
>> What? That's horrible if true. How doesn't this cause more issues?
> 
> Unlike POSIX write(), Windows's WriteFile() doesn't update the
> modification time stamp immediately. It's only updated when the last
> file handle is closed.
> 
> https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile
> 
>> When writing to a file, the last write time is not fully updated until
>> all handles used for writing have been closed.
>
Yep, I deliberately said 'seems to ...' because I have very little
by way of hard facts! ;)

Well, except, in approx 1996 on windows NT3.51 (on the only occasion
that I did any commercial windows programming), I had a 'problem' with
what appeared to be a 'late' update to a file attribute (I can't
remember which one - it could have been time related, rather than
permissions). A 'windows expert' (which I have never been) gave me
a workaround for the 'windows filesystem bug' (his words).

It was at this time that I first used cygwin (beta 14 I think - I still
have the cygnus solutions CD somewhere). I had managed to not use
windows of any description before then, so I was absolutely horrified
by the awful development environment that greeted me! (even with the
visual C++ GUI). So, on every laptop since then, I have immediately
installed cygwin, along with dual-booting linux.

In a small way, I have tried to 'pay back' the cygwin developers, who
saved me from going crazy during that project! ;)

ATB,
Ramsay Jones



