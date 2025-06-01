Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A617A305
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767142; cv=fail; b=Cx8mbR0VEXWES0tCqSdjcWBy0FZqKN1bK1S8H8odHe+wBmbyG1FttM1Fnd3c9YqMOcxZRcRrc41IEGEPEgzl7PhNST9bIC+tQEO0RV1BK+Oih0O9QW2gQDvieiGHwbt4sGGsoD5yisTNsN6wD6RdK4842TpNo3T/7mldy5xT2iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767142; c=relaxed/simple;
	bh=fSrCNtEXUhy9VfKD+IG9Rxcp1ardImFOQQpGq5gAm9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c5GWYuwGHnNMqf1U1jVz8ZvGNpGImwY2M2HxsKeYX3HPp72n6iqWcbGWmD0/eFagWvgvEzcoWOHzH7DgIL9lx5TEXgEGiGgKxrEZw7e+SR6LL75M5RSvFyAf1mxiRvaL3LcmVX9KwC7GrXCZJw0fGWuKU+X09Q0TEVBcnqu1xAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RJ4UJpFN; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RJ4UJpFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKdKcaBsXZIv70JxLABuO8Uw64vCuEs5QjSQaAAdZki8REbUzMSr7SEZi6d6v7ldHDO6pM3L1XhxPHYqWNyocILN2ak5+XyD6mHzFsAm/rwyxp1ZSf67eO+5WcRVm3hoQlkIDpuWbb6pBjCiihQ4gqiZsy171DzNf+oGhvCZuj/bMfvtt9Jew/bNZIlyCPr4hgjkx9SQZOhDZEjlKyvtb1JXps59KNTmmJ6Z7i3Tc9jB6+O0yCgnGw8q55/+6QnzP4VTCznxFueCE6tyvp1+3BUT66L236HjD1gulYTlk1LLIr+jIFHgc8hKkfcvOIsmgArlor2G5cuwHd63q1EpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7m1kyP1HFKpktgJ7l36WneORj4chuHZNSmSp1fwOlA=;
 b=luB4llx2lSlW7i5UDywV5SvwT00++DQaEAQt3D6IpxCnzGAWTXXaQvYtv6OJhq5sY1/usJ7YryEhwv/oGvA/Vloi3VfQ7PnVlnAwnrHsqgOtfJTEwkyfsSsCfe80LmPTiNJKHBqlYMr7bUqOTZfHaT9hLrtElvyMlUdeIPy7Eb1FwgzoHi+G2F3HmhbXSWm4NF7p65we7PrhIhX3ieSa1Aek8fy00x9QQje0IriHK5x+3izLY4Om4NmEJHxSP1dmCSru7xjgMdKo0VRGWMAAoVCSfWaN8QDKh9HOMIPDtZS5bXpxWjOUu9xvxRdztSa3OS1yL1YR9+LskihqNwEX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7m1kyP1HFKpktgJ7l36WneORj4chuHZNSmSp1fwOlA=;
 b=RJ4UJpFN8Chra4ZzmFw7ZpSpbaN/7zJPIUCIEFY8k4dOlAvSTJiFM3IQ9ZCSxaus+OV0cdNzYOr0Pedxq4Erq5EFSg8aAWp+52KOdGoyKoWC8Yj9tw2hSTyPysNXjR8cWHIr1Xy75/46mB+9y4lW6UHKi/fGr/JPDQuCcJbVMcxcs+p0mEmmN10RMHV6VVu/fd0NRMogvvA9qJk1dtiH9266QalA2iuuyQYoi/4QR7ndjGe8apHKpJ7ewfseV6uH1n4cqLHxNh5aP7pN/7CWdAC+6PeykxhwGal4b4sAeLkO42ESnm83GJJJh8yoLOKIbrVvu910onXhKSlg2CQT7g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6304.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sun, 1 Jun
 2025 08:38:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 2/9] imap-send: add support for OAuth2.0 authentication
