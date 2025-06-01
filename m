Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7971A2643
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767144; cv=fail; b=Mv9RrlO+B2N9Kab1f/cRpkA9jgkPvd83b30oOnmTRDs67uedEOLiZd567eQ+kdt/DaqDlVTy7GUqA/cW4FWfcgQSlzgle4MnAtZU8GQmR806JKgEaGRoqsyHqUX7C83fSn2hxM5uVQlwOtc1cQi0+GtFqsQeg+2DrdSum5nLUuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767144; c=relaxed/simple;
	bh=MAhAksfB1XXvpu0/glywnhIZo3+bhKTUu3MUO9lvzO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3KxOcKx2nz8fU+CYzH+tItE4OomX2lxx6RlEAechuwm/KaGGb1i6EQYG6kRjEopw5IQhJRuTcUqafChDkHvjH8T4ghPk/MgUNvyAM5BOK6/VvsAVk8fp9kzhnP+epmynKuSG/8+7tVWx0UJr4aKumvkM0JW98e8UnyYrPec05s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=N5ukuAPq; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="N5ukuAPq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UN8yLJikWeJeUDwfPR1bKfC5lRlY4TFIssRUuGIBiT2belt1uc8oUtthJz1sCxnYQ2O3G8E0V8BhN/TMGpIJuGxW+VwP5OVZKd9uhgvzifjnRK+EcbK8Aigr9Pr+QFGNHwjbUBgAop6sYSmCT3aQbRkywt07EsBBIC1/B4aBotFvFNLELXcYOzZUpFneFlPvmmTiHcdOvPmfLkIIPLXuXMYpUEWOpzIRJPoaLeAv/P52iw8x3Ra3ntRC9NJmJR56B7V4bU/Fz1rtptdhzbqpK+mnzVQOHqelkrWk0OcEBU2xCjpCJ3+ubiKvGqBeO9fVZfNsTae3dxXPoZ9bt4COIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wokVHCiphJ5GqDjI0Gz5b1iEZNlIsHmuVrSguUnDEQ=;
 b=GD0AQajHOHx2r7eYajKuNBEjOG1HyOktZayfIOyNfHgmLyrtd7Hn1BBNGpq64cRoRERRnfNVhb+wzyuQyTHAqTuNKPLzuawjI20zp+gG8XnrNyLDyOdEcMulBBElv5u1r/+j6ZXZeexoLI3mwpt9S4AVxUJAIIsfEF0yFQ1OqUCH4FL0b/foCYGeYc04ekY8EpWNItm1P+53XytDWBLK3i9cacL+o/WWFbI3IxiMkXh+oZIs5vA+1tLVYwKG2fBUSSnPxcKRoWCKpdH7QLgcKSGChaQTwDPeQ8mLRiwKRGEfI6ugrtbDeKv41XmmA683vDttrYGorDJHkL0lZRudoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wokVHCiphJ5GqDjI0Gz5b1iEZNlIsHmuVrSguUnDEQ=;
 b=N5ukuAPq1bZvHtbdAeEEcWZ0vjyttD2I4vO4rGsP4ASv6eqHDXSIt6o0aWitRuzAvQzyfJ+xMOMXpft/soW6F2jI2CnIWOliG65ElmbGElR1Wug2U5NUZz7umkdPnM3ucXucdccOHIDAJexRDpzvo0tYtdNc2d9c42Moky5TIDMO93FLaUfPHbU8t5LP0C3yXYhBsezSFRxAwhlMOmUvxlId+HNEYDHNMxlR3k/WG8bRQ9xY/qTWppWQQxmQhLnH9MwcyuKjnsgnszi4q3TP0msTJ6j/uwCILUA1Gjsi5wRfhqGJntlD5n4CvzwJZZwyhKBKOPzmbcyiPdkrxsAYqQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9527.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.35; Sun, 1 Jun
 2025 08:38:56 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:56 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 6/9] imap-send: fix minor mistakes in the logs
