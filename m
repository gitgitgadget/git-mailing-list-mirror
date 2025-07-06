Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746A19ABC2
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751819417; cv=none; b=Hrak4ovuN3/SjXLExTaoOn4gKl3ijupUCEhbjaT5BAhLQC9TYywQsm/xwrugsoHyE7TnRcvhGwEBUU/VGmEDBm4oZvQBYQxd+SbTufjI3B2cDdRWQU7BVYGCOjZHeS+btCIl4nNWsnu9iVw0gr+zQoL7OKb1qzx/ef40ZkfiznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751819417; c=relaxed/simple;
	bh=QWqDgO+poCO7VAMg/QZqfpDMboFnKuRVIKoXp+KVs/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNf8LV6C91xRyKtucXywJ+odL1TkfNjGkKtBOU0lvLU/lGwgsbGNqi1wE2+HgoHq3SLpMrxiUf0eBLieKsdLtc2O7BlKsjiuV4DwXelFp2tgf/pLsO9O3ChoI4AmgpIeeVR9SUiw4oxsLESs/DEX9Q1X3Q8UzlCzJ2uKSuIFXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZZFaBgow; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZZFaBgow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751819413;
	bh=QWqDgO+poCO7VAMg/QZqfpDMboFnKuRVIKoXp+KVs/U=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZZFaBgowHa5FcH49XS94Cqlhkwrw9bRiyHfbgiQqxdIcJD4bfeR4j3MWm8cmT6KE5
	 aiz52QdcWN018DGdNp7mAx109V8U/fOyTbF4iNhv8R+6vmOKdXWbeQXXbp7sbf9DvH
	 duVPhuqVW3H/H1Ou2WqShYdFZ5X48GmYc5R5+WBfvyz5NS1W8KYfQIks1KMJudZP2u
	 HWTwpr9Ce/GLKEMw1Pn4k1RuOp/WCLVDYjexPF1tmXb4ygYliYP1RBx1/uJxpBjZEP
	 ifI9jQOXsw/EiexBpSpgSiIrXplCjEd/uOiE1X9k8zYu5tM92h1NAYNwdzdLWMBdAd
	 zq+mIJ3JcRKhfkIhZWo75NtQ9Fjzp7j1zKK9vMvYA3cmcdRon+H5sPcbR8iZ1NH78c
	 GCg+cVNUUQ39q82WPpBekp/obsZ7C7jCmG/zukSiOmN3B1Ao1PoSU5hGAYDjzOqPdk
	 6lNu36tsllDL0Gzhl/w9pCXfejhBdhR87Q0AoW3wyoeV2VqdXHg
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f46e:145:3ba4:8bd6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6AD612006F;
	Sun,  6 Jul 2025 16:30:13 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	redoste <redoste@redoste.xyz>
Subject: [PATCH] SubmittingPatches: allow non-real name contributions
Date: Sun,  6 Jul 2025 16:30:09 +0000
Message-ID: <20250706163009.335780-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our submission guidelines require people to use their real name, but
this is not always suitable for various reasons.

For people who are transgender or non-binary and are transitioning or
who think they might want to transition, it can be a major obstacle and
cause major discomfort to require the use of their real name.  This is
made worse by the fact that Git provides no way to change names built
into history, so the use of a deadname is forever.  Our code of conduct
states that we "pledge to act and interact in ways that contribute to an
open, welcoming, diverse, inclusive, and healthy community," and
changing this policy is one way we can improve things for contributors.

In addition, there are some developers who are so widely known
pseudonymously that they have a Wikipedia page with their handle and no
real name.  It would seem silly to reject patches from people who are
known and respected in their open-source community just because they
don't wish to share a real name.

There are also other good reasons why people might operate
pseudonymously: because they or their family members are well known and
they wish to protect their privacy, because of current or past
harassment or retaliation or fear of that happening in the future, or
because of concerns about unwanted attention from government officials
or other authority figures.  As much as possible, we want to welcome
contributions from anyone who is willing to participate positively in
our community without having them worry about their safety or privacy.

In all of these cases, we should allow people to proceed using a
preferred name or pseudonymously if, in their best judgment, that's the
right thing to do.  State that it is common to use a real name but
explicitly mention that contributors who are not comfortable doing so or
prefer to operate pseudonymously or under a preferred name can proceed
otherwise.  Use "some form of your real name" since some current
contributors use shortened forms of their name or use initials, which
have always been considered acceptable.

Retain the prohibition on anonymous contributions that the Linux kernel
has to ensure that we have some line of provenance to a known (if
pseudonymous) author who might be able to respond to questions about it.

This helps guide people who would be fine using their real name but have
misconfigured `user.name` thinking it is intended to be a username or is
used for authentication (despite our documentation to the contrary), but
also allows for a variety of circumstances where the contributor would
feel more comfortable not doing so.

Additionally, retain the section header ID for ease of linking across
versions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I don't claim that this is the best possible wording and I'm open to
changing it.   The term "known identity" comes from Linux, but if we
need to clarify using different language or otherwise change any part of
this up, we can do so.

 Documentation/SubmittingPatches | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 958e3cc3d5..a4f4ca0205 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -408,8 +408,11 @@ your patch differs from project to project, so it may be different
 from that of the project you are accustomed to.
 
 [[real-name]]
-Also notice that a real name is used in the `Signed-off-by` trailer. Please
-don't hide your real name.
+Please use a known identity in the `Signed-off-by` trailer, since we
+unfortunately cannot accept anonymous contributions. It is common to use some
+form of your real name. We realize that some contributors are not comfortable
+doing so or prefer to contribute under a pseudonym or preferred name and we can
+accept your patch either way.
 
 [[commit-trailers]]
 If you like, you can put extra trailers at the end:
