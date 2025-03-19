Received: from p00-icloudmta-asmtp-us-west-2a-60-percent-9.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-2a.k8s.cloud.apple.com (p-west2-cluster1-host2-snip4-10.eps.apple.com [57.103.68.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359C7462
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378354; cv=none; b=Qh0lmGQT3S5Lf4t973z/0asrg5MVUZb2zwjh4VQQ3eEY8vzV6j4WNi6SP1zyNV4t8FhCUydP2MtTiXXQ2as1j7j72J7/X6I1hrTw9tgNDIzGrj+/luxqFWp6/lqEyQkV2r1OKu/MwU9H9EezlLAAqLagIrQH0eKEfQnwFo/EX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378354; c=relaxed/simple;
	bh=ntkRXNtlKJVJTGWs9hiumvhifkJ2e7evbzITqIG3/1k=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=HUyN/lKtHuyB1/In9Raa5nDPfyaCUgAOW9r9K3MjpUK9A2yXn//Qhh/i0yf7RZqnb4tqe1sHi4iLSSKrgNNSGCG1iBZpC+w9KypNYISwfhtbY4uS0jGSDKRhQOE/reJQgNGSsDB85DMghyCgI5AHiuXxT4xFwr/OkzzQZjvk4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=norbauer.com; spf=pass smtp.mailfrom=norbauer.com; dkim=pass (2048-bit key) header.d=norbauer.com header.i=@norbauer.com header.b=fJzC3z1B; arc=none smtp.client-ip=57.103.68.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=norbauer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norbauer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norbauer.com header.i=@norbauer.com header.b="fJzC3z1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=norbauer.com;
	s=sig1; bh=AwfWOipZ/Sl/qYjdPjMCr9c/pCtTIuNC/6VsuCGkbbU=;
	h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id:x-icloud-hme;
	b=fJzC3z1B9ZMcOz/kM3abHc/yZCsA8/PglUD/Ix6RNelcmTO5c4KBAG6f8/V89sHP8
	 D7AafhxhZVQvEKHjZPRjQEGbKmEjxT/BPPAq1m7/LaDJaRC541d3H8Du2eI9BpToeL
	 +xVIGowwOJf6+fFnJIxeFOyIvrs0VVoGuSDEd69Lozru/x2I3Ov3Fsj6y9lqM5ip2m
	 cAcUkPDFGxV9RFAdj7OMd9SCbTFQz5oaMCMqO/RpDOrCD47urgZok1aDefQHBQ7VBp
	 ZwSMk+6Oyyk/Hjd1spYpl1A9UB0NpX5T16Em/1ZUCyx7jokMla1VtlVAS6cNZ+yad0
	 CvJ3D5GsJD3xQ==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-9.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-2a.k8s.cloud.apple.com (Postfix) with ESMTPSA id 70B6C180022E
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:59:10 +0000 (UTC)
From: alan@norbauer.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: bug: git shows hints that should be suppressed
Date: Wed, 19 Mar 2025 02:58:58 -0700
References: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>
To: git@vger.kernel.org
In-Reply-To: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>
Message-Id: <7AFB2BA3-AFEF-4003-8ADA-0E42D5A3C4BD@norbauer.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Proofpoint-ORIG-GUID: Y4a3OAHt48qEWYBpJ9hOwIYIATXA-4Va
X-Proofpoint-GUID: Y4a3OAHt48qEWYBpJ9hOwIYIATXA-4Va
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1030 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503190069

I went ahead and narrowed the range a bit:

=E2=9C=85 2.44.1 =3D NO bug
=E2=9D=8C 2.45.1 =3D bug reproduces

Thanks,
alan

> On Mar 19, 2025, at 2:53=E2=80=AFAM, alan@norbauer.com wrote:
>=20
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your =
issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your =
issue)
> `GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3D/dev/null =
GIT_CONFIG_NOSYSTEM=3D0 GIT_ADVICE=3D0 git clone --quiet =
/Volumes/sourcecode/npm-packages/packages/repository-tools/node_modules/.c=
ache/@altano/repository-tools/2078b9db1d71a4f4a5422e25a7016c75/git.bundle =
.`
>=20
> What did you expect to happen? (Expected behavior)
> I would expect the clone to happen without any hints because I =
provided both `GIT_ADVICE=3D0` _and_ `--quiet` to the command. Both =
should suppress the hint.
>=20
> What happened instead? (Actual behavior)
> I received the "hint: Using 'master' as the name for the initial =
branch. This default branch name" on stderr, which caused my tests to =
fail (I am using git programmatically in a test).
>=20
> What's different between what you expected and what actually happened?
> The hint on stderr was displayed.
>=20
> Anything else you want to add:
> This behavior is NOT observed on git v2.44.0 and is observed on git =
v2.48.1. So the bug started occurring somewhere in between those =
versions. I can find the exact version the bug was introduced manually =
with some effort if that would be helpful.
>=20
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>=20
>=20
> [System Info]
> git version:
> git version 2.48.1
> cpu: aarch64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: =
/nix/store/hmffg6n6ylbl4c30pqc9i71mwqzrd0iv-bash-5.2p37/bin/bash
> feature: fsmonitor--daemon
> libcurl: 8.12.1
> OpenSSL: OpenSSL 3.4.1 11 Feb 2025
> zlib: 1.3.1
> uname: Darwin 24.3.0 Darwin Kernel Version 24.3.0: Thu Jan  2 20:24:23 =
PST 2025; root:xnu-11215.81.4~3/RELEASE_ARM64_T6020 arm64
> compiler info: clang: 19.1.7=20
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>=20
>=20
> [Enabled Hooks]

