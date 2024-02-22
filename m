Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125511332B7
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608118; cv=none; b=GAjUjrb44Q+Pt4v2EchmJkmec5mMr0ofwuxdi5zB1vhd1eKEIHv+9YEX9AwZfv/vHx652KLplSzWwv84ZwDYp4smWUJ1jt6P2oIeYyrw9kBME1/WC7ffwlo7IRZZbZVWtHMRtmTy/qbYWLbJssDfxEtW02OxeQCv4oVHmkuF/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608118; c=relaxed/simple;
	bh=24cqd6BppGjFm/VaiCvgn/CeewR+GmS1eJySW1bPu8w=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I5c9Sangyj/Ef2XBN02/EE+P0deMFvTjSKfS5SFo/UecFsx36wuc0aoWEBwwblVac5OATNOtlk7GDrJ/AyDffOObXaDn7+hcknru7wGQRpo9kwS6B/EPyau08ypaFlkp2XgH/FVMwn3LhdnCAjVsmznbl6T34DL2i/0v9bvlN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf2kexHj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf2kexHj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412730e5b95so17654915e9.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608115; x=1709212915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPWe61qAdoPZyXs9YiS8hEi6k2qk0jViNhPiNFV+RYk=;
        b=Cf2kexHj9XZ+MptC1msil1ol2M9NPxLdoMt/YSXL/Qsr1KDmZPYGnAvBSWE1UVB9+V
         mzjuIphCsBd4y3KXnvsePdNnVxn8FTMCYfWu6oM8qu34P9yCmDynp3yiYp1ip8Zi+iBD
         y44ADeRGIizy9X5Mfm1l5FnaBshcwQxNtVVbETjCMLQukKzgCSkabgtDDWFxuMf96EO1
         oh4Ty0q4qKZD1IPunWXMJrYzJv3EK3+mzGnD4sMhH7AvQJNu34uk61C07MAUpoAndIGG
         E2dYmwHYmfoUaDTEV6ZEz6NN7Na55j0Z8U1G1OBYGeCgUZkEgqS+VOdOQss3yj8W00zH
         sVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608115; x=1709212915;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPWe61qAdoPZyXs9YiS8hEi6k2qk0jViNhPiNFV+RYk=;
        b=Rheo3Bp2NVQ3n8wgxg+Oe16IUeO4oMZ4sZHVQhOLQXKYK1VKwWe64ZlKQrEGtzUWje
         kEfllsSCB2bavDlxlpA8/5kxeQVRPp0mgNTWlI5woWVUSZrnf9pD5xW1OkH3zVanZE3X
         N0p4esUg4job/b8FJdZKberdOz9hscLcf9ZdY8bLtiMjY04Pd03wGobyem08NSiCGpZ/
         C5NfGZgL0Q75HCYKyTa52wlaIYMttfOBogxqkjkQkyLIci4fmSWF73043TUCcuIUWxGl
         7L3KTQYjjhnh+MBGIVAPggeCV2iwltBWbN5L6UvYby/ZHeZXAO0XyR+K9K30FRu5PEoZ
         NdDw==
X-Gm-Message-State: AOJu0Yw5/N/7LXPManjqE2lG1Tcrnyu8XeUPR8YqIHsFahaqETC44q7d
	fFEPwMZEHBi7yt7wA6gAa9XaOP74ROCW0zq13H0c0ydciEOOKareKOSkaA7g
X-Google-Smtp-Source: AGHT+IGss+bhPGNpuzOS5KJ+ilYWfJGebLvfLm8SDwokArd39ehBBNcC0xk870Ch3S7tvLjYNZM6xQ==
X-Received: by 2002:a05:600c:5107:b0:410:78ca:f756 with SMTP id o7-20020a05600c510700b0041078caf756mr14758768wms.32.1708608114600;
        Thu, 22 Feb 2024 05:21:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b004127942bcd6sm4403496wmo.7.2024.02.22.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:53 -0800 (PST)
