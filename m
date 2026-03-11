Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1883CBE8A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251378; cv=none; b=h+IzfMOqrTxv9cLbmvM/2cLOYjdPhp9bYrrso0j7k1pl6RzMhzMtmWC8m55NQotDhnTV6stK9JUlVscjD+JKyaahO8f0a/xADW/Gs+U47fRi4PkkpKjb94a+Aj2BvChcEfk+32OITT0KnYw5GHqJUQzafXlkjQMIHp138UAuD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251378; c=relaxed/simple;
	bh=8ON5a/IcuZ5qVn6tSWHPJENVBvQb/zpNeIArkvQX6IM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FDUUalkXIb2PBtlodtU8iN+0XmTn7Fe7p0i1GxBp2G7eO5XRomhie+iMTbf19g9/SdR94BvcTvtQnwV+GMaE2B3XgwTSgyS+QoquoYDn+bVsGjJbtEF/8GMHQbVoD3yhHM3GQpqq2jVWW+x21UGVFBDV2NXC1/+0RoqDp6UYjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTz8DNHz; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTz8DNHz"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be4781d2baso110827eec.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251375; x=1773856175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJGsGnkFbwjjLsS1yLn4/y0bp3bHG0sMTPaKgRaRmgk=;
        b=HTz8DNHzBYePoYWqLRep7Kiht3NGk0TM+AVkkD+Oegx/c6YZ2L0LkgEbTcgGdrA23g
         L1Ri+a/ls/GriUSydmALsaX423nmzF++PgAHvFg8LkSwGj5ldOyD9D7kbCEeu1++EPXx
         AXSc9d927UsMJszrj54tCg6i0h4LLogT+l+U54waZoCpQGJhhw2/ECo6ATqnm8xMWqH/
         rN3wacqFFjEU67OBqvKXk9nrZnb5fQgUGMOgNRr0Fdk68qedNorUOAkhD/OCwL23J23V
         EeAwJEIFUJmpJ8TtUPjnB+VycAGerQLxVBrrXFtdY1RgctZfiGE5W2sW9SNFOJRkXS0Q
         0qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251375; x=1773856175;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nJGsGnkFbwjjLsS1yLn4/y0bp3bHG0sMTPaKgRaRmgk=;
        b=ohJ35Mnyv/wc1yhJ5ifmIiVn7V1Jn0JcDu8It+oFRMcZw7G6ge9sJzXPQ12KCQI0Rg
         N2onyN3KLaxFLp9oEQQt4I5ZfsLU4rtBwlaaoZzT3nA7OQ5jijjyk4lZiPj5Gch2J4+J
         psE9i4aYjGi7pZ7zVYgOKBK3Ru1yeQOiqp7N5qZPpD8TDhE5b3HtW9mgTnEkQdsKr9po
         e/LzsTwCm1lyk9+jGiG2r4U//L1fB+m4+yBmQ0J3xn64ZjHJVq9OH49vzY6/QLlkpUNb
         ZuiVxnY1WjdOFuhWa9B6sDmMzjqW7VtBhZOEfysiYtrYhFdza+0gfhWakExMPiYHnHvu
         Bo3w==
X-Gm-Message-State: AOJu0Yw3K+Bc7zWo1V5IxavYH7jgp4ohL3z9kpuSy9Yk4MM/FHDwT116
	JTAoAyVePlVmZ1TJua4jccm4TfYWL4pi6pzg1PljlLJLnymcac7t8sGvZYytWgfT
X-Gm-Gg: ATEYQzw4H4bC5GAranpukNb7LHGrFWX2VfPgCTkazZoRG/bckgpUPdU3ex7UE1r2C4L
	XPGciBC0nF6P8775eZ+yxrCUU5AuxnRXHO+97IQ2AknUAjzKhrY5airrWGQvWHvBO7raEGAVsHg
	CSwGNWTTQOvkan3KUhUO5IyQpfJMnXflF+TRIhcbkcoZbQs2Ga/oWvYp7wtIi1S5eIdRFx403tq
	nc0SEoIO1x7PdBa7K+cqDPo8FxEaVy6a1Q0aqXvqPkM/ChqgO6A2FxKJinSh6bazYxdyySpsPMJ
	RyfUm+YCdvIX67ejcrZiN/Ai9+moq5JQWCRxiy3KvgVyVBUA93PYQDPfkllCR20Nc9ItDs7JISc
	FyD1m7Wp712SGsB1k5B1hwXkL8CvG+F0cJa6cIP8qA8XC/IclMotsB70UQ+h/xlz9KBzKvm4Gx5
	DHfUKSmjTaTilapj44Pz9v8lXoy1Y=
