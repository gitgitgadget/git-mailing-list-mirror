Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37C2931D9
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320547; cv=none; b=vBpsLgUj/WYIC4ax+L0+QzPiGjvemSnbKgFlB+SNWzkRP4+ov8gi0Bzlti7SZVC2kxb/CLaPH3k+y76KwB8Xo1QnJapm+QJgu07R/kA1qfP38RIlEo3HALSMgB6jBpMam456BTc6eQgxrt/1UyNJ7vMBqaR0+PEouDTbk20fSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320547; c=relaxed/simple;
	bh=KuFdA4epxL4L911Rgeunccc1sq2Vq4hfR1Fto03p6sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7ZjNAImpYUp6UgcS4YirWFSDYRVYyWfazraOtkG4687DHJzu1tll3cVUWH0hHkY6Ou+puYDFrGM1AAbl84rsr64k6InfDil/kDHspCESvGvOwFF2P+M9JDI/KMsuu1CUf607RDYZwpUJPzY0SEMRmt8tu3C3rZT0089hCFNmC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aixLDnM1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aixLDnM1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so865323a91.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320545; x=1787925345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cb6DtOZLNLnnmGD1cHidd+0uMBvr60LoRSA+5j5STc4=;
        b=aixLDnM1HFFMbHk43NPYrEwap7TQMTdAMWhh+4fC3HCJoLVnmjXEDBDWgaHuh2kJZx
         C5SHbY0oJfUzHtkB4UMLBsMmbu0M8CTMfwnX4hyKUg8n+YluJTSiS1cb4SNCy6YFpNrg
         vlZNw5lG1yVBIRcm4QRntdz5yp6RPCgPz72fFq/K+F6azAeFzcmyN+LaQdPA9n0sz8e9
         jUNDMjVvQK4mXsfdSJFI9O5lrjgCFGrcajaHm4cMOg6Klr1TvV7OIS2sEhm8L+8Bbbte
         QxT+J0bM6BCyh3Sug2+6B1crmtin/nitwwzbxvMJxo1+/bTDnb6ucuiSz4tnQwGzUkMy
         NBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320545; x=1787925345;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cb6DtOZLNLnnmGD1cHidd+0uMBvr60LoRSA+5j5STc4=;
        b=iXxMClWI6RI7i9J0czARKOIXRdlQ6eEuXQrqc5w32EJ28ODgcqoYt+Mi72rE/phkB+
         /o57BlQxVtVTGbuaBlxlY2p87npq9kvzekNDrIxQ9D8wdS7xkpALLmFiCsogRTjqKbsu
         VAVihEhFDHscq9YbvWD7Nzk6TVBenWsqIY/zhdub+dOz4yb5h8sQbH+TwH2cyUdGxO7w
         15r5l1GXfIJPzIkFL4fayOWNss2UuHhX1KBWOIgrxQvHEMXU8QLIZeO6ikXyg7DyrX7p
         aBI3BxE91JDBBU0+QF8Kb3AH+BPHi/dS3TN0fUv9kJVNw4BU0G7x8KRJ7LMJ+d5IU9Lu
         g1IA==
X-Gm-Message-State: AFuF++n5ywT1StP9hiMaU6u998+7KGCM233PT7oxvhGWtqoJf5iBIJzx
	OJKaaHqmr47jljEX4Ddkgi0IzK8pTsLa9tV4UxkeJNbgIKmCZcz3mM6K4NPm6t+b
