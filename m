Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B652940D
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507118; cv=none; b=TlhU8Z722/Fljj2CVIX3cj6R8ZMADFn9nSK0McbBq4PuPGp4plWAUFd4Av4LSw0KK8JK1NZkgJyKsMLbqtWBEMM9lYWZ3naGHU5+36mXr0v4GFM1oXJ+33kOedoozgcs1tuOSdKyR24c+HiFa0wqic+oBH0ACuQOJQGoz/vyn44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507118; c=relaxed/simple;
	bh=znRJIFqsaQGRq5AoGO5DCZWp5n3JssYOkEUmmHCVaHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgZyy1OO8Yqq0PRzBKWINSByVk/n+SUF8dSgOqDqXUzrCJj+Pt29TCR2saEYrJxBMTN6LX+PpI36Yr02ZDpPyERKT6EjfA8G99Yy1xpX5KS9YzEcSWWGeYKCEfAd4OEeqOpteaxhWoqIZlSSYwe6dEvebbdOv2xw1T9MyfjQP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYKL79RQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYKL79RQ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32ae75801c1so4229951fa.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749507115; x=1750111915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3K3Qs5wEWZ3iLHv/34GbF1QA5faMnPzDD/CVLP2RDA=;
        b=VYKL79RQ2kvletF1f61KyJeimDf6/+3GldpG02M5o0nZQUmWrfMxsunH5dPg9V6klH
         jhlFiXVSxBeEMh2VFDDL1KFRNDnA0pv/gygDlr72NZDIZLf22Eh6+VM6LAtHVtFcQaFE
         aBMcm2nYjUfauu5IsreUAaFBpMMZMtZG+q58Qt3llS9fBaTsQLtLtUbr27mMNzVx63AJ
         VZe3GI5a+4Otms/9J+ybkWaHbF7cl2m17uINAJEthGH0ZWNV5cKXKu2lORvaO96LdS1a
         lHERbhhm/CbEok3oIXO8pvj86jNr/JxNWSEt/vcCc/IBIuHpFRaV8EV0BtsnfdBZ23NW
         yyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749507115; x=1750111915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3K3Qs5wEWZ3iLHv/34GbF1QA5faMnPzDD/CVLP2RDA=;
        b=i9UG0xs90a5ph4/7AiPubEEAkyIUZFEz1o7IQeHpEeImGKQdt66jIBKviY1EkP2z9Z
         GektxdnVKk7f48meu5Fopg8peyEcCM0suhKfnp+ExatojR5hnQCRB2KcNVW3Ja9eg+uq
         wJ12n8zhrqQeYrbpkT2PfZL6B+kfFfPJWMyjo87OOSkmSm9pMKtgexHB0cz240JcQJEN
         A+c6BW79Aoyvlei1EjdsZp7IrjfJmBlBmzONbgv83LtgkZ6vjEFpx9qssyMD6tr1HJu1
         Ydlf0IkCKO5aJqA3B4iyBanCRaYYBLrZmD1U3zmF9eFsSvDOudbnlFIlJus65CbD32pz
         Gplw==
X-Gm-Message-State: AOJu0YwBvshZsnBWfxG6VZyGrEhxatJABDZ4XZBcTK8/WtySj3KNTKqa
	lZvT5Qn9Ia23gZsV/LWDWdl95NR+TcaucV8yHY/rl7ArhU2gAUAqFOdi3FKxrQ==
X-Gm-Gg: ASbGncuH8dlzDKejM34M7sKWVHmXKlg/lIoXKjPMzpujeKL5lCYlXdab+5XhWosMiB/
	27xeK2l7Z1V16+lQ7dxS41YsGAs3ShfsoJTIf91Xf3A96kbslXgM2CsNwlr0a49pDfUlfGps2Fc
	lNDd2dhgQNo7/wbhxkvwu1nLm3u+O0lBnU2ClWhuWk7jBj5sancuGLnd/r3HD/+eS1aVXArQc4X
	Xf32yOUz6Vr5Rc/sJqQVVnbmok25LnDeqDwAeInA8y4NYMFwNoGAPJ95lVzmKoHn1KBIHku5xvE
	iCMnBlTlwr/fhaIo0QlzDxQL+k0ziPDMBpyTbpgaQylah8pa5ro8cg/G1C1Nf1RouQIE
