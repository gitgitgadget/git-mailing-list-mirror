Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8723AE7C
	for <git@vger.kernel.org>; Fri, 23 May 2025 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003016; cv=fail; b=EVmVvT9QZlZi950e3aO89Fhaq4wQUfDEo0GUGtEL7lFqWmeSPE/OjNUJEK2cz6xt3DVb0AiTCh3LAb3hqr3oSF+enNd5mv/ARkAZeAd3Qb53bJcD+Kd6uenk2VFBCTKnCYMbyu9kvp5kKrmMeD0ch31T+r56bNHgW33XeC129Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003016; c=relaxed/simple;
	bh=ii77DN/6GfoOlct9FGUezop4pfH+q4ZvjP3TPmjj99Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JoP9HaApRlChKD5U7ONNpdgKBoCwmB6ETkfEXybyYgClOuOPedye6SImVFiGto7WQ4d00xgm5IjmrndjVdUEImVRtO0x99Np1tSriESeAeJWAQBie1grpa0N3vaNZdjXnglVlOZrIQRgvCx6rY4I8FFeXJz2DVCzxdedMHGgjLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bTZCVr+V; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bTZCVr+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJwETTmOBWMKjR2i5t3CBVq8ISAtHpSgWFnaJquKgiKub5pFbZwKfOaranJ5Ug02JlAsb/En+WL07/h/GnzLZnxtYY0fo7KPjsh+ZhosVvR96b6HAu7b1rtddfunCgi+1oJsbD+ZljtOMuGsAgR0jMMFW2fHc4V9sUHR4lPNE2erS25R9savv5qtSiHo6Eg8CeNXVr6y4tBEv8sCELUS7L+9L0VsUXDMZYdJ2iT3EYSAvR+ZH6RPTTzJQF19ov+ZgN7tNm8TgZNQIR0Gpe+zt+cQg993WOCHb3O7B9XCMoD/BwVR2CxiBHYsRKdR3eR3b4mtG5S7T+LYEwB3V4snBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVB89eGsc0KRAjlLHJhCTy+d2VKQDAAdAbabYwqMmw8=;
 b=DibCUjPRllmdFUIa8wPrWkL6aAtyo/cQheanjd+LXEIU5KXhIPNSfnoAWEXI507JW3O3uZff2yGSFbmO7BfD5telfQX3DWt+Pd+6H3PB2jIHDmGOL+HQDOdqbnWMQ2rN+c1N3hozvMm2jbhz+rbUyPgcsVKC5hOYERyy85dYYAuD9ggqGpnfiY4J/9TSPcOyPMjaoBjly7MBcX0qQM9tsHPLhKlD24YcsWnrH41g8iUbi3/rVKRUw6hA591457cj8a2JJiJEwPhJnZKJUFWKi/cxUHU8xC2ulKpccXAhV+U0RxqFU6XZbhgk/F7yB9kNKx6MEEPTTSJgO9b6ujYd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVB89eGsc0KRAjlLHJhCTy+d2VKQDAAdAbabYwqMmw8=;
 b=bTZCVr+VW37HNvRjgYGFj0UUd2Mwd9lY8kqm3xa7lVcG0+PaCrm7ZgtxSu/XDe+SVoAoEFW+5WltWKKNpAGqHTuF9wXQBr7vTnhZ0heq7yiRsgssDeZEizvIf5n6Lw5OiwXaX5GMz51+asNkkLOZGlAVlzvwEnChmcIAvt12G6AwV+wKrpiwEidn+3sk/E3g1UUXlbx/szzFd2tBc10JgIpl5ZmcRJl42nfNVJv3CxkV/B1Ls5CTu+FFagwuGSL9fIK2fWAX8heR5mS32jx/jWMqn1JMtToKO4dTnbk2YhdEZVOYaQzgnqYt50QfP57D2/sJC0XVx7D2VTPP0QHkjQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6603.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 12:23:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 12:23:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 3/4] imap-send: add PLAIN authentication method to OpenSSL
