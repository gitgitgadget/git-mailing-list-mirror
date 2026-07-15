Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D263480DF3
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128944; cv=none; b=CAosJ3rtJr4cwLHlnzhyVTM8NRQ0Cx46Wh37Rufnkt3PtUmQ+QGIymWNMpLV7c7nSNA9TQElTZ3CGEr7F9Sp0rovuRBfaIFcVOv/88x7CsaMmI1X5x+eO8HO6tmEGSaii/W5oqtxtuGr4CsUQw/dceOGDROhOdVdd3CZL32W8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128944; c=relaxed/simple;
	bh=N7D8OBpqHQPyu/hF/bqxYt3Y9ODFTbl5DSWT5lgjjrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+tYrktgTH+nJFqZzLtxCzTd6M/HCT0EqJ+qGobAX93z0/0by2WDnW8IGPgIMN98rui7Q68gks4Binn1VOIwFlsnEO8OK3pvMWyFP9f2ZDl/w3yPk8LQB0616/H9rxkSRQYC657++C3mc6j6hwtYZ6786hY9PeOBK1EbmuADjvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGkmcP0J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGkmcP0J"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f6de72faso12633175e9.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128941; x=1784733741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z+lrHLxxqvmPM5JXF1z86/MRGVzft+No7Ozkf6ncRYg=;
        b=pGkmcP0JDbb2ZBKw1t15nRI1dInflVC7tsjEhG7NPnWUh70p0PAj2kuTqmbZ3qHHXE
         PWmkjLL0cfVnedDznS4C436RCBjMwDhAjAkMbqIl3vhQTHfQpexuGeZF+QMM7EOhki63
         MdcXSfCuIvKWGJ1NjXtrNdoSsCUHAXacBSBiWP3669Ym4/l9idn0ZHFXkPQBaNseEN9A
         QFD62fV4BZDrDqwPDWV4ErcaJtqcgw9ypJX9mEg/5M7UqL+c73lT0jFbHJzrtOA/7yua
         3+Xk6TId48uly6UAgh6dX4RY4m2nF7jEXwwrJjryfa9waumt33wovdWvX9a53EVIyEz7
         Y9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128941; x=1784733741;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+lrHLxxqvmPM5JXF1z86/MRGVzft+No7Ozkf6ncRYg=;
        b=X9t+WhtoqNhim3o6YPcxAU5opvpu9e7wF+nJ0uTCXr02u/j6SpEOimF9kBymz0J54L
         gaVmV+UDiUNwpRugBYIMXkuO3nlvxSug79D1aJ3n8HXLpbNhHVC53q3AYeoEfJDg9JVL
         pjzb5OpptnuSn4yR+xfJ8Znxepndp5HVomaMK4irwpj9JdQXQZY7nPWjqqPaOEyAtloV
         47m9SwOpoGLRte/6iWyaP0gtiQtW07pFNRV4am7FHcF1sRN6/DAj7ZSbVJw4vWlMDENV
         z/emZGIpnAa9GD1VHUsFmRjTnOt4cImz9DE6HhukEPj85Bz/EaylBW5e8wBxZZ0YOtWU
         7u1g==
X-Gm-Message-State: AOJu0YzFm4+up6QkdEDJtmJUpEylKilsv41jHh8jdRC155m48qnXsSmx
	tItHtLBjjUpT4MD5Vzn4e+aFoyBX0l9ika34xamY+zhXVenjr3gnB5Y0WNI7bQ==
X-Gm-Gg: AfdE7ckf5cfRsLw/y7+2OfqaKcVRTBueLM45fcYswD4TIGL2TE+NW15pTSGcU0LCYte
	9w+B6CQ35gKgOXZZAAtA61cSPZd6KscfZLWjDg1SXZiAeIC3PZjD5BuGn+uIzuBe46zACZcrCrQ
	/W6Cm7ku9EF4vRaiowIZ16FS/3T3iNa7omucxqbRlcbGv+XxGmWmdHYnZgZ5U5CdgZGUa/n8LlB
	TM94OHaQkx3hswOwDm3JsgITRCkiML++EaNeVWvlPhoZY8xLN7no6OVewUchH/kIvdNTlWAC6oN
	T0ntdyoFtyAJWF+fjyVDgVLfRJ5EWo2f7SvdWDxvUJQA0qRPbGFwQryh1eZnF0j/gTy2m/aDbhA
	7HEdLPb7Q2HkAa0ByGSOp4KDSVz2CG6pScsZodsTmOY28wp4/UtQv8WurqzKJHL1FQ1LxhR7jz7
	0pzKg+JLyD4UMKqzRgKJTVS1Z/maU=
X-Received: by 2002:a05:600d:8496:10b0:492:6f5c:fd8c with SMTP id 5b1f17b1804b1-493f88c6d2emr131275145e9.15.1784128939901;
        Wed, 15 Jul 2026 08:22:19 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:19 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/9] sequencer: be more careful with external merge
Date: Wed, 15 Jul 2026 16:21:56 +0100
Message-ID: <947bb77e44f2087c5f148e887c280bb54d648b03.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1784128921.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If an external merge strategy cannot merge (for example because it
would overwrite an untracked file) it exits with a non-zero exit
code other than 1. This should be treated differently from a merge
with conflicts, which is signaled by an exit code of 1, because, as
the merge failed, we need to reschedule the last pick. The caller
expects us to return -1 in this case. Also reschedule without trying
to merge if the commit message cannot be written as that prevents us
from successfully picking the commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 19 +++++++++++++++----
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 57855b0066a..eaffa8ebb84 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2453,14 +2453,25 @@ static int do_pick_commit(struct repository *r,
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		res = write_message(ctx->message.buf, ctx->message.len,
-				    git_path_merge_msg(r), 0);
+		if (write_message(ctx->message.buf, ctx->message.len,
+				  git_path_merge_msg(r), 0)) {
+			res = -1;
+			goto leave;
+		}
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts.nr, opts->xopts.v,
+		res = try_merge_command(r, opts->strategy,
+					opts->xopts.nr, opts->xopts.v,
 					common, oid_to_hex(&head), remotes);
+		/*
+		 * If there were conflicts, try_merge_command() returns 1,
+		 * any other no-zero return code means that either the merge
+		 * command could not be run, or it failed to merge.
+		 */
+		if (res && res != 1)
+			res = -1;
+
 		commit_list_free(common);
 		commit_list_free(remotes);
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c271..297b84e60d5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1249,6 +1249,17 @@ test_expect_success 'interrupted rebase -i with --strategy and -X' '
 	git rebase --continue &&
 	test $(git show conflict-branch:conflict) = $(cat conflict) &&
 	test $(cat file1) = Z
+'
+
+test_expect_success 'failing pick with --strategy is rescheduled' '
+	test_when_finished "rm -rf bin; test_might_fail git rebase --abort" &&
+	mkdir bin &&
+	echo exit 2 | write_script bin/git-merge-fail &&
+	git log -1 --format="pick %H # %s" HEAD >expect &&
+	test_must_fail env PATH="$PWD/bin:$PATH" \
+		git rebase --no-ff --strategy fail HEAD^ &&
+	test_cmp expect .git/rebase-merge/git-rebase-todo &&
+	test_cmp expect .git/rebase-merge/done
 '
 
 test_expect_success 'rebase -i error on commits with \ in message' '
-- 
2.54.0.200.gfd8d68259e3

