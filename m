Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515214;
	b=FVJSpGNign26cZ8G5uijYFcE9EDJQaymRPGOv/sjIfu0q6eznT1Ye0cQ1mAxoWQb9EAM
	 YR+cs5Dk0X0rSvxVCh/H0KtlN+RrFikWKsBpvhnqsC6i2gVAuIacnCO43ugLF22d9JM1y
	 GaDHuBKxAPukkAQiTQnunFd8CkAEaiayujHRMIKYtkgBwKQQpcDWaBsgo653LF6dmY0CQ
	 XC8CMsiX5RRdO1AsRQqTiW7XPnBAC/jQL/5EjwJQ43hwRa/6ilW+M15LsyJ4sDZmP92Ei
	 MYt8VsKAhPHAALnDF8lYU4/2xf+r/zXvBwTqYYf3Y9BdIzTi1J7zoay9HLnYEBQ/o0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=e6f1o8fuEFuPdBn4idpxljQ4M60y8fTZnD9oREJ3Uxg=;
	b=WFm3a2wpa1GJMtQEbrVeTHcHSFqNA5ri9SzMXVCE9XMz5sx1SEsDhZIivog/6ofJkfyy
	 TxOolpL1aFr+yl7fkaCwSIiSt3Qn3AqRj9uduVhYbHcgaSIQt4MoXnk6Uh00cZbAb/n+t
	 rCuT39Sa+iE6aPoz5VWLVZib0WoQMv5Qjjr5t+uXaBJ5XInslZs13bPYUJBU3lmw6XjhC
	 4Uxe+M5jxvhQOg2/W40sVq5SKO/jC30frInh3ynxgufp0IBLPSvw0w+0okuCsIQCJ3Tvx
	 1MT1eNNpnhFLoef9xKop6H5hym0gcFlx7TFBcrZ6t9sotag19GLFhKTNGUsHZ5FMSZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzgCVMTQ;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A10606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 06:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A10606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzgCVMTQ
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so3060495a12.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515212; x=1794120012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6f1o8fuEFuPdBn4idpxljQ4M60y8fTZnD9oREJ3Uxg=;
        b=yzgCVMTQUwLtF3k/ybKqBfaO9dahk8yNtqmH/oBtM0ZjtGw35smcCU+NDt5lthcpLI
         0IeNU8W3zfOMU1v7UNV8bUHgulJUaYJreJJbse8F7z0bHL/OwkdMW9NsB/1x1nobJRWd
         nnlvt0wm/uMWmlUJXwiYHsY/Po4ce7IUHaIlOGsJHxMAu7q4arpsWIXkUnwgmH6acdqt
         o5Ck0b0n7k6YDPqSuQTmDkHQqE3jZmEBfH7cY+KGiuANZXPaaeif5WY+72CLDn93MDJQ
         WrtY3nzGjiHZG9dDxICqXmC4t0XExJZUkes2Q6cZtphcGH9qAeePEL1isJnZ3lRAujHw
         4Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515212; x=1794120012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6f1o8fuEFuPdBn4idpxljQ4M60y8fTZnD9oREJ3Uxg=;
        b=v2xX8KHpf65ljfp6xRyZCjWOKTDFQp3eiF6c4uLZD9cm1gcBF2Va2XNmBaeWpDUjY9
         XYZF4i/Pw/qVjjxrsNMU8j7whRJG9jOKeLIFyjfBBwhm91ntw51GGrNbVM5x+K+pQ0dN
         VtsRbNLGw//XW0ovd5vRAHoi4RJzpx0BQLKq0ULyKhs6S6DioKi8ZMLPeyLGsHv7/QhG
         Y6IGLYahVZOrYvCGq+cUs5HbfpCvAWP/dELZSG7PcMB1kDCNipIRC1II/Krzu6O0P0Q0
         d9k7O1Q58lqjv66LCkRzUcI6lLTMfHC8ShiA+zuG75BM2l08Edn+lq3ZqyfrIwm/EOtW
         3Syw==
