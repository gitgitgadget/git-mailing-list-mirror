Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9223CE
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220973; cv=fail; b=gPIV+0yniriBNT83geWhSVwcYmKlFFvLpBPiaHTUixI0Eqc/H6QvIoF2i+93UAlJkHhuZxVx6S60lrIri6TXYBN5N8wUQa3TG4KARNnq1vLasmNAVA4XZM1sRdRi6QTIEuxszT5M/BXzuq28wdPlKgKNk+rk1qi0T/a2WjydIJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220973; c=relaxed/simple;
	bh=/XNka2kK9go4TBfkW2fLyW3QZVd211Ryz+ITADAnVcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ex3AwAa3qmWkGzOFT77Ru5LzcpmBxQamDnIzNpEMV/He2YNrVBrmqi8XnNlaqvBfgy1FjXm1AFtp3HsULT+qWy7DxGCzUlZ+kH1oYvRexSJHBg5cb+gjfTSTxlcBPb8IaWf82FclgYTlfB4AXwbgvTt+qy6JCPNRLz+UP87OKG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uDkBtJzC; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uDkBtJzC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMZxexgpQ6TEctpPDFimtkiWpqQ61aQzUANJuSTcZDU4V7VD4lNxr8Q7fwG9NTCyrxq60iImla4TTJe5F+p8mELSux2RXCCFb0McQo9f952WqtiuUPW44u8vEcavwD1OOg5xNYwl9RDz6Xgffh8/U6FspRqNtll0M+pdKS1hx4E/HujU/8CXQpxvl7eIugixwM+iPEQ0yA4H+09YkbA6QO655zhwdNKw1SjyPX6KHVXfDxG0hDy2ZUuyNoc5ujaPMn/aTlsqbwHrCMcOU8BnLz1Dto6Ftwmisc9N0Ie/ZS+y93fGMshKdr2M5LF3J70c8l48fqTpCLOUM1PcI2yh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsAMRXhbo2jjaJnEDX3512jN4yerayaeZMupmXNdmag=;
 b=GkFSPakmcM7+qdq+2IYJEdJLKniR2MJA/czCQidfFm6+XH6mgSYpTJPNS+tmHgGuQMRQIm/I5D2e9iIaVqAMWLEr1IUajFNNtQ6yzC1cx497yobQrJ8c/HvFlaUIlNRhUnA/1iR5jbCQJj8z3tK4eh7kRoua0WpKnvtbpobisetQoj1bn0Ymloln9vgiWfLN5mULBBcUTMw9J3pGjHBQSaCVG71CZ2/7+23Yh+eJ+xXwdODKqXDA0A1Hu0sxiXWeX6PKJiWDcGC0CTTrr1CLPVfwmrwKuWD3MUbFRkeVgBpUc1jvQpitihXTHQIb/UAyCIF9Jgj66Lz2AVr0T+qrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsAMRXhbo2jjaJnEDX3512jN4yerayaeZMupmXNdmag=;
 b=uDkBtJzC+aOfg/qlBcsGr1uUbRQkpz//OpDOakDRXgTariMQNaqswHaEEqXIU8Y0NHjaHzxr6o2CC7+tkvNgrScX3bAnfdhJG5sMQ5tI/1XkPtVc3VeT+t68fXVSYQF9RUejeWpA8+aw2W1YjLPj9iQ4uo1CawhW0OYxtujyjU2KNVO+1SpY2S5vXtRjNNE8xkJQLt51THR0pZV08620e+vuvqgEnyrU7wuNm8gMpwiVZ0UxIrKHZSb93950uuzxastMh2V9rEUh50pTaaYfGW3uYPXwFHhMzWY4X42vpwgPHBAd8kLlu8GR/cq/MsP/2g07SESY0pVv9n2Tsp+PZQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9431.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 15:09:22 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:09:22 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Ben Knoble
	<ben.knoble@gmail.com>, "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] docs: update sendmail docs to use more secure SMTP server
 for Gmail
Thread-Topic: [PATCH v2] docs: update sendmail docs to use more secure SMTP
 server for Gmail
