Received: from outbound.pv.icloud.com (p-west1-cluster4-host10-snip4-1.eps.apple.com [57.103.65.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF560278146
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533616; cv=none; b=SaXGrH+jhCXdE0PLc7KkSSQY6dVTQ1GUt8XiIj2LC6Ex7z6mUiMU/rkM5+cGq2hZIQv1+5GuddcWghHM1V829gMFvhEXjNu6Xf5KbNQQKDtP9acAr1NVjajpbqu3aHfpElBNNN3tbOuT4NmwCqEpS+tacuIjP0UQNJIqLx7893g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533616; c=relaxed/simple;
	bh=Cki8ilhzbODumNzehJUSbHwORjkIasiPEM42zAOV/w4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F8WzRK+f4pzwQeIap+vbEK+SFWYyX117AX+Xb/QxN08Kr4Qm7lrftV6fulB3qJjtsQHMshR/1zMKNumfr/HqmYUKjPtLApoPFcoyh9vicAxpWH2QiTzE0Y5UAc8jB6MYeKa3zNmFYmxBl3+PpT55zkADApSFP8q0W3AxVxNMmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=H/q2BZLZ; arc=none smtp.client-ip=57.103.65.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="H/q2BZLZ"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id 95F421800752;
	Mon, 18 Aug 2025 16:13:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=vH9W2UVXxiUUO8nWOSd/h3ur89dLXMOhJtHSXL6QNr4=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=H/q2BZLZvekmTGPTUg4WNJWW1rD01Q+Y+FSwx6b0Q/nvgrh3lgLLcOcFzbgvtGZ6tH1cKfVE9UAey0HziUhmmDX9aegy7sMz1cR0Fl62UY0OzGcoNXddGMls2C9yKJKnMlUB4YBnZ3YFdXURZfyzKiA1dWZS3bdeLPWb3G9D/sfrXZ4X0X9zQhFYsMBSCmVhPh+eEKvWhaef7uA1K4nUPV580yOykfRAVNOnbPQyK3vMzXHmmxONsseQx8JgOPGZA3yoAGumq6uhkrMTtNT0Iq+5EeZAC/dp3Anr4UItQv6hAdnQZggSFVR/Fa44k5x7GPAoL1/h+keYnWp6oXD15w==
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id 729DE1800756;
	Mon, 18 Aug 2025 16:13:30 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Discussion: Future-Proofing Git for Massive AI Parallelism
From: tanish desai <tanishdesai37@icloud.com>
In-Reply-To: <VI1PR02MB427142ED036197AC552D0865B335A@VI1PR02MB4271.eurprd02.prod.outlook.com>
Date: Mon, 18 Aug 2025 21:43:10 +0530
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Tanish Desai #TD <tanishdesai37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4942BBDD-D77D-4DF6-9373-FAA5BCE75560@icloud.com>
References: <VI1PR02MB4271E311313F60FB07359BB0B352A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <32989B0A-2DB0-4787-8A08-BDED46258C7D@icloud.com>
 <DB7PR02MB4265771098F7314E47D9F2C0B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <6C289832-28F7-4173-8C65-A95EEAB333B6@icloud.com>
 <VI1PR02MB427142ED036197AC552D0865B335A@VI1PR02MB4271.eurprd02.prod.outlook.com>
To: Skybuck Flying <skybuck2000@hotmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: re7tzpjiBiXt2JMc8oXuUiGBYHrxWh8J
X-Proofpoint-ORIG-GUID: re7tzpjiBiXt2JMc8oXuUiGBYHrxWh8J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE1MiBTYWx0ZWRfX/Kgm3BIVsI6n
 rhEzpEwpIgAqoU8Uqci7Y55+jS0EW9reQtZ3bVemA7w6uqlQIwO7PJgB4Y+ihWkl3MEpagw8vno
 Pp9uFmK/Hj0sfGamH3peHbEEmmOE1iJNPgIWBhh3xvpxGDO+zXsrem3Uv6jrl4sC1qGBeVgmaZs
 8LlVzO1lwVYSivHEytQ5jo2Bt+v4q67QUspF/Qhkri5zf538U+5XEt+LSH8YIzfoBTohqfHZAhs
 3trTj1GVs5y9K1R6RhgGVORnB0ZakAYweeWHJVWeLt9/1H7JWevsGCJh4w0n9lqbjjq8D2AyY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508180152



> On 14 Aug 2025, at 6:53=E2=80=AFAM, Skybuck Flying =
<skybuck2000@hotmail.com> wrote:
>=20
> (I shall reply to your other replies in one reply):
>=20
> Late replies: no problemo.
>=20
> Why no linux: I know Windows well, runs good, don't know much about =
Linux, probably too easy to wreck ;)
>=20
> Why not git itself:  Git not race condition save ? Is only a client ?
visit this once =E2=80=94> =
https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server
>=20
> GCP ?: Google Cloud Platform ? This cost money ? or is it free ? Why =
not gitea ? What does GCP offer that others dont have ? :)
>=20
GCP offers free credits for 90 days, which were enough for testing and =
demonstrating how it can be scaled horizontally as well. Gitea can be =
used, but in this case GCP was used just to test how we can spawn =
multiple VMs (not Git servers), each running around 10=E2=80=9312 bots. =
This was done to demonstrate that if we develop a smart mechanism to =
merge AI code (as mentioned in the first mail), then using the =
previously described blueprint we could potentially spawn =
1,000=E2=80=9310,000, or even millions of pods (just by creating more VM =
instances).
> What is Skybuck's Gitflow ?: It's a gitflow technique where before =
each new work a new branch is created, then work is done on the branch, =
once work is done the branch is closed and integrated into another =
branch, like an integration branch or master.
Yah got it.(Maybe a small insight: creating patches for all commits of a =
branch could be useful, because patches only contain the local code =
changes near the new code, not the entire codebase. This could help =
solve the problem of repeatedly sending very large and mostly unchanged =
code to the AI as context(noo this should not be the context).)
>=20
> This Skybuck's Gitflow is also describe on this very same mailing =
list.=20
>=20
> Skybuck's Gitflow still under evaluation. The AI liked it though.
>=20
> Ramdisk Project: No for now it's a fail, but I have not given up yet. =
The original author got involved too. I'm also understanding what gemini =
and me myself included is struggling with in transitioning from AnsiChar =
to Unicode.
Ohh, If there=E2=80=99s any way I could be involved, please email me =
outside this mailing thread. I=E2=80=99d be more than happy to =
contribute.
> Some small improvements may have been made to the Ramdisk project. =
However for now I believe the ramdisk service might cause windows/the =
computer to hang on shutdown, more investigation will have to be done. =
Windows 11 sandbox environment might be usefull.
>=20
> For now I am fatigued for a few reasons:
>=20
> 1. Little bit fed up with AI and it's struggles ;)
>=20
> 2. Tired from Battlefield 6 multiplayer beta gaming, however in a few =
hours it will once again commence.
>=20
> 3. Super hot weather in the Netherlands and will continue for at least =
a week.
Got lucky the monsoons hit just right here in India.
> 4. Bad sleep I guess.
>=20
> 5. Some real life things to take care of but nothing too serious.
>=20
> So my mind is kinda gone... bummer.... I hope to recover from it... =
maybe a week from now, maybe two weeks.
>=20
I hope it=E2=80=99s better now.
> That's a long time unfortunately.
>=20
> Bye for now,
>  Skybuck.
Bye for now
Tanish


