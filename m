Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8B25B0A3
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270528; cv=none; b=ItmYTRBOF7dCSih8fAcSiFiXYVoGW6ihy5NYTOjKQcUIKZqK9t/s8DaiinJv/w9LNbgecbe4Zw/gcCoSpjDWQyWkLBdjWvGakIUXXezM3/uVpL3v0WbSGBx4MfpXqY9nyx70TyLGtBO7i/6t8REDuklB02wvF9A8LHXcTZPE/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270528; c=relaxed/simple;
	bh=Ypm5uPEGSrfJ9sdmNC7tYM1wGaBMb0T5XWjntFf0T94=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oXE6quoTWB/IeBj4s7gKaHjHGrkukj/JbuxwD74WfGTg9N0qB3w2TmL1fr0eftcjgGeJPG4/CpbmJD7628Km742Qr+D7hlJX3hZYrWzj+o/0l8Vfppp50wz3aKCNCp80TjBHkg/QI5D+HLJOdMQmE+pPTOJs64+BIyso5IjML+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVumu+sa; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVumu+sa"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-49dd13a91d0so748367fac.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270525; x=1791875325; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zd+qFyu3wqDwzB2pVsatC99nnJ+n9opHFVUzUepzXaY=;
        b=eVumu+sadSNiWXvuM1B+vaZzp+I9HPkh1yLivXoCw2kqd02hGEHOGL4vzYEILjNe5z
         PTABnKeCg0RrY9NywHryVTjwtT8oDw7q+QbynjfNjywz8ae0tozRxUMMNJ98lnllLloI
         N7VunbJXfLiPN4ZPRd98C2PBUdggvJ/wflMEUnK+FwEq3SRyDEJdvWKCcIhudc//ntqj
         FnqyMp4jl7hdOqXFllUA/rXqFyzIcThZHE0VyWUEDG+ZDSLCGQMm4f9dUv8LPf9jFVn9
         kTcAxDRj7kegcWvdqzV+hTKZs6AeDwCsnz1Z5fB0FhfQUStsUnCcRZl5U7DZTle15PvK
         8GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270525; x=1791875325;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zd+qFyu3wqDwzB2pVsatC99nnJ+n9opHFVUzUepzXaY=;
        b=Nby66/ECOo7QyOO6vZ8TtwMmfHaWmJQ1HreHouLZbKTZJBb9xQPvkjst6a16o2sfrh
         QHCg+PTBovSe/RPqIDUpvX4uUqFr/mss7vVkbOlrVI//XZimG7cCNT9FGOUK2uYKxsj6
         DsRTHUb/FalFS7hGHljYjf0veQ6rHmtvhECi8FDTbv+w5IJWklp/rwuN3xB3Ps1cmjy9
         xGtzdOnXcZVCy/XxaH4nk9yUVeQmulim/pdixGHb/MTuNhwg2o/C1BhfTw40+XNACQcc
         hAUSHyNl9B+MAuV5KnNz8NuTvW9Z0nG146Xv7C9ssWVaCTdcZNO5t83UjZ0n8jM0vTOL
         3tPw==
X-Gm-Message-State: AFq9FYIq/M/f7fhCy3qBkxEz8yeCG+QReEKCPu5opdA3BVuMVqMIBcIL
	uhWxuUZ0w2ugnlSqI+RvtUILa4npkQFGoLNHUUFazVz87rE1UgnqQXaTsS2LW9OD
X-Gm-Gg: AYBFou3YWr7o0G7keYfPO+kwKhDG5QLo4VlTI1Ri9TM4MZmU2HSRnfWC90om1ZoONxD
	i4gyGu0u6xoRvjiZd3mYO5pVngPA1Br8Z2ricwP58mcV0sSaDsYI03l4exZpWW1kTJJ0F2kLEHz
	ZgzX3LR264wVQgW8hHDO5Dy0w4Xq8KG4KcA6O8ldjDL5gS8uzcHhWFrfQWGBnkYV/qNq5/FFWYN
	lEIFbfaAsKZ1j2u7pL/Cwdn3BQhXgh38RH1L20IRX4ENy/7QaSsMZAriiUlzvhoPh+eY8njtnhF
	BBfQmk8x0WKe53zyHpMizpbQMXZ4bz31Ol8asgswPZxm6GeuaL2hiKrF8ishqGg8q/NCZlQCVyH
	vmDQ3KEjLO6wOS1mzrwcUOqIOXXojN2gg0zxWj64RfdJrVkOXkIIzZ2LkFlj367ZbwakDyAAgzt
	bvWTwZQtRpW7/GqYLPbC6Se0/HjRlGeUc+YXPpATxXTB6Z4L4T+9dlxu8FrbQAjAsqjVrY1DWvw
	JU=
X-Received: by 2002:a05:6871:5214:b0:475:e235:904 with SMTP id 586e51a60fabf-4a2404eb525mr371545fac.34.1791270525171;
        Tue, 06 Oct 2026 00:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16f4b59fsm11456154fac.16.2026.10.06.00.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:08:43 -0700 (PDT)
Message-Id: <78571ebf5fb578852f8bae35fbf7cb3eb3a0bd46.1791270504.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:08:24 +0000
Subject: [PATCH 6/6] push: suggest a force push after a clean rebase
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

After rebasing pushed work onto a newer upstream without changing it,
"git status" says the branch was rebased cleanly, but a rejected
"git push" still suggests pulling from the push branch, which would
only bring back old copies of the same commits.

