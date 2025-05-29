Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493722CBD5
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535675; cv=fail; b=K1O7yGvCRsERzESzY1+rOWVnR4r1BqCh3rQo1GrkqTHpvnRvpu26mqx64/5JN0hglJmU60aPIeXVPJBt6e/ynsAiCqdlWlDjx7wKfl1Q/QmEeUVe4BGcgidopkH6/4ltUth8MU4WTyaJOuS8woCIBtJpjbbpTtAZlxcZkzZ/IUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535675; c=relaxed/simple;
	bh=WPZOgDTuwX++PV/OlrqF20J5BK5YDXeYpQkUafMy9hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sIgL8EplOx+StNPvsYnjR4N6zcVt8WNJ+LAubstFG0vBe8BTRFEfyA7pbx2LPdrc+AMcsMJsHQ8E5NO535qQ6IwJOWWN4tP0lee/MS3+YCcUkxrKltjuS0YtER/+ciF9BFoHYIEXx8xWCvsmG3Da1dZ60iHlSa3VtTo88mV86MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sp+wZ5/1; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sp+wZ5/1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWTQY5nAq6J85dROUi4OWaBTnT+OL7IHKC7G+DKFG5wXcro1s994W4MAZYngEm3rW6z+dFr3FvDDLJxO7S0vPXIO910OMw9CIBdg1TfwGfozshKapCISQhhf2DhpGGleC028k4yPI49CiRspEwc6pSSdNbSHPwNCVeVPgfEuqhNmsAUHtLl/v/aO15xnSgRI+r1X7HlpP3c2PQo5yNGuzxVBiJVz4VpozENANqLsBA+8lvK2qe6ksGH39qJs+qdeyFC4gSuZ8pnXYLOsawdI9JglELxMUV1A7yIISjb0GkaE3JYbfpsf1H07HZNgtqYQOITqolnYoj0I74pnpYReoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNMDthGasJ7YF77CwLUgu/LqV8mpkybR6Jx++LXB9iI=;
 b=JzN8SyjinE4aJ80Odi4+nE6qyoYDFlP5RjHDYEq+7p74lJqlHXqBpm25ZFZkO1WnU6JytLNaJqh/SGetmzwlejIppeDIhcrlWJXtAk92XhmDuTyE17Y9xtZqOF61hyLZ7Oqlq89J+qYCIX6S4N1LNKKT2SND30uzuBcBU4aMsJ2KKeqYKozxpLYjJMxJz7fapGUPD4wFuSMJgE0zp/Y8uiK9sOG86QYOURXiulRbIdCZ/m3MkidZrJRn8AQvgHPYC5CsNHzm+/SuIKingkZzWe97iHxlU4wcFQ6HWzXj3tSzSecw4f4aUNHxER68l1AUNlFnKvAKo1q85DO9xedcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNMDthGasJ7YF77CwLUgu/LqV8mpkybR6Jx++LXB9iI=;
 b=sp+wZ5/1zmyRG3SJWhnq37NRHQsYGp0ChR6GWHmsb1/Pz38xJYIpHs/RVkRBpp7uaAUlQoM4beoZcqJTs3nh3ihk1Flco3le43Jzsf/Jg/LZF3RhbOBcDygZqkjWmaKeRV7pOmhpdp8pl1u+SC4aMaUvCbCBlYOIbr+lzvDZWb8tw37Q1TAsf+9TVo1iGQuoCenNgd4YEv416ndGumJ7FIMmGXRRpIwbeMcjkk0hUv7E/oPpEDrYbUVhNt02p21oH8xj5XygJYBrXinPibXAnDjTbo5xPXi+vSKqcgOjI96dXyPIP1EDb7ewU1pjdfrh9lFSne1TkkDEHnkgrg98/Q==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:06 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 3/9] imap-send: add PLAIN authentication method to OpenSSL
Thread-Topic: [PATCH v8 3/9] imap-send: add PLAIN authentication method to
 OpenSSL
