Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC113AE191
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808865; cv=none; b=IXmCN8El/Ia9enjy0ZNvizKiH9n7PayblCTxlXNriJIEKyP2tZd0v6z5nvSygaoKwdt7yqI2tV3V88Ux/f/r9UaRMqnZ0DPtmthDngoizKel3nkiV6aP/Ll6Jwq6PxN0FZDG5Kpd6+qfOhgbskU+TAGN1aSYGGl5bhWhxu8LzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808865; c=relaxed/simple;
	bh=e9/pDhsBPR6roca5zOiKPly3MJHW4xQqnN6/sxeU5RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jArNbj/67MsCs5ohzw/jJa7Vxlpl+j10+tVYSTzyhqUzTO8785GAZlfZJ3EAU/exaoAMwoZ01LiWYFbBqKNmpZnN0ihTUUfZx2o6ysqCpvgasu4abs69Kakh0Yt0gacQtko2hsK/ay/Qm67yxl+6Gc7lj0V3XXqS590ny+Jp2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeWoeczR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeWoeczR"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c4a93841so2593102f8f.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808862; x=1773413662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ZGuTCyrM9zn/NNtiqQlWS+D+eIdpSuVwmAG/TytrdY=;
        b=VeWoeczR2DR4AL+RX3KKQ9Judv/w5cBn1PKaaOiwWG2UDsNer6i0EJgBsb+tfUvbTV
         i1l/vc7k+ZaR4Damdo3NMydNSMbhOBEprVpl4p8BeuB1oRqsbMS9k7WWVBARX8ZHgoTw
         opVIw5QpgMfzBR01XRKt/Is36e4wLYjmjU3wsCtBnSWPWO7bEO1UmuTkea90oUwh9qb6
         qzXAqyyOXM8Q00y+UtJddPth2FeIrNBiWsw+Q2eXs9FzLMktIX5M3s2GnweIgTv2DPFW
         /EZOo4YGMvNY+mv3+1OIwtiaJ2IJ679RGltKxiruFF6DvYUnEguWp5K0CG4rxJFP5c78
         fyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808862; x=1773413662;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZGuTCyrM9zn/NNtiqQlWS+D+eIdpSuVwmAG/TytrdY=;
        b=iodRuAUVOauxjelpT/tDgSO+Bu15q7ACugsydc2SPfQ+OmaQxCpVPEHQd/np5lcxy2
         Trkyg5QAQ35K44WvUfPbR1W0HVUP/FVygjbFpDdWeUKgRfk6j8sGOVfAxusfYOZXH+jU
         zHcWl6cNzCDocnhS1/bo1WSt9zrdQ38yq6Er3HK4nnab9wUu7NcYysJ462ioEuen/Jqm
         K31U/7tt+2V3iRdhLMn16okPfRvbScgX2/+lFHKY7SUqTctRDK6xl6yzmlZU1I+EpKDq
         fnwsDMQ5VtSfCCTnoH+XeRxmJHfIA/w3YHZK4zatsow4x7fYkleZ5JKixSt1wHHelzlt
         cavA==
X-Gm-Message-State: AOJu0YyuILINwf1hfM11MeX17UmhrWe3NfYUBKE/TbXxmO8kS78MG+0w
	r17ZwMRr6a34V7Dcvw3//vfBUszDno5I8pNLS8TqvCssNWUpYU0UaO25SRaeMQ==
X-Gm-Gg: ATEYQzwsXyfEV89ILBj+/Hc22Wg58r7ygXk5APt1El1wzJsq9EZMkYqdQRCEsbuELaN
	qUfpO41FO2xI4qBPvH+Qx0ecUIxsak4xrxvjBCSdAAmWY/0hhk8Si7mUXhYZEEWg0SF+lC6IpR7
	Y0e1tKRBe67d+etqwC6LSDNEYIIQWMe0NRyFDDoSWPx/AyKY8/GLt/Rfq66bTuqJISY0nuoeIz1
	VVeth7aB3FatKWU11y9AIzFCP8m5GnxnAYA/ma9DuvAum5CYYiwpPEwcV/QHlpfsFbQ2PogVNbN
	DCLAxeRZPCYB/yRZ7mEWdIn5E3M3GrXqN5yKUUv9OwHMFlk60wRYyf6bwebf2S61Ymmu3xApqoe
	MPgs324Z3iw2QwPDqql5hCK+46GBJuHka7tcboat+OApfWxecVwC2KxEIfQBP0H29+6a6JgaVX5
	67/LWGNnJP2Fv+tn1Mu8k9bJGkTpw=