Thread-Index: AQHcFptnp34E309NGka5moWXQM/U6Q==
Date: Tue, 26 Aug 2025 15:09:22 +0000
Message-ID: <20250826150919.5239-1-gargaditya08@live.com>
References:
 <PN3PR01MB95973B72C16F68D63BE2B410B83EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95973B72C16F68D63BE2B410B83EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB9431:EE_
x-ms-office365-filtering-correlation-id: 8e9b93b5-85f7-4098-9e61-08dde4b28a06
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayF0bP0FcI6aESyZnZAIXMvqjFvL36Vfzw0KU5wzOgJXcrSttX5S+h1V02pxuFL4u6uq4E0JsoPMQXHRzl/4BWXRgAo8aTKddvf/whYDpO+9/Wb0DHh/CpuJP8WdAxCyPzxTBobQHV/EDdqrRiyPUEjoj29A5xOuHd0ZUmS3MpNlSBlm5yqDv92d7D8cBQMvyhEmBSZ7atUkX+h2tcSVMYkVUzyJbI+tC8ImTmi1DNsZy6PeS107LaPi+rrWpsnUjHEOydXtNuMb5eQmYA4LuFHIVWZYbUd6klpYgPnJq7W9WsQcY7Z6p2W1YBlI6rUW963IolYuLLdwzzkEwwi5aug1PEcWPIyHif4Tt3+rGeGMdWSUIumQV7m6IWl3vByeW2w5sW5INLGrFKeDh2V2bDVrIFACwHuqdcdlwsadbPQ30FsOEbWIeUz6RPOe4p9hc01dPpyQmLo2988o2j4x2Xd6lf/MOZhHn1v/xyGCcKXQg5knkciXqB/ykTy4L8i/S+AU9SwPHM2n/Bi/c9BvsHoEJXAdwnV96EFsvA6W8bfoTBmEWKhXLHSgwyZYr3YT6erUZKo+mbXCnd569krIU1Dn1j5TmwHZ15otzlmADoxfDlA0lXwzL7Sz5nDhKkpAtiZOYnA7HZ4HdiJtpmOZ2bLZ1z2XYpoea0NNuQlZ5STKuRLfQSLlrNUr41JpHxmgrbTuoWJLwY6Ff2fO5yfnsLDD6yJ6fLpOnz8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|15080799012|8062599012|8060799015|19110799012|21061999006|38102599003|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?O9l5mvKPonPjewujbCBtCvbVCWxo6Vh96wBNEkvYTLPtuEK5H+GbqXfASQ?=
 =?iso-8859-1?Q?6Dpb1gwFxlXBVRKAT7XdIkKuwsNMemEpPzXNy/t1GYJIoJUK8ndFgwC920?=
 =?iso-8859-1?Q?0u55xF9JSfqCNnObUlDhWmTi0h68RsB5g7gkdVGlXcUsk7bdfLRVfBhb1j?=
 =?iso-8859-1?Q?Dg7CZ/NmalKQc3wsg62EnVkb4/oO7nM6N0+LZpn49p5ScT2iCTE3n80Bgy?=
 =?iso-8859-1?Q?2wRmlVRJ7fKhPzQwMx2jpkkP0uM/h8PFMxIlJZyY+uZMHgfFLH7IHmROfD?=
 =?iso-8859-1?Q?XTH7BTz1cuLUWeQGRoTrhBVwAkjgUk98TLuAOsips4pNh5OFBpD0BlMh86?=
 =?iso-8859-1?Q?bygJLPpcdW8qVQCDyMUmGFzbS6uSmXa1oskI59mXjxCm8XHU/akltPwpRt?=
 =?iso-8859-1?Q?Aw59POYy2wkR+Y+qk39JWLaCTEzxIuCfpVxJbYLxEeMiO+7nKCnBNSF6ok?=
 =?iso-8859-1?Q?8c9Qx2flLs/dKreSw6+IOfziOXuvJBIav2PPpzsg5z7h9pL9zQ/8E7OJnp?=
 =?iso-8859-1?Q?JG4BToGmST8r214Jyx8k/cfW09/V1hrR+HUyfbpawwbmKHQFhAtclYqyx6?=
 =?iso-8859-1?Q?iuXTGhqtTNwC0Ixvj7Dj9TXySjygTAoLKMs2WN07vKkbhcQvJZOIkbupgI?=
 =?iso-8859-1?Q?CKFQMd5406QGJvSCiabNvq5dE7HmVh7pdO0Eb/QlsRGiUYwP+QCxAohGZg?=
 =?iso-8859-1?Q?3xfD2ZB7L+P4gPTUndkAC49n2UfIZMQzK8pJlqomOWCeSW9ErhEVUW4H98?=
 =?iso-8859-1?Q?eEm5pECZuGSJHGXfRYCqZ6n8SviwZXvtd9ekZHdc134rfPyJq5rfETXrJK?=
 =?iso-8859-1?Q?4ufGwiyWmtFmhHDSKq4YiV37KxUQ0TQRWHWbUQoIjBZADlxvaLvhy0rchy?=
 =?iso-8859-1?Q?CtejSEHaOzsx/FtiwAOGRHpJxg5ngYWauHpHLf8ooRXPUHiA0GVshdUMtc?=
 =?iso-8859-1?Q?NE5nSLvSCGPO85TSwFFOEuJcq9J9D61+sU3A5CocyuiKkWidvZF6YjAi62?=
 =?iso-8859-1?Q?FBDI8d3Xnz6YD+16q9CXO5ypAw/oiEkc+M4rKdEM00Zmaa1aC9O55QhbRy?=
 =?iso-8859-1?Q?RTlkrwwPQZA6362Yl8XjBL4JacTwAklc4OPdUZtZ+w1QI/xml6gOuiCMGv?=
 =?iso-8859-1?Q?8GIko2qkcgQ4rdNn+qR25s5aULX6UzU1e3LSVor4yiO6v2xujZB9acbzxu?=
 =?iso-8859-1?Q?MxvJWWVDIPQ5ErHbFidpOJR4otLBHGiT9YoQCPSuQWOqZtBYLtrl0XseTu?=
 =?iso-8859-1?Q?kF46x7pUNBLOBxIH+x6g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?u+S4lR9s631WzHnHZZjocBVlCART5cbu1nl7eHXsWEwOUS9hFwG1vjlZ9s?=
 =?iso-8859-1?Q?BoAdoxe+enQYK1Pjv3ySX/P3r34gYOESBZ6n5PHGurbrveS9PKmw05+Opi?=
 =?iso-8859-1?Q?Q8DLcMv6aHczn9fyf7b4XIHIZytKGB16LOTCNVcjHk8F3TZuvOMd2RanDU?=
 =?iso-8859-1?Q?YrTMVVNDAJvvfA+k6bOatMc/Q8HDHPkNj4D1xOvhv0g6oBXGb/buWudVXe?=
 =?iso-8859-1?Q?Q77BX1eNXMzseXb7JurKFrJjpQTyVfOMmwIU9iOuivJik4Ksl+06Ih27ko?=
 =?iso-8859-1?Q?c7CbzoGipGx8KY3UHXE2UUxEF07QH6Do+f+BnH6RWaHi62/XFDZear4Fm0?=
 =?iso-8859-1?Q?O//K8bexW7zRWT+Lo2ME65LD+QeEmC3JdApqZdbUUz2k1e0l1+FjvSAqg1?=
 =?iso-8859-1?Q?MYlUd5FoIHqIKNdvXmdy6Prh92rsQIlEJGjRCUjqmfYaDWdbpcCLMxp4Nj?=
 =?iso-8859-1?Q?4MyfyYaKTuUr9flMDro+hpnrJjHMY5NRNKkgGIt3SKYqEQvgAqUwzd+ff/?=
 =?iso-8859-1?Q?i+dsI7XDhGfxZ8Zjp4i6TBHgX41CzuobFLYq41sEGs0O9XbYCYfREO5UZ4?=
 =?iso-8859-1?Q?XVG2uya1SH5beybTbdOTHF9CcN0BLN8aWxFJID297Im0w4m1wFs2Ogcvr4?=
 =?iso-8859-1?Q?f2Psqa95UihZQvDMNaReghNMkfvh4Tw5ZEnvWsQc/a2oR1dRZVAeD2TyPQ?=
 =?iso-8859-1?Q?KeafbXPrFHM2jPGVKLdMd70DmLnEBbMhVcT7p3r2dchDJmzy6LqPdr9cBj?=
 =?iso-8859-1?Q?38kb1grGUJhgUd0s/unHyrSu36BQ0ZMbFjrmv5g7qQd26KOBtacfgRaKdB?=
 =?iso-8859-1?Q?qQ9jM0HTTAunnLWGDTReAamwWQdnMIUxzw018lBTpD9J39BB/HyRCXSOJ9?=
 =?iso-8859-1?Q?cGDwa8jaHZGgtXCApXjqBfcMT2x/NXUbA2nKhFRLb47qrMKCBwB3102BuN?=
 =?iso-8859-1?Q?taS9XRkup7jtyhTGbmB1vA1lfeZ2gp+pmcpG8o2K9vVnS3z1dYxSFyC40p?=
 =?iso-8859-1?Q?wBwL0V3lFE+o/1hu9QucP4en9iuUuJPhzDGIbv/g1EBJtHNyAqc7436c1d?=
 =?iso-8859-1?Q?NTwBuRtJtjzPpnFimZcS/aNGAJtydVJBuyi5M/e126YId9HB+5BwfXxBPM?=
 =?iso-8859-1?Q?8oUgF997AWu9S6Xl7JWvNLwVxBEgXzklkfEljlwf0/oQIqUJQWdZc12h71?=
 =?iso-8859-1?Q?bBvWjxrvIestpirhKBwRY8do178DuXcVx9mrhldX5XkgALhUA32ZmS/T+X?=
 =?iso-8859-1?Q?XGa8KMZEoIK0E8IZDGYmWT8wtqvaWGhRJV5ylCqNc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9b93b5-85f7-4098-9e61-08dde4b28a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 15:09:22.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9431

