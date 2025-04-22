Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969B22B8CF
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312230; cv=fail; b=vCsJfDGExRYemh7ChXobMdNjY9PO8UsCoKXhrcGZ6Qbz6liIVBj7G++ttZtf594eCqKH+MOPtdqrernsV988KTVMu9NVpjkSw0hXPeL/aMX3/CBOqaVc9cMYPQ1xixUqM1eeMTtv8fJzx7R24ofJ3UOosHWkHYy0nQY8LzETzTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312230; c=relaxed/simple;
	bh=zLesOLojC1I8iNixixzHCA28fcQaS7mt34UtMXsi+2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8tvoiVTGIhKprUB50fhI0M8EVFAsdwuESwjDjNk46EkZu0crS3S6DvltKInZ7ONOXgBTFRbHWlbttWYfye9FFGk3qsKnFiTYvToXNDvHqPrUOch9E1PaCATbWPrhrS/JCe+unu81QqkN6B8NkfeobPNxG9csS0YUykCwtaTdps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UhHMfs7s; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UhHMfs7s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNIUPIDO2/3UZatrZEzmVLI4CdCT83xfSD7bXZzxsOKPpigecuDJnuPXS0sZ6qytiN8/tV48WzgtCXugrYoByhdJnYNbl+aLMa8gO5Oqp9iegNH6vahHphOl4m4tbjhd7y4ET7xTk7sFxV4VLqlBzSv1ln4otT/+au5mSq6FKZuIt5OMckA/GqHsP5p76R/dzPeO6jzTohHKK2scUA1Oi5lxCe4VoOL4AeTcco+gw8/5Ok4EMzXHu+9/UO+/anZfEu8s1Rhw0UTXtjLXnq2ivAERzDYfTY1zn43ys38iQzhJ9+Bei46e+GQCKiIqxn9e0J9uIbXhmriDP3YejxeORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n++MV3m5XeUOo+WDfinMJD6jCmy8MJKCK3OoQpLI91Q=;
 b=ymdlzXXas29gsUduTge7qqcbQcH05xba3eQXRN4fjSrUouy1cvKGwKIkVKCf4AB6OugGm3owkMDdTGxdMPqFJw+Xad0N9Hypxcw1fLyRaFp9VqcOltoDPwysJZZhWMAjidR6r9jzpG6ymyzQGXaFNuPM0NMikwSyrzqF5CYTVDpMpXFmzs/I4q7MMdm/l6VzxQ61PrksNIDrsXNsd+UatHFDFfRR8vFdnF+KJq7SCiJLhyMYFgEXRe0KljcmHUOQ7/gtLFqwhx0MIM+HkE142vVc7OQFjAM1tVtf/OTWA2VgiT9aqkej28ZVWGuSHwMEzAbSNZqDgsMG9NjlYfl1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n++MV3m5XeUOo+WDfinMJD6jCmy8MJKCK3OoQpLI91Q=;
 b=UhHMfs7sKjy9loSwpC6cWrHxjpaCsU5pyoE3L4d1O/SLk+/Vu96m2zMbzz2pUEoFWpxziVw2hfPsj2tQrtS1kaSZouRCnq1o6nxbTjgjHUrTRMIOcqznQEncVtW0r3UBd10A1cQEUH8y4ZrT/G+BZ2qb30+8MORtt98k92QUQpUn0e3q68YCFemkDXN7OyJ99L/LH9JkWdVYkfNxugiekH5G6QVqkEj1O3oZJXEHbwPIRxGoY0ad/4JKjIGLVV/urxD0IZ4OAKASTD/VhZ0tRCzrPphK7GY1A+/KsWc0WOOW+5Kq1FXLXOe6SVBPyW8j9I5eL2rynjwkWRiFHIlU1g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8754.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 08:57:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 08:57:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 2/2] send-email: retrieve Message-ID from outlook SMTP server
