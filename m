Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E429221D82
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500623; cv=fail; b=eBgSoUd6vyU15ZW+jHNH5kjPdq1Skht15LbcGiTwVmUvisTaNdo2e6Hlw/MMeFgEjMfZntTbuKobw3c2QfDBkt+RWQrzuWbUcpo+NXo8G5sggPed4a9gsrnREgdLQJOIgWhBzf3xGE7GsdJisZkq/y2BowsP5Uohho+M+fPcRG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500623; c=relaxed/simple;
	bh=YLVDRQczcaXAsR8ftn2BMqYf4dDv4XqF2/HEWOFdVRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LMBM+5+DorlOjpL5i3YuMn7yI94OuwbbDwbQG12XI0k/vz004mskh/ESnVb5rlu2CWRuDfH+W0HmSYQtEU8N0IDkQFlMYLiBu04F1YJk+JmnIMqCNoqLZmviq1aQzBVxTQLojYhK8WF4cazKrJOdtVlMSd9I2a1B0VHF3CO5XfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=roolsWY2; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="roolsWY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPIwVb7nJWF88D5qOcjOxapaCUH6l3uFnExb9oXmu0fjUb0Z6i0STDLLWsLvz/6GvYJhOE52hHgPkA/B5Ug3PAOsrGvES9FErQl61jykqNqmluHGTaIhGRzXviwlig8moLXc+yph2grRqLZ6VsS0OmyYx9gI3fqx644+w2PbRyBXb5Qzd6DYBNMoNn1QhS/5A9rYd+OFICngjNhz6KJ1L2Am6L1gKCXv47MKMoKlMXo6zuNzcA5r4we3gsw458yuheZV5GG3Ky9q8aUpJV8wu1eTh3aFNrpVKNxkm8zof3sR+4kWwRfnoZKOqOSNdr8R39dS+b//+FppVWuqtHdBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1fbUGr+qDf9QFvhxV/cSpE6x8h8pZ3SM87F1em24EU=;
 b=ZAQZ5mljRqtupdQCn2IS1yM2rj7M3I3eADka+MrFUQDWY/boKV2kAR+MTxJyewJFWBTNx7mvOkGNayOqrBkuJFdAoL+9uoeuA/vRGJ0QSdD9Mt5K9BfrZsK9buuWBDgnty4A4BskLOqp3UwZWzF1L/5BtWfvWITn6ygY186vEFal7CoVbau5tEknBz5Z4NyrnKllr0BDvsDFWUERFtkX03PpG2cMbXv/fzMVcJNTJgjAbZcRis0IFDcWLBnL2YHlqVNTSWqdMHlZ8hErTIBHfvYnqy68E+onZfo2vbJoThHh+joOxNCxs923JE1wTef7BpVf5Dsi0uO2EY7JPC7yRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1fbUGr+qDf9QFvhxV/cSpE6x8h8pZ3SM87F1em24EU=;
 b=roolsWY2/UQmHpQE0Y04ZXGk9qd1g9nVm1MhNfkyxgCYe/gJeDTcbVi/O+6ooGjjtR2wGIlXbQ8n6M9qAGgvvK8h27SC9Lv0pyBogOop490DPizMHooTh21rdKd5rx5yjBZm54u9i+lI5pkzCBmVL843IjFYe0UIne6jrf8UPKZ5eHkUpifYz3Z7Sg9O3UBkms2G1dp0BGKexP5SLE7M/beaddQK92xHVVKQunBSRHE95aRAxD28Ke2tcaBrvn48sVfb+crQBcfZVfvEZLCwiANoPxdvE399VN7W2ntBcKGE0sWDQjIr4Ih8EJFNqrDlrTPgvekm4vAJH45JrARvtg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 05/10] imap-send: add PLAIN authentication method to OpenSSL
