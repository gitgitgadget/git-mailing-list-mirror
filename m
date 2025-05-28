Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79D28E562
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452713; cv=fail; b=FUVvxLCW4Tu+LjaYshzB1ZgrG9TfdqOg2Xo7mODnTvF8aitJmXmJSoPhtBgl9/Ilz4qcz6hGea7UdAMtvKV0cEwWp9pCgpIFcXzOzBK5QTQRRYK2f8db09swv+4RgpL/Pw8W+BgnFpM3uenzgYYSnJTNVqtE9KyfwXc3F9HrSpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452713; c=relaxed/simple;
	bh=0Cpika9ugFFakt7wqj7tY8u+aBHCR44uC1itlcqjc4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGbpv3FZUOP//mfTTPR76IUgXrgeWIrNwKI3QcyD9RUq+8Dj2x/vBiTHCyQEKWRygdJO0tCi5unAaeGd7/6QMvP9CKzSbBrgawlgqgmyQ5skFZJHQOmzWr9iGnY7m8r6XYe8BrfgoRJzbng90RrE66pSOF4hMBitvAWHFg5k49U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Um7Y3bes; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Um7Y3bes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+uP2KbAr/9tccPK1q56DOzlhye/Rx0CD5TWOIAqmCKSu9c8OyH5rDuAfjSKx85PnBgy1rmOa3tg0ce2o5uKusS1oxTfPpqSRbj7T5a2gRKdp9azPoYEEkbtovdfFO71u/Kgvh4AxCI3ojR4aWudSbPdZ/gwdyf6UrhKOWgXtMb4nxLivRtRw/PgvldWumDSFAdIBYPn/iR1VGfatFdBLZyixfEPNDqMvsxfLvfZQ2C8rEDqjy26M9t9ACTD3hYUvUgcfVBl5VRIDkUoa1a02S6O2eJcYJ0t62EiN0GGZXjc2H6W72BzzevroSStqjygF+I6K8IYJeg/wToA0W1Blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8azEU02ZjiCgrWjL+jkj5hPNXkKEWFi4IV2Kfx1/uw=;
 b=eh19aaCODP00GY62Hy2mvvJ9vjqlL6hNEyonFMYACQuZfSvKqxPB59cNdoVgl1q4goM/CHS0oVuhlTvnfTGUfhJHtncWHSALJNcX7cQU8Bzb4z1iUGtMSvTBwR3gZ37mBAPw9g/neMk45R5lEbgPmeIGjdgHXIO0cUF3UJXUJIZtPl+yR1lE5rJHViI3R9NHC3x1rNvr+2GvyIw2Lr+JZ7j5zGPyjX2f6eyJKdsD2iDkeAggkYIzGxjM4ABOBls3UjtylEtM+C4GlypMOHjedzCZN5BrziE5jDFhIVGRa88P+gXwJnWwIypW5QItc66QfHjK03BXGGaJ0HB99nnY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8azEU02ZjiCgrWjL+jkj5hPNXkKEWFi4IV2Kfx1/uw=;
 b=Um7Y3besyqT8iw+9bEcASZpSPztUgHCJubphVWt5RjV2qn5+7Ym+4eVA2alfkiC1Sm3DBjEdk3n1Z0Cd++vNwzarZJgjWBhXxJYfx7r5K8dHxJGAB2NfNj6cDTcySL+9m9YB3d/Y+LAis3lTQjFkpACZwdUPG2hp+duasKN6GQhWvwWYu+9FQjjxBXZVww8PgI1iTw9kWxuMJqQGx7TEKQRjngLOhqD3peUEdR9JKxeIBzgWtWvrNLtt2SSIKiWafyIj8YOCwOlvatX7i7CgzZEGVyB6lbU2rIkhGKUaljLGOudrx+jdxS4qvct/pbxUK9wCeSSiEj/MyBphENb7Bg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 3/9] imap-send: add PLAIN authentication method to OpenSSL
