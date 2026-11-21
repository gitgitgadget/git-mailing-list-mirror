Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257765;
	b=oykrueUvJ76Y61NDAPMyisWcizR4WcdUX4rWSXfFvomsbdHG5zmB7jqjkRrzgChlQ5mW
	 9S0yDWAkhSAt1upjnGv01kcz79llPDpqbINpZo+ZhTfdmzptn9UzkFCkGje8tgWGwtTy6
	 BDJuc6z7iMb9FPpomTMTzYr/mqqFU3HdkcvbLh/tskac1G35+Bzlt0Z8jUcTF3n5lax8s
	 XQw5LA5g/FY3kF9H8gdMfPBIw9ym2hUjsmlg4EUrVYViYsaxGU+zYShrY9TsMD/hwnOCM
	 KrL2uTep5cguJ1+8GmT9G4JM9AlaFOZhUXQTMv+26uNBDrVwmtGLTP6c3bKxAP5zC2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0oTgRu1qHUXuivUo89rE1RDh6vQA0mITZ2xwyaWWfGw=;
	b=I3mBoqYgy5W6DpdyQvFhTAcek88ZkDRskbW1dfvNoECu0AkqTNJXLN3GQVdLQVbj2TF/
	 /WEAD4qo2mwXElTzCKkgUgPx5x2Xa3s40rtD0vP+IiIov5DT++GhmG3BpMyaHrjgu/3/4
	 Sj7UsbO0Cp+9LxnA7REqfkHDCoA1LbcpNrq9rgjKxPXCFc8cft0Kq5LNy8SA6kbfkfcu+
	 yqdezSVJTBqROEVAUHWTYKCfNra7IF0RFYZ4dlYfab99HgYSVA5tL9vwUY2+CWqwWZJYF
	 jRmgeO653r+JmhDtc+P3bN7rbbPTIcwltmtcK8RMTSqmbOOHcpeNwZyy/vtxPV5jbEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a4NdrpBh;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E1606A333
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 10:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 522E1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a4NdrpBh
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15dd124bbe7so3946944c88.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795257764; x=1795862564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oTgRu1qHUXuivUo89rE1RDh6vQA0mITZ2xwyaWWfGw=;
        b=a4NdrpBhoeyOitQGzQM4xOlaHZMWRe3w64g/FbPegPHjZs+IUvbdTehCWXJrDU1N+W
         0NBYvUDIXjD2hiZiwRtBnqUUbMkB08xp1uUTVkYnnOASBvbiXskME659CCGb3vNuBfhC
         W3LUNkF+GsssjF59sb4pls0mcwtk5sASnkp7ELJ0ARvyo+4ZGd/bYnNK7a8sjUpPmTXq
         /MTJuNf0DWaUIlIQEQUUXlrlgeld7FHGxZ96f6tEn/wxwGPigc8iiVT3EXYLUIo+2n9u
         5K02h78efww7vdiQNyY5N3tUVTkZ3JGXFPjWdShLoiBviwWr+HDoB/Qp9ZhtFb8tB9Ww
         HCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795257764; x=1795862564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0oTgRu1qHUXuivUo89rE1RDh6vQA0mITZ2xwyaWWfGw=;
        b=ZakyJolYHt8SGg6QRa4K6qsGaxnkhRpFGxx3dK2LynWjBbb3wODNwRPK2nfhREEQjx
         NMC8MRrW3ks2pd4GmvFMx1P5EhfI/dbjfgxSgS4Z2wCYAusZ/cfgMQIQ1jIbsKbpYwrb
         moWFvy2IbTaM9xAcbL4ipwewwJ6477otK/3tVTSix77/HuHNaIimP2sjr7/C856xoHHM
         kfbOsx0aXU2H3LHH2Y/m/81MhHq20Z7Gw6NrcqTkIHFrsK8ybll/5JF2l/gbxR2r4cuP
         eqUDMd+5vImmg0W4V7mP2EXFn5qR9MGn6f2bMMp2axgkIprZfG1Zxf0arYiwbYSFXn01
         sFtg==
X-Gm-Message-State: APuU4Z8AenPsbo8fR6jaIey71eG1Tw8lvPK3lv+TVltSr9d3DX1aaTEw
	/CbcQZYbWoLaIqFKDWvE4ArBZFcUgeRUKztRZP8GhI3/mhNtiUJkHwBEGRJNgrHUMgA=
X-Gm-Gg: AZFdTZeMfHIaxi6MjErib0XgLbAapozgU2ABbPlQnXLEnUCj1/cXepK62U9uE9q2t9G
	lT4gJfgme9NI+mISt8EbSyTspMIEHnukZCAR5qBff8Wpfcw3jAGzmuaqIZltrkMATzGvzHcMhMV
	YAuZ3b424TJhw63g6/KvlmTDlPYIoAF2GWArRJZmo5qDMO2HbpB8hreYWtkwmjGWKxGi6xywh9e
	g6WrfSMhcff3Tn/cFOfhF1MJbUcrMpqewBhd0dBGDu+ARjYBGH+3BIO2BCc5B+msLH69E9Cqa+1
	MqFwaGBWg1Ha6gU0cmzZg41i39lHknQxm082z0Dbe0/GdekT1YQfZ500qQPj3KU1sL8ZN8Tzm/m
	rp9KIUW1iyKhUWIX4JsJ1AGSyC0QmlxlJE5+TP3bh6IwXDaYwn8Bb0A8xKYiM2Y6tSMbdUSCbsQ
	UsAjWPz34z3DvelcDYOUhvmX6EmrQz0IGH7+9nbYbK2z7sqlBqy6ydlWH8+Xw7mgep/hu1VE++2
	aYLcgipODww1+PHLZ7iS3A2VpoBtpbRb5YG0fFgbNO6gdlQGU3W49QPh/MnJYirehNVhmA9Qo6x
	fYh3YiZHIRKYL/VT8c0PLq5EwGV7oD1XJZEAT0AmY5FUHTo1hVwfhK0lrtXr22eF47/yHZBJMVI
	p+uFkHN+LmIhLSXJxv8bt
