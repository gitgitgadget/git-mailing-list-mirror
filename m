Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32727FB3A
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453716; cv=fail; b=ekB8kqkbBauHkINnDR47760gV4m78IQJDkkP3ob19xfiurbTLJkOVMufu5mCcIbHWac41WfAvRcPKxwx4Go5d996Ou2I9gm62gMRaCk4x62tVdVCAFYvONCKpO+TkhS+ZLDEBrtmfmfn/72/9p6TnRMCsK2vW3E91f8QR8Pg21M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453716; c=relaxed/simple;
	bh=No6LeYpLboo6wtW0wAgRieaP3ILB462HyOUmROasy6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBxIdJArUWJqSx4062RFbBKr4BJEUz52cFkeCNfViT46Et0aL9jujPFkZ6Yex57OwtmCExSodmTq5yBRRBasrY/Um2VoccVgzTefMgRqtp7yMoUw6aRGp971El6i+F/v0Bb8ScO1kDhQ7MbMhBxPNHWaa68cWNgLXjUsCwIZAUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bbK1cN96; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bbK1cN96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMbp9XA+32mj/SDX6VBuy9npOQgNBRosL6I2YWpzGRhxoqPm61TtMCbgpYtJ4u6KCWaztVN0ThXBViqydSHqIk8GSppHfr1Bkm9yM4KyxTt73Ds3pHFjfFP+4UIznansCj1fe35LUt1hmHjeAZK+nwPPr/CYGQWcbiaOyvI0EoMKjA0cNY2YEYKglXF068zR8HqBeYymqbQ4vpzPgpPsmhQu71GPYwyWRMKfXj8iJemmUZrLCXwZHXGlVZxnGgakLidxqzKtrLpRb28ZQIfu67t7Wt/PgaWsGqK6K/HC21YkjuE0M2r5woZvVOsAoH9MSpGAW/R81z6DyzJbFF0B3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj3Ol6uCdbBHyl8hgs3H/0ZKuPbYMJVKnYa+8F/YuQ8=;
 b=fxgfIt2LRkdEWibfs0VwT6i+RlJZ8G3FUlabzyUvzRwQalRMIXhxDIxTlImxtH5ZuMSREdMYpKS1o012bvsf71Abw52j9svrKabPMwA9RZbeT7uwmw5CVrE6fiAsN1VpSavCuGq+g3IOu2tVzRJnl3jwHAH8PkHoUXMVHlnFATVAY/Arrfi7WP9ecFbYl1QIqB5W00h695qXNmEpu7uUhY4Ljxf6V5zWeFg//v1uu+YRDcg8rT0r+rabfX6iQyZ2I4FXFf7+2ByYAsarCtouXGZp8ZL3hqC1/5e5LD9PmYbSAppVL0moK6P39CEMELqN1sCLCrsngf4CX57b23agpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj3Ol6uCdbBHyl8hgs3H/0ZKuPbYMJVKnYa+8F/YuQ8=;
 b=bbK1cN96M/XTeMZvDZmrL+LENSrglOv5j55T3e5i4UVa2e9t9OTrjI9RwWH6tj53xIu44CKMFCQ+RVleWqctWlzEFNhZ0q5E39lL3JIqacUfMCiZdDF/bCJww9UO9V1UUSUt72AdmQUIQb3sJKAMq/+EynF7SVf/q7NIwBLkIFvRYcVmsI/kztRpKibf/RFwFhFRXFTdv0gaTDcWiR7sX2QVvyf3I+MiFS6jOB6Sxb5zAu9Dwt1gotmw2Czzi8cHCQ1UN8ar1aE8X2N3CHrPY2xwRPmdeh+2jp5+tLnYTS9Vv0k+jE9FztVl2NCAnumMS+YDlP2yRJb9pqQJ3z5GKA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 03/10] imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
