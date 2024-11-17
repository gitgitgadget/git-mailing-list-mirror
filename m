Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C83209
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731807124; cv=none; b=dKnBseIqb54J35RsNXvpQIfHwW1VLDblBWwowueWCR0HlULbZNdZnyjf1zjE0XbqImGQ8qCLQk/J8WfpEu/QHDUC4mxyNNCen/HqYDc+rnAuN8vOvHBJXp5sZ5LiMnHYQUhHAaDE5VdqiGnUSAcdBcOO89lCVpvfL9S3HH5HAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731807124; c=relaxed/simple;
	bh=8bWurrWoe6rrCbYp93wow5VfeENJkpWiAkJ3n6vEwqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFEXZTKGUYN/KAcK3pT+RBELncqOBkiYWaTbYcwqI8UpAwnjqPcRNA401oETYhLI+VzYq8+JtHv8Zg0rcUwB3IHtOvH+8VzI56mEaXpbff5QYgbkgmKkflSakGlVCB0jO0o/aqBD5F1c4cvSDNuh4o3phI1yrgC2ZTdYRP7iWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GG48Gs7/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GG48Gs7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731807115;
	bh=8bWurrWoe6rrCbYp93wow5VfeENJkpWiAkJ3n6vEwqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=GG48Gs7/W3+m/9EaCbv3DZpkWYdJHG03rieuyTZDRALtSD/kurQwe1l5pqu7JO5LS
	 oRxqrCFsg/g9Pe4VwyGNHLPPxPXL04PRE1x7ADhBkoYG2seQmUG44bvIPMDVtlSt7T
	 eFz/6iXNPy+kUqgh6E4j/4h8vFgAfT+N6xwa91W7jelGn+iaRtvX8LoE2UV+VEeNS8
	 +RKJJvF5v9Jhnr3CkKl3RMdx4riPbNhnfaxz2wZwumQlSlbbu688J94E4/RN8+H2fH
	 d8mrCHzin2TQgykY8U7YIvQDb2V31fTxQKzm09c66A3JEK+IUc/mQ7w4HTmjJxBkTG
	 7D5RDBlifSkCiMIEjosNmNOw3TDVeNJ81cH4saam+hT3UUWKionFaoBK+BBT4yrgEM
	 QHWXbi2+k5QeBCMEGcyvm9NXQGa77cWlg+Fvnew/Kv2oDmu7pVY+lKMrfZ1xFGW5Rx
	 +WKw3THJE+zFgsRTWAHQZwLbSBoOTGVpWT7prkRyrshUzevXR6R
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2B43C200C4;
	Sun, 17 Nov 2024 01:31:55 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH 0/2] C23 compatibility
Date: Sun, 17 Nov 2024 01:31:47 +0000
Message-ID: <20241117013149.576671-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <87ed3apy2u.fsf@gentoo.org>
References: <87ed3apy2u.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of our code works fine in C23, but there are some new additions to
the standard that conflict with either our struct tags or functions.
With this series, the code compiles and passes the testsuite with
-std=c23 on GCC 14.2.0.

brian m. carlson (2):
  index-pack: rename struct thread_local
  reflog: rename unreachable

 builtin/index-pack.c | 10 +++++-----
 reflog.c             |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

