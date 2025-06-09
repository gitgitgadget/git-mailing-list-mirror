Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7421170D
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483768; cv=fail; b=VU+uz7PNFCymmn699ImBcWMHVlSRz/QYFAj0DsfFeKbSf/vzGvdEPUGG6w4YPJnp7avTKZLYvIoON4LjI/zmNP/r1lKGga4YzSnuN/YWaPiu5JkKVT8c8ztU/gzBn+kYs/lL8/m/brEg7SkBx8L4uE/Ai0Sgn7JJ6UohUzAnKMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483768; c=relaxed/simple;
	bh=tKXoEsxPJVhTb6ACUXVCXRY06jwTmT57yPs2/414ars=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rOlBMTUuUliKgAX86wb3iv04Xn0zaeQ+lZt2gW4npNPDktJNvNFCHB0SHTS1YWllELq/TTRW1uk9YGXUYrctCwQoCtAurHNDf5CbGTrtHe5r8vAeA+y4Kgd4ZBqD4dak98/v5Ir1A3WjXI5d5icxRcp0MRzlXTot8XzcGcPxugQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=exdRZdGC; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="exdRZdGC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkvlCbIIzBk0lUcdrzO1SYzS+N9Pf2vuOLHIh+UpFf2f5PpwMY4wYWZkmQcv0q08iMSUh5CWbUQfsy8uCNyn12sAsiTwQ4crPfIisN6bW1dkl0FwcL9CNELAvhMU4Pi8DQy2v0AqqpnRhEYRq3R1xSu8q2xHel+P4FT8sH5HrviVCiSlaFCQUzH/Mc+ar+actiIrdeGaGEIhyzFj+dSYDprmT89aTpiI2PsGko13+CvPrMfneQ+mQR5XsXjgUp1EEzryLAduhdxKHcPf1j4QM96njMJo5w5LrXjezpqVVX76YBxXTkCL6TbNM7/ABuziPySU47sqZfZt6hUpKJhuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJaE4EbvCH7sR7pQUud0A0RsFByP8fzj0yQjOiw02HY=;
 b=dLsf0GZmFXkvt1JFKIsSXdjf/WKmJDCdcIRVPYQCtsSeENOMShU58aGAdTLryAAU88tuoUQUIdccjvDd6rroF1eBg2i/AcHYlkWXyRsdzHjfI9emGcBXSkHENd2e9//+W1xVQxagpA5wPyNpMPpydBsyZch/n0CbdE/EkCNlf+ftMZRe1P722IF48ExDiHqv6lp0kTuvb58lzvxco7aQLK6+43gJO6Jq7T2iZuYcKNN8ZfcaIwlWFpY4jv6roTgr8MN4mt0HU2acgr4pm742wiuCTc0Elc91FJqwvqp4uoXodwDZQMwhUS2XbnIBJMmJYNV779JUPlx4ucOWcukkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJaE4EbvCH7sR7pQUud0A0RsFByP8fzj0yQjOiw02HY=;
 b=exdRZdGCNiCmu7s1epuW++1mMEa3fRAr2QIKtjgSRKuhEhHX4zpgVvPJcdvDxydtiRs0NJR+gHLBBd+D0UTcFTQ8/LNOGG4+TCcVzzcg8tQPOHtOl1JdOe6kkFIBmo6T+Aw1NGFc4eq0fW7p5DhgDi+H2YEJO0Dtkvi0B2vUA8voZnZE7wVKt+iA8tjC7DwitM90J8t2aytt02lEu0XMG0o69HQnq4vSWdT7RUzzZOeAALqOKUQV3jg6K7rfGQY3p5S3Iba5VjDvFJOc/FTDT88NaB02FDTiEUbQVDmLglbct6ufhhIT7G4Bxb27QKr568MQzmCadNrZSRBZg01QCw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 03/10] imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
