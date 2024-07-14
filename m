Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F41CA81
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720957466; cv=none; b=dB5iVAipL51o0BHw5CiJ+d/KrVnDTzkwDkUXLdQCclvUAb53Nb6I6qV0XEqNB6ChB04ZNmUygrW55tYrF7KkQEAkoHApfb2ANhWHm9EWREnmm2cnRBaxAtKgiQUF3aPNpcXciN3o/Hl50Hhu6SUDDoYR6acHSWwvb2vhmtRkVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720957466; c=relaxed/simple;
	bh=HbB8Ng2/7GPQMGmAxlEhsOyXRpXJY2kaOaC1pzjFgkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6FUNxWTw2j3MOFmQt7NJGvacqz7+LAoh7cqmOQmUJ9Nw0mYE0eWJ5aTCSO13dh2gorxvr+b3tOzXaDltotuBrWB6+xv3SidamTZ+KKVVSjy4HRaM2IF89DQ8GFTwyBw6djDtMSIqmaqTpiYypUCP196jBlNvIjHcG7rpFANZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=cMQHQGYG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="cMQHQGYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720957454; x=1721562254; i=l.s.r@web.de;
	bh=567Y3HnA21OEE7gxh0cqdXe+aQED9o3TmWW8sm0RRoU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cMQHQGYGf9uPSoTO48Pv1rRZsC7CY2SwfLGLaGttlIV+B2Yho8PjtdBYVITRQSJ7
	 1I2Qa7Y7tsVmk1hAKYM3E5LIdK//lcdecBjfj1OAtGiQk9pbIgukHy6rHHIJekASQ
	 fa0adpGB6d/TAjDXB0DXSM69CYdZhEBLMNaaAc0a3uVd/6m/DHWu4HHKbW3enn2az
	 RrVuWThALpvNusfUWLfI8FKD9FKrJaRIo4qAPnK60xAWtkydoJ8eTsPERi5ccvI6X
	 m8+cBwm4r1GzS3AxbHXzWmCkBy7BJo5XCW4ll8ug9kDeRMhK6hTcwJVrlgfgxyLOq
	 6JRA6D4PCPd+PH2Keg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuF8z-1sEJdr0sOb-00yfrt; Sun, 14
 Jul 2024 13:44:14 +0200
Message-ID: <5bc6ce3e-38cb-40cd-b7fc-f88e4ca78d6a@web.de>
Date: Sun, 14 Jul 2024 13:44:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
To: phillip.wood@dunelm.org.uk, Josh Steadmon <steadmon@google.com>,
 Git List <git@vger.kernel.org>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
 <35f828d3-6d3d-4b86-b6bb-a35753d91b9b@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <35f828d3-6d3d-4b86-b6bb-a35753d91b9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S5HNyysLt8ijyA6xpLOKmKGnfH9HXHY1uUarUeNdDBbMzXcHvQb
 Tx1pGgMglXVLerewZm2yMFVd1VlWFgyrMlezzIM3laoMCfICWNBZ/VTIAu72nkV6/D/28z9
 vV59hWgE/tdCPXYt6DYrqyGrkfyK1MqgWIWR2QzM2n7gT8fSpCzqRMO/bzykT9jgYnMf6Le
 iKygsoUJ+tQ6J9EYOJxCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AXViuTDg8a8=;BSWksqUaN1Ic5lmF9GVowhrEwf8
 qN3WeornAnHQ74x92A6L5e+ydDudQo79E/KpVqtE/0I3QldHSwnUUYuN9E0PVM/v9hR9m6Yfn
 /qLPYMYHspt3KUX3r/0e/St8qoDdAEGWMpWG3rXMM7iOVWQS0scezS9SO9JOmBQgArP1Ahux/
 GCzv80+0mRYYu+AkUcYJwTCpXObxCwbs63hESi+nibyl1Vs+QCxN4+JJIYkickV+5Dl4Z15vr
 VB5W5BmO5mgA16EIMU8WIia5roOOJTmcjqEItbYu1Ff2x1Nggk7bd2uXfvJQQYEBgydp6fIY/
 C0ILYWjuY+/LfQi0Bpk9bWVB8DTgwZVlqKglst9k3ihTz07taeuEG8aON6ldvEwGsDHM/2nx5
 7cNbYQExOB37V8FoSRuYGabK4zuxGJq+bq9HCfO4nghvr4G7pRXuv5n0XQUKwbNjkY1sNKiBe
 dvPWHFQKeH+sa+W91w0tw8PrAWEzWdEHrYH5C1lT5mDG9uRM4NA/sIoYk3kE/0bkhi6qVUs9m
 BCQ/9doe+Ga9LEGHWGsOWqSpBDDX72PFWkPSpi0i8lbAwM+y/BbBJJXIBxyFP0OhX98Y3AHHs
 V/EXgYimUyQ6RnaqXtpy7RvZqehZ0xF7akM4n4ZcVGVcSwzKAkCNX/ADBYDGVwa5AsIN+jVai
 yvl61annpvP4j6HOhARRhXY6eHAhlhHpH39+1ixHl5YYKrYIutOBkN432v9ai1yEjvfBo83cG
 qI+V9Wc+KhBqGQ0kyzDqeNNXMdol2H1+7AOO7g9camMM+1lXGNpiV9EaP+bqYpzDYASgdFzS/
 HTbE7jDNVhRpkgz3wB+05aEA==

Am 10.07.24 um 15:55 schrieb Phillip Wood:
> On 02/07/2024 16:14, phillip.wood123@gmail.com wrote:
>> Getting rid of the untyped test arguments is definitely a benefit of th=
is approach.
>
> That got me thinking how we might make type-safe setup()
> functions. The diff below shows how we could define a macro to
> generate the functions. DEFINE_SETUP_FN(char, ch) defines setup_ch()
> that takes a test function and a char that is passed to the test with
> the initialized strbuf. I'm not sure that's the way we want to go for
> this test file but I thought I'd post it in case it is useful for
> future tests.

I'm sympathetic with the idea of enhancing the weak type system of C to
avoid mistakes.  Hiding the use of void pointers behind typed wrappers
can be useful.  Not using void pointers is even better and clearer,
though, where possible.

Thought about using such wrappers around qsort(3) and friends long ago
as well as parse_options() more recently, but didn't arrive at mergeable
patches, yet.

Initialization and destruction seem easy and familiar enough to not
warrant the use of void pointers.  No need to get fancy just for basic
necessities IMHO.

Ren=C3=A9
