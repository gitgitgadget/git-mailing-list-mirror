Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A83CCFDE
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536030; cv=none; b=aBu75aGQjGtaOARY0d38aT8ANKniDkVGtWoy6tyxvGqNBGI5dhiiiJxlZX1GHmPxyPITeANlhaOlK67xn6J5fm1irn2lnLhsFUQ2wwfZWqWnqMVFDwhsoXyOC3Xq0Rsvsa5cx6USMylKqNUlUZXVqXJ7zoq7m5nR+yzXuZlm5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536030; c=relaxed/simple;
	bh=GGOZy/lURKTb7HppvYvyAdUaVnSbH2QniVC4p+IcQtU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L5iu5gOLnstAgu4WgQcDCRl5gIVBlqoQm9loWayKLZK/Vq6oCU+0a82OWsRUMul1PAfpaVvB62fMjqXzzpr9vwI6wjTgOfSRYAARmatfYw5YpO9qSYl/4BJkoQ927lzY6tVw99eKqqa9HqoPlygvcxn4MMA0IlQybiAXLWVLwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSBFZX/C; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSBFZX/C"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c149c5722so44389841cf.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784536028; x=1785140828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H57hWFsmFi6KT1Q3AoHvMwgsEsl3wRnEPOBtBm1wPM0=;
        b=RSBFZX/CKHLX/7A/1EeowpArOPKdwfJfwhycxkZw6ilL4egQ0zx677dXI1gWgWbPSm
         KqdtITKjXVj6pAkubpyqqxZc6LoKQdkLl9b0+zfB2XqVuTZFY5inaGz0rNcdSEzHBbSS
         Z74/88rovUq0MDXVzqFWlEFyYmxa9Ccx+xZXJSoJ7YnQDsOE7Xdyugz5AtnITNhRufTQ
         WIyxxkYp5rOpxuEAF0/Cjmny2LTgzXadj8R8kyucCWihbeIuD244BkZ5GuTPeQiGQPDL
         rNKoDtg44ydkh4zAgeC3l7L86VPbXLNV0vEc2nOqEqvSdnBK4h6/xLLTh8wTLyxmHxsV
         XnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536028; x=1785140828;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H57hWFsmFi6KT1Q3AoHvMwgsEsl3wRnEPOBtBm1wPM0=;
        b=f1wxS9+siNX0KBq8DGPCJpxD012e/g1BGcuzVU8jkGNJqXkeySS426gbq/5hb3ieGV
         MNQEz9eU26QcPAxAq+/JGBL10t+ncFLFD/JM+CATyExK98lY87Yr304zft8aCvkaEguS
         4J76l10AStkZXCF3T/SRTK8n62nF/iTICr9p9nY5cWQ9vh26n53iWlGNtJcFUOiO+xZ0
         Ws81OpP7ATtDXRrJ5JSxBZt0rvni7CM/tX16wq3MN/uKzEfdMMedZUySy18VBMR3M6Be
         D+BsCYBP578XMHC6M3VX710u7YM7TUeC8MmWYhinQmllvPEei5LbSK2C2QkjV+4meQUO
         IKig==
X-Gm-Message-State: AOJu0YyYmXWORUpXPpu6q4CdwlRRuZG2CXzHQ3Nv0QymXovnbs32gQ+b
	1Ap4BUxFMmqe4n8Q/BePz4qFdc7CTW8XEj7RVuD+yYgk0WLZaIpVVplLGIolXA==
X-Gm-Gg: AfdE7clWcojFozC5E8SP53YXIP5/7iKaJzQnrLTZsJ6RmiRCdhreSInbV9B1b9QBsoX
	Rm+aQdZqF9jBog2gdukGAcJqruB4YKlZXdboqjE/1lCqNlLaN8yRQkLGCsOz04wNahpqvtGSJJH
	d3y5dCxdyazsLTk3VHrxSsumZOTkQ3oxANS93HiNHf9DBW9JDA/P75KGQ2oGOOJ6foG90O4n57Z
	/iSC37IgSoBaaeWENFahi5cJbZ9JxY6tax9jQFj4N5Jbs86BgdDWKSVCqkgxaJNCy63GvEqswm1
	UdpDCqPIIdPw6RpXOs3kJ/7wwtmV69yqldybF7skF4XaYaHA9fb3t/Nw5BHAhgSgOXLpE0alZt6
	TWpk4x4/vnu0bbDuy/2TZqZsXHxzfIyQwYY6tFZNrxJI+PqQmVzq8Y+vLdYAWtmsuTVfrIEc8vX
	mUYJEHS8OT2fk9ahJC5g==
X-Received: by 2002:a05:622a:1b29:b0:51b:9873:e37b with SMTP id d75a77b69052e-521298a7b52mr115460121cf.9.1784536028038;
        Mon, 20 Jul 2026 01:27:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214fae361dsm67901571cf.25.2026.07.20.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:27:07 -0700 (PDT)
Message-Id: <49dadc341083b8dfbbee43e6c4024a695a57e856.1784536024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
References: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
	<pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 08:27:01 +0000
Subject: [PATCH v10 2/5] history: give commit_tree_ext a message template
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

