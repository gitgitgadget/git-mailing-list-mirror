Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22472459EC
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751151603; cv=none; b=DmCPtXZK6XjnI8X4hvlCWqPtSiFnq1BvVBx0q1CX4JQNTF3Ms5NBbuvA1iK3TTdcbNuchOAV+KA4NXdi+7AalyezRdA2EJHTGUWpbHA7nh9PkTxYxtuiOPsae8imQJmrWYu1aDJcAC75n4cltJxiQVBzja8ppQUg+/rNqyoGjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751151603; c=relaxed/simple;
	bh=/9s4kxO5aevxiOEZilDgO1ewRJFe/kOR4us1ihDXvHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atIzVayKRwd7udVaBSAXm0qNPimPEcBcGPYk3pIihBeTImA1wUEWNRNhgb7QBdopJkHCI1PEXLOsuhe9V4mzxRFjc8MS9K3uIuwbjONgJ3EXz7IZ9e9jnDPNWNA/ZZQbx5spd8lccSPyl/1cMa2UVNnDNaeYCcyhkrWoJ5Vobj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=HPCxme5e; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="HPCxme5e"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751151599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6Qge2TwPJE8b4oKCVHsjl+zp4kM09DZ9oo3h/BMGTQ=;
	b=HPCxme5eFRsX2SYw6B0x77zvF8mm8FmtJVC4C1CfVGInX4lOJgxh0lCH7Pa8Tuco4vXP56
	aeXnJYhCjXIdglUUIFeL67A/WNNas2n32WBBZLiyNxk68lEzLBw3p/soFaIDnQstL56c10
	DSb52R1JuyZ/WO5eoWbAyV2QC4Yvf6g=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 5/5] apply docs: clarify wording for --intent-to-add
Date: Sat, 28 Jun 2025 18:52:07 -0400
Message-ID: <20250628225819.1294068-7-ray@ameretat.dev>
In-Reply-To: <20250628225819.1294068-2-ray@ameretat.dev>
References: <20250628225819.1294068-2-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Avoid using a double negative, and keep in mind that --index and
--cached are distinct modes of operation.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 Documentation/git-apply.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-apply.adoc b/Documentation/git-apply.adoc
index 952518b8af..a41069c0ab 100644
--- a/Documentation/git-apply.adoc
+++ b/Documentation/git-apply.adoc
@@ -75,13 +75,13 @@ OPTIONS
 	tree. If `--check` is in effect, merely check that it would
 	apply cleanly to the index entry.
 
+-N::
 --intent-to-add::
 	When applying the patch only to the working tree, mark new
 	files to be added to the index later (see `--intent-to-add`
-	option in linkgit:git-add[1]). This option is ignored unless
-	running in a Git repository and `--index` is not specified.
-	Note that `--index` could be implied by other options such
-	as `--cached` or `--3way`.
+	option in linkgit:git-add[1]). This option is ignored if
+	`--index` or `--cached` are used. Note that `--index` could
+	be implied by other options such as `--3way`.
 
 -3::
 --3way::
-- 
2.50.0.195.g74e6fc65d0

