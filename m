Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C5213E89
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112962; cv=fail; b=Whmae0fNywvpKVLeQchRgVAd7ykixxqcJ4/WXMUKgmEz7J3AkLAY7VBXr7CriWK6vX/l6+h+YP9IkAq0CoIuOAdATrTWdgAjbGEhaT4wKbzmzTOucc+2IWcm1ZEUPdRJWm+6aLjmB16dRXCzW6ejEFgiTiZH+46GsLnDP6DucMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112962; c=relaxed/simple;
	bh=fao+RV+6qQe4IOrMgUIsz2NWFZed83FUu+KpmZ2FNao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=htOHLwZCJmVIF9vCGCFqN8xzf+Q6jEcQoHXRz4xny+gBVlB1P4Jo4cqSBCsczV08mkjULIf6ewk7xPk2j7oLVM1Bz8eMYsOOBZrB2FoCa7dcWRrzqujIB5XV3Qg64dAFHCGdthAs/XjntwdaQ1bujrPg5XEzed39UfigECnbiuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=lXpXD767; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="lXpXD767"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP3pELFgl22lD31FCRnd7Ys5zZ4zQFz+6nzORbkGN0d1gPsbGnX2Rj0qAQIagKVNOqsqNcPi7hAb1NAkWdcerrF9aK1eqY7m4on8LxQ0lcQ/G4FXyPb/7nMHPWhC4Lq/+Icc/jZSjOy4FpaDp61BGadKFpe5O1zWJL3w4ivK6gcumdOpDqBttI5c1A344QTya3S3++oAq4LyP0AGNoPjwRfKNasy0M0YdAwzWzmcM6so64qz7nR81lphM2dbwm+Tgjd2EFMVlcC1rnb65gLtAdedgOmP7xg/qU7ycDsoLJuFzXu7CJWAOt+F8BeSMAk+iLgMNk71x8SjnINkqAnUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR4eiGDpdbyovOykx0L8V1KqwOlHW9Q/x5NDBONmk5c=;
 b=mTC4y9d81eBDplChFA9+9cRoHclCqQJ5kR6OVpORj5nTo73jBL6leYiGypn0hdZMBil4jQy02MqLpBtBc8mhfuFm3dtugji8BJ0NQgRuzRnzkKdAMyqfVs+3RrVXzSYtAoxq0eEgv/qFh36OPDt1KAI7gXw7d4O1KvTzSqKdEKmGg7i681QwWbcP0sEf0as2czyBOXF6M3793jl+PEjBQR3tw4DSdnuGltE/6SFT5RGXRekoeQeHQbg3r4+M5v6G2meWnKR9kO7zp5xYBuZjQY2ahbTg154tgxRxjRaeIejSJhuwTYF0r65aV3s3JDXJZTSVhJeT01yVSBsOGw2O3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR4eiGDpdbyovOykx0L8V1KqwOlHW9Q/x5NDBONmk5c=;
 b=lXpXD767doKUkm4Dp+XTQOwzHimm58jeOh+0/kcBEZoD5sx2qJywJU1ljtSeGZe8eP0JtZEiV1xMHN7wl5wVaC7euu+ORUF5wzq4hZtQsEINalBXqUicuhbIJAI6VG00qh0I5D2TaiUwU09sGLFUoM08az0Yb/saePwoorvYBrWXgfj4wyuSn2bs/iV+WaUIWNBs/6F/kSd0Y3F6TxJci0zZbGA5IAezY5JpG4+NpdEBdQ6vkBhSMufSxCGzb6whngHDHoOG+Z6JBWxREqLgaB53LVi92BD5Mc3cDlYPNAMP14lmNv1EQ/FQ/qFK2wtr51bApakl8TF8GDDell3NOw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7773.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 09/10] imap-send: display the destination mailbox when
 sending a message
Thread-Topic: [PATCH v13 09/10] imap-send: display the destination mailbox
 when sending a message
Thread-Index: AQHb1fXGxjAewlwsOUStAy8B2F2BSQ==
Date: Thu, 5 Jun 2025 08:42:31 +0000
Message-ID:
 <6dbd0bf0bc3d8cdd0ba32ba39d765eb557c550f5.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7773:EE_
