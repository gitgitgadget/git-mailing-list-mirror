Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB426ACC
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750605962; cv=none; b=NjiO9B9qCWNcneiZ+zppuUgxAE5h/ZH1K604DTgEqgsIPsHXEAwWfpQRm7rNxHKBqs7RzAfVfl0hnL6Efa70/pF4PIdv2Pukh+jqrE/7oo8iZOzYt/D/gckQJ2RYuy9OjPvVNhe9F1+rBoXA3HVPJiUsOQoU6cdhbiGAtgec7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750605962; c=relaxed/simple;
	bh=2tr0Egu817DnMDwLNEm4CdQlt9VMt8diExSPBXWoI2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrqrjEMaTl5+7yqdxhrn221pfvEwLiYL2KBvLzANTQnFr59mBTqTulFAAFPQlDp+JUdcrTjhSPVRMQVwK5xWPlI6K+1fJsgBjlkvH1GtbBpLFUV0IMYjYbQzU4eK/HsGyx3APDlWE175LY9e2ltxU1W2q7enrDwo0ckl9uXh0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=D+pCMOP2; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="D+pCMOP2"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZo-005yfu-7t
	for git@vger.kernel.org; Sun, 22 Jun 2025 17:25:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=ZrycOf0ezokYV5DkguiRoNw1qCCBfPMkTQjruHeFPBw=; b=D+pCMOP2mciQXtuNnmfIcEYi+V
	XmvUumN4b0luPXs9fHB/9GmTiVCozmcQJgwBtWfxW1199cLDZB2kxLYPM+xyfIJvoESlKf6o876kX
	MSRv24kEIU/irlMPLmV+z4cXTqcib4StZEezdjFfgkLC+LpW/aa2sdb+EFlAzSRq+1gYB0JjoBC4p
	RigB6ep70pxL2a9cVr2ubOYZ+dLwuPNr4FtsZlrozHpYNmHoZa5gPw1Bl5f5USg8MF+l0bsIwvJi+
	Y4tjNHIgH2utwdWIALWPOVXH2LUjiak1mWHrrkEFqig2QBTjHpBt3C3QUt5FsuvAontN0gQqBU6dn
	G/7o9n2g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZn-0000TE-Uj
	for git@vger.kernel.org; Sun, 22 Jun 2025 17:25:48 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTMZk-002aWd-Kj; Sun, 22 Jun 2025 17:25:45 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v2 1/3] contrib: use a more portable shebang for git-credential-netrc
Date: Mon, 23 Jun 2025 00:25:33 +0900
Message-ID: <20250622152535.11837-2-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5dea3a8a86
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop>
References: <20250620041239.27839-1-maxim@guixotic.coop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the installed scripts have their Perl shebang set to PERL_PATH,
it is nevertheless useful to be able to run the uninstalled script for
manual tests while developing. This change makes the shebang more
portable by having the perl command looked from PATH instead of from a
fixed location.

Signed-off-by: Maxim Cournoyer <maxim@guixotic.coop>
---
 contrib/credential/netrc/git-credential-netrc.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index 9fb998ae09..514f68d00b 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use warnings;

base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
-- 
2.49.0

