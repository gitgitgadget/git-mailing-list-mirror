Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9637210F45
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409480; cv=none; b=TqBKy+FM1RR5dXm5iw27qfOTMys9P+9hWPAbsEHWscsVjY3N73LTeULxPdPUw0bFkoTAm+2ZeZmwqPeilMub+igNSnW82lq8kU3BTfXDrKJXRamcIwZDFiYRIwz/O7c6B3dmzfIElpsB0G42cuzPHZjDIeCVPaxyWO4cyE2VXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409480; c=relaxed/simple;
	bh=CvdNutqQRxbGZikEHGpdXLo9MmKELXtFxSzeHpPFnFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETGxRdNFBpW9BP0zO16Q6Ad0Vjxi2eFxUQnLiV81m+/pEbjq1Khvb/Ip7mZJ26q0U+fmtYzU0oOmAoK935RiQL9kD6IChKx0HlO73Kh5JUdJx4GUrX5b+8GgGnNsZtVaZovuht+nTRD2xGUFH24hDM/thSGFLHQ426ILZ9LMbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9M4m5Zf; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9M4m5Zf"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72bd5f25ea6so3164a34.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742409477; x=1743014277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpjgqQG+8Z9+f94T6PAqRQHf2Xr+mAoRcV4YasCAg/Q=;
        b=b9M4m5ZftAoHt4MXjEl8RdjQDKELZvIk/Ks6XQuzQN4hg+5ZtKOAKGQdltDgBOMFdS
         6FqFH4UMSaZUGtVHuCtUDLSdiU6bkm36OmCM6NG3NyYHRgD1Dz3g7XTVnkkLI+InIQH+
         xcxOtEmgh+5X4roj3NlCiu5UjXNm+QrXvwL8RxXl6CKxkjGbmch/qi1E/ehOntDYoT3E
         KBLIULP4oTh+YVmHHlGsYTHPJX9oQBq43VUcKlNoBXPY9d8fykhy8iqxTjxLHrWeiECB
         wu+myLaSh6X2Ceat0pwcWQenKE3Up1fk91aF9XZvFd4rgTVFWRyazogKXHOGtkSezH1/
         Vadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409477; x=1743014277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpjgqQG+8Z9+f94T6PAqRQHf2Xr+mAoRcV4YasCAg/Q=;
        b=gthMRY7pPW2vMV5lefJqXCzI5lDLoBQRicUEijxH7TR0UA67IUlqiDo6L/BqbGV5ks
         nu4N9oY7KxIB6tV/T/YPVhTgYnJIeKJvVYeANTcttEmazGAM2AkNHBYpd2Z9JGnss46S
         thddj59vfC2JN9s7Igj/DfBZl9JKiWOaHnUgTEOHAJlHZG8kC1MCH9/6OORZMmj9iq+m
         dsUnBERoxOBrRnrFjjDpzwrJSEYP0yE8ytQOdtDyOavowP6tAxSsoa/KbHSzA6QI9PDg
         0W2M1BrKTpKW5qWFBvIs10IREh+OJ4QbpppumBuFHVeMxp+Lu0J3rPn4XuTYiZadQ9xs
         0OtA==
X-Gm-Message-State: AOJu0YyeQtQiZBp0a01D9TYscWOemGs1hbCV/W4kpys8a6AyOhYx1jry
	yBgjCv9BIqpQd0c3tVrmlSjtu2oVlNqYnuxZb20f8d/JH78F6tdEPAE1ug==
X-Gm-Gg: ASbGncsx7Tzy0VPGYfhzJBkIHB01XKahAM1uU27Ns9SPiETTXigUIN+4mIhMr6wl3G0
	inqhRlzAOBbMxagTLr8JLU7aUwIjbbRdBDiwaBFDH0W1iGGPr2afOKufCCDOAYfRINx6Zwy012f
	h1p3O67jMSguSxp1oJoE4KXq9/60UQme/R5/MV9mP/HzLBRk955sXktFxg0nSADlJFM0z6ikHix
	I+87IsufGcvCs61NygHu923Dr3KRSl3H1zpBitj7BC6xu8H/4MHJPKDaX34HqfUB2VEqbVHPWYS
	4tFs+KtUKO4i54xZq8RbXdtTHkWUeTEIs4gHQY+DF8B4G7TUmibW