X-Received: by 2002:a5d:5c84:0:b0:439:b3ff:9ab9 with SMTP id ffacd0b85a97d-439da67c418mr4452789f8f.48.1772808861576;
        Fri, 06 Mar 2026 06:54:21 -0800 (PST)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4278563f8f.0.2026.03.06.06.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:54:21 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 5/6] commit, tag: parse --trailer with OPT_STRVEC
Date: Fri,  6 Mar 2026 14:53:31 +0000
Message-ID: <3c1fa9e85791953fd30176f6afaae80c2de8cef2.1772808594.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1772808594.git.phillip.wood@dunelm.org.uk>
References: <20260224070552.148591-1-me@linux.beauty> <cover.1772808594.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

Now that amend_file_with_trailers() expects raw trailer lines, do not
store argv-style "--trailer=<trailer>" strings in git commit and git
tag.

Parse --trailer using OPT_STRVEC so trailer_args contains only the
trailer value, and drop the temporary prefix stripping in
amend_file_with_trailers().

Signed-off-by: Li Chen <me@linux.beauty>
---
 builtin/commit.c |  3 ++-
 builtin/tag.c    |  4 ++--
 trailer.c        | 25 ++-----------------------
 trailer.h        |  4 ++--
 4 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eb9013995c9..3d25c1856ce 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1720,7 +1720,8 @@ int cmd_commit(int argc,
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_STRVEC(0, "trailer", &trailer_args, N_("trailer"),
+			   N_("add custom trailer(s)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/builtin/tag.c b/builtin/tag.c
index 68b581a9c26..e0f05f94fdb 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -499,8 +499,8 @@ int cmd_tag(int argc,
 		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
 			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),
-				  N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_STRVEC(0, "trailer", &trailer_args, N_("trailer"),
+			   N_("add custom trailer(s)")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/trailer.c b/trailer.c
index 5eab4fa549d..ca8abd18826 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1341,46 +1341,25 @@ int amend_file_with_trailers(const char *path,
 			     const struct strvec *trailer_args)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct strvec stripped_trailer_args = STRVEC_INIT;
 	int ret = 0;
-	size_t i;
 
 	if (!trailer_args)
 		BUG("amend_file_with_trailers called with NULL trailer_args");
 	if (!trailer_args->nr)
 		return 0;
 
-	for (i = 0; i < trailer_args->nr; i++) {
-		const char *txt = trailer_args->v[i];
-
-		/*
-		 * Historically amend_file_with_trailers() passed its arguments
-		 * to "git interpret-trailers", which expected argv entries in
-		 * "--trailer=<trailer>" form. Continue to accept those for
-		 * existing callers, but pass only the value portion to the
-		 * in-process implementation.
-		 */
-		skip_prefix(txt, "--trailer=", &txt);
-		if (!*txt) {
-			ret = error(_("empty --trailer argument"));
-			goto out;
-		}
-		strvec_push(&stripped_trailer_args, txt);
-	}
-
-	if (validate_trailer_args(&stripped_trailer_args)) {
+	if (validate_trailer_args(trailer_args)) {
 		ret = -1;
 		goto out;
 	}
 	if (strbuf_read_file(&buf, path, 0) < 0)
 		ret = error_errno(_("could not read '%s'"), path);
 	else
-		amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
+		amend_strbuf_with_trailers(&buf, trailer_args);
 
 	if (!ret)
 		ret = write_file_in_place(path, &buf);
 out:
-	strvec_clear(&stripped_trailer_args);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/trailer.h b/trailer.h
index 3c5d9a6e199..b49338858c4 100644
--- a/trailer.h
+++ b/trailer.h
@@ -209,8 +209,8 @@ int amend_strbuf_with_trailers(struct strbuf *buf,
 /*
  * Augment a file by appending trailers specified in trailer_args.
  *
- * Each element of trailer_args should be an argv-style --trailer=<trailer>
- * option (i.e., including the --trailer= prefix).
+ * Each element of trailer_args should be in the same format as the value
+ * accepted by --trailer=<trailer> (i.e., without the --trailer= prefix).
  *
  * Returns 0 on success or a non-zero error code on failure.
  */
-- 
2.52.0.362.g884e03848a9

