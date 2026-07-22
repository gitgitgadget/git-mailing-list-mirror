Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB02139C9
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743749; cv=none; b=RJWBQwRHdrAD2K+mjUx+ddZqisXNi45yC6RQVnQfBpgmsi2+ThzbWYUjbYGAm3ITdLv1WXwPAVwlBC9kMVf1cWDbjPEQZnQwJuQhRwIAqU3up3+2KUbd3sGy0/evDoym0yMeU1f5+T9FHs/KGt3Pm9pYNRjOusG47nWwERuAbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743749; c=relaxed/simple;
	bh=lmrVIQc1JN1X6YqEmBY+VyKP/TT4ddkuTmN90OPOHpA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YNrq8bfTvOCocBJReCi9LYomjB/auS/TLjAdfkXnyI3h0MqPPAcUGuSgstaIpLXUEg+h2GGOHpyxrHmnyglYMNMRuv177FuArhrgCk2/v4UkLEaBW1/ggHBIobgQWg7Ic2issqhwIxwzlciCfVeK7d7SHqAr077GCrvzThCCTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO1/cEIh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO1/cEIh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc61541f8cso77862805ad.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743743; x=1785348543; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X17ZpV3aGC64jgZBZQtfRHlV/TEsBgO93FVkD73UJ64=;
        b=oO1/cEIhxNf6soMe4VjxMbi2Lzt3Of4VAM0cMa5bqj2fxCdp3+fg7gt/lqkyYxm5m3
         zwPtBidqlgmN9gBPDomnbUZix9dTnGksWiKsA2pzaC069eGCL8B/gM4KG1YM3ZBU+PKt
         dSxLgOzLvIz1JKWfXQ4Kd1TzrWInOnnGr7j2sTf4ESBHpW4aUMVmBvjcOGM1GnDKM43g
         f2wMPnnhR+Wop//bfY6uFJewJdpbXDdVbV+8gYEQcSmoFyFumqq6bKS+3aO6wB6qQ4Dc
         ogJL5TEQ2H9kAgUUVv+IbgSQSATv58Xf+gxIGi18scecCzFIPqmsPIeOloZknZJH+KAp
         ECFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743743; x=1785348543;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X17ZpV3aGC64jgZBZQtfRHlV/TEsBgO93FVkD73UJ64=;
        b=QMhEqhLlJ01XHlRYmrJ9mZnf046P6GhV1yuoLCAuUHKk+I2NpxtGzR20KEuLnRhMor
         Q4buksPgvdqIIbqYafw2l5vRjaxs/hflrcQgdkv98zzHwzfjPT0qAySTi+zVdWoRcACQ
         BVDV6yZOq/ZP1HpuuCntAAvdN4+To+exERztBYIJmvMfriIxSkz8OZe5Dn4avDXGxObJ
         sm6ZSqfk3HVB2GzyxU2KAJ42NkKwFbcPX2lNW4Slxqab/n4uWqU2gvFrIbh9nHWyK3ez
         Aj/JutFWuUoowVSG5hoRIwyDqHoG+Hf9h/aiR4ytlQMjQ5hbS+LHlO1xEkKC56OvSCLv
         DUIg==
X-Gm-Message-State: AOJu0YzIpluDCcrCgTrsFxqR/BOYpc336H00+oX08lAEKjJYrV3Ucp7h
	EJ6O/jS9XSNL7YAyfqvWjS6rERl6RWEBZS2M6Wxr+Z1gdaTacOdMQSijTIIBLaH/
X-Gm-Gg: AR+sD10Zdl0qc9ScnbiHn6ciuZvWMKJLdU0bP/ilP5et27cyeP8WsUKjf9oWp7YViWX
	lpRYnA3+Usp9Ojtl1pCh/VU6YxcRcWiu39aE/Ly0wLsTjbtPrBkfhF+X4acC6x75ndBK2M4aMyq
	NDrx2Xp/jnnMqe3miWjDF5oGPFYdTz5rGg8yXrJwuTZRIFnHcuZgopp2vzQ9MRCS993UbXMj6uY
	rtZMGGWHzge6PARyzqaJ7cPqNGANRsVgJCVg4UwHY+ChTnriIy8GtZ7NkwPNctHdp+uaoijEMuh
	RO69sCiL2d1UeQwHPSn09LEv2HVCyiBrVBihww9zoRLncjDWP1An8d/rilAJGpmJipeFCAbXiRO
	yJK6oYuYVn4E2+l14osa6jmckXWId/zm0m1n7QCBHzNea5gUBcTPedeRF9ziP5T4s+FB5bBUCum
	TPxPCCUIifLOryn64=
X-Received: by 2002:a17:903:184c:b0:2b0:badc:c9cf with SMTP id d9443c01a7336-2cf8dccaf30mr52743375ad.13.1784743743587;
        Wed, 22 Jul 2026 11:09:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.221.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6162csm11302505eec.7.2026.07.22.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:09:02 -0700 (PDT)
Message-Id: <494287bade1d4072ccbe8374028ca0c7cece2a80.1784743738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com>
References: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
	<pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 18:08:57 +0000
Subject: [PATCH v4 1/2] remote: pass repository to push tracking helper
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The next commit needs tracking_for_push_dest() to inspect the
repository's configured remotes. Pass the repository through the
existing callers and mark the new parameter as unused.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index b17648d6ef..0dc36956c3 100644
--- a/remote.c
+++ b/remote.c
@@ -1887,7 +1887,8 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct remote *remote,
+static char *tracking_for_push_dest(struct repository *repo UNUSED,
+				    struct remote *remote,
 				    const char *refname,
 				    struct strbuf *err)
 {
@@ -1925,13 +1926,13 @@ static char *branch_get_push_1(struct repository *repo,
 					 _("push refspecs for '%s' do not include '%s'"),
 					 remote->name, branch->name);
 
-		ret = tracking_for_push_dest(remote, dst, err);
+		ret = tracking_for_push_dest(repo, remote, dst, err);
 		free(dst);
 		return ret;
 	}
 
 	if (remote->mirror)
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	switch (push_default) {
 	case PUSH_DEFAULT_NOTHING:
@@ -1939,7 +1940,7 @@ static char *branch_get_push_1(struct repository *repo,
 
 	case PUSH_DEFAULT_MATCHING:
 	case PUSH_DEFAULT_CURRENT:
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
 		return xstrdup_or_null(branch_get_upstream(branch, err));
@@ -1953,7 +1954,7 @@ static char *branch_get_push_1(struct repository *repo,
 			up = branch_get_upstream(branch, err);
 			if (!up)
 				return NULL;
-			cur = tracking_for_push_dest(remote, branch->refname, err);
+			cur = tracking_for_push_dest(repo, remote, branch->refname, err);
 			if (!cur)
 				return NULL;
 			if (strcmp(cur, up)) {
-- 
gitgitgadget

