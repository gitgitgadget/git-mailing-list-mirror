Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0022D7A3
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535673; cv=fail; b=bcG7rV77OQzN9ec9LL79eYZ/QBfj3L7SG4lN9SmxwOg9ywknFwfy65dPEJR8Dy3NHXSy54Fj4U6eP9dKtJN3Mu4q265NBqqZ+RZ22x0eGjc4GgyPxKXgMNuw6wusHIZU3+Dy3nfYjReb2vUzRuAz8dQiGLytBDRm86WlRbhCq3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535673; c=relaxed/simple;
	bh=GTwZup5DctIf3F627M/NZRWkFXHMWlREhlDhaiotCZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPWS9JzqLS58USgy2JyuY3xhfSzWI2w05u1aCUNKIWXulkhLVEBwMLFfeWCSqdcOIaNkpJiyvJmvbsowhQhs7SO9CfgCdry31o0wAP6rCDP0uiBcRdI4D01dajuGPcNUl1DgK7Afg0S5SPm2VDZFGJC+7gRX4Y6kUuvR09+lIpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GGtEd4li; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GGtEd4li"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVdyJFDp1ar4wpTHGc94nfa9FahJt77x8b0d3mctC4OaZpk6tMQKYfuF/0aXv2JHjCb4rqAHSw72bxUw5Rrl2p+620VffCLMHzp47+Ex9zaE1MEia42gJQ+Zn3FmZHqEeKZwp4oEPKapO1N3ID3HTQ8yEjHh160x+yu6f4swJs9opRQsajdlxKJL9lvkczt7u2Yy9ka+fuPl33RLoZUW9UND3J20QdGUjCZIxseU7pKxeovo4XvcYBy+WE5iMabxbW/PG/GSkeNbnonTc9YB5j5PLsWjEkinUKvirXxp9NNrjxY+cfDWeoU1VPKepdrpyccrvvroQeaQD5b56Z4Qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PvBRDgdeZsvpan6QN3XHIZ4KjVr3jP65Pm2updmNLI=;
 b=mygLVdMqS2NC5K3f+uH0kGLdgZUzoc4cYFRP5Qafe/KvBJyeSsAQ3AT4i51EhXtAZAnPymCHIRHxBfN2sF01A12r3rMBJvZ+A4y7q+hcgDmxSXdxPw8xOaTsEExoieVLjgOq4J3Po+3xayuuX6K30psgpTNTb/QLolkxfqvNxUHBtcBIACYqpVcBPFXfXtRZkgxi6NK6ooXgm2O1ERZBAjOfzWYlZAQVDqzvceKddec3l6zi1vnQTmyvpbzYLjhjty6Ki13X6GBB3VMFjeCOdubcKnjwzj70ocEM5oeMQVDfE4S0FQfQY+Wfm0N0Lyosmxjm7Hu3w4P3haWAn1YCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PvBRDgdeZsvpan6QN3XHIZ4KjVr3jP65Pm2updmNLI=;
 b=GGtEd4li/1oRId7Txf1kz2TJg83qQ5Xc8u82HujlhdKE2acY3ZX/fCbRFKMiyR12ssNQ44nXQoTud37MVYVjmUy8l/oTlilO1DQxE2CgcQDM03XSqlDHVlxggcpYFMphYueW5cTFcH4PZWi8clhs2+SunUGL2DhVFcJcoWQ2XCTIF6tGpMU1TXzopU4PKCIUF3vW70hpw326YWDuYIYwbWEVkzKfpIRjx1NiecghYtLI0DK1f3ZtMFjEEgOChP57Y65zzSHr5EiXbWp0QoRhR+b3ZhowI98l9iD3pY9X1G1yNgRLuYdo+jEtnE3QmYIKG9cbhem+IAbq5CVFhfK39g==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:04 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 2/9] imap-send: add support for OAuth2.0 authentication
