Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8F4F4CF1
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839673; cv=none; b=giTYNBsbv8CKlolybO5o5mHwIXgZTXMOSqlsrAfMGLvvmMTPHEmdO0NO0Pj/WU6GzKrXuAXxKH4+UTEvOL4ky12eAsFFNeKQiB0W/ilN9HpEkbIuzZALdnbeEuRgjUEGX9thzbWHEbtO44U/i1nS8v7hrpnRYHw5WBFfLt2EbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839673; c=relaxed/simple;
	bh=/BHQ0KOharS0rF7HyqzXDuGiT7Wpt/LBUFQzu5dVuH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2B34cvAI1DBgqUlCwANgv/N8+zBAdybeiw2DpkT1VJeonQVje8anWse94WlHb0Po6oUACW6MBSQk5bFCfzabQx3U+s4oNfe1RSH897QBHmTf+dKzUnKbuppSJJtUKN34dErjlPA78pH3OjDulVsuLseVdr5Fv4P6PO3+ypwNjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1xGNLn-000tyy-1E
	for git@vger.kernel.org;
	Mon, 12 Oct 2026 23:14:29 +0200
Received: from [10.20.10.52] (port=53448 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <ig@drbeat.li>)
	id 1xGNLj-0000000ECLw-1W15;
	Mon, 12 Oct 2026 23:14:22 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id C9FDB40610; Mon, 12 Oct 2026 23:14:21 +0200 (CEST)
From: Beat Bolli <dev@drbeat.li>
To: Thomas Koutcher <thomas.koutcher@online.fr>
Cc: git@vger.kernel.org,
	Beat Bolli <dev@drbeat.li>
Subject: [PATCH] tig: add highlighting for the "Fixes:" and "Link:" trailers
Date: Mon, 12 Oct 2026 23:14:11 +0200
Message-ID: <20261012211411.1001119-1-dev@drbeat.li>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

These trailers are common on e.g. the Linux kernel mailing list.

Signed-off-by: Beat Bolli <dev@drbeat.li>
---
 tigrc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tigrc b/tigrc
index 35826bc7..9892b31e 100644
--- a/tigrc
+++ b/tigrc
@@ -419,6 +419,8 @@ color "    Original-patch-by:"	yellow	default
 color "    Inspired-by:"	yellow	default
 color "    Generated-by:"	yellow	default
 color "    Assisted-by:"	yellow	default
+color "    Fixes:"		yellow	default
+color "    Link:"		yellow	default
 color default			default	default	normal
 color cursor			white	green	bold
 color cursor-blur		white	green
-- 
2.53.0

