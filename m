Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC920B1F7
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199308; cv=fail; b=Slwx37wecj+yl36iGFokQOJTQnHe7ktos/xl8ZKLadR8BJbSljUF86bTdGumL46Q09GCYKxAi7HFklYbW/PDGpp5h3Kzz/o8Kq/vdRJfPv3U6lTbpq8zGpyyzjclL8ZnYx0737wMJqHFRk3kQ6iJ5kYPsTKYdi7oEyzhV2VLwxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199308; c=relaxed/simple;
	bh=PvhBmLOu8O4GNNRFsDqjuFPFlTUL5TYIdhC6QJWsmRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnoSMJQp1MtPkHYrYu1H6mHnz40m0qJvp5IpyWYkRnKPGqs8l3nb6qOic3NQMiKlysvv+FDFpVp74PCJn/Uz5z+K5oq4hHUrqb9zDKbXEjnqzpxQjro4TC4/uVd9AKmTEqSlAZU2xExVRrSCO/CiCRtjVJJWGmm/f720Rk9xvfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=teECUQKw; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="teECUQKw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvsDnjT3go7wCd1fy77UBMv66CIjeCuOIlAhcfNqTnWwXOzapVMqlKksFXJttSjvfuhmfJR8Hwjmw8PsyPWVBo1xXZe+fdHsJNS1fkpEYy6Sf7a+TEVoHRIjHQ2s6Zw/4UsluYndihw4TwpGEtpimZmV+SNud4Y1imAYgjAhc/susj0mz5UZDYSDVaALJz6sXmqQCMSHU7//5mCVXW2DVNO7ygheozEU/o2ebT79fyPbGMHipWDn5PoJ5UqEHVBQD91Vy/5u4E+QnLO67e7OIfcV5E0QIicfy+cKVUv1T6nfRRnCi5Lp7ZV5lPNRz2eJ6Mmctsa9w+rAfe1lf2fPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U083B8Mnuvp36Ri3sJkXSjmMJD9lB//jajN34y4DJCc=;
 b=Z9oKmkLyvoveLlyazu1SXIsRxPc1GDRqq73s5L46Jn0Nveqmpwz2Razuel6YNY4G7ViSb0Ir9A/IffwJaJTYLTeCnlHTXL8w/61h5p2HzCw28EDbEEj5ESYJ0ThEcIa/ZcGGshxfD9XUnN+Rd+bgGPYl7Ar5YBQv+B0J5Ckiuz7HpL46kJxtYs/FJB8W/tKRMl0b65YYol/7kObY84fcsSRbkogsjZPnOBWfpY2VUpZlgnAtdz2X9OCQoUbkK/E8gBvO7W2QDhdKipbDadlX47S1FN1VVRlsJKqANt2LQF4YfzowFCFRNRifFKapcvyr1ELKABsuZqP1486lvc7k7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U083B8Mnuvp36Ri3sJkXSjmMJD9lB//jajN34y4DJCc=;
 b=teECUQKwiFam15o5xJmMF3xLD6zHbYNE1KWlgfPVLuf5XDP4C+NZD8JOMJ6GA9Hm3wowzgKbBA4V2ESJGWccKuxB5c6eH1xoR49lQtQTXGEnOrzm3n5JhsPII6AewI/Nf9/hxsjGgm8w0bZl7mK0gg14u+fuhuJaSliJI16gfOxyNo+wwN2GuxbEMApPvIVFAx1n9xSHHptinKSmAREyDb55jM4qy6K03U7xynNZFZk4Dc+uHSXC6+6h8dijymFGT9mzJaMytq7esoBSXgUpg9+9azKg2nMtxqgfn76LHHoIsjsvkjy190GVWR0IAeioevPk0ASLOy5IL39S/nsi/Q==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 18:54:59 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 18:54:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>
Subject: [PATCH v5 3/6] imap-send: add PLAIN authentication method to OpenSSL
Thread-Topic: [PATCH v5 3/6] imap-send: add PLAIN authentication method to
 OpenSSL
