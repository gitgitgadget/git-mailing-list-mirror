Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8D236449
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635139; cv=none; b=H9jC0d9vMkMRwuQW9DHGK/z23roMvggNHJz4VzbnzXypv+kdENcXyOSrIetYUWtu8g+x+pibQKGWJKdANLAR1xfi+rBgmA5mOAFQDvElcZMKPkTm5RxCFCYAucmAjARl4RaqGYFd30wzuEGiL9URn8RCTecOukn+XsOSqo95x5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635139; c=relaxed/simple;
	bh=4Tndw1GYlY8PiPzX1zL//L6P7E3PCl6u8LKT4wjlyuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvcsw1rCvZxgFbKP0aEQ685LSqWLvZy9khxn9OZ9HVdjRc+miM708iXTH97DfJxpaz26scRndzMuexJcX05Bfye9ufvSlvtzrBUWRF6XOkJgB/kfh7nROGtVh38rFRQX5ARJKS3MzLdA62sxaPsFpd58injgHfj+nX78b+eKo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxcDzRl5; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxcDzRl5"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3fa0eb29cebso235304b6e.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741635136; x=1742239936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ81+t9Lx38WfPyXWYaI6JgA8qqe8G7JF74fWb4C/V4=;
        b=gxcDzRl59c5EsGjRsLXtrykiqQxrf6BDgNYCLpiqB2dwLTXbY/2VEnRQSD1zmhcdBj
         lYW3SsB0nPZomm1HGyAG2b0Ho48cln/esbkN2gnT5QapIkIg3zUHzlte3zs7LH/jU6Jp
         T+Qn6S3dHhjiXcOu5sf0Rz+4O/T3hoL6YcCtu1wFgq5/HppFjep/q6gPP0oE6DHhXv9J
         9HSziX7DHk1My2J47tkSZgHi0rq3CShkb4tltvkViJ+l9ABr6qSMFjJc4KDn3ma0p2MN
         bC7B4+BLGEYuyJW4UkSFpqXhUyQu7JDpD0/aECMplPsrzfGHzBQj/011d7yz4o309V0g
         8bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635136; x=1742239936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ81+t9Lx38WfPyXWYaI6JgA8qqe8G7JF74fWb4C/V4=;
        b=oXoXmZSrDZ2xUiEV7hmWcva8vDXu5z8hI19Wp9S9VLV6nsb7Gc4x6jPNbk1CyF395I
         mjcQAcdPQf/DUSW5WJ/Oj2BdwvNJvG5WqkU+QQk8IgJukwZoqTI8lXZOFVTPCSAlpxTO
         ZdZMRr+9mCqPiYJpdeEKNdkeXlHHg1iDUzuriq8dz/uabTKsbRaQPxRWtI7PcM4UemFq
         C5LLQl/kSN2ZLz7JhzzqQ70Q2aLmcReg8EzOst9zj1q6nBAo/cMbEXGOA4Om63LLxbgJ
         q+v1Jc3LByf242w3vaaD8mnYvvmyPfPuaEGeujtH2WGyH5MSUOzeu73/ZNib94AHV+PT
         upOQ==
X-Gm-Message-State: AOJu0YznTBpKVHUm0Rj+s2yE1Tddyf1WDxq1pgzLAzKI5PN0Aep5/y6/
	Uc1+dLcWIwiFqFy+cLA55RmlCjlZgEBoOX1jRE8c4r2Pn6e4Ha8/7J6eAQ==
X-Gm-Gg: ASbGncv3h9Ro9FdTcnb9yRY7mFOIMREMirMrlwP7Y9xNdELxzEcF6MgWRTR/4+txCbc
	Ct3gGP5IvcU7ntQWlZRRfHLyAPmlvynuBeywEkT46Nxur33IPlIdNyhrt+3rrBT16zF1XpvKVlc
	8LgQN86Bgbn9cm5uaKBxNLXifx6DD50Qw9vqSoPPXk/qEa0sJf9FPRzkt9FnesR+lPxh+XDmv8l
	RI5KgWNIxtNddU/FL6pov0iZ4q4FedLGs3W/LYAlwxyaBex7kyq0oUHgshTuVltLyB34O8OkywR
	V+OcAgVwN0KmQBE4CEdCsAmU4Gs518peSzdLhOkluzfK2Nx5aQec
