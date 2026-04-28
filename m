Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCD37E319
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415251; cv=none; b=OJ3kv/sQ8iurA9Y3zvATtZMu+eFynjdJO3oj5DIiXbwTt/1YZrbV9LoaOIDzWEd+Sy678wrr+0Hjhxuj69jw+JwjpTTiYcXU9WtZEdRqzBNz3+KlhpobwTLQhVtv75CFPlHsFZTKirhu29RZMTNrbWXySvt9shI+jWeH5uXA1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415251; c=relaxed/simple;
	bh=duxuvR/ys3tBcF/PvF4+LQtGvYB1WTqULmk+psD1j6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe67hK+DN4uuqCpXtOVkeoCQWhVilwG1Jkge4JbktYFaIVMSD0x6iADQndnPnNweu3P0qwe80YzCwycmucdCfOXpygFm0dK7jkkT9yRMgQ+ulVZfuUpfTUQ83zhwr1eXV3AHpk+ChfMfdpyquRHPw8/ibFGn/pKMeKUaUc+WqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N+qKKpj1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNrHRuS8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N+qKKpj1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNrHRuS8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 566121D00178;
	Tue, 28 Apr 2026 18:27:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 28 Apr 2026 18:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777415245;
	 x=1777501645; bh=q9ed0cxLMHi5FjnqHyY749QEbbmSGPuPE7KAfly3flQ=; b=
	N+qKKpj1WysfZiQwtxhE+0ZW5S7h1nlFSNZmhfs6d6hhi9ouZUMEFozDYHlwPTfp
	WJ+RWzLtx9jZScvdM21viX5L7eFJYqn0U5rH2x+Np+4Co5MN5KG2w3VgbysFSAki
	XpMg6Hm21OSZ0b6myy120qPJ5Sd7iCqZ+gxCxz3V2miRaLGIqaREsUNgTitSn6CA
	4tld0tUNYaDFIiFHmh5XZdodXD6CQJO3Yj42vEitgG5Mz+a3L77fPcrOsyA67ssi
	mDSnER6ZAXz+mcnUbQn6YiaIAcik07UW1KgMNLYm+A03EQ9DZyFeMZrEVysDaZM6
	2DEMsw72ijkl9pHStCkrAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777415245; x=
	1777501645; bh=q9ed0cxLMHi5FjnqHyY749QEbbmSGPuPE7KAfly3flQ=; b=p
	NrHRuS8UeMtjtgO4vP8miub2VI8faS50roLokrEbvfezdWgrCN8+8G4yJU6C7hAX
	4VhLfZ33vyBGj4EYoVgTJV26wvI/G2XdokYAeqp04A3J4DOmo7Unv9KZJBTgFM6v
	2Uc7oDSAxMAMu/QaAM3+QRmRyVJcGcyBZdL7Iwh+LfRuIFd3+wKMLpbmnGyGAFuu
	6b42X9twmPfux1xx4XT7CIRVZM9pMX8Wl32YH3FPTAfcfLY++nWcw+Ua4ohEuICw
	M3HaImYo+nkAOgCM5FN4u+Z9LjodmPpnCm1jUiElnd0U3gUogNusiBy9TrkhT4XE
	XgCuBdVSidmzG7nHbtcuQ==
X-ME-Sender: <xms:TTTxae_erMN0_Scv4kpJNIB7uAoPtkOcx-LwFwq2SJuujkPXCs1XUo4>
    <xme:TTTxaWKdCxmZXcUPPCiVlpGGrFz3MD7fP3ht8l5ofvm3crC8kyulJY2YWKvdmjXcK
    tHX-d0l-X5CVzqIHwJREPQFnVvnpZpq7lyg0TjLbVsjr3a0rogy>
