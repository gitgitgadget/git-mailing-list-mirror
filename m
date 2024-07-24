Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB5156967
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819505; cv=none; b=p3AUL2yRxiYhTCxo89xVQ6d5Mcdjdh+b7Un+Hmuz9rjO3TCCLXjj1jF8DDa4848FEtdy/dOn97YDQEsHOVjvY1qNzVHlfFldBVwUp+maodW1WJmS6xNQOFsUTUFy8lasjyEjW2xEyBiwIp16XAISxoGyxA90mUgpliIRaIks7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819505; c=relaxed/simple;
	bh=3wl49pMgRJVxIYb+6yipsrxKpg//Uaj2sBxk+cMxZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4GctV2uXDMgN5d4sAfikuHBIjKSnUyyHQUcYwyAG6O480DNa0Ux92ChesX5YHv7QBXvu7Ad2pdXA6uYwr+rWxfC5YaoA6410BliWJZ7bIvU2p95hHfBV6JQMfTTHaEkrfvxEdH9Qhq2k+7UAfG672FTVymwLtq37aN+lV9/gHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=aP4g0zLp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="aP4g0zLp"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9a369055so168856566b.3
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1721819501; x=1722424301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRreEhelKumu6Dey/A68lkeoXUu+xYj6Lu4mxs0D1Do=;
        b=aP4g0zLpYeU9BcZMY80OiTjgJIQNScoXf86HDETkx8c6qE9OL1jMgx2akalNC2xYvv
         3HEENYkWFWSFpkcGrJnybdNWCZoFbGOMyjPnD0ATxsEFRLFQWFdKJBeYgz+CR520OyUq
         mrmMara5EuIdIzNKLNmA7Jmp+ZuRpfVGBRfKjrzUhM6tFLpMIxy3czbrALsKuTgq9j+T
         44XEoi5sc29Fzd3QxTai2zs3FgfC2tt2xlqSvxeBj+a/WWPsXnQ4lQWw5z5S1qn2qOhm
         acUbAsL3U1rdorA/uMoWV3yssfsB/Pgl+7vhEeXn+PErxh+h1Ug0rGBqBc3srPHf23OS
         YDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721819501; x=1722424301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRreEhelKumu6Dey/A68lkeoXUu+xYj6Lu4mxs0D1Do=;
        b=pJw0D4UAR70XpT9Gz4hGaxEO7f48/6HMErRdtXVeQGn99v6qG45BkZrHbxTLCmWOoJ
         sGxpgWD/zJxGRxGGjDtiikXWtUUcdVucWLZE/PRqYvqW9Fl1Z4+knkIT5jmHxDSP0gwV
         mXItJjbk8N8+rC/HDN5KUi25K+QJ+k3UdoZF+NkF9u5aoUPmMHR0BQvQmvJYWuLn2J3y
         sKPV1+7Panc5xmSyiConjDtoEdYCDStBJdvUdNwaoR6KNj278NRwMzUXHeIzleOLFnHE
         ejPxD25Rpbdu6kWU/EhT3TvLCNoWD3pGPc9H5iNYV9drb6DAML4cD7iGyDv2n9iOuIig
         SeBA==
X-Gm-Message-State: AOJu0YwGSHqFVUHoc3OrFZJfs3lDQbzyWeuwN1ODnVDJHjS/Qy5ds0oh
	SlwaW5b/vndBhJ5UZgxgQ6OmM0lUQiqAtJUkDQUsxiYeVaBSzgZT0V325M/Hxm1vdBsbldF44Pr
	LAywyPQ==
X-Google-Smtp-Source: AGHT+IEzhRr3LPzGumB18OcTQJHlMnVfiqLz1ZacNqyb0JcxI1gS+AUmuUx4S9CMQyA9TKzieq7ICw==
X-Received: by 2002:a17:907:3f0a:b0:a7a:a4be:2f9d with SMTP id a640c23a62f3a-a7ab0e26318mr119787866b.12.1721819499428;
        Wed, 24 Jul 2024 04:11:39 -0700 (PDT)
Received: from localhost.localdomain ([165.225.201.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8a480342sm204003166b.172.2024.07.24.04.11.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jul 2024 04:11:39 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH  1/1] show-ref: improve short help messages of options
Date: Wed, 24 Jul 2024 14:11:11 +0300
Message-ID: <20240724111116.91615-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial change to indicate that branches and tags are real options
that can be used combined to get more information.  This helps with
linting translations and prompting the user that the terms represent
options.

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 builtin/show-ref.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 839a5c29f3..85700caae9 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -293,8 +293,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	struct show_one_options show_one_opts = {0};
 	int verify = 0, exists = 0;
 	const struct option show_ref_options[] = {
-		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with branches)")),
-		OPT_BOOL(0, "branches", &patterns_opts.branches_only, N_("only show branches (can be combined with tags)")),
+		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with --branches)")),
+		OPT_BOOL(0, "branches", &patterns_opts.branches_only, N_("only show branches (can be combined with --tags)")),
 		OPT_HIDDEN_BOOL(0, "heads", &patterns_opts.branches_only,
 				N_("deprecated synonym for --branches")),
 		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without resolving")),
-- 
2.45.2

