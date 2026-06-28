Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFE375AB8
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782635356; cv=none; b=Z496h/8UDNQ2WaYYIQweJdBzR89+VB2mqx5mbhjs7kUcGflHr8eiUB0n+3I90Pliwbw0OMcKPbSJyZ6Sd1JHBpL1DEbsS7g+hKzqkd3ZThR3XiNADyET0e1UyBlOu8oZ/3BJQQyX9mjtg06ZQ3BFUljUcXBpXdku11R9+RmjUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782635356; c=relaxed/simple;
	bh=v42sOHU+NPEhjIkOG/WgYyh8KYHUdpVLrZrg5hNdK2A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L2WHoHdeUoMnI7LUtnQt9BlZOLMs5d3z8dhvX5N92wJNz4evlPJLiYTwIn2dpP9fNHiDNRYQXNBa06VItdcc2npzURnRGsv7Fab4qWlH33v/FwrxD8Ga/vRQwiAFnnUi8lkhG2fMwn3dhmC9VOUATeQCAeUID+XYte4zy0kP4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqPoE24c; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqPoE24c"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-139f1dfc9faso1118602c88.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782635355; x=1783240155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=jqPoE24cMVdOTRmvojq4/L/GIHHRv43G+6W+ToOScEHDdOGT9bzqXtZuKri0umfhrr
         Z0EwFZSjfBvSHGAwAgRsa8HOLgzrZu3v7oTQxqNDUiblgCmrkFxJrcf3zxZKJodpPSO8
         vE/yyetL075Vrxga0JgSbSOvW4sBcFW7+wRtiI2sU6MUXGNvGejXo3rSwY4PSswoZk31
         cj+1oSunKQEfeEFU2/k9b5milFM6F5G34XOo0KDzKS3dobdx4hf8k3UDkUjdimShyLF1
         uwzeDxkFaiabUXQ+kv9e3e7oIpb8G0JIO/HlE8y/zGxpE6EniTNGfT3NfIyeIBVmfuun
         P9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782635355; x=1783240155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=RVoMiB89RbZCPBFOu0S86Plq8EbGFTdaSgwyfbVe11ocYchvKA1aF19cd2LA3HXC9J
         XNpWCDNGUAWIB1gsz/orLEto9yN4x24tZ+YFYHsJMNbXIW76kUYLrYez0asJdHlXgRXZ
         /4DfW5cilXwFew/8fSy1HX9E1NlJg/FPdZ22dMF0vzOcdtBDTlnEKzv8J8xabW9noKsH
         aeW8bXDEkcD8sbjNskBdl5htXQTwu4x527YxP5Jz2DyC7JfPRMplURk6/Q5A9/XQvr8j
         P1LF8EHpuH+EjUQGxy0VxVnrgsCwOPyqU1MHOamKBnRL9frd4+f2KW4GX+0EP1uDTtoE
         gVoA==
X-Gm-Message-State: AOJu0YyUnLUcide17K41ZbqBNMUP1nNznvTEYBl65lSK4Hc9WLQeLi3E
	CIy+1H5x/3eDjfoGsemKwVxUNn8WCfeif01sGKSFqTLBYH66kyi3GRlu9Ttl2/k6
X-Gm-Gg: AfdE7cm95zH00fohUKN8zSvLnkzqQXG++KEFFWGfc2glq6Zmdu2exHvBEXXz20OM42I
	5EKw6E/JDYjjUAmRktA0IfB2ILYc5YynGmnRilRmmVJiYLK7fihk7HnH/hmqtGd2wXACcLdCFts
	6dy+WWIz86k10qtUNb1ENBFhfK5KPQgzVgfB7TkJun6coyJWD+DUVbqnINM0D3x4iu60Xba8JPX
	pdLnjaaF6R6sI5BGQiJu5/PxpgoxOnTcnGVNH/kQ1yeS4vazZnVPaTVpbBoRzbJa9WgnVVp0erf
	+q7mQS/DIgLy+GnxF5BsNWE8WhTj3z4vLe7dxQYoRuakMNPOyF0VPzIJLVNOWuuNGvaellveuWF
	2XDR+W8C7eM9rpQ2MY3po2vR+VQ9RXKmEaB80QW9bH1MxZHA87DcqbFUDbGvi3un2qM3Z+yT10E
	YrEmtLuPfpXeZfpVfyO1hyuJqA
X-Received: by 2002:a05:7022:788:b0:138:916:5179 with SMTP id a92af1059eb24-139dba0da99mr10219636c88.14.1782635354532;
        Sun, 28 Jun 2026 01:29:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.186.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c9c456cf5sm25147084eec.2.2026.06.28.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:29:13 -0700 (PDT)
Message-Id: <e2674e0bc41221af18ece51ad207b6e0561ad3c9.1782635349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 08:29:07 +0000
Subject: [PATCH v6 2/4] history: give commit_tree_ext a message template
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

