Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088853;
	b=11/0T/2Wa6+UE9O8HETZyU9F2F0aG+xbTtTBAte2hMvK6tQ5nlTxGCGfWuOixDW2YJXh
	 NYTHQLtXkdNfQsQXyp7qaiV8L9IxRzOTgilzURaKiTJ1pesTf4Y5s9eO0B25fprtcmbCv
	 Sbw8mIYLpjdghJwMd98x7uEIxCblZvBdXv9bztdHWMKdjcsLAxoKhXlASgOTtcfIpPjPy
	 Vk1K+xHYWFcuuFT/t2FpOAg8iwr3tgjTyW7OGkMFl/PNtNs5H4GPGm/iu8OnrPqFdiGKl
	 wYsN4msuDXkkLOq9OkLNcLAoqfjk4eMId2XhnE9l2jyn/ATiXeiM0EFHl4aoBm9hoLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088853;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=gQABymq1PDelwSqQ8mpg2JnxSlY5A+eXq24zwbOK+7Y=;
	b=acCqTZ1WHFGvZGWQL/JiEGULCMAoGKZo7ncq+BCZP1iNqRAFTYRbCYxLn9z2alXXAhU6
	 ZrA4Q6WGmRSwzEah662uktK1GT6up8FF1VExMUuHqtSljWQyC9y/Fl8xni63GbJghJdiD
	 Os32m43LChdAgDNIleLWwNqq8zxs5vuugBoXFquFhzTpzTT8hPxY7xwiswBf7VX84d+Ko
	 bmGDVXGiEjVG8ovbJT2v+9i4qYSEFOAIdGIGCmdr1KDIvQemwauj2KBaew4vSYqB/R2BX
	 tQn/0TxdvWEkw4SAASELaMyvzgWl9BSn45bZBnjEJ1s18o62JWsX8D949PElpXIY/TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ohVzJAEt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a+z0UGgb;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76060A3829
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE76060A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ohVzJAEt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a+z0UGgb
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FC1D14001C8
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 06:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088851;
	 x=1795175251; bh=gQABymq1PDelwSqQ8mpg2JnxSlY5A+eXq24zwbOK+7Y=; b=
	ohVzJAEtSyRvzq01FQbL4zqrX8o2OGQRI21yv6ijS7hSony4GSOSuH6I/jjLOM5r
	rhSHzDN97oh9Xlp7x4EQnocsYL9Fg1SPoqRfF0q+83Bx7re89CoCIg52YlAz86xt
	U1X9z0Q1B2GivyseLNoxHUZiuA95jmvRUpCKUDgGJvfHHuF+yurkenfaJuzJC0J8
	f9a9dgs9NNKixO/sdXTtxqthVQXgbffd65AF56JbPA9m8hJOt079aL4QDCFmid/v
	r1wvMdPFD5FOFKs8pMRnQi+O+N4AawdElX6r2hIaDna2KePZYeeVm6i3+6GwCHJI
	Jje2srlu1qfUCIAckB0usg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088851; x=
	1795175251; bh=gQABymq1PDelwSqQ8mpg2JnxSlY5A+eXq24zwbOK+7Y=; b=a
	+z0UGgbyCF5S55XosSmHjpXmObPjQVMSqNyqYUw8Vpq1llj6DJGXakzRbOrifKXC
	/bhPJdqmYI4JtGZKOyRlmUYSzqiLGewOLer5EmDsGw2nwwh73YNLF9bPrgrNwnKz
	ytxfP9ramJn6xr3EqVHDxkarZnoB34QOtUX5hexMLZn7/llVAx2O/IIxWWqzo4iz
	qhRd5CWrFtp6w3xJNRsdkzXpz/tiAyKeTGDaDFak1vd09QGkqqLxI8obBwraDlxu
	dU+88QdIalyIsLk0K81RY9ub53M6jFiMTPGbTyV3JM7+f1GE7Zer0AKz/p7oa91K
	4ctO0k9BHhj3+UqMKKkfg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088851; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:0cGaGhtdPPBN3kbEJefZWhApX2uLub5sFyuhkN/iK5gTff1
	BR2yjPL6uUaFCVSltDG2W9LiTojK7afezWJmYqmNjTuwDAy/GQSRmbDF99tdiBbd
	L7t09hfe1IRqy9iwXXTOGbjJ3EZSdwjB5wsjhHSExyT9Uz6HqXVJsqBH0WktqMLv
	74sxMgxshpLiXTiQjKGqtwo0XlHTlJI6WDieNcIDUebOdDBRVY6qzYCuy1ahtFeJ
	BnXEsugb0GWMaSd4RZeV2stzApcCGTVlKsBLbbaOWrd2SSKhTZCvlMJxk1/oS/Pl
	EqLmUexmIUvJ1EIOyaW2fQjZ1u+z4zTvm/KtaRA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:emBkahQp3rJbntalNiQx5RKjd9zW9boiRmIIzUBLYiU=:qNvdG/mF9z+fsTW3q1JnvOOQ8LPNd9IixVvgt7f5g/E=;
