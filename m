Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793390889;
	b=xhdngL93KUwpFsfBLcNI8jVKqpwiZi/6AXqm3+jE3XVW7M5COvJjmHUUcFvK6dccyOnu
	 4tHe031DJMC8lta+h+uWpBHViqwtpZNc2efKKCLTF6Qrdt1gbnUTH2gCThZyv528SO9tw
	 ja2IAN9iFJMV7oLbBIiOsRVQDDAhUMa907SxJkuzZXCfAS7KvCjonQWuVwmdR/WUzTNAb
	 HLTRksqLgHFUqsCkbRV8Qh37t9o7AMbuBbl/6WXbOA8Oc5L9TFqEr1TfoFcyNzzXKWU88
	 Us/gNdPOzBc4Z1LsPxLLcNL8JJ+HniVmqkxuWDkeVmi97I2QNJUN7tl3bhtecssDO5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390889;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=xgJYyKEMwSNOZHo0M4xDgbkPObTNq+gThO0M/CVG7OA=;
	b=ffAokuy8kbs5kPn9fj+iK22FlumbpT+IkKRHcAxlPVkE6LNQH19txneeCULZW0KLxgto
	 6RJBDkchuQH0xo/f3BclqSc6jW7jg/3ULpVi8ehZbTA0YVoKNV8BQ3Z35kBEpuRaFI1c+
	 insy72dZ5drzQmgZRNtcOoyNmDudNeZutyFS2E10+3gwwVSjXSxqCByQsZY8+QEatwEfF
	 bxL17ceT7Q68GJXTm5J/6BbF4PZ/rhLD5X6cmXSefSDZna6De9qPGOWQkxL+PUefkvu4a
	 foE3vDYozfz2pgXqK/Qdm8/5q0Q79niHmgxGpNobWBTfvCiigsrtS655J3ktY2k8W4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=lOLD2Nz5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B132606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B132606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=lOLD2Nz5
ARC-Seal: i=1; a=rsa-sha256; t=1793390880; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vicka3a7KBp92Hx2wwnXW+dRqIUAt0m/ckfik4xvz/C/Mz4V42iB2hPpArRuB7B34GbkoaxPN5tKN52bCcdnPMzr86mB3kd8jfoeix8megGEzSUKc+dmxRqkywVk5vrFaz733HAUhTi8G/qCa19F/ljKafBv0VOeqotdi1qdnWM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793390880; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xgJYyKEMwSNOZHo0M4xDgbkPObTNq+gThO0M/CVG7OA=; 
	b=Oq3xaESVnL5TTAQDe4Wq1el+xJoFR3AY7D3IyZiJKQxZF9rtK5g0DYSzG03mRztwKhhVH7fJjJ9U5zD8uaqL+bwi84Qoz6Yn4K4wE0CgsxZ5v3ZZu0jGB/3ynlXL3zMG0r+v69uJQLjjniKjbXRdCYYgbZJHab71THXmxfpwhq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=lOLD2Nz5OwPxATLaHyYh5RS0vlQbZAuybRoME5jeDCdvRCCbEp49U5nOq6MHe0HHaPq4gTkG0asLU4TB1/vUTeLaoDY463YKWYVgglNAFftN8+C+y/4o2oGMWloCGvN2sxCSercoNbLtbgY/iu3eHA0ERWej+wfyF4hQsLRIrgc=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=xgJYyKEMwSNOZHo0M4xDgbkPObTNq+gThO0M/CVG7OA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17933908775821015.0299235410556;
	Fri, 30 Oct 2026 13:07:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:07:53 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v4 2/6] log: extract showing the remerge/combined diff of a
 merge commit
Message-ID: <b172890bf4c80d54e653168baf9fad65073fa667.1793298331.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1793298331.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.370.16
X-ZohoMailClient: External

No functional changes intended. A later commit in this series will also
call log_tree_merge_diff() after the parent loop of log_tree_diff(), so
extract that code to a function to avoid duplicating it.

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 log-tree.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..b4c97b86f5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1180,6 +1180,26 @@ static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
 	diff_free(&diff_opts);
 }
 
+/* Show the remerge or combined diff of a merge commit */
+static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
+			       struct commit_list *parents,
+			       struct object_id *oid)
+{
+	int octopus = (parents->next->next != NULL);
+
+	if (opt->remerge_diff) {
+		if (octopus) {
+			show_log(opt);
+			fprintf(opt->diffopt.file,
+				"diff: warning: Skipping remerge-diff "
+				"for octopus merges.\n");
+			return 1;
+		}
+		return do_remerge_diff(opt, parents, oid);
+	}
+	return do_diff_combined(opt, commit);
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -1220,20 +1240,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	}
 
 	if (is_merge) {
-		int octopus = (parents->next->next != NULL);
-
-		if (opt->remerge_diff) {
-			if (octopus) {
-				show_log(opt);
-				fprintf(opt->diffopt.file,
-					"diff: warning: Skipping remerge-diff "
-					"for octopus merges.\n");
-				return 1;
-			}
-			return do_remerge_diff(opt, parents, oid);
-		}
-		if (opt->combine_merges)
-			return do_diff_combined(opt, commit);
+		if (opt->remerge_diff || opt->combine_merges)
+			return log_tree_merge_diff(opt, commit, parents, oid);
 		if (opt->separate_merges) {
 			if (!opt->first_parent_merges) {
 				/* Show parent info for multiple diffs */
-- 
2.56.0