X-Google-Smtp-Source: AGHT+IF8gGA9+gPkkT16OjrPEYjIjWVrfYFubeUP0GfOylzLF9P+bYE06IhD92rolWuJt9nPDhg3ZA==
X-Received: by 2002:a05:6808:3a09:b0:3f9:aeb6:6e92 with SMTP id 5614622812f47-3fa2badc1a7mr429047b6e.9.1741635136525;
        Mon, 10 Mar 2025 12:32:16 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f861f30de5sm697819b6e.46.2025.03.10.12.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:32:15 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/4] rev-list: support NUL-delimited --missing option
Date: Mon, 10 Mar 2025 14:28:29 -0500
Message-ID: <20250310192829.661692-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--missing={print,print-info}` option for git-rev-list(1) prints
missing objects found while performing the revision walk. Add support
for printing missing objects in a NUL-delimited format when the `-z`
option is enabled.

        $ git rev-list -z --missing=print-info <rev>
        <oid> NUL NUL
        ?<oid> [NUL <token>=<value>]... NUL NUL

In this mode, values containing special characters or spaces are printed
as-is without being escaped or quoted.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 10 +++++++++-
 builtin/rev-list.c                  | 27 +++++++++++++++++++-------
 t/t6022-rev-list-missing.sh         | 30 +++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index d21016d657..48648b7507 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -378,7 +378,15 @@ containing newline characters:
 <OID> [NUL <object-name>] NUL NUL
 -----------------------------------------------------------------------
 +
-This option is only compatible with `--objects`.
+When the `--missing` option is provided, missing objects are printed in the
+following form where value is printed as-is without any token specific
+encoding:
++
+-----------------------------------------------------------------------
+?<OID> [NUL <token>=<value>]... NUL NUL
+-----------------------------------------------------------------------
++
+This option is only compatible with `--objects` and `--missing`.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 86b3ce5806..5bbc4a787e 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -145,25 +145,38 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 				 int print_missing_info)
 {
 	struct strbuf sb = STRBUF_INIT;
+	char info_sep = ' ';
+
+	if (nul_delim)
+		info_sep = '\0';
+
+	printf("?%s", oid_to_hex(&entry->entry.oid));
 
 	if (!print_missing_info) {
-		printf("?%s\n", oid_to_hex(&entry->entry.oid));
+		print_object_term(nul_delim);
 		return;
 	}
 
 	if (entry->path && *entry->path) {
 		struct strbuf path = STRBUF_INIT;
 
-		strbuf_addstr(&sb, " path=");
-		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
-		strbuf_addbuf(&sb, &path);
+		strbuf_addf(&sb, "%cpath=", info_sep);
+
+		if (nul_delim) {
+			strbuf_addstr(&sb, entry->path);
+		} else {
+			quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
+			strbuf_addbuf(&sb, &path);
+		}
 
 		strbuf_release(&path);
 	}
 	if (entry->type)
-		strbuf_addf(&sb, " type=%s", type_name(entry->type));
+		strbuf_addf(&sb, "%ctype=%s", info_sep, type_name(entry->type));
+
+	fwrite(sb.buf, sizeof(char), sb.len, stdout);
+	print_object_term(nul_delim);
 
-	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
 	strbuf_release(&sb);
 }
 
@@ -782,7 +795,7 @@ int cmd_rev_list(int argc,
 	if (nul_delim) {
 		if (revs.graph || revs.verbose_header || show_disk_usage ||
 		    info.show_timestamp || info.header_prefix || bisect_list ||
-		    use_bitmap_index || revs.edge_hint || arg_missing_action)
+		    use_bitmap_index || revs.edge_hint)
 			die(_("-z option used with unsupported option"));
 	}
 
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 3e2790d4c8..3ae25e4cfb 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -198,4 +198,34 @@ do
 	'
 done
 
+test_expect_success "-z nul-delimited --missing" '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m first &&
+
+		path="foo bar" &&
+		echo foobar >"$path" &&
+		git add -A &&
+		git commit -m second &&
+
+		oid=$(git rev-parse "HEAD:$path") &&
+		type="$(git cat-file -t $oid)" &&
+
+		obj_path=".git/objects/$(test_oid_to_path $oid)" &&
+
+		git rev-list -z --objects --no-object-names \
+			HEAD ^"$oid" >expect &&
+		printf "?%s\0path=%s\0type=%s\0\0" "$oid" "$path" "$type" >>expect &&
+
+		mv "$obj_path" "$obj_path.hidden" &&
+		git rev-list -z --objects --no-object-names \
+			--missing=print-info HEAD >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.49.0.rc2

