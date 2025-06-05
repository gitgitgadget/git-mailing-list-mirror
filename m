Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCA20E00B
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112958; cv=fail; b=ecAB2F0g7ZM6veojyFFmEPnhRcAHNbOsmHUbIHsZxJ1dj+IKmAcKMF4yMGbtYk8B5dwjP1Vzf67KyxGpnghiTcICnQle/yK/VRMfHrOsdIjJFjyRU/hdCFF+sEPFO+fIb68nTBX1qDyIK0nev4gTB88lloXtBlfm9cJ1qa5o6sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112958; c=relaxed/simple;
	bh=FrFHB+vLK5qQKbZ3Yl0Ym6/P2syLQcYErYt6YGkkZiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhjPX7tZy5Is6YPB9nw+tiSaJ7657jq4G9C/YhEDKyKazrMZbcPHDbK0qr8ivgQkmxPrPxg/eRIOzWqNU0OFUbyPdBhGbdI1wpmp2Vee1RIvJoGnCX5noicnxR1VxOmj87MMbcReVokA6cUZpTQws0/roORvo3ph+8vD1bKjcjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pWuOUg6R; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pWuOUg6R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhgOsxAVW2ZPmf4AY7CUSqH4RwzUviJ6kuerhoCedCFINDDV0r32bs9AqGzNqcBUlft8aahnbr8sXFilI4vhXZayieJzCKDnG/YN0/i4YKV8335ZxZ/bxozwliJV5WcGgWWIIsYnVLcd+gM7V7CTJDE48SbqJ563OlzwRaKaw8BZ36CUym/ekM5Z129bFRAp6mLIqvc9XVbv0vq/di4f/91KEHAUEhdook2BG67g5pn+Du5Wdd0xKWQ3LmejHA3D4Bo+UhhCE1a/b8Dl5wiIF1A9tGZevCghd0KRzjvai1nQteDcUE3ZGw1OmVgUoG7Seh5iUHHo3/0TQ9Om+NcOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/qUq0edYEcPSHdw/aNXdfB43kRSLlPJAoBosnUWB/8=;
 b=IMkMfKCyKk3aCTN00aNMMS1QMLYwrEvaFRzr+eQe2WEdaQD5ij7PyGIg8MvQOkBq16+6G39dWpM2BKVKtLMku93qIRrbjJt35Gen6zH5efFEAGvbFxKJgRNV4j0t6NTkyicqTPeDh//U/HlZg5KVE6CsGkdurrfMiGMd2zOSwImUIVfHydS5dKpqR7vB36NyItkqHpnwgy15F1w9yNgCfFS5FiQgMOJFuW27BEUBWddsq9Za+DiFC4P/X0TkGPHeXz0KLxHHr+PEEEFPDf6cvVXvFAMpdYQBvkrz+COiyF0yEGbDolNzJ+u2Nsfd2+njpB/iw3H0MgpTJwYvTd+3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/qUq0edYEcPSHdw/aNXdfB43kRSLlPJAoBosnUWB/8=;
 b=pWuOUg6REDbhBxJe7/bof3QKfHOV2eOfjNM4LlyGKB3B73+aWbrpdOlNZOIiIET83LZy90DvTe0lO755zyJrUDEMIiIKD8jLHvQsQOGRg7OeuZBv2948z5TzJYvy0Y4VL4OqC1ImaoNMWpsjZWQxQ60BWLF7IYKLgIDAkPYciBNfzEb/7kxbVs3fXk33/0/UTePcpQJinbUr40+oyJ35tMcIys7sBzqHEmPz35e25e6kDmJCSCyq0eH/xO9DJywgWDcIPCF/y9Gk6sn1fZDZbjaXflElkLuVY0DA4fCs9FxHU9FnwHdevLiUXpu7fyJ3o+Scojzd0rVCO2SjDmAtWw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPFFC37E0415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 03/10] imap-send: add PLAIN authentication method to
 OpenSSL
Thread-Topic: [PATCH v13 03/10] imap-send: add PLAIN authentication method to
 OpenSSL