X-Gm-Message-State: AFq9FYJiHqo3uJSqRu4EUWW8HBXRJZLHgU2oZlOf8y2SCaGkgOU0X5Wo
	RmLC7SqXKIwpG9P19bIVKP1FFve4HaanEqcuGtolQTgDzc2qBm5Iqq2P5+fYd3PmgpY=
X-Gm-Gg: AYBFou2oK1K0D0301z9xtY1VAxhNZiqe+ytYX4zXGKwEftpn98LjRZbWpdqbf4HWuGS
	bun7SS7mCrzzlSCgZ7Hu3AOePR4bb+v4eVHDMNW4OyjrVbh3W+HGzCcEdSEXg5k+5Ie2VDYk9Bd
	wQyY7KJTH+oxfn1LXLBhLmYOU9ysmYsKktNRRWTnG8n3WktTJv54VmMj1NrpUOhU9+dMncdoL7E
	MqowYiIfqcBb3ZWFq0bWVV6FKnKutaxhJqYc/E4BTZK9yzZF0XhupEvsETSthdJa4rhliDqiKN3
	/dBegpOKmAlW2FR4/RZ2lSDF7QOo9ppchmd01aLGUW9Qv4q73QmV0Z+GlvNbkUYWY+PFYhpadLV
	ejdn/sQqSbpbyFoJsOIVWCCfSk3PLyAufdAZKh9EABYBM1mwUUAqp4m5LkvqJoe//09nGVvgx/T
	aJVwBlK83IAJqJw1cur9R/HYiVQ77r5PcyA2jD1UoGnNPcrntE1UzT6+4ULmOgIarxC6HF3ksfL
	E2WNeaY3PI3lIgc/ZKXt+U3taR2eEo2u1vm8aaQceJ/u2MRq8mx/G2iWxHesDMQ+U4h92pN98m2
	jW/FwBXzf9AQrClq23UpcHYGwzbMz0a26RAiR428LYLGvujwPfyJb6GFHQFfFV3gcgxkdijBDVe
	dao/gIjezn8IdDCgarsp/mUcUl+PQtU9M2cpMeerpOBsxo1M7zxzVi/OHNKnJ9qBpXNFkqwfh62
	/3a5y07jvXFfDIyncxNjUzkgAtqOyQ
X-Received: by 2002:a05:6402:2355:b0:6b4:20bc:fa3 with SMTP id 4fb4d7f45d1cf-6b4d467bb11mr4871225a12.22.1793515211992;
        Sat, 31 Oct 2026 23:40:11 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9ee7c9sm1808594a12.7.2026.10.31.23.40.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 23:40:10 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] wt-status: use the repository the status already has
Date: Sun,  1 Nov 2026 07:39:51 +0100
Message-ID: <20261101063951.85427-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt_longstatus_print_verbose() sets up the work tree of the_repository,
even though its wt_status already names the repository in s->repo.
wt_status_check_sparse_checkout() receives a repository, but reads
the sparse-checkout setting from the_repository.

Use s->repo and r instead.

Keep USE_THE_REPOSITORY_VARIABLE because DEFAULT_ABBREV, which is
still used in this file, expands to the global default_abbrev.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 238bb48643..5bd1ecee10 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1208,7 +1208,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		status_printf_ln(s, c,
 			"--------------------------------------------------");
 		status_printf_ln(s, c, _("Changes not staged for commit:"));
-		setup_work_tree(the_repository);
+		setup_work_tree(s->repo);
 		rev.diffopt.a_prefix = "i/";
 		rev.diffopt.b_prefix = "w/";
 		run_diff_files(&rev, 0);
@@ -1895,7 +1895,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 {
 	int skip_worktree = 0;
 	int i;
-	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct repo_config_values *cfg = repo_config_values(r);
 
 	if (!cfg->apply_sparse_checkout ||
 	    r->index->cache_nr == 0) {

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.56.0