Date: Mon,  9 Jun 2025 15:41:22 +0000
Message-ID:
 <PN3PR01MB959726E51CACC5CCD4B57A4BB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d39c56-6e45-4f2f-5c12-08dda76c3f91
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6N31VFguH5y+Bs2ebAF/rALdfoFfvHedUg2HRlOqKVVhcT1yI/VdPVmsMvct?=
 =?us-ascii?Q?+FXk61eXFBM43lxEEKDe95YEfPJZNcNZx//Eoncggx90t+JoXB9Nh2Ii4NiG?=
 =?us-ascii?Q?gek+FvtViXLutKsIouKELkmeo6DyyzG07aDCt/BeIrsvJ7KzQwiqiLkim4tO?=
 =?us-ascii?Q?zUAdzZ08SkHMYXz21uJX3pKzP/KCTAWB/pxyl3emcfs81QLQn0ebiUZFVbZz?=
 =?us-ascii?Q?C5qAW40EV6Csqd/8ubxfzTQ1SVfI53OmWYuuSoSWNY0hp8zixk+sYsJD4cNg?=
 =?us-ascii?Q?kp4Jxc/AprTSSsHhpdWjauGc7X4YFZgMXaZIqTUrcj3EtDNTx2DO+Q/rK1ky?=
 =?us-ascii?Q?BQlaBekap4m5md0iAT88tpOPZK7H84NfGgO9QBv6o6FDh77QWzXWu4S7Gj9u?=
 =?us-ascii?Q?/gkmVAFMGLFeXXjwTjm/nh58Qe7A0Ger0OWCyD0NXrr8dmjVy8RZ1E/hd1JW?=
 =?us-ascii?Q?AGSE/tzd5ZeQJH+av2UwXDdCMaU+k31HVppszSSsS3TUDanO3P080N4uxTDB?=
 =?us-ascii?Q?UkgMAud0YdKhcG0e7Lns0dGLjfwQGPTkZ9rZ7S6jAxGUPt9Eraq2Wpj+yaDj?=
 =?us-ascii?Q?OGi6C1FQ5TpFptxlchLEJL5WEPE6m55yWRIysCcIFY26C7mtcw3ZL8VZdmKp?=
 =?us-ascii?Q?U4rPrgOTBrrB5RzyIuEUgmaPjyzav2ohdP2HlqbC6n5vB+aXM+aTOmgo7VY/?=
 =?us-ascii?Q?NZq8EmMdWPIntHM0zduqUJFk8srJ1ZOYIFfphH+WX9b1IiOcKAa59n1Uc85r?=
 =?us-ascii?Q?NF4yGdTjyLwp2QKAVcdPIpVWxs3b0/EtRR+vEY4PumWm6dHEZlAORqmD9YQZ?=
 =?us-ascii?Q?RKPv/Nzf2XRsbk/4L2BfYigZt33sGoGQGvsIV5UE0wIFHmxzoPS0vbZULZJi?=
 =?us-ascii?Q?JCk++jXos/70DacS+DQltyL5LrDPTjv6L1NKaCGWv3Pk83qcZRBZ5zpcwwbV?=
 =?us-ascii?Q?EE+KOolZRhJ+KvqbpoaPVQ3miYGmWoD9VWZCtrqOgLgUh0KUSFkjy8B86TbD?=
 =?us-ascii?Q?/ist6yVerg67Y23YzUbkZXIfdN3aFuAH3xcvXWx8y7/x6iafm3HtJW2Is8vS?=
 =?us-ascii?Q?W6GPgJfb8wHdPURx5QSenzu0itA7zTSygaE1K9tACdK8/eTQi3EcVFkphLV7?=
 =?us-ascii?Q?CH/4MJ4loY5L2LMTVxCQK/D4WrSZPJrkuRGleUCLttL2HkwW9W5YimI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3mWpdIhzCS7Co636pEYRS4LuLM6SXu7GeZaziVVzPsEW12b+EeJVzn8+Vxi?=
 =?us-ascii?Q?vLoq9MIbnNNyhzIVwekecryMYQ0kHG2XzDzRgUZuCf/W7VHYlQNudAD8oJjS?=
 =?us-ascii?Q?isGn/+izEroQAJF3+bgHfcOF/DFQlvu/7XRdzJC+Vv4ABEXB9E/BYZhyS29W?=
 =?us-ascii?Q?3mzYW35sJ7DBxdlBrruruQTT+M8mJ7ySvxcg5lKCsMTW9hEZiZ5jCpa7sLiL?=
 =?us-ascii?Q?4VoyGy6qNyztjYQZJvZmX/c8dsvrS3YPObymgB8C9UelbGIWtceQR2ADqLfO?=
 =?us-ascii?Q?TxSY7OhNyyPo2quNlb0i6Y+3M0EaDRhwR/kL/2KqrdcFyAORwWitKnIcqqPy?=
 =?us-ascii?Q?cCse8qe+8IjU60rl2qEHD1lEHUNWAAFS6YaHdtA05SyAmXyR6euk54MT9do0?=
 =?us-ascii?Q?7iREuPe9z8DkG//+Z17eBtFXJMo75hgM9t8qDahRr7fgBSdBrYgaz/fc8Tx3?=
 =?us-ascii?Q?bJh1pstAhKqG9xveYh7d7UD3GjuaDTvNdbC3+8tJ4zVcpRDTLprktaP55VNe?=
 =?us-ascii?Q?TUqLYzlmkaG8AK0eNGSCf6KiYwS/SoqvI9qIu7ncpPc4alWl8ShFt9O6P7YX?=
 =?us-ascii?Q?K7z/ewZaPxUV0Fbz3FpRjoZks/UEjl7twQ0NVWWYqajiOy2T4qDZiRWhHFVe?=
 =?us-ascii?Q?MOBNQnPupa09AUWAbrguxrURdGvXy/SUy+tbspef/oOll8H0wfRP6vvQzYhC?=
 =?us-ascii?Q?cToitTCQHA1jCyih5ku8OL9jl2u7ThValC1I++ZnMpWqryiljLjz5EXUt2zO?=
 =?us-ascii?Q?Z1LZoTj0zbw2pnRsOCW2l/TL6Bg4OM0CNQ/qeSOz/4SPflJZqO7axx+/+k8J?=
 =?us-ascii?Q?G392WHuSax9XGHjmBpAQvkcFq42lBpjUhE52//VBuljaI+0eetBIcU5lP6II?=
 =?us-ascii?Q?2tkOHlQZ62rhnimol07x5RaxgakyKGpdBbpb6mc+sPb75LpNALM/eh0lSa8R?=
 =?us-ascii?Q?7d0B3a2IQLe7wPaOKHeJMqK1K+6iND4beMbGXwKbYmMd6sOvlAV/BYxmCVMy?=
 =?us-ascii?Q?YrNGynCctjbDqK4wq+2pg/NpWEuESdcnhz3Da/uondJaYaPPfofCBG9uSDOr?=
 =?us-ascii?Q?ohAMay5dKza6jXHNyrCV+SbxVOyYkjNdu4O6hwK2rlV0az8/DRCQXd2D9c0U?=
 =?us-ascii?Q?s+oLLWMcbmCb7+mdB3srJjMH49vffmEeCFJyr+vnZjIjoO0q7VPkqDxzGZuw?=
 =?us-ascii?Q?vPYjUd4gfxyW3f8pvjcRfxweCNLtjuqj+n6hwttGszl72XfDv1FY3jlIJX4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d39c56-6e45-4f2f-5c12-08dda76c3f91
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:32.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

