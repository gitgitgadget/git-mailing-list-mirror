Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679C1EB5FE
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384411; cv=none; b=ufWgTwbYSblkI+h7eY/6Ts0/FMdgN//vkkK4GL5qUJFny0wvQ0XY87YqjDqiKGjI89dmMZm+iTspP+NNQGsFfLebH4jAj0aolBTq/ei6c80pFkhVxZCOqO+elhZGWm2SZ0mvy2LKrz5Jr/dUwTPCJ+PBcGfG4pQfY/rWwbHF1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384411; c=relaxed/simple;
	bh=shyJ03CA1WIa3B+fOHuONc/XgXLUv7bDE8oHZ1tOGoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RifO4aCz4rgXheY8c3uwoo8lYjYBpRYWsxdBo2EZ74A3az/IZ6uPAdze8VXdfBsXjM4qFXoU8TBCpAdN3fySI+VdgLA5M1bck34nby0EGEubnYbb5OMU/Pz9X1vnvK6mjYfgPv//J+b28GiJQsKMKYw9XrNMjz0p0XFetjWBpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1RKaTpY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1RKaTpY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266d38c2so3019470a91.0
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755384409; x=1755989209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+QKEayOBVzdl+t4AYNV2OXxUFCVwvrX0W2sldEHHEA=;
        b=B1RKaTpYgaVnmfTz7zMZPD0KFDDctz8encHVIzeWx2OBSpDSk0H0nvhqNN4y3fPx7e
         /C2dkuzSgssNqaCMzB1uuOkJwUaUWiAUwseOSUg0NVDtBpDwJ8YNGlqd6b2/sJFgVdCu
         q7fvNSOIJMlyZEZBgGYFxOMSlV0gL0sMsZ8qBT7Rf3bqY59nRn5EYyiCmvStjGo4saMQ
         /sOOQiW8XwPPcoOU7l8PVRnHMPu2F6ylxmkkG7vipDddg1MEq9YE0JlGKV/zvIthwY0i
         ZvwrWKEaBKHGgKxfxbVaJA8dNXtlBfjuWVu0IxTL6QjWyL5eIZCVAZd4NagyXakqzjvw
         slrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384409; x=1755989209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+QKEayOBVzdl+t4AYNV2OXxUFCVwvrX0W2sldEHHEA=;
        b=LTsRmRHNg4uPfDr7uJwQjLyw814YcWXpjcScBE0/06ngc7Xnw2usMLppG1xHtyLMlq
         VhpBUVs/agjfigHstCkv9YVOqgSlCCuFbla632vgFpCqDpbTMhDHNqy9kQbNI4oEC8hK
         DbQjtbicBdS0F+eCwZ+52xjWIuCr+dg38fabpL7dRbFGE+moVuALe4EvJSOcowatPc7C
         4bFWMUYm7UUvzKMVjj6SqMUzSNzUAKJ/IVlqRkYkh1wEnRBYBt356uvPLbXI+mhg6hjN
         3QZW5Us+71UW0yTUV48S07TFZJrPnSNK2R+/e6gKs5vuolW2wVanjRe5KYMlIgzT62Oi
         PlsQ==
X-Gm-Message-State: AOJu0Yx6ZeOvozHXpphUC3CtytJMQ6v2Avi0AsM8NonugR0dCMz/5qKK
	2tfIm8VZTvVGrafYPtd/oE5kzOoKl2aDM5zgDvHkQ6SwbDBUZppzhroED/P7MA==
X-Gm-Gg: ASbGncswcu400DS7XxzDx+KnnOOcaIsosVILgOzhI9t6aSRAymkVroz1VUNoijMGaEC
	dY85b57duSsQBlOe4CDV67qS3ctXi+gfls063e0egGy9xJfjsdNWWoW+OrKHE6c+xHCX1G7Sxps
	5x6wsakQwiku2OsiylhS4bcyYDtP2wmWgpnhfbP4ZMVtG4PmQWVQBjsx9gwcqMAXE+sXR/z9kXE
	AE57Zz7/mDqfyS4L1iLSM35hZhHee/fsXhEO/dc1/wMFCsZ4NeCzm7G9W1HryT0ldPAkZI3Ol3C
	JDLrO2K/4Qwg00g54L+5SMjJ1ukKB05YNYj4CWo0QSumI1TKyJ6kj8Qe6pnd1DcbCn5tCpiWxxc
	Sd8oZgYXPS8bmdbT5j4hzrIUR7pcQL7UtExAtQ4T54G2/e8JG8Wljue8c3ludqA==
X-Google-Smtp-Source: AGHT+IHjRM2n656fcHrDE9LsAFZxbj4FlbZTeMvQwEkXqFpq1xkTGcrduEROKA49oKBBDEd6SvenwA==
X-Received: by 2002:a17:90b:2dc7:b0:31f:3c3:947c with SMTP id 98e67ed59e1d1-32341e0e728mr9957768a91.10.1755384409036;
        Sat, 16 Aug 2025 15:46:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:e855:1cad:1392:e988])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5ad0f7sm4617280a12.2.2025.08.16.15.46.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Aug 2025 15:46:48 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v11 5/5] repo: add the --format flag
Date: Sat, 16 Aug 2025 19:46:03 -0300
Message-Id: <20250816224603.3307-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250816224603.3307-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250816224603.3307-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the --format flag to git-repo-info. By using this flag, the users
can choose the format for obtaining the data they requested.

