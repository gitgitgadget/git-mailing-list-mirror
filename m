Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925498;
	b=UeZU8XVPnQlGURKWqL0GIZpA0WMzJp2cocXxJ2iliDrCORPIcDqVx3WidwNg6DkeBP+c
	 /1fMniLTlBx7aZttGJcwmmNkoAg7k+4s2lxJaXIEDMsTtgVRWVmfxBQfSD5T6cDmjDDOQ
	 8edC1oaG/UQebokux33TkESIW+OzKZAGFRvuTYOH6adQ4gZR63/yS7zs5fNHv3U7B26r+
	 S99GueRZCVGBSxIfU8X+snD9t1mhUwyJBxrTcVS+iiCxySPR1cpzkMZ81sD9L+dstv9DC
	 1P5ogIpF/eMlbaqX0UE6l/33vTJy5SGA/G7JoYmJh0JQ2XyJ3/4mQ/pftmk2JSpeBOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Yu3tasik5SB+tNVfe66h54jUgInuOLV171tvQ+kfBVA=;
	b=YQkNxaz4i+TPVpapziDEn1a/j+/psKXBJvZ/LWqET9hWBIrh4Cqc7tuk1ha3fOCE3gSw
	 dWbB/66g+yu9F3udllsQY9hXhWHrNbZQIfDvUhTjWkrxloiBrDwmDPdI6fuyaJvIRIWqK
	 kxv3RAA2gNbPuihQ9ZSAPIRmYtH+jDvi/0uf1q6WLe1IBZN1clXf1SJ0e082qEPCQaE1g
	 S3tiCpb7IeNX4lIDFGDwLqK22ojIvLQm0EIcJXrNW6Gy/cP49OmdMQxnx02A0W9b1hgU9
	 Nik+PV+5gklx/a7GBItql/JUlCSKPKkwXxPfH1O7YrbXGcvF//LxadLPMlhLxZeYwPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJqXebEr;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A8606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 10:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B8A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJqXebEr
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843cf077f10so2471114a34.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792925497; x=1793530297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yu3tasik5SB+tNVfe66h54jUgInuOLV171tvQ+kfBVA=;
        b=GJqXebErLYLryE4vQRtdvVE1e7VFZ2h6u6sxRhguJA9QV8rT+V7mJIQZKV4EFKW9bA
         TLk4bDeveS053LCQPb/GAQgccvxgx/8ni4IEX4pxxvRxP+nUMVkIFL3YrEb25jUsoOaQ
         FgGlsYEBHbGYdm8W+pg89XIx3OzmXpsYuXBhWNZbgotfM8HbfwKx80iKh0rYM0vUcbrc
         Ng6Z3ulzXVy63KVN1oo0WDVBkSYSTMONcjjaThg6hMvUhrA6bUwVSO9gG5rvVUe4u1/Q
         DmIQ/mORunU6/1Y7LfYgtJ0/x50WDucyG71XwypLnxBsxZ4RvPP31QOI0KEW538jCuj3
         j6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792925497; x=1793530297;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yu3tasik5SB+tNVfe66h54jUgInuOLV171tvQ+kfBVA=;
        b=j8A/q+O+Mpi4gBqUp1v8/qZrZMnAW6W4dGewbQgw4ZX0Rw6V/sllB0dfgI/GUxAy8I
         mms9jr6p/fE6ptRtif+kh7GBhlFPVevQrLDv6q6BBAbeIhO7330mPNpEvSotCogZaIdG
         WVHQsbi4GZVt71sGWkKxHlCYBb5UudL7R4NhMfSTpzpZlKe6wvwqPb4egyxuQPjQcTbe
         0vGIaMjEaNis2Jbom7jNgCeIjNcVfcrzXFKImGG9wK3O1iCPbobMNJ5GS5AOjPRtJZbc
         MaaRnA41x22KUbaPi8M1CDpOFkKdF5g7E42AsCyGkRQr1JARFWVLeLU2rGT4Wzwpf0Lu
         BIow==
X-Gm-Message-State: AFq9FYK1hzqmnMp6Ienq52F9AGwXXjJG1y+ILxcHcO4/uyRhfzW0t7lu
	/BoDS7Qo8EFV6xRoUPjcktGNKEUJ4ItWYgNQZ3GwlbHsmEhLVqxOW3/Re4oB/2Na
