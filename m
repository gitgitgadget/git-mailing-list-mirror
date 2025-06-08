Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F709211710
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380240; cv=fail; b=lnZxbXEPeJfyPRlPfHIllCgna1bOyt3VIYqUzYJbboAwkaJikgNX9T8ZB8D15rIfGsQ5HWMesDhZONK8JB3QawtcP5J+asgxQM2th67OippRvz7AkMk1KSldrrqpBhh17KruhJ60vuFGBy2I3fAW20E1zI3bJqVdoaD/tCE/iUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380240; c=relaxed/simple;
	bh=4NT2hs0gaThn+nOmQH3ZMyF0MhvgB68CUdI3nrMvY6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkJhOVbsBtHW42X8ewcm20ORCS3NFUapk/ogdIGDO32mCqA4acBPTSm0K+T0OzHy7mzFC/3x+tlHhUr2L/n+L3RUE4VYdTJsYPZcVvUsBMR7pWxyKWHWJB7TUFZ7ikAOf7IVESgju1aDcYwKiSpI9W46Z+jR5Z+im2WO6OUgTCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RPhowkTG; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RPhowkTG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmyG3UqmbJZXxd5IaaEKFcVcPOgHkmMiK6Z4CVMCC0Chc0o1tttxupN/zQyF27A8mr1/y+c3Vaxmf01l2PacVMOyRfLMOB5wT0KcIQQvVBiLR0jHN/Py6y3A4nS57KOUd/TsiTmC3p5MkpY6pHOp3sXxx9iV4eBEuVoJKUXr6vyQDU/KqYdcKH95hr3eeN96kgKtYeXW/lp+r4nGIoy0jEDiAmz9yKadHtRGOda8Xxnrdu39SgIjv4u4Qo3jghQSIMIZzleLvmSbMM+17+kiB3DEQBFFeluDK+903b5UMsLLGooH4uyTrxWYyfzXAMRFm1btGTpm+drmjh1Ipj06OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BKDsaXjtJuuds/qhELLEuzMcBbpu3RsEWsLT/n6DyU=;
 b=QRh6+3a5+Pz41f0QGGwxMDRfEWVq7VjRG7vykd+JIeINngUTJ5uTjd74LjGtnxxP9VOqUWAlv1RNgG05N++JHTlQvPv8Q6YH+G8Rn3/4O8T+UI7INZYG8wMhWRrHu79UGIeS45gvRCBmD14zcRsrvnRknFT5SDPb0J2NUDoIVu2wkxM9SB4bTz0SbBban+Y9WRfRr0eO0GtJb5TqXhQcHsfHNfKhX68nn8nZuo+WV3wlP9tHBuHHpQwDerWQh75H9axoyHxoZ5mPyPJBuO0v4s2kSI4FKjg6k3zvaQ9J8ikZ6Na0X55iXz/exk6CCCHBCVPwNWc8vbwRrkNIDFCnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BKDsaXjtJuuds/qhELLEuzMcBbpu3RsEWsLT/n6DyU=;
 b=RPhowkTGMQkA/NUOHoaRYh/vobjWuMY1mgkYWrVMpcVQH1KXRYt/UVQO4AYetgbFB9WJm/uNH+nXg+diFakRGy0I+55VbrvJl0zq3TcZNWsC+U19xxKlxhWZ6kOycpgazAzed+ErP0Q/utIa5ARvIByYLfn8YsR/sZEGkvMXgwieg+7vOwvj9zu6PkER1vTYhCbO9TqmK8pEnC5nDXXHJcei0tvX0UIXsJVi/qdO1SkWMWJMWWK2ov6ZseWtqMIC3iMEgpA+1nwUAxlOxxlsiYnqY7W1865hwca2OiKw2G44gZ0Jd2PxPxpfDPhySeGIKzns2WICE4SYTaAxYyLNKA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF9841FCE60.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Sun, 8 Jun
 2025 10:57:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 05/10] imap-send: add PLAIN authentication method to OpenSSL
Date: Sun,  8 Jun 2025 10:55:14 +0000
Message-ID:
 <PN3PR01MB95972C1EB5E3595CF8096F02B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250608105520.18264-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF9841FCE60:EE_