X-Gm-Gg: AR+sD10QJdRLhsz/6D1hhLn1Nk/fx1r6ROkvv+YeolEzY8gM4aMXAIgMEFy7l4Ihq5c
	V7G0MiUDtfnyv2T9g57XDBDcVAkmmY/wD8x//gi2oKnpdl5iE6kXBLl24ROqlAtQ3TMsQTmdpls
	RZsJoP2tWqv1xBDWKSQ5DulbP+q6g/6DQABFBUFNp9T+iLytxuU7w/COWk/hRr+h7/lznbW5l4/
	Yzx8NJyIy61M20FeaLDx92Ka0iNYkWdl0UqZ2zdtSKV08N7WDyZ3m38Hvn1KMSZHqMpqAr6o9F3
	JgSc8TJb/Dmk4gcQqIaUVFhoSeppxpo5VaFBKUiR73p4vD3V3d43FNdVK94BRIBymj113VPxT5e
	oMUmsi5JvubH+7H+vRaMO9CzLJTBiERiP59rI/LUAGuYkVYeRJ6NXRTXfhcMlLDofwBvUDgtxMf
	iMFpY9DyiQJzIOWD76IKAVE/FspyPjh8gPbRj0FDg+BOQOcRLzJkb1toPdmtctOWDeQiIdfyEtO
	6QFT5Uw5apVPVhYiwR9M7UAGZ/mEEd0rlOXwW+UiUkb7qC0mTDMloQkXqq4t1DZCBLC1EU=
X-Received: by 2002:a17:90b:54d0:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-395c353ee4amr13412072a91.6.1787320545306;
        Fri, 21 Aug 2026 06:55:45 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm31969308eec.4.2026.08.21.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:55:44 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 2/2] repo: add Unicode support for `repo structure` output
Date: Fri, 21 Aug 2026 19:23:45 +0530
Message-ID: <20260821135410.429698-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
References: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ASCII output ignores locale support for UTF-8. Use box-drawing
characters and bullets when the locale supports UTF-8, since modern
terminals render tables cleanly this way, and fall back to ASCII
otherwise.

Tests now discover an available UTF-8 locale to set a `UTF8_LOCALE`
prerequisite, and existing ASCII table tests are explicitly pinned
to `LC_ALL=C` so their behavior remains deterministic regardless of the
runner's environment.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/repo.c            | 110 ++++++++++++++++-------------
 t/t1901-repo-structure.sh | 141 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 48 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..2c1cca6f2e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -498,82 +498,86 @@ static void stats_table_setup_structure(struct stats_table *table,
 	size_t object_count_total;
 	size_t disk_object_total;
 	size_t ref_total;
+	const int utf8 = is_utf8_locale();
+	const char *bullet_l0 = utf8 ? "•" : "*";
+	const char *bullet_l1 = utf8 ? "  •" : "  *";
+	const char *bullet_l2 = utf8 ? "    •" : "    *";
 
 	ref_total = get_total_reference_count(refs);
-	stats_table_addf(table, "* %s", _("References"));
-	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
-	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
-	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
-	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
-	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
+	stats_table_addf(table, "%s %s", bullet_l0, _("References"));
+	stats_table_count_addf(table, ref_total, "%s %s", bullet_l1, _("Count"));
+	stats_table_count_addf(table, refs->branches, "%s %s", bullet_l2, _("Branches"));
+	stats_table_count_addf(table, refs->tags, "%s %s", bullet_l2, _("Tags"));
+	stats_table_count_addf(table, refs->remotes, "%s %s", bullet_l2, _("Remotes"));
+	stats_table_count_addf(table, refs->others, "%s %s", bullet_l2, _("Others"));
 
 	object_count_total = get_total_object_values(&objects->type_counts);
 	stats_table_addf(table, "");
-	stats_table_addf(table, "* %s", _("Reachable objects"));
-	stats_table_count_addf(table, object_count_total, "  * %s", _("Count"));
+	stats_table_addf(table, "%s %s", bullet_l0, _("Reachable objects"));
+	stats_table_count_addf(table, object_count_total, "%s %s", bullet_l1, _("Count"));
 	stats_table_count_addf(table, objects->type_counts.commits,
-			       "    * %s", _("Commits"));
+			       "%s %s", bullet_l2, _("Commits"));
 	stats_table_count_addf(table, objects->type_counts.trees,
-			       "    * %s", _("Trees"));
+			       "%s %s", bullet_l2, _("Trees"));
 	stats_table_count_addf(table, objects->type_counts.blobs,
-			       "    * %s", _("Blobs"));
+			       "%s %s", bullet_l2, _("Blobs"));
 	stats_table_count_addf(table, objects->type_counts.tags,
-			       "    * %s", _("Tags"));
+			       "%s %s", bullet_l2, _("Tags"));
 
 	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
 	stats_table_size_addf(table, inflated_object_total,
-			      "  * %s", _("Inflated size"));
+			      "%s %s", bullet_l1, _("Inflated size"));
 	stats_table_size_addf(table, objects->inflated_sizes.commits,
-			      "    * %s", _("Commits"));
+			      "%s %s", bullet_l2, _("Commits"));
 	stats_table_size_addf(table, objects->inflated_sizes.trees,
-			      "    * %s", _("Trees"));
+			      "%s %s", bullet_l2, _("Trees"));
 	stats_table_size_addf(table, objects->inflated_sizes.blobs,
-			      "    * %s", _("Blobs"));
+			      "%s %s", bullet_l2, _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
-			      "    * %s", _("Tags"));
+			      "%s %s", bullet_l2, _("Tags"));
 
 	disk_object_total = get_total_object_values(&objects->disk_sizes);
 	stats_table_size_addf(table, disk_object_total,
-			      "  * %s", _("Disk size"));
+			      "%s %s", bullet_l1, _("Disk size"));
 	stats_table_size_addf(table, objects->disk_sizes.commits,
-			      "    * %s", _("Commits"));
+			      "%s %s", bullet_l2, _("Commits"));
 	stats_table_size_addf(table, objects->disk_sizes.trees,
-			      "    * %s", _("Trees"));
+			      "%s %s", bullet_l2, _("Trees"));
 	stats_table_size_addf(table, objects->disk_sizes.blobs,
-			      "    * %s", _("Blobs"));
+			      "%s %s", bullet_l2, _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
-			      "    * %s", _("Tags"));
+			      "%s %s", bullet_l2, _("Tags"));
 
 	stats_table_addf(table, "");