Thread-Topic: [PATCH v11 2/9] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb0tCajHHVu7IHKUOJJwqhoLdVBQ==
Date: Sun, 1 Jun 2025 08:38:51 +0000
Message-ID: <20250601083821.2440110-3-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: 40f0293f-6d3c-47ab-219a-08dda0e7bcc3
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|12121999007|8062599006|8060799009|15080799009|19110799006|1602099012|3412199025|4302099013|440099028|102099032|10035399007|19111999003|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OsYNvOqc2UbYr2BgaQ/yt+/Y9icUuDKCMyoJZDxgkZwWGnX8Gt/Nxi2zx8?=
 =?iso-8859-1?Q?KWNYo0deMAA/RVcWdSxibVt8ib1IPwBNgYP0nJS2Xt/b2iTyU3ESSox3Vh?=
 =?iso-8859-1?Q?U3/1vYjTQxgFukTJv2uXHGGMK2JplPI7orsqwEVusqxG5yFwE/wk8vUSGW?=
 =?iso-8859-1?Q?v4AB5x62fPXQNJNZFD48xXys3Jzm2liI4ka8SnWR38M7fRyFZqS28J6fTF?=
 =?iso-8859-1?Q?/yW+ZA3aIh4Q1qv85p4IqM9ZAqkX4HUzK9HBK8QxcslPXww6OkUg4n2/Ke?=
 =?iso-8859-1?Q?DjL6bxvPlxa2LRyHl2JCOqXPDa+Ap8hh4S9LJ/GA7Z4DvdSgRiCf2QIyFO?=
 =?iso-8859-1?Q?s5r1w16NeAB47J/Ezivac3nd1q0M3Wq6n6V5DJKcZoKBNOAGX9gKrifq1c?=
 =?iso-8859-1?Q?7WPILHbe7VIcL7vFVzD1XsmbwON1DY7nJep4Iv3fKujQZD/WOlNMbHcZge?=
 =?iso-8859-1?Q?9b5cCNGc5BWAleK/Vr8mZQgpur5qi3NFKbzCu+zmOHL81ywCzQ2m9IQQWB?=
 =?iso-8859-1?Q?VB25OS0K5wPHAGv1gLAYFFyo+BGiNh/UB5auYoaIn+vOZuq2LV5BtF3Ez6?=
 =?iso-8859-1?Q?fUuXZbE4cXI4wCku2CEZ+WaZe++AmS0CpoSRSmxGUV7l6UYHXDzvsb/kRe?=
 =?iso-8859-1?Q?6AXCBkZSkSLQF6z4k98f08Zf1NEU4ITe4haVI4h2Mylza7flpDqkua4jXm?=
 =?iso-8859-1?Q?XZe895tG0Nl29U1mgn/9tiLuQm7G+yC9NWzXbn7E9QzV1aXJeXUSJPCuhF?=
 =?iso-8859-1?Q?+zUzbCY2K6PsHeCp68nnxOAcsznmzvLD2xf58bvo0J3DiPbKKAq7olu1oZ?=
 =?iso-8859-1?Q?kTywoO7QqXUBUQAEFw3RzS6sFiEg94/Na+t3giqLJTcC8yKJYn27oui9ho?=
 =?iso-8859-1?Q?34vaPwPm34M9S4xCRNwnvPwGEx79roskv+M9MMLCVuvPry3l6fH28hPmrb?=
 =?iso-8859-1?Q?r7Pg7DLm+v1jz5HEmFzQiH2vDuXmTD7PruQ2kFGKA6nH3Igay1ALSqhiIf?=
 =?iso-8859-1?Q?1/Z6UU9fh8kzusuXyd0up2M7+4HsTY1HrAKFTJfa7zO1t6rl03JW7g3y1l?=
 =?iso-8859-1?Q?CpFwPrbJYPw2FOrXa3QJrZi/vDfnWlpzwjPwQ9CPIw2J1SkIIGSejgIQAO?=
 =?iso-8859-1?Q?H5m1iZwzP+C0TuLO06kKRvvBUPJXW2ydaGSDw/wYM9IH1yVgl372RCsXfG?=
 =?iso-8859-1?Q?v93XwXonBMAsrLqVw16OfIbGf5nG+zDq1fQQZ2CTSf1/CMWLwnb3DRpRLV?=
 =?iso-8859-1?Q?waICI9VElSRo90xSv8cs0wAo4Ubf9cz7efUo7J1Sf1Nhb4GSlfWNMgl6V5?=
 =?iso-8859-1?Q?SOMT2IoSoOfb6rFL1jLf/v2XMQ23/zV1TBBBmCD5P+AW+zMspoGK0fBLE0?=
 =?iso-8859-1?Q?CNmTYK9T0eM29jtqzHUIT6LJGEUcX1nyJ03pFzwSrVxMHHx8KAqyFbNpzw?=
 =?iso-8859-1?Q?1ffW7arle4sykU0W/oHhEWdaVgqdn37/tHdMVQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7IPMydMq3AoD0B+QFlWQTlURCqxqZm/qUzPgOTRk+EIsvjCbu99ua1wPQA?=
 =?iso-8859-1?Q?QE7P4Xo06LO0a2MFJQiaQIXI1gK8ZBrEMX92z0Qbap5BXi5HuJOhsBoAjr?=
 =?iso-8859-1?Q?tv5UAI5e3o9oj7Fyvd3hmG8AKxZrY9KEvKsedV/W4Kv2apmVhrJpdboUC0?=
 =?iso-8859-1?Q?CcJCOpW1FiWwZ4DCZkcTleL5Vkn7WJuw/wzcUT1bMm1PXLUhyP+qOTbaoZ?=
 =?iso-8859-1?Q?363odC7IoS8o0kaqWA/G1fpDoJFJp3yTxa4cJ8U9nOyTZnU8EeAmszP2qP?=
 =?iso-8859-1?Q?Kt4HVoOBrsNbTbH5zhBlxQWztRIw5zhPNVKx5TxrfYWQ5LNRTA6r2OwCwA?=
 =?iso-8859-1?Q?oeNqk3wmaBSAEMuR6IHwBGpKK5gehujIVgae9OCmOdonUAEFj0zemn0EGX?=
 =?iso-8859-1?Q?Bq1MjgvbYssYzif7/ASTPtohy5ZMzuvnwsMM7Wi5NhFUuFngEF+Aaddzxu?=
 =?iso-8859-1?Q?QKQPJrcmiEOV+MzqXgacwryrpdLmZjVKEGMEbp7Zwxpz2d8oGZMR4VQ7fR?=
 =?iso-8859-1?Q?/IsFFH4MjhvWVLPTvxf3q39cdPZ4JAiaNrylHAaSBIOrmjcaa3etdKm6Ju?=
 =?iso-8859-1?Q?Zq9O31eusVzkdsbXaDKKKshgPt0CEj/zuJ+OetxU3KrliPkZ8TqebBbccd?=
 =?iso-8859-1?Q?xtBBvX/0UgI6GLrBiBF5ZxowyhdM7OQ29+w8UoYt9PBlt2exdRyQC2qxe/?=
 =?iso-8859-1?Q?EiusCwSoIDXBTnlGiWKLFAeTxhBDMAqOR06P8vH6zYyaqLPeig0V9Lu15n?=
 =?iso-8859-1?Q?7sLm7UpcDN+Q5jOFU+gG/JWcIk+UTtWo+j7B0JLDd8MRn8P9zrMV4E0DdP?=
 =?iso-8859-1?Q?E7E2Frt89if7Xp6N4sGnG5as/f9SXg8S+6KM+GtKKkyOx3jDX/mdhDugEx?=
 =?iso-8859-1?Q?4VpD4XfNYjkJ6JtasxXHS45Mzh38LX/YIZKLE2uYYrk4evZQgMgh/clqNZ?=
 =?iso-8859-1?Q?j4MJrC3nlkVhaqkR/hPpgLjj4kSqwoIe/ivJDo6s/cSbgvqU8XhqI0feLU?=
 =?iso-8859-1?Q?MwrBxLKuwqYO32LBVg92zoL74M+usjGFPWhWDZfIOUnMFP9MD/q4RPKA8y?=
 =?iso-8859-1?Q?4GOuetvuDY8VP43tZZAkdKPCiaKFifQ+06hBlC1Od03GTGSPRFE3MFMcdk?=
 =?iso-8859-1?Q?nDjiwF3azYqZelbw521ibJtKhQkDafZV2sXwcQulRY6ZQHvgxZcdAU9q4F?=
 =?iso-8859-1?Q?fUb5YlWp79phFDw06OGMB2NSTvEDIf3NWwva0l474qzvlPxd92TYIzJwSp?=
 =?iso-8859-1?Q?7G3HGRK99YCdnnbmgbSf4luRLzvWlxb61NbDGqYgA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f0293f-6d3c-47ab-219a-08dda0e7bcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:51.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6304

