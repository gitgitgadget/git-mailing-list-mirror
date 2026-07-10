Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210341CB43
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683609; cv=none; b=HeUvdkPrCYKaaXeZowPovahmFEU2V6m6RlOxPQwt6OmQOHSDDiIudX/lKSG9QFuGsUNtnP4YfsL7/pWng3T/jX0om1uZp9jc01pcgfg86UEuToW1yBXfk88dinZWY3qU3T6VykXgA5WwhDPci/Ip4It32rv0ABvHG5dTf6SE/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683609; c=relaxed/simple;
	bh=nIxDGsFPecAr6231wtPvhycIv6cXOOF7LeNZnNNsk+8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BwJkFoQPXNPYDAjW76VK6oDl6HlrUJdE2qQN9uelNYCJdzRcbnIp1P+qtEk86KQKFHHdatFHoB6kwMNh5MCvaxk2CY9TppcJnEr28+kWqgpADRUTWIp3eSjd4sBYd6f7yLasJj7r1JKttpCTgVZz25WlIqopu1wZ1DtMKwV25Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR34rtV9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR34rtV9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c7c61b5292so13465095ad.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683589; x=1784288389; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GH3NbajPNJr5WB/7AYna0lWJeO6/VkNdIugs1z6/hwU=;
        b=BR34rtV9IRjCPNdv2E3WzcIo1P/F7+igIn7MQO8nvhMAjzqec8D0+b2Ltb1DgZnYRZ
         Htv3AANoBXN6zalEa/yeTU/DQaooZK2A4Q163Tqtxzvrfl64oEr40G9XcLRn0H0X+nOr
         hafa9yo7Pb+w2UDkbHVTMVOAqaGJF8oqPe6+8enTc0WqjuZCCh497ijH8zCTQqxJ7i4H
         lGdmftWnL3LhsTTWO0FJMWvXrNkQDNYrRC3VxTf56WXBppoM9Gs9+VdW3ziHV41G7dzp
         zOZazsfMkXOgzP9gSSqNKtklj8msMMFayMZuDKd5O/y0uODjcCzulXDFbeKQmbh5QRj6
         /VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683589; x=1784288389;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GH3NbajPNJr5WB/7AYna0lWJeO6/VkNdIugs1z6/hwU=;
        b=Ce3MHhER3MnZf9pwfKCv9E+qD5TOPo9q0TpMi9H9vojqch9+WDDqyhvB4p5ZnOCyF+
         KHBuUD/gbOjSdF7rIMwmt9JeVj4BrCdugOPsw1O/4q09BIH2c+9jEMVL1JPUHgmQe2un
         n0ZYmy/e0FKx/1648FhEdeNI0R7oCl0VpGkxGyQG3RAF/BsP+rmSELQWBSxcUKQZ7i35
         eBaOdJ7UP2FyxoOL9PzN3Pnxj3EgkPLNWKTmivSVXOk5JUblFq2Qa6RahitaKVtkz7UP
         s8KdomHxYSeckjqx86CHhpMEHoVN+XHxe6J9t984fatwZuGcS2fnmmEgnNgALp3fp3Kj
         Jvmw==
X-Gm-Message-State: AOJu0YxLFsJJwCRh2Vu1uxb3nFiGK7D4ew+MOueTbYLHhfGt6tICmg44
	cgsp7pUTDiuINOLztNPcz+xDyFkBNCTkBXrdgJskqVYcUnSwywdEVT9V8b7Cib3h
X-Gm-Gg: AfdE7cmlPjYVIu2aFMx/fRSSs4qS+U5FEdwCDy/SWYV7OWzfT/6rkLVyhRCkwXWmLVt
	8vhIvDVn7jnioOwvKPPh8dIBsuZLtvrC3wuwKAuewSYdaWaf7F6Ncg2LlzPrxcpTgWpB9PKgGpo
	XsEdo5PNTgJZevz8TqR1mCxFCYnZVIGS1qhqia/8WJaLbPzTQYKUAYOXckR2XuOHXt50A6ZAc+N
	aS/1JIBGoBRyX8mS+abjoFeaFwfd4Wj0rdA2hkd/vsYhZ0PqdpPvQOFlJjFaJhaP1rIh6p6eavo
	km6FFzSTVxRMaqJamCZYUalLLNWCnrNf7F7DNncizDC8MVYxoEa6wGUheN2Mn4l2a4O5+tDD0N8
	HvVjce1+eR01h7IreMFnyY5C9gG9Nih96Asu435npkFkWqvq0on3v3pEV9xdQhDp8YFrpKY5b5u
	GvjS1oMj7Pp8JNDLy8
X-Received: by 2002:a17:903:110f:b0:2ca:6d87:cda0 with SMTP id d9443c01a7336-2ccea2a5ddemr120872765ad.6.1783683588978;
        Fri, 10 Jul 2026 04:39:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8c12sm58761485ad.26.2026.07.10.04.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:48 -0700 (PDT)
Message-Id: <ca818ee405a8078e14ec4faab2422b34c6e83681.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:30 +0000
Subject: [PATCH v2 06/12] bisect: handle NULL commit in `bisect_successful()`
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

When `lookup_commit_reference_by_name()` is called to find the first bad
commit, the result is passed to `repo_format_commit_message()`
immediately, which dereferences commit without checking for NULL.

However, the commit could be NULL, even though in practice this is
unlikely because `bisect_successful()` is only called after a successful
bisect run has identified the bad commit, but the ref could still become
dangling due to a concurrent gc or repository corruption.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index e7c2d2f3bb..408e0f414e 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -663,6 +663,11 @@ static int bisect_successful(struct bisect_terms *terms)
 
 	refs_read_ref(get_main_ref_store(the_repository), bad_ref, &oid);
 	commit = lookup_commit_reference_by_name(bad_ref);
+	if (!commit) {
+		error(_("could not find commit for '%s'"), bad_ref);
+		free(bad_ref);
+		return BISECT_FAILED;
+	}
 	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
 				   &pp);
 
-- 
gitgitgadget

