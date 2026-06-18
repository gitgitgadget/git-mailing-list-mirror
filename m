Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B50330337
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810233; cv=none; b=Tqld6ECw+rKzVrrgX0TxEKLvUMsPWkFoLEygQLtPj7hrl2bjh4h1ZfV5uHexglVh2Bc8YbucpIhb1opYxW2PtJKfU9uNp83aot2TJVbxU0EiOq4G0ntaCGpKQROPQQ4Eir+nlzLsvjPpwqaWagOGQAk9ud+NCnTV5h4jzYtPq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810233; c=relaxed/simple;
	bh=v42sOHU+NPEhjIkOG/WgYyh8KYHUdpVLrZrg5hNdK2A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YEMgnk9R7kNSRDnlwrTxPnh/G+EGp3aTLEd2es3197gVu3HLbSqCIdXJpZngbkrJBWGKOYnr//gCzCVmXjfaCS/BM9pyGah+A6UGDIkCbMNaweJB2AjMMwIFRRcDs6c6sTyfimGx6rNBb3zQTidBND0xGLDU2hb43SiK/qCq0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIZ7pq12; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIZ7pq12"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6611669cd16so1899585d50.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810231; x=1782415031; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=SIZ7pq12y0+UW6xqg3vhrcQFatYr9/CrASmNN/mRgvIxDfOnoO6E65Bg2tBMZ4+ZRh
         ckTUJifr/G+jzh2PHMKz0LxsOQGWWYKBn1Cd6NzA0LwrW5CWG6IsgVspbvgYdHtfoirW
         QbXWCtEG056Ql+Pdxbj4aa8SN5Ye4Gxo+JCfyFDv32wzO84chwXB3FfZ5qtXM/Zt26DR
         wELJNiLkrHG7Ell/+gkrIxvIOsU7pRnOipigsRcN8jToGTcQWqJVkfuumvmSGiQScgRu
         pqh2/PITKkZQs/mhce62r8SaoKNAhOml76+qDQ0XiFYats+DvCzEbc0uThb+DVo+GYYi
         kChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810231; x=1782415031;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=AZewDuHlgef9ZfzMw2yyHzRhipTG9sDg2Zg9vt1c2BkRvR+kjP34KMZWmFY5ysX0Bq
         dbSceGlDOK7SICQvxw6kCLpFLn10tL3EQcNWDUBtgEjin9Bm2lY94tHTZuSz9nT11KKI
         qDF7/gCVlYF/+MTPTmbWmRljWQJFuDyh+88ntf3DMJr0pCjF9Rcbq+hE8JS59xd0eNZe
         pa9S5xKZQrDsHqZS4FVh90lau01tKPMdTwsvRk82VRQqTYZgqo/XA4tWS6kw7e4ZdYSb
         GguyXDZq1p6r6E/yGbt2lGwJmKkN55NGTAK4lRxGdlRFAu8Xk1DaW1ThB0yIMRdozBh2
         3FDA==
X-Gm-Message-State: AOJu0Yy1Rh0xJKmX3GqtqR+oE5ey85aFgodRkDmbhAMWLFINZWSONQ6z
	5L3puJbbe0097rHovuALW4hdsJlsH6vfsfgItJKwlz7q9niDnaKlloqd0uSFrw==
X-Gm-Gg: AfdE7ck08161chtjp9V7XFhBG2IkjzmOWhu//XNT/QqAf0z0SZX6NkmpNsN8PLTCxXz
	bfloF9Cf5Z6r2y+Kx/4bu2+MXgK1fGPQf0QBm06mV44KkcnW9+SvZ4A3Gtr6YOgSJax7RqHgNVC
	n5F2cWhqEBDazYuDdqJSruTnX0nxgVIqgo0HnUcs2q1Nwpp1U/77+Hwl8BG84g5C4a1XJSNhrrz
	qCB8XEvGj1xrrPXsCrymlVYjzlyTzBo40vFi8Kw2n1a0PnL/B5W1XuVz1mrJeZsiGFDbtM9ErcQ
	Vmuoz7Snn+WPyrl/eZO5E3aWFJuku+0VUUF8jLdsMAfjDKE0QOauPEjDVaZZpdhZWSf+6TWgg20
	6GzesZoH7QSKWSiQwTLYEBX+TgD5N0/TsD94IfFXlHeNx5nuekSC3UBEuSc3acSM44GCFIeNe0R
	A4Bijfx8I/zpNWDuSQSX92Ihf/zw==
X-Received: by 2002:a53:be4e:0:b0:662:e7fe:a8e8 with SMTP id 956f58d0204a3-662ffed7460mr111091d50.31.1781810231202;
        Thu, 18 Jun 2026 12:17:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12c6dasm462986d6.8.2026.06.18.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:17:10 -0700 (PDT)
Message-Id: <498da64046f676b57fdebb0b62a38adacd7eeb1b.1781810227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:17:04 +0000
Subject: [PATCH v3 2/4] history: give commit_tree_ext a message template
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

