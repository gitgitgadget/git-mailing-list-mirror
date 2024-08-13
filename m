Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB474C8C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554404; cv=none; b=M+LX8x+CBSAChyE54R8DDYqsQmXxO9ieRCq/jxzaKqs0w3ODqeP9z7bH1uqy76Qsw35UJ+HBhqW8x7oAkp/5Geq+7MmMm7+GOOcX2VpTmrt7cmNCK5WxUeWc5s3JxSCzAX0OCIcKlT4f9rky0vbA9x26EQQMyX7PloK2osnsBJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554404; c=relaxed/simple;
	bh=AWdMTyLTIwCLjj5mdyX0DRZ0CLNlx11DobQIi+Lkhro=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KEO4JTU4+zMHQkKj5vNzabY10Q8TLa6KI6HNXZxZBPbBCgHNiyrLOPbDA1+luSvigmJj19lZJ4+LAQJjYctrssPbwyLVg1H53hozYEJ2y1Zj82M7LekVXD0VQRG/cFm28LyXoCuNS7s/Wl0RZq+17wm3pROF3k1Md5l2A+VzieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=cT7F/YGa; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="cT7F/YGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723554398; x=1724159198;
	i=johannes.schindelin@gmx.de;
	bh=Mn65pkq3dagBNWNtlotHwdziDX3eKaPlk8fp39adwPk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cT7F/YGa0xg3Y79k0msiEbe2gO56BVc2CP7oBIKkEZGaoRQnUpuI2ZyvQh/QBvpp
	 Tvtx4m5DzE7weOITmraseLcYCrjvYMzpMp/zqrnQqvDb5KL7/95WjZroAgK9CN9D3
	 kgYyYHEiuwKPsS/LfVjHkBw+HEwJVLOdqEHcnz46RIFlUNo0OxGhHjEbwVfCmFZls
	 8wtDTD2ixApjBaDejbcmhkW0GbY08I9lly+56k3tq7UWQrApkzkwELMuBrJ5Rv4fu
	 cgqmrjT2GaPhgW/qBxXqcDZjXTt8BceoIz1K7+AJTHPhVrTQvy75Wy/4r54uuoYPx
	 TdzjVsp9FlwZFy5Arg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.78]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1s996U093I-0147O7; Tue, 13
 Aug 2024 15:06:38 +0200
Date: Tue, 13 Aug 2024 15:06:37 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tim Abdiukov <tabdiukov@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Bug with bash and OpenSSL usage on Windows
In-Reply-To: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
Message-ID: <074d1fb3-e2ef-6365-73cd-b63672b4842e@gmx.de>
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n9PHVuMClsGxOwXQzqfamA1NnmK5Wo6sQgcDUNJcYrsGDhhvEht
 UV7jDGEbDxNrc/Kk+qULrUvmGhgbV7qBYN5GxxpBYjA2JVVLgEfyt96hasHx9VS3Cd6PKYc
 FcfPQhEyIvJwCYhHdFUpyFUr5WyIvPbEwN69mwWK+82iv+WvhXxWSAUuoysv2qORDVMDCsV
 wH5GWmWT/mY1jTLyPYmEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hpsz1ZamWjk=;HQNUynw+TiV1f/LWsS14y6Yg2iB
 i6sQudhoNjyAHvhvxeCyaLpp+flqPr6UR6SK6iW3LiaAayGzezJh0XzQoyALSYPKVpHBzXXmA
 91jdTOwCmmnhNjN9o77xpru2qin2yjro2FPDFqArxHEodUMKOyo4l0n/mXnnkhtRQd0RAsxOY
 Rx9NQLiNATan/C5utD5vSBsHUAVANB+N3tR9j8WHlZYiKa6jczdNtC9xxVJUNlB4A/wiL4fPW
 eRKTTDGSWsHZJ9BKbgUwkhAUqTqB65snDR1iNwR4H5I3YtB1rO3W6PTsVav+J85i3LaYoZRLM
 YGHeJR8p/ZIgh58D4pi7MOTYqwZkuryrW1S4HKYNHLPa/HVD6R9/aZ5waBWjxrhPR8UANvqpb
 k8UMSAJbqb+vk70ijmrRg6dS/mZ7JJ1cqXwvlPPqwcRL6ytdWym9HNDnbdwpiSDHU28DOfIlE
 JToPlNUP6pH1X9czaRuDH4aQPkeMVkyE5yZk8hA2O8IbjoryeRJvHOxdS62oR+j9PBfWQxKAF
 A3lGJ7AFcs5N8F2UiNoDkji6FP1FyFr4ZU1Vt5M9vG1zs5+ajMvYiwuFgsgEc/HWfNwVNqBkm
 IlQB8gxP/TMtis212tX1ezBTXn7q8sOdsaWV6qNun64Kdjl3WHtg9AF+IC2UEctFDPWuXhrvW
 dR8ofio+Xk0s0qrABf1OamdUgkhB31ltmV1VlDwcBYPSkR0y/w05WdGiF95I2dO7vcFnp3lpW
 hc9KeYP6xTNjxF9/cqwBbMyrrxrVPM9KDHwKqDtwFCRwpprEgjIhdCvfbL1tcsLA2aHIW8F4R
 DppmjOKs2b5Yu+7zJb6JCKOg==
Content-Transfer-Encoding: quoted-printable

Hi Tim,

I suspect that you also reported this issue at
https://github.com/git-for-windows/git/issues/5079. For the benefit of
readers of this list, here is the explanation:

`openssl.exe` is a pure Win32 program, while Git Bash uses a friendly fork
of the Cygwin POSIX emulation layer. The latter, therefore, uses emulated
pseudo terminals, but Win32 programs only use Win32 Consoles.

For the moment, therefore, programs like `openssl.exe` that want to
interact with the user via such a Win32 Console have to be called via the
`winpty` helper that acts as a translator between Win32 Consoles and
emulated Unix pseudo terminals.

Modern Windows versions support a concept called "pseudo consoles" that
are similar to Unix pseudo terminals, similar enough that there is an
option to use them, which would avoid the need for that `winpty` helper.

In the near future, the Git for Windows project will switch the default to
use those pseudo consoles by default (where available, that is).

Ciao,
Johannes

On Sat, 27 Jul 2024, Tim Abdiukov wrote:

>   What did you do before the bug happened? (Steps to reproduce your issu=
e)
> Tried to generate a self-signed certificate using git bash.
>
> Using git bash, I ran
> ```
> openssl genrsa -aes256 (private key location) 4096
> ```
> however, openssl just hung (on Windows). Cmd can execute this command,
> but bash cannot.
>
> What did you expect to happen? (Expected behavior)
>
> openssl to generate messages about key generation to stdout
>
> What happened instead? (Actual behavior)
>
> openssl just hung
>
> What's different between what you expected and what actually happened?
>
> openssl just hung, rendering it unusable within bash Windows
>
> Anything else you want to add:
>
> This is an issue specifically with Windows x64.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.45.2.windows.1
> cpu: x86_64
> built from commit: 91d03cb2e4fbf6ad961ace739b8a646868cb154d
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19044
> compiler info: gnuc: 14.1
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash=
.exe
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
>
>
