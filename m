Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328A280A3A
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453719; cv=fail; b=H4EWiSyjpSxQ6RFdn+uNZVvA/qcTgvsnZx5rZ8vwMFQiprGH1a8ocDAKxG83EECsUq4zgqRbsPxtAjQ7zm8DQLdDSo4r3TcZysIONP0BaYZuhxAUOoLP8qEsQMvffyrodAexfxEWD09Av5QMU1OnbD4XyNvxRBuLN0u4O2vC6ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453719; c=relaxed/simple;
	bh=4NT2hs0gaThn+nOmQH3ZMyF0MhvgB68CUdI3nrMvY6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7Pzb/+d+XdYD4KeB5onAVq5MCg8LOQ0IRG8DjaO96ucAXlKh5qvyjFO6KmSM3hcrTe4EQrRAKfZRBsvGEb7UXonwF+xVV27UjKSQALpC9hahDDKkjyxNb03bYA2POoBvbmLYDMv39vjjYFRFlt1jkMxplUqzClDA1o0Wz4QRR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=D1ZzCIva; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="D1ZzCIva"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm05nyo9I3mFrTG4OJtt52MiG1C4y+3V55biN+xPPZUM99umgpwHhgvesO7MuoomT8zTFGeKiCawuUqRpgGOPSWQjTp2EkWp4ZERLrOWPG+YLDgxGc6HHAxD+jDI90XIyk36BZaTNRwjYkiUXjnyi9aFc8yxr8sEiBcK71TvUOyNbiF86ugHns2sTJh392AIsNMA18V9QKlx4MltTGEGz7MzTd812MpRgKrUxzJyURtDWOSEVKM87j9QLQ+TlZb3sX7lakaapOCLA7MapHsR2+kHKtsbKguNTREB+hIyNNVN68tMLyGfoc/fWoiEoxzG/x2A4k9YsBuzT5URsUsaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BKDsaXjtJuuds/qhELLEuzMcBbpu3RsEWsLT/n6DyU=;
 b=oEQ86RdJj60IQMjkvFjVFYM1f52OKsP6n/cI1VNzh1P5oD+NoopcnjXUel9Zw5LX5GoI8beUlU1NO3tUNy83Dg2PC2k6r9JxE4Lraa36ZNLgxRc94nCNz7CtW+7lDPq4nUKhfNwUzVqQn7B1K0uqT50O5T84UsTWfOuUx+bBr2XrbjADgA0VUilrKvZaRrzWZyzATCPhAnN19y7h8EESlbq2KU41FBHcKzQLEbLFtakLqPQ6jKwmXiuWvSktVu8t5vhR/tvuOK3Sm3UVJ7s8f8pTLsAcUrdBwBW92A4ZpFjX9LEVdJWOLQT5pEz2aAvQL3Ubmrcg/KFg/a8Iy7u0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BKDsaXjtJuuds/qhELLEuzMcBbpu3RsEWsLT/n6DyU=;
 b=D1ZzCIva3lPtpowbgz/I6ljto17xrS1ayxRNLDiDS28dRQrBitXgJvhCJ3DRGp9JQCyH/jRaQGcqbqbrQmsl79lCAKTSbLMXwFMOHeJ43jsBb4ajGrb127SUadjxGxiTy+GhePdHNwDB3EpQramO96WS1by1X/waIAivwcgbR1M6c4B/VouCkTahNogDCf5DuWMvZJ1kz37ZNTsEIAoa5I3D0jKazf414ddJChgj+68DTO9uEVnqliACzrRGozGUUL6DO1SrcimaipEokp+0WIlqHfcsxDYb0i1Th8pAAeSQzVVhuKcg9+f/5p3uRs34e7YSuQibw4oZNFe6R1uG1A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 05/10] imap-send: add PLAIN authentication method to OpenSSL
