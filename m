Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543558;
	b=nAxvI0R0Bfwudbe1BLwhUktK5I/y8qqYomdY5RyUcG8Sz3yeCFGEmRDtdd94xAPfJwPR
	 tpSTyE4ZOAR0MGPTKMc5CkxUNYJUNqaJHHsrUjAFoXbt2uQC7B8F9RlbbXq7SZg0afusV
	 CPzVc6adnESKUtEq+0X7qBDf7uX777zPS6PjTXYtqn1nTgqx2b4auIcC5TCzR10yvXFpe
	 VTpfn8QbXr5DTVKV7dRqD6f3JFy15S3HcJN0n0HN3K2MV9d0zLh0ovw/18Rg4BHCID3pB
	 sXs5xXlkVXvdMWYHa4pmSn+FAgsKeBkmN4tXVIxh+ITswXYuc5ByavVkwWgkCKpsoIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ClZJGLb2XsHzJdRmgdKodgo0zX+nfrEblKmNTxC29BA=;
	b=Sl72zaBsrl8AnhRVVNS273xHl1Aw1PZ3GctqZ2Mns/1jxZqmzdJKvRTSba9q1D4cv6lX
	 MxEEVOyy8fZyW9qfqrKD34kwWknHe1vKtumv0P8I3pruc5rozqUVq1VoaHikht7YIj1mw
	 viCaxub3KH/az2bIUt/DraSogs18YriyzvrB7OkNBVqB70dMjW0OyVdbzm72Vf15fOHpk
	 3fVRVt0qiGYsaxTFaZMvFMS+VaTyyl2IZ12G5PRp9KbSdDMLVdypy+5HZsaGUtbiGlMsj
	 O6JQwmQrDZbmy3jfHWiRl7P9sv6YwsL74qB1OVa6NzWk0AUbmRM9/YKA/+f3YMRoGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i9vN+lRr;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD42606A337
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAD42606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i9vN+lRr
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4923b9fdd43so2993242f8f.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543556; x=1796148356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ClZJGLb2XsHzJdRmgdKodgo0zX+nfrEblKmNTxC29BA=;
        b=i9vN+lRrAlsR4xS63NhtuP1i7xZb549Tm5MJaP/I8i5L6Vllr18nlC1UZeiqqjTXmH
         aXEeQfTYGbBsPItAKR5u/3owkttsfvu4tRiEz1fhInODgL1f5twiPdvty+wsh2zG+mjL
         FzQQ3GDjO1aO26aJrV5shil63iWzjo+mdV+KvVjk1a1qUIs7E1bZfzxOlw0i0ZxGHOb9
         Hw7zscgCv34ujTdVzPejShdJK3ziXdX6Fd3LwcBIAMVrBh3+C1G+rE4veGrU82vSYWyh
         BLokjR66x1o7Vw0z5DG8gzo6eofrA3I05xSF1H10+F6Lepm6BHq3AZJjN43HduReMuNU
         Es1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543556; x=1796148356;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ClZJGLb2XsHzJdRmgdKodgo0zX+nfrEblKmNTxC29BA=;
        b=ZwfO4jE/wwacx3n1MWkD8t1VhKsfxeZJRxT/YnOG30CYa+gWiZFr2HNaP0DFIXBa7j
         2dWQbPxRjlLCEHS12ickRnXmqYuh4AzZzxl1TF22XrREiHbXB06HmN/SrtkaijPM0oYC
         KboQNsXvbZoKyb2zVbBv8uzcrpLtdQpyOobMAfAYoGsm0X6GvAJv6/pr99qJm5Yc519b
         8OB+IWsG6G9nkYddtMa9b1qwnQFShZoJzvCDBJ0EVZKwu8JaFLuwrpIZt0x4ufYk1hVn
         tQ0rIgKvgCpI8mUuQVVqrulv4hmF6Qwjzi4VfnxYT24kVbMvzE0srnp2O0YiJVP++Sql
         aHDQ==
X-Gm-Message-State: APuU4Z9+cPT5o2YSxkXnWJn2ziQnRm4OMyYxJ+Ou5FK/1hUYYBAY1MyC
	9Y9gkU7RPb6hl/zwGWwrboAjE7KXF+sZzD2wuPGLZmI3X1WL2val+98UHK6KzL37zoU8W7UpQMl
	YnqKLUSUZ7WFRXWKrfbkBod09AOVwDIvC50UfkHYuXCsN1aysfCHhiN8eUg35/oYZ6LBqgYle0Y
	wpHYUy4fIzRX36Fl1sh1o8Wg==
X-Received: from wrnl16.prod.google.com ([2002:adf:e9d0:0:b0:4ac:c680:bccb])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:402b:b0:4a4:f86e:d97
 with SMTP id ffacd0b85a97d-4abaa976a91mr30536444f8f.1.1795543555687; Tue, 24
 Nov 2026 10:05:55 -0800 (PST)
