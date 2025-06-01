Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3081A3154
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767145; cv=fail; b=M1WAAKmiO2ntUGE6tn60oAMz9f2+7xig6NzxIQHlWucrwzSsADS79XfM8lGDBBGhOSfdk2JEXd7shHLPrZsfMDWeG2v1Uasm7ceZGBEFvLsKEGRSkx0VFtR7QZYacYAPeJuzmbA8bGVGB3UKDp0MV1Lw3pPgjMAlGMq+Mcs/E0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767145; c=relaxed/simple;
	bh=PdLJyKFQI0+zvMd3XPcgDp7maAVrlil5QAjs+RCxrk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfsfB/csUKkqWgAsXZsC7opN40Ry1H7m6fzNvM54qE7Ke7va+q66SQewLTMNHMucncZI2dH5OIc/Bn+X7rxecXg6fZPTsBl5O62weHcOIavMr0K3AmWeDYS6IKIN3+l7xf0xinkv19cR9wfiLQ/8nNiwIiWlrjWwa/+6otlu2zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Sa3giCsj; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Sa3giCsj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6hNBaoWA/yVjPvfIFnATgUAbpowjPsOoUuIWHZ5KJMBsekSIum87p5RqnkVNo9v6H4wb2uQwv39DFIi6ZB0ZJBYbhhvPN8oi6XNHUQcgg0np0GLepLaAaeeDRrbtXQG1s7uI7UcXYhEOX3HQjtwtOX+WuRyB/PZldFDIDrCIXDMOS5VN2FUE+W4NLfD7yuMvjOYcgjXEmmYK8qZbzglyWCFCAbF1WKOssFlfdRe6+CU6EsnPQ4hO4NB+QuL+Ad7Q+T4OYRgoARZjh8VGLS7JCWl+jrpMUePY39bMtBe7gnCWsWhyf6gJiEjGArJrmYiB01ewAm0jMw94XyEAYW/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LDiZnbRGFSI61epcfL9AbkSAevFyhPk/jXFQgzBM+M=;
 b=fyNHR4BTwRn9KVzyxLKXsdXULUIRlTW+tMsbnJj4MKcXWCVyYqF8Aunxz8QDGFUKVQm22RXnpn9ue/E2YAv1gR+EmYk2BjOJ8bWIMMk90NbuhbS3s5766WVd9AB4pSGDr5LD44NISJWq8mfZdVRh1zdoOzzm7/uHQqqbVMzI4qV9vNsnYK2ugHmJaUlNZEePwpIY3FysHHLtkhHkwsWEQt5uiyaQIgj7pHAStwHrX6ZnB+JtIaUPKRDKDojWveaVtCBW80jl5D+ZZDvHHqfYMmgiDHkGRVAbm3DMm6iJA5uUQrmHEeI8rS2NDeximKbcE6hoeWOmWuHAKT02+sLHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LDiZnbRGFSI61epcfL9AbkSAevFyhPk/jXFQgzBM+M=;
 b=Sa3giCsjVkllxl20xOTWrNOGDrH1OnDH7DZjXpzKIuIc9dgv3ubli0E1aWeufd+8Tmehc483ikhbJOfaPOS1kcURYx0hDVRdbLgev+NaivLItwMNYH+4g6P8Tch/LZYtjJnxQztZ/eYsVoXUouoqjWxr6vq7zm/vknoHkB4PTxXny23mQOjW28QJ60d4we72OzpOSyp5EgAWvGV6iNmSkfytXL4e+rxs4rMbNiXTw4JmV2FLxzmVxMhQneh24hEj5YcgSP6fuT79ODI5vtV7ZIyRRlF7tYqaWn9hzSntA1Y2crGQ5A7pj6zqRHhBZXV8tgigwrHX8LOvoEJagS1WSA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6304.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sun, 1 Jun
 2025 08:38:53 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:53 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 3/9] imap-send: add PLAIN authentication method to OpenSSL
Thread-Topic: [PATCH v11 3/9] imap-send: add PLAIN authentication method to
 OpenSSL