X-Google-Smtp-Source: AGHT+IEzN4Nw5ySD9x2kr7HItm3ZCwMGQzRYleAKEqQ7vhJWviO1mdjrU7adrhSPgTRtwkM1YvUfbA==
X-Received: by 2002:a2e:b892:0:b0:308:f479:56a2 with SMTP id 38308e7fff4ca-32adfa30e0dmr14149691fa.0.1749507113819;
        Mon, 09 Jun 2025 15:11:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:1b88:a3c1:4d31:4a93])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1cccab7sm12731461fa.86.2025.06.09.15.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:11:53 -0700 (PDT)
From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] rebase: write script before initializing state
Date: Tue, 10 Jun 2025 00:10:55 +0200
Message-ID: <20250609221055.136074-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If rebase.instructionFormat is invalid the repository is left in a
strange state when the interactive rebase fails. `git status` outputs
boths the same as it would in the normal case *and* something related to
interactive rebase:

    $ git -c rebase.instructionFormat=blah rebase -i
    fatal: invalid --pretty format: blah
    $ git status
    On branch master
    Your branch is ahead of 'upstream/master' by 1 commit.
      (use "git push" to publish your local commits)

    git-rebase-todo is missing.
    No commands done.
    No commands remaining.
    You are currently editing a commit while rebasing branch 'master' on '8db3019401'.
      (use "git commit --amend" to amend the current commit)
      (use "git rebase --continue" once you are satisfied with your changes)

By attempting to write the rebase script before initializing the state
this potential scenario is avoided.
---
The diff looks perhaps more messy than required. The only required
change is the filling in of make_script_args and the call to
sequencer_make_script() above the call to init_basic_state(). But then
the `if (ret)` looks out of place, and moving that up means adding `goto
cleanup` which means the code that was previously the else case can be
dedented.

get_commit_format() calls die() in this case, so cleaning up the
sequencer state isn't an option. Maybe it shouldn't call die in the
first place, but that looks to be much larger change.

 builtin/rebase.c             | 42 ++++++++++++++++++------------------
 t/t3415-rebase-autosquash.sh | 10 +++++++++
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e8c4ee678..8139816417 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -293,15 +293,6 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 				&revisions, &shortrevisions))
 		goto cleanup;
 
-	if (init_basic_state(&replay,
-			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, &opts->orig_head->object.oid))
-		goto cleanup;
-
-	if (!opts->upstream && opts->squash_onto)
-		write_file(path_squash_onto(), "%s\n",
-			   oid_to_hex(opts->squash_onto));
-
 	strvec_pushl(&make_script_args, "", revisions, NULL);
 	if (opts->restrict_revision)
 		strvec_pushf(&make_script_args, "^%s",
@@ -310,21 +301,30 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.nr, make_script_args.v,
 				    flags);
-
-	if (ret)
+	if (ret) {
 		error(_("could not generate todo list"));
-	else {
-		discard_index(the_repository->index);
-		if (todo_list_parse_insn_buffer(the_repository, &replay,
-						todo_list.buf.buf, &todo_list))
-			BUG("unusable todo list");
-
-		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto,
-			&opts->orig_head->object.oid, &opts->exec,
-			opts->autosquash, opts->update_refs, &todo_list);
+		goto cleanup;
 	}
 
+	if (init_basic_state(&replay,
+			     opts->head_name ? opts->head_name : "detached HEAD",
+			     opts->onto, &opts->orig_head->object.oid))
+		goto cleanup;
+
+	if (!opts->upstream && opts->squash_onto)
+		write_file(path_squash_onto(), "%s\n",
+			   oid_to_hex(opts->squash_onto));
+
+	discard_index(the_repository->index);
+	if (todo_list_parse_insn_buffer(the_repository, &replay,
+					todo_list.buf.buf, &todo_list))
+		BUG("unusable todo list");
+
+	ret = complete_action(the_repository, &replay, flags,
+		shortrevisions, opts->onto_name, opts->onto,
+		&opts->orig_head->object.oid, &opts->exec,
+		opts->autosquash, opts->update_refs, &todo_list);
+
 cleanup:
 	replay_opts_release(&replay);
 	free(revisions);
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 26b42a526a..5d093e3a7a 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -394,6 +394,16 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
 	)
 '
 
+test_expect_success 'autosquash with invalid custom instructionFormat' '
+	git reset --hard base &&
+	test_commit invalid-instructionFormat-test &&
+	(
+		test_must_fail git -c rebase.instructionFormat=blah \
+			rebase --autosquash  --force-rebase -i HEAD^ &&
+		test_path_is_missing .git/rebase-merge
+	)
+'
+
 set_backup_editor () {
 	write_script backup-editor.sh <<-\EOF
 	cp "$1" .git/backup-"$(basename "$1")"
-- 
2.43.0