Thread-Index: AQHb1fXDer3bIomwiU65XAtULRADEw==
Date: Thu, 5 Jun 2025 08:42:26 +0000
Message-ID:
 <d934bdcb82df2c997b44f2ae5d4d5d9ba9cf066c.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PPFFC37E0415:EE_
x-ms-office365-filtering-correlation-id: 90c368cc-ef54-458d-e731-08dda40ce606
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|8022599003|461199028|7092599006|8060799009|8062599006|15080799009|19110799006|41001999006|1602099012|3412199025|4302099013|440099028|10035399007|102099032|12091999003|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?i0rESURZtoTQtEnGH3D41g44uByfqlp4yux2QLXko/lvoGEC87+gfPTBw7?=
 =?iso-8859-1?Q?VNE/6lKQHXWXOUH66QDzys2PZlKwoVR5ytjxGzdms1Wsx9oehbTDv/6GA+?=
 =?iso-8859-1?Q?IQ2lzWwMXx54uf+8aEha/DGEtDQynzRYFmN80kYjHrEnfymA+QluWReXWs?=
 =?iso-8859-1?Q?qSzV37o+0IbxQP6YBmrgy+QGVZSdJYZFh7wQnrqCpQBslyegFA2OjYYTZ3?=
 =?iso-8859-1?Q?2dNz+LAoSOrzNt1+g+A0ly6di9PRI3r0ro8nK4zrllmM7o9PMGrbaWpr+r?=
 =?iso-8859-1?Q?C1Up56XixH6z397jyeQypIngYHWa2qS05Y2NWqvEefv8eW97xwVb8tlyC4?=
 =?iso-8859-1?Q?1VXDzv3j7oAl4hERUNYFZCL7OK98lA8kV6v83ehRx5AvCr4/ce47s7+KxC?=
 =?iso-8859-1?Q?ER0YjrrMNgGH64YdgAZSwMjUhhZOADBeeqn88uu8ClwfeNa3TNPO7fefZs?=
 =?iso-8859-1?Q?SfpHGRXdjkKOiYj2OOY5/ijdzTEGN3tNmhe8CnMQX/q7IPQv39q1cxwS4H?=
 =?iso-8859-1?Q?ctPlNbCBjGLpI28pgiCqMl0HdUjLKESGTwS4uvwAJPOnjvL80LhuEWMGHi?=
 =?iso-8859-1?Q?7JP71TXE3c0RKtochhBPu+GRL9DwNEA3OrwqWgnrGc4VDu+TUTTAJMNFt8?=
 =?iso-8859-1?Q?XTghgGGLzPdKcAS1dLfre7ws7dn3vqSX5LbxSbdWDVQYXzRXHhTKn1vCEv?=
 =?iso-8859-1?Q?A8vsYmQYgUNVbjhKLMD8mp1AY/bXCELSSQxfzqq5OjRNdci4cFfEqj/7LQ?=
 =?iso-8859-1?Q?Ya5BaKWlMdIJYtOQDJxTsOE/RyWYkX9r5ZlrqF6KVNPu5g2hLewLTp7WsV?=
 =?iso-8859-1?Q?XS1z6BEfCHoDBQ7bXfdjAuWALsNEdxZ3+nbikJZCfKtkcEMNfO4UUpMdbk?=
 =?iso-8859-1?Q?TWzJD+z+gOn2psvcSHkFMvJyFFB2apLg4Wj951UdEbdqtuisyun+xTKl7J?=
 =?iso-8859-1?Q?Whl5XGAx3xsT8gm4BUncaPi7WVzebcoJC2aCSu8WdKJ4DO7jh6b5McT8EJ?=
 =?iso-8859-1?Q?GqLE4LUYPuenpRwPUhgbdHzM8tymm1DiTH01A2EQ/ZS+303hXdsZDlZRZ4?=
 =?iso-8859-1?Q?9euFu7f5A5ZL7r0X+liuuq5Vse4YHOzibgmDAv/LbiLfITWEOBXwbnHLDa?=
 =?iso-8859-1?Q?fKJT0LnGAwhX786GminbboktIhXXUsB1G2bOL0vDHUODZCBmodFuRfQCuY?=
 =?iso-8859-1?Q?cVFirkPn9Fj/7dPFFIA+TqMVinwvV8rjcUNQO+zpnFUdZ+C2mM5MjA5klf?=
 =?iso-8859-1?Q?4c+8NXaMCHqpdkbEauUph3A/RrQ1jLhUEW5iMqUu1qx8bAMXqpOFwmTivu?=
 =?iso-8859-1?Q?nhN42xUzr4bilMnrzqPqXwfD2rfSCWHNzU6X7sXETut14XUKLMdrcBJr6S?=
 =?iso-8859-1?Q?gX3sBH4BAuiF2UzBPXEWfwk+zkdw0FJVO6i6WdUl1TXfDy2Og7+P56oACc?=
 =?iso-8859-1?Q?0iILHakYzsAMSBtDVasfPcP/SQDS2ufZVUkUIg4wSgbHwMnP5igpetNM1m?=
 =?iso-8859-1?Q?8zeGaR6FvJHiHU2u0X7Pvo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ICFDqE4kIBBHA1J/vDy53mXhZ8hutM6UcdAS8qdMqVt3Sp5P02oCYpoFJ1?=
 =?iso-8859-1?Q?vdpNCdWM+ZTRf/FRRxgKLxPP7kbtjoymDBWZ8kQaPCdTXjY0uZQrSoQ+U0?=
 =?iso-8859-1?Q?2sKeUeRsasvKGKtTNj1AuzsqRBX0y2ru77GRDXTYWUQI+Jo+AO6Yu7rqzy?=
 =?iso-8859-1?Q?W2wCV6w8InZjkLiw5UzJQOBkklFgWN+6+6UMIYLLudlDhI6dlD/u3Oz58p?=
 =?iso-8859-1?Q?UVhk33pMkhChC7/VWZYK60+OBLfnFgGHIfWh07f1Zp+gFyHe2jyk6VXWQt?=
 =?iso-8859-1?Q?OI16awI9kEP62NDrX31PUUfGjNDuiakvB3woVFy6d4byuM+vySFr9sLIh8?=
 =?iso-8859-1?Q?A9OC+X0BXzTyF7oIvxJc1kUTwbW6raFSjw83CptAOknTzjJN8PKJa9Jpyd?=
 =?iso-8859-1?Q?7/LpEjSJmPDY1d/2lNpyyIodSlLZCUi/tEbuw+qRZTgzllf/5O8KPws+wc?=
 =?iso-8859-1?Q?Ko5uyo71CD3jwxvUresBcApZ3aSfPw89SfHnUHXKU9UwBtQ/dot+1VunW2?=
 =?iso-8859-1?Q?hpuLo6Z6HdkHUvm6UGGrZkg17w1WKUxeNJ+Iwp/syzarnBrD/dYxJz0TVs?=
 =?iso-8859-1?Q?wN8eSjJEIO2c1P3ZLvGyVktBvoHGQol8/z9m4IhZtm5lzqYymz/xEkOxnk?=
 =?iso-8859-1?Q?233+bgS+KF5D2kNLv+bQNlkJ8P88PUj/Zvy9ejV4QZUAdzAxp17hyp0/E1?=
 =?iso-8859-1?Q?ExMPHvnijkKeyvgH3XzQlWYH9rnFX0CrnzAyw/1WS4axwb0nLpNRhCG7cP?=
 =?iso-8859-1?Q?mW3v/YFjSdKPMNLtFudT9hkCi41VBXOfqv8R+68LvE0rt44oTPD0Ueac7R?=
 =?iso-8859-1?Q?Ewb24DpQLRre73SZDunKH+gh1X5yhSsYXLTkm4i3LLUOiNwKkHgW556UwP?=
 =?iso-8859-1?Q?5Z8IxKLceAiMg9x4hGlnxhvhF/KJ1pJd6z0HkSjKs3wtO8npe4KtELoHK7?=
 =?iso-8859-1?Q?U/0MhCxwVpBIKPP0iRj38/InZ4GK8oQI858/uB6S+WvMeNclMoe4mukdyy?=
 =?iso-8859-1?Q?TjUPcT48BSERbWT23O6/ta3jWhpij5hBXa5x3lFdLOJzZMe9wuS+TjRldE?=
 =?iso-8859-1?Q?0AhNYG8stGFvvSwIEWp5vdqcOOujzQew510l7+T3GrrAXPlV1vsqKi9W66?=
 =?iso-8859-1?Q?gu5hlNgkJVdS9cFSpHeaqITF033rNXEmrKI/Q/c/1qStKpg7GwIfYUpiTl?=
 =?iso-8859-1?Q?0ck3i+SwLYclDqFgcz3dCbW2JHIFnSYgPPTmp/nkrZL/4fHoItesSqYc7k?=
 =?iso-8859-1?Q?IeNHjFrmEFpMh3LsHH3i3Fqsk5kK+qraZSl2IFTZI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c368cc-ef54-458d-e731-08dda40ce606
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:26.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFFC37E0415

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +-
 imap-send.c                    | 82 +++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 29b998d5ff..7c8b2dcce4 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server=
