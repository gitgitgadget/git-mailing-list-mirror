Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399561;
	b=n65FWe4P0ywwPO99NXnPPqAVZOJyY9rm6WzDKoWg+8uJu5Y1yv/mFXkkgnFTDKmo/Crp
	 Y4NuzJKY8cWwWg0n1vbLNFWHqEN6y1Uat46jrRI59iJaKOvVu8PR2ymQrHRD2R7sUFMGO
	 MzU7v0aZtj3EvLOsPjCQGUR2KERpFqX2kYal0Ug/GWVKZpEkzhUf0AV/K8wW82Bc65oWi
	 JscR8wDHyr11mt7s2CRn4nOnpF/X0X3UXZyLETA/aLnYpvQWf+QmTKTdpH5hq6bTS+TVw
	 7vjnjAv2p9tNtDwRQioImqvBhBF0JVepdWVQGuuB/rmV24qq3egHTkRIUafsKN1X14g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399561;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=fbH1UsCWrEGycWveFGROwsiYO85Aam1H2TI5SqomjCo=;
	b=k4QsCeuFVd/XuuFww5HR3xQ1LCmJ2/54oU5AROyIzfL+QwuuFIeUbsQSB6ptFqQVwjgd
	 jA2Z3ltF/qFRDyK6aNsMPdVjWWSh75J0XxzXYruK2c24FEeiI0U0kRDdoAyrQW7P8H0A8
	 bGZQ6QzydJaF3OIBsR3qRArm7TIiFnymkwv3eFnpUVkyuaCQAcBtbU9IdV4zE5uWjkDyt
	 34SFM7oGNeTiFPfOLTij5zhy0Ssjmsu7SVjSHts04Zc/X5y+UzZaC2VUDkNOh6IRWWK++
	 jJPVyj09KBfy17xhnWU8qTK+l80u078SbMJNLvIrT1CfLQrwhNGjhzXQop23+j11pZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=cKzEm4ii;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZQhgxwwI;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037560A260B
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B037560A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=cKzEm4ii;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZQhgxwwI
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03FCF7A02DF
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 07:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399559;
	 x=1794485959; bh=fbH1UsCWrEGycWveFGROwsiYO85Aam1H2TI5SqomjCo=; b=
	cKzEm4iib46RXw2yRkDoEKommWoOcKVXWWJMeNmhA+CKYGa9m7c6fiNJVwETiRp9
	vAGamjBT0SQ8k7j96DLTw6eQ41MHBUa07WWc/vpeM7WzPwY0vCcYLLyXIbY7PUDw
	QWv8En9vocCYBDcCAYqXjbmTbF9RzNB8rW/Bi/4yo7bMOHnH4CUIaW2VY5afi5uQ
	+uhFfzga4I9k3SWjkX0vKt0zO0Un+qyTPy38Nj3zvnoKNX49ScQYerQQ1utYTiz+
	c44IFCfQX2lvZdIRPAIcr4YbRtlP0JLRI9/29zjJzierXSAAR3oOZWJUqy/SMAyy
	Qk9fDrbl/TQ+P9NI0V4ZdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399559; x=
	1794485959; bh=fbH1UsCWrEGycWveFGROwsiYO85Aam1H2TI5SqomjCo=; b=Z
	QhgxwwIAq/44DqCnN38t8EUFJUYn0vhbZSQqguYClAHuGxKlIfqe++QhTwd++BdF
	N4zhk09JornCQ+sSvlKJYlPivWcls8faaDVoI4EV89OsuV3B7MnSRKQkFA220Ewc
	FTzcaSeRXJF0aBQM42N6nFibI4uvGMHJeKTe0/WoqimIS0qFawShINLlcajzIhpJ
	h1QRj6dAFw/hl89jUWu7/LcjjdYQlHbsbruA3DRWhs0BbVoX0qexynTVmkzOtmz/
	HEzgP5lbRvDSLMcPmqt1weF0seDP2ChV5WnYLnI/7TSqqa2G720gsOSe/5DVNUW8
	QMwoRCtfFF7dld8zSPaAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399559; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:K3IcRsrJHAKXHl9LGTHfMFo2akIH9pUIuT3WnCZ0luf2ZaW
	fx83lcgyezmsDVJlHApgjtoBn46p9R6zoP3p/f0A7THDKU3Dc9YWxACOvzqQDvTE
	ndZGMDQ07F8sl/MTYIUA3LkiNNYQB/kM4gLI8+U9qJeB8zIpxB2jIDLK0rhPS90x
	F2g+/aIVGB488lkT9QLQ8BDj6oZe+HhV0alDtJDD1CXhy6mmato6Pe6Vr5hpfPlx
	lmcguVl9FBO6+J5y5r4IkINfbnaFZiIM59U6S5m3cyp919ArpsnGIaZQhLfE7pYE
	nUQ9ykAcjiKxnWnCQFbng4y7ySC7VJoMqR1DakA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+D5r3tn2E+9ogdZj/vDkxMpJCci/rllKzYX3+g4t3Qg=:yX47SQPKphvWB4YcYHw42jCOJmY3EkEp2BSIHBxHqJA=;