Thread-Topic: [PATCH v8 2/9] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb0LWszPAcJNkU6kmX5ZPXQRJ/hQ==
Date: Thu, 29 May 2025 16:21:04 +0000
Message-ID: <20250529162020.45187-3-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250529162020.45187-1-gargaditya08@live.com>
In-Reply-To: <20250529162020.45187-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7067:EE_
x-ms-office365-filtering-correlation-id: 7410a4fb-38e0-40f8-e8c6-08dd9ecccf67
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|12121999007|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|1602099012|440099028|4302099013|3412199025|10035399007|12091999003|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?u6jRloB0nuU+NdAQrdHdSljZo6Cpws6qcdStm2d+VD+METE/t9U9HmrOCu?=
 =?iso-8859-1?Q?ARH//dH08je8Xd3Itpn+vz8hvhuXsbaDvKI4v33Ayl0emGNKvQJecPkAyh?=
 =?iso-8859-1?Q?zeodSuXEiCnsnMSAD9uqlvRXn23Vu/8mWTfJ1kCpW9zdUo0rtWtCmPUko5?=
 =?iso-8859-1?Q?+7G+kR3gOLX2cFitkIMPFslFjUhLNsdvOuETeJ7SCUpBTwnynNjfcUtSx1?=
 =?iso-8859-1?Q?q4BAYGAlKHSqyxG2GCQIXCIJbcUBIOcZ8X0r2huWL2XbDeVhF8rI2ZwbAv?=
 =?iso-8859-1?Q?E/zFNt/0HBJkFjhUfd+JUdgVTg73FI3Izg1CqS4hLIZowojZ7uoCEDCyoC?=
 =?iso-8859-1?Q?qa625+cFBq7iPIYrhNQ4RdMx+ImnLfIAknGip5ycjpJ7ukD/dV45K7OaIu?=
 =?iso-8859-1?Q?38wFhwK9CtNAs9mHa9mnttOjNNKTwl51dmFlvtJgEc3KdpPf4BhGna1E/v?=
 =?iso-8859-1?Q?IVYCSoIMdUMyau1SOzOM+hSPcqEoVMGdjLZz3FQOVq1rsitH+PB1pHfiIf?=
 =?iso-8859-1?Q?u/J76ehkqpgErmIqvbjVZtJ88yhQmkBT9GXlRsxcGAqpnbhM2clQ9tSqNG?=
 =?iso-8859-1?Q?1aruMv7QtZ1faP2GqDggWDtHBylPxLwFKeNg9Q9yxJGCTq5mR0xnKignoD?=
 =?iso-8859-1?Q?2AygU31f1/GJLCerffTKg/LeyGvcERoOATTCbOP86N/rZtZ70L04UNl8rk?=
 =?iso-8859-1?Q?EgphHkAvrQViYY5EQtIKer/WseRdmXLKWu0IAem8EOIjsAxPuTKVmE7HJd?=
 =?iso-8859-1?Q?9F7jFyfqMoCTdQ6B1dvwjJBVTvqg1l1ReZqt7pcZQJXuX4hFW1YiQP3aoT?=
 =?iso-8859-1?Q?0BlcnLSj1u3z163q+QGSeqAInWEyB5/I5L1aQ4/DJAya0ukEqUOmAGUN8d?=
 =?iso-8859-1?Q?3QQhAXgLP2SSLE50P6lWOmgoj1yARXp5hVanpE1pZk+K1legiz/2R7/uS5?=
 =?iso-8859-1?Q?9PKwmbnkstdd1bb+sl/Z/GpHL+csXc2mY/mMY9fJWOckjN18hzoY5lWtOI?=
 =?iso-8859-1?Q?nCAtQLUAzw2RU7gflcgV3scv84xW6+1grVePvBnuPQAAhV3PLwQI/3/Cne?=
 =?iso-8859-1?Q?LZcYwTcTjqQOhSf6Kw20rN8Pj7T08YFCivEcS6kLGqvsKLhia6hBNyBh7z?=
 =?iso-8859-1?Q?d05e4YCDaW+MYTNAL3vyiA0jsYLWR7e8/bV3sWAB21XQiVw9jq6/hhgjLX?=
 =?iso-8859-1?Q?ivNQgE0Wj6kTyyOTLSXOVwUg7JJhcC8Kh+01INoeob6L5vnUbgWegjTt0m?=
 =?iso-8859-1?Q?RXbVJgAP03+VchYmsMz8EWNNGRhU0rrrjMNqOd3gyn50QCZFyx5j7pr0Uz?=
 =?iso-8859-1?Q?pg/QnYNwBNTn1kPJu7p36Qf9Wrjfz0FLZHTnSPNaTPGJu7KaL33PGtuKi7?=
 =?iso-8859-1?Q?uuP0s3bcwpH18ozuMLYY77qddwBXqd/EHJB+jmU9JJv1+FECV45m0C0yKR?=
 =?iso-8859-1?Q?LiU8Ynkn6GlhLnqhOGcTrCPp5V9W5iALrIIr5NB/pERvOYr5Ga9g7EqMCS?=
 =?iso-8859-1?Q?Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7A97lSD5pgs03eiDgbXsOEbKayGEwxTMir6AQzh801eHd2oBRjapEqWt7/?=
 =?iso-8859-1?Q?K30F4IiMB8msbNKV3W9U5rzyUnjVpqqAhFAtP8hrptz34AGm5LJtiQPU6t?=
 =?iso-8859-1?Q?6tSGQCd1WGg0QFkRo0F29KFTxtVlcHApE66eKHW3nMF4yeIPcXZOmjcpqO?=
 =?iso-8859-1?Q?6cvMmD9VzHC8WMDoAKcpWAZ+ZA6nMaqiceX3WZX8eQv4KIUToyLW8hg/d2?=
 =?iso-8859-1?Q?p2l+Xcsph1WvBwXmzTrB/wPFmzqr6RYDZwASx+JVj4RdGB85pn9ksigoCB?=
 =?iso-8859-1?Q?ggO2xCjdIszJqWJ1ow8IVX1Lyt0zatMMPbj1oJvilxocGPBHY7nyfATQYC?=
 =?iso-8859-1?Q?0fMO5SAVd8tXH60ztsgELLNmowh3gYmJk/OKwEoiclWJtPEFHyA4AebU5t?=
 =?iso-8859-1?Q?7udY1QCn+nXSlqABh9+mMe3NlbTITENjrN8J+2IK5JnEkCZMRg6P6KgWZp?=
 =?iso-8859-1?Q?2EXQjzqHs17M9KSpmSmrAIjpdviN/bP2Au8bb22cLDN1gOplknPERvaU8A?=
 =?iso-8859-1?Q?uX1fTLVlUR0Y+oarkneWDfeCv9SUk5MCataRQEKGbkCSO54gdff3Znjhs0?=
 =?iso-8859-1?Q?tHnDps8PGD+llbmlAUE3RYF9CoOMDt3CAAS2fm7kGD6RLBqJRIy24fifZA?=
 =?iso-8859-1?Q?KFvS9wTkn/5lbyDKDlpqGgd2zjsWzZDtH4OYqYFoVoS0JQ9a3V5DvIkSo7?=
 =?iso-8859-1?Q?dPBUY5BnXXT0xtybtPzvurHv5fbteIwuaxdldzVMaYFXvpVpynCt2JROV3?=
 =?iso-8859-1?Q?2vNdd+9c4ZmQAZLmnBU/z0KaQKiG3AFISyCxFZ1WFX8NIfwR8KOd7bIbCo?=
 =?iso-8859-1?Q?roJORaMdwv6imKwL4D/uxv4f7EhyoiJFjoJvkbu42QYGVz/lzmOa8QUq8V?=
 =?iso-8859-1?Q?ATqfRFxkiCG8lMEamxHYyyP49i0VOjQOmZuIyTjOMX4H5QCBW+r8OG97Qp?=
 =?iso-8859-1?Q?iGC+Og92JfCELB6mP+iu8ZQQxMFF63w3E3dXpAIGDkR6suFZceb8FgXMMM?=
 =?iso-8859-1?Q?HcojyXJx++mX73ZkTU1/Tn7b+9lJ/ZxxYZWyzAFogVor5q1gj672vn2Rur?=
 =?iso-8859-1?Q?hsGmS5KNTu4pixWKOWWQEwtZPdds0RDzPkSnbIHL3EgIWxufP9LYQ9LKPa?=
 =?iso-8859-1?Q?vUWc4vCoUMRnHv4ZKUM+MpFjFGXChZOAKXbhyd5HRdubtLCgFqdAcGlld1?=
 =?iso-8859-1?Q?V1YsktQeRY9lk5EXHj2r1FsftuvxrMA64lsxA1CjorcdaLNVyxflVnw8O9?=
 =?iso-8859-1?Q?0LP+iAck5FYwusXwOdUqOEAyTTn6EhJDAqYfa8Llk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7410a4fb-38e0-40f8-e8c6-08dd9ecccf67
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:04.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

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
index 37f94a37e8..0c7844aff2 100644
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
2.49.0.638.g602e07a80b.dirty

