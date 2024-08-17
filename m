Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375B12FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883050; cv=none; b=lF7tBFctaf1OUKUyz4uGXoG5CBZWTxBOzkl8Fic2asa9A+t+39VFZlGMvNedqqaC3Anfk35VI3EIm61M6hVyb/60J1RH4fpk/s8twFDK7Qk+m2reexRiUdS2yg0LVkB5bKxjMeBRra1QyUZ9S9OO8MYZuuSY9YNteh7/sOAGEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883050; c=relaxed/simple;
	bh=FL3YHUWGca7oFH6xxI8+ggBTBdB49Oyfv/JipP8T3h4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0jlTfLjZsuH+ngHx9TZ32Ktkaj6ipVVVSkjsNW12/u+F2/RQosSFfYEuDV/HsQukpIZwL2k2YjR0Gi5WkbAEottbmdrxKmc26Dd4YHhVCE271RR6bY6zuYM/hq6a+XVPKT2V5hoIDG4QgNc+Y4dLKKaGULK+YF4BR/PswhKTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24720 invoked by uid 109); 17 Aug 2024 08:24:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:24:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27960 invoked by uid 111); 17 Aug 2024 08:24:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:24:11 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:24:06 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 09/15] reftable: drop obsolete test function declarations
Message-ID: <20240817082406.GI10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

These functions were moved to the unit test framework in ba9661b457 (t:
move reftable/record_test.c to the unit testing framework, 2024-07-02)
and b34116a30c (t: move reftable/basics_test.c to the unit testing
framework, 2024-05-29). The declarations in reftable-tests.h are
leftover cruft.

Signed-off-by: Jeff King <peff@peff.net>
---
OK, I lied in the cover letter, this one isn't just adding UNUSED. But
hopefully it is also obviously correct. ;)

 reftable/reftable-tests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 4b666810af..941e5dd011 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -9,9 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef REFTABLE_TESTS_H
 #define REFTABLE_TESTS_H
 
-int basics_test_main(int argc, const char **argv);
 int block_test_main(int argc, const char **argv);
-int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
 int reftable_dump_main(int argc, char *const *argv);
-- 
2.46.0.585.gd6679c16d8

