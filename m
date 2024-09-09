Received: from ams.karleo.net (ams.karleo.net [178.62.251.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992F1B81D8
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.251.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893321; cv=none; b=YT1B8bYU3vS/N6+QHCrkjNqDwgr2Ch/11SOvU/FF2LT/k6lCSOz3kcrN0Sq0de/d/M7y4BcBhw6t4vbGpLlY15Fn76zrWMMJzPmJ+Ei/5TVRbracfMSG2WAhUW6kgQr/zjBuBiEsi3dWJECEq4b4q0NZ3biTyCcSN/Ve1yRtFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893321; c=relaxed/simple;
	bh=B3vTHCfpLC+uA0FYwc55QiZ+xXjmguNlY0tvYmHkd+s=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=NBsBg1Hh8IKU1r2fFaBeZ74+wjDWD2Hwp7RR1+vaqfjhvBsGLs6PcjaCOXYIRKZcxlhdtRnqwSuWeVr6z6g5KpUEUGcVxXMS8QSPeV6VtB+CP2XcjA0n9sfsiAa0n09hBZfJ1lpPare0hR6Mu/tOE+VbHPf+Y3ggW7ntMygIZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timm.sh; spf=pass smtp.mailfrom=timm.sh; dkim=pass (2048-bit key) header.d=timm.sh header.i=@timm.sh header.b=bd5Ss0zb; arc=none smtp.client-ip=178.62.251.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timm.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timm.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timm.sh header.i=@timm.sh header.b="bd5Ss0zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timm.sh; s=2020k1;
	t=1725893317; bh=B3vTHCfpLC+uA0FYwc55QiZ+xXjmguNlY0tvYmHkd+s=;
	h=From:Subject:Date:To:From;
	b=bd5Ss0zbQWZ5iHYGhYe8U+3Le9YDuXyB7Kd3rUGaJklopc22Wo3eZCsjhFs7cSQkg
	 6Dtils01X50afpzeAtdRHg5jLttpfNz27zxp4vqgYjc5HaU+qfutvBMTX998ApQblW
	 dxbAictYixtyTrlZjUT+RYcNBXxj1YLIa13S5A7qVMCkKyNhvYAvF+CEAFCfIN76Hf
	 dfFxSRtZTAzUNeC4zxRsybdbomqZ3e6cq60j7ZzwFG8UkLgR8MdL4NW3dP6vwMgDrt
	 xpeixGAfT8ZyKjnHid6/NkftklKLWVz/PdGfQosxjbzhroMU1KmJQw1dpO9xWieyNG
	 yaaZh5AZfz5Aw==
Received: from smtpclient.apple (unknown [IPv6:2a02:8108:121c:d0e0:ada1:7a23:5bc2:824])
	by ams.karleo.net (Postfix) with ESMTPSA id 3E7E04015F
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:48:37 +0000 (UTC)
From: Okke Timm <okke@timm.sh>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: [bug?] git diff --cached in a non-git directory
Message-Id: <92DCB50E-A2F6-4334-A0C5-A9CB2D29AC18@timm.sh>
Date: Mon, 9 Sep 2024 16:48:26 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I changed into a non-git directory.
Then I called git with 'git diff --cached', which produced this error:

error: unknown option `cached'
usage: git diff --no-index [<options>] <path> <path>
[...]

What did you expect to happen? (Expected behavior)
A helfpul error message.

What happened instead? (Actual behavior)
An unhelpful error message saying that cached is an unknown option.

What's different between what you expected and what actually happened?
Me being confused why git suddenly forgot that `git diff --cached` is an =
allowed option.

Anything else you want to add:
Please fix and thank you for this great tool!

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.4.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:14:21 =
PDT 2024; root:xnu-10063.141.2~1/RELEASE_ARM64_T8103 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