Date: Fri, 23 May 2025 17:44:29 +0530
Message-ID:
 <PN3PR01MB959744963D207BB8BAADB4DFB898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523122236.22593-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: c5570a35-13bf-493d-1097-08dd99f49e29
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799009|7092599006|19110799006|15080799009|461199028|5072599009|440099028|3412199025|4302099013|12091999003|19111999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gARa2V0IKYM7JY6LI9T65Gy8c/pvPm4c6yi1MPJhzHS5NG2+2QxuR95NRmgC?=
 =?us-ascii?Q?CKv4M+31QbQtytCkYs9HPPueLR5kKumHak0GaoPdpwfkZfUu3tDtQZkJz3kh?=
 =?us-ascii?Q?qvhsD/zEVEgeHeY8vtOoGmZ/AIqABOQ8wzC6+9xYKJAYO9LIBGc3lIcoN2ET?=
 =?us-ascii?Q?cj/f4f989+z2EAKSypVkLkDsLUzmoXpB9mR+1WzJSUm0DXxVp8i+Rywr/uZ9?=
 =?us-ascii?Q?rrFUyaTZGVOVaKfbZhkvOgM8PYxw/ruRcQdFpKde6Tt3WY/pQSEcjMNq+Uqd?=
 =?us-ascii?Q?OpaHnjReOpJH2bxoK6EYlc8J5GigjQVpjH058QAbhTuh55MG2llPr9Z1TS35?=
 =?us-ascii?Q?Zl0Plm5k6qMrI0m4toWZK5MklRkPfZtuROmVlyOtg5KNMCWowh2FE0Y0bYUt?=
 =?us-ascii?Q?YzNUG3jwKGd7aMnHY/FivRg4lbvzHFS4qLElvAqGum0oS9L5IbUPbfPGyoyK?=
 =?us-ascii?Q?d1iTsOHrXyEq5ue5kccDgXJhewkpdJSzil+3M5oQQmyMKjHd1W2OA0gJPXmy?=
 =?us-ascii?Q?CE6FguMwO0sper7XOGOGCQE1OeMB6GnAD5I7uHr4K3zKg9riGYTwVswN/3ZG?=
 =?us-ascii?Q?Z5Lk0pu3kQE6i4jrGRF0z5rc1Pc+ulJAsaHmbFotxYDs9NsF+lfCXQSCQs4H?=
 =?us-ascii?Q?XfM3RM43jOc7gAZOoM0oIs5z/GqzTfqEe66ITAPJlaYxqjqLTmf5VyrKe0F9?=
 =?us-ascii?Q?JOAYZ42DYA6O9lnk+DG1yAnsDaBqlnZCvan57qKFZpSEtegYWR1KI+DRzLBF?=
 =?us-ascii?Q?oHOtnDTjr+1xVUDn3Hwf8kfKBqGqlZtS/xmjBa9Q289oafBnCPu1Ynv5+4Y1?=
 =?us-ascii?Q?k6SaChWGvLj/6SaxvS77oMkDThTycT4e2gVsuoGHzmlBeXYC8whn+BYdjZUc?=
 =?us-ascii?Q?dtVFrYk9kC3qlQqEbo4dADkzlFZpzbvszxVg+T+WebBeIzpvmJROETuCTucS?=
 =?us-ascii?Q?/SaJ/LAzx/nskWAmRrf3hGjJPbIvJHALEg7GoI+xULeaCeVrYQTVY4Dg9lwT?=
 =?us-ascii?Q?WVqjZb2MzsbMYRoMgzwrnU6+b8TNd5aUabcRN0C+wMGIAvugcKk0+UHZLVJW?=
 =?us-ascii?Q?hw1qT7gTTz7kFLcISpwwoQYv+HWGyx7Ab8RuTOX8tE2H0fMlHc377+AJ9cBU?=
 =?us-ascii?Q?D8YMCVN+WIHryop6gfvyZ4sUnaz2TAGFVXGrPM/i/xsF+cOgQ0vy7mHmtKC/?=
 =?us-ascii?Q?Mg1407T3s970OO9qgF1z4TgSls5jvZhKl7DgssgGHZVnd3c6fw/ms+mUMoTR?=
 =?us-ascii?Q?KjIU41FCARjK9EqEu427FVa+38NTKGzmTwIkR/pVdNjr/2dE2TRcWswZAqx+?=
 =?us-ascii?Q?zfFTIDj4T5/XRuVmZBUkLugx?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+a7Ovp26T06WedX7LNtmBHAQwNXOVr6rGyi6AY4GTv9SAPSwTMdyQnDRHwnB?=
 =?us-ascii?Q?m5C9ieWn8S/aj+vjTaRJZhSGxenNYa40XZ0C5t07tig91hMpTrslovPv0Sgc?=
 =?us-ascii?Q?mRwoEnS8+wWbts0OVqUKCVQgaQ+tuAhzo3JCqn1l5OFI5voOmUInytpXuCU8?=
 =?us-ascii?Q?tDhysxexZhiUWlRNtfweRT9rTOqGRFkGRpGAzbzDd0NO88w523fMrVIaB9ti?=
 =?us-ascii?Q?E74A6T7d7di1p5Qzp+3H7SC8xDyKAtTuOrfqB+BM1PLa8hUVI546gFgWJHXf?=
 =?us-ascii?Q?Y8VOK+OGWjqOeIMkaXyZDf/c8NELNnxC/glMggprxt7F/nceaAEjcNyrMUTW?=
 =?us-ascii?Q?KuabJTXVMR5Bk0fb3z0HiDt9vCVGCHc31Fz3F5KFwO//oUKZY1KaBa1QEhYa?=
 =?us-ascii?Q?oQD4tbFUVoCpNIWtyRoZOSucLSzdOAVJigsp8IvZ4tTbQcOjj/qc/DqflcH5?=
 =?us-ascii?Q?/sYIMOKmMdM4ta2R1xZ/1ymCnugx0xY1TEL2xjOA0ptiL6ouU9+N+FQsjp7N?=
 =?us-ascii?Q?BvULxvgCBNzSQ7uwm0pDEcF9yElNCWFJhtaiNZWZZHmkRpvNoiugwiw3+LGl?=
 =?us-ascii?Q?F61Wb62dx5zI6Z59dHxuynpz//8c2fvT0UW8ha0ZNfiOTmaDMmKfeQnLknC8?=
 =?us-ascii?Q?GIlhYJf1Ja2jLmybGzsAz5yTIx+FHwo8rtymiPBt8Ni66vVAzT9SNJYOc1Up?=
 =?us-ascii?Q?g4VfslnZGr0bP1Zhfie1Roj4UkGk1PYM/tId3QXaeQziUpfP4X+71xjW65iK?=
 =?us-ascii?Q?zapye8/bhU3U4UeJC+ABfWvnBdvcgFVFU4lZkQKBATsx9qzBE0UkEDs+cpmW?=
 =?us-ascii?Q?zBqOuVYwATFKaG5Nyomd3SMjkS/93PX8g8tC7axMp4Dx4ZPRR2+Hi/SYcM5C?=
 =?us-ascii?Q?krqemIX4u9zLHsZam6sitwr29KfzuBw7fBeKI9GUNfxDFlDEzy9J3QgCvfOv?=
 =?us-ascii?Q?JYC02ERTNPR+MJq7hhak06eNx4Hrt5vmHd0uNdctLu4LHlcX3gSWRsCAAuqH?=
 =?us-ascii?Q?aBb4YH4mhkDE5Ui1+pXZLTDZwBdyNKLPbud1+1rgFld1ZeBFMujY5zGqPIw6?=
 =?us-ascii?Q?3HCoyjQUI2JNOyAuQ5zl78i0lC8JQt7Hb3tIeo61ZStyQRyQTd0yR9pnvj/1?=
 =?us-ascii?Q?ljFKMVTQLGaS3y8/WVV3T8ajysfml4vZ/cmfZXpx2MUfjbsJgwmaCmr6pv6i?=
 =?us-ascii?Q?6aZlVibffCELU7NXg0cdG4m+MSaGWGOdYE4Wld8/ToJVBjhMOHmCitYRZ+KD?=
 =?us-ascii?Q?UUAx49ErcsxUMsNJpa9ugg7pjMJzKPoY+SkFRALqnIPM1XinToQ59klj9Z5H?=
 =?us-ascii?Q?VY8=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c5570a35-13bf-493d-1097-08dd99f49e29
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:23:26.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6603

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
index 04b507fc14..ad54aceb28 100644
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
+	    "with OpenSSL library, but it's support has not been compiled in.");
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
2.43.0

