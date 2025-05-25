Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F725D559
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199305; cv=fail; b=K6PvDhjlzfhZzoc8+8m2NjoEzEYngmGUUhkPjnWilBZUFC+6il8/LQs62yJXaTrq5naDZFVTtUeSFDDwbuV5KmKeZgDMDXRoLmwG1/sYLczOscu06QDyLlycMckcvdzyuqHCpsgpz3wM/efC5UTq3KbmSCPh2S+PgJ/3EVnOoWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199305; c=relaxed/simple;
	bh=RefKcpH+2pgsWIn+nD38ejdGH+1D3VMxR/HJB4V+Q0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DXJ65FYNVc+l/vP8WlpJyAZ48kyD2nyNwQC3e2CA+RyGJvqgQI5jUXcG3fBb/2b7hE9sgRHFk6qB5Qy1JB+iqe3nU5DMcitwUeXeX4n5h4LDXWTIoMO2mUzCFlmQC/Pp4iz37I9+2N/dHVtvvXFVXn0600lgR9HWZ3x4xGTIZK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=DatALsF8; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="DatALsF8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+eWDzD/VCMNyqw/HhAOacr83uYMU9WazC8ReLKXiGIi78M8S9dtBE/ecyWfP20zcMB4TqDbp5WUHtgY9R/2+55SpycyFdAwGEZ6FvZFFH0fdoKIf7b3v3GRpHBS6mZyQPhFUQV9/eMjInjXp0WSSiaE3oW/OXb+H70z8IXpjLH20IruA4Ra3PLOeB3qYVJt3gNSDXHOk8ck5Th/B5S3tI4YhtqvzIA173IxigA1k/yNyhTZ/sZhVC43DZpNgG7ElwU5KhQpbYuVRVjeqch1B581MhNvqTvR5xOm6ZGrfFVjEIbLrxa7wi/hOAmYdICDaMP266K122TZ2q7sS5xItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbDn7xyU+rC4Zh7renE8IwGforSr4VXyIva6MzurVSg=;
 b=OPNHTCVm2MS3NjpR4mEu/g3QIP6o3D8QUXhrftIIh7CRmXsuBpIFnzLLjWUlKBXlFRrYU4F85is64l9F3HbayUUdd7S2M5kuhPr2aIT6cGvzyfUcdjdFSfyHMDIZVTRNZVZYCo/j5ehOkTLAplmHHlYEJ7Z5LWDtSb/DJvyObGaD2sNdcLrksBxrxDUTvRbf1Td/m+jQBYY2xr+vevLPQkv78hWePdHKxGsrkQJfgggbX+Fal3XQuU2WG1pk2v/5rfbOuqw9rXFkbZ1rNKfioGK+HN4xPKOPjjlD6T0Zia79WWBBIPdh8ErmefXhiykySkphnArL7BmP5LdSjzDiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbDn7xyU+rC4Zh7renE8IwGforSr4VXyIva6MzurVSg=;
 b=DatALsF8/zhuEbIS+heJHU0AhvKYzESWFb8YiIJhQ8RiX6/UJUQJREGQ0309AiuNQmx5F1AdIYbqqCfMEeCAMMPf+VqEpHBPUonP/0i2COJMYQdoEWhVqd+IzTSgWdBp5kT7SVAs1QOy3ZN+Bcbd6h6KFabePvJ0Hh+us/B+BUE7+793Kcfee/4YChS5YILfVA0XqEHElpDaq+JaWrL0qsRVj/VvWz4Yi0GtHCgFWi6iIasEeH/KFlg9rcmf8VRJaEEne2F9yPrsbg3siknxPLVIiWo0CZZW84bDuIcYLdwclo17J+PNSmdVvJ/qPHqa3tZTcGTWoEWdc33A1714gw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 18:54:57 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 18:54:57 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>