X-Received: by 2002:a05:7300:5725:b0:2bd:fe5a:b876 with SMTP id 5a478bee46e88-2be8a561bf9mr1571408eec.21.1773251375011;
        Wed, 11 Mar 2026 10:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.192.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa4e9e2sm3863488eec.17.2026.03.11.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:49:34 -0700 (PDT)
Message-Id: <1cc22f437e92fe522ca23891cf3686c6b4e815c2.1773251369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
References: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
	<pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 17:49:29 +0000
Subject: [PATCH v5 3/3] unpack-trees: suggesting 'git checkout -m <branch>'
 with its repercussions
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

This comment is an extention to the already existing stash comment.

After the valuable insights given to me by git maintaniers.
I removed the new function I introduced.
Added updated comment over the already existing function
"setup_unpack_trees_porcelain" with "git checkout -m <branch>"
and its repercussions
I have also mentioned the repercussions of using "-m".

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 Documentation/config/advice.adoc |  5 -----
 advice.c                         | 20 --------------------
 advice.h                         |  2 --
 t/t6439-merge-co-error-msgs.sh   |  6 ++++++
 t/t7406-submodule-update.sh      |  3 +++
 unpack-trees.c                   |  9 +++++++--
 6 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 8752e05636..257db58918 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -126,11 +126,6 @@ all advice messages.
 		Shown when a sparse index is expanded to a full index, which is likely
 		due to an unexpected set of files existing outside of the
 		sparse-checkout.
-	stashBeforeCheckout::
-		Shown when the user attempts to switch branches but has
-		local modifications that would be overwritten by the
-		operation, to suggest using linkgit:git-stash[1] to
-		save changes before switching.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/advice.c b/advice.c
index ba290d3760..0018501b7b 100644
--- a/advice.c
+++ b/advice.c
@@ -81,7 +81,6 @@ static struct {
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
-	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
@@ -313,22 +312,3 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
 			    "* Use \"git add --sparse <paths>\" to update the index\n"
 			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
 }
-
-void advise_on_checkout_dirty_files(struct string_list *file_list)
-{
-    struct string_list_item *item;
-
-    if (!file_list->nr)
-	return;
-
-    fprintf(stderr, _("The following files have local modifications that would\n"
-		      "be overwritten by switching branches:\n"));
-    for_each_string_list_item(item, file_list)
-	fprintf(stderr, "\t%s\n", item->string);
-
-    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
-		      _("To carry your local changes over to the new branch, use:\n"
-			"\n"
-			"\tgit checkout -m <branch>\n"
-			));
-}
diff --git a/advice.h b/advice.h
index c035b5d8e3..8def280688 100644
--- a/advice.h
+++ b/advice.h
@@ -48,7 +48,6 @@ enum advice_type {
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
-	ADVICE_STASH_BEFORE_CHECKOUT,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
@@ -84,6 +83,5 @@ void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
-void advise_on_checkout_dirty_files(struct string_list *file_list);
 
 #endif /* ADVICE_H */
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 643c9368e0..cf996e0e51 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -77,6 +77,9 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please commit your changes or stash them before you switch branches.
+Try using 'git checkout -m <branch>' for a quick fix.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
@@ -99,6 +102,9 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please commit your changes or stash them before you switch branches.
+Try using 'git checkout -m <branch>' for a quick fix.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3adab12091..2e4cc9b3fe 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -212,6 +212,9 @@ test_expect_success 'submodule update should fail due to local changes' '
 	> error: Your local changes to the following files would be overwritten by checkout:
 	> 	file
 	> Please commit your changes or stash them before you switch branches.
+	> Try using '\''git checkout -m <branch>'\'' for a quick fix.
+	> Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+	> Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 	> Aborting
 	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
 	EOF
diff --git a/unpack-trees.c b/unpack-trees.c
index 998a1e6dc7..9835a82455 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -128,8 +128,13 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
-			  "Please commit your changes or stash them before you switch branches.")
-		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
+			  "Please commit your changes or stash them before you switch branches.\n"
+			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
+			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
+			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
+			  )
+		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
+				"Please commit your changes or stash them before you switch branches.");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
-- 
gitgitgadget
