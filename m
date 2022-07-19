Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74449C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiGSSeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiGSSeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C625C9FF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:34:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c22so1301370wmr.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oDTEvPcVWKPtgQDp+Kz23rFft4+tqEdSecqk4vR4/N4=;
        b=gdUcNGdDUUVLlhXvsMdPItZGdwiADc9RZEIKZZHuQ6fkc6MeRwkvhafBBdmS/j/pIP
         PaFf9ir4DWTIoNyV3tIgFPL/gbSoCkik5ySxN538L5uEkKPgU5FtuEHl0i8s9okUAi1E
         l+R44HITgcEZ+Pe2ZWG54W1J5082OMzWuMHEwzN46XBvhvTO68B4GEQTeSa70PPHIiSf
         fCSzJcWOBG5vfgnKzlsncpRkoJdiUfSMmJvge+IoxLccvVfLmqjWB+weXIFIb5nZUpPh
         qFJln8xiPN5IF7miTVbbayxKEjSgZ4LLoslPqJbQAkTe1xypue6ZeTe0IFSS69KoCYs9
         qe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oDTEvPcVWKPtgQDp+Kz23rFft4+tqEdSecqk4vR4/N4=;
        b=fwyuhHtgi9zRIhRyaeCN7t317FjI1/mFTHumM4Fw/DeTz8wTbXUmM6GLWER2v+Nmxv
         iiaagW52cXMaBJ+sv8hKHLdTUsoZT/9AuY6ypuHg+AwI8KfQjfO/tUe0zWe6IVj5t1cK
         P8pKd9AhHSTOuZhYfjuuHLff8yyCDq0buIjPiM4fbGpffbeSAwdwNyB1TeF4UPOyYu6K
         qOokcgZl6OTwYuOW+2v/Y3H5G044IPbNU4PuJj+SsZyEGAl6WOaBDQIyReGNES2Ovn1Z
         vcw9aoZIRtja95Drjz6tObs/snKLQHdu0so20D4YXRCqvsTrOpxABHFuqO7wSv1273lK
         EoMw==
X-Gm-Message-State: AJIora9j0vZPJ8FjclgQosX2B2dylPAXP7SIbP2kDkiqC4lc3HRQvMds
        F+N1BXUMaESsIi4Q11Y2iTLTOvyZxFE=
X-Google-Smtp-Source: AGRyM1tyfaiSUtzcDgEk7izVMiy6BhIRYcFPAj4RA8pZX+2fPEhNv66VqEIZjspWPhfMWtFoaAxJrA==
X-Received: by 2002:a05:600c:4e07:b0:3a1:8548:4dd7 with SMTP id b7-20020a05600c4e0700b003a185484dd7mr569578wmq.170.1658255642221;
        Tue, 19 Jul 2022 11:34:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t64-20020a1c4643000000b003a30c3d0c9csm16105378wma.8.2022.07.19.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:34:01 -0700 (PDT)
Message-Id: <ec080ce1e90c2593a7d2f44e2cc1655aad5756eb.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:44 +0000
Subject: [PATCH v5 12/12] sequencer: notify user of --update-refs activity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When the user runs 'git rebase -i --update-refs', the end message still
says only

  Successfully rebased and updated <HEAD-ref>.

Update the sequencer to collect the successful (and unsuccessful) ref
updates due to the --update-refs option, so the end message now says

  Successfully rebased and updated <HEAD-ref>.
  Updated the following refs with --update-refs:
	refs/heads/first
	refs/heads/third
  Failed to update the following refs with --update-refs:
	refs/heads/second

To test this output, we need to be very careful to format the expected
error to drop the leading tab characters. Also, we need to be aware that
the verbose output from 'git rebase' is writing progress lines which
don't use traditional newlines but clear the line after every progress
item is complete. When opening the error file in an editor, these lines
are visible, but when looking at the diff in a terminal those lines
disappear because of the characters that delete the previous characters.
Use 'sed' to clear those progress lines and clear the tabs so we can get
an exact match on our expected output.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c                   | 40 +++++++++++++++++++++++++++++------
 t/t3404-rebase-interactive.sh | 37 ++++++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1602649332b..96e1d58ede8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4261,26 +4261,54 @@ static int do_update_ref(struct repository *r, const char *refname)
 	return 0;
 }
 
