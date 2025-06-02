Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423A20F082
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862040; cv=fail; b=G2uiVFScATQt+sH9neFb6CItO1y1QKV9n1O3JsgBelX6CEiRNqZMxAghy2CxW1Kl901hrsWPzSGczUFUcbBht5wPH1hmIEPunQxS3Bw8ph2nsfYyG4S1ThWCoxRXJ/gcSgQO49nHgjkOkNT4cqwzg6I86WGdwpkaX6BNV982svk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862040; c=relaxed/simple;
	bh=vIylar7mIbIPvmU97b9L6F5JloU3DZWJmyw2yZXPKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyndG4564JLhTkRnVvCcApQFw1ICYTt0WvS0ugP6saX3gG+o6HIWhnwrwsU/STJ9gAB1TFyFIYRbHxTy7ToFuvEwzEFmlqLV8jxloJxexJW37nVzeYL3ozFYfOMy0+k8S2POQZZIm7vEmOTm50nJPOF7gnC8MR55QW0cZRQqJXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Q/F0T5o9; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Q/F0T5o9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjQawBDdqhLD5Ml1YlzAIrQLSzuYH7z3r4yKaoYS244w6xs/Kz4lkvBQM6xcAdPq9UtVRfpSe2NyGEl3B5Bhd1VHJwofM7EiusaGMLljiKxHlMmLIofyBQ9wqpT0NbDQKjeTu9lYUfknMl1aJwn9m32XylpHF0cyb+QVsKhJhB1tQafQRvOZkenrbjJ3LAkgYL7wgzJxzlwYb4IlU8pzE3vN9BEf9mtrcA06Z/ms8T2GVNkCY55GXw/BqMTzNbdmfWw0zu2kcPYXzMzi2T3M8FI+DMNncxWmnGix0KNTd0lrESIKmQnl8yC8UiZg0qHuR/uYXh3TGHyF3uiOuVF6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2vNny2dZXwfIoU5EVoTeFSYzCGhX+509WOkv6zXFkQ=;
 b=j2uWFIAAsURsmApgR4ybc6g+FR6UUTk/b3AEOYUA6c2VtaU8Ndq4vYWw3I2zcgzHu21LigWWZx08XABrAQF993Ws55PNT8V8v1uiDemFke/nCPQb+8D5ZDOXYPkxEoShevmjO+vgw1wk+v76TlulUK/M8K2FhgBv2+fSNLqk6HwJqTvrjMdFQ2G892T5XFg/56vFw+c6SzmOH9IDpxT8l4/xC4GL+wZoTPQ7YXd4RWiXvq9ieC339B4BolTrNM3m0F56yT36e3QsYZQ7sHrVK5qp3wah7GyJbwzdYQRcUGzl5KTocCzB4sPWPAKTW6FL2KbisaXM6vPCVcOP3x/QPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2vNny2dZXwfIoU5EVoTeFSYzCGhX+509WOkv6zXFkQ=;
 b=Q/F0T5o9jmTwSsZ+Cc/s7ZUFikEaEXqBEoMroeenY3iD08LRngM+Sz5s6ZiomI8X019syW3Wzezxw2RCuobDqaO0FZuyGhniAqEIyQQ0aK8CzcK1e1LAPVWyrZQpsFSQXmC788q/mlqwwIDYa9NZl76xYd22u/u9B4xRjqAZVFqsU5636z445bFeaCllWj8AGiyQeQSc7236WxwLWarYayJyyIlLMENLr+UOD9gJPZVL6lfbrvjwCaNAjCJB/kr7TUdBRNEijyg/tEIbBlu1L6jBt0UgdxUwoK5+9dTwJ4Elc47pzFtdIhPzsOmT6Ac1/UJOgTH2nos37vp+Nfb60g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 05/10] imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
Date: Mon,  2 Jun 2025 16:29:36 +0530
Message-ID:
 <PN3PR01MB959713A2536AD407D15CE632B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g36d50d01f0.dirty