Thread-Topic: [PATCH v11 6/9] imap-send: fix minor mistakes in the logs
Thread-Index: AQHb0tCcWtoIpWR8ekOjgEZg/Ha6tw==
Date: Sun, 1 Jun 2025 08:38:55 +0000
Message-ID: <20250601083821.2440110-7-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250601083821.2440110-1-gargaditya08@live.com>
In-Reply-To: <20250601083821.2440110-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB9527:EE_
x-ms-office365-filtering-correlation-id: 8cc9f37a-5b65-4c18-c8ff-08dda0e7bf35
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5QmiMa3p2rJrfOy5rGq2pnOXGwOFE/0Ac39IuUT7igCGTcchRoobGuhmhO1OvBiOzCo++o/bo2BBPSxTPZWYFfEXPXib1bjbYlvgn1f9g/oPwaGA9QvWdl0lg8xryJ8XMKcUYB+oLyRWJV4Xmvq4WHJNlwM8RtMG/bC6PySjU7yaHF2hQcOssE9enMK6Su1Mw1pubgn06YNkJwIyITwhruB0gDQ0sBNKASOBZGsf0KGJv85VOKJLkXMxpTmTJQIstSjjSsSlKuP0LezZXiRzvsB14rYHj7X6qZxIND9W22656AgZHopDpwlGfn1bGHeCNMaGXoGA706eu0lkhyFHQ9NudDsf31SiT8d1lhIWEh1RmbJI/c86RaEedzil8G3Qh/UJ4WHnzV9ouTQQkoQoDsBrTnldFt9EYxzPrpwlmf1Iaf7bhFfmtAP/dC67vLcCWbBimB415KKjNRzivGFrYE6MGzlK8Ga8F2xatV2M06Fk9pN5OFoouXt/jPUEU1mhWCOoa7g/VDOkn8MjVxam+AsDqXY+MP8uE8nzxnGDOqACZxaahlcUkYX8FPz7iUJ1s9tU/pEv4NEZ+kDrY6CC1tVCybyp4CWHegTEBfGBDGBvfXcnHbs6G46zfgbgwZQtAMH4Om/q84eWawGvV8vRXEKEk9/CGXV4fLd0GciyhURWNGIzfRwvqamkLWhkiklzHxVl7lIN1elOZxKjpmOPPsLaErUKK6QMZ
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|8062599006|8060799009|7092599006|41001999006|12121999007|19110799006|15080799009|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XsAsdVIz9ivZvdcumH1m3RHMlRyocHjVjsCMC4oyH+YWe3jr51woIX7Zjk?=
 =?iso-8859-1?Q?/Zk3KV3QylZjG4r5Hdx/S0BgsPmxLasaHt0CQ6fwDpaG2VC/dk21/DokkP?=
 =?iso-8859-1?Q?tW5jMJcrgSqjxHsEyanz+h+guXqclODad8V01AztdAE3a5pBKZ7rl6TH40?=
 =?iso-8859-1?Q?+TpbkklGL36JjM8dFRyl1LEpUas5HtytepNM6p8O8Wsd8MgzDrUoYEPoC9?=
 =?iso-8859-1?Q?l7OxMoA+w9U16KX7GF8P9kgn3vIIGHKi59Rk8zu9s1/8qzpAJJLwOHL7Gu?=
 =?iso-8859-1?Q?m66PXLjBJLXeiK62y64zRmzYyqZz09AQ+EmagtK0n96oRAXzTgDoP3Gfd1?=
 =?iso-8859-1?Q?NFJXv2fEbgFU7KQ+FXMb9xj7iEjhiGt4J3CD7lWi/8C8NLmyqBORu4QcAP?=
 =?iso-8859-1?Q?at3pulAiv3wtysWWQIbspc3rZQrjsao8xz8sv/oUufJF/RvdeET1rUhgfx?=
 =?iso-8859-1?Q?884YKC3hv+9LYS+L8Du6nm7Tw+7MO2sV1uee+IbDNu/6E+mhJcUeSnteSU?=
 =?iso-8859-1?Q?4hqiWQY584d37QPxZKr97GjOFUeopC7/L5dG3N2Gnx5LpcZI5UCss/L02u?=
 =?iso-8859-1?Q?5hou5jv2xkeBtXBe9asfovGPliTzRtzb3XG4Hbb53ACw5qz1rwOoDahuz7?=
 =?iso-8859-1?Q?NWE6EuIj5FFGgI5Wm/9HumoQd249yx1GBCP+m44b6XCev4UOHsCzVo/8hi?=
 =?iso-8859-1?Q?8KSoXgGMSZsPaYTmI0V7hxs7te9WjiMZi7dO4NgiZmtjzpSTv3G18I2l5P?=
 =?iso-8859-1?Q?3R+eZDGHXdnh8JcnZFfrcM3UoF4KPaFP/aG/rMhKR31bLCyb3JHk64dNV7?=
 =?iso-8859-1?Q?rbVEVZrTZGjwRoh8lKFulDhJJPHNiTR0XyfhIRVkfBiCWR4vv2GMe4V9TM?=
 =?iso-8859-1?Q?KrPut2TQATWnIFvzjkTy5N/6csA1T1hvzR7xkWyhqWHHv/nAC0T2pPTnS/?=
 =?iso-8859-1?Q?xvzYHAROd2asD84QQZKb5+m7nS4gQ0TiOnPBVwDiBeejWAFgqE9blhhV2n?=
 =?iso-8859-1?Q?aSfoLPk8ct7/3eKR98HZ9luqHChiXLdPUIQTYr3PjS8IUjJ1YP/nTcXQWI?=
 =?iso-8859-1?Q?uimOLgykiSJfAuAJSr4MWJeLtZmmHZs2JfgYzPDI9MFluFmuFwjy0eW1mY?=
 =?iso-8859-1?Q?qyJpTgsuWULb2oRRnMmEvGgflr44EsaRJkdz0a1Lr5NbRFGO1yRyVSLsiF?=
 =?iso-8859-1?Q?qqvCTgDPdNmVP99i68k/sjFYu5LIuX7eFBKV5DomOw2GS8paflbcqbq/u8?=
 =?iso-8859-1?Q?f61R2uS7Vzroz+Fon+MOx8UHaOxNif3s7FDJLbLrM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hrM/kwJxap9Xt60fjultGDzQ9cc8DK5DkCb3ykxNBlTt42iQ1T7mStKXfq?=
 =?iso-8859-1?Q?nO/OcXQhy0tTAcZex6t9eZLYBfSGsRB0gnmzGxdrAmqJ+aUO2MVqusnvTu?=
 =?iso-8859-1?Q?hHBW0mwi6zAknpiJDNPZ1GNptCAn+Xgzi+Mdv0PZZJQ634W8MlN7gmbPQF?=
 =?iso-8859-1?Q?7LbLsXQVjpd7/DsWi4bosH0snGJuIpJ3YmrEPI1r0LlbmPZpVdR98saVdK?=
 =?iso-8859-1?Q?O955gr9gkZawpCc5QsQHI7drb/HVuqTGjW9/hJ9TsSeSzwOzb5/mzInWOH?=
 =?iso-8859-1?Q?lp7L0C2289vzNO6UNFwutZOKHsnT6yhjPsaOBh1Xh4xzL6lsbSE9as7WFS?=
 =?iso-8859-1?Q?BNObkAYW3fpGweIK3mmYiZ4fXdUTMhU1oQmKpNTVt1dcLfSaM0PaD8qC9q?=
 =?iso-8859-1?Q?Ya8bf10YNm7MZWY+mmbKaiOGAg+Nk29Qb7SpE4SGe7GIKwlWmn+THgfrOa?=
 =?iso-8859-1?Q?VAkTHCkUgILR2sUDdBDf4SpjM2FSb2qbERtBJ8JnMUmNMXK3H/YVLdxxmo?=
 =?iso-8859-1?Q?JY185ZFgWWnb++l6v7/nr3bAHOI5K37L4HK6d3fM7kCAgjIVz6EXIiLMGD?=
 =?iso-8859-1?Q?dB0pLJn5qJ6mF+/e1WJQQ1SI/Lc5HgZE9XvkJ16clBHV/b3zSXZ87VO7VM?=
 =?iso-8859-1?Q?pkgHyfrXhu+KeOPBmnv81alP4DDOSkpYnOfRt4RXf/usHYQFZK+mkwxsiC?=
 =?iso-8859-1?Q?kzUkI4/ijEv6yIcqlgeklkssBeelSCTsTb1vRUN9/mGcPnO+YNQymo7gFV?=
 =?iso-8859-1?Q?alTSNtX5n6gVG0f/9FUVcA9esPAGXERhI5ibKdO6cAavFgvfhmF4o6XOaG?=
 =?iso-8859-1?Q?6EMzP3oIUw9Z4ayBUVjAtBnXdTdwoyF6hwXHQOLO9xeqimgsyZqZ7yJ57b?=
 =?iso-8859-1?Q?lCUV2fsM/5rYnPdzaVgcbbUJkNxLcrb9X+XFjRD1FcAGWmnRtaJpXOWGFF?=
 =?iso-8859-1?Q?2q4pfsMJ05dd1As+bZB5DAp05eHKuHC+MG3fs6en7y1MOdgdASpJ46Pbc6?=
 =?iso-8859-1?Q?0/di7LMuoc8nbyryfLnFrui5hMYm7Pfk7AR24DILAilgXyjjILz48a6Xlo?=
 =?iso-8859-1?Q?zixUBlAJ3wuGm1AjxR2a2snhPT23ud+vJXsG6qKIJczz4LTT5vhfvIZhn7?=
 =?iso-8859-1?Q?nnKHUAaFYAReo9fd6+C3XPXqj673SggdrqLDx/9B5T+CioGAfU60qZJVeP?=
 =?iso-8859-1?Q?7YzV5Bs1GudgRdZMp5oqmultT9E6lmMJ5CcfeSNlZ/jnTDUvUlxHVpa0YS?=
 =?iso-8859-1?Q?6JQeDg9F1YHxw4SnSmtHJ6llFpfwmFWwQDEJaaaF0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc9f37a-5b65-4c18-c8ff-08dda0e7bf35
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:55.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9527

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index cfa335b647..97e7fb197f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -205,7 +205,7 @@ static int ssl_socket_connect(struct imap_socket *sock =
UNUSED,
 			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	fprintf(stderr, "SSL requested, but SSL support is not compiled in.\n");
 	return -1;
 }