Thread-Index: AQHbzaaDlmWbsNp8K0K1+L8LqzPl9A==
Date: Sun, 25 May 2025 18:54:59 +0000
Message-ID: <20250525185447.29982-4-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250525185447.29982-1-gargaditya08@live.com>
In-Reply-To: <20250525185447.29982-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|PN3PR01MB10362:EE_
x-ms-office365-filtering-correlation-id: e13cac58-e125-467b-25a4-08dd9bbda624
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|461199028|7092599006|38102599003|15080799009|19110799006|41001999006|12091999003|19111999003|1602099012|4302099013|440099028|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0g18XRxxtCX+KbhO5GmaKko73G/WbqrsTqHS5Wuq1kLxVGjWmu/A5mmsVL?=
 =?iso-8859-1?Q?ldkwCyFrUxi6Y+wqBK5RAMURQMfvtLo/ZOwYWT/eafhfTQMTy6CU7sd0dK?=
 =?iso-8859-1?Q?YVZ7IykiX4ZDVIeXtG2xGD1iAkVZBv6XL/9PPVAVjDxHtxiz5fOozYg1J6?=
 =?iso-8859-1?Q?EZlv5SkUeXI0h8MMlM9K4NnCDJrEJp+KK9/CjeZmplw2uAYJympXkYbpv7?=
 =?iso-8859-1?Q?I7X7kjk6MyvGDE3AU87OYdGznoFwB5i/380CywAuYtHv+FDnNK8r3nTRvh?=
 =?iso-8859-1?Q?u/oHuIvyHG+Tal3OzH/91kp9qSpcyO6TrXu6GACJtgE9qeun3R+8w7HvPO?=
 =?iso-8859-1?Q?WU9XMgDW/0/2566frhspbmiK/rg90M4CodaeLMNCMFuiOEyEdMJN56bMyv?=
 =?iso-8859-1?Q?m6G0Pmlm5Vl0Iq2iRqXF+21Hw+ij/Qw8nkNsrtAQRptP2csxbuM1YgSpuG?=
 =?iso-8859-1?Q?4N4ZECtLyz39B33Z5yf32D7taRYRnd8CfsPw3u3tcxl+dq2NP/jEWZN6SV?=
 =?iso-8859-1?Q?uIqTTN3D/OOWRBuvknEfln+8kvWbJaKAWGzzWjRH9D5rYG/5OZ508C/g5u?=
 =?iso-8859-1?Q?4yuyhrGBm+FUXeloB9uJRrafEKVhykw8huo5rxlvk1W0zWvGmDgqvzzAW6?=
 =?iso-8859-1?Q?YEi+gAw3AGvvYHCK/Xv/2Bowihj0RWyQwGILciOskxT0gR1+fZg8Ljs9Zx?=
 =?iso-8859-1?Q?Npv0GTxoOlCimdbeoEBJpLcFCGvTn7OFLjKk87UDNGtj5QqhswN/w6g1aw?=
 =?iso-8859-1?Q?/3Yt7+bvs+vmHprX2la+kVDDMBVwF7EWWvHfx3/i1Q1DUMFXXVeyykTxOI?=
 =?iso-8859-1?Q?CJISvHgdw92GBhPMznh5aBYfeXVOfnuwfzv4W8ZwOJt0lf/9AtjicLCJwc?=
 =?iso-8859-1?Q?n75H/TS12ml74O6c8dg7V0A9uu07eufyHcYX3OoBVHfruxUtzhjug7w1qN?=
 =?iso-8859-1?Q?jauAUwZ8+DRoUg5mGEwFsJGIgPZ+5ePWBjiuL6WDpyFLIfcrh1G+bjGrPq?=
 =?iso-8859-1?Q?ag/Gu+SWCX2fFxi8s22iYIOIPGO8ihOJi/xJwF3osBhCiC4TmJLv8X0oi8?=
 =?iso-8859-1?Q?qKw2FL9j41LCtS+laX+DZ+C1JvyQXGunzCWOB+V1SugXSw5yw/cYs9pWEb?=
 =?iso-8859-1?Q?TI21CN/yMaAKmnVPTrfVooKGg0MI/7FzzP1+7qeLAHy+OyXc00bcdEJR47?=
 =?iso-8859-1?Q?hhUahaCDieYaDwtUPtY9/zFaekpVqvH7v66kyPQMN9IIzntNuYa7EYmwbx?=
 =?iso-8859-1?Q?7XeMegbRvC2CFDo9VyzkPXITUt//MYxwWPGU0fGzfXmirx2WBqL3GfNYlB?=
 =?iso-8859-1?Q?9Uk/XGr463E83CcKXLWN6HMSJqoeV4VFHSlW+qVModyRS6uS5XCPllD3nl?=
 =?iso-8859-1?Q?yFWCG7kCNVFoRfl0C8f1XlQdq+77W8HfJ8pAoZpZ9yiB9PWaIfwN8/PYKp?=
 =?iso-8859-1?Q?yIUrxuihFWChLVpI9JGfImSCRpfwJyLZmZbU7w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/blgamGX436ke9T8UgSCGwC3bRPNcFtLHadvTO2SKAp0lgb4El3VpREQBP?=
 =?iso-8859-1?Q?rjj+lVGmoti16qWWyk1mleMcyXiQaHcNOERKE+K+nYaUxngdRx+DkYGKyY?=
 =?iso-8859-1?Q?0DvW1cbek/3+3KMsEJ1ihS7gfguxtK8KIL3elz/qZizRxahSHI32E30PFl?=
 =?iso-8859-1?Q?QUsR8AfsCfFj97gPxEvBgRXIyAo32f48C2wdQFDg+ybsFrKKf0JzHZ9HyC?=
 =?iso-8859-1?Q?QvBG6PV9vt+0JOdwAeUnezgYBPOnrQvNV67E8lzUQbCejcq2drOlTnnB77?=
 =?iso-8859-1?Q?4IXKlvJUYgUM+R16pG/Qs9dx51CKZRmAWSQ47gAglV6s0UvY42jlQlngKJ?=
 =?iso-8859-1?Q?J2TeKirEpj6sS8I5mQKiFKT1rJ4jriZH9REVTMP2WIeIeKqnMF4gPYRD8A?=
 =?iso-8859-1?Q?WiABmCrmmqDMwIq2QeTp3ABRPsVX893UrbCxmIe0C2dVxP25SlyjJu4I/u?=
 =?iso-8859-1?Q?LOITAVxU369jgkNWvKVawWpaIq4TVloTzPmFXjkrBC/sPpcvn4WrWPn0TR?=
 =?iso-8859-1?Q?ElaquaEuofOy5t037g5xMuaJF8kJLrVL++ywwiypYlFlgcxwXmy7geaXxC?=
 =?iso-8859-1?Q?YgmHTRIzQKUfDfzVSPQykB7VKeyUcPfxCZtrkxiZ/x+qEeVUUo9ZwAzuN7?=
 =?iso-8859-1?Q?D/IqdneQNpidHuaYWJCDXuwRvpbjiZsc+MLo+VyCH5qm2yTyOr2kBqGaep?=
 =?iso-8859-1?Q?1ecV0dMa5vycpMDzMzC4ejMyR2NEcyI3SRwW9Abc36Lopnxv1vhdzvWClx?=
 =?iso-8859-1?Q?F6PjjAT7LrL9H3cYaAGxr+gTQCmDl5KzS8uxKGbmXW2Cn4AedR/1OmYBFy?=
 =?iso-8859-1?Q?RmsR+BhgE2EgH2WsV2tmSrhU5BRBpcE+gwB6J2tbzvlrZ/9kbr61tWG3g2?=
 =?iso-8859-1?Q?UjwKnpr7Jvm3SCK1Eut455yYY2NXSV2VZRk33jg8DNIKBnQkYEVvWRIsae?=
 =?iso-8859-1?Q?ATFONIEEtqlKhP+aQTUc6hxLGE2hU+jbJpKc3BCxIPZqy0BaDSG1Yqyhzu?=
 =?iso-8859-1?Q?i9/aTflEFqFves14RdFq+Khvkga2rkxxKlnlAJHLo/mwXpTkhUtZaJFoFl?=
 =?iso-8859-1?Q?QTS3JTr5Wp3oWqMzbwt6DqUUj9ovinRSpwmUfeRH/O+Gz/CUiEJGS8env+?=
 =?iso-8859-1?Q?UGztTzWRfcLyyeCFBplUi4HbiuiSzqsku3vCW9on+nQrbV1IOOmZ38EEBY?=
 =?iso-8859-1?Q?TS9m3LFG4/WjL97kB/bnND+brUuDtKkzgLmliJUOG8NPxy/pcZIByy8bzK?=
 =?iso-8859-1?Q?V4yoqQ1OS6+xHk5lf0yjOpj0bU9KKLdGIP1mcRIRU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e13cac58-e125-467b-25a4-08dd9bbda624
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 18:54:59.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

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
@@ -150,6 +151,7 @@ static const char *cap_list[] =3D {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=3DPLAIN",
 	"AUTH=3DCRAM-MD5",
 	"AUTH=3DOAUTHBEARER",
 	"AUTH=3DXOAUTH2",
@@ -851,6 +853,40 @@ static char hexchar(unsigned int b)
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
+	/* Compose the PLAIN string
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
@@ -951,6 +987,13 @@ static char *xoauth2_base64(const char *user, const ch=
ar *access_token)
=20
 #else
=20
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
@@ -1207,7 +1270,22 @@ static struct imap_store *imap_open_store(struct ima=
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
2.43.0


