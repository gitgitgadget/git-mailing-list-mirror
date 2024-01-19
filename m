Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C04EB27
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671376; cv=none; b=bdH00zlk4p2Gy6Oao23FEuaeMYqMZU7xbVGzNNUH/JL9UYo99N1qXEUZURJDr769lBKNxTJDhMJv4mU5n7Zx8i2yYKsIxitXFBwL1+VudTA+vQYrPwupyLNcdxS+C92vN3v0x+DKUQCL+VFJ4EiXS2hROK4RMcMjD3N7+lgXvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671376; c=relaxed/simple;
	bh=tEuigmVhIXMSPNW4UWYP2wX0SMtcsN4d0n+eD5UGoCk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l+jry9Gdcm2takHZAg4VRhOVcrnnSy32+QubFSJPm4xZxOOAgcinx2J83TaDph0vSSLwC2d7Pin69/3UFdYC4c5L/oeTVt6d+Yci0bMym1k02A++a3pD75+59efku7Suj7W3NAjYUpbCJwdDkbHVGygzPV2OEwUc2fcQdS6hz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=schwidom@gmx.net header.b=YIpIMMbQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=schwidom@gmx.net header.b="YIpIMMbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1705671371; x=1706276171; i=schwidom@gmx.net;
	bh=tEuigmVhIXMSPNW4UWYP2wX0SMtcsN4d0n+eD5UGoCk=;
	h=X-UI-Sender-Class:Date:From:To:Subject;
	b=YIpIMMbQ2iuFlod6frAOYoNZOP2RFR9WOPcwfvyxngTtov9q078Jx65tPqHBgEYr
	 XshTrw5MD/0I2EeWxMCgYBwmPM1NfPEXOO8ovGob7EgnXFyFEtsuN3u/DbNsSUPtr
	 80QbaU1q+dtruIzdFZt8ks31AQoaxMQiLbtPow0Iu8y969fU80odXaqFBeVbkjnwS
	 D9uCH1/DtQozYMwkxSgDD0LGEcDX+IyBzVpMNkU6yNhFLCzZS5g1sugLfJhkf09kp
	 sIVHu+cspm6lpVo/Jgb1lTjG2WSZsdXd2KLXz+2nKPIto/KnTkYS2R6npqVVepqbK
	 We0QjHsUZx2sy6NGDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian64 ([46.114.241.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1qhp7X2X52-00lVru for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 14:36:11 +0100
Received: from ox by debian64 with local (Exim 4.92)
	(envelope-from <schwidom@gmx.net>)
	id 1rQosZ-00006d-8r
	for git@vger.kernel.org; Fri, 19 Jan 2024 14:25:51 +0100
Date: Fri, 19 Jan 2024 14:25:51 +0100
From: Frank Schwidom <schwidom@gmx.net>
To: git@vger.kernel.org
Subject: Bugreport
Message-ID: <20240119132551.GA31532@debian64>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
X-Provags-ID: V03:K1:RTURR4z/MKx9XlDCgccQrIYc4oBJZclv/zYVxuhj8+BKS09J7aw
 TS5kC/AMaae0XhEzvJ6jAkYKSQn3gEBm5uSB2I/B4hCDmdDDngqN9jNHL2gpUQZf9yR4ULu
 J3PKcohymuQqYwFdYFSikh5iifoxMB3Vezkudx2McplW7/ikqUSnpEIn2aj0iD+IVw1LZHi
 mfgOm/cxzoypQ9BVgKFew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cKoaEveYKUM=;1j8JwgMbCU8gaNrCONUChEEGMsr
 XAM+z4gXtZs+TsvNjqR3dKifhA5M6qciIEagRY7iou695nBPimYHcYI8/8X+0BAHSid5GhOH2
 nzVdcy94eMnaRYYgkEG0gTdR4+gG0m78ewgaxIsowZgmQWcTC2KgsAeSCW07arVY5Cyet5iwD
 e6cqVR7i7oS0UB5GoVov7Gdh3S6eOEysEzycC3qm2mzknmmCWZ8oX+qwYI3XOwcngqVDWjZhB
 yxYGBu2cWd6I2Zjbevj8UgHMjoKF1y47vZq1s68AHVccVL0VqWwnbDcwUoepAPU8YjrJmxWzZ
 GiIb6Og42LDSD18I3tZR5efa+44dD4PB5XcKhez4oEVs6fiYFg/HmTgokHbq81hPUp651Nbl9
 QOa7T8QeLPXj9HRgRRdbsloxYWHBXka+N0lehvwP9YtZSIXul8oDQk7MxpTusupABGAyJfFsl
 +y/qTMY+zlOdyjAYgTnONI9KgJ5PgXGy84YSDFe5qvtfqCcj63sCjLuYumM371OT432zaABMX
 yXFA/1vmuGXgl9gqlp1VzB99MPlW8pC/kw27yo5aMgwgFoG1m4L80EgmvLARDaI5F6bPu+NCj
 Nvrc2/KLaQJMctOE0pDv4VWkCBEOwsDhT6+9xdGlF1MW1tvmTufCh+NGrLYG/knTJTsbq4XGz
 fzV9wl6ghwv+Oz2gdZT19TIwOpqhRy4PMFNgIddvvNNA/9FerbC1OOY3r1m10mijGh9+jaAKx
 F8I9voYOMtnLvszGAB4Gx5M2oXRABFetPPOMfKQHdTN0BeSjSnEF5N5EPouZMdkoT9nNwqaUu
 ksQgJqKtHCQApvmME+f27o86Cxfq1cZ4MhyUUzUZi/8pLRtsyihb8XTn65TY4Zcs+bhRHI/cb
 pGi/rSGV6YepQBFoWBs/Rqo3htOogL+7jT1CJBQ+NNfI4TwNlgZwEcCDPsCC2W2fQylDGipnk
 rTR/gNZCt+eQgBng1TxG5qjVd54=


This bug exists in possibly all git versions.

$ git init
$ touch a.txt
$ ln -s a.txt d
$ git add .
$ git commit -m + .
[master (root-commit) f6b4468] +
 2 files changed, 1 insertion(+)
 create mode 100644 a.txt
 create mode 120000 d
$ ls -la
total 12
drwxr-xr-x 3 ox ox 4096 Jan 19 14:10 .
drwxr-xr-x 4 ox ox 4096 Jan 19 14:04 ..
drwxr-xr-x 8 ox ox 4096 Jan 19 14:10 .git
-rw-r--r-- 1 ox ox    0 Jan 19 14:10 a.txt
lrwxrwxrwx 1 ox ox    5 Jan 19 14:10 d -> a.txt
$ rm d
$ mkdir d
$ touch d/b.txt
$ git add .
$ git commit . -m +
error: 'd' does not have a commit checked out
fatal: updating files failed


# I expect that git just replaces the link by the directory. But it makes problems.

# Workaround:

$ rm -rf d
$ git add .
$ git commit -m + .
[master 522e6db] +
 1 file changed, 1 deletion(-)
 delete mode 120000 d
$ mkdir d
$ touch d/b.txt
$ git add .
$ git commit -m + .
[master 8a125ee] +
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 d/b.txt

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-8-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.25-1 (2023-04-22) x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Thanks in advance,
Frank Schwidom