=20
@@ -1053,7 +1053,7 @@ static int auth_cram_md5(struct imap_store *ctx, cons=
t char *prompt)
 	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret !=3D strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
=20
 	free(response);
@@ -1152,7 +1152,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 		imap->buf.sock.fd[0] =3D tunnel.out;
 		imap->buf.sock.fd[1] =3D tunnel.in;
=20
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1171,7 +1171,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
=20
 		for (ai0 =3D ai; ai; ai =3D ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1209,7 +1209,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
=20
 		addr.sin_addr.s_addr =3D *((int *) he->h_addr_list[0]);
=20
@@ -1223,7 +1223,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("error: unable to connect to server\n", stderr);
 			goto bail;
 		}
=20
@@ -1235,7 +1235,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
=20
 	/* read the greeting string */
@@ -1338,12 +1338,12 @@ static struct imap_store *imap_open_store(struct im=
ap_server_conf *srvc, const c
 					goto bail;
 				}
 			} else {
-				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				fprintf(stderr, "unknown authentication method:%s\n", srvc->host);
 				goto bail;
 			}
 		} else {
 			if (CAP(NOLOGIN)) {
-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
+				fprintf(stderr, "skipping account %s@%s, server forbids LOGIN\n",
 					srvc->user, srvc->host);
 				goto bail;
 			}
@@ -1599,7 +1599,7 @@ static int append_msgs_to_imap(struct imap_server_con=
f *server,
 	}
 	ctx->name =3D server->folder;
=20
-	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
 	while (1) {
 		unsigned percent =3D n * 100 / total;
=20
@@ -1708,7 +1708,7 @@ static int curl_append_msgs_to_imap(struct imap_serve=
r_conf *server,
 	curl =3D setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
=20
-	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
 	while (1) {
 		unsigned percent =3D n * 100 / total;
 		int prev_len;
@@ -1792,13 +1792,13 @@ int cmd_main(int argc, const char **argv)
 		server.port =3D server.use_ssl ? 993 : 143;
=20
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "no IMAP store specified\n");
 		ret =3D 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "no IMAP host specified\n");
 			ret =3D 1;
 			goto out;
 		}
@@ -1820,7 +1820,7 @@ int cmd_main(int argc, const char **argv)
=20
 	total =3D count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "no messages found to send\n");
 		ret =3D 1;
 		goto out;
 	}
--=20
2.49.0.638.g5e24c6cde8

