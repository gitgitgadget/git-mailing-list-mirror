Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944F1F1932
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981745; cv=none; b=qNN6VJhamP2A004iJiLNVWQe/eYMEePET0gaX2z2+NZ5Du8P1HTNzRYZ3WRioV1RKxzzBVx4smt3uCJNbvMWhMZykPMZVJzn03RIAcmk7HyWXl6yGB0B0jnLe2MJKkSEYslgMdWECdSgxe1zvDQtLsbpLEPMzrdHqLz3dDqqCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981745; c=relaxed/simple;
	bh=8eJ7Hwi6lJpgi/n1ZimyBtqCp0fEfvRFXhbxTqu3YDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hh++8f5Vl4gZcSfrXVdRlVecnx4k4IQdz6n1qUhRNVqaXQAl89/5AyIZvKNV4+eCrsZ9RluwR9zPbubEZlnDzGEtJ2bvS+ayA3OMuBKu/5eapLm3i4iCD4uF/4pffFvTMxMVLt+acas58CC+m7jaZO9e9mJjomHzPDvlzQtxSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bE/SdSKs; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bE/SdSKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1776981741; x=1777586541; i=l.s.r@web.de;
	bh=cJeJ5r/7ZuGC9Pp/Z/qTPTiZ3KEZ8eC3D/GYYfMI4WA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bE/SdSKsP6uKuJZmXnfRM8hAAzeJaLAFs/zHnA2LACIwLu5MogeEIffFi6lcDMEx
	 v720nNlE6ykprhbFSU11Ocsf1VNPRekjyWyr5gLw0yOpIL7CqIY9sVf483jslnOlp
	 HBJNzy9lQpTf3KyeqDZCMoSaof8lHiyfvudwbnQQLpaMfTIp0MkfS+wc7RTkg9n4p
	 jMmg0WMzfE2p4p1upa3FRVyj1XFefSfIUqFDEfR83dCOLD88XleY0nXWsKwgb4Bqr
	 sqkeY4qZ08lr9kkqGgPurm7MV+MhOLMDSYkkFCJdNKygX0hCJ74cPJmCs5WHoSzZL
	 2NcPr0nbBOjf1d0fIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1wHwjj0lI3-002ZVT; Thu, 23
 Apr 2026 23:36:40 +0200
Message-ID: <ea07acab-313d-435d-8328-e601fee980c3@web.de>
Date: Thu, 23 Apr 2026 23:36:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Hierarchical Aliases no longer work in 2.54.0
To: "Grossfeld, Michael" <Michael.Grossfeld@amd.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jZn5tIXnVAy2fwvokmyONRxfqvXcyWs6mgFZmGTF7DMXzRvJO2N
 6RdESCavco9cfmrvS9cpkDGJBu/K/rjYyl/0RfA5+tLPx6b8v87EjcAEMqOyCo8xMuqN7mZ
 3IwmKFI90MB2noFjfetzdH2k5cNm2REsEYxgSJglnx0sOqPBbndOeDabUd75ZTuJ8KR25Tn
 rqxeRTryz7Zi0ndz+D8pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:97H1lmDbREg=;zYQgFNWdrY98kCilWWGs5prL3jn
 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
 ZsUh3XjnhFFz1Gcs3P+xWdFg==

On 4/23/26 8:19 PM, Grossfeld, Michael wrote:
> Hello all! Seeing this issue on 2.54.0 and it didn't look like anyone ha=
d reported it yet.
>=20
>> What did you do before the bug happened? (Steps to reproduce your issue=
)
>=20
> Attempting to use the hierarchical alias "pull.sub", which was working i=
n 2.53.0, is no longer working in 2.54.0.
> It returns the following error: "git: 'pull.sub' is not a git command. S=
ee 'git --help'."
> >> What did you expect to happen? (Expected behavior)
>=20
> The git alias should have firsted pulled, then updated submodules recurs=
ively.
>=20
>> What happened instead? (Actual behavior)
>=20
> It reports the following error: "git: 'pull.sub' is not a git command. S=
ee 'git --help'."
>=20
>> What's different between what you expected and what actually happened?
>=20
> git 2.53.0 to git 2.54.0.
>=20
>> Anything else you want to add:
>=20
> The alias was defined in my gitconfig as in 2.53.0, and remains this way=
:
>=20
> [alias "pull"]
>         sub =3D "!f() { git pull origin --recurse-submodules=3Dno --ff-o=
nly; echo Updating Submodules...; git submodule update --recursive --jobs=
=3D16 --progress; }; f"

Broken by ac1f12a9de4 (alias: support non-alphanumeric names via
subsection syntax, 2026-02-18).

Alias sections were not documented before.  How did you discover them?

I think the previous behavior can be brought back while keeping the
new feature, except for aliases that end in ".command".

> It was written via this command:
>         git config --global alias.pull.sub '!f() { git pull origin --rec=
urse-submodules=3Dno --ff-only -p; echo Updating Submodules...; git submod=
ule update --recursive --jobs=3D16; }; f'
>=20
> Trying to do the following (with .command):
>         git config --global alias.pull.sub.command '!f() { git pull orig=
in --recurse-submodules=3Dno --ff-only -p; echo Updating Submodules...; gi=
t submodule update --recursive --jobs=3D16; }; f'
>=20
> Results in a section of the gitconfig that looks like this:
>=20
> [alias "pull.sub"]
>         command =3D "!f() { git pull origin --recurse-submodules=3Dno --=
ff-only -p; echo Updating Submodules...; git submodule update --recursive =
=2D-jobs=3D16; }; f"

Which works, right?

> [System Info]
> git version:
> git version 2.54.0.windows.1
> cpu: x86_64
> built from commit: 2b8a3ab140826ac423c2845ef81d4c6ac4f7bf3c
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> rust: disabled
> feature: fsmonitor--daemon
> gettext: enabled
> libcurl: 8.19.0
> OpenSSL: OpenSSL 3.5.6 7 Apr 2026
> zlib: 1.3.2
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Windows 10.0 26200
> compiler info: gnuc: 15.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): D:\develop\tools\Git\usr\bin\bash=
.exe
>=20
> Thanks for the help!
>=20
> Michael Grossfeld
> AMD

