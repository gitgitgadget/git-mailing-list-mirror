Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D928F931
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335602; cv=fail; b=Rs7jtLxY1vDBVJEjFMKGvatmtgLn3yZNpsOOiYOl2CjTDvTBu3jCI9i2MMYHTweCQyEVc70l+Mqo9bfyL7+E+w1ibzHYGMooCNuZR1a+SjIbqR4Bt3alNgUzcCLkdvlJSMpp/e5V18WbVVCZRt0dCmCGI83++2ViL7Q6rI740hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335602; c=relaxed/simple;
	bh=zLesOLojC1I8iNixixzHCA28fcQaS7mt34UtMXsi+2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m9nuIcyF0baOwmdjBiqqnEM9wqECMQXaFz/M/+6SDEc/bg71lds94eHGP/PPdyWY/YiiRTFhEtSn5LmOZtdShbW3M9efN2pLJyZ9m9T5+bW5lIjJIVIR2JfbN3WibQUs37oyWhtca2sV9L23w7D1qaHjDNAi9EghZ56vIOuna2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=lxphle6l; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="lxphle6l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhiJ5JXC8BcaPDSlzgnq8IX6ZO8AATadhGFmAL6ktW1UQfPdZbp9WG2NVoay+cLysjxtiSIMumHAcXfQRAutF1+1qT06EJOE4mdLlGHZQ5EVmcoi+m0xohbtUK74Lns15bWnGZX9kw24krg1Nq49wZHBN0aMBMY6IO+MxJNT6CAd2tUvtFn6EOAqEfPSQIBmkgjD+WHwuVoapMiOVObZawgX/w2Lqr14bx/xD97UtgZAXbRjd+KV5WBcBzOd8Z+TrwHjZH2/S20pw+6LBw06OD26z4hYLbELVrF78LpRwOdA5thIisKbVw/W//2go0pWZNSqQfEb+z3/4jYXHKar+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n++MV3m5XeUOo+WDfinMJD6jCmy8MJKCK3OoQpLI91Q=;
 b=D+IbyxFy0y88nIJt03O+CKa3TJCXN2R1/gvuTslDQw1YMoKSd702jgf9gtvaTIuQddJU7xuC1AmLGl5SalF/qZ7lhity9IybEc7MkDJLaQDN6lEHPgTAtnNejHv/fkh71wPWp8FCmrt3XJBBVK9ECyH1Q6cuRo5l3+UIbXbmdFX0pUqB3bIkWF89tDiChqhUqrNZ5H+Z8EkRWbUcVMYw/bHcom/qynL0xsGK9nhyoqdxb91eJzeNox9WRMkA2Lo+vVG8yYSk32cU8wR2GW1vNFw9Tstw5b6GU6Ka7qq8wV0gjyGswlqsb9GozS8u944uFitEmhyVfUkjNCzyDdPvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n++MV3m5XeUOo+WDfinMJD6jCmy8MJKCK3OoQpLI91Q=;
 b=lxphle6l/moSy+cIht9oKmcWv+EAyyjmmqWfKpodYpWEs+oaqPXAeVTqXf6i2IT9SwuQ0L/2vkPwdtjDe0iEGkO1iiG5x3xFHSUW8YLT241sehN1IryLPQ0UC0fCwlWoJvbNufXlFD7tz8IwXFi/kEclhzggmkGCAdfgYzm3Pf9fmyWAoQ9P9UyrQMlc1HYlSXbeT/B2RrN/egdG1tNY9ZrToYWMbMeLAvQVYmEpUPWWtvJRBmaqAhK5d0xsR09aLlKfrE2n7cvG6YI+mJiFYh/j3PVwCGKR/jrDgMGlliKbZrVDIR3Vl+KefoadWmMBeS64bf7HEVkNWAKUpqmCtA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6777.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 15:26:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 15:26:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3 2/3] send-email: retrieve Message-ID from outlook SMTP server
