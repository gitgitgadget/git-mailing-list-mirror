Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBF189F51
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568336; cv=none; b=C/1/6i6iauHcL42Qzzexs24c1+ruOr6SY86NgJZeI2T5vfJXebUGEtDqppiu6q1NyMki/3CgG76qmPf0fk+8Xh3RrnQhQSGzREQGd/zy0n2ubaEelGbgt70vbfQyy6pZVFivQ5N4A5Imug9A/CC8RDkQDq5Cnnesf76HPTPAGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568336; c=relaxed/simple;
	bh=u1qIKaBHLyTOUyN8JK4shX/TddOVaa0TPiFnPvLNmfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM6I2v80cZ/lnMYEKUUFwf4mAmpgGJHMHPhYGeX56BAarUZazFftMeNdHRc3AlsYjKe7q4k2K3ZvujL9IvnaXB9rqLqxC0yBGjFWGqhaM1WflIN1pZTKzzGLlwTrUA1Ws9QbhFLXulrB8fO/0VlHBE5cqDa2YH+ALg5QUgyuyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Hv1DdfV9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Hv1DdfV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720568333;
	bh=u1qIKaBHLyTOUyN8JK4shX/TddOVaa0TPiFnPvLNmfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Hv1DdfV9Xs8vklzWqsKBU1oD70X94KZp1BBrNatrsl95Gk11nc5AwYV5IitY1S+Gi
	 H33hseNxEoWpSQGlg66z6P5FtC8jKIGNXUXL+3u++OijHxwNjrRaG/tx7SbDrpGKny
	 vPkReqLejoXGuGzXwoJKqUz0RPRqs19qxpM9tsaA4faS+UPoYJ0xvHdC/UUNM2UDPL
	 lYfiqmEZV9fj3pwYqX6vEmaEyyB5vMnwlqTPGwoKblQaFH87krO/RBpLEioig16yEu
	 5EN0cV3UkR0/t6/HD9/9rs0pk9BesL/Vc3UdE+OasZuqiqxwEP5d1z9GWFzS313WPK
	 flVjPmDB7xBTAGEgx1dlK0mUmRocKcAZBBGfz3LwWH4s6ebldjt+joRzWHOAKT5b9x
	 2rtG4qUl9NYRCm0ndFir86NkCmzpR+EacZdnN2FzS+TVQe3X/6FIu7JxApVgt/XaY5
	 RBbT8HXS4B3vUUlGSbFQ8yVCWFWllobTferK7s2gYBZ3RnXXhEJ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C5B2220991;
	Tue,  9 Jul 2024 23:38:53 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 0/4] Additional FAQ entries
Date: Tue,  9 Jul 2024 23:37:42 +0000
Message-ID: <20240709233746.445860-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240704003818.750223-1-sandals@crustytoothpaste.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces some additional Git FAQ entries on various
topics.  They are all things I've seen in my professional life or on
Stack Overflow, so I've written documentation.

Changes from v3:
* Improve text for eol options in .gitattributes.
* Split working tree syncing into its own category.
* Add some more explanation about what might go wrong in such a case.
* Rephrase some text to avoid repetition.

Changes from v2 (partial):
* Add documentation on proxies to the configuration documentation as
  well.
* Mention some security problems that are known to occur with TLS MITM
  proxies.  This mirrors the similar Git LFS documentation.
* Provide a documentation example about how to use proxies with SSH.
* Recommend running a `git fsck` after syncing with rsync.

Changes from v1:
* Drop the monorepo patch for now; I want to revise it further.
* Reorder the working tree patch to place more warnings up front.
* Mention core.gitproxy and socat.
* Rephrase text in the EOL entry to read correctly and be easier to
  understand.
* Improve the commit message for the working tree FAQ entry to make it
  clearer that users wish to transfer uncommitted changes.

brian m. carlson (4):
  gitfaq: add documentation on proxies
  gitfaq: give advice on using eol attribute in gitattributes
  gitfaq: add entry about syncing working trees
  doc: mention that proxies must be completely transparent

 Documentation/config/http.txt |   5 ++
 Documentation/gitfaq.txt      | 109 ++++++++++++++++++++++++++++++++--
 2 files changed, 110 insertions(+), 4 deletions(-)

