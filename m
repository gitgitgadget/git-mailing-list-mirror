Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61077134AB
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760891441; cv=none; b=mDOFjEVGxEkcLr4UST3YT6WTbGoHwIxkkX8FQxjmIz39AZVtsf/td+rrUHK2JCtN/1ZxxeClqNtZjGsOlvv75Uo65ou5+wNwCnqblP925n+MMw2Cxp5n5MghtXDi6r5EM4aXOii/Z4JhZThOuNA9cJmdPRybmFEEIcAnTemhuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760891441; c=relaxed/simple;
	bh=Mw1RiJD5GOxgwrSNa/b78BA747COL93yRX8oiKE1qdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzhrOJBbMcW4Zd6YsXgvyClnRr3tP5jGa0Elh8puGadqiwU8VeJiSjM7Qhln9ESl2DvJD4EZEZGrfslv80HX0dLbdSRVC3nCT4ogtachfeFxA7h+qpseaQlfjssxRky9rXvUJg5MzXZUBnTAsG54sjKKx7gnE3f2DBDQ2NuaYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTjqXMiy; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTjqXMiy"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so2337689a91.1
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760891439; x=1761496239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/qfAS5iwhrtwaVelcUMvdDGKWuHJGeKmgFvy77Ck18=;
        b=LTjqXMiyNcH7KE5pv0gxHIeORGxbxdnANyzY+HY0R9taojGBtzlxpJB3nIAM/OHEyc
         zI94f4r/MrupYt2Ev0lVhLKrYvsjZbSrcSWR2q0jFb/OlCUyGjXGDgXlNXfrNBlDIyQ5
         A0QJzlmcQXfu8C08ot+QFdudEL0Mtm4wLLcWW+9ZU/8oI/GrvJDgzhngt0GZ7RcP7Vim
         BdAlEkcFt/dlQtB2/+J3Ito5JOnB59BygC0wccTf1CtsNBtc7dFF1gkXA9N+2Svc5Wh/
         1loeairWDsajX7C5lDOS73uCKfooTIJxf5AJ2RELPdnXEyJtD5F34y+8cQg8dwglqVjf
         IAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760891439; x=1761496239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/qfAS5iwhrtwaVelcUMvdDGKWuHJGeKmgFvy77Ck18=;
        b=p9igZySqtcpkSzcUZjVAsu+81ennZssniIvCdV+kTIkm6rQgs+J+W3ZLqR+eb38olZ
         JYGFEsrP4TRcpIJfVIWSqpzrnbSUOJKRZTz9iRDPTwtvkvp0EXh5vDCvIUepS5IvX3Ba
         kZjmqb88Wl446ay76BBxHKWx75IttGJd2D/8onXlrda/NDnl+n3H6lQQhMlxyiOI1WqB
         vHpnUWjbts/F5XCzl49NtVRXHFVCgdL1WNfx0/SGgvehbAADpHamXOsj13301x4vBdKI
         H2nzl+CZOolsUoUAqphxSOmSxA4VNOeYH3GLLMK0F3efaNtTPkJmC+4CIs81CpQwgE3N
         +4CA==
X-Gm-Message-State: AOJu0Yy31M9okWIdkkH6cmnO/HChs6jeyPQ8VpObl7De4JjpQM6rqfTD
	FnUG8tPpwfGoELccKgfk0Xt0HdDIzSYIsoawG2kYtGinHeD7SuloQ9JL
X-Gm-Gg: ASbGncuab8WDkGH9WeWz1JBMoUs/5UC4vCE9BXtCIqgpaZTrLFdMW0gsUu2wXYDjQRA
	7mBcW2V/3RsTe2AVpPpVGT1Qj3oN63wR3HpQlOap0wrYxd0CpAqavTv2qDaVetQgqvy49f7Jxxr
	DZ91EuBBNkHWYS7IO4Onk6JJBADukUHSQzFZK6U4oID/t/SqdjqS6NnLu8J/ypaPOYjy5UsqMju
	cnuAYTSsPDrdU703MuC6dfzT/4HOqVpmmyklzhCly2/Dfy4ag4Ih1sl2JAIlNG5W8urZF5QU2dh
	B/wUGmROEZkcW74SbOAomBiNpR6ozGyJgnh+3CQm3T6rDRBiXVSaY7LMFKmAFgq/24Al3e91nQp
	YUH/kwhbd58qEcSxJSndx3zF1OxVmzhD+QWbkKL45P1Kyr6Sh48jHPP7YfEKl48dLkx/TXm7dFE
	gHx+ihR7jUsyV+8JuZXHLDNbJsT+jAGnQUdzpFAcW4fs+TKZsuNfoWwnktMfo2ixwI
