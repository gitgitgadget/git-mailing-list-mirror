Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0993EBF34
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771048713; cv=none; b=GF8hyzrtVFhC+QALYszIldJ1x0gLeHWU/KtnfSx2PTYU/5FUQT/RhGmriHEp0BhmhYUvVjbmOYsA84O/eXwVPguAPzzzrQecNaaG4wbr48F63aDGwHLB0ip9q/ILxseh5VuXW0Xryu7kcaWr96ukUCDEEHgPPdWzuPHmWx5jo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771048713; c=relaxed/simple;
	bh=YNwG5it2NGHzjFrEoDcUJjTWcc8QUgcYw+Rsv/cd0yI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xfh6y8lnp0O+f8nBwFPcpeYm3m4mL8sU0EPkCmHVmBcv3XvMDJjbvwtodxbNA40y4RwAQdw4C1wqv2uucnUXo2kc71m9vr9k/DPW/qXw3C+ieGyOWbix8U5OdJhXDUI7UD6OSbYSkIj4GkDnrIZa2AdJak/aFyIGMKW62CjYDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=FutL3OAU; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="FutL3OAU"
Date: Sat, 14 Feb 2026 06:49:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771048164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eA5axkK50FmVB0YyiOBvmTZdyR1TyC9fyWtCAF49rwI=;
	b=FutL3OAU0Jmd24OLqsfZkEE2SQXZ9fyrKqO89RKElx1D1/pItal/0XqVnE/gY6tXLL77pr
	b9Djz99BSMvyZxBA31ALLshEdsrX8MQAcueoznW87M2lu40gzwwPCq5nwIvu3BjSK/fYz+
	UbfK8ZSZlP02QKcKxwW+cAuMJxfECfJa/yRnu5WvWnOuMdUZrqsUgngO5N19n8nIEW97Oc
	i3VyS/9D+3sZLzmVND1VoxnDEL/8IFFiq052TSsn5pgptpAd7mRy62EsPbhM/jR/EpyTXy
	wLVPUHc6MdF1ZrYZXwAgaDu9odDwuNrE5fQkb/jAVuD8Ys+DvTkpR2B9Wk4rFw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Mirko Faina <mroik@delayed.space>
Subject: [PATCH] format-patch: fix from header in cover letter
Message-ID: <aZAMr6XOwKkTa55q@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=mroik@delayed.space;
 h=from:subject; bh=HE0DWZvXSxzFNkGlMWrtKHtWVesxVHyPikcSrPlbxR0=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpkAA56Ctx+Db/8bEx8kGfdVGoyaEUTOUsyCK8n
 26s56TJ6LWJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZAAOQAKCRBIeX6hnBm+
 0Ul6D/9Ql9u3LCSNVzb0Gqs+2bIYoWAeeAdstrifKEGKibGyQsSa5oZr9FmXxPrs1hHz/qd31gV
 Tkk04u6chvB7ODB7xsApKmNA2zrh2uIjemvStA+TRy7yuI90zY8oLEtN4V6LoItDZgReZMgw3sA
 F/Dk+tCGl8TGgIDMNzUM8RXVOpmVsMZFYks9Oa4ZXzT2vxnBFhUafPLfVAs2urTOjQ/7j0dg9OX
 ZJU1y6YOf7l0LEIPp7DNii4sOXRp9rcHaH/Ek+VrUGSE3Hqal6C1rE9FSNKmxY0qdAHZ5W71PnI
 2W6Ly8ar6Tdj3xi9fnf8C5rEanO4its/vpRzdYL5Kd31vtOo3meoR+yzSg264VRsYIddgpf57zY
 NP5ADkQk7iaVVl/p+vhFcBFztsqBN+dd1ZDFK7ykXau28j7/Y/5viJFwM9yK/FilpMDhqdXQW14
 nKJcNnZUUYRIdsvGjyDzlkF8iB+numZmmmUdx6x6G9EV/A7q9VGJGxHf9aI1Siv0f3/43wj7/Zj
 JACIOLTZK5ZK9+yVkCHsp7sf7Ay67euZDY73PolH5ShVmFF/02C5Kk56sgD5KQ9PvMRJoEdcyKh
 8VY/K8qX0Lrpw/K7e2T8B3nTX4WP1cQ3Jf42fCUAQWuDq300RGedSZpoXGZuIks6MwmmyljN8ou
 DV33x6GI/8E7HRw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Bar: --

From: Mroik <mroik@delayed.space>

Fixes "From" header for the cover letter when `--from` is passed

Signed-off-by: Mroik <mroik@delayed.space>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index d43ca693bf..df41b43fce 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1345,7 +1345,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
 
-	committer = git_committer_info(0);
+	committer = cfg->from ? cfg->from : git_committer_info(0);
 
 	if (use_separate_file &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
-- 
2.53.0