Date: Mon,  9 Jun 2025 07:20:34 +0000
Message-ID:
 <PN3PR01MB9597E68428E7483061E39A63B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250609072041.12114-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: b14d6494-ff3f-4dd9-27bb-08dda7264778
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|15080799009|41001999006|7092599006|8060799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4l0KUgDH1/AOAYcBNgAgEzRaKOJWnqKt0vjn9QpOLYMAiAkqyKZSEy8FVeAI?=
 =?us-ascii?Q?QFnW1KuNMU4SXlTSdBWjAf1MrHUYIUfgEGdquCVh1kKnNxQ7hnt2A5OvbyuJ?=
 =?us-ascii?Q?4V8vWiss7MripPBhs7JjAPJ4e5uN6sXNiw2VFG01I79GLdLIaTPFja+mTxND?=
 =?us-ascii?Q?BThCzLOFetHtWTPh8WgiRvkDe1bUt00s2zW0pT5ZR/7y2FRBK2OVxSAva7l5?=
 =?us-ascii?Q?3VsUOLbNhl0LDkd2IZuHbabZu2m8C8wfYgjL+AqJCy//ynZHEFsZARzotAfZ?=
 =?us-ascii?Q?jxICp3MJDROaCdBrItzIgDEUsiJUYUg5bOzn4h0agqfhR/YbkvikyoELhFd7?=
 =?us-ascii?Q?H5Wz/6ZD0DX3M64UlK1pfU87H42EgwpOxYZj/1YZB5o5fJdnL42RXGFQGxHB?=
 =?us-ascii?Q?3fKP407ikNOGnfX2FHskPrN3+qcFlsxeTsFbF1WkLpmt83G7Arf76hNYMZJt?=
 =?us-ascii?Q?cKlhyVqqwfEZhJtROyr2VUX1wwGRk4HB0FFWiIZVjbqqdsE87LEbZ62Gyx2y?=
 =?us-ascii?Q?9MIJTH7krJeiax+IWOGprWV0O8NlTevIFbm5RfWMRga2J/KlV4z8vQ7XBsGC?=
 =?us-ascii?Q?Nl+iDSa2x0SHKhAmN63jXowwJzqgKry39Hzlq5wEbTdluoQW1FOcWg2OEme1?=
 =?us-ascii?Q?5ONEZiyMour8Y2SAJtq2alGxJD3uQQ+kT+WtdoRCE3zzkqlbWpU/GYeJVZ2a?=
 =?us-ascii?Q?EsC4n1bF4jyJ9n8aWkoZcaNT5X0UXFtuDQrX7R1J2uCly8qHsiuRbZHZPj/I?=
 =?us-ascii?Q?uXTASJBW8ZbJLUEwNz7h8+Ds/J5CwYdjraKZBgSycIIDtQ+sCg77HFvSdQBM?=
 =?us-ascii?Q?LOgaDlONDyQsPtGq3EAZW5fUxtZMVZ6IbURl9ZD2z5pT1Q3LkVAG2qPBb7/e?=
 =?us-ascii?Q?BXdQHLwvys76VfbcDMP8HxgMkDMB70coQ8Uxr5SvAGNGYL1lxwPdd38+lnsQ?=
 =?us-ascii?Q?5cgECtUy+lw3P0i5DA/a9YmWgQpNG1fksIqtwxEXzB9kYvsHZyKJ6MWfVZkt?=
 =?us-ascii?Q?kf8yAl/HzNH3znIBKubsiIYkDPTcxaDsSIm7k/G0Qt4dsWc2Vn6rvQdt22IF?=
 =?us-ascii?Q?fiCDKkMaMxMxkaKYLhifiV8GLU75SrfkEaapOE16GW3BgwDzATjo17cdqfZ7?=
 =?us-ascii?Q?SrkH6dPAp5m++nvC37N0KIoPqxbmqCHQUw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4f65vpUSUbiZ1HrshdD72+zMLN0c22xt9xdqVQLm/sj8FxvYFnrKmWljdK0r?=
 =?us-ascii?Q?+vN2JqK0gj7Fi9QqKfUjw+9aybiZgjuVyXPFUYKyU6Wg0p7P6jgUsp73dkYu?=
 =?us-ascii?Q?2+aEDRqLiDLBZhUHBmtMR+rYKdNC/u8hlNaWPbC9YL9ie7hLOf0SaxkBZcuF?=
 =?us-ascii?Q?fQaE9lBX8FHGwMzxNUk3kD8Rbw6Nq+9e9WPeOfg8iPvOXt8MEEDR4e2lVW0x?=
 =?us-ascii?Q?dmL3v2kgzT8YTZ/K+eO90Ad7982gypv8CgcuE3NFd1brVEBKn8u1hZEs3GnJ?=
 =?us-ascii?Q?uiyfGuoNBCwlsNQKRVKWjewYwvf+T+0wrRQY7cMLplZDDd3PJNj+Hx5fA5uU?=
 =?us-ascii?Q?l9Om1INvrDlAE/RDAI0GvlU4OYje5V2fvLZyAPfWlUjC9yRVH9zSQ8bSa/dU?=
 =?us-ascii?Q?yQSHoX6NsTi5w/6IogcGaoQV3PXXb/yYzvAeG5R2Cs1h1SWmUllAUG7YXLeX?=
 =?us-ascii?Q?3m2oCCzID4CnLVcPpEumDY79Gfde8x1l0n0xeGPB7rqCPWqN9caOmqQ1oMAb?=
 =?us-ascii?Q?a3txnZa9OdQ/FcbNJBO2hvz+Ci4CPZkZkD8IC2Lp8+d+/815n3fy4wEHhAbL?=
 =?us-ascii?Q?TTrsUDB6Iq/8ZChHRSDUUgEdFZ0zXffhC1RuBNiLXMz+F/rDoaB8mUVGUW6Q?=
 =?us-ascii?Q?l8Z5hNjC/jAZtp3rwj+cisT2OlvnrYRXqV9NOO81M/diwtHXN3C4Ig7G0Zcy?=
 =?us-ascii?Q?mOqQG5hC2JCA5UXfB7hW7n/UB5qBwv//f6GoNxfcsI+vRHZHyYsUQ9tEiZHA?=
 =?us-ascii?Q?OaB/0mUAln6BsS0whNQSjaxuyi2YfObrOm1cETkW3mm8kY2q/DsLiAgUpygQ?=
 =?us-ascii?Q?nakSuqKkuu7+Ywg5ZdD8gMaKSRcwiBFj/eOuOfrCST3mxD+00gSodfUfbsrF?=
 =?us-ascii?Q?cgKToqxtaYu4ObTTjTvcAUygvx4rcaWDmDWtCNdtTKgDawKJun27144ktIh3?=
 =?us-ascii?Q?EODomxIspRfxmjX51uXIAjIPFKCytFdSMqEmqDHMY6GEpJzi+p57+e2Grckv?=
 =?us-ascii?Q?C1IyWHYoOUgvSivzM9KCvHJXjZ+b8G57vmtLYBZTpMrVTU6LbDG8PIeKA824?=
 =?us-ascii?Q?aaz/IEaiNy2jehAXJBto0RgFxWH6y3WvO+tXMW0xOL0voTBjcv5dlvWqhqHs?=
 =?us-ascii?Q?3ufMbfQwTR8ei1j324z6lDG5IfHpp6njGptrs8oXMQCJlkxvrHaFNL6wlLjN?=
 =?us-ascii?Q?4ZVB+15wUc18uU/Et+w2qEBkeduSTN4jL+QnffvPmwLLmshV3EuKoBUN5yQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b14d6494-ff3f-4dd9-27bb-08dda7264778
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:41.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

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

