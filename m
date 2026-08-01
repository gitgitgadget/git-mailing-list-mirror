Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03621377A9C
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567217; cv=none; b=WjaGYhcFzDjhNIJX5kDqyud6vDUDdo0w18djPnA/mFOG/CDRAzcZebuDQSs/6DmcFcThFxRzcX06QjH1ibjNEbuoVV7NoaGQnCRyAWJcoEX143j/rb3F2jzBM/etqhnx5WUbRbAyudMtcPV8Mv7YavnBQ+519uJrJpmrrEonkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567217; c=relaxed/simple;
	bh=GGOZy/lURKTb7HppvYvyAdUaVnSbH2QniVC4p+IcQtU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qtpn+juW6XOboEKdjfW0pd0T+9nu0Daqu6THRAlRUUHypuDt9DW4sXrx14qlx5ctdQaoNh9D0VaIxI1kx4ZjaapjMzRtYpvy7ZG7fBkPE+NUwJHMGqulQKiYEYIP794P/OzGqEtPOU/C2e9zg/Al1y22ge0i1zHvY6uTsXBMEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRcK0cuK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRcK0cuK"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so1578775b3a.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567215; x=1786172015; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H57hWFsmFi6KT1Q3AoHvMwgsEsl3wRnEPOBtBm1wPM0=;
        b=BRcK0cuKR8/aD4/LwyWURMySGA3lqotgZeEAXyrdmhXH36dEhu0fJoGy6xokUOL2qF
         aaIDv3+Dl6JT3lPMjyUp2pgnzNXxOpZo18jGVDPc4ErtoYhH5mARVhhaFgEqSZVXJnFW
         AYPDl+oXWLpIzaiWC6BdIypUnITug3ZQ/IvOxRXOZvoOZxvkm4BvJj2YRAbAoW/fcKyO
         O7rVszfYciz6rvsZhrsgKq8g6XNiLC1t3A3oBDukjnUM9hZiLpYetbfn9a4He3IAndM4
         tQXf7IjKDLd3A2r75PZDwUDKN6/pKPAbSYBxM3d94P4FIajXaIZZPZ2P6RFZ2VipeOgO
         OtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567215; x=1786172015;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H57hWFsmFi6KT1Q3AoHvMwgsEsl3wRnEPOBtBm1wPM0=;
        b=eItd4L3Ona6zcpxLfkIoLOKVKscLrPjUuRJ2imJrfT/NHWIBdgEFuhKh8EeqSYV+Tf
         H60dFvbfH78eKbrURh2kdjAvzP6EQXcjRLpbX6GYOjdWCQU/5j8bHz6eqz3fRRglpp4l
         FmoOaOnTZADNUFiIt2+zuPSMLfdGMlhiadFcRFWGMoUALo3b3sm0y+mI/5HZnlnOvxJE
         gMEvaqjjlXWW/096L51pFFMnPvtwISTU25r6QIFQbB9ZjvzOt3B+SK4iu1OjKMpnWTMk
         CSpkbMYUqLkDfn7qSDcSgD/sreRgDfDmUsvclfSAWO5KZkSgkDdFsdD7xgeNhUTcvnYl
         WH1Q==
X-Gm-Message-State: AOJu0Yx2mDXLtDVQYvSdVheAyn190eKCkZ4OB28SXiKZMOIjvbcogaPp
	Fp59+XU0749tUCNLSGX6XCvRQ6mrpuKJEUkJHvrhPcEi0Sayfk6KXsqPYnpVYgDw
X-Gm-Gg: AR+sD11o1+Gnmcx5GWGcq8bP9sKxafQlbLI+Z0jdDBXtn3GcrYiVgZHpV3lVT+1i1sq
	ekAGnjtYtnulsYS/S+JYjLfGmbsE0oYOGojYEhZzYtAnLLeKnQ1DBweaw8AReKW8a0r075NhIBY
	pTzroJQQ0B/i0cZuzbX28ys1/8GTpZ/HtY1B4Z+gHOBCapxL6BKNW7zaOGuykO/G7aZUyQO/i56
	b4SvdfGO0o5Co0os+xPVkuOAs5bouiiR5VBgXSW9Kun+mCwA6yBPvCPpCS1ySc1BuIhxoH6umOe
	Qehc8+IFexGIJIeV+d6ppWVyE1zVu+tbdd/cVN0DbGwGb69JVET0TGnIlXnPfVImOkFHQnADjsR
	WsmJUcNpFq3RHINKE6vqM6F6o4Hw13fomsxx/3s1eY8n2Mib1IsCL9fWM0+rTBn/eJEyvM2twsb
	KheOic/hvCt1NgJgio0HutI3AeWUGRg4zar2Y2/F71q6XVJIX9FV/uFA0VBfuIPlg=
X-Received: by 2002:a05:6a00:847:b0:845:3fe5:cddd with SMTP id d2e1a72fcca58-84ee48ea6c4mr2139480b3a.36.1785567215189;
        Fri, 31 Jul 2026 23:53:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.138.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29c7e3sm1358566b3a.38.2026.07.31.23.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:53:34 -0700 (PDT)
Message-Id: <7309f6448527fcdb2aacf3f73cf5c16ba8238976.1785567209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
References: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
	<pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 06:53:27 +0000
Subject: [PATCH v11 2/4] history: give commit_tree_ext a message template
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
index 673744a55a..b592b98393 100644
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