When the commits outside the upstream carry the same changes on both
sides, say what "git status" says and suggest only the force push:

  hint: Updates were rejected because 'origin/topic' has diverged
  hint: from your current branch, which was rebased cleanly on 'upstream/main'.
  hint: Use 'git push --force-with-lease origin topic' to replace it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/push.c           | 20 +++++++++++++++++---
 remote.c                 | 17 +++++++++++++++++
 remote.h                 |  6 ++++++
 t/t6040-tracking-info.sh | 25 +++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d918723d43..bf6e5386a0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -301,6 +301,11 @@ static const char message_advice_pull_from_branch_before_push[] =
 	   "from your current branch. Use 'git pull %s %s'\n"
 	   "to integrate the remote changes.");
 
+static const char message_advice_force_after_clean_rebase[] =
+	N_("Updates were rejected because '%s' has diverged\n"
+	   "from your current branch, which was rebased cleanly on '%s'.\n"
+	   "Use 'git push --force-with-lease %s %s' to replace it.");
+
 static const char message_advice_pull_or_force_before_push[] =
 	N_("Updates were rejected because '%s' has diverged\n"
 	   "from your current branch. Use 'git pull %s %s'\n"
@@ -356,15 +361,24 @@ static void advise_pull_before_push(struct remote *push_remote,
 		tracking_name = refs_shorten_unambiguous_ref(
 			get_main_ref_store(the_repository), tracking, 0);
 
-	if (tracking && (reject_reasons & REJECT_NON_FF_HEAD_REWRITE))
+	if (tracking && branch_rebased_cleanly(branch, tracking)) {
+		char *upstream_name = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), upstream, 0);
+
+		advise(_(message_advice_force_after_clean_rebase),
+		       tracking_name, upstream_name,
+		       remote->name, branch->name);
+		free(upstream_name);
+	} else if (tracking && (reject_reasons & REJECT_NON_FF_HEAD_REWRITE)) {
 		advise(_(message_advice_pull_or_force_before_push),
 		       tracking_name, remote->name, branch->name,
 		       remote->name, branch->name);
-	else if (tracking && (!upstream || strcmp(tracking, upstream)))
+	} else if (tracking && (!upstream || strcmp(tracking, upstream))) {
 		advise(_(message_advice_pull_from_branch_before_push),
 		       tracking_name, remote->name, branch->name);
-	else
+	} else {
 		advise(_(message_advice_pull_before_push));
+	}
 
 	free(tracking_name);
 	free(tracking);
diff --git a/remote.c b/remote.c
index af8d026073..623ff98a01 100644
--- a/remote.c
+++ b/remote.c
@@ -2391,6 +2391,23 @@ static bool stat_outside_upstream(const char *branch_name, const char *base,
 	return true;
 }
 
+bool branch_rebased_cleanly(struct branch *branch, const char *base)
+{
+	const char *upstream = branch_get_upstream(branch, NULL);
+	int ours, theirs, ours_unmerged, theirs_unmerged;
+	bool same_changes = false;
+
+	if (!upstream || !strcmp(upstream, base))
+		return false;
+	if (stat_branch_pair(branch->refname, base, NULL, &ours, &theirs,
+			     NULL, AHEAD_BEHIND_FULL) <= 0 || !ours || !theirs)
+		return false;
+	return stat_outside_upstream(branch->refname, base, upstream,
+				     ours, theirs, &ours_unmerged,
+				     &theirs_unmerged, &same_changes) &&
+	       same_changes;
+}
+
 static char *resolve_compare_branch(struct branch *branch, const char *name)
 {
 	const char *resolved = NULL;
diff --git a/remote.h b/remote.h
index cca02033b9..dd8ef6c443 100644
--- a/remote.h
+++ b/remote.h
@@ -408,6 +408,12 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf,
 			 int show_divergence_advice);
 
+/*
+ * Return true when the branch has diverged from base only because the
+ * work on base was rebased cleanly on the upstream of the branch.
+ */
+bool branch_rebased_cleanly(struct branch *branch, const char *base);
+
 struct ref *get_local_heads(void);
 
 /*
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index b53034ba36..b5339e1452 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -804,6 +804,31 @@ test_expect_success 'status.compareBranches after a clean rebase of the push bra
 	and have 3 and 1 different commits each (rebased cleanly on ${SQ}origin/main${SQ}).
 	  (use "git push --force-with-lease" to publish your local commits)
 
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual &&
+	(
+		cd test &&
+		test_must_fail git push 2>../push.err &&
+		git push --force-with-lease origin feature19 &&
+		git status >../actual
+	) &&
+	url=$(git -C test config remote.origin.url) &&
+	cat >expect <<-EOF &&
+	To $url
+	 ! [rejected]        feature19 -> feature19 (non-fast-forward)
+	error: failed to push some refs to ${SQ}$url${SQ}
+	hint: Updates were rejected because ${SQ}origin/feature19${SQ} has diverged
+	hint: from your current branch, which was rebased cleanly on ${SQ}origin/main${SQ}.
+	hint: Use ${SQ}git push --force-with-lease origin feature19${SQ} to replace it.
+	EOF
+	test_cmp expect push.err &&
+	cat >expect <<-EOF &&
+	On branch feature19
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is up to date with ${SQ}origin/feature19${SQ}.
+
 	nothing to commit, working tree clean
 	EOF
 	test_cmp expect actual
-- 
gitgitgadget