X-Gm-Gg: AYBFou3psL6si3fI04uJVJR8YKdMqIuFUH9JdBipGY8IbADgrCFDysAcQ/NOLaX4a1a
	yiPyvHar2MaUjnqI49D84ulyMKfbawtTsBHyxXyF6RpfMtT+c+Z2v9vRG74nthKyx77UsP6bUtY
	+vYLzsiVRo8i+IPNUxTs4riII8uAlODuEzuoalWEOe3OJcrv03tVNF8opn89eKRz/wa2/jG1WH2
	2kEUsoqkHNlOYFNw4brAgrcwIU1Gsnm2+ekIlLN6j8ADmbpbAPT2wKYIxoliesOAWnST2ypUCfb
	Q1MUaKdyhEl5n99Bsr5Gvb2sFQITOgyisZwVyziys2i5pGOHmzGOLaguqvR4fdlKGS5oMU3v5td
	4lUdGMFEoORQGEojbLFl2RcnByfJ5s082b8DQmDWjSuQkhxbwlwSTNKgmLbv/npdWT/5K0NTvid
	gcyJ/rWEEHOs0wq6Oednl2dMpCHUkQAM2+TejIXkchqwJRysjgIOlUkSouUiSxJbhsbXDz9jA2z
	ApufLCMo7Otku3yRW9nraH0XHxbe1+HOJ5vK/vnR3tlOUkvVSnyskGeoCZ92w==
X-Received: by 2002:a05:6830:438b:b0:7e9:dd7f:7a83 with SMTP id 46e09a7af769-850f8c2b499mr2858647a34.0.1792925496917;
        Sun, 25 Oct 2026 03:51:36 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.125.113])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb64ba34sm4792148a34.17.2026.10.25.03.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 03:51:35 -0700 (PDT)
Message-Id: <pull.2458.v3.git.git.1792925493844.gitgitgadget@gmail.com>
In-Reply-To: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 10:51:33 +0000
Subject: [PATCH v3] status: compare against both upstream and push branch by
 default
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Commit 3ea95ac9c5 (status: add status.compareBranches config for
multiple branch comparisons, 2026-02-26) added status.compareBranches
so that "git status" can show comparison of the current branch with
its upstream in addition to where the branch is pushed to, which is
great to support the triangular workflow. It however did not make it
the default to show both.

Showing both without any configuration was the original proposal for
that commit. But some found the comparison with the push branch to be
noise. So the comparison was made opt in [1], with the idea of
flipping the default later if people like the option.

Even when nobody else pushes to the push branch, the comparison with it
is useful:

  - When returning to a topic after working on something else, it is
    a reminder of how the branch differs from what was last pushed.

  - It tells whether the branch was rebased or rewritten locally since
    the last push, and needs a forced push.

  - When the answer is already known, it is a quick way to validate
    what is about to be pushed out, much like sendemail.annotate lets
    one review each patch before "git send-email" sends it.

Some who work mostly in triangular workflows check this regularly, and
have built their own aliases for that: a quick check of how the branch
has diverged from its push and upstream branches, a detailed comparison
of what was pushed with the local version, and a graph of where the
branch and its push branch diverged. Most users have no such aliases
and only see what plain "git status" tells them. Showing both by
default gives them that check without having to discover the variable
first.

Make "@{upstream} @{push}" the default. With push.default left at
"simple", @{push} is either the same as @{upstream} or does not
resolve at all, so the output stays the same. It only changes for
those who set push.default to "current" or "matching", or configure a
push refspec, in two cases:

  - In a triangular workflow, a comparison with the push branch is
    shown after the one with the upstream.

  - A branch without an upstream is compared with the branch it is
    pushed to, where nothing was shown before.

No existing test relied on the old default, since none of them had a
push branch different from the upstream without also setting
status.compareBranches. Add tests for the new default on a branch
whose upstream and push branch are the same, on a branch in a
triangular workflow, and on a branch without an upstream. The existing
test that sets the variable to "@{upstream}" uses a branch where both
are the same, so it passes with either default. Add one on a
triangular branch to show that it restores the old output.

[1] https://lore.kernel.org/git/xmqq8qe0f2iq.fsf@gitster.g/

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    status: compare against both upstream and push branch by default
    
    Make @{upstream} @{push} the default for status.compareBranches. With
    the default push.default of simple the output does not change. With
    current or matching, a branch pushed somewhere other than its upstream
    now shows both comparisons.
    
    Changes in v3:
    
     * Try to make a stronger case in commit message.
    
    Changes in v2:
    
     * Kept the existing tests unchanged, including the explicit
       "@{upstream} @{push}" config and the "@{upstream}" test on main
     * Added tests for the new default with the same upstream and push
       branch, in a triangular workflow, and without an upstream
     * Added a test showing that "@{upstream}" restores the old output on a
       triangular branch
     * Reworded the commit message to point to 3ea95ac9c5 and explain which
       setups see a change

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2458%2FHaraldNordgren%2Fstatus-compare-branches-default-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2458/HaraldNordgren/status-compare-branches-default-v3
Pull-Request: https://github.com/git/git/pull/2458