Thread-Index: AQHb0tCaO1p5+hstIUCR6JHCq6tqVg==
Date: Sun, 1 Jun 2025 08:38:52 +0000
Message-ID: <20250601083821.2440110-4-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250601083821.2440110-1-gargaditya08@live.com>
In-Reply-To: <20250601083821.2440110-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6304:EE_
x-ms-office365-filtering-correlation-id: c9ef5e6f-6639-4b1c-42bc-08dda0e7bd63
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|8062599006|8060799009|15080799009|19110799006|1602099012|3412199025|4302099013|440099028|102099032|10035399007|19111999003|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tDnuPpUL35Thk1lYNx0zLEI95ikxKsqAT7AjKjUZt5vzGJymuK7RdkdK7A?=
 =?iso-8859-1?Q?VUYAQPbkepE8vVj8zXHZ89PDDL6L2vUNkqXNoTxqjhbeT9Z7e2GOq9EQPz?=
 =?iso-8859-1?Q?m8ciKOqUesRG8GoEeiBqMRwDJMMpzA8fLfloZOqjG0l+tcBimcMRkejONd?=
 =?iso-8859-1?Q?49P3FB96EcOkVj1EOQ0TbpRqUDIyeZYJwXOftjyP6FIznNoya0D0a9cdla?=
 =?iso-8859-1?Q?fHI+BmIypUBXgaqz12n7xANFGcPDNAhYUwNPSR48Qp/yykzI2TbxkB4Uef?=
 =?iso-8859-1?Q?D3+VZP4XT2kOCmGUqnKjmRc9qppY36l6I425prTmyt+YfXR7+V0MbQGVC7?=
 =?iso-8859-1?Q?auxwUr6AbllLkiuhNRlbG8JnOKu2iK6a+wPuEtkZAlv8FygQt/8umJmSAA?=
 =?iso-8859-1?Q?0rsIGUt2VVCLqrCnkSVlwXYmp6J+ZzUvyHvGd6KEehRsrb3yYMf0VVJHrf?=
 =?iso-8859-1?Q?3uuhDang3mXz6ZIdQplGajpnpviVC6JeTZdDOpwwldP9bsFkNsmvrgwg4U?=
 =?iso-8859-1?Q?WH9Wjw8Fwbn0mtmT8MDmf4QI3kx2U5ypAQcXcGp9rvuedTrO3nYve4UjEt?=
 =?iso-8859-1?Q?zt5e+M+gQ2JPzsRQl7n4aT5Kzn2kr2Vl20Vp4AbDTYiqZFWAIS0TazPQC8?=
 =?iso-8859-1?Q?WO0+g2CD3Z0WDbojDwdROcJ9vAXxANjKDROfrhwFOxURJ5spvXCmjDuq6N?=
 =?iso-8859-1?Q?cAl2oFkkhVvESz3Q/f9lqfzcAwV7zB2g2p28M17MNMtv0JS8aAHJsfFqOL?=
 =?iso-8859-1?Q?/ek6rV8ebmcno07KGf3XqAhE28EyCIGnGhs9qasgof0oA003bITJskVttn?=
 =?iso-8859-1?Q?pEQX9rp+orjGpxm26l/CfaMYd7LRU84wTFV4RZA0xrxFJ6+GS6AY1WhsmS?=
 =?iso-8859-1?Q?oy9+5bYJQpMFOD9BGJuLXls8kwk8ql3G4XcmMGpsrBnroKQlBsAAoSb/1t?=
 =?iso-8859-1?Q?Cb7i8wKVcvcV7weCf2sCKUq+hYqREH3igR88bbgSaUnqp0rBek/KiGDEDA?=
 =?iso-8859-1?Q?SxES61XfnJijTmu5X9XHbwZlN1ErU6UOAGJ8ZCgTl+kvlm1JvbayGGLmaP?=
 =?iso-8859-1?Q?1Hrvf3YCcUbhBB//CY/w4bTB3rlBwybkKEPSyzDLN4dgsLlF+GFaJaTuWQ?=
 =?iso-8859-1?Q?59p2nXcbYV/yZNINf22mMzarU8Xrh/bJIzQ02wYHddNGi+sP0xtVfrxRAv?=
 =?iso-8859-1?Q?Iz0Cb6CootUOXAF2YQQUvhvM6aMMRGks3usALJ1C3hJOrgAjXAQR5gLZ7a?=
 =?iso-8859-1?Q?DboV59YzZo06pCNXTRPkTx91oEr7CHqSXUyTvn1JrSWibHQg4Eacwq8QXh?=
 =?iso-8859-1?Q?Ll3XjQmPJmOSoIXeg0l+S5wAXYaafyRw1WjPURGCXwa7bPzmY+ijzrim4U?=
 =?iso-8859-1?Q?JaWzkKE4IWcbyzmnj/eiC9FKBPkxVDl/PWhnSSIp7PADsd4vBOwU7W+0q+?=
 =?iso-8859-1?Q?s85iX8vOTM7DP6tcYtqtPizFG8FaJP5bxVU+4w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pc98eEW+4uTYgiu5urDNiPAsZqFgIIGir+k20Av6xBB+NFOjmnumY6Mpc2?=
 =?iso-8859-1?Q?ONEcUZqnb5+J3K96ggjE3H15NtHQWn8dSwEoJIgr0qP+hGbtO4Mf6mykSh?=
 =?iso-8859-1?Q?IhY/jkvwXL2WO1xXuaepG4hJl66XDo46jj58TZpvQssH+A49bw24FIETyH?=
 =?iso-8859-1?Q?TuaSWJPPRmMtURpZmr7i6baD0nfWl/nVGiiwdAufXolkDD1YDlYOPoBBKY?=
 =?iso-8859-1?Q?R1dwDgfUMfxQ9fTUyToklCL8QshfuZHSoDG0JPr/Lc0YYh+nVclgEBWQ6h?=
 =?iso-8859-1?Q?7qLjH12tzurJuhegikXks7+p+XETvrJc7trqREYBsL0csXUE7MHJy07Ni1?=
 =?iso-8859-1?Q?U/n3uB4IJoM2VWGL5ADyKyzOdHjKEkw9auIPFwN15XTOiwD5qn6+W/K62E?=
 =?iso-8859-1?Q?zQ0BHaCAz87YqfGByil5XCWvpD43FI83hfz3mbQTmsmDPFA73uTfTCsrGa?=
 =?iso-8859-1?Q?CY1s20/Bnb8p/STgqGu/ZG0QQpeEvsq5Vtz+Z2I8iPXpm1Sw5Ain/aYQ7v?=
 =?iso-8859-1?Q?/N/RjmAOb2ZHVLI2PeMagsIck4ctK3NEDTg9wKDTRQG4oboMFpLZt6E7Rh?=
 =?iso-8859-1?Q?wt/3OTpgl/UhYEpPTxZtaXrP/iiCgLU3EFG4VHJgw9Ye2Pm/DfUS/FCvMr?=
 =?iso-8859-1?Q?YVyEjHOrXXO0ZH/rxpJO8jdnI1y/XlcrE6PrAqBdHifRc03vaxARCrZ2nG?=
 =?iso-8859-1?Q?vDvsjLvhS38cj6NrxcR4NZ7zNDwQ+q4D2km6VHV/sePFfwWQ60apWw3eAC?=
 =?iso-8859-1?Q?bYg/wheigMmCoP3onvRFkZ4dBLJH+K9KcWaI9dT8ea0hjByMPqxhNvbDM/?=
 =?iso-8859-1?Q?e9DPVVIIUsj6PisB3/T3YiAIg9uNk6NX3OfN1iUZmqRVU/A32nv/Ub0ZZn?=
 =?iso-8859-1?Q?4qIJ+Xa5QCquex9u0c4mvkm2129MGpZgSjX7HL6w3WK/+a8A5PVPpB8aWa?=
 =?iso-8859-1?Q?R+ZD65510PlsLeY3ApoElmsShcAXHLKZ2CHs381Fvo0nJri7OVAMDKHYKa?=
 =?iso-8859-1?Q?lDg9xSNPOtXsWosbpxg4Aqe6ekndApDqFyIKVbIQ/ALPL4smlLOT+yh15b?=
 =?iso-8859-1?Q?vxdgx7MbtTbIba7ysE/D3695/6536Od/UPgrtQ3TRRTAA4SEkEz0Qw651M?=
 =?iso-8859-1?Q?QxCk6TpVSx6FkIDG2aaQ66GO7cWzhdoixihgNRDJDhgImsLLiEWT78xJ8t?=
 =?iso-8859-1?Q?iCtO3GG2oC9tUZ4HBRmyJzpb9zEq78qfDNlVkkeFagRsTw3E4d/zsE37du?=
 =?iso-8859-1?Q?RwiRbxt92+XAKOqFNLyMxzfIgtO5TL8lLIql540wk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ef5e6f-6639-4b1c-42bc-08dda0e7bd63
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:52.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6304

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +-
 imap-send.c                    | 81 +++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index fef6487293..24e88228d0 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server=
.
 	If Git was built with the NO_CURL option, or if your curl version is olde=
r
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
-	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are 'PLAIN', 'CRAM-MD5', 'OAUTHBEARER'
+	and 'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMA=
P
 	plaintext LOGIN command.
diff --git a/imap-send.c b/imap-send.c
index 4f3a1fb5b1..bc26abd150 100644
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
@@ -953,6 +990,13 @@ static char *xoauth2_base64(const char *user, const ch=
ar *access_token)
=20
 #else
=20
+static char *plain_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use PLAIN authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
 static char *cram(const char *challenge_64 UNUSED,
 		  const char *user UNUSED,
 		  const char *pass UNUSED)
@@ -977,6 +1021,26 @@ static char *xoauth2_base64(const char *user UNUSED,
=20
 #endif
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
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -1209,7 +1273,22 @@ static struct imap_store *imap_open_store(struct ima=
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
2.49.0.638.g5e24c6cde8

