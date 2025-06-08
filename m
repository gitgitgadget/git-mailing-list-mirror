Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16721323C
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380241; cv=fail; b=tMFdGFKpoHyH5XsyKgYm76REJSJIIaYVo+HngDLdBWc+LGH2uX7ND4x5Z4d+eVpRmOMXl8GzoBMvNk+lhLs4DCpSgy9CGEPFMxzTnbnRi7dG1cF0wHHK2TTJcf7UXvTMFM/tWNRt2+FYYkOcD+mU2nS5ZpHEjIWFYjULn7ykIAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380241; c=relaxed/simple;
	bh=No6LeYpLboo6wtW0wAgRieaP3ILB462HyOUmROasy6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDGk3p1YTaSaLXcNufDY9Ytuso/aQSMbe+MKr2XNnsObuMcNgroGzS8QKHUKaJ0ocUyQzKKGK9laIRNeZX2hjHDpzrZYZ8OvcZJlaBnt2yDFis4xrlsJ2r9TPlSd8Ou19V2kD4fRRKX6onw1Rz/paQkjNUi1ViO+Z+Cj9tNN1oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QFUFp8jw; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QFUFp8jw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBPLGBihXShuRIhjOI+Bw+xFccev2dxdPZ7JS84tUz7rXpP/QdQ5DB0hozulqxmvhZda0NIYCJSvE1BVul9axlAMtlwMXyYLOyvGzp0+qvCl7lUqfdxzbLcVTNrwv5Y63ZUcviW/IfGgODQbEnHUkbYmWam/17aGCIVLuyLix/nG8DKtebuNJ0V+0Nigl3608k2+7brZvZmtsJpQox6xeIC7sb6ixjU1cUJSNnVIxnqkN1I5lveW7i9ytVGZywLU8llmxi6nlU2SFB7M4KfheZIqrjAxMvko65Q3eWJceWWOKi2/FHT73j0RKzHqBXGCopExCv0J6yGDzJOHpoTtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj3Ol6uCdbBHyl8hgs3H/0ZKuPbYMJVKnYa+8F/YuQ8=;
 b=jDT1dzQFOnkWgWKNsdcnETFedySD+QD36QI710s5NAWV8zcGzCrC5vDRs1lAMWEG0rdStNyw1QbcCCY4q/1stjoyqRsMYlxUdaSchMKIWAqcuVenKykIbRXQRrQ5JwxbwCyDU5MwZLk+p4W98DrHH1ZVfKGADt7cNAvw28WggNM0lC2/qpwtFgoI4lpib8MAtA6FWEkBouQvHkPabNne4KFlZ2TSOB2xKQo74H6c/5/7ED5ciYHcSXRZzCdpaex8+90UDhVGtICNcAlb1iNIcoNgPo8EJ/Aj188yvzoSXWGvUjKdzkxBDyC3I4eeLQfvW1mW8Olswzf2MnxF+iwMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj3Ol6uCdbBHyl8hgs3H/0ZKuPbYMJVKnYa+8F/YuQ8=;
 b=QFUFp8jwLg1vg8I0ZF15ILkryJ6Di55+P6oc7yr/PFeU4LHIidzYh6OeFUOjxOegGVoK3Vm2a2XjUSvvetCHka24X0YVEYD9ju/dT3ULX52DAcYTuzvL/+GtuOUgKb5wjIqhdOiVWIscMx+AIvjLOPHfnIgphcSEZ8M2fjW+cq22OJD25uozgH9JmUAAbF8FvCCTFGxudw9Cxn5Z7LKwJPUVhUGC5Jae/EHjizn/Wywa9PYzxv3hAvziy3eJlOAFjpVrTge+7jGNgIkUBFz4gt+hhy+h3HHLLljbO503F+Jf25RK3K9RkSJBU800GTUe8RnwQD+dTZRte/Ca/Brz2w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8974.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 10:57:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 03/10] imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
