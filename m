Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4734779DF
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719050480; cv=none; b=ktKbXkNLzKNrDCG1BbVvMEyswk8G+JXhROiZJn6Epv1CExmONtT33+Vywx12pPMvcm+ZuT3xYLRv0gqq2SRNmII1wVhuCSuyvbR82xwyLIWjFw+km+ksndfUzFVCd5VK4IWVgkplws7UYQyMFV11c6EIvOkH2wZBIDyNhZvG7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719050480; c=relaxed/simple;
	bh=BH+Kba6n5vGN43kYu1d/dT7pXmVp4DT9NF9iskH7eLI=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=CjWlclzDg1qysdx/Yc+NIwbs3PEH96J+Oww5/97JT8YqgLAxzSAtBclzD0vJPCOpWwSHp4PzcU1b+5UuCR/sz+cCsQsmtaFZ21GNUP+wZUAc9GgpfRGdvIUEO601JKuZj7Z6nYIpM2C//oQoHItpwK/oILWz+YtRtMxR3BxZv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b=Zp6skNys; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b="Zp6skNys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719050476; x=1719655276; i=lolligerhans@gmx.de;
	bh=zQT9+0CIjp8bB+kjrkK9TVbAc5V4n/EIMJSZPLXnKuY=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
	 from:message-id:mime-version:reply-to:subject:to;
	b=Zp6skNyszLMrm69ExZpBLJGtD0BySMn+YX6i6OpmIdWmK97M/HJGGYW4ULJeBaBQ
	 UZz9kpZ6dYdZ2hgEi0a3q48zyM57I8MwDJhAIN/fTVRgjUKKOBSz/x+Q44kvGY7AP
	 BT/5G/Dhw6fqjLH+CDXNTZfEdM6ZV3M67rBsjUaxW1bgdHG7rI5dERRgUqzqsWUbg
	 liYmadNX2sBFq4KFV0ZxJ8FjVRM1VheBBzURwBfbMECnDS7MZ1YiioOyJRcoAlG88
	 +UrwgU1AFG/Mw1GZTIKjoulXpeiD5ZEVxJPrgkFqCwlYQNasEIVJRpgrfdmcf1E3q
	 NiY6BIQreScXGNClOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.15.3] ([10.236.15.3]) by msvc-mesg-gmx004 (via HTTP);
 Sat, 22 Jun 2024 12:01:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
From: lolligerhans@gmx.de
To: git@vger.kernel.org
Subject: Bug: diff.external --no-ext-diff suppresses --color-moved
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Sat, 22 Jun 2024 12:01:16 +0200
X-Priority: 3
X-Provags-ID: V03:K1:53x7l66wkhwA2G1yzeCzOchZWeCZrooyW58ZUxqx5+ix2l+/q3c+Yjy6AB56ZHvdAb/WS
 YdYOODUs8NrwTA8xCqpTYD4igDqPPx/BuIvShAriK0ue6htxYkJGF+6VgkWbnsZkapsmxldOY0gi
 ofJNBK8LgDLxxAeHSLwrttrxZ76m9D0xze7sFswDGQzYj6ZHOfmIwIhXEKcilO4IPEHUL+quslPm
 8cxKu4ZCD4M4W1wIbSIcueSowZSuXRzejMCw92HPI9EMLl3ETaSg0G++0g4s67R1TjXeLRxbWZJm
 /E=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a2UDVgx7r10=;mkGrRxIQHVMwM9sMRyJPaL0lg9+
 JehzoT+fgC5Ck81NGmnWVPO/f5dLstW9uzrRkee71Sxh8E0rVYtX8BD5kMisMruiuwyfn2gm/
 7hZlkokmVbhovimfSHLgP+zoxV9NlTO337FcWwsXbNPh34nJg8dItdH6nJBkw6630Aydz2iQr
 jWW+ai9t05lWC8jBgwyaEIM8sc93D1mTY+BSQ60kwUBaFHuDwz+hpmHwuDMkI2HEoqsO3JKfu
 EQsBScBpGRuN4ValN6AdvjTSvtC3KjMW42olHCYCAInYm+dRny0oIArqom24HJ60NFxufTmlP
 zfOA2e4pYrhh1r8rYH4h2he92+c2m0UlhNKHY30YeFganNw7MLRwVFyPhF9z1VIAE14DdUMOi
 748cWQFfQ0xpz9/N2+8c1oGqBkoF1kERh26FglAWhQNEgHlTy97gbmPypQgxSWmdjsxFCVJ3m
 9bs9KipU+mMRPICLuWzAj/37JQNDnk7k6DLvdibKH6SNd7m7usIrrh4I0QD33AFin+K1jIZlO
 igHrI2nRczWEynedlx8okMSWnu0L427qPvzgJP/+xxXzEG19AFloRXbQzORKpLyLAAleZDqWR
 A2f+7yYRlF/vXhgFLYBa79I3pWnsMr2URBqc5nwluwxp4nYKBXFJcvTt414aalIC4Byic1X7c
 Wb/nVdRxgxnXrU+mB9E4n9NPUVdzRL+byBuOHvCv+w7vr4aqW5Jx/P6PGEgxaNA=

Hello,

I configured "diff.extern" but use aliases for "diff --no-ext-diff". This combination suppresses --color-moved (as well as the corresponding config "diff.colorMoved").

What did you do before the bug happened? (Steps to reproduce your issue)
  1. Prepare ~/.gitconfig:
            [diff]
               #external = echo
  2. In some repository, create a moved-lines diff between index and working
     directory.
     For example, commit this file (the next 9 lines verbatim):
            line 1 first one
            line 2 second two
            line 3 third three
            line 4 fourth four
            line 5 fifth five
            line 6 sixth six
            line 7 seventh seven
            line 8 eighth eight
            line 9 ninth nine
     Then, edit it (moving lines exactly) to:
            line 4 fourth four
            line 5 fifth five
            line 6 sixth six
            line 7 seventh seven
            line 8 eighth eight
            line 9 ninth nine
            line 1 first one
            line 2 second two
            line 3 third three
     In this state, the command 'git diff --color-moved' should highlight
     changes as line moves with default colors purple/cyan.
  3. In ~/.gitconfig, uncomment 'external'.
  4. In the same repository, trigger the bug by running:
            git diff --no-ext-diff --color-moved

What did you expect to happen? (Expected behavior)

  The diff should be recognized as moving lines and colorized accordingly. By
  default in purple/cyan.
  The diff should NOT be colorized red/green.

What happened instead? (Actual behavior)

  The diff is colorized in red/green.

What's different between what you expected and what actually happened?

  The colorization is expected to indicate moved lines.
  The actual colorization indicates deletion/insertion, as if '--color-moved' is
  ignored.

Anything else you want to add:

  - I assume this bug is up to date with the 'next' branch, because the command
            git log v2.45.2..origin/next | grep "no-ext"
    finds no match in the repository from github.
  - Works the same in the older v2.25.1
  - Works the same with 'diff.colorMoved' instead of --color-moved
  - Works the same for other values of 'diff.external'
  - Works the same when setting custom colors for 'color.diff.oldMoved' etc.
  - Works not the same when using --no-ext-diff alone. Only when using
    diff.external as well.

[System Info]
git version:
git version 2.45.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-107-generic #117~20.04.1-Ubuntu SMP Tue Apr 30 00:00:00 2024 x86_64
compiler info: gnuc: 9.4
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks] (none)
