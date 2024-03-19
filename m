Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589D39851
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873426; cv=none; b=TPbiB3YsZAEPT3dDBikmwqLLkty/eqsUYm3Yk5PONAMdWePHU0dF3GZeX9o3yKwrNDyWcuLNEmHN9BYUORO0AvEuxIgb+vm84RMkxIokd8K5W8IDpHeO0K36aCTCzDMWFkaPHRbeMTTDHRQw8+otI4KPY/pCf2TedCWuw46GiR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873426; c=relaxed/simple;
	bh=CvYZP08pp7iX6MoRF1DvRrtRZ2ygkfRhZ3MddLPvpGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leXVfddon7suk7JGA6Ba6DGdVsr3gIo6Rwpb1Sz+Lgu9x3ZzVarOlvDq9L0SYTFBvDIPWgMNOv6oNm+WAl50zb1gw3E3ibRu/TL0wKMLKh1dqQhQu44hCiM5ifTwkx2yPm0leSuZk0hhkRYLRW3GCmtP8PxSarJZx7q4qwiIMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=nAjUPLFg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMxkJt4l; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="nAjUPLFg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMxkJt4l"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id B5E7218000F5;
	Tue, 19 Mar 2024 14:37:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 19 Mar 2024 14:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1710873422; x=1710959822; bh=o8/07PNSFS3lUY5D2D3ZdzcJL6QZzjEg
	GUT3AB97b14=; b=nAjUPLFgsPEkL2GqoT873ExxHI8njE10qzHU03XeMbLivhkn
	h4lrqNXwVMpRTf+cd0jK4frkH8yD1CCWYadQ9q5HVNPvz3BAXFIZB7C+ZqnPFicC
	l9npVbuz2VEli4MvprAAC2xJO1vWby3wCW38nISmZ6NiZmKX0yb7X1RFvMb0RZ5y
	3b0aD9VkDrlJOymQ6C01TLBPwz0++kOBHx1E+ykDNHGlz+mmHhhrZVIiGs3YnPJk
	QbnO756qjRhEdOdwk9cYWyPcLvB9kWJw+b+0pBFwoV6E4ohZuJXesTokn5bWPAl8
	e37d5+nUzNSCk1Ax7MR6teAw4dQwOohJ/+Auxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710873422; x=
	1710959822; bh=o8/07PNSFS3lUY5D2D3ZdzcJL6QZzjEgGUT3AB97b14=; b=M
	MxkJt4lxWjuRb1faQn68ZwgsRvTO7Vh29GZcgmVPZC8qFVJAnJ+o2dBkw8+fnjeY
	GG3nXVmTu5/h85Ltxio62UbLCtaAy5Xga43CIdLhrToq5+ZyOAdcLwdZmX2oImma
	M4/ozNHXdvcoO1jBnF3GJeWZmP74i1jLCcg1K+1vsnWD9MCW9obNLF3YLPvRs8pJ
	9XAOPEekEo9BE8zbShxiEY68vcPBmTRf3tpUc1pWr9mjJP9Fl/d9SeiK1lg3x6es
	Wz4Zfo0x/P4tUYIiNc0ieHvItzRIXM6SGzDHAbq8P3c2WQCvOlR7quHCUpg6Uzk6
	uWRfw4+d32nU6ElWYyKYw==
X-ME-Sender: <xms:Ttv5Zd4Lasb5mIp1si3on4P63_1RIPtWcHyMUV0GAlZjulVEJGDLwiE>
    <xme:Ttv5Za6dbn7zGPb7vrCEjpFiklW4AluCRtWOgMMl_FEDkva13F7LyC4AH6wJHPuZ0
    8melyXhmfUd02Fx1g>
X-ME-Received: <xmr:Ttv5ZUfPi257cMvQuqE8_naDU_gCA4zEscWJ6HN95VYieZGqqLFuA2H_LCYvzEsNOlKW_b-G83cx30aljhqJzNebPqHZsnCCKvTaFM4J2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueeiue
    ffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Ttv5ZWJ3GJre8R7YKQ2Fz0zamSUxl2AxTnKf-1wn8T24MOsH-7srBA>
    <xmx:Ttv5ZRKlSN49R_IxIHOia_bDh4GjW4mkJGavSalU5cdbLr4a-HXvlA>
    <xmx:Ttv5ZfwQuzL0OQm46ERZfF3FEKWcuUzzpvYX-IeWHwKqFMo6bpgmzQ>
    <xmx:Ttv5ZdI01k1bUhaPUsBXqS-9CWrrBW7ScJFJIyQokCoFr0JGcJjwrw>
    <xmx:Ttv5ZeHLtnjvMkaSLu5pDJdc7yiQLrc7B4Mn2vb0M6YhJsLKsH9RRXIRA0U>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 14:37:00 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] revision: add a per-email field to rev-info