Message-ID: <5c16becfb9b4741a1c91f1c560ad270b74048baa.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:41 +0000
Subject: [PATCH v2 02/11] Prepare `repo_in_merge_bases_many()` to optionally
 expect missing commits
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently this function treats unrelated commit histories the same way
as commit histories with missing commit objects.

Typically, missing commit objects constitute a corrupt repository,
though, and should be reported as such. The next commits will make it
so, but there is one exception: In `git fetch --update-shallow` we
_expect_ commit objects to be missing, and we do want to treat the
now-incomplete commit histories as unrelated.

To allow for that, let's introduce an additional parameter that is
passed to `repo_in_merge_bases_many()` to trigger this behavior, and use
it in the two callers in `shallow.c`.

This does not change behavior in this commit, but prepares in an
easy-to-review way for the upcoming changes that will make the merge
base logic more stringent with regards to missing commit objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c        | 5 +++--
 commit-reach.h        | 3 ++-
 remote.c              | 2 +-
 shallow.c             | 5 +++--
 t/helper/test-reach.c | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 7ea916f9ebd..ba2df8b8f3a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -467,7 +467,7 @@ int repo_is_descendant_of(struct repository *r,
 
 			other = with_commit->item;
 			with_commit = with_commit->next;
-			if (repo_in_merge_bases_many(r, other, 1, &commit))
+			if (repo_in_merge_bases_many(r, other, 1, &commit, 0))
 				return 1;
 		}
 		return 0;
@@ -478,7 +478,8 @@ int repo_is_descendant_of(struct repository *r,
  * Is "commit" an ancestor of one of the "references"?
  */
 int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
-			     int nr_reference, struct commit **reference)
+			     int nr_reference, struct commit **reference,
+			     int ignore_missing_commits)
 {
 	struct commit_list *bases;
 	int ret = 0, i;
diff --git a/commit-reach.h b/commit-reach.h
index 35c4da49481..68f81549a44 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -30,7 +30,8 @@ int repo_in_merge_bases(struct repository *r,
 			struct commit *reference);
 int repo_in_merge_bases_many(struct repository *r,
 			     struct commit *commit,
-			     int nr_reference, struct commit **reference);
+			     int nr_reference, struct commit **reference,
+			     int ignore_missing_commits);
 
 /*
  * Takes a list of commits and returns a new list where those
diff --git a/remote.c b/remote.c
index abb24822beb..763c80f4a7d 100644
--- a/remote.c
+++ b/remote.c
@@ -2675,7 +2675,7 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 		if (MERGE_BASES_BATCH_SIZE < size)
 			size = MERGE_BASES_BATCH_SIZE;
 
-		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk)))
+		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk, 0)))
 			break;
 	}
 
diff --git a/shallow.c b/shallow.c
index ac728cdd778..dfcc1f86a7f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -797,7 +797,7 @@ static void post_assign_shallow(struct shallow_info *info,
 		for (j = 0; j < bitmap_nr; j++)
 			if (bitmap[0][j] &&
 			    /* Step 7, reachability test at commit level */
-			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
+			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1)) {
 				update_refstatus(ref_status, info->ref->nr, *bitmap);
 				dst++;
 				break;
@@ -828,7 +828,8 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 		si->reachable[c] = repo_in_merge_bases_many(the_repository,
 							    commit,
 							    si->nr_commits,
-							    si->commits);
+							    si->commits,
+							    1);
 		si->need_reachability_test[c] = 0;
 	}
 	return si->reachable[c];
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 3e173399a00..aa816e168ea 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -113,7 +113,7 @@ int cmd__reach(int ac, const char **av)
 		       repo_in_merge_bases(the_repository, A, B));
 	else if (!strcmp(av[1], "in_merge_bases_many"))
 		printf("%s(A,X):%d\n", av[1],
-		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array));
+		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array, 0));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
-- 
gitgitgadget