Given that this command can be used for generating input for other
applications and for being read by end users, it requires at least two
formats: one for being read by humans and other for being read by
machines. Some other Git commands also have two output formats, notably
git-config which was the inspiration for the two formats that were
chosen here:

- keyvalue, where the retrieved data is printed one per line, using =
  for delimiting the key and the value. This is the default format,
  targeted for end users.
- nul, where the retrieved data is separated by NUL characters, using
  the newline character for delimiting the key and the value. This
  format is targeted for being read by machines.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 40 ++++++++++++++++++++++++++------
 builtin/repo.c              | 46 ++++++++++++++++++++++++++++++++-----
 t/t1900-repo.sh             | 18 ++++++++++++---
 3 files changed, 88 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 01b7f9c95e..2870828d93 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [<key>...]
+git repo info [--format=(keyvalue|nul)] [<key>...]
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [<key>...]`::
+`info [--format=(keyvalue|nul)] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -26,14 +26,23 @@ COMMANDS
 The values are returned in the same order in which their respective keys were
 requested.
 +
-The output format consists of key-value pairs one per line using the `=`
-character as the delimiter between the key and the value. Values containing
-"unusual" characters are quoted as explained for the configuration variable
-`core.quotePath` (see linkgit:git-config[1]).
+The output format can be chosen through the flag `--format`. Two formats are
+supported:
++
+`keyvalue`:::
+	output key-value pairs one per line using the `=` character as
+	the delimiter between the key and the value. Values containing "unusual"
+	characters are quoted as explained for the configuration variable
+	`core.quotePath` (see linkgit:git-config[1]). This is the default.
+
+`nul`:::
+	similar to `keyvalue`, but using a newline character as the delimiter
+	between the key and the value and using a NUL character after each value.
+	This format is better suited for being parsed by another applications than
+	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
 
 INFO KEYS
 ---------
-
 In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
@@ -49,6 +58,23 @@ values that they return:
 +
 include::ref-storage-format.adoc[]
 
+EXAMPLES
+--------
+
+* Retrieves the reference format of the current repository:
++
+------------
+git repo info references.format
+------------
++
+
+* Retrieves whether the current repository is bare and whether it is shallow
+using the `nul` format:
++
+------------
+git repo info --format=nul layout.bare layout.shallow
+------------
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 3c9140593b..8c6e7f42ab 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,12 +9,17 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [<key>...]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
+enum output_format {
+	FORMAT_KEYVALUE,
+	FORMAT_NUL_TERMINATED,
+};
+
 struct field {
 	const char *key;
 	get_value_fn *get_value;
@@ -65,7 +70,9 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
-static int print_fields(int argc, const char **argv, struct repository *repo)
+static int print_fields(int argc, const char **argv,
+			struct repository *repo,
+			enum output_format format)
 {
 	int ret = 0;
 	struct strbuf valbuf = STRBUF_INIT;
@@ -86,8 +93,18 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 		strbuf_reset(&quotbuf);
 
 		get_value(repo, &valbuf);
-		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-		printf("%s=%s\n", key, quotbuf.buf);
+
+		switch (format) {
+		case FORMAT_KEYVALUE:
+			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
+			printf("%s=%s\n", key, quotbuf.buf);
+			break;
+		case FORMAT_NUL_TERMINATED:
+			printf("%s\n%s%c", key, valbuf.buf, '\0');
+			break;
+		default:
+			BUG("not a valid output format: %d", format);
+		}
 	}
 
 	strbuf_release(&valbuf);
@@ -95,10 +112,27 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 	return ret;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	return print_fields(argc - 1, argv + 1, repo);
+	const char *format_str = "keyvalue";
+	enum output_format format;
+	struct option options[] = {
+		OPT_STRING(0, "format", &format_str, N_("format"),
+			   N_("output format")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (!strcmp(format_str, "keyvalue"))
+		format = FORMAT_KEYVALUE;
+	else if (!strcmp(format_str, "nul"))
+		format = FORMAT_NUL_TERMINATED;
+	else
+		die(_("invalid format '%s'"), format_str);
+
+	return print_fields(argc, argv, repo, format);
 }
 
 int cmd_repo(int argc, const char **argv, const char *prefix,
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 6a9cbf3d47..a69c715357 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -25,11 +25,17 @@ test_repo_info () {
 		eval "$init_command $repo_name"
 	'
 
-	test_expect_success "$label" '
-		echo "$key=$expected_value" >expect &&
-		git -C $repo_name repo info "$key" >actual &&
+	test_expect_success "keyvalue: $label" '
+		echo "$key=$expected_value" > expect &&
+		git -C "$repo_name" repo info "$key" >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success "nul: $label" '
+		printf "%s\n%s\0" "$key" "$expected_value" >expect &&
+		git -C "$repo_name" repo info --format=nul "$key" >actual &&
+		test_cmp_bin expect actual
+	'
 }
 
 test_repo_info 'ref format files is retrieved correctly' \
@@ -80,4 +86,10 @@ test_expect_success 'git-repo-info outputs data even if there is an invalid fiel
 	test_cmp expect actual
 '
 
+test_expect_success 'git-repo-info aborts when requesting an invalid format' '
+	echo "fatal: invalid format ${SQ}foo${SQ}" >expect &&
+	test_must_fail git repo info --format=foo 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

