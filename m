Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357948034A
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128581; cv=none; b=nLOwcXMfWR97vqtiKeYlaxDByi9743f6MGxFa14mmBAN1gjrXTm04C72BSeXXThlkMlabYU8nksI47Cm+1UMaakwKDCCiWbwy5X01UGrZMizhEtSnZ8c6aXrjdHHyNW7pTu+kfQ5lTIvPMyuF9NXEhxtXGBD8LxnM91XFBM2ssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128581; c=relaxed/simple;
	bh=kvrel2DGrILSR+QVdRbzx0iv/TvNoVYvcJgNSpRyQIQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RODKzn78+IIR3ARJe6pTsDvd5Mkhc0GNoXlS/7H/tsv9WpUVS89FBqBeJplAUFGrfKGY1bmYIOu7+vsTE1EAIyNz8M6SrCIcek1Hg0MAy4qo9XHx3cl5wvbBzk8eJhFaCcJWr0inGzkydtTjYrVclZYCc01O8ksayoHOQnDC8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suNlBMb9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suNlBMb9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2a76536bso53150231cf.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128578; x=1784733378; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z+1Sw/8P4wb4iXGktmtkJYjUM3THK7Z1ZrK24Dzc4+s=;
        b=suNlBMb90PYHUPFU4jnHri51F4g9GMeNOTjkQjPG6EZBvmngPuHW2t+7uGwlLgYEtE
         NHTGZUaDQ4bhMetoOsiKdm43OdaIQ9tJDkxmr5RmnOTattXzNHNzE2rfWB3juoy248MF
         f4VI/k9obnE9mvm6sTLhsO30ATNTSe7Q+O+NTE3T4qFeKEI5MByVi+GSjiPHKxEKK9Gg
         cpNEqQuxi7DcPeT6lc28cSiUZMZfD97oOWlctMUSjLENQKkKJwG3tZ9gOK0Gr/Rah7Rx
         Xrz5tfGojep1JKd4GKf2KRV1FaQ918LQDFraOD63m5bxgC0MUvcDO46pvqNzjWRQ278z
         0gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128578; x=1784733378;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+1Sw/8P4wb4iXGktmtkJYjUM3THK7Z1ZrK24Dzc4+s=;
        b=g2N2WEIs3lqqQ1xUe8DVDYzmOxguDKVTgsoF+KcCAz2jOE8Jcz1dyyDc5abP3Ns43P
         ASZRuHiBxjMrcmZqc13lGYRhUqwEO8hNHEqGJueq8jDFTnVeDlaCgEPOU6kTu1vffojn
         HM5hy4aUH6J4DWEBV5fv4lLAn/5B17F+GEaCxEDPWIK8ufBE8Jhv/Mxy8A6j8Uan85m+
         00tS3nfZtrw4hA4cUKngKvyHbngK7mM1gINbNX6KBKwP6LGwZcQN60Fo/2qqIC1CWmvD
         f9v0BvePRZoloNvgQsHxqfu45YutAug6UUxbDaQDCahBKb0372UfRg5+T7lwxwAqSiIq
         mfrw==
X-Gm-Message-State: AOJu0YwNG+bSWw+JU45NRndVhCleX8UVd0tMAMfMY6XPbW0NzZYQTj1H
	C8fchCmQnepjacQJDxvWUGADQs3pF5Hr0TcKBmoP7Auby42GJAM6ObqkQYFHbJIy
X-Gm-Gg: AfdE7clLM63VscDHY9Vk0Ni1Uhf3CXYb9YLvki4f0T+mLK1SgIBjdNINMRyT4xM5wnz
	9OkOFCZft0rvH/JU1lGpLfa5brLGZ1TX3ve7e8siVYZk1mTB9jcE8DGpU8h3c3EsfyXXG8HV/7I
	6yUV6QCd69iMkJAiTPeUnvXkoQrzTmglWokLkyXggNFNTjYu2b2xyGy1HyceZj5324F+q/L0+3/
	bChCiF8i+kRzUKAbZiR2LIG9N2roPRd9zL3jVlI4xfh2QJU4umFznE1JSS2rlJac4ga/M6Qm5wA
	D4pHF99VxGYpm0vOi90LegO5WEWzJLv4pAGxju08KVsNfm+cSoXo4IT3PC9FNWncGXPy2tk4EJt
	3+ttRZh2ThY59AG8DVENritoaCpZww3AVpSAFT6tOOjynYw+IYEoNaFryt4nHtuIzUR8E26W5pA
	HQycQKQq8KKGPnJjI=
X-Received: by 2002:ac8:5a86:0:b0:51b:ec6c:766c with SMTP id d75a77b69052e-51e4ede1a5dmr35053821cf.12.1784128578001;
        Wed, 15 Jul 2026 08:16:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.175.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm140504751cf.12.2026.07.15.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:16:17 -0700 (PDT)
Message-Id: <e06e49095b48c7323157851ae233e9283f45185a.1784128573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
	<pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 15:16:10 +0000
Subject: [PATCH v9 2/5] history: give commit_tree_ext a message template
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

