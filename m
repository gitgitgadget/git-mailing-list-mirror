Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8266280CD0
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453723; cv=fail; b=cbYzW+GAUKPbWC4wFouXwjEutLmGz6XYkQxdZav3QabBLMLxrVuvv5iMPnnAa4N7aW/7jiZCqKdM7LozG8T8fSwSH4Xoqm+vPy4o4xRX3HfgZiP8vYwCBcWeyapTOhOD8j4ROja3yHKKtkhEj2HFOYE59pcOWfgwGzgbtBowS40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453723; c=relaxed/simple;
	bh=7vWFyQ7VEuRuJBtacMTsaW51vus7rZ2Uy4fMA1at4Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8Zq4m+SurMoWj6kP2HLU0VMpi7rQgUgmUu/WO/hMH5Qtw5V0ANgDeI1jxBSuE6B80wVhrUdll6JtLRzENjSwljWDiM4Uh9YfDH2YGzw3X1v7qggzgxx+lrX7s0wpYhjG5u5myJhdX3XX0MyNyNj3G33gFM+eo7WmsTLScbhOuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bV0wUsN5; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bV0wUsN5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdUNH4wFHEVRjzl4ZrPE+BnXCSUQ8rPulxqr/kYKzlwirAZz8vGiAMhrUmKU5dPkdp26RkRlXyg9aQhtdAqXzJSU+7G5xY2EX5ly+YraoUFLJK+jOza0m7RI9EmBClK//vieWw9XvD8AEcdCLg3oSlqvC/4pAw/RrUxXEXqvLQR4XeMfU9Gmi6V3vTA9404XAjltMqj+j5RS8A9S5kqLmPt4HXrgMVlEhUTQXJCABTuFm7XywFoX5wi4b4GNSNqaZN9oUDWkbNTuk/VYBDYHhSSjCI6ut3KAvQkotVGpR6DaoznTNoBb7TSf/UWToScPrtvo0Ntq6k+XgaCvp1zn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw39m6na1ODSpfyfoNMuq6uohWdGQOtSM5C/qTkFHZ4=;
 b=H6KN8FwG1xh/rC+UdQVQCx18sy++gSCHD3Fosb/2QzzHKjXVATjNg2u7xgRFTEt2ZHtw7Df9KwaQyBISr2OSUTbvLmPvpj4lNQmRDZgTGeDcy3nbDMJ30JFi8+QnFAWf1jfRbY3tcobhxuCkn+CDLX+r5ga0Dsn/2zGZAYqC4ETUaqJE/UUYt1h62P002Sz9FCo14DL/eqwgVeq236LplmXu9aUwKCtQvOeT5/deFMh/NRoc0UULXG3yumBJzx8NWGvEGsAntZSiKC5LT0KzOftsKp3CVJmRYfX3rCyrDph/ZIvKkJ8AXPm2R2BTOcZxbQzLTlxvAo726tsDmVDC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw39m6na1ODSpfyfoNMuq6uohWdGQOtSM5C/qTkFHZ4=;
 b=bV0wUsN5FxVlX6cYKhsDfepyNqMGpOQ4f3L6zuAqKI4hBE9cqwNpEobDt7aYEkmqg/T+HZbdROsLyKOkXIiwEbCzAhfLsL8ZwRgGLtfNhsK4ZG4UzMMmwYyj++IkyLH3rlVwmoa5zkuKqvKzbP3xzpZnLsitWrJDvz/wOQJF1CSxcCklLEiRyL6Y+Ku9cYil3u9XVoQLSM69B/VwkHDugNPIVApba8idSKdz4bfXceWepZncldrPD9DBVK76h0/IzIlWky7XKTr3mzsT5hUmRExr7TnrTKPtLiUWop+YnOO+2oOW2kQbieF7ekTS1Y78TdBFUbMnba0lzEAKQYbkfQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:50 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:50 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 08/10] imap-send: display port alongwith host when git credential is invoked
