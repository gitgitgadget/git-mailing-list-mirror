Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634320FAA4
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112955; cv=fail; b=W4cKOMC5zBYXCyiHdfLw6AgpbNVINvfyKb/QF80nFe8TXPqWerREW32jeFTEdz0OQpBsckdMoWd5ICT+NslbNoZkunS8ORCoeZW8Olmj2BPTTzkM2LlXTlAEwSzWulc1T/wTrgxXBkITkFC9pTecs75h13ZFcSdPpwxYg8mRjNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112955; c=relaxed/simple;
	bh=+/I8Xj0oQ+ePNPhUffKI02Ibvu6BnA7qVBYWzeVqNF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tWSjILU0aPSNKmSiOMPkETEwlhme24G7e5M/VMP0FJIVDd6nagIdtXzpjOeBLg0eWdKV6nPi75nhthpRE2SkVjl1DvS91fahpGKvuE+5lBfsE/e4PiwHkH/K921QQC7scwA69NqLMxR/Lhjnc12qPiCbNscYL6lxziyO2jpF9Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=otFOln1k; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="otFOln1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTX1DWAnGEJQb4dAEjB2xY8NQv1BtYmJrBNMFQVnx0OTU/BVfb6W4uvmTO715X5IM8zqa3ZISaFwtRwQY1gKz71vEbaz28ORSixv4Izpt1gyRt0IjuG+iFEH8BCdfDfpZDFHmu08uzXg2aC8RTJ0OB5i5epaCloxrBjGpyZ58Ok6BymywWqS4D4500PG17yRZOkn1g7b5XugiLiNsYbF4URYoHMRYQfTMDgM+Mw9gEmn02phouYQXAwKlNKm4/OjFYsxmDh86YGe7dda1bYB691mgUdzswxeXOTrH9WDQpq0Jg2SItVdR5nwOyfhE5T766cbMGjziaRIu5Opd9CuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPqYX9mT9EHWZ0gJ7SNnIT6Uj4qyAbI7ayxCs//XHss=;
 b=pnUq8FIRTPjGkGc7V5MFpW1nH6E6rxYrjICzgy4bbgBKVpcQkUXHEA/oP2n1WYrjf4+XK8KDHjN3mlWpNNnpDTEJPzuUonPq7uJiOTa92HecHB1wE8alTARcJdhsypYX565YYycEiXCuccJE/nNwyBYxnHz36zB54tcyLoDTJ2VVjUacrcFN7A2Ofz8QS7pQYqlYX90rR6uN72AHj7xkygZx1zMBuw4JpywoVoM6nSYO4Yg1gENe7FqPJgCE0R12mv0TKzEE0GO9fdhV3JAazr35GcXcrhnuBLjSpX3JX4JMdJu61WpDK1rob60oUFnq+kBh6owBp5las/sIaJb0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPqYX9mT9EHWZ0gJ7SNnIT6Uj4qyAbI7ayxCs//XHss=;
 b=otFOln1km7Mgh5ER6bkYWB2B5wbAeYtszKLXwdCAz2hemsYzFF3F+u9QZkggY8t7+YDWlMt7vVO7U/8X5Pspol3g+/9c9lEZZjSchxK6R1ZkC5isHNQ1gO6P5M9vUIWXRIYyRM7Y34rKQM4aGqQjuVhxkNVMMFQ8F9uAjgqgnaQXcjiEOZTiMua6Zh+c6VSQrw3AopH+NUmjuE6bhiaTYU77+8wmZ28a+q5q41xgoA9ZP0+MCFVSPvnv5tOvxT8VBoTLpEOxnOt1DvOdSYEHU6F9mIxrNMoiW42A1Yh2vYQA47wgVzUhM+TBxmuUj6mzLk6qOlwVwj8Tt/V0lEL3xw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPFFC37E0415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 02/10] imap-send: add support for OAuth2.0 authentication
Thread-Topic: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb1fXClSX0hMaoWkio+rC4u/XbAQ==
Date: Thu, 5 Jun 2025 08:42:25 +0000
Message-ID:
 <0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PPFFC37E0415:EE_