Subject: [PATCH v5 2/6] imap-send: add support for OAuth2.0 authentication
Thread-Topic: [PATCH v5 2/6] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHbzaaCvUB/SF5LiUW7MyxPsxK5bA==
Date: Sun, 25 May 2025 18:54:57 +0000
Message-ID: <20250525185447.29982-3-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: a12ef744-bfa7-4a90-56f9-08dd9bbda4f0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|8062599006|8060799009|461199028|7092599006|38102599003|15080799009|19110799006|12121999007|41001999006|12091999003|19111999003|1602099012|4302099013|440099028|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2kDBtdkF93rc0m97NHB1POEcPfYXNa1SyQgWHc4t7w6QB29OV4DSKmd7gc?=
 =?iso-8859-1?Q?SIX/iMcMXsTBZ+I8XoWx5RXhJ65JSmYcSn4w5PyhXsXmfaPZ9x2CPkvOHF?=
 =?iso-8859-1?Q?IQViiochCEIqhf9IL/JTouzbP7gL0HZmavqWMCi+T6qaAdCUtbPlNDRiX8?=
 =?iso-8859-1?Q?e2T+IwT3euOIVR9hhrIn0WnW0PX2Gt8yKPAD4GhCMboyAdL792NvQ6NVN1?=
 =?iso-8859-1?Q?TkLT997R89pxG+zOTyM1t5iWB7XzprbSnuqDe3R1oM9EKdlDoIok/WGi4K?=
 =?iso-8859-1?Q?kJRpJVVfJ0lqU0Hd8b5avSH4bMw6e4tosB/aPHaD1RUh2LuNJPA3HHkkvq?=
 =?iso-8859-1?Q?BbnpopvMCnurUPEtpPEzjrC42ysJmwGyhr0QbsPKRE6v18jniQz6uAuQp4?=
 =?iso-8859-1?Q?SPA5dO6/453ILRNq4TdgD7DLRCxpT2hANjEaXBzU0EItHwlh6/PV8nBf/H?=
 =?iso-8859-1?Q?LFU2K25izqU6bEGimozZ66i4cSU/hYCJq3kAL8wTK1NzY+LYLgpWOSrxWd?=
 =?iso-8859-1?Q?fvudL3mj70IPRas/8ozrerte9vleB8ud8UT9QNMxRxw3NKOSwaO1sxznXS?=
 =?iso-8859-1?Q?PzCJyZOUU2/qSh0tz2SH84g8S7eaJzozbh99c8cFmcpWzwG2Xu5Wle4C6j?=
 =?iso-8859-1?Q?wK4l+elGgVDcCzUjbvTHOjnQTBNlCF/QxyVLTl18TPMfhqju3NdO/2wTNL?=
 =?iso-8859-1?Q?d+FAqvQk5HnMbUa/sKkjB0da6mDbGAonIKG5AHu12bEMlsnVzwQdzcR0b9?=
 =?iso-8859-1?Q?8j+9fJHf7IHUv9eZySs5pyyHWR00akRMJ02OeaU1eY2opyneZT2JAmjt/a?=
 =?iso-8859-1?Q?Ei+xElVL220NNHEkdznmh6G37V0miALbacijVbXPPkNvRQjIqCYncVGVfe?=
 =?iso-8859-1?Q?dzNKxzS/p+EpUGT5xWGl8/i4DU7T6WYQDBAKfFjh9g6sh2MImduOnsMwtD?=
 =?iso-8859-1?Q?0Lbm7EtDrkDiTgoX/9KfbIYe46Z5GZpSLORDZ4IJDgYB0hL8hP//RphDo9?=
 =?iso-8859-1?Q?i8UVj/bdEbq9ttZfWICgo0zXQPIwJlx/75aOo/2S2QZogT7jwGes+gjjMX?=
 =?iso-8859-1?Q?sFlZXlwELEhn/Pab4krCpJeTyqyTAph5266LYl6/fS34FNYkUFR11IZ7JI?=
 =?iso-8859-1?Q?Oi6NPme6C+Wp3jebqTDcPMiQzQ/2wijsaQXlH7uirUmUIXWGyMPf+dfGyC?=
 =?iso-8859-1?Q?ZfERF6F3XOlSNQsoyraDHJFy8n7qhMBi1GEV6nIA70PguS2Cnq30zG6fRH?=
 =?iso-8859-1?Q?NjgjKq9c9Uo8mFc8W0mi2IOQkkwZZ7DYJ4CsEikK3/KkE3GI+U17VqKl08?=
 =?iso-8859-1?Q?lAkTawib5Yl0cQiVZkFOuA4DgT7B5LaM0j6+/he52DVMm57DVJYR+RZbCN?=
 =?iso-8859-1?Q?sNvKEaOBBvpuH9piyVfolF/JuJwWXp47jcXeUIN8xHNWd/iBJRZafbXtqC?=
 =?iso-8859-1?Q?93zVHC0PW9Riqo+rJO/MflLVmwkAivxQAz0pIqb6p9im3tw2xwmxEx3GDT?=
 =?iso-8859-1?Q?8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Zhgx0AqGRHXAG5agDo2YxT+WbB0IHlExw6/QmbOdQBpYnMQqUWHf55mKpe?=
 =?iso-8859-1?Q?T7n4ADfeFTKW3OMZoQoTxX+rGHildeyDQOD6MVOHBM30/gdBQ/4xtPsoP4?=
 =?iso-8859-1?Q?N6YMQU8gq3Cy87EkSYciqUp14OqzXp23aJ+z2SzbSTAVyicKxDRuJi9Ui3?=
 =?iso-8859-1?Q?xHxNTaIK/LFZ+K8Hy8lrqMI+0+AZLz1uQqDuwahqaD6ohkTi1p7nxTxgLJ?=
 =?iso-8859-1?Q?vDG6v9vJ4AKqD508pGeZ8ZshD9B9822UJWdr/pFK8XZBuiDGA3+oiFUaPj?=
 =?iso-8859-1?Q?9Eyqm3Oq9Ve1AYDOr0dD0AvYYBo27DGDzGYzXOENI+gMctJ0rPdFkNuewv?=
 =?iso-8859-1?Q?ym72oxFDQlWM2IKUqIB8fFWzt4dSLgzx6zlb7/VItsinG+IQoOy3ZYyDbH?=
 =?iso-8859-1?Q?eONrFhSKFrgeGpyuuuq1rByZsuM4tKOTkHfOhKIqiYz1E3avNxU3iN0vgK?=
 =?iso-8859-1?Q?mfh837nvhuPk1orUaNyxoK4BJd9QNVD/93eB5SWMbobpfn/X1zqJXHdDip?=
 =?iso-8859-1?Q?DyEf/UvvfD/rPkmB14VeIf6ZsZZ1v5hvifiNhYxnwHmcHFWWjh+U33JY/i?=
 =?iso-8859-1?Q?u+jA9bTJq1/Yf5fsTvJEfDa+cqx4K2L4jLcUO0HJOp8TA0xOr+EB5qiX+F?=
 =?iso-8859-1?Q?RREdaLfFZqza3UISdj1DvsZElq7bCu7toMOFDex0W43RQHKtn5AB1INQnQ?=
 =?iso-8859-1?Q?uxAn8HSMXCjRrwEIbZCAxUxvmZFgiJzzN40SSGfr0sdRO37Uz3c74M+na1?=
 =?iso-8859-1?Q?BW52lS1t3cK5E4qu9RJ6jADFIYRYXQfWbFNU3+sxJ8C1T4ITtYIPzVes18?=
 =?iso-8859-1?Q?pwWfGwy5auAGFTtLdKivCbE2Njk9jt/+veKcnLs7qeDzjJUqjeuY0cWGZ7?=
 =?iso-8859-1?Q?XlAPtB0RBuDNZnEocKlGweXvMisGJP/MLMbm9onbf/W6ux5ywQsTjLfrds?=
 =?iso-8859-1?Q?Ooic/cgbOWuU2lWuPLcxMjroY6SxHABfFX/l/4U/uq6KCyxKEeU/gES5oi?=
 =?iso-8859-1?Q?PsNv18bdZTEwjAFRqUEmwr31p5auM8y/gXXdhdTQQmePMYoRudXFwU0mbS?=
 =?iso-8859-1?Q?il5oV6gTQ2lxY2ogSa+6Ezd3yPte8dwyPDzmJTFzqJqvvGlBZH3x3jmXO9?=
 =?iso-8859-1?Q?32JnFSHbNwD4D5ZXmixfwwPFx+BEzjQmy2Wy3mI0neS2MK4lweuSXAMjqp?=
 =?iso-8859-1?Q?+7vwPSes2+q9O9hvl8tsgAxAo7qd5S/qjufWwKuo4AgX5eewYqUSpu2bLV?=
 =?iso-8859-1?Q?IjxlcPKUcfvhL3yIf+UF8Z5BNBQsYaoNv0dBv9LUQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a12ef744-bfa7-4a90-56f9-08dd9bbda4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 18:54:57.4303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

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
 Documentation/git-imap-send.adoc |  46 +++++++-
 imap-send.c                      | 176 +++++++++++++++++++++++++++++--
 3 files changed, 214 insertions(+), 13 deletions(-)

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
index 26ccf4e433..c3a46070ac 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,19 @@ Using Gmail's IMAP interface:
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
+Gmail does not allow using your account password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you =
can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create=
 it.
