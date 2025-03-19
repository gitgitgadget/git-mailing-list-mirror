Received: from p00-icloudmta-asmtp-us-west-2a-60-percent-3.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-2a.k8s.cloud.apple.com (p-west2-cluster3-host11-snip4-7.eps.apple.com [57.103.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A81AB50D
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378052; cv=none; b=IXFL+uT7SSakjgswSLiJni3B63DlWMpAm/r/AHGc884FtUsO7CBlbamembBaBria2cWJvJBKhXqguOrYwgkvj+khhaFbEQ/RGMv8Fp//btHEBuY8qjcGXmNnxyZeoz4GfasXrrR2k3g+mqqS450bimR6nAV9lXSmSSmILGrSB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378052; c=relaxed/simple;
	bh=peLCNJMY5TTinb3N/OtI6N4hVwU0FKr96AUKIIFWmJ0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=IvKOvsIbiy7DAeVGy4iihZZZvh+RKazc5KeN+EzGz2F6kQff1HYQ6qzep1LDDf6qEJyuEX4OBXt1GfBfpJZwiSw6ui9oAgVBd7EEy2gDjjgOQ8JIjWj51ev2qmy4PleEiqddOrmBC24geFuhuvPkPwkG4d0cPgFk5FsqUpUqIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=norbauer.com; spf=pass smtp.mailfrom=norbauer.com; dkim=pass (2048-bit key) header.d=norbauer.com header.i=@norbauer.com header.b=YxaBvymf; arc=none smtp.client-ip=57.103.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=norbauer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norbauer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norbauer.com header.i=@norbauer.com header.b="YxaBvymf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=norbauer.com;
	s=sig1; bh=Z12DTHybphPGpwlHzP/gB4mVkm9BrSBN12EfWhFMkPI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
	b=YxaBvymfahzFxr9qU3jVLHqSy4TLXg0Hf8srT332ZtO419hj16liZhwXxVeth96jX
	 dF+c5VZi5OOkXgHfuBkdrWKGhPsI+3a9DsoxGtCQuOGJBKDg0+nySmD2z8gBcHkPic
	 msvXFd+HIx2F1KGZYyUYbkKWU30n+Sv6lT5pUyREb2MP6a+/e56kAJYK5rLL/vhlzj
	 Cw1KuU2z3NTlx05Eufp6iC+ATJj/QYtmy+X9L+TYko52T1FkI9IKotubqvVDKGHKAp
	 Gscn92aPG+a8Ph3OgzybJ2IxJApfgQVXvabFL7/BcbtiZeML4h4Mu7QUqMqw6/mM3R
	 fD21Sk+Wgmuxg==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-3.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-2a.k8s.cloud.apple.com (Postfix) with ESMTPSA id 7C8B418001C6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:54:08 +0000 (UTC)
From: alan@norbauer.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: bug: git shows hints that should be suppressed
Message-Id: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>
Date: Wed, 19 Mar 2025 02:53:56 -0700
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Proofpoint-ORIG-GUID: ty3auunEXx6GZJ2SOWl-ZdPenRUGhRrc
X-Proofpoint-GUID: ty3auunEXx6GZJ2SOWl-ZdPenRUGhRrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1030 mlxscore=0 mlxlogscore=980 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503190068

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
`GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3D/dev/null =
GIT_CONFIG_NOSYSTEM=3D0 GIT_ADVICE=3D0 git clone --quiet =
/Volumes/sourcecode/npm-packages/packages/repository-tools/node_modules/.c=
ache/@altano/repository-tools/2078b9db1d71a4f4a5422e25a7016c75/git.bundle =
.`

What did you expect to happen? (Expected behavior)
I would expect the clone to happen without any hints because I provided =
both `GIT_ADVICE=3D0` _and_ `--quiet` to the command. Both should =
suppress the hint.

What happened instead? (Actual behavior)
I received the "hint: Using 'master' as the name for the initial branch. =
This default branch name" on stderr, which caused my tests to fail (I am =
using git programmatically in a test).

What's different between what you expected and what actually happened?
The hint on stderr was displayed.

Anything else you want to add:
This behavior is NOT observed on git v2.44.0 and is observed on git =
v2.48.1. So the bug started occurring somewhere in between those =
versions. I can find the exact version the bug was introduced manually =
with some effort if that would be helpful.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.48.1
cpu: aarch64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: =
/nix/store/hmffg6n6ylbl4c30pqc9i71mwqzrd0iv-bash-5.2p37/bin/bash
feature: fsmonitor--daemon
libcurl: 8.12.1
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib: 1.3.1
uname: Darwin 24.3.0 Darwin Kernel Version 24.3.0: Thu Jan  2 20:24:23 =
PST 2025; root:xnu-11215.81.4~3/RELEASE_ARM64_T6020 arm64
compiler info: clang: 19.1.7=20
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]=