In-Reply-To: <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250602105940.75439-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ffa95c-303f-418c-cbac-08dda1c4af1e
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLRoRWQFhX+jcTRznXquhX4ddJfVYHpfCBkx8P5f8jjpPjpqn/DnqDeQiZRRKgrRrwX/bZ8Gj7jZS/IHXYwpynQwu6ZQ7TBLutCjhCxDRf2EqtZLc59jo1QIHMCXgbXpaHLHRuSXtItJd7A9Ate7BFKs1whla3z9deXudteRXkc4dUeri9XSjyox4VOi+A5SdFREbPNIfGfcBBqxjsLLAIL5MKR2+ukqGWs3J4dqIzW9ExXmHWWUMevLN1vvV6l6Vt4fgMxygze7zSUOC0tN6FiME5UjpNZcKBsjBRGGuAfl0v2X8p8Fz4p3lQXJSq//G2ybaAIpbs5vxfaH89mD4e8i4cLODww1Bd6tWMB5Vla6wNhknJ1/BZRchX83yGQXbpQ2+7/LQJwDiwY/bUke+UjlNC5S2nbzFWr72Hw52M9SZ8tU2o4+Q6AOd9n/nWNJ2n2McgloWzOZB/C7CHYAmiY4s/pSiErc/YCqu1F5EO5WjJzMYsf8TrGHy8q0em0STr8UtGa5tQ3swFebjjl6Mu70R6eFn2vYsWvVmUh6A95xhGL22/PV+CbtJYqfyP19PPAtSOL395sTzDpucW/8PQGhGrEVQtMzuO6aDfY98jsoRHom71p/C+UdzzFC7sBmNL2q0H7YY3s0Lwbv8nZbRc1QprOAD03hFraaX7y5JNSZu6hccOU63vwZW+yTLSYn2J2MKMx6i4A3IKfya0o7cAsvh+GSE1JJFH3HF2FfImbaR0ZKmeIO4H+9KWkCoKM3pM80AYnuivQh9m9Kja0FcniM
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jV8BbIaCninWNAAlCxzgBJ90nal8OeDXD2WrpyC0gLjbCTVpw5kWStHgXgvG?=
 =?us-ascii?Q?d72x76e1m4bW0WFBAs1z1bV0ta5UrEN6oNdgVR63Jy7heZhgcoF4IGAlCgA0?=
 =?us-ascii?Q?PFyVcjfAhVowbZ8pojVeZwcmt8tWJk31lzvVC9dY1F0a39Er5IOrGOiJduzB?=
 =?us-ascii?Q?URcUYTnQTk8he9nUivnSsSRj8HoCvANcHrxUFjTHRbacoTMFdVr2HexVJ2MV?=
 =?us-ascii?Q?1JigDWXAI3umAk9cG/If7a0MfWJAJRnCIdvEKsuK/WblAk/j274+YZlLlkpj?=
 =?us-ascii?Q?mWy7PXlHKXTXl8WQn+m7tZfE0ZEXMiGhaACdxHWtbL0oE/yyUIvBQ+UEwsZ2?=
 =?us-ascii?Q?58tfntBUZ4vJPcowr1cRukCTUL7H/TRv9DZuWazE1FF1qywlYaus2Kl2oues?=
 =?us-ascii?Q?U7bD9rZFjTxLREIF7l/CDqWXc1jWRft1Xf/kHG2sO9Zjx+0GD8HSQeWQ/4aF?=
 =?us-ascii?Q?Xq/dVqA6/gRzwmJZg446RJF7g5jHDDxxh5KozmaHWvF6H/g/+l5/GbwzeWyu?=
 =?us-ascii?Q?+NApS51m+XvncvCBtiCtVuLxgFuBZkDsXHFU+rrRPUPdssWzkKqA11zbC8T5?=
 =?us-ascii?Q?JDOQvX0e7j73c9iH7K9f/BX5iU9Ki+K9j/IBgy0Ygkn3c9t/Qp3V3Fw72hC4?=
 =?us-ascii?Q?EhX/oZOfhK/lJC9ML2PHbzSbs0tLWKCxSjN/7egSbMMrGM+qKcxcTKFC2PO0?=
 =?us-ascii?Q?mhwATRYi0sl+IUDpaMs1oOaggW8E/ZAkCUrRkmelDcKLbInzbXBeaRJdApUD?=
 =?us-ascii?Q?1tGu04FA1M0sK04jD1cbUa/12k6MozFl9ltDZuvOvqP9sh0uuOTERHr59CfO?=
 =?us-ascii?Q?diELOi/qJb4tD/lK++uGVT+U8RvC2lPlqpZg2erEIXARQ8/61OeuW+1qnbWP?=
 =?us-ascii?Q?H7Ah4FCb+deQu8ZDArzJSeHJf4ujOeo4kdwcbf2z44hrR2LkR9BhwQerBM+R?=
 =?us-ascii?Q?Xym7yt+Kgo4Ais2MUFbS1vfP9CWkJamzVmU0clXpI86S+mYMX4qQihGmHGkb?=
 =?us-ascii?Q?sIzP9qFFhl10/ruqGn6JcC5GYgUOfUp+Rt6MP2u36fvtRCXXwS6aE/LxlysW?=
 =?us-ascii?Q?m0ebrwDxxQm459w2HZBn5AVD9sRZwCjpJI/FEE37bRU1SAzjZ1DZagPFlUun?=
 =?us-ascii?Q?pGwubfPiheSzlxsM2bR4dBOwKpn5VpfBmMylXIflwWyeenTJGn+Q+Pk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2yLBBGECzb8hBLC7Z6gh6H0rD9JdECSz1LWI+yhLI7CN9st6H7PB0OdITM5L?=
 =?us-ascii?Q?o0Rrz93Hj/saIFo3V2efGWz1J7JMbTufqjeA8UrEeFUha2FGKeOpvwinNbq9?=
 =?us-ascii?Q?oueuXsON4/dzUztMkx6sxAKc7C7hvh2X4RgkNnnzVJ7j9pd7+pUU0G+e9je0?=
 =?us-ascii?Q?0CVMmheIjP2FcLbxPys6FYpvzrEgMOwYVZig6p2Ey9JVhYBOOpFxXi4xm4Jo?=
 =?us-ascii?Q?NlS8EwR28hxz6QmJwB5Dg6hGLJFk3QepDscxSdBihXx9np2L7p7v3L0/a5nX?=
 =?us-ascii?Q?2jZJQAOh9gTNneeFv+x9/Er6Gb47aTeMs/Xu2sNHsPldgQ9zI5Aj8EhlXTlb?=
 =?us-ascii?Q?Grpj7KBhbSwwLSUr2m2D0h9fN9C6KXJbfXox1b6VK+xU70GwbS8J++LVE+WY?=
 =?us-ascii?Q?pLDvnANKCXa/sWsAWca2zxqK2t4stN2Yg0Hh+BoCw4dE9E9cxTr3ureec5XN?=
 =?us-ascii?Q?Nd8N416wqTDAU5k3WXCP52AdOWracpj6/lBe+pNlKIz1TescNLppzVHq1jdP?=
 =?us-ascii?Q?jOS3XwBQU+Sbcc91/RLOourjzk2Xzq4KvLRMrv3YsmJnY6Zf8ZuTSPWxweLH?=
 =?us-ascii?Q?yP50hCuZ2m1Ottugb6xPILgZ5861QzxvTW2Sr97Cr2nm4rl4FLRWBqJY9/sM?=
 =?us-ascii?Q?psaNlw2Jo+iSf99toB+9IBgzK8hzh5DobCPyKkoqeuPIb5O4Urh7Mm9Uy+gw?=
 =?us-ascii?Q?QXOAkTNKa178t6UVue6Zl3LdAAJ26iC6EI6ReE+c6t4gNXp3nkSr8461/N5P?=
 =?us-ascii?Q?ngexdk5jb2AxvFvd83mv92EPeC1+AnBnCDvf/ttW6zSpzwBkNoVPMAPL/MaQ?=
 =?us-ascii?Q?vzBBE/tYQS1GNePGtilCjRDBjyReyBIe1iHNXJ9jZVB0Ea+14oI4XzkY5rCN?=
 =?us-ascii?Q?neMw774ozBWsTJwz4ZjlqWKgCuwuPb48dnPT0ErZ6hejowZqv7Wz23lKtNwv?=
 =?us-ascii?Q?hFhFuw4uD9IWdZE+syaLJ45qtUXjvabhOBSToorDuQ0s148vpt3Ayj2iljDB?=
 =?us-ascii?Q?WOhsBaepfuoB4oPIliZm3tUteT40x/5sgWO+4ThML6YTJQavCAe3gcraN5HF?=
 =?us-ascii?Q?Rc5h9TW/o5CtLNWZEvB6T7seOwoRoFG3A5bUs8bD/l+EBE7b+Hfm2ZvjV/5Q?=
 =?us-ascii?Q?tp7+6mZJ9NfKiTdlT188qmYclzXSLlJp25yMZcdZqwKCeTvIGSso2Ebc/Px/?=
 =?us-ascii?Q?3kXx51tzSxIKfbXPSroDgcgsDCy3VCqNe8Oh6d1ChOZuoKGwKvadQGhNagat?=
 =?us-ascii?Q?jTPob3NwIwXeU+8ib5GMlKR8EaKHLuZRVltcY5m5N8wpEQ/VRJxrT91c2CIA?=
 =?us-ascii?Q?RFrCRBCkR56eQnLUN8dLLtgt?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ffa95c-303f-418c-cbac-08dda1c4af1e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:28.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

Unlike PLAIN, XOAUTH2 and OAUTHBEARER, CRAM-MD5 authentication is not
supported by libcurl and requires OpenSSL. If the user tries to use
CRAM-MD5 authentication without OpenSSL, the previous behaviour was to
attempt to authenticate and fail with a die(error). Handle this in a
better way by first checking if OpenSSL is available and then attempting
to authenticate. If OpenSSL is not available, print an error message and
exit gracefully.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 5f31dad3b0..879c72a606 100644
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
@@ -1287,6 +1280,13 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 						"but %s doesn't support it.\n", srvc->host);
 					goto bail;
 				}
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "If you want to use CRAM-MD5 authentication mechanism, "
+					"you have to build git-imap-send with OpenSSL library.");
+				goto bail;
+				#endif
+
 				/* CRAM-MD5 */
 
 				memset(&cb, 0, sizeof(cb));
-- 
2.49.0.639.g36d50d01f0