OAuth2.0 is a new way of authentication supported by various email provider=
s
these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], wherea=
s
XOAUTH2 is Google's proprietary mechanism (See [3]).

[1]: https://datatracker.ietf.org/doc/html/rfc5801
[2]: https://datatracker.ietf.org/doc/html/rfc7628
[3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#in=
itial_client_response

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  47 +++++++-
 imap-send.c                      | 179 +++++++++++++++++++++++++++++--
 3 files changed, 218 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 3d28f72643..fef6487293 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server=
.
 	If Git was built with the NO_CURL option, or if your curl version is olde=
r
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
+	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 26ccf4e433..08ecb1e829 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,18 @@ Using Gmail's IMAP interface:
=20
 ---------
 [imap]
-	folder =3D "[Gmail]/Drafts"
-	host =3D imaps://imap.gmail.com
-	user =3D user@gmail.com
-	port =3D 993
+    folder =3D "[Gmail]/Drafts"
+    host =3D imaps://imap.gmail.com
+    user =3D user@gmail.com
+    port =3D 993
 ---------
=20
+Gmail does not allow using your regular password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you =
can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create=
 it.
+Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder =3D "[Google Mail]/Drafts"` if you =
get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of=
 the "Drafts"
 folder will be localized.
=20
+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBE=
ARER`
+or `XOAUTH2` mechanism in your config. It is more secure than using app-sp=
ecific
+passwords, and also does not enforce the need of having multi-factor authe=
ntication.
+You will have to use an OAuth2.0 access token in place of your password wh=
en using this
+authentication.
+
+---------
+[imap]
+    folder =3D "[Gmail]/Drafts"
+    host =3D imaps://imap.gmail.com
+    user =3D user@gmail.com
+    port =3D 993
+    authmethod =3D OAUTHBEARER
+---------
+
+Using Outlook's IMAP interface:
+
+Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, i=
t
+supports only `XOAUTH2` as the mechanism.
+
+---------
+[imap]
+    folder =3D "Drafts"
+    host =3D imaps://outlook.office365.com
+    user =3D user@outlook.com
+    port =3D 993
+    authmethod =3D XOAUTH2
+---------
+
 Once the commits are ready to be sent, run the following command:
=20
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-s=
end
@@ -124,6 +159,10 @@ Just make sure to disable line wrapping in the email c=
lient (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
=20
+In case you are using OAuth2.0 authentication, it is easier to use credent=
ial
+helpers to generate tokens. Credential helpers suggested in
+linkgit:git-send-email[1] can be used for `git imap-send` as well.
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..4f3a1fb5b1 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2
 };
=20
 static const char *cap_list[] =3D {
@@ -149,6 +151,8 @@ static const char *cap_list[] =3D {
 	"NAMESPACE",
 	"STARTTLS",
 	"AUTH=3DCRAM-MD5",
+	"AUTH=3DOAUTHBEARER",
+	"AUTH=3DXOAUTH2",
 };
=20
 #define RESP_OK    0
@@ -885,6 +889,68 @@ static char *cram(const char *challenge_64, const char=
 *user, const char *pass)
 	return (char *)response_64;
 }
=20
+static char *oauthbearer_base64(const char *user, const char *access_token=
)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the OAUTHBEARER string
+	 *
+	 * "n,a=3D" {User} ",^Ahost=3D" {Host} "^Aport=3D" {Port} "^Aauth=3DBeare=
r " {Access Token} "^A^A
+	 *
+	 * The first part `n,a=3D" {User} ",` is the gs2 header described in RFC5=
801.
+	 * * gs2-cb-flag `n` -> client does not support CB
+	 * * gs2-authzid `a=3D" {User} "`
+	 *
+	 * The second part are key value pairs containing host, port and auth as
+	 * described in RFC7628.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc5801
+	 * https://datatracker.ietf.org/doc/html/rfc7628
+	 */
+	raw_len =3D strlen(user) + strlen(access_token) + 20;
+	raw =3D xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "n,a=3D%s,\001auth=3DBearer %s\001\001", user,=
 access_token);
