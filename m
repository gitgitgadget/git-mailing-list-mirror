Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116195;
	b=a/x9MiwnnfRGirLwTgN6PtGBJJ+E0911MOPo8niod2iKeBrQkNv8loIys0+SjUVkpduH
	 0bOgqbkAB4Z35n44tEiGr9pnTRSxfNTXjnWAuaNMFgkpcV+a9a44HLO1RA9fDrcWQp9/7
	 ZNpRXaTWNao9tal2fj1Z1xzKnm7+C0FgwcpPt+M9ycsAIc+A+VPDvtHUvcj3N8odDwz+z
	 Tuhagmn14q+K+vEVHchsayq1r0crxr/o0/E/sn+ubx8rXSDy/KnwFDo7+McTZSYn1FgVE
	 4ZY1ky00upYBXIYpnV1RUUR3Jm2+S/JrOB8sx8rvitPOhxMnQnsBOE4vQU9CsElt44g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=lsiH1ANFKe3n8tPu6el6rYQDZA94XwU8nrNc/8y4lrY=;
	b=CuhFo7yU7xYaKndDkW8c8n+TwkQEJTK9UL/anYlM2RX+gwt/jdKw95mggggDrxG0njwu
	 SVo+/vE1AT1cIg814VcXHHwciw8evJedKTfVEKtOxd2ekAcbW8M7mi/2r4pqQQ+EYouPJ
	 hun265T77qy4njKjn8sz6STaRI0lPvMbAWJ+dXqkyUi7bTgdZjkFIGqWIKWIQNJx5lMKI
	 uGTx/RETXOafMJpla095nlWaYBgXQ+u1OD9OOOYamsEwpYlC6bqnj6VhqrqeM9mzhADDh
	 IwZjVT6eRhNvlwYxNn6L5SVRna3ScBGe7BohSQilib9Svo/2WdZWUpPivRddXRJ2gdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RIRLVySh;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C7606A32F
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D11C7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RIRLVySh
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso258765e9.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116193; x=1795720993; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lsiH1ANFKe3n8tPu6el6rYQDZA94XwU8nrNc/8y4lrY=;
        b=RIRLVyShFrqlHBupVvKtzRflC+JTCWMusZ1XJRdYxaczxPPzRNH16n/aYVRnx9aWib
         0N1K1YqOJfsZtEMRM7urNod5dQtF1PlEttciuDPegJ0G8a3vfwtmmXFB2TeamCSa1E+i
         VPukOg8QjRZ7gN7pN8kXjH4O3f4KK6T194XrpBXwj+L00Y1fXhOW5PXNzv2ZRgD0RDlA
         a8ULDJmoTgW61sNmvWD1s/yebuiGWeVrtvI1XqjFBGjJ5Gz4PYcjcvrqwwgvgaH7ikO4
         GQVShf8M4/Aohk0vgYbp1tiUqy3uQSnrVgy0uMiLaGhD5iH+RBBXNqjt76yn7Be6U43I
         CQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116193; x=1795720993;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsiH1ANFKe3n8tPu6el6rYQDZA94XwU8nrNc/8y4lrY=;
        b=n+JIAfm7Vu4lRlTm4oMp0RQHFZVaS995tLiYPNQcnsjg8AxEKD4bU16KerEIflYmXN
         2J35ZSl4UMralUS4odK0zJ7q1YTUSM1ahBujnLK4KjeTlmo88KGdt6N7lobelfd0+Axq
         Tv35OXrxPhk0RUllXhbozgxm6hQKJXNGsL5MpX5msF5zdjNpiljiozWK2Gh9pikIeOSB
         E+IJaiTxJC8Gp/O+RKu1R6SXzVCioDA4xDAJrhfKi/7DXS8IXTo9O/UDSa2lHdQ2reaM
         3R1n+1mSbg56tKt+TxH8y/HAz7kQwWld2Y/l0Ijq9drKTfP4nh+N5GumpPdinfwCnWx3
         bj9Q==
X-Gm-Message-State: APuU4Z8h5SUavXFEzcRafd7Inwq22ihxQdBbKd8NXlBYhH4qbYTBK+Qp
	Q014UBvJTgfoV97dNS6w51ry0b9aW6voidJXra43zL1ZXCB93BMRlba3XjlX9TEQpkrlgH2mAXv
	7b3JiwKdyGqp7bzvNL8PAD88DRH2JyHJfbswaRxpI6oGb4sTOq7fKufJ8UEO1zFj9CKXsblBkUm
	OeSU70l9H1BWgEd1O3RhhKpg==