-static int do_update_refs(struct repository *r)
+static int do_update_refs(struct repository *r, int quiet)
 {
 	int res = 0;
 	struct string_list_item *item;
 	struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
 	struct ref_store *refs = get_main_ref_store(r);
+	struct strbuf update_msg = STRBUF_INIT;
+	struct strbuf error_msg = STRBUF_INIT;
 
 	if ((res = sequencer_get_update_refs_state(r->gitdir, &refs_to_oids)))
 		return res;
 
 	for_each_string_list_item(item, &refs_to_oids) {
 		struct update_ref_record *rec = item->util;
+		int loop_res;
 
-		res |= refs_update_ref(refs, "rewritten during rebase",
-				       item->string,
-				       &rec->after, &rec->before,
-				       0, UPDATE_REFS_MSG_ON_ERR);
+		loop_res = refs_update_ref(refs, "rewritten during rebase",
+					   item->string,
+					   &rec->after, &rec->before,
+					   0, UPDATE_REFS_MSG_ON_ERR);
+		res |= loop_res;
+
+		if (quiet)
+			continue;
+
+		if (loop_res)
+			strbuf_addf(&error_msg, "\t%s\n", item->string);
+		else
+			strbuf_addf(&update_msg, "\t%s\n", item->string);
+	}
+
+	if (!quiet &&
+	    (update_msg.len || error_msg.len)) {
+		fprintf(stderr,
+			_("Updated the following refs with %s:\n%s"),
+			"--update-refs",
+			update_msg.buf);
+
+		if (res)
+			fprintf(stderr,
+				_("Failed to update the following refs with %s:\n%s"),
+				"--update-refs",
+				error_msg.buf);
 	}
 
 	string_list_clear(&refs_to_oids, 1);
+	strbuf_release(&update_msg);
+	strbuf_release(&error_msg);
 	return res;
 }
 
@@ -4800,7 +4828,7 @@ cleanup_head_ref:
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
 
-		if (do_update_refs(r))
+		if (do_update_refs(r, opts->quiet))
 			return -1;
 	}
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1a27bb0626d..688b01e3eb6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1840,12 +1840,26 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_commit extra2 fileX &&
 	git commit --amend --fixup=L &&
 
-	git rebase -i --autosquash --update-refs primary &&
+	git rebase -i --autosquash --update-refs primary 2>err &&
 
 	test_cmp_rev HEAD~3 refs/heads/first &&
 	test_cmp_rev HEAD~3 refs/heads/second &&
 	test_cmp_rev HEAD~1 refs/heads/third &&
-	test_cmp_rev HEAD refs/heads/no-conflict-branch
+	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
+
+	cat >expect <<-\EOF &&
+	Successfully rebased and updated refs/heads/update-refs.
+	Updated the following refs with --update-refs:
+		refs/heads/first
+		refs/heads/no-conflict-branch
+		refs/heads/second
+		refs/heads/third
+	EOF
+
+	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
+	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
+		<err >err.trimmed &&
+	test_cmp expect err.trimmed
 '
 
 test_expect_success 'respect user edits to update-ref steps' '
@@ -1983,8 +1997,23 @@ test_expect_success '--update-refs: check failed ref update' '
 	# the lock in the update-refs file.
 	git rev-parse third >.git/refs/heads/second &&
 
-	git rebase --continue 2>err &&
-	grep "update_ref failed for ref '\''refs/heads/second'\''" err
+	test_must_fail git rebase --continue 2>err &&
+	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
+
+	cat >expect <<-\EOF &&
+	Updated the following refs with --update-refs:
+		refs/heads/first
+		refs/heads/no-conflict-branch
+		refs/heads/third
+	Failed to update the following refs with --update-refs:
+		refs/heads/second
+	EOF
+
+	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
+	tail -n 6 err >err.last &&
+	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
+		<err.last >err.trimmed &&
+	test_cmp expect err.trimmed
 '
 
 # This must be the last test in this file
-- 
gitgitgadget