Date: Mon,  9 Jun 2025 07:20:39 +0000
Message-ID:
 <PN3PR01MB9597AF90BA3D4B3295ECC278B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g6561d45bee
In-Reply-To: <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B5.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609072041.12114-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: d6606877-fd5d-4755-d421-08dda72648a2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|15080799009|41001999006|7092599006|8060799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NDAunuvsNer0KZcqXDGDTy7YRcJnLPDbZ4waX0U3Cqlv2X6IlMYRkH5DnPXi?=
 =?us-ascii?Q?JFStOi02dEAm39B+iGELbJM2WGWxtWeVjOq/rK3LZ6ytxkxpdfWMjgQQ0NLc?=
 =?us-ascii?Q?UH6I/89LKPVZAzTiFrjdFkYXZ82Uhj9qZuV2dES9mnzs8i2VM1xJbjwa441v?=
 =?us-ascii?Q?1UeMKoQRAbFCIdxFS8dxWsPqnj3872TRN8h6dd7VfABg7WUU2gmc7wJWlpoh?=
 =?us-ascii?Q?7CXzO3rSdOEIbhh5XvLeYn2N7Ra7QLDSOChvhnE04AnU8acRL0jhQVTm+mSy?=
 =?us-ascii?Q?4Nt7JFNlgjRbhE/7F3iG2WTWakU5q2l+6xG3fdUGCJvok6X+9Tn6IIRxx39T?=
 =?us-ascii?Q?snCbdqBfY7+fn00s8mJPNH7eEThkKXs/UslwEzVrZSMebELio1+SZqgY4ihb?=
 =?us-ascii?Q?oQiTwkvjH05Y05FqQIGI9s3w+BRNb9NnEs5xp0gax0dY/OCPlBvAKY9GBfSd?=
 =?us-ascii?Q?YgmdHWBTY0gGHWgnABXa/Y7E3Pk3imcKr+Rup0CVfrIfnrKAB8Xtzu7Zo67y?=
 =?us-ascii?Q?SwhzHf3XzZoea9b6h2nX6TJNfp/1pHYNmJOo131Oc2FGoLF35AyBNLnidJnF?=
 =?us-ascii?Q?2sFyY1heHHMSQnUeVHjk3tGhGA29aS0O0Ny2K8f542O2VLyRbLXKCklFLPuO?=
 =?us-ascii?Q?X7+r2UGEZG87ZgGatsNlzUEnVkI7SFAYLpT/vN6ZuP25Z1oobCa2ONvvBxMZ?=
 =?us-ascii?Q?BE3EgrYBjVCAEFrNolZBUK1mhoX/83b7rSRwal7TX5txMoQqDSCuvClBYC5o?=
 =?us-ascii?Q?tpJqwK98Ugb8nrRnvZnl98MtOpcSa5fnnWKZ9XqHDp4ddFJUmHqDsJX5oWnT?=
 =?us-ascii?Q?TuUd5mzGfaGRyj5NmXo0PuV4WHJuq3x4cvvTEKoWwyJtOuNywSExgEcC7egC?=
 =?us-ascii?Q?fU7nskhFtLg3m56gBD0a9uCnqMEl7aXIHsW9fqKhLrjnrElps68VrG49DqUx?=
 =?us-ascii?Q?G3JjCfeXotPbMWav3jSyUrlr8Tk+pdFx56xD02aiZme1ohFTopZ9dD3p0JaB?=
 =?us-ascii?Q?MCaPNj9gyibz5MSlITdJ/v3oyl5ikWp2PQl6Y9umzG/NRCOgUsny8C+/KWQc?=
 =?us-ascii?Q?K87hre7wRcaHVRbPK3+ZA1kHvfXaA218tO5sL3pCGMNTWGB9XWb91yKWbAWx?=
 =?us-ascii?Q?WRuGxAMFQ8evDD6th23IkLP0wQS+9ADoEw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OFILTeKu3e27ZL0Yfi3UuGxgrEXai1dZnHZdj5OERMwWwCRvWKyvNb2iNiu?=
 =?us-ascii?Q?6CZJYDuELZrKIqnNZgGst5eWb26FjtG97Tmq/jOuakN6QVojbB1v3J8Au/V0?=
 =?us-ascii?Q?0vnXcw40TNK+EMgn3VIkSBLfQ9vkCnqKxc91tNT04Aekx3hPHVbuYrY11AR6?=
 =?us-ascii?Q?OXUHBc0wqu2xYiPCPmBywl5IbqnwTkGjXIMxgS18orbYZHwTjSCwZX17KcmK?=
 =?us-ascii?Q?yrsKA38Lsi6jD4+hheRJGbM5XHolWw/QJDTZRbKJR3umRvSHyjCw4aggDryN?=
 =?us-ascii?Q?TAGixTinBVVzos2yS1s9M45uuCqWE5dJLiUK99rBkt+d9pw1PHFs+rh1/Pp/?=
 =?us-ascii?Q?N0tpMMjegCLApboVk3zi0UtGBT+WXXmlDQOoK9/UnmEXbh2tHR4wOapAFvA3?=
 =?us-ascii?Q?81qHL0v/2bLJg/qho4IgKNwmx3L1iRsXFDdz5rXNbv9PylH0kUh3pj2ue84P?=
 =?us-ascii?Q?3Je8gfA84w8fqu4oIjkTmpbD0UXwAY6+dTJbeCc63/h2Dp4L1rNHRuWJjHSK?=
 =?us-ascii?Q?YXrfuSjZjuAsigVl61/eXfh61u97szT1yeb126n7bVe2Rztv8WEL0lBsw+qk?=
 =?us-ascii?Q?/tKDbmH4WTceWj8YL7pL7Rm3taxZ0VguF0hclOkCUKzM0B8HGujdxEqbthvu?=
 =?us-ascii?Q?uVuvym9AGMZTNlvs8WK5wp9GDU6vqpHwFNxztswwZOuuEQdRf19JoOc8YXa/?=
 =?us-ascii?Q?WoxmdGqZBZ7V7ndIDP68Aocsxlzmj991sYEl7P0qIIO+PEoC391eSuwKvb62?=
 =?us-ascii?Q?mO7qgHkhuoGi/Ut9jD7M7ZzWeQpiVK1obdOmZZlmAp51mGB0Upq5lr0lVnhT?=
 =?us-ascii?Q?g4F2TiFJb/lHT7Xb6jGoCIqDGQPaOENQNIu8qxzFLwRcUqM7NWaz8fLcfWqX?=
 =?us-ascii?Q?zLyegaRqdXN5Svjvy06G/PoOy5jzhds28jA8g4XYgdsyZH0q7Et7vURou46D?=
 =?us-ascii?Q?uo1V+LIwADgOzfc+Uh/1LDXDuhBNl3NiFjxtkzQTE0eCBnZAnW+x0oPhGzz6?=
 =?us-ascii?Q?sZPPBXsiYfwynndA/gj6bVLiYtARRHZ7YXN2aZPSIQG+LCHPo+6RppLbOSxi?=
 =?us-ascii?Q?aIuw/xO7x8WXPKf+cEwzXAkz/69Y3NRKmE0Y87kLFfYNE/ZFHz49+u74uEdq?=
 =?us-ascii?Q?FZmH4B0zsjOJLx7VS/Wo6VE8HTjjE49qA3doyIYSTSeWRQ8NUHhzphqc6WB8?=
 =?us-ascii?Q?Cl9TUm4+F+K87Vr7HqDPeY2Q3P36ZVTAAyoTbSSgv0ofp0OjFcjZ/yT5f8U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6606877-fd5d-4755-d421-08dda72648a2
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:42.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

FWIW, if no port is specified by the user, the default port, 993 for
IMAPS and 143 for IMAP is used by the code. So, the case of no port
defined for the helper is not possible, and therefore is not added.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index f03a92a2fb..9807012169 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1089,7 +1089,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0