Thread-Index: AQHb0LWtjW15LyS9J0qKfCbBnc8lMg==
Date: Thu, 29 May 2025 16:21:06 +0000
Message-ID: <20250529162020.45187-4-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: 9ac38291-baa7-4026-032d-08dd9eccd067
x-ms-exchange-slblob-mailprops:
 8U9+OAG/EBLERCSHXadvhc9ELuiLr8N5ggUrDJKCLnlUPwaN4vuKu057R4GZJ6dbgHeqzsLMmzFaKemiIB9aFTFIeOl/qmD0TJ4NC7fbaShDDqhYl80li/J3IRiUBT/t+QxoZCPlcMbDOQ8MZXOS5NFqe2qHYhtg8iLuY+Iw18F66YjJRNAYZSYfaCbftyGBBO0Tt5HYIfREC33F3jxZqZXsHJaFZ2aw7ub+yxabL4LF/IcQFz/FdYU5VZOnh2SU2hgxrdMHs7sTkLx5Y6nZlsjIzMKvV5F4nTBrAa69RfLl03vjFZZU1WG0eGSpXSgH5yHxtShrTzRJhsbRBH90Uk97GyZdYN/5BL6DFUVN+UyVHVGCtdimpHssQXMTPotRs0RGA9qxGjchRwiHRCLlpRwvr606xvBNxkLTsApe8CsHEFPECSeXG/ZNmd+CCPAe+fy5JE+6GrkbsUqqzTv0YhlzS3glIDaQzFpD8RVkStc4wLyK6mXQa6W2y/YTfex3nEBD3G+XQliXxLac0POLduv4DKEQmnlJaBoUsMhsISI4jyIUtznRD6pkfAWB9oPRnyOfANpMCdK2D4dBANfO52gzKxvI1aSwYwamSbbVs2FBz/+sFxlaT1Z9L2kCSK5/r64Rwa0Nsx4o9reNnc+WO0K2j20/kKKeKSZ/kJDGXly4jS/SY+RuFjdANh+sAdE0MzhNlml6QfBQJtE2i/1OppA9ZKOMJ+1DkNizREHfQEEbEeXnF5KL/kQLKZrRTjDlXq/i+X8LT1bIyoM4Uh9HO6g3Y6UkZKLevq1r46qEPG+xw/01TFX/n2wsLyiNqUKUeOND6OaW5MXwT4xJRXKNaA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|1602099012|440099028|4302099013|3412199025|10035399007|12091999003|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4bwmpmKqju4rRTv+R26Hn5ONBsIJStBlomBygB+N60cIsmv5/JWou+RqSV?=
 =?iso-8859-1?Q?rYRrW2VrKPD1vXbmPW99RVUc5yGLwOLmXxQ2KK6c+uIE+0eqbSxCr65cZA?=
 =?iso-8859-1?Q?wu6eEL6hAv7EOOH79e0F4dJPUiQ1b/dhCQiO4zLoDVVD8I5hmWz5og2wKd?=
 =?iso-8859-1?Q?Kl1ZbJV5olo37MVJac+T2EpAQmmP0qGuy6Hpm/63hgYGLSFVidazHyFN5M?=
 =?iso-8859-1?Q?a/YJfVcbAKiyzZXFxHgDS74cSRaW4hYoJG0VLpWK99IGgc7lUJ8aMP4MHl?=
 =?iso-8859-1?Q?59uG6skbBL6sNFB1UFrNzrQWQynuPNW8CjZrvfHu4Dj/g1uPNWqmrxQ1m+?=
 =?iso-8859-1?Q?IltygrOaLAz9zGDEjQvErXRpJKa1GtOMXdZsfKeu1MV4Rt/+sAhkRxBzjO?=
 =?iso-8859-1?Q?ETDivYZVh5gWobzGs+ZoCX43dXEIFX/fj5FXceLQvhJiE3vKLCfQSt15zb?=
 =?iso-8859-1?Q?9BK6IevV2YlGFWpc/5t+RJbLDX23sot96oyHXy35R2FVPxBhPTXLJDSA3S?=
 =?iso-8859-1?Q?qBDZTqCyLdxsbq/HCXVvZ9Z0un3x7Q2b3p8HOd/ElNuJJdThgpIzv4fbit?=
 =?iso-8859-1?Q?n65Z5qFlW1EQAsFCgfPc7R6eFJrFhBLoO9GlAoWRBb511/E+SIroUnCbL7?=
 =?iso-8859-1?Q?/RdxbWvfyJg5xEovT/oHxW5oM9d+K9r3VVjo7yAlsIGQkG7HUibv/6I4GH?=
 =?iso-8859-1?Q?IFrvTJf0udvqMCbux2NWd7qVP4hR7gxpGbCxFuETkYiqvf8SL31KnCSYrm?=
 =?iso-8859-1?Q?lCedGHsjezviQbtK4T1aDwU3g7cL+FHkJ6vvWxNx0D1uTffgc5E1y0+S4Z?=
 =?iso-8859-1?Q?r19Vf2mKuA9ZmbT2UQhcp388TXYulaw1YJ6U43dK7daLu1Q4tRA9PEyJIP?=
 =?iso-8859-1?Q?2EWqaXYs9gztScl8Ly9mXwMG+EysLi5qa3SzqlYk84gnFhd3hUkidCP/0X?=
 =?iso-8859-1?Q?esd4Bw9vMxe0j8McXtNAMyPve+2saD+p33xm+OwFJXMDdn575XeXV1tfO4?=
 =?iso-8859-1?Q?qb7wntvh8BaK4RuJDBSWpM0dMMNfEdi5SE5O3g82ix9SDlq6cXJDmWHbSc?=
 =?iso-8859-1?Q?LDaN6Ml4I92NP566lS6crzXMK+a3i1HxT5180oH2kbDMsVWhMu7ynaR3t1?=
 =?iso-8859-1?Q?QMpTjOV786pcJUecTMH+Q5arCvUcUZ7K2+O4m6ipUfRsqUe5SZV0WTYCZV?=
 =?iso-8859-1?Q?q/MbMSy5yaIRozhUoDAFYTZ+MZSyqH+K01grIDMJYSIAv8tJ13uHKA7lDc?=
 =?iso-8859-1?Q?4hT1OFYdMDoOialuOxlnr1jgTFf5yVLOAFdKXL3bkN9hGBeenWHTT2tLW2?=
 =?iso-8859-1?Q?9L54wEX+//2eY1x5aJkpMaUCafJd6Ej0HZUwj2e4w6SKUZ8jHoqRcxqVjd?=
 =?iso-8859-1?Q?tcdQG4mPzdNktDDMigB1z28aCqE5UL0JQN1fvhFviptZcwUdMA2gPfKmjT?=
 =?iso-8859-1?Q?2KWxeD0OtgUgF40DZ/e38IwVlZx2PTy/guEuRA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lnt7MDT7tjjJRJbxx6RN4N02J/qZC+oOsNtYjEPhFB1tyozRcAtN2IcrHv?=
 =?iso-8859-1?Q?7JL+50OzP+lglGpcypwfd0eQiFkRXwN8iPXFyJN5ccVIW5MRcWSTOLC4QK?=
 =?iso-8859-1?Q?sZKl7cmWXVsZ3zIayTe9OgfQYAupnDQuDYIwOwUqJBCazaGxKIU9vmS/OE?=
 =?iso-8859-1?Q?3zrNAllwdAyTs2NjFLp7WdtHykxJ0a4fb2YlcaXOFnV2EzanNFHHOBBmLa?=
 =?iso-8859-1?Q?PpwUjSIQvtKkybqCwzuD4FuUadgHHxKMxQVoSZG6WjaQOYg5POTrcXJm98?=
 =?iso-8859-1?Q?cxpJkJWQI3695DRkFq0IBb+34JqbRZKas1Ih4V/yWGQtcv7ebOdIun1Ouu?=
 =?iso-8859-1?Q?t7cg9/pG2uSCW21eE9CE2hD8mw+j1ahgMpbdVwUOfd3SmEQHJKtUXYRnBC?=
 =?iso-8859-1?Q?0wRKoDplc7LiFm+j8GNc6cTaBVnVsL8BsmZ/0wSqRK6uG8zqha7BIWM7In?=
 =?iso-8859-1?Q?9WE0pWki+bi4vqIlF7hrgFiEAihWeWQki4hYcyANkiTqCUN6ai7eGpJ2G6?=
 =?iso-8859-1?Q?BMvbY3sYw1Gz7swAXXwyg92xtmDGIrO5gGYdd+ZOEcjeWgZWoEzIlwp6sO?=
 =?iso-8859-1?Q?rXxVg2KhAq3P8Q9U9MhwNZOQ1GQG+EsD6W2J4kYSqiFO8fx0daSxrbzXE1?=
 =?iso-8859-1?Q?8uSLjtnXflEe2CGXbqW3QQuZ/c3VZI5B/4JxhpTgeFWgfeJKqMUDU3ZT0S?=
 =?iso-8859-1?Q?/K3OTmf4+ed7eMUSWAXP8JhWSpcX0YEsYAGhMFpzig5/htfLYUQfMGFGpK?=
 =?iso-8859-1?Q?fxDnhKJ4vvy8mAiNE9ydek9OL6fZO8zrKaiqYlu46ASpJtfzXyE9KfoKh/?=
 =?iso-8859-1?Q?sxedQgLxq9vIUvj0x0lFAHmB3f9L7q2L+nF20v3OYaC67b3ZBB4lWa/sA0?=
 =?iso-8859-1?Q?+PS19a8SepnN/VtlBoJ65EkinsGhRdLVYkWRTbi9W41wJ3zXFYus8F22yT?=
 =?iso-8859-1?Q?3BoHS5EHsuMQtAiPcdk9t1P6+EgRtflNMtauq5WY7z0yNxdjXMZCtCtsot?=
 =?iso-8859-1?Q?ZMcB9j6Yt2/Nr5SLNze8sqPrBckg4wVBaQ/jdNXPDFUbKK0bccweeHHuDb?=
 =?iso-8859-1?Q?L+5lotGcRvSQWVXEwVUD7jOGQfokJFygfSO2q+BCHQ5BvQa7F9+WxvEWYZ?=
 =?iso-8859-1?Q?V24NfUvWlmq0e0AjfSz2NLVXREWMpxxY+5/63h4P5a/l7D2XPpMi1auOeQ?=
 =?iso-8859-1?Q?85WrxTxw1xUTqP5gYxaVQzjUtiKYzXj5jOmdl68akrqX6Xuh075gazGKeW?=
 =?iso-8859-1?Q?7k08tsZ9NwQBeOgl9nEWiwwvc18rwbrwY+307s/Wk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac38291-baa7-4026-032d-08dd9eccd067
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:06.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

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
index 0c7844aff2..c07ff98c3a 100644
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
+	    "with OpenSSL library, but its support has not been compiled in.");
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
2.49.0.638.g602e07a80b.dirty