X-ME-Sender: <xms:R130agjB4i3zMaiawaCwnVDK77IKmQxPD6NWsEdJT5tWbBLoIUYUSg>
    <xme:R130agAhiIlOCZMYVEiDS_hcRxB4ctKq0lRQ9C8t5Q6st_KycLZLKajswkwIcNH2v
    3_U8smW3_QHas92fswm6oABN8hsbVqqtss3CFUcZCdGljWduDkHlmLY>
X-ME-Received: <xmr:R130atEahrYn6EXRZrIHv2dyB7arHscXc1TbdqbQG8e8TqCxgoCcDqVqehA8P-f_irPzug>
X-ME-Proxy-Cause: dmFkZTFRIa8kAjDW89sEfVRnDekK2zx//+bdamBHYuEVMnrtwcc/TLPGMTroUYOrvv6zRh
    Mm/grCEpFXX8rqxmloU/LI3jgEotVTnm14TcTFxaM0ZoZuHg5RjsYO0DHsBFsMK+HA8CIy
    67f3pihWLXLzN3Xz5vpcJJnolXSs2pNxvqVwRAQys5kMLno7tCzJCsaAeCnZQODbydZ+A4
    xNBkq8JUfiUQtav5CsIs7M1S3V8LZ7nVBmIueTVU/KwRJc4G6uLLPyPV/qtBnoepjIVM0B
    BAS+0CmHkQOZ15HZuVKOof0yh1fr6P2oYHB8x/uDbsYjj1aIiPjs1zIsHWhY0+EN1l98YJ
    eEtt14cb8MpRVHFRyKqlHARJN0vXv5j97jRQq+5cmRviRT8nwWAPrlz+nRiHZHWCOJQf7w
    6oz0VcZESftorl+leli96XtrweCL7lgtRSMs/ELhxMe1AdzwRxoyRh4IfgU5S36a+yd//i
    9UkWfftrV1z6CDjDji8nivY9oIirGlhA2jgko6D7kRGXDBC1a1eaTccZb3R5/VylufhYUt
    4MoTJwc5LMjhcfM6XtPfkRHSu7yWDJfYnwPMnWEpJerYYq7c8D8jhBDJqQiVubUXFNy2RH
    uf+Jm5gDCi49rkPmzqXir9yEUAX/2gKlJgsmuGthAhFAgt5ranSa+AAr97bQ
X-ME-Proxy: <xmx:R130agI__QL3EXklCH6UzqtJwNEal7d9wn8xYhNBAMA8dxgWwuJiQQ>
    <xmx:R130apnViEuxr-rYWuaQEqO-H-HJ0IZx-91QI6GhlchNii4IqQlU9w>
    <xmx:R130agS2zP7LC05y37TfLVnA-LwdcCgR1ONJW0C-ybv6-w2BOQ95Cg>
    <xmx:R130ajIrTDRcgFrCTYUZ6ZjX_T5a35BvulT0vReUIhKGRPm8OcdkBQ>
    <xmx:R130akmQV0zrcbL_6PFHhR9n1w34WTYjtUP9WSntf0DmbZs3k24pidSP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df49a14c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:47 +0100
