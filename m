Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17A3955C0
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889484; cv=none; b=RGLAByJrVzhCNc3n8cA/MkvIX3YARK0kgVKq1CFCVSFMPH6oHP9fotI3s/TyCJ4/J7vICLEEwWKWXIYjL9rLBjMyZSXngr6T/Cig+sONN9jQfJ2it8cBUm+x00udBY/mkB3Pv/KXdfYc51C0G11dhuiyteHr/9Ny6mf4sW96msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889484; c=relaxed/simple;
	bh=q/65UelVfCCPkMTsaTEmnv+v5D8aGw81hG0FhHk3Ksg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KA/hM9QZn00SWLsMyrlgoX2SK2gysZpIF7VSPh62eSywR+yMfNPJK91xUhwdDXbsHnhC/PW1QDuJhUm1ppizvYy69Imx3d5iiS/Ns+ONACTODCuWXZzrukt5VYmUzlW/7gc1wKfFzRJSrqSr5iIGZS+K3M5ECzqcBCt4SvM44qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASAKh0ou; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASAKh0ou"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c08df8513so2199411cf.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889483; x=1783494283; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsKS1hwy6oKRKqny0aGjNsolU0wy9WcU0s2BulyQZ3E=;
        b=ASAKh0ouOPhOgtdwSo0wDbrck54+bI84NchaZha4IcLoiM5OsvdHKEqLILW50xTHlH
         kIGE2K2R8XRgCtXlqbomCoVhDXw1PwBcTnMM9PvbuAqrS1gq0DKDKispxzo41Www82vl
         PsQ6NcqlAA6AghvBqlhEEDImI41boyB5s0l8MA4SE8RqVu3dX11NWXCYqF3sBX+fOt+i
         V2F7JNmRWIZqeoJkid0ADXhfsG/9pPVmO3dkuWMRK5j2pUU1neEwAzPHZckcqS3IKupZ
         Gy4CRkcXRC7xB0r8c2DC/dWzH3TtjY1e4cXkwIcluvcoLHsWhfnhnGIbozkCNV5CgWat
         J5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889483; x=1783494283;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsKS1hwy6oKRKqny0aGjNsolU0wy9WcU0s2BulyQZ3E=;
        b=RlZu5RulePgONh65A/XosFPRBr2K00O5zeNoer9uCLnr6NTFQ/VzSihM0kIePkIbKV
         dfJBu3u7K0O+zY0w6zEeZdCbLaEhh3CnQ9NsSj2R1x8kfqheuthhoRfdq8elI9OSKuIy
         GZ008mp+qI+uSJE55M6xBQgIiGHWeeZH33zWwzXi4CRB6McZj4PydZgOb4fdAGLOhwIO
         mUoBNrRpG1ZkyN/TIHtHs+GzMOPqVroO+jQLOuelSY5vao6bm4fDVgLDyhwlOOcbYStf
         Cy8T+587U0lMKkb3zPvoEoyiE69UzLVoVh6uf2bVmDxDVakAUz80PeODfUW9BUR7337F
         T/8A==
X-Gm-Message-State: AOJu0Yz0CuvXjkHtOISRw9SqWd8fmqH9Ps4RSDNMKX4srW4MyMkKXUbX
	ThnSq9SkT8y4ttGyHS/aNOSdSb6QvGe9XhCFPjoz9IyGsq5kMWWtCiI8GrkvSQ==
X-Gm-Gg: AfdE7cmZI2mHfd8dDsmKvvHxZEjb2f/N7X/Bgz1eCfNnNFaVYuZXNnbpk01xgHqAAiI
	oqZ7Pafr035km7ETj3itIxPvN8pN6AuLOlQK2jMZZU37CQjiW47z0kSPkqgEOwexehhppTraRZo
	nF4a27Cc8AlTnkusu/HokDQvJJzM3nABg+MGgQ6g63r3DOxlk8V/+X3z5QGsNtaR5yMorRinPkY
	wTCHStvE5njB8awm+YvKQwl3G7JA6IOE5zbuswtkVcNxQWJfooMXi3hGmdntNbRN6oOXQSzZuhd
	SjEcbiPvRaqSf0Rx933weNLezAGRFvFFT6MsUpSNRkkX0ucyR9zkMXFKkLUQ5Z6XSoOTBQP3XwU
	3sg8uGlgH2yFMrL8nw9JK2Ga9NeyB/xBKFNSP3stzIwkCUl7xQF8GA4TvacqzQKJAwA8LVS5tdX
	9m7OfZYC+bkfVPEH4L
X-Received: by 2002:a05:622a:83:b0:517:9206:10fd with SMTP id d75a77b69052e-51c26a65d70mr5601861cf.16.1782889482677;
        Wed, 01 Jul 2026 00:04:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3afb5ad48sm6902146d6.11.2026.07.01.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:41 -0700 (PDT)
Message-Id: <5a6b17f075ca2d0442d512a0021557aa112860fc.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:24 +0000
Subject: [PATCH 06/13] line-log: avoid redundant copy that leaks in
 process_ranges
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When bloom_filter_check() indicates that a commit does not touch
any of the tracked paths, line_log_process_ranges_arbitrary_commit()
propagates the current ranges to the parent by calling
line_log_data_copy() and passing the copy to add_line_range().
However, add_line_range() always makes its own copy internally
(via line_log_data_copy or line_log_data_merge), so the caller's
copy is never freed and leaks every time this path is taken.

Pass range directly to add_line_range() instead of making a
redundant intermediate copy. The callee's internal copy handles
ownership correctly.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index 5fc75ae275..0179f138f7 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1141,8 +1141,7 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit
 
 	if (range) {
 		if (commit->parents && !bloom_filter_check(rev, commit, range)) {
-			struct line_log_data *prange = line_log_data_copy(range);
-			add_line_range(rev, commit->parents->item, prange);
+			add_line_range(rev, commit->parents->item, range);
 			clear_commit_line_range(rev, commit);
 		} else if (commit->parents && commit->parents->next)
 			changed = process_ranges_merge_commit(rev, commit, range);
-- 
gitgitgadget