Unlike PLAIN, XOAUTH2 and OAUTHBEARER, CRAM-MD5 authentication is not
supported by libcurl and requires OpenSSL. If the user tries to use
CRAM-MD5 authentication without OpenSSL, the previous behaviour was to
attempt to authenticate and fail with a die(error). Handle this in a
better way by first checking if OpenSSL is available and then attempting
to authenticate. If OpenSSL is not available, print an error message and
exit gracefully.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 66 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index cee8f5690d..39013330a7 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -885,18 +885,6 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
-#else
-
-static char *cram(const char *challenge_64 UNUSED,
-		  const char *user UNUSED,
-		  const char *pass UNUSED)
-{
-	die("If you want to use CRAM-MD5 authenticate method, "
-	    "you have to build git-imap-send with OpenSSL library.");
-}
-
-#endif
-
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -915,6 +903,12 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	return 0;
 }
 
+#else
+
+#define auth_cram_md5 NULL
+
+#endif
+
 static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -934,6 +928,38 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		srvc->pass = xstrdup(cred->password);
 }
 
+static int try_auth_method(struct imap_server_conf *srvc,
+			   struct imap_store *ctx,
+			   struct imap *imap,
+			   const char *auth_method,
+			   enum CAPABILITY cap,
+			   int (*fn)(struct imap_store *, const char *))
+{
+	struct imap_cmd_cb cb = {0};
+
+	if (!CAP(cap)) {
+		fprintf(stderr, "You specified "
+			"%s as authentication method, "
+			"but %s doesn't support it.\n",
+			auth_method, srvc->host);
+		return -1;
+	}
+	cb.cont = fn;
+
+	if (NOT_CONSTANT(!cb.cont)) {
+		fprintf(stderr, "If you want to use %s authentication mechanism, "
+			"you have to build git-imap-send with OpenSSL library.",
+			auth_method);
+		return -1;
+	}
+	if (imap_exec(ctx, &cb, "AUTHENTICATE %s", auth_method) != RESP_OK) {
+		fprintf(stderr, "IMAP error: AUTHENTICATE %s failed\n",
+			auth_method);
+		return -1;
+	}
+	return 0;
+}
+
 static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)
 {
 	struct credential cred = CREDENTIAL_INIT;
@@ -1089,23 +1115,9 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		server_fill_credential(srvc, &cred);
 
 		if (srvc->auth_method) {
-			struct imap_cmd_cb cb;
-
 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
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
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
-- 
2.49.0.824.geaff4db692

