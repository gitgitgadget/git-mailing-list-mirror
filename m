Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618831AF0AF
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767148; cv=fail; b=I2ueNHkHDYbDQ1AxTcxN9/r7Tuhxqwiz5Ius8Va8pQc32gEZlXBu85F9v4INdCkCHINjsSghu6sGxSp3ht/AfAwJWJK5lo+jOk7yd/OQVIMiv3oGZiQpgyuMcaWBVEFutX3IuGB8YsrqIbJKXexGIfvarj23WsulPgu0zCX6jVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767148; c=relaxed/simple;
	bh=5PnpHkccoijg5PIdPPXU8H7rh/yIvFGlYiM/U7It8h4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8zwWY304W7IDk7BAX1CDaGWOA2EhL6XYLgCXA8ebr3I+nJNxJguu2hno9DamOCB3yWWq2zmhPmaElai8ooDnRpZr0DSsxXGPmKmnMq8vqpKRsoL2seohvgxbK9RUXfiHPcdp22dGxMXujlO5Od49Rz2uKwsjLeTtXjmkigP9SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KXWidsaU; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KXWidsaU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJRCp1eGFmaMwccxRXehcrFP7YLROvSlXKy0Fwp7v4+uQicJ8B6AuZR82hqmuk2weNCPnArGhmPpmtcMPcXwCyiUaPx/tZuhEjVEqGHOheFC7CJzHfugH+qHmNrq+E9E1memvs3jeJ64XbFtYTTkQu/41i45A0Gr4KNYcNJAVWxabPY/5HZN03lbUpg1Pdql/fIQaO/iYmcU/EOkswNOxX5lu9okYE6hxZrwIXVI9ZUDRTGBpOdtFEey4RUMStRJHClCGeoGtwRwYmyViCMAvq+e+FvQ4zTpY9jSiJpjy8905eX7Cm5f3h+4Rs4slvVJYw4U1UX62iqgd4IFMh0yFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcAghNl4SLQExhmQywv+c708IJUqrfLFK9+PcOJu9c4=;
 b=Baf1aeYOZFIRfC4fXjSlAtQ4XQn4y0NcMs0VFV8hH2aIi+A0XwHCxqdUisnmkEGlhBSkb5UGCLZHRdlRNrpqyx1/LidOIvXyDir4lYwn57Vg9TLCEbJMXXFqrAYjQ6lQ+YDD1d+GT6svXclEREpHlZk16+vK97YTc7+omLPvTzMZTDGOk9ze2fLwv0/SIInm5D+3UaNJhapS1GBq8tGFv1jVM5SCZh1GK4p05Id0LNoNJ/8TgkKK8VjpQ1Tx3xFQ8sGq47KTaqzLbMkV89vM7xKRS0mX3FxsMcAOue14blWr7yNurmhOAStP1nhRO5wo5BqHVcnIz49nwukigkSEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcAghNl4SLQExhmQywv+c708IJUqrfLFK9+PcOJu9c4=;
 b=KXWidsaU9vjKbhHwKtX0TWypUJAwgXXiJkM/F+BbUPKtv7lkkBp1FCB2cVeGWynB33vig30O+zHgwZM/0gLPWi7cxut+EQXwEjkvTBEDoVqGkqsz515WFbvOnoy5AJ3UAmyTPm9X9WvGLYKsBbOIACXaGw/tNelHfnEviRqhfiLQ01k9yvcLI1RQQYF9l/i3AexqZmN0oAlY4JA4K083wIWdu3OuxQyh+PrfGONm+Pq6j7w1a2uRxYMe1NhP47tLWyF8zYsA5yBT+gQCbOVn2BnmfkUUzlLb0gHkCpOO1KRP19ffahxJjvKm0C5QGt5zlN1CbdZ02cVJfEl1el0xKw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9527.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.35; Sun, 1 Jun
 2025 08:38:57 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:57 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 8/9] imap-send: display the destination mailbox when
 sending a message
Thread-Topic: [PATCH v11 8/9] imap-send: display the destination mailbox when
 sending a message