Date: Wed, 28 May 2025 22:47:49 +0530
Message-ID:
 <PN3PR01MB95973F67A61F8CBCC17FE0A1B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7a2fba-c27a-4cb3-3f0f-08dd9e0ba733
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBLERCSHXadvhc9ELuiLr8N5ggUrDJKCLnnWuwHPmGcihvgacFADHaweVtznkxwM1R3C0VIfaLmR2ha03VChPLX3uTZoW8R8fUbthZKmuCWNQ/YGMhx4RFOEEWFKTnz1B6Io/G3De3R9SiOi1y8pcMkBQ+wTpbjAz4mFU4hyzrkp6NdxjFuKlyc7BCmHmoZyjQlqX0hPo14G1s7y8bE6mi/H4S9apWDPT1G4Dz4PY4d6ZO71YVUaq2bRVYPSFxWYkfLthQS7tjfL+CeGc1B65wsO47QOnbiSjTukEOlXDdIX5stOKV97lJCtAL2DRjUYU/fTVTSjA2evDAeMluWbGkvgYfehXUmRN+pBHCaUeBDHWbC7Toqcdee55dP0Okphnztn/68rBYPZwn3n3b9WEVs4iXfp2dOSUEb5df4pVqMymfHAR/YsjbaH3zNn9dCJCiLm12n1WRtZXloL8Akg5yUTndXb2JZQGQhkCGfjO0txI+zVufSiAZVtyoP/3UjNFjGgWQS1Rs6dvw14AcZyeyiVvaIc78kJqOX/b7Fz5sqNovJy/4OcPPG6RuZulL5ZXTym88sALQiF66AI8wiCcY1zIJ/S+Qfm9/3shUKz1k1Y3Y380YgUvLDc1HZSEHTcFgYaXQcRCiER2M2Q23nBvuKUFUUY+ssZf3xMJU3fGq40DHutGeKG3uuqrALfMydJF//wl4rFW+uUi+Vbgos1KLTSHweyhrP0OMdl04/fZrRVgCaXaxN895WtOP7y/heI8Bn6sbXzLK6y7qcDioiIO9sdeMZUwo17D+do50oM1FvAcIUmum/yT/xS+q2kN8J17DpuHlho8BzwpQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|41001999006|5072599009|461199028|3412199025|440099028|12091999003|19111999003|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xt8cbU5Ind9EVwwr7lRrC9zt/l1BqGQIf1ytoLS7ZD5foG+en9HHbXVndOYK?=
 =?us-ascii?Q?GeM7wn7rANgNivFA+GzZh3KaofhK88mCgQWltZCr8s345O57nUaucrURYZw7?=
 =?us-ascii?Q?3g5YEu2ks/WE7aO/2hsnxmM4KbLJFMs1LMNOVqwjuhnP4fwjQGpbirKEv+Jz?=
 =?us-ascii?Q?5SH7pFTwvmeXVJfbdlM2lyncy32Qs3kuYDNFQN39nFtWQjZUz2dczto1KOMo?=
 =?us-ascii?Q?mppgU0AorfJvTVBFjN0PdOpyAjc74WAk3fElsqD2QySRwcWEKgcJMMdOLA2H?=
 =?us-ascii?Q?1+Hr+SA7OEstjp8IHFq2ODTDJtS7O3fmwokb4eT6dNipJV3cuHwY6CsP1DBR?=
 =?us-ascii?Q?x1r6yU+Ja4XQyUajO5M1RMQVb0SvnLMVZoF0BqoQ2dR+nQ4pYGXC828P1yOD?=
 =?us-ascii?Q?yIjCpWqO07Tcs+G+REkugHRiJWlDKEZhutJXbgHt7RM+A3fqnMH6lqoAfrvR?=
 =?us-ascii?Q?hCp3ilb1QpC4gWfIWVyueA4r8ZsV0TSQoYqcAVFd5G4LAB6VSPcUFsfSry2b?=
 =?us-ascii?Q?CEZkwT2y6fvPv/jUn0OmSkuFBG9duELI9Lo+jgxkb72Ty8N1IqHdy2SRZ4g+?=
 =?us-ascii?Q?R5lFJAzxybpQqEgSbEEkBfioFxkyKO4akLVsGSVIjp2+1VSOglkPYV0dXERw?=
 =?us-ascii?Q?oLy61iECzU4GSm2aX3iQYEZfLAf2lv3Bpw3Mbe1dFkaQW7eavA59mW4D+HbI?=
 =?us-ascii?Q?Gb/j64ho2dayHxFRSATAAVpbsRD++oQslNSRp1sQUY8IMAKfoh8M0HITu/qG?=
 =?us-ascii?Q?HTgoHMxzsmxatMEWDwVO648Yycw64tyZamnCupsW13xcztgyyg01tFEQcaBp?=
 =?us-ascii?Q?1xVBFDxZaTLb7uEoU4Y18T5RjbHGKBrRscljoE4MHzZjm35Oy9q1ChRSd2QU?=
 =?us-ascii?Q?Ux2xna7kKlJHbCQ9C5dzA9KzXFslWeXfbqJe92XJQ8Nv0vRZtkv4JnCVpGzd?=
 =?us-ascii?Q?bE8LUJIGXo8/LB+uC08YO4vhnLpvuYelImdHTb5PezWLuphjkMI0p4V9R7L5?=
 =?us-ascii?Q?mScYK/9Ggrs1wnFdGECB4OxoBG6ZvJbUv0phEPC3yaD7bH+YZFuLfMCjeMTL?=
 =?us-ascii?Q?EPja8TNwi14czHyKsmrOOJZdhBH7uWhTE51odbP5l9eODb6Lf/xBivuybFFo?=
 =?us-ascii?Q?lqdiVAjB3fn22ktdhpgXoR9rTX1gAqHK9lPJwEj5mTGcvnhoZMtFjY7TDIDY?=
 =?us-ascii?Q?x2HViLzx0l99HoclwMN4q4JdALswKvZ0evrLeNLqlURcwlf9vrIw+FlRuhHS?=
 =?us-ascii?Q?fuiVFFU+eTwzTmGZAMqClVMvw6KFLhN02HA4dbpY9/5ExoQhtHpN5lRNR3ie?=
 =?us-ascii?Q?0eka+XKmnVkufiaWCMMNTvnl0j7mVrB1Dm0xSY4GWjxqXWVVCbaPPYVJjVjL?=
 =?us-ascii?Q?Sncx+JEXJ+g/2kdzzkRElhQK1VD8?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5a4lNRRF0wu4J4Cwdd+rcHD1cItK+eW43Ri0BNWubBg4gqNjDjin3vUt16JU?=
 =?us-ascii?Q?G55ffxJVP337Ha9VtwmwxgkJN3etMiVEJSTJ6PRr70jjgfG/UlI1fUup59Dt?=
 =?us-ascii?Q?IBMnIgQm2RtH+fqzu+XNaLVXLldqD/he/Ltz0QD/A3qexy/XDiiFXequnzKV?=
 =?us-ascii?Q?PO4lcBSP1xQyHHC4TrCs/tRMu8ZLyG6jTtdyWoaB5R7tW/p5CyMPkG7zbJ7t?=
 =?us-ascii?Q?61gcVb4xNoTKRdcIB7Luph+uwcBxXCpKYD98vojDrOkrcq6bLCwCQCi4K2HC?=
 =?us-ascii?Q?zY2IUTxfXybpLtRU3vuyu0HOzozAn2RciyRRzcHAwlH4cmKMRlTFghWJA4n9?=
 =?us-ascii?Q?zb712/zkdoyBnO3KdbhJGKGXNiOOekSNHUhVYAqxxGOwkIWjqM/J12YLTN54?=
 =?us-ascii?Q?XVFOFFRBuDFfO+OiT6msHWC/fApgGrkabmhCUyaU6lddjuKwd2Bpngu+hqU1?=
 =?us-ascii?Q?HQ0LyKiyd9y2fZG4Nta6cozWImiiGfuWolAFBUXDOEcOyUGTDq/XknFy9frR?=
 =?us-ascii?Q?RXUlrzJ70byan9SH59nd2th9m6dpqwa+qOCSmTtuZCEvkEsehISAwcNqtd85?=
 =?us-ascii?Q?qsmFuXIfATlWjB3bn2SgMGycKBmqkcvGw/EGy6zRLgPQTH/ZmlpWpYhDPsGJ?=
 =?us-ascii?Q?bFHYE0RK1UdTb+9EEzilDvJjXgQsI555fmLUhTW343za8hvuwDWFLriZGNXQ?=
 =?us-ascii?Q?FzWMBh4TdCmWVmSCorxressR/1u2z/M0dfopVwTZlgm76SoiIiAeTHMIIB8B?=
 =?us-ascii?Q?DX774Xw9dM0XkZZIu3nYt007L1MDMzf9PSBPe3vWXdAfVH7PB0UwvEwS+fGk?=
 =?us-ascii?Q?sq3cQYUL3k1Ki2bpJMhfByoA4hOyPKYS4N5vClFDCowUA06uGpCxxhzMtO93?=
 =?us-ascii?Q?l4cb6uQgnLN4v++Q1VbK7nCYDB9ZcAcIS3UMgV5vRzqTACHy+/M7AtCrtBto?=
 =?us-ascii?Q?UJtGXUO2txAuTJCNckDZdRm6uCmDvZlTyuo/tB75ouKnGzFPK5bjDc/F5hBg?=
 =?us-ascii?Q?euJ8bM/XpS/tsZDp2fhaflhGYXr4giEjlz0YMKzgkuEnetdBDix/BQvx7qNq?=
 =?us-ascii?Q?ab6CmmtgoINy8zYOaF61I4GYg67WFiBA3thVkaZP9vQ9Qiy+6Ykyi6SUP3YR?=
 =?us-ascii?Q?Bj2BB+s0vsuw8pWCOCuL5PhcnX3U7/mqCQm144O1xajG6Wa1PlzlJOfTEfTH?=
 =?us-ascii?Q?7M1Odi0ZuHAnIVeN8+FO6gtgXtTIcNvZuTQVSo4Q/Z+E94P0DLqPIvN3v6Iu?=
 =?us-ascii?Q?eLCfv5zsKZ7pSJ3693zRAtjHgi2vTKae+yDWb5MmU14mvr+EIEYyBqq+zDf5?=
 =?us-ascii?Q?wktR27tC6II4TqpW3Q3S6Pk5?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a2fba-c27a-4cb3-3f0f-08dd9e0ba733
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:24.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +-
 imap-send.c                    | 80 +++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index fef6487293..24e88228d0 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
