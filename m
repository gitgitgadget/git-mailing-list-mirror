Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B1219A80
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240544; cv=fail; b=l0hJtz4A/kAurt+ticcnm0/f710D6gDHLxzv1TLLw/U60mYEMAgSPZgeRuSqkVm4hPxi4Oh5qkdlJUP2xeG5sxBp0F8c27zox1gJV5hg/ou+9xgYrk4GMKxzdCP+Exrk2Ihb0mg3K4Lt74hYYIDAcWGim/o72xE9/6/GMzIkQGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240544; c=relaxed/simple;
	bh=VVbZpiqCNA3hF7gKuhJfmTd5CSxwnlF9pUpFrkOJzvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKkk2SiuYpUFI5mdjbwoevcFSHLMn9hagc5H3Pl7grTxgvYXjB/qYechKpQUsg/bemySEgcrkLc7w7Js3TWdo8npbodT0hk3Pm6XGNz5GxLrbZ+4S98m6HIxWGKA2d4sXPWxe8EYY4t2VoUWR+FdoujbUBLBx3Muu3Fw4/z53Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=guTv7vsr; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="guTv7vsr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxWOdQahncJm96ESXEg0aTF16uqkTjao5LcFynp9CJS8HslZAxtlWaHjVF+TylZdV8MVfmTlkbiR57E3PzWE2OUsuDIzCmmueUmMbFV6H902m7Dl5DmsIrz5hVEM9ISuDP2aGb5o3nQYlgghtPbqYKOPoQtRh6E6Fsb5RTd+9LlbD0P7WlzWLrURuF01PMb4u3zbDBsQ0rmYJnKqxHeVvGkr3JCgY0qjYi6i1Jy/3SD7uEZuJAwysOxf7EfP/I450zNM7XwUkBLYEzirVbjQzxoOlTahOvEdweY1JzdcwsiAI+KnA03Ht6ztPyC/QrkI8lPXs7DlPaTYJKO+6kAsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N93WEbD4oVCzNE329mHZR2tfZANvUQ9hk2MQqFI4AWo=;
 b=HMHjTjICS8Y2omRwOik80E9yDCMN5g4jIkOROOXKoeqz4WdP6p/E9Cx432ogrrgihAqmRo33FiKyQnXweLEO2emEsZcd2TQYfzuz3fgDb6DzdevOwkZB7omSRWzgrhK1ShdRr6Uq6ZsONcKmZJaLDxY6AkjJWQSEP8mAiqT5gMpVXaJ0dp5cHzEZsOxGhKsYA+IXyl/jsV9Ef8E/9ZpKmYcxQthJwKK9SzN8KefENtVbeWK3vP9OLbAGDQo0RjFlCbp7LLJM83e7w962iJMkd4v6Nyfi6juDiFXPRq6klLyO3JS9zfdtkhVoOSVC9tQ2LgaVHfAm3WwySW2zpfGfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N93WEbD4oVCzNE329mHZR2tfZANvUQ9hk2MQqFI4AWo=;
 b=guTv7vsru26q3+BCNiz8d6R8R6061DOgK8OdpY/6/7jrFSHHH7dLrUOfqF5ulYCk4RWqkFHoCOBHFJXySNVHF3NEp2DDHAPuU1t18GEE6In/OieohNNTZXC9N/kx6Xz2eeUVZP5w/4wvgLAau70RMWAM34IeAZgOQB8/HTXYk8eMyCxQCxYUqDN6s5kYOOmKJMXN4EiAdMIup677sdC689Eu3gA4aFfqPPzJD+wkwYimTkJQdlBIHMyoza2CJ0xgIYb6S9JPYiPSqPa6igCJZtpV5d6fs4rdGDLiJmZaAa55pWTJltb9LcHxp+S1NQMmbypXvtqzrtXbHbF3o2nc4Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 05/10] imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