Date: Mon,  9 Jun 2025 20:22:50 +0000
Message-ID:
 <PN3PR01MB959718E5A5AD5F9A577DA66FB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: f7069403-9964-44a9-874f-08dda7937e06
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|4302099013|440099028|3412199025|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?di72bSvpzrYqJAh5MW2R7FcvzLY2ShBc1zsCMhqrljRdYnf5MAyr8y9Rbu3y?=
 =?us-ascii?Q?yNzwzIsBouKlZCRY8tCD64lHYGz1IMCBtrazSdogyIubrcq5RN3RQaVwYtDj?=
 =?us-ascii?Q?dsrBqwemDCK/qIRoF7GAO7vyNNajmgEkoaXT6nnYcJllbMgpkOvSbRV55DGt?=
 =?us-ascii?Q?qROIVQAaHY6zvUwiNKwkNK4u44StZwcyqO97PYzZpKVER2qjonsS/QaHJcEp?=
 =?us-ascii?Q?EGLjY7Nsr+wiqG19bfE2wtfWbm6z0SOZupaSN9/5kk7U78YQBWpDH/F0scQC?=
 =?us-ascii?Q?a3Q46gXMUv0AnkkbozNJSfx79GTdmGAA71Gh/8S/0bDfRdwmzqeHRcvwYNxZ?=
 =?us-ascii?Q?9nk3SlyCmsX3plzggV9yy3xS2g0Jv1XV2PBJ7qEQaKlvaD/QYYGXaUTblfOI?=
 =?us-ascii?Q?se/2iUVMJiJsAWes82u8/dOh8BRy8nFKw2bm8vQavHwoNNxysY87ITmOoVcy?=
 =?us-ascii?Q?lEtwVeeHCNhztwXDHIsHbvss5odBSNqPK4Zxhg1OLDqF67KObkkADEbcba0r?=
 =?us-ascii?Q?JwFv+X04rCdZdv4La7q79pl9+9mRZ4xCQST8TOwe0PZ+L3cc07xb4Xx3z5K9?=
 =?us-ascii?Q?iwN2EXc+8y/p0dVT09or3Ney0BU2F4QKKUeKmbVnwLXNPhZk0VksRE55W8/V?=
 =?us-ascii?Q?7PCD6mbYESh59yI1QWCkWuAQk1NDTQoYqJhcBoNZVDBXsGv7KWkAOzHWHiHy?=
 =?us-ascii?Q?AAHD9b8lGss34dwNjej8ydDwoPu2DT/8FcaHQ7l/iaWajfZXp9j4RLlNWqfx?=
 =?us-ascii?Q?2YvXqamn51+1rQu19gl+jY+tRrfLrHdHsuE3G8T8jeewb7LBeQ0k1VYxHqEj?=
 =?us-ascii?Q?xMs+cYCcxpnsLXJ/r2VRW8R3WLsAl+UG9yL5c7/RtojKuBF5/+FTe5FCK3ak?=
 =?us-ascii?Q?GJhRcdUw+Hlyc9ZQj2zhuy1jtqflY+Ep00b1v8XW4wkxSohNR2o2+F+f7AAm?=
 =?us-ascii?Q?ekUbcwtbvojeYxjYxEHXpodtU1iAmXMFeBoi/aTUcjcTuB6hg+zEt6MEwAJ9?=
 =?us-ascii?Q?D0LamP2nXFcYxh7ktqAQWyFwEMHJtxD+XJqtnwcgWHpW8vyM5hEPrNJsNQ+w?=
 =?us-ascii?Q?2Ab5oi2Wsf1h8t2UhHlWuPGBungkR0flk2QE6IvbRwSru+ltAPgZnjauUGxy?=
 =?us-ascii?Q?jre6/ub1i1kv+iMvTigKV9RWedrt4VL8TnPiovBynEKiYhy+J9VlFKiENtDN?=
 =?us-ascii?Q?tyt08XfR60fopUVlrXugmyuI5yrwLWmXpkooUYc88ShDGkvF5aoYFNY02P8k?=
 =?us-ascii?Q?QjSCroPKBfXRfwoZ60Jw59KoD/oi//CRkoBDr3nnKDFpLeslJ0uLVPE0tBZS?=
 =?us-ascii?Q?45uMzi84rnctJJZ+0fOEJWgzpGi0K7NF7tD8qUjuq4d16x9Nxb6mWOFg0vcz?=
 =?us-ascii?Q?wy9nw4YQboq24pFOpnlgM6KpvzOO8MVdIOF1l5GwE1/5DvqpDA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gS37IUsuwC0umr4J8wlZfJTE5Dm2zvQotApYQ0yPbS1nVY/BMX+80KnZkqu?=
 =?us-ascii?Q?+UVB5YPdxvporxJSKakKNK3mJ632GKTIldMc0/X8mOMc5e4Zf2yLZjA/GGDh?=
 =?us-ascii?Q?9KTt3AAgy5psFpy/dbSpFLB+4/GnXokkKHiAqZs53UO9o4iiOOWFnllm/kNs?=
 =?us-ascii?Q?TfiB4cu7MndnNHdoVQ0KHo95bV5mMWewMLvpb+VMpVUSGVmMMAotmIcIyj6y?=
 =?us-ascii?Q?/cjR6VQAxPVWufOzD22E8xbAIzzmFGdgvR6uwA7Snveldg8oft8CnulXTo9G?=
 =?us-ascii?Q?VKedpWeOibbOLRoQIYmcWPzE1kPh8pUrAxrSecZgeVml/5bKYjq4MPcfCHyB?=
 =?us-ascii?Q?t9vTYT3rYuE5jDhpkZ1YBwbk8ZGIs5Das3Z+oimm2MZSu0B3RoWyXyvL/zot?=
 =?us-ascii?Q?d/Vp+6kmkyx1gF06p/c60rjx61F6n2rZIhJloXmBwZAbqwd9rq/D9F2+hnD6?=
 =?us-ascii?Q?0Uqck/ETwEQKZ4Uu0ldIfjw0ijgIcoT+Al3zR4RkxGyXWmR7xl1Nw/9piBqu?=
 =?us-ascii?Q?F8iJSR64g+bD5NGq5xuloHkWMnlThQ22egIHo2xxm17I2O4U9Pslr6UlWF10?=
 =?us-ascii?Q?IHygBbe+RM1+JL7ZesKFAHP+UN3FRdWLZt8cRvpUxHQDXSla4n07IsgLTnhL?=
 =?us-ascii?Q?5QSfXSmAadQYPKRsRS1koaN/VVluKsX+/WQo32q11hYbHj/t7UGTlAEhJDp4?=
 =?us-ascii?Q?Z/7W7w2UUbcYZfrRf7eIWmZhu0+lLjulqsUXQeGAb3SkTr8VLvejmyRJR8X9?=
 =?us-ascii?Q?NHx/q+2S0hLSVINVFI7dolT7zBLsetppWBXeeSYt7wPNJIeMTrZvvvWzTtrG?=
 =?us-ascii?Q?p6x/pj2Xfl8JwL5f6eaojVfrySDS37H/U0fe01/D8yGnMb3Ec14tZwO+WIP+?=
 =?us-ascii?Q?XFFiKGq+qSwL9h6M+8BRYZWt+o6HH6MS56Istkg2HaN7jCMB2maIuHPutvs4?=
 =?us-ascii?Q?FnrKoagCL6f1I9R4Cd9lbMCZ8MZhsvTrtH2r7kCkQSsaSoOSyuVRwNbXDcKQ?=
 =?us-ascii?Q?2WCAVynHjL7wc1U2gPXPfGV26ND7GsMmnzsoa3agInjacL3xlgV0TMP4x2OO?=
 =?us-ascii?Q?0LGLdZT6JekKZ0a9CFk44GO5WzNsbcQambO4QHb2rfSBr1t2fQ1K3Z/jSgMZ?=
 =?us-ascii?Q?6/kBRDcL3MjLIPhHPmv5Uh5JgZe43BVDRw8Sm8XRoZaD/NOF7LLIFrCe9K3V?=
 =?us-ascii?Q?uLq1C5U2Cp1nD/GlFSQK3NSZbDUOOoMBdnVCv5Az60D3ySAE0VFo+tXsRF8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7069403-9964-44a9-874f-08dda7937e06
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:27.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

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
index 24eab86a1a..64f66ec67d 100644
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

