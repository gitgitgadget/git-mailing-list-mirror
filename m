Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8438F259
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249440; cv=none; b=tp1z3uUs1qM1XeITKnF/i/xbfbFLtfIkm+DQXtZ8w97onqPmj4FgVcwttfLy5QSs/0LpjYz2c3UZ8htUpg7AsB5p9FaMz2LDdOteuseTzMTHUCkufQQitMYcoxfMWmjIDwo34Le/D+Vcy1hJRJvDUvOtTYyujTyFzeSKkS1dUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249440; c=relaxed/simple;
	bh=Qlw5ArwqpUvv+GwBilOYc/NbsKYNhuo0w1wlRcFsLzc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rxiT+sytozX+YmbrMC4IMzXirCxtSJNo+P1soEAzEX0o3zozWGFay17kUchCe0NRhT+bzutmsab8bqgYZYK5JpIH1tcECFJR4q2RA6Hpn/3Me64G3H4tnoY2+MKZBpmzgmYMBdbp/fBm15rsufZsqt1akTQyEVAaunZZTkQ6Wc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj1jUcTv; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj1jUcTv"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb787dec99so132874a34.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249438; x=1787854238; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=mj1jUcTvLdy2dkV/TxUOAK2FhOnFmKJgP/Y6J+P3fZlKeJU9+b9ZbItvlNXFI9beC4
         RAafTRiOeCs2M+YojW0KBjTS+Xt21DpB7NMC2J0ZpgPtnbe50/Fb6kzHH4PW0/0wVmmQ
         YVrJaY1dZoUI7JGMhxpQZ5Zka0kQwHxpxwal7FCWVaXfGBjE2mqaRu2Zk5AVKvvRmB6i
         xKp6DeJGXeVl6HHCVVtRCXsVbpVo9sONDI3WOwF+35QcwhB3RhP05qgb0AXGS4CuA7Bi
         nom1t36WANvvUJrfQ2G0ilEJBj7zV5aTh/K4wBIgEwPReb5dUmCg3wDIWaOAQClPC7A5
         ymzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249438; x=1787854238;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=djfIaJxtraI5yBRGZ/B7NVIdDmffJAXMQaxIECFX70SlaIZ1jD8YohFeq8/7evy/Pj
         wonctwMTX8ZnLSdHwR5SFvlVsTCChra7hb4nDKRHtc2Mxew/8jB7UcSSNk0HIZnmymFQ
         TI3MulyIRHjiwq/pT4bZMbgkC9g3Nyez7P6lluvj3hYZ/n5MIH9qyrNCDwdpKo+6bKNV
         rRXoeGKSwUCiq4viWbCxDRYeLf/504Ehlx6u5vIm9oT6EwPesC2FnehH6Mp7/r8Zn9Qm
         LfjeZ55GA9Y+JvWk7CJF1C+DPxGEamcG9Gym9rf6XGIKWGRECssK56l7iBaH8j2PKmMZ
         cm4Q==
X-Gm-Message-State: AOJu0YyJRkqmeFhi/WPHPpv08Kc2N7uYc7F2LtSQiy/vfKCI5+3FGUPV
	nsnVRsqom9OvG+6zBzBcZg3PkgUBlyuIZGSlLREhprI7t96x8TOwgF4oLpYecQgA
X-Gm-Gg: AR+sD13gv+Grl3gjr6eZYUIeRVQqpIfG7gZEi+dAZ3Fbs2X2vEDiPXOAH0F6tVF7vUv
	WHUvylnP96TEolCbNHunw6IJS2Th9kmTDw8wF/GeJjIaynNIl54vm32ccokzbh+zqcu2lcj7OJt
	4DnMkMg07BigHTfacQgwlvY+AzvtDagYsvJD+d1QiLcdw6sD3uKAOGPFErQ/ISIHvWHE5+ACLAX
	7W5rIrYOBg5Ceg+kFhFSqc4tr3ISBGp+jHgWuR2uBsqZCCyUgAuuWp1wsMwNHTaGfj8S7R8Vc2b
	88sroX/ciV4i7XriQDfwbJEXcCDaL++wZ9/+0AASegPXcqPbrrRAwaPsaNoPfhjveSORB6kX34k
	8oMnbt+o0rUPi3TMJ6tmHHN/f4rWkjMp9GqaIjW8KSEwWRB50L8qoaPZl4Ntip2tudqmSkLqUCB
	X046lXMaz4nhUuk4yOI6ThhMN1FTtLUoYaoKSBhQFS/zDrjfjJEGj9VXm42ZyyEb7OCi9f3Ma6i
	CA=
X-Received: by 2002:a05:6830:6a9a:b0:7e9:cf6f:aef8 with SMTP id 46e09a7af769-7f46140436cmr342192a34.11.1787249437717;
        Thu, 20 Aug 2026 11:10:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.251.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fea85b1sm5936704a34.11.2026.08.20.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:10:37 -0700 (PDT)
Message-Id: <aadb7a5df4366639cfffaac135d51c2a83739d08.1787249432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 18:10:26 +0000
Subject: [PATCH v14 2/8] history: give commit_tree_ext a message template
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
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
index c22715d848..a60e8dbcd0 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -108,6 +108,7 @@ enum commit_tree_flags {
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
+			   const char *message_template,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
@@ -137,13 +138,16 @@ static int commit_tree_ext(struct repository *repo,
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
@@ -196,7 +200,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
 		return -1;
 
-	return commit_tree_ext(repo, action, original, original->parents,
+	return commit_tree_ext(repo, action, original, NULL, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
 }
 
@@ -675,7 +679,7 @@ static int cmd_history_fixup(int argc,
 		goto out;
 
 	if (!skip_commit) {
-		ret = commit_tree_ext(repo, "fixup", original, original->parents,
+		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
 				      &rewritten, flags);
 		if (ret < 0) {
@@ -886,7 +890,7 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
 			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
@@ -903,7 +907,7 @@ static int split_commit(struct repository *repo,
 	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
 			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
-- 
gitgitgadget