Date: Tue, 22 Apr 2025 15:23:20 +0000
Message-ID:
 <PN3PR01MB9597D68A4E7A570949672832B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250422152624.19037-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 901a9f6a-ca26-4579-3663-08dd81b20f91
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|7092599003|461199028|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pIFtmNrBchAU6K+DJP2d1npP28yCT/LwU9Damov16abvvnFSEepyAjnsutw2?=
 =?us-ascii?Q?Uqwj+UCXG1C/iE54DLa22KkLPeIQXXc/RPTYY8BhN5jv5XjI7uobXhKD7Ba9?=
 =?us-ascii?Q?2xz0AJHZbAsq1MM5md8XbrM9zbC27Y3sVYkCPolyLDFPgXMuRGmhidcClX+w?=
 =?us-ascii?Q?G233u4F0gwqjim1CFsCU3n7rRbkzBD9P5o092ND3zcSzvFNUJmQ77wqRVzBN?=
 =?us-ascii?Q?7g5OD6EsCLKn19BePqCLy08l+E0ETnoDvhXhMMcggNtIgClbIQoybtXoELc+?=
 =?us-ascii?Q?n+41TOqbJ3WnITFhVtKGM5RblTz1Ddeq/TLSpkUrz9MOuJS38dmdozCOIlmn?=
 =?us-ascii?Q?hD1m4QkpF4tK1VC1rcNnC2F/W+Wh0bV7mScBN+N/3/ZwQouwM5TWQMy86ogR?=
 =?us-ascii?Q?7DiwKjCdSGl66pStAOfIei6x1zxMytsPtnvG/Cm6oPxRSA1fRL2dD5Q5o0/4?=
 =?us-ascii?Q?2rQkqR8yVq06RaU4QWTATmFflk2wtxL+vrcTm+uoW2dhr40QfNRwgnMLVSlI?=
 =?us-ascii?Q?73+3WKqPXwxxzrjtkrBGLpyCH3O3dPBxF8is6mcnR3e9M9Rvy4wAIDrLuZN5?=
 =?us-ascii?Q?puJPIEp0YLl/lAqNZYYtYvWy94FLmteqZ/lY7paVBwHghdFkaLRJdUqA1sjP?=
 =?us-ascii?Q?v9v3oqtpt+PUAGQAk+FRKH0BhlAUlOGJd8qzsqCyDjvxmja2y5k2EdE+J/c1?=
 =?us-ascii?Q?w0BEHmn+LwhhAn37nbvXhayM3ZvTkGKA94HRX8glXRh3kMRG0/0rkjhrVGA2?=
 =?us-ascii?Q?s+29vrXJud6QBrlUrjBkSLlZuhDWiYkCRBFtRTbtGtM6qMjGOgI/dRaaUfEg?=
 =?us-ascii?Q?t6Qb1QoLYUpDwM1LtKsG+mZH5InXGCKHRphpNPqjLfxJZw4t8Y1yPuXoqgjx?=
 =?us-ascii?Q?n4bruCWeG2aN345xCDqP7gscLsgbHIr45nruh/rzX9rgxKPFLsSUmKzAH1x5?=
 =?us-ascii?Q?5cz9ZRv9BVvzLaEcP1e51+3GvXUZs7RK7pHuSIhekOX0SZkck+rpEseQWqNk?=
 =?us-ascii?Q?1HoMFICe7eYAgmCUblgKloMtzyClTHOtDlvY75gORACRNNr5QISdrG2Ubcpy?=
 =?us-ascii?Q?su99B3cum/3KZ5iPRbgsPQyOlf1U0Vwp9ps2y2uphh20uYkNlwQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOidsnGWB5PmbSRfIVh4zsmq5JilyIMV71Uszn3irMLjHl5Xv2T4V+F10akI?=
 =?us-ascii?Q?6JipseE6a59zYwG0t+8vMSVmgIhjB8Z1FUHX78APGGMdt9GvwYZWyBG03su9?=
 =?us-ascii?Q?v4SWWq38hcOyvuXg8/hYHrSO8znzAT7G06T2ot56xOl8HutN0vWYHk0copid?=
 =?us-ascii?Q?Asd/ylxuYNsbvCVwhVFIGf5V8VSU5Da3XYvx9UgJafqnYk8lBORFZoK4w/R2?=
 =?us-ascii?Q?9bZVfngsRCpMrGs+WyudYJ4hU823sxEWdcAMqbMO3jCdw2/F1xpf6dDEwNvj?=
 =?us-ascii?Q?p3eL3Pqr0r34PdbXlj2W2L2lrxwm4AmyrR9LlGMt/cT+eICsGku6OpiCoMMv?=
 =?us-ascii?Q?QyjmBV6JVMqQNLQZDzt/Im4ouM6uWeVFdw1aYA3ZeN+CYVzQk56yNhavpJjk?=
 =?us-ascii?Q?hhKiLWnXMZ5D9jnRm6N9TJ0EnUaUvAAq7eu8Z/vYqwnEYHkJwS/dphxYgmlV?=
 =?us-ascii?Q?c7886yyo5J7oTsbVAApH3WoWxz6WeIignxbKjUYGeofes1mJXsef5Wg+s3pZ?=
 =?us-ascii?Q?ezaZKPbF5LMIMy9PSCU49JAgorRJvQqVzOGifnp556QNz6d8M5zosc7/gm/B?=
 =?us-ascii?Q?opCSnduBCrnErgfVEVndLEX+AZpO0ctp2q9uROdRgeR/wfkOuUx68CPSzWVQ?=
 =?us-ascii?Q?/bKH54J1Ag9a9uoK/NahJ3L5/Ur0JIZqW+qTfVtP40+45bjlO02Nhqa80nuc?=
 =?us-ascii?Q?KEhiFQeHs5lKPIjiARoZs3i+ZvoJ56r2y++xETMd33ibefXkw2rKz87FcgU/?=
 =?us-ascii?Q?WI2tLqFOvdSuzyy2+OFnIUennqDNbr/OwUEFmwOZi8qgO8JIn9jxZBnXIwrs?=
 =?us-ascii?Q?WugIacsrthmE6gCpRmnsWR0xAo4wOUdc7IMd6Ms1nvfMHjXTNnQHXWgMKJnq?=
 =?us-ascii?Q?9aKoAQ30xj4wfXFmQi96ySipbW+GUh9ECfgQPI/9b0YF9WSLNkP5T9mfID6x?=
 =?us-ascii?Q?t8dZms2W7Kh7tNV6pLxO8AibNHoFJpbH0xI80ClGqkBRYOE3XTkY1/7uDo3D?=
 =?us-ascii?Q?yigl3uUBR2U3EgTMYnM1eL6UPhu25Bl1cmE7LoO6/f2Fh6efQGjJgCPOhkRn?=
 =?us-ascii?Q?FP4CTaNX3QOHi76dETLppCbCKbL8qLyqkeJbxXGJLFVfdz6MWD6AAZTyUdiU?=
 =?us-ascii?Q?w8l5uQDVxhzd4aaJlIO0OPSpUTT4dZYeh5vi7DyEMybO3ynfdX0v56njCHKt?=
 =?us-ascii?Q?grnElWVoMKdnp9lHrZiTplL3/gWjyjeLvYWzrwz00N91npPg6uQdVVrljpU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 901a9f6a-ca26-4579-3663-08dd81b20f91
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:26:32.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6777

Outlook does not accept the Message-ID header in the email body. Instead
it saves it in its own proprietary X-Microsoft-Original-Message-ID
header and a random Message-ID is set my the server. As a result,
replying to threads does not work.

The $smtp->message variable in this script for outlook is something like
this:

2.0.0 OK <Message-ID> [Hostname=Some-hostname]

This contains the Message-ID set by Microsoft in the first <>.

This patch retrieves the Message-ID from this server response
and sets it in the email headers instead of using the self generated one.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index a6cafda29c..216b23caa5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1799,6 +1799,17 @@ sub send_message {
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
+
+		# Retrieve the Message-ID from the server response in case of Outlook
+		if ($smtp_server eq 'smtp.office365.com' || $smtp_server eq 'smtp-mail.outlook.com') {
+			if ($smtp->message =~ /<([^>]+)>/) {
+				$message_id = "<$1>";
+				printf __("Outlook: Retrieved Message-ID: %s\n"), $message_id;
+			} else {
+				warn __("Warning: Could not retrieve Message-ID from server response.\n");
+			}
+		}
+
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-- 
2.49.0