-	stats_table_addf(table, "* %s", _("Largest objects"));
-	stats_table_addf(table, "  * %s", _("Commits"));
+	stats_table_addf(table, "%s %s", bullet_l0, _("Largest objects"));
+	stats_table_addf(table, "%s %s", bullet_l1, _("Commits"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.commit_size.oid,
 				     objects->largest.commit_size.value,
-				     "    * %s", _("Maximum size"));
+				     "%s %s", bullet_l2, _("Maximum size"));
 	stats_table_object_count_addf(table,
 				      &objects->largest.parent_count.oid,
 				      objects->largest.parent_count.value,
-				      "    * %s", _("Maximum parents"));
-	stats_table_addf(table, "  * %s", _("Trees"));
+				      "%s %s", bullet_l2, _("Maximum parents"));
+	stats_table_addf(table, "%s %s", bullet_l1, _("Trees"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tree_size.oid,
 				     objects->largest.tree_size.value,
-				     "    * %s", _("Maximum size"));
+				     "%s %s", bullet_l2, _("Maximum size"));
 	stats_table_object_count_addf(table,
 				      &objects->largest.tree_entries.oid,
 				      objects->largest.tree_entries.value,
-				      "    * %s", _("Maximum entries"));
-	stats_table_addf(table, "  * %s", _("Blobs"));
+				      "%s %s", bullet_l2, _("Maximum entries"));
+	stats_table_addf(table, "%s %s", bullet_l1, _("Blobs"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.blob_size.oid,
 				     objects->largest.blob_size.value,
-				     "    * %s", _("Maximum size"));
-	stats_table_addf(table, "  * %s", _("Tags"));
+				     "%s %s", bullet_l2, _("Maximum size"));
+	stats_table_addf(table, "%s %s", bullet_l1, _("Tags"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tag_size.oid,
 				     objects->largest.tag_size.value,
-				     "    * %s", _("Maximum size"));
+				     "%s %s", bullet_l2, _("Maximum size"));
 }
 
 #define INDEX_WIDTH 4
@@ -589,28 +593,42 @@ static void stats_table_print_structure(const struct stats_table *table)
 	int unit_col_width = table->unit_col_width;
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
+	const int utf8 = is_utf8_locale();
+	const char *border_left = utf8 ? "│ " : "| ";
+	const char *border_mid = utf8 ? " │ " : " | ";
+	const char *border_right = utf8 ? " │" : " |";
 
 	if (title_name_width > name_col_width)
 		name_col_width = title_name_width;
 	if (title_value_width > value_col_width + unit_col_width + 1)
 		value_col_width = title_value_width - unit_col_width;
 
