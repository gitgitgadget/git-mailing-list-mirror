Received: from ams.karleo.net (ams.karleo.net [178.62.251.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A04D8DA
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.251.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897096; cv=none; b=Ik0s8UUfxLN9ZYtt5QxxPAT1+d7YSPhy7m4mCDCyvvB/9nUxVq/57u0phq22ItZAnher2enPHTauKoSvPsrfydqfcyfci4EOnnKHVwTPvto73gXgMmykLEcerCGLl6GSWEvqSbjLpEVo0JJ50mQP43i3QxtxKY0uz1b9/6p/ueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897096; c=relaxed/simple;
	bh=rJL5yBiO0oB+9wRqDDijMZu6qxX9zjvCaKErnoU70lU=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=NWDg13EoFsrZJA4xcP/mTbZvNlgHAWyOFcaXDBNsN9EllNuBJNzatCTd2Jzb9J/ioirG3+bcTFKXeKtgxaYfHudRG+7pKZRFb2jpfCuno349kJ/b8WXhsEJhjPlHrVArFqtMltkf0edr6hGEqUL/Q4g/FhZ5vpT/4PlUqLn5kyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timm.sh; spf=pass smtp.mailfrom=timm.sh; dkim=pass (2048-bit key) header.d=timm.sh header.i=@timm.sh header.b=TEljgizi; arc=none smtp.client-ip=178.62.251.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timm.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timm.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timm.sh header.i=@timm.sh header.b="TEljgizi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timm.sh; s=2020k1;
	t=1725897092; bh=rJL5yBiO0oB+9wRqDDijMZu6qxX9zjvCaKErnoU70lU=;
	h=From:Subject:Date:References:To:In-Reply-To:From;
	b=TEljgiziG1cZvbbeu1Bx2hZT3ylTXVeivz3iWULH8USa0HYANIFf5f2GlxLoXkv3k
	 MqZFdB9ut/VdW6KJhFv9Oa6FG60PAK3Q9/Z/Fm8hqM+g3DkVUzpRVbpCMuwJ/+e5Rd
	 Rb3ZlUTR0rg4PiKmRmYUGNTE4YDq88/XSqRZO/qFhPb7OIwCdQM3TiN8gIPBCzYwg8
	 ZXew0jwEOWxOxHEHi8cVYIHhLjVZLdd4s8J5oY41oPlPERjXlh0A77/+AHUvnqnxVD
	 kzsqni68JVVjZso3uAJf8EY+gfePp0/luxfzaalNDcSk3luPJSNeErhD3nK3OvyLNW
	 f731UVpOIlbZw==
Received: from smtpclient.apple (unknown [IPv6:2a02:8108:121c:d0e0:ada1:7a23:5bc2:824])
	by ams.karleo.net (Postfix) with ESMTPSA id A04FD404A4
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:51:32 +0000 (UTC)
From: Okke Timm <okke@timm.sh>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [bug?] git diff --cached in a non-git directory
Date: Mon, 9 Sep 2024 17:51:22 +0200
References: <2886189B-4BB5-4230-B7AF-94F97A13D72F@timm.sh>
 <05b501db02ce$3bd49e30$b37dda90$@nexbridge.com>
To: git@vger.kernel.org
In-Reply-To: <05b501db02ce$3bd49e30$b37dda90$@nexbridge.com>
Message-Id: <A95B257B-2414-43C7-B041-AC22B03D9143@timm.sh>
X-Mailer: Apple Mail (2.3776.700.51)


> Am 09.09.2024 um 17:37 schrieb <rsbecker@nexbridge.com> =
<rsbecker@nexbridge.com>:
>=20
> On September 9, 2024 10:26 AM, Okke Timm wrote:
>> What did you do before the bug happened? (Steps to reproduce your =
issue) I
>> changed into a non-git directory.
>> Then I called git with 'git diff --cached', which produced this =
error:
>>=20
>> error: unknown option `cached'
>> usage: git diff --no-index [<options>] <path> <path> [...]
>>=20
>> What did you expect to happen? (Expected behavior) A helfpul error =
message.
>>=20
>> What happened instead? (Actual behavior) An unhelpful error message =
saying
> that
>> cached is an unknown option.
>>=20
>> What's different between what you expected and what actually =
happened?
>> Me being confused why git suddenly forgot that `git diff --cached` is =
an
> allowed
>> option.
>>=20
>> Anything else you want to add:
>> Please fix and thank you for this great tool!
>>=20
>> Please review the rest of the bug report below.
>> You can delete any lines you don't wish to share.
>>=20
>>=20
>> [System Info]
>> git version:
>> git version 2.46.0
>> cpu: arm64
>> no commit associated with this build
>> sizeof-long: 8
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> feature: fsmonitor--daemon
>> libcurl: 8.4.0
>> zlib: 1.2.12
>> uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 =
21:14:21 PDT
>> 2024; root:xnu-10063.141.2~1/RELEASE_ARM64_T8103 arm64 compiler info:
>> clang: 15.0.0 (clang-1500.3.9.4) libc info: no libc information =
available
> $SHELL
>> (typically, interactive shell): /opt/homebrew/bin/bash
>>=20
>>=20
>> [Enabled Hooks]
>> not run from a git repository - no hooks to show
>=20
> Because you are not in a git repository clone, the --cached option has =
no
> meaning. It refers to the staging area only, so when not in a clone, =
git
> does not consider --cached as supported because there is no connection
> between an external directory and an internal. If you want to perform =
a diff
> from cached vs. external, run the git diff from inside the clone =
referencing
> the internal and external file after =E2=80=94.


i criticized the error message in my bug report. If it would tell me =
that this is
not a git repository, I=E2=80=99d be happy. But telling me that =
`=E2=80=94cached` is not an
allowed option for `git diff` is very unhelpful and confusing.

The reason why I reported this is that git gets run in tools these days =
and not
all check for the presence of a git repository correctly all the time. =
Also
sometimes permission issue hide the `.git` directory for some reason =
(reported
for Windows and VSCode).=
