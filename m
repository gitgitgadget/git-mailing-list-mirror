Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098037;
	b=bvlmEFL++Z4FaKQ2To/hqVI59V+r8clg5yb3UvcRyClKRGpBpErA6JSOpOUqYbcFRAa4
	 Ods88WAwD8jYPdN31srN6K+fpDDFKU3P+L7qrKYe8XovRhpah8XNsH7KFUk/4fFDvz1ZG
	 g0vtZcXXBVkhl+RHpXbQdUGZXRQBYGEmW7ajcF4g5J/RtYiDH25CHmiObDz60WoQDEU3b
	 TmX4rvd+kkfT/Xq8JuCs8nbiC/dc9Qi8SVykAK77PmoZgrTGYvCanK9o9ASbdU+LdR74e
	 hyVrAKpUozzzxGpfKBP9hFzVAFzQv08DeGJEbeAOJEYIgE9g+aFhbS3YnFl8mtNI/yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098037;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=7kiI/t1uV1gVKeEMngiV1pNxBZZc2Nel5RZhGY8G0Es=;
	b=jOkaeRZXzWezfj5N/6ONzIdKV9c176yBUPLEt1bmfJGbKL/6vcTMiypfhzgotBsKMBzo
	 dTMTcarlQvtuypFj+C/pFP3Izynb6vGFFl1ahDpTGAgJhru5ZeRfAHI7Kb8+OGogaaXBW
	 xGR/X+GydoQ/Laswk1KhERPf1dQQBW/vdBX8eQArV/Ow2Z5Y4Oaz34w23/Z1mYtiRM6Zu
	 pVFl8ftVuTfxzJBAo+00eVg2Jj+6NldKGytP549XGFf+TvS/uTLP70nY2xc17XJLul43T
	 XZIq7AAqSaiGoC4+luOkRwU7S7O8Ra6hCOjd3BGzWlsWKX/V9tbQyo8FbJFfuyJu/HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oq7WybB6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E66anEYB;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C56606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C56606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oq7WybB6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E66anEYB
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3521D00139
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 06:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098036;
	 x=1793184436; bh=7kiI/t1uV1gVKeEMngiV1pNxBZZc2Nel5RZhGY8G0Es=; b=
	oq7WybB6PBoKrm9H6kw7PQ8q21Kq5RsWG8gTE/I9tVezVILkKvx1WgDtd3FA1oNp
	CESNk6+ZiscQqjHVjeXvAWmh4RZawBqtCREtupsqLES8ee2zxaDLJXuobwpjKXuX
	TuyARWYgcdVsixpSl9rXHu/PFt/p8MV+Mg0cP7hgATJ/hrfALwhgm9vikyb2Mx3n
	oiUmk1M+T79uc/4hojJpn7xSiB/zvnR3aLhMkY4gjJzQPyzfOosEtForLiQebxhl
	61sECMmJUgLCL/B10M/x3r3t6DjrjsxYuvgXVgDCKDhD+sucS9k7NfZfEDsAtplP
	qPJ8EXIbASm5vZjFPY8NUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098036; x=
	1793184436; bh=7kiI/t1uV1gVKeEMngiV1pNxBZZc2Nel5RZhGY8G0Es=; b=E
	66anEYBKf35Dyan7uTaRACY+ThE5+J1yDkxtQgLDqT7aGFGFiGDH3f1uSCeGQs/d
	yoa8V3IC7pSMUxvDSa3I9N+0wYDAslqrCXoVytXl8OkkAxUo2MmJFa60MwjcI/sO
	0CeRR7emxHaOW0geLpn2jVC62tmsE4IKLQae5/0nB9RGZ2y18lwlAN7xU7Ie0lrw
	kqzBYTiJbO5gC228HPCS4QvjCTCay0mSCEZFEdtpeFpJkeWDpmcLRUkiyeYKRFmv
	uzWhG7ddhf0hybRaxBPu1gy4pnKrQ/O7mlEJrVkk7oa5Ewh4AzKPctKbCwbatLwK
	8HnE3iuWCqQdRQpYwNmqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098036; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bqLgdu2LgcsZpSUtpbjgRRRTWR7GL6207RYOLvHM8CXkBGa
	2XyHpHBRRbt7OMfIHCFME/Pd1Aq1YcgVPAT5LsE59LWjaAgQ66hbggVsoDBzSelh
	D52K0TPqLR8OMcJTeZ0OWMZn8Xzs6GZzf1mYYT80/lTvYN+/sXgQu79l59HRc5q+
	t7nLoqfreRa2hlXyFSSnyZ0+zORGVt5LKPD1IS+DcuyIgt15DaOcyvY8huDLwuCo
	FX6HBItxhvUv+do8reUgj2RdKgXpAWTD8WgxazN1T47xZUWCAfzoht1tLolZpYnf
	USOv8k5VOjA0/7N37ArLVKF8IDlWAaTeOzEfzcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7LOux699vdDn0Ukyexr3QO2cBFgmnM+/cFQzdZ2SSDs=:3K2OgHG4EH8994n+PA4+MBy9vdgYWr+CSZK0m7Ggb78=;