X-Received: by 2002:a05:7022:e80e:b0:1ab:de8b:5f0f with SMTP id a92af1059eb24-1b556924b07mr6161655c88.40.1795257764338;
        Sat, 21 Nov 2026 02:42:44 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm13290463c88.15.2026.11.21.02.42.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 02:42:43 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Sami Jawhar <sami@theorem.dev>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] combine-diff: do not show a patch for too many parents
Date: Sat, 21 Nov 2026 16:12:34 +0530
Message-ID: <20261121104234.98386-3-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121104234.98386-1-aniketgupta3001@gmail.com>
References: <20261121104234.98386-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The masks used to show a combined diff patch hold one bit for each
parent, plus two more bits for markers in the flags of a line. With an
unsigned long that is enough for 62 parents, or 30 where long has 32
bits. For a merge with more parents the shifts are undefined, so the
hunks are either missing or shown with the wrong columns, and nothing
tells the user.

Report an error instead and skip the patch for such a merge. Do not
die, so that a "git log --cc" through a history with a big octopus merge
is not cut short. The raw format does not use the masks and is shown
as before.

Add tests for the largest number of parents that works and for one more
than that. The first is skipped where long is not 64 bits.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 combine-diff.c           | 16 +++++++++++++++-
 t/t4038-diff-combined.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index 54d0aed6b2..414fec9cb8 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -136,6 +136,12 @@ struct sline {
 	unsigned long *p_lno;
 };
 
+/*
+ * The masks used to show a patch hold a bit for each parent, followed by
+ * the two marker bits described above.
+ */
+#define MAX_PATCH_PARENTS ((int)bitsizeof(unsigned long) - 2)
+
 static int match_string_spaces(const char *line1, int len1,
 			       const char *line2, int len2,
 			       long flags)
@@ -1491,6 +1497,7 @@ void diff_tree_combined(const struct object_id *oid,
 	struct combine_diff_path *p, *paths;
 	int i, num_paths, needsep, show_log_first, num_parent = parents->nr;
 	int need_generic_pathscan;
+	int show_patch;
 
 	if (opt->ignore_regex_nr)
 		die("combined diff and '%s' cannot be used together",
@@ -1515,6 +1522,13 @@ void diff_tree_combined(const struct object_id *oid,
 			       opt->line_termination);
 	}
 
+	show_patch = opt->output_format & DIFF_FORMAT_PATCH;
+	if (show_patch && num_parent > MAX_PATCH_PARENTS) {
+		error(_("cannot show a combined diff patch with more than %d parents"),
+		      MAX_PATCH_PARENTS);
+		show_patch = 0;
+	}
+
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
 	diffopts.flags.allow_external = 0;
@@ -1616,7 +1630,7 @@ void diff_tree_combined(const struct object_id *oid,
 		else if (opt->output_format & DIFF_FORMAT_CALLBACK)
 			handle_combined_callback(opt, paths, num_parent, num_paths);
 
-		if (opt->output_format & DIFF_FORMAT_PATCH) {
+		if (show_patch) {
 			if (needsep)
 				printf("%s%c", diff_line_prefix(opt),
 				       opt->line_termination);
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index fcf7333d7b..ad670d76db 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -151,6 +151,42 @@ test_expect_success LONG_IS_64BIT 'check --cc with forty parents, two losing the
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for --cc with many parents' '
+	blob=$(echo file | git hash-object --stdin -w) &&
+	result_tree=$(echo "100644 blob $blob	file" | git mktree) &&
+	many_trees= &&
+	for i in $(test_seq 1 63)
+	do
+		case $i in
+		2 | 40)
+			extra=common
+			;;
+		*)
+			extra=
+			;;
+		esac &&
+		blob=$(test_write_lines $extra file file$i | git hash-object --stdin -w) &&
+		many_trees="$many_trees$(echo "100644 blob $blob	file" | git mktree)$LF" || return 1
+	done
+'
+
+test_expect_success LONG_IS_64BIT 'check --cc with sixty-two parents' '
+	sixty_two_trees=$(echo "$many_trees" | sed -e 62q) &&
+	git diff --cc $result_tree $sixty_two_trees >out &&
+	# Check that the second and the fortieth column mark the line:
+	printf " -%37s-%22scommon\n" "" "" >expect &&
+	grep common out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'refuse --cc patch with sixty-three parents' '
+	git diff --cc --patch-with-raw $result_tree $many_trees >out 2>err &&
+	test_grep "cannot show a combined diff patch with more than [0-9]* parents" err &&
+	# The raw output has a colon for each parent and is still shown:
+	test_grep "^:\{63\}[^:]" out &&
+	test_grep ! "^diff --cc" out
+'
+
 test_expect_success 'setup combined ignore spaces' '
 	git checkout main &&
 	>test &&
-- 
2.54.0 (Apple Git-157)