Date: Tue, 22 Apr 2025 08:54:25 +0000
Message-ID:
 <PN3PR01MB9597A491CB14F4DC5DA6AA69B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB959739CFCF4D1EFC14259F8BB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB959739CFCF4D1EFC14259F8BB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b7::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250422085616.9679-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab49350-af79-4478-a586-08dd817ba45b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|5072599009|15080799006|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dPp/uoAYd04fnqccgn5V/+sokyoRhMgePyUYRTjgBEbV30ARrUM9RDDOE9qX?=
 =?us-ascii?Q?7lZEghDLzP8zr9loNFftbu7I8qjg8nZPveQLa3u/Q7n7zAyoM5uQSqW0m8mR?=
 =?us-ascii?Q?JC4jMv9/6+i7fukobPp+KK1WPjW8DUyI4mLeR05oVSLcgYa0HIbAeel8Mkkc?=
 =?us-ascii?Q?FA+jF7XO9MmNWnQjXhL/ahjLm3Lejrv/LJBsZilT/vcA8qN2iTDlEy7fca9h?=
 =?us-ascii?Q?2encPCyUFpNnw9YLXHt4N3ATgPStWFUvtkEToEYqESv8wrYu3vELGIzF6w4T?=
 =?us-ascii?Q?8/cVqLLish6DrwYak8OFsfLdf6TRy8HwJCxS3OubRdOhOuRmcKcnsPDTNXnD?=
 =?us-ascii?Q?VsYX9zS1sr4isbMporZtR9SXw/t1bRQhs1xMsOFV/PtNOTiQCVtZY9g/U6Nl?=
 =?us-ascii?Q?jq/BJZzs53fD6Ieg7LQhj859qcyCmkdRXLzcOE/g3aNBDmtNSr1sH4nH7ymE?=
 =?us-ascii?Q?xJa/nCNoMgXpa5tDQoFagDqp9cy7U1b63Ez7UNqCzNmy4o4LAELHFvLYCSW5?=
 =?us-ascii?Q?glGWN4nzOneZRWZOu3Rt+6QOHrUTpWcd0S/0dXN/qKYzmWzO+c2PEJi8u366?=
 =?us-ascii?Q?UBT+L5Vo8M2M2ZVnx/sv6G5/Rt70pd8Zoc4igqMcjcvE82IfZ11K7L+ooLeX?=
 =?us-ascii?Q?q72xhW0wsCjzGFz6UJbeoJW8/DFOPIoVPkmbpL8+93VLTcKWkgylrEokToFw?=
 =?us-ascii?Q?GZ5OuTAKNaFAJfQKikI2Ut4A6r6lUaH3uEO8Pipym4rYUOuk1Q+GIE1HjnYP?=
 =?us-ascii?Q?uVBNaJXNUfo1bXr0OM0cPnwIVoo9RlMzWcRX8u4LKV6BoGygZN8SXyPLqAh2?=
 =?us-ascii?Q?EM9VgNEw413gPSWLxIzfgOmZR2aHonBOcLnSZgGk4QKD4Kaf0zaNkyFLG366?=
 =?us-ascii?Q?QPsupWro/mrJLwFvTUOQsY+9xVU4HxkYgOiWf4fhf0bTw1b0rJstjexV+/9v?=
 =?us-ascii?Q?WCQmg4Agp3ezLDmjSClo5PFe9xzm0hmdOcGBOywyqUjNUmzdvrWggt8XMvVh?=
 =?us-ascii?Q?jTYUcq0T5VOM8OhIDdnEvQqywt5gEbWwXccxk3JCrVa6uRqpmBY2ufGIhpmR?=
 =?us-ascii?Q?3bIpo4r6O/OKAuGj+dUbXkB3YysBro3/LwNvCH/9GZpSHGtFtHs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ddoZ91R2X9Q2Cb5LHSw3Z/cpI/M8shRbZmlec/4hyuylds0Fb1FRXB2aY6mS?=
 =?us-ascii?Q?+fqRlRNS21uZK2hyJ2D/7X5yObY8z5Q2+0XhSJPeTZwEDAIxV071u7hb63YY?=
 =?us-ascii?Q?hG0A2nf0zb0wL4Re7XdTZ57tPtl20cSRWVAUx8z+83ldDmo84ppYaR7U971w?=
 =?us-ascii?Q?nMArVGQa8sN+WdUbbOOHwOGOpBm/P2xR+92Ne8SxzqrHBPVz4tKLHV684cha?=
 =?us-ascii?Q?lkjE88iUT7d3dqSKC57zgQooYHcdKihm1zAmyoIHfSX++b0xuJmxQkus+Ydo?=
 =?us-ascii?Q?6AcSq1U2HPlNfdiedOXGpWe7PV3k/3GYFoA5hBYnCxb0WkJNakrnADTa+1/t?=
 =?us-ascii?Q?rmrWGvv/fsSjPXPvmSfalEjGVuUo4s/DvRD334OvKbqYbZZ7spfBU/zFIYAY?=
 =?us-ascii?Q?OjQ0/YC96pXVUau9S3SAMSvhfzpr3yGBsTUPteuOfBHBWskqtyVXu9BAqrWz?=
 =?us-ascii?Q?+KXAjdfQz3ngJLKLIhfchXPFpFdtnzqOT4hfizlZcTJMF96Q97M8NpDR1W3E?=
 =?us-ascii?Q?pkcmD5OYbEr6nj+EUnbjwAQf7RER70GKna3Im2UV7WpielDYMZ7DsZOgvMMu?=
 =?us-ascii?Q?GQ8s5UN9hbEm2u8hgsVidgZcCbIktYS3Rq0iJH1CCSAMyYgQqKtLdo+oTP54?=
 =?us-ascii?Q?y5TmWtC91Fu+nwEwQbPDFkyDsUzd83nDyu1rOmL1+MQDMRrWKH8nkHJmpQvH?=
 =?us-ascii?Q?bbsyr5A3/RVeTFN7UueY7tawpF9s1sjpvQLNO/hT29oFFEXLZePK/Iclb+il?=
 =?us-ascii?Q?7j9Ww2CfwC9N/J1CVwjVgeBowJuPXVr1Kkr4WclbS3vL97/Tr6IEsQa33B12?=
 =?us-ascii?Q?lWqCU1L7gmL8qy1EDlEgj6JakVh0AqykNhCyi7LZTWeC5YIPz2rZ8ErudNyY?=
 =?us-ascii?Q?Awl86aEyh5n3Jg3M3BMk6M68wSG5R0cOrVB5TZ5NX9Ga11QsgRZaDBqdGDGS?=
 =?us-ascii?Q?9bdE37pAUOXl2/QEiXC1Lvi7yfO744i3bcKc1VZ2sp0Zpcf9ldjNcGqvOE+X?=
 =?us-ascii?Q?7u1923E5nxP+NEoxQAdWDtCo0EuZBXO7lwM/QmXAiO5Un/lKtK7WnOdKixCU?=
 =?us-ascii?Q?BYOzQ8GXgoUgHZf0o7I+DP/uzNJF1DOjzlDaRj4kywjleImUzrpyPvq7yDcK?=
 =?us-ascii?Q?d6GwDX4UCcXNFHZ0uCtXJHgrrM+gbSiFoJ1qFUS7T+hgYTYNzjIaAU/VPD0Y?=
 =?us-ascii?Q?YX71K0aR39xwCuIVOf3UIYvJrSDFMaOCa/x1juMxQiWJ7BGBCdkSJlcvMKQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab49350-af79-4478-a586-08dd817ba45b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:56:59.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8754

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