Thread-Index: AQHb0tCd0HXsljCmuEuO0EPh0p84xQ==
Date: Sun, 1 Jun 2025 08:38:57 +0000
Message-ID: <20250601083821.2440110-9-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: 61d68042-3ebe-4e04-6492-08dda0e7c019
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnF5oAkD/pH/pT3EsSPbJJWQsPeBApmgdrHnbI/abMddcITZbKQHOE/QSzHvGI2FhyDsz4yv1XF1A7hPIyOcZrve7UpwpkPmBukmMVXOL6OhUszaFq9ufp1isx/1y65r4IJwhgIBAINHQfOphbupn81yWF6+4WJkmDtgejn/8UPFH3rXzER6s7gOIDSZnGTXZ4Qr3g133EyT1eTnZ2Ot4U96qk0FKNy1Mkx6Wy0/ATa2F0uDjVv04Py+KePo8zdhXPNBjJ0strh0GXW2I2Xvp2/4y0WyzDJXNjon8M3BDnFEh4mVy+R0qefSj3zJXQk4gj3d+KNBOe3oNC8D1XQcWbNV+F8U7bAuqMfW1xjOh1/nA/WUgNMNJ5HSrIpDohaEJOZ5nEXHvQpxnoLfVa7pa3mCApa9kxFIsUWQpA9AoVQbkIJaaw3C/MIBCOB8aefdyzfeFPVFEEEnNQAhFzC785yomTnIkfLwiZyd5vUXiiro8jRuYz6oci485Di29O7JNDURmYDSCcv4CUl2ESJeZIv81eEJKA6WYx5psgcrHNn7SA8JENek/aDqux0rlrzwpXDbutVP25bExJHhD56SUS+ZAlI4SU/NeBTT/13iQl73yBZ7JaI94wi6XFYKK2QhyipVqERTMZv4tSMVXL7Oh7EvyEqnyTx7zUOBVxg0ODArF972d9PhcpnzwifhTEkjxK6oKN9Q/x2xfZsSw2xRkA0BxdNR7afQm8+bPhMOI4bnk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|8062599006|8060799009|7092599006|19110799006|15080799009|56899033|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DgGzCGxpNN/lxuWempqIFFrFQBkmbCbTjSeg1A+2QRPA8RX8yYct0DvCJQ?=
 =?iso-8859-1?Q?Ek3BIzEJ9qYGdcdEyPYfvw22yxp6H5Fs5yl4wQpNR3xz9EG10l6oDaVjUI?=
 =?iso-8859-1?Q?XyghvOfowLjStcBa5XdemlkfgFxKSOnHJAa8aUbvJHJ2aR00oZzye4y0JM?=
 =?iso-8859-1?Q?Q9e7L1f4tOp8fla4YwIHRI/bvwl6qNEzNH7cqmH0h4gVZbozBWzpV+wse0?=
 =?iso-8859-1?Q?KsPFobUWKogu43MNmM7U0te5JD0gXA0itQH41qawN3lskNwZGo51L0ownr?=
 =?iso-8859-1?Q?WPzLIGgt2KtDXfD49hbeTegBKG6dNIYs5ug1qVVuS7D8aR2/rrBsZGKVoj?=
 =?iso-8859-1?Q?eOZApe0HEuTi8KjRANZLYEOQr1Drs0fMemGhS1NYoittp3VCtLAGzOBOkz?=
 =?iso-8859-1?Q?zZ0jXp8aSZCXQGLUPV7rhWBz2tnRxS1+OAxHdZhL1EH1kNH8OkUGMU4y6O?=
 =?iso-8859-1?Q?xdB00T8A3dagMoLaOW4F0r7KwjXrvN5vygc1UHNJoNANBc4GYCs5Yp8X81?=
 =?iso-8859-1?Q?VGo34JKhZcyjfcNgvq317hWXWVkbJDnTKCVFhtawCbdd5TNce0cXasoEdF?=
 =?iso-8859-1?Q?3T5tWgEZdRbEn4ekgRZ2ejTh27m7ZHiHkW8036uv9H9looAcpiympdHCyL?=
 =?iso-8859-1?Q?mI/tSMGii+DjjDROo/PBPJ4GYF0/NGZa0YjPv7LFUIcgJXohcaBBIzJ6z0?=
 =?iso-8859-1?Q?FhTrSenU8loFd26CzPzqueg3q+Oh2sV89DDy0mxhpWmOcp2KSgyNSfP4nf?=
 =?iso-8859-1?Q?Tbx9m6XYtJDtCkF2RvH4DOODoYo62+U4mAS/ic6ftyJBDYkTiaUAADe7nJ?=
 =?iso-8859-1?Q?acwrzcxWtPtoSmQHCcoqtweEXAdurh6KPJPVEPBBhMrA38O4JMGtO9wpkv?=
 =?iso-8859-1?Q?Dl6q2l3/HVFioeYFBQO90k0/KL3Uut12r/+By9ciiujLYroRCSeWOrB6xv?=
 =?iso-8859-1?Q?ynSi/RdL7dcjN4vRawyQNaCNzsIDGy9zooSAv1Tal4+SxPphlfwlTvYtA6?=
 =?iso-8859-1?Q?PDbZoPurQb9L0T2cueImBpd7wXriahlIeL3MvWSvgsyb/9KmlNw7ukaJwV?=
 =?iso-8859-1?Q?NiB2qopCojuissY6MP3bLBbvz4N8nugosyqlu3fiUgk4gqnZEeRt+kb+VH?=
 =?iso-8859-1?Q?F+B1UvYJCFPmpa1aqzOaTRpUC3hAiwx+ajgvAXgjok4IITQiHn89+lbcVB?=
 =?iso-8859-1?Q?bmxnRVdj1bQ6HQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zjYRxjB1d5+4zi4V2kzjrLJgcwgCfctpNhuKafNh8x+e6iIIl88DGr956p?=
 =?iso-8859-1?Q?vFJe4dglYlRvGsoz6mGvQ9MGntLZPMEafGS0w9LfKnzf3TdNQDVKfw6Oj+?=
 =?iso-8859-1?Q?ffJouCD3Sgvee+7nnliGw8L2QV9rUUuE3hW7gxNkcLDSOrJtI6IQQ+WjLe?=
 =?iso-8859-1?Q?5PTZXx+BWp7p4flHtSyzLtQDPAYsgMoeLD3GFX8bffxuTbWWotWKYpdcee?=
 =?iso-8859-1?Q?vxicY9Z01HS+dKjXJX7S1bwIfLSyKQUYrKPzCsSiBKkB10EkgJSMLrHjHh?=
 =?iso-8859-1?Q?1YUVBUQAbn/UKqETsIYxys9pgAV8I+UqX5DpXbCV2YEXUTwhZo5CX69McY?=
 =?iso-8859-1?Q?LdaoVqLNVFWiZTpsuTAU0aVeuFqTrl11h5BKMa6XZrekU1TsgVC8cpUkdB?=
 =?iso-8859-1?Q?7Wxn5n4U7wSles0hKjDR8To1ly/tOmpM8ZVTKrQS+WQdBvgX7UaVCCCZMe?=
 =?iso-8859-1?Q?5DHXhwUkH7rA3gFEiFnC3TcUeIIslT6XbDtg3iTENJ4ugF7tdOj4KfHiSi?=
 =?iso-8859-1?Q?TEiYS6fe4gWXotcEgJLIiHtAI7PFPK1sc+RmzaCR4zsfO9JhK6GCsnoR6f?=
 =?iso-8859-1?Q?FVBVdId2qL7Nxuu0aOox+1HqN1daucn/dFrUP4TJhHtKqvvJk/Zo3CaWt2?=
 =?iso-8859-1?Q?ov3qrhn8YsckGHqefnBgq+vhJtp6H497inNikkXWmK2ez7CUyJQgZ/bEs8?=
 =?iso-8859-1?Q?OY5L9wTtANavlS5/Es3FWViwFFSWyqtzjoy2QKhOqcqwZsdAKcpC7RuM66?=
 =?iso-8859-1?Q?QwhMYsD30LM2/nzwPIpravsnXEa8A0+F5f1R+rSy77ck/ubA8T7OM/Itqi?=
 =?iso-8859-1?Q?wtLTY/SbDqbYGFv5fcWcG2Ydm9oj9EACq4iNi33joLd/O3wwGNCDbXSZ2a?=
 =?iso-8859-1?Q?cA6DQCZHZ1lgkBxKR2L5GEkf6nBqaWUKqPCZ428ISoMXQX9QHpS7qJPkYD?=
 =?iso-8859-1?Q?mr39NtQfLWCjdFTrwxoHZ2gmDpvWuSN7K0zPpYQ73UVg7HK1KjuiCccwUL?=
 =?iso-8859-1?Q?tvXjR3WvviMpMEf4LeT4VbWlhfqBD12w0tE+5hFRUV1xErPp6+wjIKRXIo?=
 =?iso-8859-1?Q?JHqlSTiF5yNb5Yl8m2lQOV1g0zXQOvToC+WvP0cIfnV6xn+McyuTP/bXbn?=
 =?iso-8859-1?Q?XIfS4kB0VjXBDVuVU3w/ulr/jqwiM/KNu2ymi5E59olIGJTiB6QRqlLSET?=
 =?iso-8859-1?Q?KbhmfFaD/eeVgHBiKuxJB6nY6FWzsAB/PuCSm+XfpyR3fm+XsmnM7ZMDZK?=
 =?iso-8859-1?Q?mZOsj8VYAbOW0rE6aHdToUP/nCMkaW8dGEHTZ8TFE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d68042-3ebe-4e04-6492-08dda0e7c019
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:57.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9527

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    Sending 1 message
     100% (1/1) done

This had been made more informative by adding the name of the destination
folder as well:

    Sending 1 message to Drafts folder...
     100% (1/1) done

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9c3c8d8c3c..3565a91ca3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1599,7 +1599,8 @@ static int append_msgs_to_imap(struct imap_server_con=
f *server,
 	}
 	ctx->name =3D server->folder;
=20
-	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total !=3D 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent =3D n * 100 / total;
=20
@@ -1708,7 +1709,8 @@ static int curl_append_msgs_to_imap(struct imap_serve=
r_conf *server,
 	curl =3D setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
=20
-	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total !=3D 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent =3D n * 100 / total;
 		int prev_len;
--=20
2.49.0.638.g5e24c6cde8

