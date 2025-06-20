Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505D221FAD
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401661; cv=fail; b=bYvP6rvmfY2IKwRIeYaG1Xo7prcGSAv5ivhLVbHd+dwIg3zR+2e/9cqvvpSi4HVwJhesFlCSlDqHhrb9hjSmOFtLOZ9voTVftpdOR0gC9yCYD0RAhyf7l5LrV3ZBdUFsEjSnvBmwK8fVvJ22vog3MMzkEzNpJrODfapUSJMFCXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401661; c=relaxed/simple;
	bh=huaTkd3LDiIOQsWHwFt8ZYOLmAUZQ8BauqezCRCaxB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTrch3rBxAYTsWFlv2K6TG85R/VPOpBOgkFLyselLCk9FJ6figka0Ppjunt6fpKb5dOM6qwH4dThAKqBSBwp9UTSBHn/WBZM4RG1krG84laTk+/xaunW2Q1T814pyJzZJqV6VboJigFJHEUKJhQq2X1gtveBS2wTdq2T4TdIgJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=E/Fmu2vg; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="E/Fmu2vg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laZyucygOfTbDb/m87xflXFHM86Z6lYZJ9BvLvGZ9rxeptQjnnZTPgR+g7wiHNFur9vpcOPQlTqqJd/KoJJVrAP+Tv7B58bHpFHQGETKN1S9++kQSne2vxUAmPA9zqDL32IAZhaXAIlHRFfJ+VjQh4Gjg7F7XI8m0qAWkZjo3kVNeP1NClE3E9eeyY/3B4tBJrCr5dcJzJ1P2Mbqy+qtRKJHem65tQqcBi0bJBjZmbOePFVk73JZxLwsDaZX9lOeI+Emgf0XEbJyP48BANjN87CbrwQwmIfDEsMy5aSVvpoE+oINDprYrjZNxlsYKs+8ej/xo13tF0Mcd9/GEZw4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQbxOr6Y0KAMs8XoHVXddEwkgjsSf9V4W7Qdfr4JNJo=;
 b=cwc+a5I9+MHtkdgcuYn/L2p1dKZPloICYGf5u5jib2906GS8FABng4e/huSWgTO6STxhZXYyKzFK8l0YVM+egNxhDqeVz3ORRVFQLVZmlEWnPeHNQHnUbLfLUSeIzz7LKw6bGoeSpfMGef3A+rNN6F6H9uMIGUEBBJEjtHAFHoSqPOl/oLTt10YO9iL6CFZIQWoygJfatuuaMt98gkodGwLO58/k1rHvW+psXtTgQ4lm5Oo6EaX5uAziTYd/TsxoapPBwlpl4HKdnT+pTCsdGMrbLLIdOUQi/nnBdSp8OmYNlMq9QwABXhdRv38lPcp67WSCmY55EqOZ5xmiO9L7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQbxOr6Y0KAMs8XoHVXddEwkgjsSf9V4W7Qdfr4JNJo=;
 b=E/Fmu2vgxklv8EJLsZWk9DqugnYwOj9ul6U9g1TPJkUQya3xVtMyma0AWRNFqtNt8BF8GUKmSZw6PLgRBblEM7XFKcbfJGMSkF67xLG4OvGuuTzSQaF1qYsyso7hFrsSB1rYaFUUOU3sytRDDzcjg2rJSJ3OYfscXpx22jMbKm9RERB5UuxEan0Nl0zJNgIjRAk8TB63pg21opBvcHYfhJF67Gmc0buAxF1Al/urdLiHizpWnppnm9hJE+p42FZk9spOI4sG3DRhdDVQ9RbTfTUXwVTfgZuu+KTX/ZCKrOnyHuMQuv4ZXGwc2k/GugWZmgaI4X0rWK/pROlK3bnnIA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6749.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 03/10] imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
