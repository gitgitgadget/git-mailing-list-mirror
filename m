Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FE31E857
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741128; cv=none; b=jEqHqnc2KX8g9SYBo7X7cQNgJB1HTquHJ0JVU2hMJlDB6yz3wBwgNTn2B7ZXIRUFZwPXNO5Z2JG/A7aaJxSE1Ke6plOSpZh5DhkyLTJTeg9GLgS0VbTYgFtpIsca7bFKhEuvzLevmpTF01WeAgJMJ1vJ7Tv6E/qXf9UYGJswasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741128; c=relaxed/simple;
	bh=AGTjJ4njci0zupOax4HlTN8H8ZTcyOe06xZxp9ThD4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lOvz6funitJwkEVmM70JSVx/k6ccv5AhvA8MGZ28C7XGsgGuXKCSSU31awbxKNaFe5He+lI5NcTIR7Wr/2rTB8lkMrBkimyfecBokHGCtt4M3Jl1YLC0CJxVApEkCMCl5Hte2hmYFefMdJ6NKvcKmPDVbqfpYtakt7gnRJmvMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJUZ1zBN; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJUZ1zBN"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-44856d185bcso820643fac.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787741121; x=1788345921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8TXffpdy1uCzS0D+NJX+pRwVVNoIqRCcs3ObM3P0mkw=;
        b=IJUZ1zBNbEZfHBF4Aui5Jy9hbR9nvkTyduV+XrLKabgaUJw1d6Gbp09pel+es1+W23
         EYOjD8OkwRNP61wEayLcLXAayEnFjSg0Z+BtCkZO/8rQ2qqQLh3jHGaanj+RsUCVzVTW
         0+E6q0nEf8Hg2OZzSrYtn7Z7Q3UJ+8x1SfXQvq3F6R83uGsTtGRgK6LjXnmkwvUZuKjw
         TrpBsCMPIlgO0iZ7i5FwjXQq5SDbhpFXF2Jxzla+imIclOPgNW7rX+w8wmtLWLMWB9JU
         Ei6dmyb4I3DiNJo3I8mRC/v/BAN7xQ/QAT/ENMPHx3bkB6WhdSQYS/w8xoC046eq1Aut
         /MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741121; x=1788345921;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8TXffpdy1uCzS0D+NJX+pRwVVNoIqRCcs3ObM3P0mkw=;
        b=pKy1aE6inCW4arxJgq/13qnYcp6ENki590L6jeMrUh2UHkf0zLTsz9llkk2pgm0NAF
         mj75gHRfPiIbgvZNkbRgJRsc8ujqCQYj4Iz7rtkZDgMPUa249bb0tfmCSLPH/331LYBQ
         cw4dr+nbXVcel6xCbwMoRK/9E4unVIDaoML5O7UO3vaHit5w86qf9RAw32xt3yrOWNPD
         3K3HiHwAWTSBVdTuyWYa8uFqeRVaThOIjoxO50jMnF4L+aWYlnBfYrjhsx8/nf0RwP+e
         Mru0KWQguhi4PqxZuyaAXjWoMJj76x8VLHsoZsQHNWPZbd6eaPoWEZi3iMumM1EjEktj
         acqw==
X-Gm-Message-State: AFuF++nsKdFlWybbUDzliXpZ4/WJXeTb6QZEiBY0PGf8LlEmu6pb8fc4
	6viLVHUursxgWUbeAoI4XryZkl3ykNu1D4H57A8NTpnZgFauuAfRvDdTv8L7cSYN
X-Gm-Gg: AR+sD12r+TaAi74v1agzl5LIBpLU4r/GhVfVh+hAPe18aCtGcqI0dqd/CXwXrU6IhhY
	IAjCySUkt91kdLYo3yOk8Aep13qcOAu0W0vzXhEuhUWo7OAoueFqWz4BdgUuafL1tipDkOYZ8BA
	vidHq3X1+lZfI5DWz66cGf2VIDCQnak4RlPu1mP+2XOOAWxpzZWMDYZ9khOAYhWjTyRyzQfchH5
	Xt8o9ZehAoxREu2I3oFn+5S0nFg30HGDXFznQiojEDsEFlvLWs57SxfxIBO1IJtbaMkK3p4gVLF
	/wVl7USHlKES6041vWYZUkec5cnav02IVYF8tGXMuWgpYb060Dc81gAnJ3eBDc4niPOkFaRVTd3
	WIkvAViCjEv6Rw3QLHixIbveqz6mnnINgDLpyOsRzWX34YOf8fF0feGkvwBk2Le5B7TiGSME2sl
	xzjuosOlTp9tLg6YxTh3g29wAj3725iGuCMGMnRAHBLXXuDxfPt4kJ6hWwvfCjizg5NPGQ56k/m
	Q==
X-Received: by 2002:a05:6871:c8d2:b0:442:175:cea9 with SMTP id 586e51a60fabf-465986ee91bmr6261339fac.7.1787741121301;
        Wed, 26 Aug 2026 03:45:21 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.19.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465ad9f3711sm1907771fac.3.2026.08.26.03.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:45:19 -0700 (PDT)
Message-Id: <1010ac32958dffab2b23f636305fe8de7fb5bba2.1787741111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 10:45:09 +0000
Subject: [PATCH v9 3/4] worktree add: improve message for ambiguous remote
 branch name
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
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git worktree add ../foo-dir bar-topic' without
specifying a remote, and there is no local branch named bar-topic, we
try to guess which remote branch bar-topic refers to, then create a
new branch named bar-topic that tracks the remote branch.

If multiple remotes have a branch named bar-topic, we silently gave
up, leaving the variable 'branch' intact.  We then entered the
conditional clause 'if (!opts.orphan &&
!lookup_commit_reference_by_name(branch))' and triggered an "invalid
reference" error.  This error message did not provide enough
information to resolve the ambiguity.

When multiple matching branches are found, display a hint and a
descriptive error message and die immediately.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/worktree.c      | 37 ++++++++++++++++++++++++++++++++++---
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 22c8e5e131..c745deddde 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -764,6 +764,25 @@ static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
 	return 1;
 }
 
+static void advise_disambiguating_remotes(const char *path, const char *branch,
+					  const struct string_list *matched_remote_names)
+{
+	struct string_list_item *item;
+
+	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
+		 "<remote>, you can do so by:\n"
+		 "\n"
+		 "    git worktree add -b %s %s <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
+		 "consider setting checkout.defaultRemote=origin in your config."),
+	       branch, path, branch);
+}
+
 static char *dwim_branch(const char *path, char **new_branch)
 {
 	int n;
@@ -898,17 +917,29 @@ static int add(int ac, const char **av, const char *prefix,
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2) {
-		struct object_id oid;
 		struct commit *commit;
-		char *remote;
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL, NULL);
+			struct object_id oid;
+			char *remote;
+			int num_matches = 0;
+			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+			remote = unique_tracking_name(branch, &oid, &num_matches,
+						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet &&
+				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+					advise_disambiguating_remotes(path, branch,
+								      &matched_remote_names);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
+			string_list_clear(&matched_remote_names, 0);
 		}
 
 		if (!strcmp(branch, "HEAD"))
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual
-- 
gitgitgadget