Date: Fri,  6 Jun 2025 20:06:27 +0000
Message-ID:
 <PN3PR01MB959732DB7232FFE1ED7D38F3B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: c13ca7b7-a831-4a37-53dc-08dda535f3ae
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLRD5RrPfNelPuCpDirA8PgpPLjKKVu37cwp4/K8n/UJLdh88lQa7cBZdMN2FSIC1ZW7ZLOMcRxoAbSuvDF0YXy4aaJqZFS6VJQyreUVq+rmXeBsGLd1BTJ6sy+BbffyDSFxN5mwrXJhUyZE3+Sfn1CP9/5PCyeR5r9THqQUFt2XItGfqydB0vc+ViWKaazdXiAYfzbYaerS12S3+3XgU2xZntKEZldz4URY33Z979Q+1miUH1R48ccadeJDNsXknN5nuip1iZT/3DMgYSWuy5SxAFDFSla5gWoAqXhKQRzfdFTaXdxhgsSdh3ma15O6JE0aX0HRoqfq+JrS3EzHrnVOT8MffnzHvXX3lPbxTHSxgx+dz84PNHi4RGvXPNvfrngXP2coMQNubLcYCVyFGPsK6/jLch6TweHQZnt1CRDXJqx8Hs3ZUk4sD82tMc56eN+VH/APuMMNWbHESr7GKz1YDgE2RcjyTSvik+5eVUYyHfgoPQX1ylIvGXD3sXeFQpuUQQvz+elIkxtRHugUxnkvwQdDqXO2MdmGqqP/xASMEtWWoav/APMGmVHvTz8JQi/OroptzF8QEauxKxpdzeEsQsRf+mK9IVdC/ePgC4r0dnkHisxjenKAPhyNN3Xr+6qQgxiyLHj4VFYweES4g8vQ6TRGhAGsXR23La3qYG8RXmIQ/t6YzKd5xT4/jbE4yKCR8uFX2tDTNW4stTGsZzsFZIP9oU3EU4rzyKbodGeLBTvE5YN24rEmHeHrCEkA0NiD+ZGZm1cbWDLhq+OEulT3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrczShDu2It9EpS74uqxtx0PO9r63BTJWKbC1ctmQSmfLSm6cRscT9UirO6j?=
 =?us-ascii?Q?c0pN+rpKq2sCHTI8YEd1897mMi2rs1JtbKKMm7A9eaTmzeUoY8R7Y0cnkNxs?=
 =?us-ascii?Q?tZccatTsI4451l+Wk6gTvFTB8W4kP2PBtWBAcLo/unGtW+rI9PR4FL3qJH2H?=
 =?us-ascii?Q?u3BM7YUAxNqUI4HyFRA8WH/HoF6VxZ2t6UgmXrM/pC1hczSMmDc5pa/P1MLt?=
 =?us-ascii?Q?kl2+fzWOsJle3ve+zZGXAbJQALuoutwsy+/ZF9170rG+iFU6REjYWMTv2Uib?=
 =?us-ascii?Q?RlQgz/khMsf9ilNbHmaKof+JgOTIwFF7F7NybQFprZYZhT2qpcxzI3b6Du5P?=
 =?us-ascii?Q?TQXz0oBvXmlGBk0LuK+C0oJmUMAn/pZyOj62B4WiKulwM69EoOVJyIPwoP4u?=
 =?us-ascii?Q?hYi6nFWLVGEwW5OH1tneTRHoUwM/zS/35NXxidODVKkRyc5KJaxQvRUqJ2hW?=
 =?us-ascii?Q?SqqcwNaXkr40fn2zfc0BwvlUU2wS81HOiQxpD70HXMBoYtPhVD5PfdFDNgnd?=
 =?us-ascii?Q?FJqGLWXBsAWq2Px7ZYaFNgvREbbO7Zz+kfBDidzb5I61piTL+jjbzY7Hwk8z?=
 =?us-ascii?Q?Ppp/QZb4rODH1jNuYzmfG1pqwSLO5pB57A5/EHCfHU0tAFCEGiDI4ZebGzkd?=
 =?us-ascii?Q?fXaWirrqJ5GYqjKo0tNp6gkei0nrtE8w0ZAFloOlJlUCohz3VAtv06/wq5Pb?=
 =?us-ascii?Q?yl2wIx6WMiehRq7MSbuQ37ie7yoJ70vpfQFtvo1ZdUdHjQ94COXcJFFNGYp9?=
 =?us-ascii?Q?lNkfkOTTMC/PSlsyNT7OLfydC0IXR1ucD5lhSF2dm/0KiZVCEPZW+plnT80M?=
 =?us-ascii?Q?BYfnl04K8/F8c2GpDemqAKf4TNsMoKanrOI7RtbrN+bkaXPVRt2jwxurb9WZ?=
 =?us-ascii?Q?/LrDjj82FctubV5qK6wrbFs/Qn6VjCRLXhBGENPqLIHVSTp164TKy3/4Z5eH?=
 =?us-ascii?Q?/TE8elEO8R0p365ZmB2xWVbA9jxs7Lhnpt77DILi0X6DUiTAljeVXj1esfIf?=
 =?us-ascii?Q?Y49RE2RPvCbAN7+80DuQLMlVCoMANRvHJRRUlyfIhqKIWx1biuvm/ahwcGkE?=
 =?us-ascii?Q?8GZiZjAUOJPc/VamzolJpdS6+joIdGJCLBmTGFKvqAvKwwI+AzybD3mPlHMI?=
 =?us-ascii?Q?2KGP0ed71Ai52YKzO+gmLy3Kchoucm7qMAMAXLqZH8zvEiaoKBfBiis=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qmJBmBeXW64MxQZdCZKZtGFvRE860GsATng0DMzkW/NRWN5eVpJNi37wMS4?=
 =?us-ascii?Q?CA95XItjZozjC8qLbhOiz3undMCnixcXUtLMaq5xAesx/4I35TQkoBI44s7+?=
 =?us-ascii?Q?z1as0oyiXPCEzF2pBJpJlvLaKu6rHN3Z+LbLRBtTzPPW67UlNqoYBpPl+n9B?=
 =?us-ascii?Q?p1C4NbnfvQPuShlP61ndCnhAduKnA8HgxDtdBys3V2MwJ27532YrQHCpnqdG?=
 =?us-ascii?Q?v2Ad7Ps6GpzD6XA0C/+0SvYv7PQeg41n8TRaKa35eR3LdcGeRTpyXSQFFyUI?=
 =?us-ascii?Q?Dp00IzAi3YtCgRyNtvqM3a2vPDY7aJHhDkz32rpF87bSjd7hzYPpdYIeHjQd?=
 =?us-ascii?Q?guohdBvq/npZmivySXQRarlLTuhEhQpHlQ7h797V1/nNFvOSp1T6St1Tw7WH?=
 =?us-ascii?Q?ewFf+a37JcwiXanaP5BWucgdI8wxi1ezgxRAV4FRr7bICVld8oxd/ClY7RFl?=
 =?us-ascii?Q?j1xbHn+vYPxm6CaiUUlazOx6sy83e9iq79VY4KjiaLtgGOGatW9cQd43B5sT?=
 =?us-ascii?Q?ntDBiiWNK+dY9jV8yfz6bCVNiFZbIBoH8JpQm8xfZmKmsVBG9mByP8zbGkyM?=
 =?us-ascii?Q?510mSe9nERrOtwTiDAn4uqSAT5+0U6+qtc7FbF3+dTnQfe+UpvTrMuypuIXV?=
 =?us-ascii?Q?nGLhjz73GXqT5n1pd4xBMriCXvNmTl6cygwlRgxBnu2ZwQVvWBPExHniZVgU?=
 =?us-ascii?Q?Cpb5MVIq1d1EN+bAr5duo8arble6jN9m3V0Qc7vEgm4IFTxQX4QsO+5cT2KD?=
 =?us-ascii?Q?FU1pjoHYZasZlGF2hmF+9Q37n/iiNPfMgzj+m1nDx0dDwT0YsV02tTSbCQMA?=
 =?us-ascii?Q?pCP8CsL6PwH5enyhRe9eS2tvjWS0Srer3bRnsqcb+XCMSxtpeBN0d1dPQ3nk?=
 =?us-ascii?Q?J71ciNWB5hi5azOgoMXLE9Sjedh+GyRH5WkUbEvjzvseR8i2lRi9XzKiejs1?=
 =?us-ascii?Q?2EZ0SF96rFe9NHdiDVdjmL/X57PBhzHr3DnGIM2GsA3oX07AKZjCF8+oqGBE?=
 =?us-ascii?Q?gDXWPsY8en9eDfxKeau7jvTpvb1PUcjyMyBdafz+S5ivbBdwhEX3rG5EWg+a?=
 =?us-ascii?Q?cJU5hY7jJ138swBAU2TxVbvhYatd4fPXktel5WBsX5VKY7aST12fYr/6LkUp?=
 =?us-ascii?Q?t2FNIaF0dpw9zZ5j+OD1zu3LjVYmCLZLdemSpTFCRbewLNbR4hmRmu8Nfrl4?=
 =?us-ascii?Q?ImtQpmhJzXDMW0tz8oPFNvbXFewMxs9cbraKnrVL6zXpXOykg80IgTISadI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c13ca7b7-a831-4a37-53dc-08dda535f3ae
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:49.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

