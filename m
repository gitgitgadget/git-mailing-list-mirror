Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E323D649F
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674408; cv=none; b=jWNzzGIxD2J386duxNhPzGfgAGjohoLbpEybKH2VAvWFtzkbhAEIg5U5T/AoJ3M0d6i46LjJL+WLnWO2yR/3O8XHq87yhAaAYXpZGNZwvbKu+9lRf3poeff0I79KfgGYgrI316dUnNlOaAb2+Gu0gagsZDZZeSy0o7CREBHME0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674408; c=relaxed/simple;
	bh=kvrel2DGrILSR+QVdRbzx0iv/TvNoVYvcJgNSpRyQIQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sjhZPZCyL+cRXjB4FbF7enCycpwvtIoMlADGgrq9ZmIvHMkmoBOTytBD/995nBZygqVkLAAXOY+VbYfsbiPBPaylrxHRlPoFZ+jLfy5rJ4DxzZvvqpCYzRLujkEQUt8f76tokba8gR/x3UOZjq54VHXHfZPGTJ5bcaxut6A6KFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5kOD6tQ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5kOD6tQ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6b5737bb2so618539a34.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674406; x=1784279206; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z+1Sw/8P4wb4iXGktmtkJYjUM3THK7Z1ZrK24Dzc4+s=;
        b=a5kOD6tQ+ryOoNUOqQFLPqlCWwuaTo6cT1WCC8fyp620WrLBabI6a7fMe0D2n9jnWm
         CFHZLrEl5sIyqQDrTqqdM76nzf8KYgGUvGFJjXHNCp+mKJaCBmcIjeHPHotkDpf92Y9x
         3+xqyMLPuelAT5DjYL/3iJ90fHCqhwk4IKOsXeD0dZEHN9xSmHNhenk5gcHlRCkeIJTD
         usBqROU8HS8jNMrWEMT9KugUj9Ukxqm+ccWIvUOgku1JdQcg1xMHeSwW+2xziBOkK6WG
         EVgxJWNXCSyMng5h6OL+rQ9ZUUgJFlWAZ6GwcuiSRan4Mcr0p2nBSn4+x6N84ZvAr+cg
         u1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674406; x=1784279206;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+1Sw/8P4wb4iXGktmtkJYjUM3THK7Z1ZrK24Dzc4+s=;
        b=gHRLogzQIcz3GxYqrjFHXFiZHcPB+WVMq8Xv/s4sjnHK9bI7BItgKhxBLHHawqkzMo
         SkUDGmKyK3oVq8u5nHSKRviHXceKioLtINbYZAZmBWrNmz+gIbyhfbjCSuluA6gKoX59
         +VhaSkOyszkKIu899xViKactLOhva6eSUb5qRY+M5amhiR6bSI238o3wv0PYcgeYbE7S
         G+ri54X+fiJD0/F7RXRF1DMGTfeNxRiNozfJwYyQiG9AQ8mwSEGe1XjaM9j61FE3kYQ7
         ZNZkhK4pzbAA8s4C0i6dW3wqJ8+saiZRYfpAUy25jFQI0fS81WTJqmM4W2cVWsSAV4mE
         TrRA==
X-Gm-Message-State: AOJu0YzoBf8SM5vCj1gK2qYUwOz4eLI4dn+alfyqJjj6lnBWCVY3gg0L
	xOLp6GniKcQHvSxW87wvT/jROUSdV/pLWB4ucOmToQmR6FuFKGQYlQiAfjqMZw==
X-Gm-Gg: AfdE7cmfv7f1ZAPCev7Ii6tVAVJvr20tANoNo6volZEFrl83LuFufDZlTNaAlNxlbaf
	kyVBcIwtaeg1x+LUgPv9V411vI2Z0RYnmryVOvNz9gVyZkS4ycujT+yoqf6V8sejnXnR6qa/jsL
	SBsRouPmfNV1tGtAFgvgfrxucYp45k/ephBHflMNYKok05WtaudfJR0obWVJpJFD64xYjlm6wf8
	jCvPYQ8kQvf2noqZAUKSn9LM/eQN5xPnRXXjNEDHbbjbKOaRY7oN4fQLzDbVmxuWz6eHRe6fQ2B
	JeZh3vS3BCp8C8H2k9Xro3s0ZFKR2HsuwB9esEKMSKcwce83beecXQYu5LbNJd/RxubcrJFcgyf
	vAcMak56woBTO5Yw4otRHxFywxL4xDl0QgVYqGa/0TCrmRsogNLw/KRTHzLbcgUgyO7oA4vWhan
	qbPx38jBt3MX4Aumg=
X-Received: by 2002:a05:6830:380e:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7ebd01236d2mr6717986a34.10.1783674406045;
        Fri, 10 Jul 2026 02:06:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.20.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bc0d0sm6083766a34.19.2026.07.10.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:06:44 -0700 (PDT)
Message-Id: <50f35728876bee48671b7af766d51e2493f2e281.1783674396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
	<pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 09:06:33 +0000
Subject: [PATCH v8 2/5] history: give commit_tree_ext a message template
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
index 9f516687fe..cbba25096f 100644
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

