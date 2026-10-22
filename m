Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792701987;
	b=xznH/E+JLTjMgklKGAQWy784wCaZZrt+VrXqLdc7SNJk2OafzrU3nwtB4yobcjNPZPdi
	 vF9HEBZssw7GSLUYArnScaUr2flymjr5/WxLZsHVQp46kfRWCy9En1U8r+vkVNDEzldBr
	 6J/xzLl3rVTbJAAp/Av7xbc5n9q6LSDMWFpueLDPjzSJBWhCQasAgZFnyMngX3SQyL15Q
	 OAkvlK07hYp7iTa1giIfEswgCJG2gJ13eAA/PpTUJGWyCXFh6+4LwvHzcU3q1+b0RB8X+
	 wGEtMKWeSFkPoe9fvqLA0Cg7wZGn9BEMq7JAoNUdT6TjumtIf83EmhH69oY1hCUXvrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701987;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=xgJYyKEMwSNOZHo0M4xDgbkPObTNq+gThO0M/CVG7OA=;
	b=uMA18jLeP0q0cM1fgZ0VyTCJyTJIo17sH54Ax/QwFBkypEn7Dsz0K6NW+cHmtBvnz4e3
	 KgbGz6jeBAbmZdlUjE0HXW+vqDfDXm+WzUg9kCoHQ7ZAjuIW13mGVRDsmoFd6kphWAzJM
	 W9VO0rXcOB4zcjY777g1Td9UEUbfXpz6vuDwU6vU7vJovUXq3T4FISwDRMq6lOmHCPLnq
	 UTtZ7r1EnHS3rajJe3BSrsRA2sALN/TzmfufHhCXuOL/B3S7R7SnZrY7TS5hjrwW86Znq
	 9WDM7941tFAM80k4I6IAU4WZ8wY6VWNRh//aW0F5aC7eNZzIPsTPkDeE5C3Ck9bpisw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=UxJDZnym;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79D606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E79D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=UxJDZnym
ARC-Seal: i=1; a=rsa-sha256; t=1792701978; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ubng4gsa0ov5U38dRg4GnLeCUOUFYL1yj2+veZh+MOzb+0GqIUoi/AUaGrqVbUcqmrgRMy9QyzvH4qJ03veo2ArJizKlL8UTFJaffd2jUySWuthPmwJ2FQamcR5p/piJ4K53NEGULHv9ugP0AEUKwoXj5tIt95RlPA9IXgS8fWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792701978; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xgJYyKEMwSNOZHo0M4xDgbkPObTNq+gThO0M/CVG7OA=; 
	b=U6ncu6jfe+9PkMBeDcwhQ38cIt240pcdTptJYVTGHh7nrK9kGZJ4qmY0Sudi0OIQSOEma4vhwjjX1G4mQdeK2judOkFMJAfU0O8haF/6fggts3wbPs94OH4tlADFTut7+ID108yeIs1O8RSnY8QcbA1BFfgZyrftHDnedI01Tf0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792701978;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=xgJYyKEMwSNOZHo0M4xDgbkPObTNq+gThO0M/CVG7OA=;
	b=UxJDZnym5mnrCgS6NG+lrTHEDtssMJGoxo043fAymr0bxwlal0wLhPlMrWNY1mKy
	WJxAItZzEbJVR6MQ7CojnFzXVcYW9Ky67vl0oqV8nlJU6uYAd/dcVptKwchvYYqmAcA
	/c/5DRxjpvszeTZWXd5A2ffWqn3Uk60Ih90RxmmU=
Received: by smtp.zohomail.com with SMTPS id 1792701977435728.2994532176023;
	Thu, 22 Oct 2026 13:46:17 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:46:13 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v3 2/4] log: extract showing the remerge/combined diff of a
 merge commit
Message-ID: <2e734ef5a07f3d92eabee6864d3968b90a8ad7f1.1792701579.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1792701579.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.682.56
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

