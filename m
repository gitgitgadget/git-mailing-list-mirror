Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB401E9069
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604600; cv=none; b=eqOtg1EYVelTinhuQbpchlZ+8YIkia+3Fzpq5RHO9/CIVS4I7Y/4LkE1vWXzuy4ia1gt3b6YB6kr/d3oOIrD+Yv9bZOc7bJZc320iXfncomzahW8ae8SnegYF1/tq3kELHEVv28EnodwHq7/By25XTEFvRosTJBRHkb/TdegyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604600; c=relaxed/simple;
	bh=A6RvymvX1A1TXa6m4bLhK0vIlclZi8ntV/v14mWLupY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S48YiMh5iTnCowbXdMdykBhJ+nJjy64V4sG5ktbBoh+bQaUKI6bJFOTKs5BibTmelogbQNnVYW+ySGIyZAFKl8qMVD758AsCcoAop/amMEH3oUjQuE73niT15x0icO4jRvWk/G99AnEFYQRroIs2m6tGnEE/UBeNeUFeiiLV7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rbL17OQA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rbL17OQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=A6RvymvX1A1TXa6m4bLhK0vIlclZi8ntV/v14mWLupY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=rbL17OQAzHrWneju9sfrfKHVZM+4cw3ZylJWO5H5KVq3hVvIZEVL4Jaa9dDpvMEXz
	 2VM7z7cYixH5sqrcMKZJxISdczE+BDMeJZz5J2UiACSV1tAC6FMqUiqM4NoWOIs7ed
	 AFc2Oy5sM0rVAu/ejfpjGJtkDsGi2JbAFGHrFcvzCMFvPakpl+VU7gg3dDCr0o35Fz
	 2muh3S7wd3cCTS6RHFK5nkHThOXfYRlR1sj0N/ImACo2xhi7bvbuzlleCHOWf2kjHn
	 1CMYlySEYvmE62dOMcyLR5+4bSIGB0eAMTuAs5lewTYiZwdc3A90Ebs9gxgcO8SvQN
	 PLgiWjaciYHoKwGVjsrpQ38QMu8/eOeZZ6dFdkm0XlrByYFm5DS/1L22W0pamvaa5F
	 lNbkiSPF4cHhgxsq7XW0nMa02kt6PYRhLGqPgPoeg1ZKUCdaEl8uY4LbrhNlDC4O2Q
	 R7n6eKH6jVMkOX0UxhDHVMJc8aV1jYj7tgzkbA5kT0IpiQuBQ2p
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7AA8D200C2;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 12/13] INSTALL: require Perl 5.26.0
Date: Thu, 10 Oct 2024 23:56:20 +0000
Message-ID: <20241010235621.738239-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our platform support policy states that we require "versions of
dependencies which are generally accepted as stable and supportable,
e.g., in line with the version used by other long-term-support
distributions".  Of Debian, Ubuntu, RHEL, and SLES, the four most common
distributions that provide LTS versions, the version with mainstream
long-term security support with the oldest Perl is 5.26.0 in SLES 15.6.

This is a major upgrade, since Perl 5.8.1, according to the Perl
documentation, was released in September of 2003.  It brings a lot of
new features that we can choose to use, such as s///r to return the
modified string, the postderef functionality, and subroutine signatures,
although the latter was still considered experimental until 5.36.

Update the INSTALL file to reflect our new dependency requirement.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 INSTALL | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 6e0321ff0e..54d7528f9e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -119,7 +119,7 @@ Issues of note:
 	- A POSIX-compliant shell is required to run some scripts needed
 	  for everyday use (e.g. "bisect", "request-pull").
 
-	- "Perl" version 5.8.1 or later is needed to use some of the
+	- "Perl" version 5.26.0 or later is needed to use some of the
 	  features (e.g. sending patches using "git send-email",
 	  interacting with svn repositories with "git svn").  If you can
 	  live without these, use NO_PERL.  Note that recent releases of
