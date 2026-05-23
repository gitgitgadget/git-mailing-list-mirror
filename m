Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203371A23A4
	for <git@vger.kernel.org>; Sat, 23 May 2026 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779560398; cv=none; b=Aqn2dTBDlFfOWxao0UemyLpwwcw2GcMkLHxv5JO93cQOVhOiS1DrnkjnSD03Ivq+Uf58zbIvAHAzt+WWp0YQePFq7khay+wpP4aiWf1YHt78/OxSJ5zB0Z8vwrXA7bwCuVOhYGhJRms6XYtvAMiv2i+1M2NyRalygT4/nLenouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779560398; c=relaxed/simple;
	bh=6rZGVBSVSkrUvPDYmBD6smeqezFl6QbQbrKeXoCYNLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hezAoq05ubxupIdIa2stEA5aSoeiA6ecUQMN9eqVng2StSpmaGAp5zGXPP8JosU3s/xXEIuRFpr53hLrX+VPqj/JHOFLUgkMJQkDgNTjbiCpunXlpzENW3yPC9AIzkv9zHZQUls0dMbMoO2g9anGfqnHWutGnfAtcK9DZtOS8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OadYpU2C; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OadYpU2C"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b59772d441so104262446d6.0
        for <git@vger.kernel.org>; Sat, 23 May 2026 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779560396; x=1780165196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ahvqfI1xKE5RAIAe2J9UktHy59AkHGPkhsdE8lxEC8=;
        b=OadYpU2CRS5HKTAmqp0E5PV8y/VHLomtcyAnhsUp82cNIzf2zk+5DuDgSToVLNJfLJ
         2ZHelxjNraKTV9m5614RFMCqKjy6d9g6ynbEPSYLh1ei+RBeGiYY+eoUEjTGOaBGg94a
         peENDrtiXX6CfvBwGNe5+CEWhYugD1sfe0K6q/6lmL2kXIS/ZiI0iE9HuUOvIN/1k1iz
         NHiapU1pSJrr+yKLtv+9vd5uD3e2vjfN8ZYZJ7PA7I7ot5Y15TWdUZxvgn/nsiIHUK37
         1wHInCEaXnObsu/XCIESToahUPImS4PHIMFyk8/yv6Ry1HLsDZL3LMnQbYy6IFwl+N5t
         q4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779560396; x=1780165196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ahvqfI1xKE5RAIAe2J9UktHy59AkHGPkhsdE8lxEC8=;
        b=k3Cf1kTUfR8wWvbo4xvJ68BMsQqT+x3CvCW8vYAtvZVHJgC+UvvIUQWHZL0vg8OOJQ
         WxZHM8dno0mfnsjp+Vj6JMfxd2mf4SrYOsSivlsPNcaQbp2/3AmE5q3rW/nHuPs0WyBg
         tYXORAX88i9whuBCo5HqfmGASzjhloA07UdjSeueqBwW9G2M+3jqYU4OazZCHx/oMvH2
         ohT1hGrz9A9aw9VTKm9FgZf2ML+BXZFetoYUkD1mwT3KZmMVw8PqL2g0sllV7yvTbn58
         IjP8+618+n959ob09NnK/66o2q1C6ED2s+Tt8ueqXREOuin6zgJZpE5oQuOi9denkuj+
         YLeA==
X-Gm-Message-State: AOJu0YxfZB3KCq5HITD0J1sGCec6TFWz2NxEx4kUvfj10Dzl6N5aVvJU
	YB888jhaIVIgqPtYf6y5OfFA3dyYK1yz+9E0Xk+PgaZye9tbb4BrLIz7g/BqSbEy