X-Google-Smtp-Source: AGHT+IEt+gDQGueihHC4WYQOGgxFCLJLwaZURkS3UCB/lKPZ1uE4GCSBf7gyTonrZVbijpVG7BhPLQ==
X-Received: by 2002:a17:90a:ec8b:b0:33b:b020:596a with SMTP id 98e67ed59e1d1-33bcf8744ecmr14668179a91.10.1760891439463;
        Sun, 19 Oct 2025 09:30:39 -0700 (PDT)
Received: from localhost.localdomain (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddeaea7sm5726428a91.3.2025.10.19.09.30.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 09:30:39 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	yldhome2d2@gmail.com,
	gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	jake@zimmerman.io,
	peff@peff.net
Subject: [PATCH v4] diff: stop output garbled message in dry run mode
Date: Mon, 20 Oct 2025 00:30:24 +0800
Message-ID: <20251019163024.18939-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251018094823.31173-1-yldhome2d2@gmail.com>
References: <20251018094823.31173-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier, b55e6d36 (diff: ensure consistent diff behavior with
ignore options, 2025-08-08) introduced "dry-run" mode to the
diff machinery so that content-based diff filtering (like
ignoring space changes or those that match -I<regex>) can first
try to produce a patch without emitting any output to see if
under the given diff filtering condition we would get any output
lines, and a new helper function diff_flush_patch_quietly() was
introduced to use the mode to see an individual filepair needs
to be shown.

However, the solution was not complete. When files are deleted,
file modes change, or there are unmerged entries in the index,
dry-run mode still produces output because we overlooked these
conditions, and as a result, dry-run mode was not quiet.

To fix this, return early in emit_diff_symbol_from_struct() if
we are in dry-run mode. This function will be called by all the
emit functions to output the results. Returning early can avoid
diff output when files are deleted or file modes are changed.
Stop print message in dry-run mode if we have unmerged entries
in index. Discard output of external diff tool in dry-run mode.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 diff.c                  |  8 ++++++--
 t/t4013-diff-various.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 87fa16b730..3c92f0d806 100644
--- a/diff.c
+++ b/diff.c
@@ -1351,6 +1351,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	int len = eds->len;
 	unsigned flags = eds->flags;
 
+	if (o->dry_run)
+		return;
+
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -4420,7 +4423,7 @@ static void run_external_diff(const struct external_diff *pgm,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
+	int quiet = !(o->output_format & DIFF_FORMAT_PATCH) || o->dry_run;
 	int rc;
 
 	/*
@@ -4615,7 +4618,8 @@ static void run_diff_cmd(const struct external_diff *pgm,
 		    p->status == DIFF_STATUS_RENAMED)
 			o->found_changes = 1;
 	} else {
-		fprintf(o->file, "* Unmerged path %s\n", name);
+		if (!o->dry_run)
+			fprintf(o->file, "* Unmerged path %s\n", name);
 		o->found_changes = 1;
 	}
 }
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 55a06eadb3..d35695f5b0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -661,6 +661,43 @@ test_expect_success 'diff -I<regex>: ignore matching file' '
 	test_grep ! "file1" actual
 '
 
+test_expect_success 'diff -I<regex>: ignore all content changes' '
+	test_when_finished "git rm -f file1 file2 file3" &&
+	: >file1 &&
+	git add file1 &&
+	: >file2 &&
+	git add file2 &&
+	: >file3 &&
+	git add file3 &&
+
+	rm -f file1 file2 &&
+	mkdir file2 &&
+	echo "A" >file3 &&
+	A_hash=$(git hash-object -w file3) &&
+	echo "B" >file3 &&
+	B_hash=$(git hash-object -w file3) &&
+	cat <<-EOF | git update-index --index-info &&
+	100644 $A_hash 1	file3
+	100644 $B_hash 2	file3
+	EOF
+
+	test_diff_no_content_changes () {
+		git diff $1 --ignore-blank-lines -I".*" >actual &&
+		test_line_count = 3 actual &&
+		test_grep "file1" actual &&
+		test_grep "file2" actual &&
+		test_grep "file3" actual &&
+		test_grep ! "diff --git" actual
+	} &&
+	test_diff_no_content_changes "--raw" &&
+	test_diff_no_content_changes "--name-only" &&
+	test_diff_no_content_changes "--name-status" &&
+
+	: >actual &&
+	test_must_fail git diff --quiet -I".*" >actual &&
+	test_must_be_empty actual
+'
+
 # check_prefix <patch> <src> <dst>
 # check only lines with paths to avoid dependency on exact oid/contents
 check_prefix () {
-- 
2.50.1 (Apple Git-155)

