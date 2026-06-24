Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769531DDBF
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338115; cv=none; b=OrLk3s6ghLmzc/vdVzM35riXst/F8inrdoG+3W7aTOl5bIVvYpZwHAoZrHZlq/H0Q9yjTdh7jweUWUnGs1fGYpYNOR8JahoqUco0EpdRn+oYwl+aLF4TzjKdrsMuaN3cDR9U8qs83RkFLkIAazjED/sLY3NLK25LujoFbE5lJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338115; c=relaxed/simple;
	bh=NutoYXBg1C7XgbflVuG0jW+euBPKTNQMr3lJ1a/7C7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xahj6fVBOIIOX/8USB/2WLPLpWmII7OfNByHkoSJ9irntPYBt+mbOIGRA0uwyfH52YkUXtzHl5QKw0MfQxmDnvZnykNEZfIF305giFpdP/MQkzf1CRm1FyMAfLu7cKtGS3HxwNUdFMB45ypAmK47Zn54/FnE5UrrWYLYX+/Mil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfJ11/4u; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfJ11/4u"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c52f96f60so2897400eec.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338113; x=1782942913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=BfJ11/4uRBaFqT1JYvcyKGKsmQzv6xTV7bn1UV7HObFBs0IvR3KxFcFlimHELwNaDE
         mr3RrhDQ74K4gIGQSpDqd4yg+AshbXz1Q6MrILoaHevT9PlPtj009pWt5mOGyv0ExFao
         D5KMBNlLN2RHnDaq19/idIfxVxDXuZa5MOVDNnkBUh6BpaGsWIyGrahcjnRyo+jOYqzm
         NxnocPnQRNigOAfDDm86SYid+ghb3KiecL/4MOqiLF/ZXf/MZpbhfE3zR1GGUT0ZgfdW
         v7Z5VY86TfxwiltJXPsqUL8FzB+E5g50ccaWvuKMG4nQ39gVYZsvVoIF8q1XYukNq2uQ
         x3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338113; x=1782942913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=Rcl/d/7/l+X80HfWnH4TMZTdu0MXelJYMgAQiohwyy7GG7+7XTgobtNHI4I6U0DwFk
         wA9EYoCUPaEGmw1E+WLG437OtVBR3TOuH+hkNlb/L1gZWa8YgSUYODw4AqRpjvx6nNRW
         wD+EjXFu0S5X9ULAfzTRxH+daA7Ay8Rbrt8uaqBhI/GbbgaFKcy2AWs/zRx5rFPEaZbC
         uoxWgF+npyNPvTSwQqGt0iWNPW2VpWXndfEzW7XSmKVIbHgcTyQ7pedQ9W0Mkaqu1L+w
         LywWzERuiO5zcVM3oBgv9tP+7r/ZdxIgZyISSGihFO+zll6fW2R+0xust/DTemU2JL7P
         WhOg==
X-Gm-Message-State: AOJu0YwELbfGMiJuuJSs+kb6ejuGO6Dtmou5tjGgrAzCjxMPYV7MH9cW
	g9WS+bcQpXDA5aGApunTv0YYkJZ4PCwM1vnA54+vAI0lp/Iw8+OLZzRN28AT9Z8R
X-Gm-Gg: AfdE7cnanfpqD1Re9snSm/HpTBS8Da6i709uhESXCEb1mN5yDVCKgDkIvWbZjqd5tR8
	DwSSqL51seOV6yPXcYU04v/BYUEiq2WytAzivVX0WvBRlIewqo7vV0XMYRZenxM1vqRlImqV5MB
	bN2Htx+PSNF8XixzxQOf1qTmE+BUTY/Bd1DC7FzrOQ9OWBsBfPnqZ2YYNFUCKmb5XbsgBJcJ3j2
	CFMcqTSEsEUsixSl5FzYTkjcZSsGjAx8M/1/XsWPSc+Eo+36ivcu7nJkEPR2+w0Y5E8/T9s+EhA
	383FwkmIDg8Ra5BAVocVKF1eWmxJUzXnS87HxkBRmx1Df90QZ6RcS04i1WX/gPVUZY6nG8QjzaE
	nXT4n/BShx77cV+S/WOiOHBm/6GOM5SiwdFJuMawVGKm4rGMq1Yajv+qA5JasqQXBoZFw2pEJ+x
	n9zpr+yWb2C6piqeJw
X-Received: by 2002:a05:7300:7c17:b0:30b:f73f:ff6e with SMTP id 5a478bee46e88-30c84b87a74mr26897eec.11.1782338113149;
        Wed, 24 Jun 2026 14:55:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1ae5sm2067628eec.16.2026.06.24.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:12 -0700 (PDT)
Message-Id: <a0fd5b4a6c1b9d7823b431be703ee1696ea41f6c.1782338106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
	<pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:02 +0000
Subject: [PATCH v18 3/7] branch: let delete_branches skip unmerged branches on
 bulk refusal
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a skip-unmerged mode to delete_branches() and check_branch_commit()
so a bulk caller can silently skip branches that are not fully merged
and carry on, rather than erroring with the "use 'git branch -D'"
advice that the plain "git branch -d" path emits. Existing callers are
unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a9be980aef..4c569d056a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -199,16 +200,20 @@ static int check_branch_commit(const char *branchname, const char *refname,
 			       int kinds, unsigned int flags)
 {
 	bool force = flags & DELETE_BRANCH_FORCE;
+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!skip_unmerged) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -235,6 +240,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	int remote_branch = 0;
 	bool force;
 	bool quiet = flags & DELETE_BRANCH_QUIET;
+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -319,7 +325,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!skip_unmerged)
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