+If you do not want to enable multi-factor authentication, you can use OAut=
h2.0
+authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder =3D "[Google Mail]/Drafts"` if you =
get an error
 that the "Folder doesn't exist".
@@ -116,6 +123,33 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of=
 the "Drafts"
 folder will be localized.
=20
+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBE=
ARER`
+or `XOAUTH2` mechanism in your config. In such a case you will have to use=
 an
+OAuth2.0 access token in place of your password.
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
@@ -124,6 +158,10 @@ Just make sure to disable line wrapping in the email c=
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
index 37f94a37e8..04b507fc14 100644
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
@@ -885,6 +889,66 @@ static char *cram(const char *challenge_64, const char=
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
+	/* Compose the OAUTHBEARER string
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
+	/* Compose the XOAUTH2 string
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
@@ -895,6 +959,20 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
=20
+static char *oauthbearer_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use OAUTHBEARER authenticate method "
+	    "with OpenSSL library, but it's support has not been compiled in.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use XOAUTH2 authenticate method "
+	    "with OpenSSL library, but it's support has not been compiled in.");
+}
+
 #endif
=20
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -913,6 +991,46 @@ static int auth_cram_md5(struct imap_store *ctx, const=
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
@@ -1104,6 +1222,36 @@ static struct imap_store *imap_open_store(struct ima=
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
@@ -1405,7 +1553,11 @@ static CURL *setup_curl(struct imap_server_conf *srv=
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
@@ -1423,11 +1575,21 @@ static CURL *setup_curl(struct imap_server_conf *sr=
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
+			/* While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
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
2.43.0


