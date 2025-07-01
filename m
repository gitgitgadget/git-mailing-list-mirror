Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE6238C0A
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362194; cv=none; b=L/X7alL2BUssgFpqA4its7pQNsNm6uiCbC596dwyjORzgB7Su53z5pxoA5yeueB4ArjX+fBXAfSF9fVUJKwz1UfqGMdVZszw7VTwUrkuJxfMUtygQEaz480IZOpmFm56GexepeTmfnfLQ0SFoDmJcc1XHjT51a4mmN7pTaj5hMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362194; c=relaxed/simple;
	bh=vHpSuSq/lb+cBQOnXPbJBuYUNE1zv7pneP4n2BoAc2U=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=glvZGK7GNkHRY/Nv1ZIGYv6D978F4BBSK8+knMqiYErkF250l9/zTLERIVaFVJVPa0jA3pHrBNJsskg/o4P0lC95ybyveu3vnKTaKmReAXcpUsP8tGPVFWuzy2ZMReTSjd8SB3uIFerWRR2taRzxsGSi81+0IzhdMUjWUzlbZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b=CKy3kPyS; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b="CKy3kPyS"
Authentication-Results: mail.aegee.org/5619O6TC4169213; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1751361847; i=dkim+MSA-ssl@aegee.org;
	bh=vHpSuSq/lb+cBQOnXPbJBuYUNE1zv7pneP4n2BoAc2U=;
	h=Subject:From:To:Date;
	b=CKy3kPySjdlGTbhOH01PrnWKeGRTDDEckVatGk6Y3bh/jlnfLJjWznMDIQfk69J6u
	 F+LPMV9XeADOqnCT1YWM3q22G5cFVBjZStdt0D/nPB+qKeEuxoHoJ+/+ej1hU9++c1
	 ZHAqIZLLty21mX7jaZisZvQSdx2TugxVHMoFMjkLom5FGBqMvLnhVwlWmasofHgSRi
	 jb0VBdQZKmDUBe/zsVg7RocexVsPEOVI0R7bEvqURa+sUIq7il9SALgxo0lmpeNtJR
	 gx6/H0/M82HILbGFYbRddDifumZQDN+ujj+0A9n5me4MY90TtTR+b3JibYXHZ85P1T
	 R3z32CwFmxNlDxFHkC6yf7EuPMf0JmM0UP4vO3OeXruBDwQiMITowBl+Bh4HdigR62
	 V/kFG3XYRxoPg1sQS+tMTIT/WGGjyzhdtFFQDMy755ATHwPlmqucDPKUuhB+Moox5w
	 3GwVQhFGoN+VkbNO8HPG4L7jUBH7K51pzRPktOkrqL3R9lR7neCOSFLJaLiDyoEEmd
	 v9bR0M7a1tZq2cmkDxiVMe2f7rh4fiu8NlkuLagB3Yr8V8uIkvYLZJC/YamwtzbkWD
	 XGhb9z1aHM1umHg1WvKThYBP6FBLOojNMBDrByBPmHn7Ubo2EiuMZiWr+PbkFji1Ys
	 /INlcUwZQ5gVWAG45YPuSqz4=
Authentication-Results: mail.aegee.org/5619O6TC4169213; dkim=none
Received: from [192.168.0.242] (95-43-114-153.ip.btc-net.bg [95.43.114.153])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 5619O6TC4169213
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 1 Jul 2025 09:24:07 GMT
Message-ID: <e7a2fdff63d9a90ef4dc1341fa642fff5197b64a.camel@aegee.org>
Subject: git treeless-clone + wait + pull =?UTF-8?Q?=E2=86=92?= problem,
 again pull =?UTF-8?Q?=E2=86=92?= OK
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: git@vger.kernel.org
Date: Tue, 01 Jul 2025 12:24:05 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.57.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

the problem is that when I do a treeless or blobless clone and some time la=
ter git pull, git prints many, many lines that it tries to fetch data, then=
 I interrupt with Ctrl+C, then do git pull again and then it completes.  Ho=
wever I never tried to precisely document this until now:

On 26 June 2025 I do

$ git clone --filter=3Dtree:0 https://github.com/git/git.git
=E2=80=A6
$ git show --oneline
cf6f63ea6 (HEAD -> master, origin/master, origin/HEAD) The fourth batch


Today I do=20

$ git pull
From https://github.com/git/git
   cf6f63ea6..83014dc05  master     -> origin/master
   74e6fc65d..83e99ddf4  next       -> origin/next
 + bc3287e71...a842a7780 seen       -> origin/seen  (forced update)
   fefffbb31..7af8e2e03  todo       -> origin/todo
fatal: You are attempting to fetch cf6f63ea6bf35173e02e18bdc6a4ba41288acff9=
, which is in the commit graph file but not in the object database.
This is probably due to repo corruption.
If you are attempting to repair this repo corruption by refetching the miss=
ing object, use 'git fetch --refetch' with the missing object.
fatal: could not fetch 5e66731277a4d791043dc51e2804dc0b496c523b from promis=
or remote

$ git pull
Updating cf6f63ea6..83014dc05                  =20
remote: Enumerating objects: 22, done.                                     =
                                    =20
remote: Counting objects: 100% (21/21), done.  =20
remote: Compressing objects: 100% (21/21), done.
Receiving objects: 100% (22/22), 137.56 KiB | 8.60 MiB/s, done.
remote: Total 22 (delta 0), reused 1 (delta 0), pack-reused 1 (from 1)
Fast-forward                                           =20
 Documentation/RelNotes/2.51.0.adoc     |  15 +++   =20
 Documentation/config/merge.adoc        |  14 +-  =20
 Documentation/git-merge.adoc           |   2 +-
 Documentation/git-stash.adoc           |  29 ++++-
 Documentation/merge-options.adoc       |   3 +
 builtin/merge.c                        |  66 +++++++++-
 builtin/pull.c                         |   3 +
 builtin/stash.c                        | 460 +++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++--
 contrib/coccinelle/commit.cocci        |   3 +-
 hash.h                                 |   1 +
 object-name.c                          |   6 +-
 t/t0021-conversion.sh                  |   4 +-
 t/t0610-reftable-basics.sh             |   6 +-
 t/t0612-reftable-jgit-compatibility.sh |  13 +-
 t/t0613-reftable-write-options.sh      |  24 +---
 t/t1400-update-ref.sh                  |  10 +-
 t/t3903-stash.sh                       | 101 +++++++++++++++
 t/t5004-archive-corner-cases.sh        |   5 +-
 t/t6422-merge-rename-corner-cases.sh   |  10 +-
 t/t7422-submodule-output.sh            |   9 +-
 t/t7600-merge.sh                       |  74 ++++++++++-
 t/test-lib-functions.sh                |  16 ++-
 22 files changed, 789 insertions(+), 85 deletions(-)

As can be seen, after treeless (or blobless) clone, git pull has to be exec=
uted twice to complete the operation, the first time calling always git fai=
ls.  With always I mean over longer period of time I tried this with many d=
ifferent repositories.

git version 2.50.0

Kind regards
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD
