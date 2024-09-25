Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92641D5AB1
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278034; cv=none; b=SanhwIYrL8zYik7BRKNs2QUj/vfctT7QwZwWlFQWLv7UmEruK55ZeylcG7xX1XzSNHtrZ7vyxER5ZSAzOazX+osrQ6HPJFm5dtIfvSGfCqhojWApcxKlIhJaTSwdVotD2otejzWJhgl33ni4hXFy55qq4dpOqh99raPZ59AQPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278034; c=relaxed/simple;
	bh=g1D/AjvroHXuBmIf+4JOsbvfVyIEBAAJIw6VxNDshJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qYHwcAmQ69PVEkKlbydEtl/cuvDW22U3oidam1di8kO7iVGOsE3JA1qYCFQyOkTxVRsc7/vdxlfut4srHhoVmPiuEa/UJXp3V5njDX8Rp99DO61Y4/gqYnGEN2Wbfz6/aHm6qefMiCnwZhfsHjMWXveM3bd+2T/AOw1J62FpIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=D9W1DCzY; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="D9W1DCzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727278019; x=1727882819; i=l.s.r@web.de;
	bh=7Z/uyB3FnMxWP0skW71HpQkvy8O/tzvi9t+7XkOxszU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D9W1DCzYpnf1K9InwAYu02EKMgWgDm0Y4nWDLXlvtGK7xiQoa92jQQNOJw2RIi8A
	 +laMD3kUGGn3OZXb1yJs9U5Gri6Pc8oeiyXrjFu5cYTbbXGxDoP386w/neosI+5lP
	 exQq0v0ACdP0k+LOzGARvarnbYdQiy6YC1yDWll60FuttjEvaeeG+fhc5C9FtWQQd
	 vny1MG+BAx8mG/vrDrUlDLVGcfRPqv16OzJqRvEgU0p3xuYA8egtwtAjxUQkxbRPg
	 uYMkZT4q0Obvk6U/9FcibavbH/cYFJzlQnR4bnUD/uGbWj5Zzjd4/1NLJo+6CbbtE
	 kAGrA/BfJVKobA5IJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.135]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xnj-1rusWO22vT-0118Rk; Wed, 25
 Sep 2024 17:26:59 +0200
Message-ID: <e3da5c9b-c208-4937-a2b4-e1028f3e6841@web.de>
Date: Wed, 25 Sep 2024 17:26:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git diff --exit-code misbehaving in 2.46.x
To: Jan Wendland <jwend1703@gmail.com>, git@vger.kernel.org
References: <CAB0mhhz9LHZ1AWSu_0oM=c89+z0w=XemnQwFAm45wp8zSmQ1Sw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAB0mhhz9LHZ1AWSu_0oM=c89+z0w=XemnQwFAm45wp8zSmQ1Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kMrSfkdew2dTnPy/ejg9yZMor3Rft/bDc8yicp7/MNJqO4Z2Y+o
 Pl48PIr/sYCCUOOFqSY9Hb2Nwc7+rC3hIxSH+aMZGT3Kuzc5MbNhBesyTI07B49Nctn1znj
 vgtqMnYOmS13WPXR5MxvqEPHGfVugawFSy0MTpEqd178CjYqo7B+i9oTxSEkQcE8/q/twLx
 sqB6e8ua8cQPmMoh+hLGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hqnw/KbcidQ=;CCW7m2jl2COfhjeOkBxw7aByHR8
 41lj2pbYOsh8zhTZgqy1MOXzwl/hPVAA3AAHNQotrNeQIx+SZneZaU5mXSovQAnhOBh9n4ZsU
 EbVSoROVQ5unSU8+DQXosteBOWrjgN2p1d565eJLamyACTKHKIxBNm4bZjiYR6EQGlMHD8zxF
 cd34Uw6D3FUMgzme3QPmbG4Z0Buzm5/cFSgQUe55SE7quNU8XBPfZZf4VD4N7qbckFgr78+fx
 eKmmRD4U4/dGiK/Re+ABqpTsSNafXRj+Lvc/rbQD5Nr0njNh38UEBKS1J+SRMu8m9e3XerEEV
 /vqxBeJMDayF/amZlozjfYW/zjz+2kLflUuI2QbbXULO1AVoK5d1xfjZoDotuz48kUSgLHe7H
 F+5rGXstSQr71HFIhqyRWCCQ8gXGeMSQPT6GWmqST56oEkboujPHvv/ESsT+R8OnxLD7maluD
 sEucMuww2mIChmqCYLdTYXQLy/0T8mUqk4yW+ADYoMy+jqoTueDYe0bTGmn5xLHBiFEiDryhy
 GXE6ZBT5f8YtFkuZDYrxyaJJp4KwRXY3+8KcXFVLMXSfEvBmovh6L5PivLG3GbWjHEzzfmOUa
 k8PL5hKy7/XhoLeC6AHoi8osQK8uXzFH/0uM2EZnDCyedGDPn+eZ3ZIfSqcBVTwweeOi2fhID
 Z+/pP9xKS5RACXgE8QI48/zGGkC5iZqMDHzA4va8hNQb4T8KX8jXTs4PZN30/m81TbN36PxJE
 Wf90alVk8OcH/EH0rHwRNHOEh2lkmxnfAwo9d0P1KmsSu827vgifJ4sylozZ2teZjop1LenCR
 q6/4eoR2hd3RxZWN3LLYEyJg==

Am 25.09.24 um 16:27 schrieb Jan Wendland:
> Hey team,
>
> git diff --exit-code in 2.46.x is unexpectedly returning a zero exit
> code for files marked as binary in .gitattributes where 2.45.x would
> correctly produce a non-zero exit code.
>
> To reproduce:
> mkdir -p git-exit-code/dist
> cd git-exit-code
> git init
> echo "hi" > dist/main.js
> echo "dist/** binary" > .gitattributes
> git add --all
> git commit -m "Initial commit"
> echo "some change" >> dist/main.js
> git diff --exit-code
> echo $? # actual is 0, expected to be 1
>
> Is this intended?

Thanks for the report!  This is a known bug.  The "next" branch contains
a fix, 9a41735af6 (diff: report modified binary files as changes in
builtin_diff(), 2024-09-21).

Ren=C3=A9