Subject: [PATCH v4 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
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
Message-Id: <20261111-pks-rerere-subcommands-v4-11-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In git-rerere(1) we have our own custom logic to parse subcommands. In
preceding commits we have refactored all of those subcommands so that
they are ready to be used as `OPT_SUBCOMMAND()`s. Switch over to use
these so that we get rid of our custom subcommand parsing.

Unfortunately this means that we have a backwards-incompatible change
because we no longer accept the "--[no-]rerere-autoupdate" flag for all
subcommands. But this was arguably broken and misleading as we ignore
this flag for any other subcommand aynway. So we cheat a bit and simply
call it a bug that those flags were accepted in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 84 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 3162b074ec6..97c791e420b 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -5,6 +5,7 @@
 #include "rerere.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "pathspec.h"
@@ -152,6 +153,31 @@ static int cmd_rerere_gc(int argc,
 	return 0;
 }
 
+static int cmd_rerere_perform(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	int autoupdate = -1;
+	struct option options[] = {
+		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
+			N_("register clean resolutions in index"), 1),
+		OPT_END(),
+	};
+	enum rerere_flags flags = 0;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (autoupdate == 1)
+		flags = RERERE_AUTOUPDATE;
+	if (autoupdate == 0)
+		flags = RERERE_NOAUTOUPDATE;
+
+	return rerere(repo, flags);
+}
+
 static int cmd_rerere_remaining(int argc,
 				const char **argv,
 				const char *prefix,
@@ -211,41 +237,43 @@ int cmd_rerere(int argc,
 	       const char *prefix,
 	       struct repository *repo)
 {
-	int autoupdate = -1, flags = 0;
-
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
-			N_("register clean resolutions in index"), 1),
+		OPT_SUBCOMMAND("clear", &fn, cmd_rerere_clear),
+		OPT_SUBCOMMAND("diff", &fn, cmd_rerere_diff),
+		OPT_SUBCOMMAND("forget", &fn, cmd_rerere_forget),
+		OPT_SUBCOMMAND("gc", &fn, cmd_rerere_gc),
+		OPT_SUBCOMMAND("remaining", &fn, cmd_rerere_remaining),
+		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT);
-
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);
 	repo_config(repo, git_xmerge_config, NULL);
 
-	if (autoupdate == 1)
-		flags = RERERE_AUTOUPDATE;
-	if (autoupdate == 0)
-		flags = RERERE_NOAUTOUPDATE;
+	if (!fn) {
+		struct strvec args = STRVEC_INIT;
+		const char **args_copy;
+		int ret;
 
-	if (argc < 1)
-		return rerere(repo, flags);
-
-	if (!strcmp(argv[0], "forget"))
-		return cmd_rerere_forget(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "clear"))
-		return cmd_rerere_clear(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "gc"))
-		return cmd_rerere_gc(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "status"))
-		return cmd_rerere_status(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "remaining"))
-		return cmd_rerere_remaining(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "diff"))
-		return cmd_rerere_diff(argc, argv, prefix, repo);
-	else
-		usage_with_options(rerere_usage, options);
+		strvec_push(&args, "perform");
+		strvec_pushv(&args, argv);
 
-	return 0;
+		/*
+		 * We need to copy the array as it will be modified by
+		 * `parse_options()`, and if so we leak the strings
+		 * referenced by `args`.
+		 */
+		CALLOC_ARRAY(args_copy, args.nr);
+		COPY_ARRAY(args_copy, args.v, args.nr);
+
+		ret = cmd_rerere_perform(args.nr, args_copy, prefix, repo);
+
+		strvec_clear(&args);
+		free(args_copy);
+		return ret;
+	}
+
+	return fn(argc, argv, prefix, repo);
 }

-- 
2.56.0.611.g1030f0b940.dirty