-	strbuf_addstr(&buf, "| ");
+	strbuf_addstr(&buf, border_left);
 	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width + INDEX_WIDTH,
 			  name_col_title);
-	strbuf_addstr(&buf, " | ");
+	strbuf_addstr(&buf, border_mid);
 	strbuf_utf8_align(&buf, ALIGN_LEFT,
 			  value_col_width + unit_col_width + 1, value_col_title);
-	strbuf_addstr(&buf, " |");
+	strbuf_addstr(&buf, border_right);
 	printf("%s\n", buf.buf);
 
-	printf("| ");
-	for (int i = 0; i < name_col_width + INDEX_WIDTH; i++)
-		putchar('-');
-	printf(" | ");
-	for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
-		putchar('-');
-	printf(" |\n");
+	if (utf8) {
+		printf("├─");
+		for (int i = 0; i < name_col_width + INDEX_WIDTH; i++)
+			printf("─");
+		printf("─┼─");
+		for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
+			printf("─");
+		printf("─┤\n");
+	} else {
+		printf("| ");
+		for (int i = 0; i < name_col_width + INDEX_WIDTH; i++)
+			putchar('-');
+		printf(" | ");
+		for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
+			putchar('-');
+		printf(" |\n");
+	}
 
 	for_each_string_list_item(item, &table->rows) {
 		struct stats_table_entry *entry = item->util;
@@ -624,7 +642,7 @@ static void stats_table_print_structure(const struct stats_table *table)
 		}
 
 		strbuf_reset(&buf);
-		strbuf_addstr(&buf, "| ");
+		strbuf_addstr(&buf, border_left);
 		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
 
 		if (entry && entry->oid)
@@ -633,11 +651,11 @@ static void stats_table_print_structure(const struct stats_table *table)
 		else
 			strbuf_addchars(&buf, ' ', INDEX_WIDTH);
 
-		strbuf_addstr(&buf, " | ");
+		strbuf_addstr(&buf, border_mid);
 		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
 		strbuf_addch(&buf, ' ');
 		strbuf_utf8_align(&buf, ALIGN_LEFT, unit_col_width, unit);
-		strbuf_addstr(&buf, " |");
+		strbuf_addstr(&buf, border_right);
 		printf("%s\n", buf.buf);
 	}
 
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..926db09175 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -4,6 +4,29 @@ test_description='test git repo structure'
 
 . ./test-lib.sh
 