Range-diff vs v2:

 1:  39512b9ea1 ! 1:  ae9063c16a status: compare against both upstream and push branch by default
     @@ Commit message
          noise. So the comparison was made opt in [1], with the idea of
          flipping the default later if people like the option.
      
     +    Even when nobody else pushes to the push branch, the comparison with it
     +    is useful:
     +
     +      - When returning to a topic after working on something else, it is
     +        a reminder of how the branch differs from what was last pushed.
     +
     +      - It tells whether the branch was rebased or rewritten locally since
     +        the last push, and needs a forced push.
     +
     +      - When the answer is already known, it is a quick way to validate
     +        what is about to be pushed out, much like sendemail.annotate lets
     +        one review each patch before "git send-email" sends it.
     +
     +    Some who work mostly in triangular workflows check this regularly, and
     +    have built their own aliases for that: a quick check of how the branch
     +    has diverged from its push and upstream branches, a detailed comparison
     +    of what was pushed with the local version, and a graph of where the
     +    branch and its push branch diverged. Most users have no such aliases
     +    and only see what plain "git status" tells them. Showing both by
     +    default gives them that check without having to discover the variable
     +    first.
     +
          Make "@{upstream} @{push}" the default. With push.default left at
          "simple", @{push} is either the same as @{upstream} or does not
          resolve at all, so the output stays the same. It only changes for
     @@ Commit message
            - A branch without an upstream is compared with the branch it is
              pushed to, where nothing was shown before.
      
     -    Those who find the comparison with the push branch to be noise can
     -    set status.compareBranches to "@{upstream}" to get the old output
     -    back. Having configured push.default and a push remote to get there,
     -    they are the users best placed to find that setting. Those who are
     -    just starting to push somewhere other than where they pull from
     -    benefit the most from seeing both comparisons without having to
     -    discover the variable first.
     -
          No existing test relied on the old default, since none of them had a
          push branch different from the upstream without also setting
          status.compareBranches. Add tests for the new default on a branch


 Documentation/config/status.adoc | 11 +++---
 remote.c                         |  1 +
 t/t6040-tracking-info.sh         | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index b5dd85b761..1d847d3a8a 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -23,8 +23,9 @@ status.compareBranches::
 	are supported. They are interpreted as `branch@{upstream}` and
 	`branch@{push}` for the current branch.
 +
-If not set, the default behavior is equivalent to `@{upstream}`, which
-compares against the configured upstream tracking branch.
+If not set, the default behavior is equivalent to `@{upstream} @{push}`,
+which compares against both the configured upstream and push tracking
+branches.
 +
 The entries are shown in the order they appear in the configuration.
 Duplicate entries that resolve to the same ref are suppressed after
@@ -36,11 +37,11 @@ Example:
 +
 ----
 [status]
-	compareBranches = @{upstream} @{push}
+	compareBranches = @{upstream}
 ----
 +
-This would show comparisons against both the configured upstream and push
-tracking branches for the current branch.
+This would only show the comparison against the configured upstream
+tracking branch for the current branch.
 
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
diff --git a/remote.c b/remote.c
index 49ee2ea318..0d97cb9100 100644
--- a/remote.c
+++ b/remote.c
@@ -2472,6 +2472,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		string_list_remove_empty_items(&branches, 0);
 	} else {
 		string_list_append(&branches, "@{upstream}");
+		string_list_append(&branches, "@{push}");
 	}
 
 	upstream_ref = branch_get_upstream(branch, NULL);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..3d61297c37 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -331,6 +331,18 @@ test_expect_success 'status.compareBranches deduplicates when upstream and push
 	test_cmp expect actual
 '
 
+test_expect_success 'status shows one comparison by default when upstream and push are the same' '
+	git -C test checkout main &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is up to date with ${SQ}origin/main${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'status.compareBranches with only upstream shows only upstream' '
 	test_config -C test status.compareBranches "@{upstream}" &&
 	git -C test checkout main &&
@@ -380,6 +392,36 @@ test_expect_success 'status.compareBranches shows ahead of both upstream and pus
 	test_cmp expect actual
 '
 
+test_expect_success 'status shows ahead of both upstream and push branch by default' '
+	test_config -C test push.default current &&
+	git -C test checkout feature3 &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature3
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature3${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with only upstream hides a different push branch' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream}" &&
+	git -C test checkout feature3 &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature3
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'checkout with status.compareBranches shows both branches' '
 	test_config -C test push.default current &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
@@ -707,6 +749,21 @@ test_expect_success 'status.compareBranches with behind push branch and no upstr
 	test_cmp expect actual
 '
 
+test_expect_success 'status shows push branch by default without upstream' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	git -C test checkout feature15 &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature15
+	Your branch is behind ${SQ}origin/feature15${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull origin feature15" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'status.compareBranches behind upstream-equals-push suggests plain pull' '
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
 	git -C test checkout -b feature16 origin/main &&

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