Earlier recommendation by IETF with RFC 2595 was to deprecate=0A=
implicit TLS in preference for upgrade an initially unencrypted=0A=
connection with STARTTLS command.  These days, however, IETF=0A=
recommends that connections be made using "Implicit TLS", in=0A=
preference to STARTTLS and the like, completely reversing their=0A=
earlier position, in RFC8314.=0A=
=0A=
Update the GMail example to use the implicit TLS to match the=0A=
current recommendation at port 465.=0A=
=0A=
Signed-off-by: Aditya Garg <gargaditya08@live.com>=0A=
---=0A=
 Documentation/git-send-email.adoc | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc=0A=
index daddaae36d..8aa54e36e7 100644=0A=
--- a/Documentation/git-send-email.adoc=0A=
+++ b/Documentation/git-send-email.adoc=0A=
@@ -565,10 +565,10 @@ edit `~/.gitconfig` to specify your account settings:=
=0A=
 =0A=
 ----=0A=
 [sendemail]=0A=
-	smtpEncryption =3D tls=0A=
+	smtpEncryption =3D ssl=0A=
 	smtpServer =3D smtp.gmail.com=0A=
 	smtpUser =3D yourname@gmail.com=0A=
-	smtpServerPort =3D 587=0A=
+	smtpServerPort =3D 465=0A=
 ----=0A=
 =0A=
 Gmail does not allow using your regular password for `git send-email`.=0A=
@@ -586,10 +586,10 @@ if you want to use `OAUTHBEARER`, edit your `~/.gitco=
nfig` file and add=0A=
 =0A=
 ----=0A=
 [sendemail]=0A=
-	smtpEncryption =3D tls=0A=
+	smtpEncryption =3D ssl=0A=
 	smtpServer =3D smtp.gmail.com=0A=
 	smtpUser =3D yourname@gmail.com=0A=
-	smtpServerPort =3D 587=0A=
+	smtpServerPort =3D 465=0A=
 	smtpAuth =3D OAUTHBEARER=0A=
 ----=0A=
 =0A=
=0A=
Range-diff against v1:=0A=
-:  ---------- > 1:  6b73d4bb6c docs: update sendmail docs to use more secu=
re SMTP server for Gmail=0A=
-- =0A=
2.51.0=0A=
=0A=