X-ME-Sender: <xms:NIHgamhpR4B3Kn2LkbZ0Ae3jhRQIS5-z5UPvBi55WrxjB0I-SEMaEQ>
    <xme:NIHgat9lm8l5WErM9IzdD0EpQkvx5aqYralUAw8LYci02NN1q798Sy517bF3856LK
    IVvBwgej3x0XSJOagXk0oJnbUBSjC-m89QLRzu-Q3Kykq7_4naXtb8>
X-ME-Received: <xmr:NIHgajslZzxNu79TLkL8bdXgQJBqxxj0Y1jjzr9fTIY_OWdTa7PxnA>
X-ME-Proxy-Cause: dmFkZTFQAhMj+d0VRKgbWkhQwzvS4rn6woO60XWJgpMQw13+GFEJ7sBYn1M9REZbRMminc
    RV4HpjduuDdThTCjnqvWCotDxzb41XrrctGzW39RSaf3bCqRXQVyuBlJpA6NeQKCmf8Rcn
    YhvWf9p3ep+Rx4eE7VUYOyHZTFzVJD3BoV22KZdB1856Bsa6txC7gvZtr4r5EUiPFvuIQP
    v3xzl5KrEOx7einZ5pRDQDHnGKWM2TfCMzw1sxuo2PA8whmwT3udzd4Epz6l1Kg35uo/Gy
    F+NTFyuktJVVE1HRJX1RSJxl0p0jrURqk2jdSpsm3DvLx9EvAQgO5G2SJTmtA/kzNjBzE5
    02cRysmB8/k9/q1S4JjvvexdK4ErS0QxYtSiEasW74hJKBQt4k+ZFCTitqmKCp3iQCrxSt
    ndC8CGZI33KLANcA2EFnPKvPApYdaFwys1Om1Tc5eRoWM4AnqHJ45OI1A7w9b8TzIr/ve7
    DO6XKYXA8JG9GfJGw2/hXGYsc2b/wKnk/bdusLn5xlpOOwpuNdt4YrlfeojqY5tfgA0tPd
    tZQuGXYOIZ59Mu5F9KCakrpmiEkgA7aHswLtICMWzR0TP3GLUwvYGL/iosWRTwrXeHyWd+
    Umuj6UzmLlH1f/+MH6a/hpTFR2fYfu3adlebb69ekx/CRpSkY4mZqDhg/ooQ
X-ME-Proxy: <xmx:NIHgakZdN0gJZSqdkHAh6AU_kCbbaYdjzDQvgHr6Ujc9xVjNdqmHow>
    <xmx:NIHgajqQDM8kunwSRlCgM2EMAm2uIZc4WwAa_I3qiLXDyLqw8sy5TA>
    <xmx:NIHgap9xEHWc3zrPOInvXHGaxs5e_tEzZwJi_8gVajgU9uz5aodolQ>
    <xmx:NIHgai9EqE05FNOCFk7YIMhmSDYJxU-YJ5VtS3n4ON2hDMBmuVXAYA>
    <xmx:NIHgajiKdarVjLPkV4d_UY6ekbGKs0ev2_g6bMND92-XEo2913YZFo8y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a773dcbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:48 +0100
Subject: [PATCH 05/12] builtin/rerere: turn "forget" into a proper
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
Message-Id: <20261027-pks-rerere-subcommands-v1-5-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
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
index d65870779f3..0f55619bf62 100644
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
 		return rerere_record(repo, flags);
 
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
2.56.0.341.g393f52fd96.dirty