X-Gm-Gg: Acq92OG538clLxH2zQvfRt+gZb6SQmP4r4ZYRCcD2a02TqAh1QlZTHDQAlzjK+6pYuf
	y7aGkR1rt80rhNxR5PFY1BKg3VcHTIrMBQENG76ecJXu9xl4WX9mT/sEbP74cIUrH+B3hhs5F3O
	/ONAocz8Ym6qm4ANtdUOA2809WkDOfFlSwU0cfLROXJtSaEdBBS7r5ayvd06Z6DlL00ye6Z51Nk
	eXLsIAJ5ksAmWCZqavaCZllEHdtB8U8Xv+jD/IpTykxRdWtVkZLmAyGAYA0Ftckrqmv5Lay8ff4
	xlx0NqdGMztl/ejc4+mvmpKXEg0jsnXtieiHwjJFWaZmxbnLU7BQoEkWp/2ae4vjnhg2tLfLLYB
	uky8c4NLc+5W640LAL6Cg/+VNDOr9JuF7kU/wI47Eoe+0N/HN9w8qOCkkRi6C/2VD0XFRyn9wVg
	gGiFV9AuQW4FECBW3c88oyoSV+tQ==
X-Received: by 2002:a05:6214:f62:b0:8cc:d29:9f6e with SMTP id 6a1803df08f44-8cc7b5847bemr147378196d6.22.1779560396019;
        Sat, 23 May 2026 11:19:56 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81323f7csm52254576d6.46.2026.05.23.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:19:55 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] fixup git-gui: allow blame to show uncommitted changes
Date: Sat, 23 May 2026 14:19:50 -0400
Message-ID: <20260523181950.201345-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-11-mlevedahl@gmail.com>
References: <20260520202411.108764-11-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a0db0d61fb ("git-gui: Generate blame on uncommitted working tree
file", 2007-05-08) added ability for git-gui's blame to use uncommited
content in the worktree in the blame display. The specific mechanism
that allows this is passing head as {} to the blame constructor, and this
mode is enabled by specifying no head, which means the current branch is
used, and no swapping of head / path is possible. Path checking looks for the
path existing in the currently checked out branch, so files unknown to
git cannot be blamed. This mirrors git blame behavior. Both now will

    use the worktree contents of the file $path as the basis for blame,
        including showing an empty blame if the file exists and is empty.
    error if $path is remove from the worktree, even if it exists on the
          current branch.

The latter behavior is a change: before this patch, git-gui will show
the unknown file in its entirety with no annotations. The new behavior,
following git blame, reports that git knows nothing about the file.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
This patch will be squashed into 0011 in a v3, or kept separate. The
comment in patch 11 saying blame's use of the worktree is unaffected
is wrong, this fixes blame to do exactly what git-blame does with
worktree content. Slightly different than what git-gui did before
regarding unknown files, but I think git-blame's approach is correct.


 git-gui.sh | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ae609f86f1..114511974a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3084,11 +3084,16 @@ blame {
 		}
 	}
 
-	# no swapping allowed if head not given, use current branch (HEAD)
+	# If head not given, use current branch (HEAD), no swapping allowed,
+	# and blame may use the worktree file content.
+	set use_worktree 0
 	if {$head eq {}} {
 		load_current_branch
 		set head $current_branch
 		set canswap 0
+		if {$subcommand eq {blame} && ![is_bare]} {
+			set use_worktree 1
+		}
 	}
 
 	# -- before "rev" arg means we got -- path head
@@ -3098,7 +3103,16 @@ blame {
 		set canswap 0
 	}
 
-	set objtype [find_path_type $head $path]
+	if {$use_worktree} {
+		if {[file isfile $path]} {
+			set objtype {blob}
+		} else {
+			set objtype {}
+		}
+	} else {
+		set objtype [find_path_type $head $path]
+	}
+
 	if {$objtype eq {} && $canswap} {
 		set objtype [find_path_type $althead $altpath]
 		if {$objtype ne {}} {
@@ -3108,7 +3122,7 @@ blame {
 	}
 	set current_branch $head
 
-	# check that path exists in head, and objtype matches need
+	# check objtype matches need
 	if {$objtype ne $required_objtype} {
 		switch -- $required_objtype {
 			tree {set err [strcat \
@@ -3130,8 +3144,13 @@ blame {
 	browser {
 		browser::new $head $path
 	}
-	blame {
-		blame::new $head $path $jump_spec
+
+	blame   {
+		if {$use_worktree} {
+			blame::new {} $path $jump_spec
+		} else {
+			blame::new $head $path $jump_spec
+		}
 	}
 	}
 	return
-- 
2.54.0.99.14