+
+	/* Base64 encode */
+	b64 =3D xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, s=
trlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static char *xoauth2_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the XOAUTH2 string
+	 * "user=3D" {User} "^Aauth=3DBearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#in=
itial_client_response
+	 */
+	raw_len =3D strlen(user) + strlen(access_token) + 20;
+	raw =3D xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "user=3D%s\001auth=3DBearer %s\001\001", user,=
 access_token);
+
+	/* Base64 encode */
+	b64 =3D xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, s=
trlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 #else
=20
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +961,20 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
=20
+static char *oauthbearer_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use OAUTHBEARER authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use XOAUTH2 authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
 #endif
=20
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -913,6 +993,46 @@ static int auth_cram_md5(struct imap_store *ctx, const=
 char *prompt)
 	return 0;
 }
=20
+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNU=
SED)
+{
+	int ret;
+	char *b64;
+
+	b64 =3D oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("OAUTHBEARER: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret =3D socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret !=3D (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending OAUTHBEARER response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 =3D xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("XOAUTH2: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret =3D socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret !=3D (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending XOAUTH2 response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static void server_fill_credential(struct imap_server_conf *srvc, struct c=
redential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -1104,6 +1224,36 @@ static struct imap_store *imap_open_store(struct ima=
p_server_conf *srvc, const c
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
 				}
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (!CAP(AUTH_OAUTHBEARER)) {
+					fprintf(stderr, "You specified "
+						"OAUTHBEARER as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* OAUTHBEARER */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont =3D auth_oauthbearer;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") !=3D RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (!CAP(AUTH_XOAUTH2)) {
+					fprintf(stderr, "You specified "
+						"XOAUTH2 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* XOAUTH2 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont =3D auth_xoauth2;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") !=3D RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
+					goto bail;
+				}
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1405,7 +1555,11 @@ static CURL *setup_curl(struct imap_server_conf *srv=
c, struct credential *cred)
=20
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	if (!srvc->auth_method ||
+	    strcmp(srvc->auth_method, "XOAUTH2") ||
+	    strcmp(srvc->auth_method, "OAUTHBEARER"))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
=20
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1423,11 +1577,22 @@ static CURL *setup_curl(struct imap_server_conf *sr=
vc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
=20
 	if (srvc->auth_method) {
-		struct strbuf auth =3D STRBUF_INIT;
-		strbuf_addstr(&auth, "AUTH=3D");
-		strbuf_addstr(&auth, srvc->auth_method);
-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
-		strbuf_release(&auth);
+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
+
+			/*
+			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
+			 * upon debugging, it has been found that it is capable of detecting
+			 * the best option out of OAUTHBEARER and XOAUTH2.
+			 */
+			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
+		} else {
+			struct strbuf auth =3D STRBUF_INIT;
+			strbuf_addstr(&auth, "AUTH=3D");
+			strbuf_addstr(&auth, srvc->auth_method);
+			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+			strbuf_release(&auth);
+		}
 	}
=20
 	if (!srvc->use_ssl)
--=20
2.49.0.638.g5e24c6cde8

