Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE21822E5
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063984; cv=none; b=HG6Yd+06IIuS8Rc1oDwf1pUkgTbm7v1vN1GP9m/Jref7MvpvjorjEKNNeQs90fWDwtQzG/02seyFYpV/uoF1VOhAtER4O0Pq3WfnuyChMf84uv5b/79TF9BYCc+gbNqQGCtWzeNsxSIfbAMen0VaquLb2JN+Ss9PAo7eCQKKAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063984; c=relaxed/simple;
	bh=3gknF6cNMDFYAFJ38nfk5s+EKIskefwOpbnGQpiq04U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJyjtbXHXHAxrOYhI+TDtwBt2cXrVMD5ohlDtFcbFGVd2Ag8DkG78kc62SS582hPRmGXY8FDkAj3D39x0PpAxzE6TaJxpUs1P6S2C4HsslGT4OynPkEjOX0+pzTgSU6y5O0yQpj/K7EWAn0sJ0JLO4npiC6l+YN87CBGCgmytyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnKZDnur; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnKZDnur"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ee8eaa1694so629213eaf.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 20:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734063981; x=1734668781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8jOOdxwqEtp3jZJ/b4Fj0gnVnD8E3vzo6CJoILBGvI=;
        b=CnKZDnurTg9ikBkHinfpr/JA/DWwQp5hLqI3a/iNIwKVAvGJHRkZ7wX3HHvnoEJShE
         MlvxvF+bgdNTxIWomBpw8EiwSswiDjso2mHheRNY/LQ+ssHHlkpziUE5x86Ybg9K/uUX
         Ucc+ii//h4fr5Dyb1G5q5rrv/oV8TfqOth/KWliEGYlKhMFT3enmsvdck6S6YY60d42T
         u2WOELctZkjQp7HpuSZxlNW1fYUyZsWDcYJtD7CVA5cv7gWLeRHr2qYpr3O3+iXoYV2e
         GoPWfIZgi2vBMi5TfsPcwE9ZRQ5lgc/otsZNkZUJFRtE1aeR2aWpceOzIWmon1ODMGLG
         YKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734063981; x=1734668781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8jOOdxwqEtp3jZJ/b4Fj0gnVnD8E3vzo6CJoILBGvI=;
        b=Ao+pW00bkAzNa5nM8zubhajMWSXtcVkJN/DF9gNx+Dd/6D255eeQl62XBvYo7LrZmY
         HT99yzD0tLNQHdbDoz96Ns+FjCV6X4Ikp9aD8OB6XOCmDW43Ad3+9XtY1uCSBWVLhJU9
         OXOKOa9f5ifrhpvmx9O+XJ3CLGI2dxNaDj3msRnhpL+i8lw78woEDD6QGYGdPRizKcDy
         eklAhV7Gofl4Zh4rGI0GhCKZuX/H17YPEBWBstI4Rv3L3zvTfTMTkAskqj+tQUo+L2Dc
         JUy15mDflvuorqQ7lmqjtS9Zvea5v6xDXWyu7HsCj91gqOSIpSvXURY0nGCqV540Gdrt
         qzpg==
X-Gm-Message-State: AOJu0YxVtgFlSMuKxeYTsavk6txgPhgDFz9eHVWZKBZIqrMRK4F9jL67
	nG7+glT6OLGPaRN/4rzCjimIO8SKbWShgH4RlmPv7E6cAcWoms2rvnPI9A==
X-Gm-Gg: ASbGncs9UFdbGGghhHPc+sBKJ2H3ieq8FmChVLB6j2NeI4j3tar4Nic9/0SpbmNdgXD
	6/d6maDsWX7sLXM6VqTM6aKNyOjrHtGPKPEUN35Zd97cl2qfnfYuo7ElTWo2NKnrNQ1a5yRltkp
	Y2ZZIKexHCaF2CaFs749VBEd2dfIRJ0PRqT0wg6eUnr/7CwDaUSIy8ptf1M7iLnhlr7rWGvoI87
	05F9FDKfi0+mbXVU8d4Z4iW5IFp+fPI8mGnX7tklTsq9FLdEJKSPOVdv2l6rbO4
X-Google-Smtp-Source: AGHT+IEpYITkwNVYvjyF4P6yNYOLAxBbI4kKgLQeSFYEXUm0t2rrA5WLMdKir1C0ubEdFkpr9OcgXw==
X-Received: by 2002:a05:6820:1e88:b0:5f2:af6a:e4c0 with SMTP id 006d021491bc7-5f32929d472mr798749eaf.1.1734063981547;
        Thu, 12 Dec 2024 20:26:21 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e37410edfsm342736a34.67.2024.12.12.20.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:26:20 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/3] builtin/diff-blob: Add "-z" option