X-MS-Office365-Filtering-Correlation-Id: d673a3d1-ddb8-4232-d947-08dda67b3728
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|7092599006|461199028|19110799006|15080799009|41001999006|4302099013|3412199025|440099028|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P8TU6McsdCWXZ16iyGZHtUwOC0AF8JM5Mgo+tvOPDmUT1ziP/J5BKIM/Y1hi?=
 =?us-ascii?Q?8aRCqq9lnyyiovAk9rtD+TVuuykhTSSjMhukOhqa6kljPyUg9RrcEhSDCJsF?=
 =?us-ascii?Q?2IfxNvvPOX0sbV9BwE3CHESfIKRQoF0rsCmojmacxLKxjqenBDTl75Dn0ofA?=
 =?us-ascii?Q?JJszdZspEIyl42eR+jMv6AYF9GLjjnWSX2a6k/Vv1f4UWlGqrdND+rITiex1?=
 =?us-ascii?Q?rlkAOTbNzXvVoZs1776QWkbHqI5T9Fz9ByJrLcsGbS1uQqa6OpkkeD9/ym19?=
 =?us-ascii?Q?eWrAoCjgjKiBc/cq3/APU5KzRdB7FIajdkzMsvALAWcMnfS9X2V+xLkAX9DN?=
 =?us-ascii?Q?HXZcdON8aNanvWpseycS9jkzu1Lu6Q/CTWY6E/QWXkFUEXfv5DX4jiWd9QZp?=
 =?us-ascii?Q?zvT0qSS150o7lflz2qAwdadprkXVZSUrl/+ZylNN0KwpPMz30nkg7aqFIgj3?=
 =?us-ascii?Q?KocXeguorhykJNxg9fW+hdTaSdtjur7AIfeX/N7O4190npJDqGQr0sUVc5dP?=
 =?us-ascii?Q?P/oOINZJQz2BbrYwXv06P6X1ASzqc7WgUg8H8roQZ/Yn1LBgj6DGXNSJeOjg?=
 =?us-ascii?Q?NLP186o8pOalDY6dhmLhVQSoNBN/VX5CXdhG3IT9fzrcM+9RIkLQmV353RUm?=
 =?us-ascii?Q?4SBCaHH10lTx5SdocHBAp5RDActqyU/Z2GTKRQ847mWiAsCxnyZxhUIE7TDL?=
 =?us-ascii?Q?aBFt9fpy3YkpKObXCb4CzSzJQIluqhYCRwCFrQMRz6ef4MQSkDlixa3R8a15?=
 =?us-ascii?Q?XDZTZmgIBAFft2azV99ZizyXzhB3XXzaYQmJ90MXMDKy4YKaisvcTWR+FXXn?=
 =?us-ascii?Q?QCASQI4fAsHrxjPudRIU0E8NVxKqaz5IlOs1XI2NqB88Gp4z3lGP1bMVpuf7?=
 =?us-ascii?Q?DDRhcAwy0xn9Wcbn18PwpP03QF17P2Q66tN/sZiQXHt/dRR8Hkl4R4dtYyv0?=
 =?us-ascii?Q?wZ6X5JSvdz/lBdyjFpl4+irCoV6sWRcg5uvxF8j6Jq4jpgtiY7m4tZ49RStJ?=
 =?us-ascii?Q?LqVCR4FPiv+YPFo0pvURJludj/5hlYeDWWb60UgThw7kh0CNylqQSxlve6bx?=
 =?us-ascii?Q?NWXB/ZNaDV3CMVDRsrrzvPJSjFc68394npm3kkmmH2L4HSFScXuzGmkCrcED?=
 =?us-ascii?Q?H+7HF2X4Oc/sQUPZTdXn7il5tF4UY/9coznfEbgA2OtAu5cLXnkpi0nok25O?=
 =?us-ascii?Q?dXRTU7tl5dlsMXRdUeAcJTeLFa0UZrTLm4wN8q5ylSWiebMUwKqwfBrXKhHP?=
 =?us-ascii?Q?5vRXSxS+fREr7/jdCfKIgBLIstXg/HbxTtF8pr6YxZ+nR+lpOMVpNF/V8CpM?=
 =?us-ascii?Q?pR0N3wN0X+UM2P18TPWKhV6yPPip9CuI7O7F5ca2QPJ+Q5KCvrWvn2IvEEgn?=
 =?us-ascii?Q?vfKD/+aXBmh/oRHztbf0kfLTdqvl?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7Gu2Ic3qj4DeJANM9yQ++WXVsJ5M2wUY6sGD5vaweCPHGMgIinI41iqJ3+B?=
 =?us-ascii?Q?rNCvQc7PvXliODPXAuujnn1Ctj2oQ3wXVJn8s3VjfEnX0GjBw5xelwD5VCuk?=
 =?us-ascii?Q?DY39XRCI+XgtwYZSkazrCTyevWjk2pX8Jn9g6aCAzvNGuN+FnZmabvQGrdz4?=
 =?us-ascii?Q?aWczcev5AYBUSyZR2QhIsGkEN2FWedtaCnoV5JX6b61rpU/tT1+C0832eByg?=
 =?us-ascii?Q?zw7IJgyIjjDbYXRiv7Lbn8Pgv5DAVGPozWDHUtPE2zeHTCMbVscnfPUYnehd?=
 =?us-ascii?Q?1/gfWxPCEZRoAamy6n6HzIaPp7YcMYRY2ODTHZrILJ9GyfEbjTgKyidgGpQD?=
 =?us-ascii?Q?uFGnOAQKXwlQQuYjWZ1nTPES4ntPnSTHy3jSpWYEsmo4eBy71SOlNhJAvoOh?=
 =?us-ascii?Q?B8HgCT9UTDmagOkL3Q825hsKW3699vYa6/CzqUqvIM3EFEHfnt2Cz8qljY3B?=
 =?us-ascii?Q?NjtOAv3z5RHZ6xGHC/WZwcV36RxA85jybSuhrtTPLMLe1cux5Qx4h02LTWzl?=
 =?us-ascii?Q?AydLo/wGb6kqfKZhbxlPikm0r3dyqyZmo0SBAKA4n8RyGyyig2eOI8b27L+D?=
 =?us-ascii?Q?irbTtBm93oBK7naHSe35eZeJ/0xPxWcwAM66tFAT/O0f9uAVawQEiySM/cME?=
 =?us-ascii?Q?p/ARmLDgg+4byMQMwHrH2RHb/MmRKiYDbFsEZ/5sE+GE4xinexUkK1jmQZHb?=
 =?us-ascii?Q?ZENShojApLD6sB3OSaXKxWd62TahIlD/o76mqhTgbVISzTGxubTHNmd0JXQ/?=
 =?us-ascii?Q?WRnJv1anB8ZB34Q0OHHdvEKr8hEJTCuoJjNumYE6ejROXMewmYxZY+ZpknXt?=
 =?us-ascii?Q?vx2qHDFvSxTOb9CMv6D3WANl20ArDtc0iNNdt1Rzh1XRe3gyssFHUgRsXcki?=
 =?us-ascii?Q?Kj5/l2ZkDps5zSRqgQrvdDY82f53wzE2HcVIctkeigPPfVvgkdQhUV3TZLyH?=
 =?us-ascii?Q?zMWM5ClC2JxMAmogUErfpZH5s/+mm3NyPEr7aD+aGQLMZuKaEwa5Inixa/fQ?=
 =?us-ascii?Q?wjDFgF+WBALR/A64h+uJRLdb6K794+pVlwJs7wXOcbQ2Mm2QRILjxkktz0nQ?=
 =?us-ascii?Q?wI3VK4mtA3XFRDUdPzHCoGdE69zEszmyZTYBnIms6Nz7CDVluQcMBWy1Qt5O?=
 =?us-ascii?Q?VHR4OxOvarJ5opbq4yLKz+9FFdmY+AT7SvwcfpeHaQAd6CBIbKvPLQv21ebx?=
 =?us-ascii?Q?GMRCwnGAPEzCyLJw0w8YlRrUcWU1E8GYdw+mp/caxSYHvkV7Bha+NneiyrM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d673a3d1-ddb8-4232-d947-08dda67b3728
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:09.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF9841FCE60

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