Date: Sun,  8 Jun 2025 10:55:12 +0000
Message-ID:
 <PN3PR01MB9597580DCFE961DADD493C7CB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 353b2d15-7bee-486d-4955-08dda67b36cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|41001999006|7092599006|8060799009|5072599009|461199028|15080799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3rK8y1N4VMCdpUtQIM2i+MrbrnEiV1Rknp+expiUYi9w7L7nq4edlgryWlSo?=
 =?us-ascii?Q?b7yIKC94hcQgvbM45FSnL1oiP0QA/Qx1zJ5e5ReiYqUZ32pkFms080+73GhS?=
 =?us-ascii?Q?4ioXerKuJZZEJh82fcaYFyp6HSp6T9pgDbnTHz8la1Ae5+Mz/kBZdMbzp3d1?=
 =?us-ascii?Q?CxFu1z/26d/4Q1JlZ311Xq/0aQvms7N6R9NEHN5dnBXp/93oToDIl6nJ2mH4?=
 =?us-ascii?Q?0prOK3H/SbPM9h7d//KckdcCBBTCJjMLnZz0dYnNY3kbD6lJwHwbyyVW/x8m?=
 =?us-ascii?Q?wtIJ+vgGRnG3B6mh+Uk3ANfLcJgQ84bdpHJ69LzdtGSdf6CboNtUf5WGcZcZ?=
 =?us-ascii?Q?v/EIZXSinlzKQLBzlsYZypVbLQKB4KUYCb6XK3sP1R75zL7f65hqRZmX3F5C?=
 =?us-ascii?Q?jkz3d+LKVeRDUA/O7iTCAsEPPUH0zYhHyJdp+xJnFA9Qv1rkaNEEhCazMx0s?=
 =?us-ascii?Q?PycJY1FA/d7o+Wg4M6hXeNV/Gf7t+mxFs6NagzoEwX5NetQOt9LNiJ2GT34k?=
 =?us-ascii?Q?FKlHm01/a1kEHFyMAtTP/Je0yrXg+W0sRUaFVXKsJR3pIgHdShLHlnNJp4UR?=
 =?us-ascii?Q?UsbOtyrYIK9IrQ6vlR36WySDinFBWeLUy8remZ0t4wobElmbBzrS4iGtlBc7?=
 =?us-ascii?Q?cSaDkT3xVBqhzGTTxJ+sb5ARQIesXsujjdH+2F8zpu9rdRtdmJMwsMpeCsEZ?=
 =?us-ascii?Q?1f4gh7on45U6w2dQoQ3d1OK/Q4QKgPBVkUbYzSm7l1HXPFHDW9mdDsd6Vw/M?=
 =?us-ascii?Q?D1uIDH7HEAU+nTg59pgXVHwZPcaieVsCg6xezcd/cuoDB4zzvBPoU4FAw/Pc?=
 =?us-ascii?Q?+LOCrS+A/j/jnsKH2YGF7KjtqT363iFYcGg9QtWvPm8UQaLxG3NCEtlF7M9H?=
 =?us-ascii?Q?4viwKOxMXp6Jr/42kbUvX7n7fZh/8jfWLZKNxwCpogJR651oGPAdDIjLthV/?=
 =?us-ascii?Q?Fj9fYk4I1mCC1GtMUi0Ynib++gmeZpenlw2CuQLue1ANJH4v1ME2i0Y1hojt?=
 =?us-ascii?Q?h7WbJe4FXhrmTLMWylRooCHbI3FWlcvDfuhFoAx1/Min8sfpQ1ZMA1QZr3/K?=
 =?us-ascii?Q?08jsD/pPXGMewjthmCilfIm7aKMffrsQAPFe/UUi5hUycV6BRU3bHA8CCCRA?=
 =?us-ascii?Q?o9hQL0p/njgGGJbKMTUH8hO7Ji7zSnqtdg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wzw8dqFps5mmp+NZK7c8sHFB3f0tqHyXnT3eMiXcsiCAua7puYATIc3dIkrt?=
 =?us-ascii?Q?SUykdOsBQLYVloMD2eStrYkjZkj336ZLHpVi0HEZAlzyXcERaUSb3xFrbgYu?=
 =?us-ascii?Q?tBpyjkAQFQSBde7H8d+bSmot4GyP31bo6T4S6p2e1XgIypxJcHN0huX0rq9p?=
 =?us-ascii?Q?RtWklWfxbfL/VEsFsyMTkebPycA0y1InQD8ka6VMBXWhUiCfzwDLVs6G9SKv?=
 =?us-ascii?Q?D9ezH+KCRhydZRV/aeXl1dML9CuqP+a3SxnTuq05305O212rWWV+ouANywpq?=
 =?us-ascii?Q?Oez88Vpk484KxpBT3sfAB0t4ctJYnXKknHTQ0/KbVe62s0PZc7LtKTpTvcca?=
 =?us-ascii?Q?HCfc0qtmVCsaH8tOTozaMjM+0CH6ngnct1Q0ZpXXclyku6xrt9I+6WpAWRWF?=
 =?us-ascii?Q?YsDyJcoF0aQt5QlkKO79FT78cp5mt/fq86WBHLo3fOE84Puxj93W3faCSWJg?=
 =?us-ascii?Q?akpVhVVtH38/FdWQWbg8w5AzF77pAdruzeCwVsh/LPCmYR6zQZ57B66WC/uu?=
 =?us-ascii?Q?c9Zsyi3LUvqDVTG4qO+mFImfW64iwwO1rNYOiPb9Ad5XrtWvba7+A5p6pdkI?=
 =?us-ascii?Q?i811pnVLJJN9Ap96KSpdIWKHfXAi68rvqcGNGEayQjYkA4+QJZ4tLAuNL37K?=
 =?us-ascii?Q?dH0EVzJbuc9pO8+1SJC3C1P+FnwjEjqDwbqifasuXQNX+hCrUPdBw/FqQtfi?=
 =?us-ascii?Q?O+jpSzHwgY1DfhqZljESeWPGhbq+DkMi0r5DYsaG+hg9px1ewf2n1WbK1VKH?=
 =?us-ascii?Q?xmdRxP95W5m2Qt/DC/SYyR/cLMCaV5adWHcCAYtrA8jOYsQhQCe1JGEqZKvf?=
 =?us-ascii?Q?YdcmT6VyF+Ii6g4kCMlfS3QroqQ5Tcjeh6guUftCG5wXI619JcEuEhiJh7UP?=
 =?us-ascii?Q?8rK4Z6uO+LqanlBPKU36jafefmQYFLvZjGXgr1XX1h/SdBb/qEEVRrse2LBg?=
 =?us-ascii?Q?94z6HCgg5XxOTsfRbb4XI1k57lIdjq4/gFVRqRaj7h4M28fykbqynrHBFzDw?=
 =?us-ascii?Q?ne9Ao5pFozvDR0aqn71Ij5zOqjHjAYsuChPtQUhJmcAr2lLMe+OP3pynaj0j?=
 =?us-ascii?Q?zAhyBzzElujxx/OOOL/QKPbgeCxpvTIEXOce1tjjPMhOnSxPlUdq8/qxG05L?=
 =?us-ascii?Q?s9roX+sslDtQ9SpsPhOw7/IbxDQjJ9ZmZxFZAIyl7fL7Bnmg0hSQtLABsX2l?=
 =?us-ascii?Q?f7DI3EcrhGjNZCn0xKpWKXw6d6vC3Syh5wOFs/nxhQRzORILlge5X6yj7xw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 353b2d15-7bee-486d-4955-08dda67b36cc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:08.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8974

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
index 1a582c8443..f55399cd9e 100644
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
2.49.0

