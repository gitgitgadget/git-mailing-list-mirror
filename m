Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B974156C40
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151408; cv=none; b=h2gOtqaztwfmC/QiEcWhVITbv0C6M0MaZkzzYZnbuPaudFoIHnbaBP61T9pqPjz96hKar8vwCAHWLN2DwGLv8pcosWp2eg7eX6UV5ce/OlRiEwxAZTXpFAWYDKzPSH0xQbVn/9P3juOgqPAJzci6oaBs8nbYWuZaA1ARYZjJFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151408; c=relaxed/simple;
	bh=6G2Nar8266I1nPjyXGZYpAgoHSjw5NrWtTfj/oPk/QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/pqw12iX/3TYetquNrYTu7dfS1pRo6Y+GJ5Jg4HmwRghM9dpDRNDFOnzvvw7OwnznjSchypa8ijK93JJSbIsW4wauLEi/KOEyx5wgZpDsy+wc0ch25eWqAmDrIiaQP59BTesabo2Cw8Kz4RRzn2I4V97wq8VKW7GTRHYiJockk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8Djf74C; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8Djf74C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723151407; x=1754687407;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6G2Nar8266I1nPjyXGZYpAgoHSjw5NrWtTfj/oPk/QY=;
  b=l8Djf74CNxsU7UcB3kfkgzuFHPRzeKD2NlNAxd58qcmQ3rb+nIy0b86e
   GSx29qrRrXUbOegsnkZ71lLLNogWIHMoScHG4g920wiPnU+brKohfQ7Z9
   Gw/hr43ZekYdtj+QlxddCQ2oxQ+xccM5EkpkLbGDHyJHI1VlpQsc474T9
   W9MEzfWYt5mFBv1AUicE1gX20QrWdGNJkviTakDjJCIq1Ivu696KdjJFo
   CKtRBrXalipgK4usnUMPyUileDOupXsQQMeHVNAGi1zp3CiFi8E8BJE7D
   vm5pUCGphhZK7VxXSD3S5fTuoOxX9TB8fe7vnIkiWAr/BxqIvoLi4Cn7Q
   Q==;
X-CSE-ConnectionGUID: +3gMenIwQTygeHcwzuAdHg==
X-CSE-MsgGUID: dw40O57HQAK9eToyaIlEBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46712895"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="46712895"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:04 -0700
X-CSE-ConnectionGUID: IaOy6iGQTBCnclIzZs6CUQ==
X-CSE-MsgGUID: dTbGXlICTfCcpEZBbjKY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61991229"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 08 Aug 2024 14:09:59 -0700
Subject: [PATCH 2/3] t9001-send-email.sh: update alias list used for pine
 test
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-jk-translate-alias-send-email-v1-2-10a03b3d6b06@gmail.com>
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
In-Reply-To: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

The set of aliases used for the pine --dump-aliases test do not
perfectly mesh with the way the pine address book is defined. While
technically all valid, there are some oddities including bob's name
being partially split so that the actual address is returned as
"Bobbyton <bob@example.com". A strict reading of the pine documentation
indicates that the address should either be of the form
"address@domain" or a comma separated list of address, name/address
pairs, or other aliases enclosed by ().

The parsing implementation in git-send-email is not as strict, but it
makes sense to ensure the test data used is. Although the --dump-aliases
test does not make use of the address data, it is helpful to avoid
giving future developers the wrong impression of the file format.

Also add an alias which translates to multiple addresses using the ()
format.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9001-send-email.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index aa36ace393b7..c96d6955b9f2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2093,13 +2093,15 @@ test_dump_aliases '--dump-aliases mailrc format' \
 test_dump_aliases '--dump-aliases pine format' \
 	'pine' \
 	'alice' \
+	'bcgrp' \
 	'bob' \
 	'chloe' \
 	'eve' <<-\EOF
-	alice	Alice W Land	<awol@example.com>
-	eve	Eve	<eve@example.com>
-	bob	Robert	Bobbyton <bob@example.com>
+	alice	Alice W Land	awol@example.com		Friend
+	eve	Eve	eve@example.com
+	bob	Robert Bobbyton	bob@example.com
 	chloe		chloe@example.com
+	bcgrp		(bob, chloe, Other <o@example.com>)
 	EOF
 
 test_dump_aliases '--dump-aliases gnus format' \

-- 
2.46.0.124.g2dc1a81c8933