Date: Fri, 20 Jun 2025 12:10:26 +0530
Message-ID:
 <PN3PR01MB9597CE7842A672B8FB1393F9B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 9479ba82-cc28-4ebe-60bf-08ddafc56525
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|5072599009|15080799009|8060799009|461199028|41001999006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lwpoCdBoWL5MnozEKgdxmYEfqif7FKqaHMSUcPHat/mz7KwMebiHUEpKEX5i?=
 =?us-ascii?Q?41j7Pr3cC/51VgaKq41xRkVtJ/jetOMqSMbyuF06n0VxsorwkZf/IRw6bSh5?=
 =?us-ascii?Q?GCkjEVyN9uJarAKiWJl95/eXgCoa+KbpD28ES8L6o9yVipLLzVxeGO3vlPNF?=
 =?us-ascii?Q?KFsSSGY7/2bCB/1SkQNmk9RtKrM77MvzIDyqMdPqlMEo7O2KkSnjHfgerEoO?=
 =?us-ascii?Q?Kk56bjEl7Az6/SNHXTQTCLRVIMNZZA3B5/C+MFuP13s9uZYD7gXT+Axp6E1I?=
 =?us-ascii?Q?7qQL2JgjSnTWY0jZuotNG6Tt2hiPxKEdaYyxPlZ/WDqSbhSKxhXWAvfjBEgz?=
 =?us-ascii?Q?85js3SlxrbDp/pmUO2bRIDZrLeUq7wAo2OkaGp79UP5G66X+nB7dVOyt4zx0?=
 =?us-ascii?Q?aLoHNRUizkgKbcu5YP95348EBwVdKXAuu9SwLslln5cJpSCVxJJKUZ4JCU8c?=
 =?us-ascii?Q?ThgygFUqNWqGn7miJlIr6HY6PWkekf/GzRBMiVkRIT1uON7cWmaAj+nWiKWJ?=
 =?us-ascii?Q?LGtNVgeG6oeLvq6cvUlgAqkS7C/VgcLKjFThWnEE9Mf0BOKZrEs/JDXZTQn4?=
 =?us-ascii?Q?d6cT8YgMlYI50HnOR2gedggpOHb+ThQm1Zop5X1JnDGVTUAwszO9+Z3y5tJh?=
 =?us-ascii?Q?jvmTAldDp+1dHtMMZvLDfPKrtE8f3zeIt1WbED5vl4kgBffELfrenNPYgzwj?=
 =?us-ascii?Q?n3aV2oY2jPkS6tI7KjZarLbTxNCA8FoHExWoSPeqU+Utzm9m5cbXyB6OWY08?=
 =?us-ascii?Q?1ZnrtR6eC0tIhlmn+ZljWWceSXObUTTBjYBDSRdZbEqr3KhN40EmRinugnST?=
 =?us-ascii?Q?L6b3ArbjUG0tq4RFJ1JHgadB7G7kPN22aD5tfN/ZRxOVcRoVgi5FDNNqWBww?=
 =?us-ascii?Q?kFL3m2cRtwtp3/VofXftpfdbFJJXplZT3TGVoRk8qVM9JIyCi8dyxK9voOYv?=
 =?us-ascii?Q?W+7kJQNuVBWXBM1alQYsaaETggapqECiOEOvrOHNmFE7q7/aa5PGRhiTXSoC?=
 =?us-ascii?Q?SqDQeExWS1vaRoPmr9SF/GOu9HZ7TlzRgiYiRVZvrh2aADmQBUGd5VSDrjZy?=
 =?us-ascii?Q?IXipIvGaA5dtxjy0n0Obqi6H9Zx4JMy1DiKxqwyIhi6+sN5sPgJHjxG+YSn6?=
 =?us-ascii?Q?Gk5WclsCyMOSLW77whwjrpAzU8KmYVC7QyHDutDiVwn2pY3Z95cxtpk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z78CNhWDdmxU/Crl36ertwePuADW7gNluGhJ4LO9Yp//XC1IpPECBtAyjpR0?=
 =?us-ascii?Q?Ne5YG/6r2Id+eQDOYCljWe9quGAl+CjLDkhvcg50i3k8NtnciK0LkjStlnEi?=
 =?us-ascii?Q?jupE1IWEr8U39FJJbIW8zf3bmGvIzpC4Ny2mXBd32yp+3SUluf7r3R5xIko8?=
 =?us-ascii?Q?61YCbep28o4xuWYsuUbbhJ8Gb1amb/pB1yXeV7pgSreyTCbNvtIcXSzR9M/r?=
 =?us-ascii?Q?dmRFllNdn2ClQN9eBVAj62QzFA9sWgcS5atAK20uW5AD/4VV6fleroIC4HWo?=
 =?us-ascii?Q?OxlTBY1yyHDjuvXUZXBE9nuf30OwCaZmfl7pW5F0BsJhiTgAQ6pzkkqRko/K?=
 =?us-ascii?Q?dn3a87ubjjMtw3vHNCMtHrbn67YCHrO/3P3oAhA7SKJQKNEZZu3mWtvwr5tW?=
 =?us-ascii?Q?6pFM1l3uVw7L5f+oF8EaYjPypH+z3ClpIaAz0OQgiKKav7SpVmk+tLUCAbfr?=
 =?us-ascii?Q?E1yxmfffcY6KLJob83fQkRM2qhs2NxFQVxzOgYUTj/uk3haPpyLnu232hyJf?=
 =?us-ascii?Q?uAED2Taotyx6wpb8j9FGK78aqcCugnH97DR7jp/0SVUaqOafxVj5COdTEyMM?=
 =?us-ascii?Q?xmEfjItHNgfomMyQAUYNge2UgDs8rf9nTNjOMu7zA860GrDnGIjmSdXRL5HX?=
 =?us-ascii?Q?0kNTNoJCMaM5YVMknbjCXadlE0AymXldi+PXwVertg8O0wbzqxnYNK2YjPK2?=
 =?us-ascii?Q?iFVlG4aK8qd1uVB9f13gF1Xxs8xvpurpaoK3/ekXpV1AYddrpUoKnVyxgJcM?=
 =?us-ascii?Q?8x6sdmxtmX8b1i11hpNzD7GWZrrXfiEcyBRFt6PhRfBawoFu7N08RdUN7W8t?=
 =?us-ascii?Q?dm5ZF3iSH6/lwRMwswuEkT4n8PD2GNbt6+SohDE1lN0YnGzXKNw5yuTbKsDL?=
 =?us-ascii?Q?SoO+RdO9C7tgbdtwnOh6PqfoUTU+CZDKKN0dgrT0pSd00VPSkWWA4ON5B1ba?=
 =?us-ascii?Q?gLSda6oXjAgZm0Gw2upmIOLvSEZMhh5S3e6chy6sH9Leqde6nXr+CsSJdyQj?=
 =?us-ascii?Q?VdEcrsGhXuUUq0SA21F7giPDKgJqYYY4gaRDgw3ug+e/yNz6IM4lf6CLappL?=
 =?us-ascii?Q?Zkh5nH2dHHodBGcqhv7bYvgHk6L6BKKi5cZ8WbH3o68Of1h/NZMGuUlWnXfH?=
 =?us-ascii?Q?OTCJSxkgALlyMHzmNSWlxgScFpHqHZGCnKEvrfhiD5fH8amu7yB85foNvauT?=
 =?us-ascii?Q?BQqnzVoSsjdX0UJImm9+5cu9ZMYpUAB4+A5kOW8JwStKJQk14OpbAeC+oJHI?=
 =?us-ascii?Q?5ZeR5zTPISil10Cnhx6J54IUUrRaYzJ9M8yZStR/knL1Mkwt8i71nQHeV02M?=
 =?us-ascii?Q?jvI=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9479ba82-cc28-4ebe-60bf-08ddafc56525
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:49.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6749

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
2.49.0.824.gcc76007b2f