X-Google-Smtp-Source: AGHT+IH9eDjSapeNdfpMA+xuNwHE5QvJ1WoPe/jLbhcCE0tUH6b93sP2Th7ekMc5SziE+Um5uLrbBQ==
X-Received: by 2002:a05:6830:6882:b0:72b:a92b:5797 with SMTP id 46e09a7af769-72bfbdd1b86mr3348806a34.9.1742409477301;
        Wed, 19 Mar 2025 11:37:57 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e796sm2561943a34.48.2025.03.19.11.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:37:56 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 5/5] rev-list: support NUL-delimited --missing option
Date: Wed, 19 Mar 2025 13:34:10 -0500
Message-ID: <20250319183410.1225428-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250319183410.1225428-1-jltobler@gmail.com>
References: <20250313235747.9583-1-jltobler@gmail.com>
 <20250319183410.1225428-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--missing={print,print-info}` option for git-rev-list(1) prints
missing objects found while performing the object walk in the form:

        $ git rev-list --missing=print-info <rev>
        ?<oid> [SP <token>=<value>]... LF

Add support for printing missing objects in a NUL-delimited format when
the `-z` option is enabled.

        $ git rev-list -z --missing=print-info <rev>
        <oid> NUL missing=yes NUL [<token>=<value> NUL]...

In this mode, values containing special characters or spaces are printed
as-is without being escaped or quoted. Instead of prefixing the missing
OID with '?', a separate `missing=yes` token/value pair is appended.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc |  5 +++--
 builtin/rev-list.c                  | 31 ++++++++++++++++++++---------
 t/t6022-rev-list-missing.sh         | 31 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 3fc9902d6b..0e5605a85e 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -380,10 +380,11 @@ and thus is used to signal the start of a new object record. Examples:
 <OID> NUL
 <OID> NUL path=<path> NUL
 <OID> NUL boundary=yes NUL
+<OID> NUL missing=yes NUL [<token>=<value> NUL]...
 -----------------------------------------------------------------------
 +
-This mode is only compatible with the `--objects` and `--boundary` output
-options.
+This mode is only compatible with the `--objects`, `--boundary`, and
+`--missing` output options.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bcb880f109..e6ee3f82ee 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -136,24 +136,37 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 {
 	struct strbuf sb = STRBUF_INIT;
 
+	if (line_term)
+		printf("?%s", oid_to_hex(&entry->entry.oid));
+	else
+		printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
+		       info_term);
+
 	if (!print_missing_info) {
-		printf("?%s\n", oid_to_hex(&entry->entry.oid));
+		putchar(line_term);
 		return;
 	}
 
 	if (entry->path && *entry->path) {
-		struct strbuf path = STRBUF_INIT;
+		strbuf_addf(&sb, "%cpath=", info_term);
+
+		if (line_term) {
+			struct strbuf path = STRBUF_INIT;
 
-		strbuf_addstr(&sb, " path=");
-		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
-		strbuf_addbuf(&sb, &path);
+			quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
+			strbuf_addbuf(&sb, &path);
 
-		strbuf_release(&path);
+			strbuf_release(&path);
+		} else {
+			strbuf_addstr(&sb, entry->path);
+		}
 	}
 	if (entry->type)
-		strbuf_addf(&sb, " type=%s", type_name(entry->type));
+		strbuf_addf(&sb, "%ctype=%s", info_term, type_name(entry->type));
+
+	fwrite(sb.buf, sizeof(char), sb.len, stdout);
+	putchar(line_term);
 
-	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
 	strbuf_release(&sb);
 }
 
@@ -783,7 +796,7 @@ int cmd_rev_list(int argc,
 		if (revs.graph || revs.verbose_header || show_disk_usage ||
 		    info.show_timestamp || info.header_prefix || bisect_list ||
 		    use_bitmap_index || revs.edge_hint || revs.left_right ||
-		    revs.cherry_mark || arg_missing_action)
+		    revs.cherry_mark)
 			die(_("-z option used with unsupported option"));
 	}
 
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 3e2790d4c8..08e92dd002 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -198,4 +198,35 @@ do
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
+		printf "%s\0missing=yes\0path=%s\0type=%s\0" "$oid" "$path" \
+			"$type" >>expect &&
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