x-ms-office365-filtering-correlation-id: 78040a9c-2678-428c-665d-08dda40ce8f8
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|15080799009|8062599006|19110799006|8060799009|56899033|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?q4cEKQ3oK+UYcEDssABT7GbCZYazY9xr7aR7JFQPP+AyOsR2vBLOx7A0D6?=
 =?iso-8859-1?Q?ZZ7nzRdUn0HDc6C2MJWfHg6QWsKU56RdaKcTNI3C9ri8F+sws1clQU19Tg?=
 =?iso-8859-1?Q?FEu6Lu7gMTyyv1loYLLbCOU1yOMAOLylFNFuPJ/7YR2zlsYZPatzXwiFmj?=
 =?iso-8859-1?Q?O4BEwt96RNL0pWikiiI6JrCdGXUoi+w8h9qtPcNJVx3M5Ozuttyywt1rwW?=
 =?iso-8859-1?Q?044ta0i6pT1aJg5dN10bI35BvpnZX+UsZGwobOC5SQ4MPMH54l/F2XaNQf?=
 =?iso-8859-1?Q?VRSfDrRt7CsiR/XMiyFRFCzmLTo2zrqHBjIHEpj5nwdyM7p3qRBjmEQrfs?=
 =?iso-8859-1?Q?NXEQxS9WDhGZIN0wnJXPRL0BpaIJPsvs6UJstr+bVJPxeoBpQP6rBcDOi+?=
 =?iso-8859-1?Q?5hf8hkSA167wAyaHW0luDGm7W8XKungSnPdf9uWK8yeQK7ZEwmiJ7UTa3l?=
 =?iso-8859-1?Q?EqapMYVUOFPO69/pfxXPwSU3ET7UPV0IDKilUO1NrE+ZmI2em7+mbST6CP?=
 =?iso-8859-1?Q?Jvnb/U/jpAVBDlAwxaEWo1pefAJ6qrw3/0osQCR9+sOQrv2nucivE8yRve?=
 =?iso-8859-1?Q?/wyYeoqjxkynLlIUSg6n3qT8Arm5m1UaekQn4fBWlTs8Xfq8BG6vrfeIh2?=
 =?iso-8859-1?Q?Y0hFAEqQOmAPJnaZdTDKewEyAxakixAGiVtieBK4aWBxFYSLhGyL4gYPSZ?=
 =?iso-8859-1?Q?iYDKUg6gkeS6Wy2SR7vx4KQtQgOeTdTMQ1aknhDpbmd6oa0SMNA4mtZ6Zt?=
 =?iso-8859-1?Q?Z8CxgWODUN7LC7buH7oV2YG3Q1Lju5FR84LqL31/dLtviZJuvUbQPvy7jf?=
 =?iso-8859-1?Q?QNnJBIQk44Kcp2R7wCeHp5Nvx7gM6B4tbGBZFvbdK24bRyR86qEQdapmMX?=
 =?iso-8859-1?Q?clPalk7fNQ8Rvc/3Qp+M0WRmN9MfjxNFw90pBmckoHwGvFMRWSHFLHVOaB?=
 =?iso-8859-1?Q?GOLlaelFg7H3z35bHDfXBp4fpXU+I2gtInyasCDxhduB8TXbonIWizUE9V?=
 =?iso-8859-1?Q?vSmW2KL6nhBFkLS1T8DRkO0RyHFUwRp31WG0eWp8EiRlzMxFXwGz9+cbnO?=
 =?iso-8859-1?Q?vANWWxeLNFGFKJYSwz61pemy5C4UCI13rki9fuX+J+15ddYuXWv22HOxqC?=
 =?iso-8859-1?Q?j5rv2sSB5sa/z9+9bVUGmHRIQzExIISN/GDSQue7hu1NYSbLgykufggNbf?=
 =?iso-8859-1?Q?YZfe0WqJkbUJJA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YO9gnX5lOCt/N2r5oAYbnyHpaiQIcVnx8cC+WDSdB0sczRhEGSIHPY1tdl?=
 =?iso-8859-1?Q?/qNg40SJqr2/iZDZBROYfYQb6j5BIuyIomKpy4lwH8cOLaqjeN/4cJLnv0?=
 =?iso-8859-1?Q?zUac8nMhhJhTX3Du2fy/S6NvLQBecPv6F/rkyZ10+msraWjbYFRZ57Exaa?=
 =?iso-8859-1?Q?E44VOfqV2P7kGjIWapXWrbX6/MK/dKM84eDrWessOTQM3t45vF830Sp/iZ?=
 =?iso-8859-1?Q?orO/nUkzdur0vaPU8qhlL9A7JQe/jqRep37J+/hXYitbRv28Jgz6hAZlQh?=
 =?iso-8859-1?Q?F+UHC8RjAGIuxh+144TYCerUS3wLVpNwaDI4IIiaNTyGHJNUomm+sikxCr?=
 =?iso-8859-1?Q?eGjWFQMmq4iroh4i50d6wL3+pOtBQsM1Gz0i0qWUNx9PooA338492GJBAO?=
 =?iso-8859-1?Q?RqlJCGpUPTtOYM6wIV76/KM6gc/1wsAN66p9lkD56DaeNFFkODOf/Rmk+G?=
 =?iso-8859-1?Q?gC8HZPFkEoaTJZv2mIw7l4I6KovETKYw8f7WvtdfeHJfWjl9/w3HS5VVvS?=
 =?iso-8859-1?Q?EpZJCR+71O2V0eBIKu0SMtlyZiKyh2SVkkLzr2M/qaqHYLbuYKzEJHDVWl?=
 =?iso-8859-1?Q?HXsLIyPF6x6s9ObSmZtBwdGrGx+VkNdIuL47TdfsaQRcjJ6gK5PrnL6C7u?=
 =?iso-8859-1?Q?TydsgrkS/QNufHncKEMxR8etax/OLMqs1W6iwuWCAo0B/NhOMvoCVUC6JE?=
 =?iso-8859-1?Q?hjqkpVbcPyWPT9xHoh/JStZwmO+veN/DCyYqFU3jM1SvTiDB0kdOODlQqf?=
 =?iso-8859-1?Q?CkVkC7QJpYi3PN9r4/OmBwfPGM/JiTVgSq55QxcqsgkCkq2WchbezpR3/u?=
 =?iso-8859-1?Q?MjSoMUbVffjh7vQc6J5Vh3eTblVkxG9cFCoNJwyVGi3Thz/eClcBEYb2Ct?=
 =?iso-8859-1?Q?M5+4kiTBWUyK7iCT8jyGqcAm2jBbSZ+6gO5Wug0B5JJspGOglzVq/IZHaF?=
 =?iso-8859-1?Q?JSK5k1s2ypo53Cba0H6455uhJtTjNp4zfZS42Sk0AExNrBeDXzlFCsq6Yy?=
 =?iso-8859-1?Q?uoK48RGaIeg7Em+yoi74q2ntxbMbcFykBTwe8+olnyuO0frudTRz2wnP54?=
 =?iso-8859-1?Q?6B38LOiFUQGhIlVhDSapUpxqJUyt9MtR4cs+cFMJ1e7jMARbVwjx2LCXS3?=
 =?iso-8859-1?Q?8CgW7Dk2956UzAS/X4QI0FISrN9GyXJbJmCGm0fxHpOf1hjwt6y1d3V8Nh?=
 =?iso-8859-1?Q?6SP3nJVFjoegxsyHTnSilfgR83GZrarjlMinRQ9ZtWKMenSEAA2cvQ/+gB?=
 =?iso-8859-1?Q?LbsYlb1IZAnfk474nDG0WuIz9jbV0TJHjnl4Pf80I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78040a9c-2678-428c-665d-08dda40ce8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:31.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7773

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
index edc6b1ec25..3ad916c6da 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1603,7 +1603,8 @@ static int append_msgs_to_imap(struct imap_server_con=
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
@@ -1712,7 +1713,8 @@ static int curl_append_msgs_to_imap(struct imap_serve=
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
2.49.0.639.gf77f2423e1