.
 	If Git was built with the NO_CURL option, or if your curl version is olde=
r
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
-	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
+	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMA=
P
 	plaintext `LOGIN` command.
diff --git a/imap-send.c b/imap-send.c
index 829e957abd..38f09f1f02 100644
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
@@ -150,6 +151,7 @@ static const char *cap_list[] =3D {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=3DPLAIN",
 	"AUTH=3DCRAM-MD5",
 	"AUTH=3DOAUTHBEARER",
 	"AUTH=3DXOAUTH2",
@@ -851,6 +853,41 @@ static char hexchar(unsigned int b)
 }
=20
 #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
+static char *plain_base64(const char *user, const char *pass)
+{
+	int user_len =3D strlen(user);
+	int pass_len =3D strlen(pass);
+	int raw_len =3D 1 + user_len + 1 + pass_len;
+	int b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the PLAIN string
+	 *
+	 * The username and password are combined to one string and base64 encode=
d.
+	 * "\0user\0pass"
+	 *
+	 * The method has been described in RFC4616.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc4616
+	 */
+	raw =3D xmallocz(raw_len);
+	raw[0] =3D '\0';
+	memcpy(raw + 1, user, user_len);
+	raw[1 + user_len] =3D '\0';
+	memcpy(raw + 2 + user_len, pass, pass_len);
+
+	b64 =3D xmallocz(ENCODED_SIZE(raw_len));
+	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, r=
aw_len);
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 static char *cram(const char *challenge_64, const char *user, const char *=
pass)
 {
 	int i, resp_len, encoded_len, decoded_len;
@@ -951,6 +988,26 @@ static char *xoauth2_base64(const char *user, const ch=
ar *access_token)
 	return b64;
 }
=20
+static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 =3D plain_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("PLAIN: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret =3D socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret !=3D (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending PLAIN response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNU=
SED)
 {
 	int ret;
@@ -1001,6 +1058,7 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
=20
+#define auth_plain NULL
 #define auth_oauthbearer NULL
 #define auth_xoauth2 NULL
=20
@@ -1198,7 +1256,29 @@ static struct imap_store *imap_open_store(struct ima=
p_server_conf *srvc, const c
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
=20
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (!CAP(AUTH_PLAIN)) {
+					fprintf(stderr, "You specified "
+						"PLAIN as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "You are trying to use PLAIN authentication mechanism =
"
+					"with OpenSSL library, but its support has not been compiled in.");
+				goto bail;
+				#endif
+
+				/* PLAIN */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont =3D auth_plain;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") !=3D RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (!CAP(AUTH_CRAM_MD5)) {
 					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
--=20
2.49.0.639.gf77f2423e1