+# Detect if a UTF-8 locale is available on the test system.
+if test -z "$GIT_TEST_UTF8_LOCALE"
+then
+	case "${LC_ALL:-$LANG}" in
+	*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
+		GIT_TEST_UTF8_LOCALE="${LC_ALL:-$LANG}"
+		;;
+	*)
+		if type locale >/dev/null 2>&1
+		then
+			GIT_TEST_UTF8_LOCALE=$(locale -a 2>/dev/null | sed -n '/\.[uU][tT][fF]-*8$/{
+				p
+				q
+			}')
+		fi
+		;;
+	esac
+fi
+if test -n "$GIT_TEST_UTF8_LOCALE"
+then
+	test_set_prereq UTF8_LOCALE
+fi
+
 object_type_disk_usage() {
 	disk_usage_opt="--disk-usage"
 
@@ -66,7 +89,10 @@ test_expect_success 'empty repository' '
 		|     * Maximum size        |    0 B |
 		EOF
 
-		git repo structure >out 2>err &&
+		# Force a non-UTF8 locale so this test always exercises the
+		# ASCII fallback formatting, regardless of what locale the
+		# runner defaults to.
+		LC_ALL=C git repo structure >out 2>err &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
@@ -137,7 +163,10 @@ test_expect_success SHA1 'repository with references and objects' '
 		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
 		EOF
 
-		git repo structure >out 2>err &&
+		# Force a non-UTF8 locale so this test always exercises the
+		# ASCII fallback formatting, regardless of what locale the
+		# runner defaults to.
+		LC_ALL=C git repo structure >out 2>err &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
@@ -230,4 +259,112 @@ test_expect_success 'git repo structure -h shows only repo structure usage' '
 	test_grep ! "git repo info" actual
 '
 
+test_expect_success UTF8_LOCALE 'unicode output under UTF-8 locale with missing locale dir' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >expect <<-\EOF &&
+		│ Repository structure      │ Value  │
+		├───────────────────────────┼────────┤
+		│ • References              │        │
+		│   • Count                 │    0   │
+		│     • Branches            │    0   │
+		│     • Tags                │    0   │
+		│     • Remotes             │    0   │
+		│     • Others              │    0   │
+		│                           │        │
+		│ • Reachable objects       │        │
+		│   • Count                 │    0   │
+		│     • Commits             │    0   │
+		│     • Trees               │    0   │
+		│     • Blobs               │    0   │
+		│     • Tags                │    0   │
+		│   • Inflated size         │    0 B │
+		│     • Commits             │    0 B │
+		│     • Trees               │    0 B │
+		│     • Blobs               │    0 B │
+		│     • Tags                │    0 B │
+		│   • Disk size             │    0 B │
+		│     • Commits             │    0 B │
+		│     • Trees               │    0 B │
+		│     • Blobs               │    0 B │
+		│     • Tags                │    0 B │
+		│                           │        │
+		│ • Largest objects         │        │
+		│   • Commits               │        │
+		│     • Maximum size        │    0 B │
+		│     • Maximum parents     │    0   │
+		│   • Trees                 │        │
+		│     • Maximum size        │    0 B │
+		│     • Maximum entries     │    0   │
+		│   • Blobs                 │        │
+		│     • Maximum size        │    0 B │
+		│   • Tags                  │        │
+		│     • Maximum size        │    0 B │
+		EOF
+		# Point GIT_TEXTDOMAINDIR at a nonexistent path so
+		# git_setup_gettext() takes its early-return path (its
+		# locale-directory check fails) and never populates the
+		# gettext-internal charset. This exercises the
+		# is_utf8_locale() fallback that derives the charset
+		# directly from LC_ALL/LC_CTYPE/LANG instead, regardless of
+		# whether gettext itself was able to initialize.
+		GIT_TEXTDOMAINDIR="$TRASH_DIRECTORY/nonexistent-locale-dir" \
+		LC_ALL="$GIT_TEST_UTF8_LOCALE" git repo structure >out 2>err &&
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success UTF8_LOCALE 'unicode output under UTF-8 locale' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >expect <<-\EOF &&
+		│ Repository structure      │ Value  │
+		├───────────────────────────┼────────┤
+		│ • References              │        │
+		│   • Count                 │    0   │
+		│     • Branches            │    0   │
+		│     • Tags                │    0   │
+		│     • Remotes             │    0   │
+		│     • Others              │    0   │
+		│                           │        │
+		│ • Reachable objects       │        │
+		│   • Count                 │    0   │
+		│     • Commits             │    0   │
+		│     • Trees               │    0   │
+		│     • Blobs               │    0   │
+		│     • Tags                │    0   │
+		│   • Inflated size         │    0 B │
+		│     • Commits             │    0 B │
+		│     • Trees               │    0 B │
+		│     • Blobs               │    0 B │
+		│     • Tags                │    0 B │
+		│   • Disk size             │    0 B │
+		│     • Commits             │    0 B │
+		│     • Trees               │    0 B │
+		│     • Blobs               │    0 B │
+		│     • Tags                │    0 B │
+		│                           │        │
+		│ • Largest objects         │        │
+		│   • Commits               │        │
+		│     • Maximum size        │    0 B │
+		│     • Maximum parents     │    0   │
+		│   • Trees                 │        │
+		│     • Maximum size        │    0 B │
+		│     • Maximum entries     │    0   │
+		│   • Blobs                 │        │
+		│     • Maximum size        │    0 B │
+		│   • Tags                  │        │
+		│     • Maximum size        │    0 B │
+		EOF
+		LC_ALL="$GIT_TEST_UTF8_LOCALE" git repo structure >out 2>err &&
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.55.GIT

