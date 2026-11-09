Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211519;
	b=hgzARkp2JZerks8KX8gVLPa8rb3ueLsPoMzR7e4z4PE9E4P86MNQXxF8g/aSHK9Lzpv1
	 ewT8rsE9IzJ52LjUhPW0mk1TkQkfgw6ZET4ZraWeSkSH/OJBBaEHrZnUrSHdv7yi4uOiD
	 0fuT208Qz6AHbVwGGGA1eoUHZ8yjnpMvKgemu1q1dYdum4mY+MqWGaNTwS27LesFjpqkF
	 KaGaMbvltoWHMmySicbLfuR5x+c4zDYguZSeRmgjbOuy5TAgrAMpj1rFzVJYXWGqSuisB
	 RDG5nhNUe487se/3rvkhVAr6vf7Iykqe7bF5jGIxgQdcuKoHTXHRgiT7QriuwFH7ffw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211519;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=EKL86dZpa/Bky62l8ujClcGftEqgeiju33z5h45CDME=;
	b=0hgQyi4mq2Vu/JqUCLcJ84TwFwGituV7FzAX/2n8jagMymKkY0XN6Hu/Sd9V7V4gF3/P
	 HmyvriL4MmnevoVLCXT3iSUm08Cu4M9Tv43w9a4knzwydgvE8ctd1xPaVpi0+syxBEcSP
	 DfVuv5cgRo4LUJW7NlQfEsV5NEiWiduy7oJfdlqsRUHUz0RHsJ/Rmdvh612X+EALrrF1P
	 LEOj4dCl9dgu5Teny6aqlkvZxc17mh+WAqm0d3pO6PDtpaw0xBO4Fa1uVt1BqMeZJA3Tb
	 E+hXmiZxyIW1mJW0QSP9uFGk8lB5G5pmb4CQVOcvZ+1qQn/kgvgPTkjRzQZZ7i/KmDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=B4Sq0q5Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.109
Received: from sender6-pp-e109.zoho.com (sender6-pp-e109.zoho.com [165.173.180.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CEC606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CEC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=B4Sq0q5Q
ARC-Seal: i=1; a=rsa-sha256; t=1794211511; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=APhXzNQ+E44P5e7dTbNBXJyF5ve7B2bPlHrBI93qoWQ5dKawqxbjwhN8ZvggTks385ayTwaB6Xl4ar4aIcFS25QRG0pRL8d2gQopeHNPf0MxAtLxdSKnECYKPzMjVheaCnCSrUS02mA0JAe6pEA5O74COXVg84cdBeoS+FEtkvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211511; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EKL86dZpa/Bky62l8ujClcGftEqgeiju33z5h45CDME=; 
	b=HGot/6gfnYvI4doUX/o8AqoQd8/ZH4Rns2p2ZhllJGRPOCwhAdRDQLYzTnBDqrCylrvzUV4tRFcyuhFdxMO9lCE2843efBhJrHrz30XkxJBbWKMF5yuLpBpdg9LUOu4XPrDW3HuhgWWQTsNqV5ZvUsg/V1TPo4aj8tbjnGV3L4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=B4Sq0q5QkXrwMF8GXPgFVPTgiyHXY/GQodQHae3P0WVdyf9t0hSP+D9hjZfOcsRiqwiVMsBfIRLPbvPVWBowdHfYbgmBd2W9MEApJiAkMJae2LGN0Owpkp97o1ZPcdTYi59GPcbhcrwKW8YpjPbD1OYHHYWN45YmiYvAD2y7N+w=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=EKL86dZpa/Bky62l8ujClcGftEqgeiju33z5h45CDME=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211509506672.0261996172924;
	Mon, 9 Nov 2026 00:05:09 -0800 (PST)
Date: Mon, 9 Nov 2026 09:05:06 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v5 2/5] log: extract showing the remerge/combined diff of a
 merge commit
Message-ID: <f36129714b3270b788dd44c43c7cfb01c9e00893.1794078554.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1794078554.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
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
2.51.0