Unlike PLAIN, XOAUTH2 and OAUTHBEARER, CRAM-MD5 authentication is not
supported by libcurl and requires OpenSSL. If the user tries to use
CRAM-MD5 authentication without OpenSSL, the previous behaviour was to
attempt to authenticate and fail with a die(error). Handle this in a
better way by first checking if OpenSSL is available and then attempting
to authenticate. If OpenSSL is not available, print an error message and
exit gracefully.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 61 ++++++++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 6522f80964..c6e47ddc42 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1008,6 +1008,24 @@ static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
 	return 0;
 }
 
+static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
+{
+	int ret;
+	char *response;
+
+	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
+
+	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
+	if (ret != strlen(response)) {
+		free(response);
+		return error("IMAP error: sending response failed");
+	}
+
+	free(response);
+
+	return 0;
+}
+
 static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
 {
 	int ret;
@@ -1050,38 +1068,13 @@ static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
 
 #else
 
-static char *cram(const char *challenge_64 UNUSED,
-		  const char *user UNUSED,
-		  const char *pass UNUSED)
-{
-	die("If you want to use CRAM-MD5 authenticate method, "
-	    "you have to build git-imap-send with OpenSSL library.");
-}
-
 #define auth_plain NULL
+#define auth_cram_md5 NULL
 #define auth_oauthbearer NULL
 #define auth_xoauth2 NULL
 
 #endif
 
-static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
-{
-	int ret;
-	char *response;
-
-	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
-
-	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response)) {
-		free(response);
-		return error("IMAP error: sending response failed");
-	}
-
-	free(response);
-
-	return 0;
-}
-
 static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -1288,26 +1281,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		server_fill_credential(srvc, &cred);
 
 		if (srvc->auth_method) {
-			struct imap_cmd_cb cb;
-
 			if (!strcmp(srvc->auth_method, "PLAIN")) {
 				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
 					goto bail;
 			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
-				if (!CAP(AUTH_CRAM_MD5)) {
-					fprintf(stderr, "You specified "
-						"CRAM-MD5 as authentication method, "
-						"but %s doesn't support it.\n", srvc->host);
-					goto bail;
-				}
-				/* CRAM-MD5 */
-
-				memset(&cb, 0, sizeof(cb));
-				cb.cont = auth_cram_md5;
-				if (imap_exec(ctx, &cb, "AUTHENTICATE CRAM-MD5") != RESP_OK) {
-					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
+				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
 					goto bail;
-				}
 			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
 				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
 					goto bail;
-- 
2.49.0