X-Received: from wrbdm12.prod.google.com ([2002:a05:6000:bcc:b0:4a5:8df0:1304])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1548:b0:4a1:e00b:a10b
 with SMTP id 5b1f17b1804b1-4bb88800020mr13201225e9.7.1795116193034; Thu, 19
 Nov 2026 11:23:13 -0800 (PST)
Date: Thu, 19 Nov 2026 20:23:11 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192311.2685319-1-dmnk@google.com>
Subject: [PATCH] archive: reject remote --add-file in callback
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Johannes Sixt <j6t@kdbg.org>, 
	"=?UTF-8?q?Jean-No=C3=ABl=20Avila?=" <jn.avila@free.fr>, dmnk+artist@google.com, Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

parse_archive_args() only checks "is_remote && args->extra_files.nr"
after parse_options() returns. When git-upload-archive parses client
arguments, add_file_cb() runs first and calls stat() on the requested
path on the server filesystem, reporting "File not found" or "Not a
regular file" before the "--remote" incompatibility check is reached
(and succeeding altogether if "--no-add-file" follows).

Pass is_remote into add_file_cb() and reject "--add-file" and
"--add-virtual-file" immediately before touching the filesystem.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 archive.c           | 31 ++++++++++++++++++++++---------
 t/t5000-tar-tree.sh |  9 +++++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 59790be986..b983209ce4 100644
--- a/archive.c
+++ b/archive.c
@@ -559,15 +559,27 @@ static void extra_file_info_clear(void *util, const char *str UNUSED)
 	free(info);
 }
 
+struct add_file_data {
+	struct archiver_args *args;
+	const char **basep;
+	int is_remote;
+};
+
 static int add_file_cb(const struct option *opt, const char *arg, int unset)
 {
-	struct archiver_args *args = opt->value;
-	const char **basep = (const char **)opt->defval;
-	const char *base = *basep;
+	struct add_file_data *data = opt->value;
+	struct archiver_args *args = data->args;
+	const char *base = *data->basep;
 	char *path;
 	struct string_list_item *item;
 	struct extra_file_info *info;
 
+	if (data->is_remote)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    !strcmp(opt->long_name, "add-virtual-file") ?
+		    "--add-virtual-file" : "--add-file",
+		    "--remote");
+
 	if (unset) {
 		string_list_clear_func(&args->extra_files,
 				       extra_file_info_clear);
@@ -645,6 +657,11 @@ static int parse_archive_args(int argc, const char **argv,
 	int i;
 	int list = 0;
 	int worktree_attributes = 0;
+	struct add_file_data add_file_data = {
+		.args = args,
+		.basep = &base,
+		.is_remote = is_remote,
+	};
 	struct option opts[] = {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
@@ -653,20 +670,18 @@ static int parse_archive_args(int argc, const char **argv,
 		{
 			.type = OPTION_CALLBACK,
 			.long_name = "add-file",
-			.value = args,
+			.value = &add_file_data,
 			.argh = N_("file"),
 			.help = N_("add untracked file to archive"),
 			.callback = add_file_cb,
-			.defval = (intptr_t) &base,
 		},
 		{
 			.type = OPTION_CALLBACK,
 			.long_name = "add-virtual-file",
-			.value = args,
+			.value = &add_file_data,
 			.argh = N_("path:content"),
 			.help = N_("add untracked file to archive"),
 			.callback = add_file_cb,
-			.defval = (intptr_t) &base,
 		},
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
@@ -702,8 +717,6 @@ static int parse_archive_args(int argc, const char **argv,
 		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
 	if (output)
 		die(_("Unexpected option --output"));
-	if (is_remote && args->extra_files.nr)
-		die(_("options '%s' and '%s' cannot be used together"), "--add-file", "--remote");
 
 	if (!base)
 		base = "";
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3ad600c793..930a9fcb29 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -237,6 +237,15 @@ check_tar with_untracked2
 check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
 
+test_expect_success 'git archive --remote rejects --add-file before stat' '
+	test_must_fail git archive --remote=. --add-file=no-such-file HEAD 2>err &&
+	test_grep "cannot be used together" err &&
+	test_grep ! "File not found" err &&
+	echo untracked >untracked &&
+	test_must_fail git archive --remote=. --add-file=untracked --no-add-file HEAD 2>err &&
+	test_grep "cannot be used together" err
+'
+
 test_expect_success 'git archive on large files' '
 	test_config core.bigfilethreshold 1 &&
 	git archive HEAD >b3.tar &&
-- 
2.56.1.750.gf70dc682cf-goog

