Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8779DE
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713582547; cv=none; b=YyyQJCE26YT3iRQVX69gwzM9vDJn9uk3J7NwwUSSutpGddFZCGop5E1fkiAIW+ZCFmzVjWXUAbOXD95c7M+23c2z/e5BCAAyeoy3Pgqi8fM/TLj8drbBku8AlXZFjPwUu7BMvdsNTIZ+94fsY7nTChOVynYz+J++Dg82Sj+AjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713582547; c=relaxed/simple;
	bh=+LRz0idqs/Lk7dYUAGeYiPAPx6BgBSvqrUQTg/3WJlw=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=okCf4X7s5KkZTmMuH0A5A6OYfNmto4e7/rP4VNLVCgtnXb8hsNpBJKE9XxA/6ZFfTFgb1wJaibiCFC+2jQ8wg3/qJJKR0dmUsIZqp93QefyhY/ymliuUKt03VBxI7l733YEiyPuneB5TJfgFrB28XSHfEolSsA6/Y5iST7IuLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JqCTER9s; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JqCTER9s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1713582535;
	bh=+LRz0idqs/Lk7dYUAGeYiPAPx6BgBSvqrUQTg/3WJlw=;
	h=From:To:Subject:Date;
	b=JqCTER9s2gYjXHDmC8fSaI/xFaOzbVSp8htoIxoKG1HyG+P7fCBL2gccVk5uBwqLp
	 r1XSlaDzJFyjXgtdPrq+zV48WfoxGCqj9R3icUZHzngnRDWZSBrNx6+hy7y5x/Uf/7
	 mK75bgCgcEIXBceyZy0Wni7DsfawTpdGUuWf/8f4=
X-QQ-FEAT: oHWrrGTW1dDc6WqWDAkbuvNXljmAAGFi
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-XMAILINFO: MYvQTNt/YNi0PyvuhjZO4GYx+qmjetOBOxCuPLxopd2/UJgYrQbZrU+DI5Kk+1
	 zZdj3cVVzLUYj71ESdNGq9nDoaIdWzOGjjB4WMTYMc105NOvkIs27pE66QmUsSyLpe6U9U7DUerMD
	 d/2Iw0+yc0BlP9SuTCxxASy5KBBQK5TGQkqZgcacCQdtauUldSheePYG+aivj80bPgGZ2RednuQJI
	 7OcwAMZZNF8xdmEeV86IdkWN1UmvzK2yImKYD+FzbfdSxAQ/NuPUycj7WECiEGxniOG92d+D7dUtD
	 K7L3bP1flFvcdamyjfsrbBMWlnhYqgx0e5327+isVis7NU9i6j7BgmkBNmO8tpNV/o0s7HkdKkWFN
	 1A+q2gU6Zang9lfwa9uoQk1JalyoPdPb3yekrb3E7bzCK717w2VFu9GS5jbC0KUY9jMYlpw8aucqF
	 ojmBiYSYBeM4t3JXzN/LgumUPb+62IxPC6F/5Mm9XOnUGRoXUCw0lOKq6D9i4CLht+AmprcX9TNeC
	 GKFmItKwNygZdoLv4FDkDVhYW7cbp33rJNnNhZrUhuMU4s+zRgJoBmFecOvTqotMisqynTU/byB6M
	 02Ur451vCyj66kN20AEwfRre+jY/cDmJsh0PbMWNlp0lBSedqZnW2cqMahOun3D7aTkSpqPhOn+jP
	 Gohz6zY+rPNC8sGl5jMYiKRCxdqMKk53zfeNkbMNnRvfDeEV4Z+RJ3ZRG5g6bRsJHytwvW1hBXW1j
	 7hfLrC7hGDzpkPrBNu1K0xsZTtmR1AmP7qm4rFSq3Dj8xG1QUQ1U9BBxECiWYYiUTzYqGeZOr/eYW
	 uu8HAY5ZqZ4rMhw+Amx3a9cPc28luZF+ALN7iEB8j8URUh+4nx5bjvfqQDwYkgmLHdA5Qp9KIfxfn
	 1hmUAH0TjkjTZ0ywehit4pdF0KwDGjz4iNJQBP/I3dj0v5/AYJM0VLHTbka0tOKCJKp65qryle78X
	 IFsa6x71GuD4oSzkwTsSlk061zomRPE76XhHU4pHqZuIY70ELU
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail443t1713582045t2130250
From: "=?ISO-8859-1?B?d3V6aG91aHVpMTQ=?=" <wuzhouhui14@foxmail.com>
To: "=?ISO-8859-1?B?Z2l0?=" <git@vger.kernel.org>
Subject: Why conflict when merge a branch that the directory is unmodified
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Sat, 20 Apr 2024 11:00:45 +0800
X-Priority: 3
Message-ID: <tencent_6FF9636AA4D83460C0CE7C9F1EEC3463CF05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

SGksCgpTdXBwb3NlIEkgaGF2ZSB0d28gYnJhbmNoZXMgd2l0aCBmb2xsb3dpbmcgY29tbWl0
IGhpc3RvcmllczoKCkItLS0tQy0tLUQoZGlyZWN0b3J5IGFiYy8gbW9kaWZpZWQpICAgICAg
ICAgICAgICAgQnJhbmNoMQogICAgLwpMLS1NLS0tTyhkaXJlY3RvcnkgYWJjLyBub3QgbW9k
aWZpZWQpICAgICAgICAgICAgQnJhbmNoMgoKSW4gcHJldmlvdXMgZ3JhcGgsIHRoZSBCcmFu
Y2gxIG1lcmdlIEJyYW5jaDIgaW4gY29tbWl0IEMuIEFmdGVyIGNvbW1pdCBDLAp0aGUgQnJh
bmNoMSBtb2RpZmllZCBzb21lIGNvbnRlbnRzIGluIGRpcmVjdG9yIGFiYy8uIEJyYW5jaDIg
ZG9lc24ndAptb2RpZnkgZGlyZWN0b3J5IGFiYy8gc2luY2UgY29tbWl0IE0sIHdoaWNoIGhh
cyBiZWVuIG1lcmdlZCBpbnRvIEJyYW5jaDEuCgpUaGVuLCB3aGVuIEkgZG86CgogIGdpdCBj
aGVja291dCBCcmFuY2gxCiAgZ2l0IG1lcmdlIEJyYW5jaDIKCnRoZSBkaXJlY3RvciBhYmMv
IGNvbnRhaW5zIGNvbmZsaWN0cywgd2h5PyBCZWNhdXNlIHRoZSBkaXJlY3RvciBhYmMvIGRv
ZXNuJ3QKY2hhbmdlZCBzaW5jZSBjb21taXQgTSBpbiBCcmFuY2gyLCBzbyBkaXJlY3Rvcnkg
YWJjLyBzaG91bGQgbm90IGhhdmUKY29uZmxpY3RzLgoKVGhhbmtzLg==
á