Date: Mon,  9 Jun 2025 07:20:36 +0000
Message-ID:
 <PN3PR01MB9597F9E0E8C6E333C023721BB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250609072041.12114-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fd81dd-ddfd-4040-bcd5-08dda7264801
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|15080799009|41001999006|7092599006|8060799009|1602099012|440099028|3412199025|4302099013|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?igsxFINUEtWrs9A0JNmtClfbc31MzXVAsUNeVWo1f6o0F7QbeOu+/xc0x7m/?=
 =?us-ascii?Q?BaSrwQMuNiSxAss3dWk/FsdQLO6Of1IkxMfIZVNHYIUj0nJOWpSV0d+ayV8r?=
 =?us-ascii?Q?mUWzCh3suLWB7DA/NLwj2PBYhhrlYX4onpDWzK0LJlnTjxi18gVi59LdggXU?=
 =?us-ascii?Q?fOMId08DbEw2ndC+Og/qSSeLEmaohukjbTcyRd2eHj3zhr12v0n6YwQQjdSV?=
 =?us-ascii?Q?a1tk+xoY1Sot8cz+2wqxuRyryLuWor/LpHDMw39cbIpgLigy4fqvhTebNpAI?=
 =?us-ascii?Q?pkUPzyIAu08Tq8Miq1ds0lOEZWpQAp9nvCpXQfz9DKVySwWzq9NykomKvYJ3?=
 =?us-ascii?Q?uNBPcKnXnC9ruxGOf6MtYpmt4H/a7CZoRrDlpTBExRaScaSxW5KecdnyHm1g?=
 =?us-ascii?Q?Avrxgmu4eXe0Ic0Ajxu8cOPKQcnImr+XKsjVbluBqv/Ko2FxEjW8zmfTtBLs?=
 =?us-ascii?Q?VsvhMlpVjnGAOlWkgKVCGz+WsWl89YL6M1U9fJOtPl8uvVvg8GOzBfY26tdf?=
 =?us-ascii?Q?ZNHtIwhnXCrOnksvmKLfWYYhEoHIEqwVsuGR3d/J99BivcjevUqfFM6gFo37?=
 =?us-ascii?Q?Dqk5PuvKX/3tH8zxdpD2qpVNA5Wm/smGDjoQ5klb3rB/C3CN7Y0cAZkzl+Wm?=
 =?us-ascii?Q?cTBpxq03If+BmagAhGvJJtyW52HMlDRWcB94GqGv5svdENufTcmswsyNPL5j?=
 =?us-ascii?Q?Ot7EOuosXb8BCml1Ty3vLUrK2gPE3zVfeoAor1Y5rgVI8EEj/TP6YLGEsa4F?=
 =?us-ascii?Q?RY1sckHyr8iTrEBPV8CELMTvSn5zvimb4UsLIQenWPnJnoIAbYQ+gS9y0r7w?=
 =?us-ascii?Q?vfgm1mzwMHwBBwcw6a9FtZLL1Cc2Tgya62mVWOGyqT/dDNGc9a3pUJcDrNWJ?=
 =?us-ascii?Q?A2Gl6zTMcvdG7+xOmquYUfwgM68PTRnXC+OiZ9g7kC13xvBrkpSVgsItBJ1x?=
 =?us-ascii?Q?WyZBA3zayW8V/ZeJbNKz03TtwB8QXzJxFVlLrto64BoMuksf+05WkHf8juas?=
 =?us-ascii?Q?Y1/Td9xab3+jY1RP5V+GkykjSeiGlMnFsTJIf4DTxZjGOLl/kJQC0nH9iYvN?=
 =?us-ascii?Q?hxteQBRPliVTVxDle1Irz/CtbCcq3uZFmQUAR11aQMAtZKfxz6+MUlFMe9Rb?=
 =?us-ascii?Q?1TuBPou0pkic0676yCYbk3zkTkb/cC2IGn4cNzbQt7/M97zAScAEsLdm8xGA?=
 =?us-ascii?Q?bJNAbOnIhdljsetKkjSAUqR/hsDWVAj4/7XQetqyP8A5UBz7EUKKQsh/MYC4?=
 =?us-ascii?Q?i8vo5t5cVmN4X1GNVAhfVRzT3EJXi232DqmwCoTDyffZQRhHQOvsQmCnVQUQ?=
 =?us-ascii?Q?IC4quGaCXdQP99Kwx1ttgiUO4VXmzu01odLf7KUQ0ho+yalMzMS0YsLaQ9PK?=
 =?us-ascii?Q?/t8UHVknmGS7bjvGDPlsZYcfZAuK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPfj7d0wZQr5QgK9/dvSry2crBrOknt97mjMWLI27PzBNEn6VykXC+vEToku?=
 =?us-ascii?Q?mzKLVeNkhINq5HqE3rHcsYTaSL/5f2epcMxS1/COrEGLEObYYLQfJ4ZeexsW?=
 =?us-ascii?Q?bJMujCRRhteE6VJtB+9Le2HvejT9j7CwjzB2h/8B/nHKH/QWxq67cCfVbpWv?=
 =?us-ascii?Q?psD3KZf0LtqvI1UtHfyr4junOytlzklzs+/ln/EK/IVa2tJVIdvSFCyuqCXU?=
 =?us-ascii?Q?vRTnwmwV5FxFJBU90adS6FVOcg0NQiBFCsAt6LUJOKgZjLyVvRvjHT/+ttvR?=
 =?us-ascii?Q?PBOS9EthsirFvACHLJYw2wo9SgI/JX6cCLOY7Q5hLoScoPBnalrRmPADXBL3?=
 =?us-ascii?Q?QKRFl6wOc+U+wIfVdKpT50iAxG7GFbyDvRS6RbzWixRDv3W5eYeAO9p01k1N?=
 =?us-ascii?Q?TqpoYR7YR5sjDA7jD+mhSI/iX990CS/AFgsOeNtPpcxAToLPkjkjQdC5T78e?=
 =?us-ascii?Q?DX/OQXqioY7L8V/D9YVgeyIQS+Ze06Mft90PU/0njLjGERgP7TOP3hn9a0xo?=
 =?us-ascii?Q?rKaQWN5FpNxcxPCbAg0TZD07ZHpE6ofFb1hVn+gilDbCBeurOD26D1ypCYlX?=
 =?us-ascii?Q?yizYhEhErrtgGaiZZ54vMcvu5v/L6xYIx7FPKJb7cPle2lfH/q6KyWc5IBx/?=
 =?us-ascii?Q?HKulia8Ege5+0z2HL43QyHZadVQI8gKDMbQxSRGiFDE4RL/ClWf62dwN32fg?=
 =?us-ascii?Q?Kt6KRmUDDY7qtRGPGLQLOelosx/+SeQXdX9zvNWsx70KfIX3eHTiTTMOq4Wz?=
 =?us-ascii?Q?/B6PKbDhon+ZXuPCGSbeC6Pn07Zv9oDmCQNReBjpykyEY3RProid+blzzX3W?=
 =?us-ascii?Q?Ra4xvpLGsNwRoyhSqBemGRIssPTWFUXfn+7g+OCzTmBzFgjJ/qLJE9SFYe+K?=
 =?us-ascii?Q?51SMMaf1oYImGR3xOBUvAgZbA0Xx/iofLBSa2p1AciHtMtocwowmCy1AyJyx?=
 =?us-ascii?Q?m6T2OSrB03oTqwC00kC1fPTLK65MkYoJYO2J28LBzs80F9Edj6IPpIJbLJKN?=
 =?us-ascii?Q?OgRx9rNMdCUemTrkg9J6qNw2B/J/7rETdKRXeIJFuFzBgK7VzfZJeF90Bza7?=
 =?us-ascii?Q?TJLLqS4tbWofdVi/7F959MLPqZTIeSGy9nIQ9GLIYdtp+kUnYSv3bKrRvNFW?=
 =?us-ascii?Q?yuq9wlq+NtMMV4WnoWAxNyhYwdlHVLVOa01/XMFRM+iPjL1PmQHFiIBmD7GL?=
 =?us-ascii?Q?xmZ3/pAgdCMisj6bCEfJBAjIoxnnkwgJTQf5awDNJsygpuOwBlQyiJCHjQ0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fd81dd-ddfd-4040-bcd5-08dda7264801
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:41.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +--
 imap-send.c                    | 63 +++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 29b998d5ff..7c8b2dcce4 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
-	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
+	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext `LOGIN` command.
diff --git a/imap-send.c b/imap-send.c
index 5373f18b94..c6e47ddc42 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,6 +139,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_PLAIN,
 	AUTH_CRAM_MD5,
 	AUTH_OAUTHBEARER,
 	AUTH_XOAUTH2,
@@ -150,6 +151,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=PLAIN",
 	"AUTH=CRAM-MD5",
 	"AUTH=OAUTHBEARER",
 	"AUTH=XOAUTH2",
@@ -851,6 +853,41 @@ static char hexchar(unsigned int b)
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
+	/*
+	 * Compose the PLAIN string
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
@@ -951,6 +988,26 @@ static char *xoauth2_base64(const char *user, const char *access_token)
 	return b64;
 }
 
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
@@ -1011,6 +1068,7 @@ static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
 
 #else
 
+#define auth_plain NULL
 #define auth_cram_md5 NULL
 #define auth_oauthbearer NULL
 #define auth_xoauth2 NULL
@@ -1223,7 +1281,10 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		server_fill_credential(srvc, &cred);
 
 		if (srvc->auth_method) {
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
+					goto bail;
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
 					goto bail;
 			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
-- 
2.49.0