Date: Tue, 19 Mar 2024 19:35:36 +0100
Message-ID: <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.144.g29ae9861142
In-Reply-To: <cover.1710873210.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name> <cover.1710873210.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 9a7102b708e4afe78447e48e4baf5b6d66ca50d1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add `pe_header` to `rev_info` to store per-email headers.

The next commit will add an option to `format-patch` which will allow
the user to store headers per-email; a complement to options like
`--add-header`.

To make this possible we need a new field to store these headers. We
also need to take ownership of `extra_headers_p` in
`log_write_email_headers`; facilitate this by removing constness from
the relevant pointers.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Replaces “log-tree: take ownership of pointer”
      • Link: https://lore.kernel.org/git/3b12a8cf393b6d8f0877fd7d87173c565d7d5a90.1709841147.git.code@khaugsbakk.name/
    • More preliminary work
      • Link: https://lore.kernel.org/git/20240313065454.GB125150@coredump.intra.peff.net/

 log-tree.c | 21 +++++++++++----------
 log-tree.h |  2 +-
 pretty.h   |  2 +-
 revision.h |  4 +++-
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index e5438b029d9..f6cdde6e8f3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -470,16 +470,21 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 }
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
+			     char **extra_headers_p,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart)
 {
-	const char *extra_headers = opt->extra_headers;
+	struct strbuf headers = STRBUF_INIT;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      null_oid() : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 
+	if (opt->extra_headers)
+		strbuf_addstr(&headers, opt->extra_headers);
+	if (opt->pe_headers)
+		strbuf_addstr(&headers, opt->pe_headers);
+
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
@@ -496,16 +501,13 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary && maybe_multipart) {
-		static struct strbuf subject_buffer = STRBUF_INIT;
 		static struct strbuf buffer = STRBUF_INIT;
 		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
 
-		strbuf_reset(&subject_buffer);
 		strbuf_reset(&buffer);
 
-		strbuf_addf(&subject_buffer,
-			 "%s"
+		strbuf_addf(&headers,
 			 "MIME-Version: 1.0\n"
 			 "Content-Type: multipart/mixed;"
 			 " boundary=\"%s%s\"\n"
@@ -516,10 +518,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 "Content-Type: text/plain; "
 			 "charset=UTF-8; format=fixed\n"
 			 "Content-Transfer-Encoding: 8bit\n\n",
-			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
-		extra_headers = subject_buffer.buf;
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
@@ -539,7 +539,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer.buf;
 		strbuf_release(&filename);
 	}
-	*extra_headers_p = extra_headers;
+	*extra_headers_p = headers.len ? strbuf_detach(&headers, NULL) : NULL;
 }
 
 static void show_sig_lines(struct rev_info *opt, int status, const char *bol)
@@ -678,7 +678,7 @@ void show_log(struct rev_info *opt)
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
-	const char *extra_headers = opt->extra_headers;
+	char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
@@ -857,6 +857,7 @@ void show_log(struct rev_info *opt)
 
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
+	free(ctx.after_subject);
 
 	if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
 		struct diff_queue_struct dq;
diff --git a/log-tree.h b/log-tree.h
index 41c776fea52..94978e2c838 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -29,7 +29,7 @@ void format_decorations(struct strbuf *sb, const struct commit *commit,
 			int use_color, const struct decoration_options *opts);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
+			     char **extra_headers_p,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart);
 void load_ref_decorations(struct decoration_filter *filter, int flags);
diff --git a/pretty.h b/pretty.h
index 421209e9ec2..bdce3191875 100644
--- a/pretty.h
+++ b/pretty.h
@@ -35,7 +35,7 @@ struct pretty_print_context {
 	 */
 	enum cmit_fmt fmt;
 	int abbrev;
-	const char *after_subject;
+	char *after_subject;
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
diff --git a/revision.h b/revision.h
index 94c43138bc3..95e92397a7a 100644
--- a/revision.h
+++ b/revision.h
@@ -290,7 +290,9 @@ struct rev_info {
 	struct ident_split from_ident;
 	struct string_list *ref_message_ids;
 	int		add_signoff;
-	const char	*extra_headers;
+	char		*extra_headers;
+	/* per-email headers */
+	char		*pe_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		patch_name_max;
-- 
2.44.0.144.g29ae9861142