x-ms-office365-filtering-correlation-id: 3964c756-070e-44ab-4de8-08dda40ce57a
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|8022599003|461199028|7092599006|8060799009|8062599006|15080799009|19110799006|41001999006|12121999007|1602099012|3412199025|4302099013|440099028|10035399007|102099032|12091999003|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ku8Fvcwx9VO34U1yJAx8tc/dzsJ+WLvWnRY6LF99WQWGegY7jwWxuoEDg0?=
 =?iso-8859-1?Q?YG5QfUtN8rN0NMOb4VFiHLBPqCSEp7mFDsgn89LGS8Kcqf1FIuhahO4k+y?=
 =?iso-8859-1?Q?mcmQxrWiEk/fnMCsJ4X8FgbdDUi/iJf2FDS0GzXpalKB7zbGjF4O0fZhLg?=
 =?iso-8859-1?Q?JsR2epzFYmhm4VJxmZmePoy0PJXMoMwJ42vDX7V7suc2D2+BZzdxNXBp+1?=
 =?iso-8859-1?Q?QTGKa1euWAR0ryJ3VMXkLAwGpMtuv2dsQ9YYi7ymx45Vmzw2t5IRoASC5t?=
 =?iso-8859-1?Q?5uBEXdDtAzDUmF4mjdXuE3TnuBqbNwC0HjfgTxNvcBAZNbIDjSihg5TEeX?=
 =?iso-8859-1?Q?xN4ZgDWakKrKdNtSDu97OR9ibHPMFkTirjbwI/q9UJ0CCaOOk8PlOaOyK2?=
 =?iso-8859-1?Q?ITcwV/yJMm3pARnrd/qT3ZZ+PI7Um4lVYtBLTOEAeO0vey4UfFgijNLEDd?=
 =?iso-8859-1?Q?oaYah7aR2oS+/aUZJ/7synJt9TZtOBWjym2uEn3Km9TJRFSDPsaAANQMNx?=
 =?iso-8859-1?Q?oC1Pf06WBqTh+BaL8DXaeMOKp6VxNdtnnTwIBW+XhsOhcUt9YTRo3cBpE3?=
 =?iso-8859-1?Q?wj/K8QFoWLg2WuArY5v8ywOzGZBa76h1/BFZx/jz7uxUKhMHxW4xTY5y0R?=
 =?iso-8859-1?Q?gZAGapwWKYWIWTtX+QbF6XRcxWqpMjl7OJV0gD5rC7EbdfNxc5Rc0QvaN5?=
 =?iso-8859-1?Q?o24tz2IL3h31ow1+O608bGRWn54GfJVKq7MbY8QYDK0koaC8AxUmpJ3WzA?=
 =?iso-8859-1?Q?zXZgxffobGAhmuh3lCbqPL1ajPrSNQqUPce764dXaKHScQxOF8TfDtMB4q?=
 =?iso-8859-1?Q?J/DuFTvkyud3KpIuzGA8ScyjYyDR1fujX4dLctrhJSazp2Cfm7h2tAXx2Q?=
 =?iso-8859-1?Q?DCWvskEz6Tv8YOIA2U+pnjlbDoVN9MqTeOrukR71FTMZpGTAxrqG3oHdfY?=
 =?iso-8859-1?Q?Vs6qvY4e6YO3ziulWKygBMJvqQ4iCqtVJPBm6Iuwg2Yw6Un0QE8uZK+0SF?=
 =?iso-8859-1?Q?uxOYZxI3pnlCspGNzhwaPEiOLPT7tWsAOIOvqADtdmbNDOnTdjsJwo8q+n?=
 =?iso-8859-1?Q?RjQ02Djk3mhvUa9vv7XRDsc3EhPDKqzLGWZ2+b/G/PTR7dnpQZpJzh7jY/?=
 =?iso-8859-1?Q?M73dVyeT5Pv+VI/yS1mPZUiV+Jg2j30nrdzRfBHRmpEQjMNBHX/8sj61AE?=
 =?iso-8859-1?Q?6OccH2Rj0OowfPGkWm6sgkH1JAtAcBKbgkY5sWumWqlPXSMOj5G2BTmygw?=
 =?iso-8859-1?Q?18rLaQyMsTs9Mw51DDuspL7II5KA9zzMQ0Gxgx6+RD7mmz/GZ2fnmJ8FZ1?=
 =?iso-8859-1?Q?WW172CiTC7UJC19VUye5ycG7tHppdycK3FigRfpLXP3ZrGB2NCDkYNSKzf?=
 =?iso-8859-1?Q?+Yg9K2WsuyeN3oVgN42or7609gr2eNPCpJ71TnFHe1/oOUEUYkf+W9GLeg?=
 =?iso-8859-1?Q?/oIVwhBhjOF/LyPtWHod37aVovzzLbBlkG/N6+O8ne72v2aD44E7HKHAZG?=
 =?iso-8859-1?Q?U=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+gSrnBS09bBhhFxNx8Js2/C2bSunBIurbKMFtHUHGclyDbg9Zh0MjUIYJ+?=
 =?iso-8859-1?Q?ykr/zG+g+AaEJLWoN8L6z4W38TcV4uBc0rQREfc6U59mboXswfNSG4ycvS?=
 =?iso-8859-1?Q?uG8qqIarwlcHJJaWjZqMyZt8mFMYLmNpnjvG0Hctj5rwwjxVQjedRcdRKo?=
 =?iso-8859-1?Q?p17QQbMhC3owJSYsYdm6EIfNZOfe4zb9qr3E+9ecsdkyw9I3fTELH44D1d?=
 =?iso-8859-1?Q?8I/Xlwa2yB7hfOUbivZLUs7L/pev5TVbw0WcFVbRAi6vaGrjAJkaMmtZfy?=
 =?iso-8859-1?Q?f9ppOsy47xi5yAe51S9RiYanT/OPs9qVT5npRuftBfik7HTB2N+d1KyxA3?=
 =?iso-8859-1?Q?fAFYgDYKWXLmFhcJgEIrqYo+6RiYiTHu49pjMbtrpTmAP1scfv2wT7hJxV?=
 =?iso-8859-1?Q?FJRFWh6llk8xDQ02su/cp93WNtt5bDI/eGBL4yn9Nsi6iFVPhsZqiOwqvD?=
 =?iso-8859-1?Q?fA7EkhVWUIVpEy93kpfPAxB3GARuosf6HZ/PiokF0n0sjWflTqhVzPJaoj?=
 =?iso-8859-1?Q?Sof1jBURIB1uDHuoHD4pt2AiCfMN4ZwMNyUMnDHZPe5rS0Cxc/pnuRJ4JF?=
 =?iso-8859-1?Q?2HQj1jJ7ih60ifE3lOjX1hbzQBRtwHVEL32pPdOE6H4bNza/dEuWqxGABu?=
 =?iso-8859-1?Q?d0+uYkWu78EPZs3GWwSNzATxmbFOdDSljBIcil11jgbFBWa+WhPF/Sd25c?=
 =?iso-8859-1?Q?Igzn+rd+cL1EsHsp7UwCUJwy/yWV/nbvgkraNb5uQhE+7N5d7fQTyMyl7V?=
 =?iso-8859-1?Q?3Q2//o1tdOraiXmwql1ht2jKQ/MU3cLK02cLlsXNUOPIZEk4ikgfepz15e?=
 =?iso-8859-1?Q?wSsUJxTPU71PudyxmsNwT9WvKDFl8nDc625STh+TFwUKAqIGFHJ9tuG8Nn?=
 =?iso-8859-1?Q?gXQOZhVMAWDJ9g3Oa1yeFieGJVzHp/GUa4Y9HltOgqmJ9IlwSFXmcqm0JZ?=
 =?iso-8859-1?Q?i3AteHyjk/x9rkl0aqIdlblc4zIN2YTSW0YwBKto3PT8RSHgrDDkG26BvF?=
 =?iso-8859-1?Q?bIsY33954emamhmDYoEV6DR88U20Y06ZzuL0NDOzcV8GHkGn/au4rcSQy4?=
 =?iso-8859-1?Q?QB7xnHE8qzjKkgYZr6dv2XB3qZ0LKvB5o7LpFBlQ14odcJKJQLNmPO2NjY?=
 =?iso-8859-1?Q?s6vOyHvlL5ggjIQpyIZiZEvC38B/Ffh8QJ0sHLnnXpWJGuujyOm7n1PsbL?=
 =?iso-8859-1?Q?gzr1wFF5WSk392WadHEv9B2p6GGsbpzK4uwS6h5HXfcekOM/vuj32SdpiP?=
 =?iso-8859-1?Q?OrzppEQxbhTyZchnfIEespAOy42Z91i2d7B5I+5e4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3964c756-070e-44ab-4de8-08dda40ce57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:25.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFFC37E0415

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
 imap-send.c                      | 182 +++++++++++++++++++++++++++++--
 3 files changed, 221 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 3d28f72643..29b998d5ff 100644
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
+	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
+	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 26ccf4e433..8adf0e5aac 100644
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
+If you have multi-factor authentication set up on your Gmail account, you
+can generate an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create
+it. Alternatively, use OAuth2.0 authentication as described below.
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
+If you want to use OAuth2.0 based authentication, you can specify
+`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
+than using app-specific passwords, and also does not enforce the need of
+having multi-factor authentication. You will have to use an OAuth2.0
+access token in place of your password when using this authentication.
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
index 37f94a37e8..829e957abd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2,
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
@@ -885,6 +889,108 @@ static char *cram(const char *challenge_64, const cha=
r *user, const char *pass)
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
 #else
=20
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +1001,9 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
=20
+#define auth_oauthbearer NULL
+#define auth_xoauth2 NULL
+
 #endif
=20
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -1104,6 +1213,50 @@ static struct imap_store *imap_open_store(struct ima=
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
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "You are trying to use OAUTHBEARER authentication mech=
anism "
+					"with OpenSSL library, but its support has not been compiled in.");
+				goto bail;
+				#endif
+
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
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "You are trying to use XOAUTH2 authentication mechanis=
m "
+					"with OpenSSL library, but its support has not been compiled in.");
+				goto bail;
+				#endif
+
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
@@ -1405,7 +1558,11 @@ static CURL *setup_curl(struct imap_server_conf *srv=
c, struct credential *cred)
=20
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	if (!srvc->auth_method ||
+	    (strcmp(srvc->auth_method, "XOAUTH2") &&
+	    strcmp(srvc->auth_method, "OAUTHBEARER")))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
=20
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1423,11 +1580,22 @@ static CURL *setup_curl(struct imap_server_conf *sr=
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
2.49.0.639.gf77f2423e1