Date: Tue, 24 Nov 2026 18:05:50 +0000
In-Reply-To: <cover.1795543448.git.dmnk@google.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192311.2685319-1-dmnk@google.com> <cover.1795543448.git.dmnk@google.com>
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <543109b7483191cd26b4f02d8b95a62a940b1dd9.1795543448.git.dmnk@google.com>
Subject: [PATCH v2 2/2] archive: defer --add-file stat() until after option parsing
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: "=?utf-8?q?Ren=C3=A9_Scharfe?=" <l.s.r@web.de>, Junio C Hamano <gitster@pobox.com>, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

add_file_cb() calls stat() on each --add-file argument while
parse_options() is still running, before parse_archive_args() checks
is_remote. When git-upload-archive parses client arguments, it probes
the requested path on the server filesystem and reports "File not found"
or "Not a regular file" instead of rejecting --add-file with --remote.

Move the stat() and regular-file checks into parse_archive_args() after
parse_options() finishes, refusing entries with a NULL content pointer
when is_remote is set. This rejects remote --add-file before touching
the filesystem, allows a later --no-add-file to cancel an earlier
--add-file, and lets --add-virtual-file work with --remote since its
content is supplied inline.

Suggested-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 archive.c           | 24 +++++++++++++++++-------
 t/t5000-tar-tree.sh | 24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index 2348ab12ed..413fc1cd11 100644
--- a/archive.c
+++ b/archive.c
@@ -586,11 +586,8 @@ static int add_file_cb(const struct option *opt, const=
 char *arg, int unset)
=20
 	if (!strcmp(opt->long_name, "add-file")) {
 		path =3D prefix_filename(args->prefix, arg);
-		if (stat(path, &info->stat))
-			die(_("File not found: %s"), path);
-		if (!S_ISREG(info->stat.st_mode))
-			die(_("Not a regular file: %s"), path);
-		info->content =3D NULL; /* read the file later */
+		memset(&info->stat, 0, sizeof(info->stat));
+		info->content =3D NULL; /* stat and read the file later */
 	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
 		struct strbuf buf =3D STRBUF_INIT;
 		const char *p =3D arg;
@@ -646,6 +643,7 @@ static int parse_archive_args(int argc, const char **ar=
gv,
 	const char *mtime_option =3D NULL;
 	int compression_level =3D -1;
 	int verbose =3D 0;
+	struct string_list_item *item;
 	int i;
 	int list =3D 0;
 	int worktree_attributes =3D 0;
@@ -706,8 +704,20 @@ static int parse_archive_args(int argc, const char **a=
rgv,
 		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
 	if (output)
 		die(_("Unexpected option --output"));
-	if (is_remote && args->extra_files.nr)
-		die(_("options '%s' and '%s' cannot be used together"), "--add-file", "-=
-remote");
+	for_each_string_list_item(item, &args->extra_files) {
+		const char *path =3D item->string;
+		struct extra_file_info *info =3D item->util;
+
+		if (info->content)
+			continue;
+		if (is_remote)
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--add-file", "--remote");
+		if (stat(path, &info->stat))
+			die(_("File not found: %s"), path);
+		if (!S_ISREG(info->stat.st_mode))
+			die(_("Not a regular file: %s"), path);
+	}
=20
 	if (!base)
 		base =3D "";
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3ad600c793..c2bead12e9 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -237,6 +237,30 @@ check_tar with_untracked2
 check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
=20
+test_expect_success 'git archive --remote rejects --add-file without stat'=
 '
+	test_must_fail git archive --remote=3D. --add-file=3Dno-such-file HEAD 2>=
err &&
+	test_grep "cannot be used together" err &&
+	test_grep ! "File not found" err &&
+	test_must_fail git archive --remote=3D. --add-file=3D. HEAD 2>err &&
+	test_grep "cannot be used together" err &&
+	test_grep ! "Not a regular file" err
+'
+
+test_expect_success 'git archive allows --no-add-file after missing --add-=
file' '
+	git archive --add-file=3Dno-such-file --no-add-file HEAD >canceled.tar &&
+	test_cmp_bin b.tar canceled.tar &&
+	git archive --remote=3D. --add-file=3Dno-such-file --no-add-file HEAD >re=
mote-canceled.tar &&
+	test_cmp_bin b.tar remote-canceled.tar
+'
+
+test_expect_success 'git archive --remote with --add-virtual-file' '
+	printf virtual >expected-virtual &&
+	git archive --remote=3D. --add-virtual-file=3Dvirtual:virtual HEAD >remot=
e_virtual.tar
+'
+
+check_tar remote_virtual
+check_added remote_virtual expected-virtual virtual
+
 test_expect_success 'git archive on large files' '
 	test_config core.bigfilethreshold 1 &&
 	git archive HEAD >b3.tar &&
--=20
2.56.1.831.g720f3f5937-goog