X-ME-Received: <xmr:TTTxaRYXLmApFYPlkc1oBfs1LJmPODHPcR_NG-GZN-uO4ZDrJvk0Y4-OpMMj3WhiyBShDyHDNJKr6FHYrx3fZEvbcDuuQWasCNAxCSgKv8B_TnDjhtpHktOU9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TTTxaQIccKGlJ40fH-_tlGHtwTppm5fCAaPN7aNeX-oVup9NU0eb4Q>
    <xmx:TTTxaXA0H26UAfxaDnKy1nxIe2TYNjMEBYMil5t21WbrbCTOAL6ztA>
    <xmx:TTTxadp0N24_fJmlp_nbDEeD5Pn8Fns04PIMFTT-6Gf0nYdQWKjnkQ>
    <xmx:TTTxaaimY_M8Gl9A2Q1q6VfHa2rC6cSOPFe_SiZdjhSS5EAhtgDcPQ>
    <xmx:TTTxaSIWPdSYDqLMGlKU5Dd4WA7bOEQ-iM-fwjtt_WqGaVa_QiJfgjXv>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 18:27:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com
Subject: [PATCH v3 3/5] name-rev: factor code for sharing with a new command
Date: Wed, 29 Apr 2026 00:25:54 +0200
Message-ID: <V3_name-rev_factor.66d@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V3_CV_format-rev.66a@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz> <V3_CV_format-rev.66a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We are about to introduce a new command git-format-rev(1) to this
file. Let’s factor some code so that we can share it with the new
command.

We want to be able to format commits found in freeform text, and
git-name-rev(1) already has a function for that but for symbolic
names. Let’s use a tagged union for the command-specific payload.

No functional changes.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/name-rev.c | 54 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6357eaa76d0..dc4136f4de3 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -272,6 +272,24 @@ struct name_ref_data {
 	struct string_list exclude_filters;
 };
 
+enum command_type {
+	NAME_REV = 1,
+};
+
+struct command {
+	enum command_type type;
+	union {
+		int name_only;
+	} u;
+};
+
+static void init_name_rev_command(struct command *cmd,
+				  int name_only)
+{
+	cmd->type = NAME_REV;
+	cmd->u.name_only = name_only;
+}
+
 static struct tip_table {
 	struct tip_table_entry {
 		struct object_id oid;
@@ -507,7 +525,7 @@ static char const * const name_rev_usage[] = {
 	NULL
 };
 
-static void name_rev_line(char *p, struct name_ref_data *data)
+static void name_rev_line(char *p, struct command *cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int counter = 0;
@@ -516,6 +534,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
+	start:
 		if (!ishex(*p)) {
 			counter = 0;
 		} else if (++counter == hexsz &&
@@ -524,25 +543,32 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			const char *name = NULL;
 			char c = *(p + 1);
 			int p_len = p - p_start + 1;
+			struct object *o = NULL;
+			int oid_ret = 1;
 
 			counter = 0;
 
 			*(p + 1) = 0;
-			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
-				struct object *o =
-					lookup_object(the_repository, &oid);
+			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);
+
+			switch (cmd->type) {
+			case NAME_REV:
+				if (!oid_ret)
+					o = lookup_object(the_repository, &oid);
 				if (o)
 					name = get_rev_name(o, &buf);
+				*(p + 1) = c;
+				if (!name)
+					goto start;
+				if (cmd->u.name_only)
+					printf("%.*s%s", p_len - hexsz, p_start, name);
+				else
+					printf("%.*s (%s)", p_len, p_start, name);
+				break;
+			default:
+				BUG("uncovered case: %d", cmd->type);
 			}
-			*(p + 1) = c;
-
-			if (!name)
-				continue;
 
-			if (data->name_only)
-				printf("%.*s%s", p_len - hexsz, p_start, name);
-			else
-				printf("%.*s (%s)", p_len, p_start, name);
 			p_start = p + 1;
 		}
 	}
@@ -567,6 +593,7 @@ int cmd_name_rev(int argc,
 #endif
 	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
+	struct command cmd;
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -596,6 +623,7 @@ int cmd_name_rev(int argc,
 	init_commit_rev_name(&rev_names);
 	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
+	init_name_rev_command(&cmd, data.name_only);
 
 #ifndef WITH_BREAKING_CHANGES
 	if (transform_stdin) {
@@ -663,7 +691,7 @@ int cmd_name_rev(int argc,
 
 		while (strbuf_getline(&sb, stdin) != EOF) {
 			strbuf_addch(&sb, '\n');
-			name_rev_line(sb.buf, &data);
+			name_rev_line(sb.buf, &cmd);
 		}
 		strbuf_release(&sb);
 	} else if (all) {
-- 
2.54.0.13.g9c7419e39f8