X-ME-Sender: <xms:0-H-apcgLe-7kWTXkIB4XXM3nHcm2ZbKRMJjZpwpec93J8YTQM4vEQ>
    <xme:0-H-auNK4cFmg2Kb14ZuHhphQTfj7gOiVRhmXGY3bCKS31_2IhJwpF9UmMxUOtUmK
    NmViuLjJjUUMUR2cqn0lMQmrkdP3f9W1paicJcWcc3DyU0ryL2kPsY>
X-ME-Received: <xmr:0-H-anjiYkf8ffQslq5LjczO1O1GthI68uN7dpH9I5W5o9OBiARJmhrPVZ3mo_o9xAoOhrY>
X-ME-Proxy-Cause: dmFkZTGI8Ax+S5Me/90verxaIn26rbOdrgBU+Z55rUVHa2b94Uw9RFz5Wwhmi7v5FyLB5w
    6CHi7eXpcybp/lMu+8oIvVaGsAG8FArC//0h3DUnt51RCcTAyw6geuQb2O0CLwNQiDqTkN
    4XNJOBsfHpNr3iXTWWDaOnMpPdw+FjaMvgx20Vw07k2LpW1RKCl7llTSsg2R6N56E6dioE
    nCUNXLemFL7+F+fQt0wGtivP4IOCMI+AhDKX/Ku8nuNpH08fcCqlj3oDJUcg4Uk+6ly+Hg
    V51mzZENE93LXXI6tKTalM7QAOYM9/CpD34P77bNggn03kN97mLPQYLRXFC/FwL0RV4zTa
    +AGcYsF9wLvIt3/y3+zooEFJQ1SwiEgAOuNrzRHvoVSQ/Mxhc55Jy8lCXRRQRvdJI6dcTI
    eE2vFVCAl0clRd8VDQN57tOTwbhO0jYSkJfZ/nGY4eY247TEAl4WczpzBVECpppt9qTYiU
    AhwOxjZmrUIYv3kjTdBz7pwiPXPIMuIsxAt3DxAeDHUF+kTK41VQmldXrSKrNdsccA5Wop
    Anr1JMsCpaJv3UfJAQ+lbUlzFA0Xz0t7KFW3DtsWn37ScS25u57LyuiWw1aQDqdD4e0c53
    u6qx6+g6On4yM/jGUwQOC3XP6Kyzdd39FazRbA7wLVIxOPFTkWsCn4QCM8sg
X-ME-Proxy: <xmx:0-H-ah1LUuxQCTvgfQumpYfr8PP5M1EzXS8cGSwRr53eYfupbYx9fw>
    <xmx:0-H-ahg_g6Bm7BFwemNRKVI4xZQUHDK2JEnbD7cROdjvgZMvn3fUnw>
    <xmx:0-H-ahe7R4ucYW8iiBC-a5kXb0cG51Uq58LOBUAS_6YQutwK2LwM-Q>
    <xmx:0-H-aklmwLKlaYLu4Or_Qa8kO8fyM89oPgnKvI759ddez27LQKw3MQ>
    <xmx:0-H-arDOFEjAzQIyiOc_B9mZEa04cr_YszKYO8-X1Y6MWafc9tXmqaU6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6fe957d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:06 +0100
Subject: [PATCH v5 05/13] builtin/rerere: turn "forget" into a proper
 subcommand
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-pks-rerere-subcommands-v5-5-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The git-rerere(1) command has its own, home-grown implementation of
subcommands. Of course this implementation is inconsistent with how
subcommands typically work:

  - Options from other subcommands apply to each other.

  - We don't have proper usage strings.

  - Running `git rerere <subcmd> -h` doesn't print the options that are
    supported by that subcommand, but instead it just prints the help of
    git-rerere(1) itself.

A subsequent commit will thus introduce proper subcommands as supported
by our parse-options subsystem. Refactor the "forget" subcommand to use
parse-options as a preparatory step. The other commands will follow in
subsequent commits until all of them have been converted, and then we
switch over to `OPT_SUBCOMMAND()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 405276cc94b..5d2ae154ff8 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,28 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_forget(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct pathspec pathspec;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (!argc)
+		warning(_("'git rerere forget' without paths is deprecated"));
+	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
+
+	ret = rerere_forget(repo, &pathspec);
+
+	clear_pathspec(&pathspec);
+	return ret;
+}
+
 int cmd_rerere(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -83,20 +105,8 @@ int cmd_rerere(int argc,
 	if (argc < 1)
 		return rerere(repo, flags);
 
-	if (!strcmp(argv[0], "forget")) {
-		struct pathspec pathspec;
-		int ret;
-
-		if (argc < 2)
-			warning(_("'git rerere forget' without paths is deprecated"));
-		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
-			       prefix, argv + 1);
-
-		ret = rerere_forget(repo, &pathspec);
-
-		clear_pathspec(&pathspec);
-		return ret;
-	}
+	if (!strcmp(argv[0], "forget"))
+		return cmd_rerere_forget(argc, argv, prefix, repo);
 
 	if (!strcmp(argv[0], "clear")) {
 		rerere_clear(repo, &merge_rr);

-- 
2.56.1.831.g720f3f5937.dirty