Date: Thu, 12 Dec 2024 22:23:12 -0600
Message-ID: <20241213042312.2890841-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213042312.2890841-1-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "--stdin" option for git-diff-blob(1) reads two space separated
blobs for each line of input. A blob may be specified by its ID or a
path-scoped revision that resolves to a blob. It is possible for the
path to contain whitespace or newline characters which must be escaped.

To make input more simple, teach git-diff-blob(1) the "-z" option which
changes the input delimiter for each blob to a NUL character. With this
option, the command waits two NUL terminated blobs to read and then
generates the diff. The diff output is also NUL terminated to help
differentiate between outputted diffs.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-diff-blob.txt |  6 +++++-
 builtin/diff-blob.c             | 37 +++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-diff-blob.txt b/Documentation/git-diff-blob.txt
index f6ecd522fa..36cd686bb1 100644
--- a/Documentation/git-diff-blob.txt
+++ b/Documentation/git-diff-blob.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git diff-blob' <blob> <blob>
-'git diff-blob' --stdin
+'git diff-blob' --stdin [-z]
 
 DESCRIPTION
 -----------
@@ -26,6 +26,10 @@ OPTIONS
 	from the command line.  Instead, it reads lines containing two <blob>
 	from its standard input.  (Use a single space as separator.)
 
+-z::
+	When `--stdin` has been given, use NUL characters to separate blob
+	inputs and diff outputs.
+
 include::pretty-formats.txt[]
 
 include::diff-format.txt[]
diff --git a/builtin/diff-blob.c b/builtin/diff-blob.c
index 45edfdd979..60c92cec9c 100644
--- a/builtin/diff-blob.c
+++ b/builtin/diff-blob.c
@@ -81,23 +81,39 @@ static void parse_blob_stdin(struct object_array *blob_pair,
 	object_context_release(&oc);
 }
 
-static void diff_blob_stdin(struct repository *repo, struct diff_options *opts)
+static void diff_blob_stdin(struct repository *repo, struct diff_options *opts,
+			    int null_term)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list_item *item;
 
-	while (strbuf_getline(&sb, stdin) != EOF) {
+	while (1) {
 		struct object_array blob_pair = OBJECT_ARRAY_INIT;
 		struct string_list list = STRING_LIST_INIT_NODUP;
 
-		if (string_list_split_in_place(&list, sb.buf, " ", -1) != 2)
-			die("two blobs not provided");
+		if (null_term) {
+			if (strbuf_getline_nul(&sb, stdin) == EOF)
+				break;
+			parse_blob_stdin(&blob_pair, repo, sb.buf);
 
-		for_each_string_list_item(item, &list) {
-			parse_blob_stdin(&blob_pair, repo, item->string);
+			if (strbuf_getline_nul(&sb, stdin) == EOF)
+				break;
+			parse_blob_stdin(&blob_pair, repo, sb.buf);
+		} else {
+			if (strbuf_getline(&sb, stdin) == EOF)
+				break;
+
+			if (string_list_split_in_place(&list, sb.buf, " ", -1) != 2)
+				die("two blobs not provided");
+
+			for_each_string_list_item(item, &list) {
+				parse_blob_stdin(&blob_pair, repo, item->string);
+			}
 		}
 
 		diff_blobs(&blob_pair.objects[0], &blob_pair.objects[1], opts);
+		if (null_term)
+			printf("%c", '\0');
 
 		string_list_clear(&list, 1);
 		object_array_clear(&blob_pair);
@@ -112,16 +128,19 @@ int cmd_diff_blob(int argc, const char **argv, const char *prefix,
 	struct object_array_entry *old_blob, *new_blob;
 	struct rev_info revs;
 	int read_stdin = 0;
+	int null_term = 0;
 	int ret;
 
 	const char * const usage[] = {
 		N_("git diff-blob <blob> <blob>"),
-		N_("git diff-blob --stdin"),
+		N_("git diff-blob --stdin [-z]"),
 		NULL
 	};
 	struct option options[] = {
 		OPT_BOOL(0, "stdin", &read_stdin,
 			N_("read blob pairs from stdin")),
+		OPT_BOOL('z', NULL, &null_term,
+			N_("inputed blobs and outputted diffs terminated with NUL")),
 		OPT_END()
 	};
 
@@ -149,13 +168,13 @@ int cmd_diff_blob(int argc, const char **argv, const char *prefix,
 			usage_with_options(usage, options);
 
 		revs.diffopt.no_free = 1;
-		diff_blob_stdin(repo, &revs.diffopt);
+		diff_blob_stdin(repo, &revs.diffopt, null_term);
 		revs.diffopt.no_free = 0;
 		diff_free(&revs.diffopt);
 
 		break;
 	case 2:
-		if (read_stdin)
+		if (read_stdin || null_term)
 			usage_with_options(usage, options);
 
 		old_blob = &revs.pending.objects[0];
-- 
2.47.1