-	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are 'PLAIN', 'CRAM-MD5', 'OAUTHBEARER'
+	and 'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext LOGIN command.
diff --git a/imap-send.c b/imap-send.c
index 0c7844aff2..c07ff98c3a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,6 +139,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_PLAIN,
 	AUTH_CRAM_MD5,
 	AUTH_OAUTHBEARER,
 	AUTH_XOAUTH2
@@ -150,6 +151,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=PLAIN",
 	"AUTH=CRAM-MD5",
 	"AUTH=OAUTHBEARER",
 	"AUTH=XOAUTH2",
@@ -851,6 +853,40 @@ static char hexchar(unsigned int b)
 }
 
 #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
+static char *plain_base64(const char *user, const char *pass)
+{
+	int user_len = strlen(user);
+	int pass_len = strlen(pass);
+	int raw_len = 1 + user_len + 1 + pass_len;
+	int b64_len;
+	char *raw, *b64;
+
+	/* Compose the PLAIN string
+	 *
+	 * The username and password are combined to one string and base64 encoded.
+	 * "\0user\0pass"
+	 *
+	 * The method has been described in RFC4616.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc4616
+	 */
+	raw = xmallocz(raw_len);
+	raw[0] = '\0';
+	memcpy(raw + 1, user, user_len);
+	raw[1 + user_len] = '\0';
+	memcpy(raw + 2 + user_len, pass, pass_len);
+
+	b64 = xmallocz(ENCODED_SIZE(raw_len));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, raw_len);
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
 	int i, resp_len, encoded_len, decoded_len;
@@ -951,6 +987,13 @@ static char *xoauth2_base64(const char *user, const char *access_token)
 
 #else
 
+static char *plain_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use PLAIN authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
 static char *cram(const char *challenge_64 UNUSED,
 		  const char *user UNUSED,
 		  const char *pass UNUSED)
@@ -975,6 +1018,26 @@ static char *xoauth2_base64(const char *user UNUSED,
 
 #endif
 
+static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = plain_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("PLAIN: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending PLAIN response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -1207,7 +1270,22 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
 
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (!CAP(AUTH_PLAIN)) {
+					fprintf(stderr, "You specified "
+						"PLAIN as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* PLAIN */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_plain;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (!CAP(AUTH_CRAM_MD5)) {
 					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
-- 
2.49.0.638.g5db5b64a3b.dirty

