Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBC1F4634
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021201; cv=none; b=doQtz1PtgCZqiUAP8gSxPKDvRdq4V/nLsy6cN2Hjv2Oj65PswmUj4KYKL3qlZC6D8YsWWOSqlaCiTVMEyLn2SFFhQXsq/SRwujQvAQIe/xVmSMTy3oipeyimykubdoUh14+GOFTwyrqbEPJMmxGVyfbL0HnsUvuo6s+U97UfSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021201; c=relaxed/simple;
	bh=v42sOHU+NPEhjIkOG/WgYyh8KYHUdpVLrZrg5hNdK2A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=irel6o+TRk6uMvfIHyxSb09JRKOklFWfT1FUR8qGTgpxcbJuNvUi2yl3mzipd87uR4BresNWm43bmwTFI1nIVqmqWYQkt0GXEvkhLH8p0yo5mGSidUluh1idKjrsAyohjugz+YuMOC50cRgfNVSdWLSfj+CdEklP9E83qaGOgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq9Ww67m; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq9Ww67m"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8de2adc59d8so24668296d6.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021199; x=1782625999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=dq9Ww67mvKrT1QfqkHRATxnsduiw+QPWfp5Htkg+ZNjGXxe+ZG3LOscPUAONkPDevU
         Fj8qvQX+tPbYqAU7XjJGASNAYy7KtKrk3yrQnNoeOSjTImA6tIGOBy7G0MrHnVJKbEGt
         CNxNgCtjpOqopgI/BYBzMEwDQtlUcy/FVFFUixrFy2mVotJtOFEYGXj+7IOFGS1ojroq
         haEInOAUEk2yCQhdQ/1vJjMkK5vNNvHhTcya/AImQZVwxrbiv0VXlgbzoa+9RMrgykaR
         G7mOU8eJ/eMNgDn9l11g1hCXl26Sw+QND5WPC4oTu81/0Q62kwQBisAdSeEleKi5Ivjg
         XogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021199; x=1782625999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=EsqDosT2lefqvhQu8PYnd+Kw1aTT5gWEFTYru8Xom1hnoN+FdCqvwNp98tAiguw/8p
         PBGSg5ZXZl2C+FlrjB8t+yWVS2P4RCsJw+g0s14ACfEw7CcyvZyiZ79Qg/kKKBimNkCQ
         CoHDT/PKnMhjvvF7ZYpL8ucv0ZO7mdZE/TJYaxyHGTy5et8cLz+fU9klzbAyhRQAdo55
         5t9EErvGdA2QVaQHbM7582qAAV/a/Wp5KOIruEaZ9URt8lAKLKtQ12ZV/9A1dd86dCET
         jhZO0JspvDLG2ChsUysQ4yyR5bwBgFspRY6xlpk26w480UMIgWoGqBnjuBTRhuimopqS
         R7iA==
X-Gm-Message-State: AOJu0YyMwMPpRlW8x/oY+qnAiyM5Vskn37hP96qjJ8SYeUQzUfgELpXI
	qA+R14FydbBRvYZBM8i/2jh8wHcaIH6KHxY94zQ16Rwzzcws8+GmuHvfTQyEkw==
X-Gm-Gg: AfdE7clHd/nstP8g1tSfhGZ/6XaRNl1cq6jLaGaBFCSL97/XPQy/eE6xnt75f2AdzN6
	9L/bL+hODslZL74eu7je4ssAItUlZg9/fi9kL8y3emZWutizqAwhVMWam9KfhwwhnbkjppFxPJS
	uexteIQx9B4qKXmSBNF7kTEA+XF6NE6FFKUdkOMkH/4RLjwisPPb7vAS2lE/fLu9zkgwUP3OelE
	BiKherM6VNwcakYa4OWp5JIWG5ImLQxfU1PY/MTtANprZ5+9/CwGsWZYxrnB19ZGHv2x9WJ8fbx
	zxS3kGW7YN33Kas6u3CkYVyOsgETZG3f1SsMaauKFgDVP/Qp/Um9lKH35ksjCJ6sw7cWn5oxwwI
	Slup5bHj2eo9lclhdwYEy3Qpj9kk/cT3T70/wpOBpnLh/JYznBQm6KYd0iLInZgXGYblLDZAQ2f
	6UaLdSqhxt6oFMt+4VJbANj/Lykawa
X-Received: by 2002:ad4:5d6f:0:b0:8b0:33a2:2520 with SMTP id 6a1803df08f44-8de4bd92938mr157835766d6.10.1782021198757;
        Sat, 20 Jun 2026 22:53:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.117.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb4a4sm52299446d6.36.2026.06.20.22.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:53:18 -0700 (PDT)
Message-Id: <ee591e83b461311a55514be7418639532cf9997c.1782021195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
References: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
	<pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jun 2026 05:53:13 +0000
Subject: [PATCH v4 2/4] history: give commit_tree_ext a message template
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

commit_tree_ext() reuses the message of the commit it is handed. A
caller that folds several commits together wants to seed the message
from more than that single commit, so add an optional message_template
parameter. When NULL, the behavior is unchanged.

Pass NULL from the existing fixup and split callers.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index f95f26e684..305bde3102 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -101,6 +101,7 @@ enum commit_tree_flags {
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
+			   const char *message_template,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
@@ -130,13 +131,16 @@ static int commit_tree_ext(struct repository *repo,
 		original_author = xmemdupz(ptr, len);
 	find_commit_subject(original_message, &original_body);
 
+	if (!message_template)
+		message_template = original_body;
+
 	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
 		ret = fill_commit_message(repo, old_tree, new_tree,
-					  original_body, action, &commit_message);
+					  message_template, action, &commit_message);
 		if (ret < 0)
 			goto out;
 	} else {
-		strbuf_addstr(&commit_message, original_body);
+		strbuf_addstr(&commit_message, message_template);
 	}
 
 	original_extra_headers = read_commit_extra_headers(commit_with_message,
@@ -189,7 +193,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
 		return -1;
 
-	return commit_tree_ext(repo, action, original, original->parents,
+	return commit_tree_ext(repo, action, original, NULL, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
 }
 
@@ -644,7 +648,7 @@ static int cmd_history_fixup(int argc,
 		goto out;
 
 	if (!skip_commit) {
-		ret = commit_tree_ext(repo, "fixup", original, original->parents,
+		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
 				      &rewritten, flags);
 		if (ret < 0) {
@@ -855,7 +859,7 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
 			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
@@ -872,7 +876,7 @@ static int split_commit(struct repository *repo,
 	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
 			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
-- 
gitgitgadget

