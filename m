Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAF20E718
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112953; cv=fail; b=VhgKEUtp8srW00ITTPZjESZ742cGBAgS0Ojj4VpY1IXF215EgUvwS+nwAzWALvlH+SfVAUVgwdywgdpBI8ysylM53WcnERWZISoDCqgRQjbbThCaQkjr1v+bFZPDmq1O9HOvdLU2KgXOkTh8/Ok2yK126EX9cRCIfpnhd5AK9X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112953; c=relaxed/simple;
	bh=Zpw8YwqmnAQNztsilgoPQ374c8AhBifkvPCQAwYpN30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvLD9grTOsk5TyBz6TCTliUW37Tl8z33ml2KmjsURDlG6H3gfY6mR5Hf6EGU8+nEoI3cvk6YoeWqJ3Rm6TYm1l0rOJXImwpVdNuY88w+WGWNQzoQ3vvy5kjSPTz66WwHgTfUIRkUhQpJzUTpvFl1tYpwFj2fic0on4YlYHfwHQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Z8KtyoZQ; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Z8KtyoZQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC8snO9V8tu0KGMoDcOaGIILi3UZnG/gj8J9NN7Qq6LmrbpLBOGXTOeo+S5L7kU+hri6fU/7e4QkhY9e/Z5ZBD53WOdgXa4nagzchT/XDPvBX505NsiXWhZvBv/L4ofo9gGeyeE22WhTawQwI1S9dExr3ZCXNugtnWCSdNmoCSHzGR1lgxltdTnPJQ8pI8mCp9tcGpO7uyybQJsdgsIIo6a0EZmtzh7l2KennGGVaNmymWvDUCU5kB4EVX8z2RyTETH/GHVI5nQ1kL/valtE//lqIhuBe5pD5jXH8OrRgssC456EVIdVqVnd5TeMiWrP2srQQxuLVBVBxSTfyR5WMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsNSJUXPSgK2/Z8tkMZ6cNwOV5UqbSGHv9f8Y45LYPw=;
 b=w4N83s7t4Ch5pOFWwfsC1h/oCKk/sTdFu7yxfFQqylGdPXmS8ZQLYLGwFXcHZr5S9bonN/jQQkO/+Xv68TkCTkY3UF6JlPjsXzHHc1poC1mZHYRMG5YGxWiVeV1HBkFuh0B7Pf8LWev+HzLwvQs94AJ4Rm06iZ8+nOI0VYkh9JmRmcXKlO7SaXACrBaPz4DSfGAkM5v3L4lAkVVVGAhryKtbNTFpg+xypt0vAN6ySnrG4/zI84KgPtQlYHopH+XunpcfotNiZJ7QoBwUQIau2p8racVHiVKZZtJwaDealMXA19An36FT4Ztj2sG48+0nEdEKnorV4oGSX2hwxynjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsNSJUXPSgK2/Z8tkMZ6cNwOV5UqbSGHv9f8Y45LYPw=;
 b=Z8KtyoZQdslC8lTbX5qSILzfyd+K29F4BRapxm1J26FetH9FGodUjsS1BEWymI19r5o/bGRTQmHXQa15qs6MdAA8G5sCYDjIprzM2Bdn0sF3OrPEiW1s6LgRt72qPyRNJLUCkLExidHm2I732HyWUPoOityV7qXjJrvER4co5IYstNSi6kvL5P3JM9vWIeEUHOPDmJRIbwsomwLBf6MF1T0PO7rV5wGPP2MCp7w18k3TvKqS+kb9uHRVwxjrZUYjmEYIxtXq6KSb9P89QyqsdVSu8Rj70VhzZQAvZDV0DSHe765ELRG4ovK1vS0D9bztcjEmjlICIvksILwbTIa1TQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPFFC37E0415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 01/10] imap-send: fix bug causing cfg->folder being set to
 NULL
Thread-Topic: [PATCH v13 01/10] imap-send: fix bug causing cfg->folder being
 set to NULL
Thread-Index: AQHb1fXCYmz9h4eWYEGy7DQK+vfWUA==
Date: Thu, 5 Jun 2025 08:42:24 +0000
Message-ID:
 <3e3ddf70772a9c319170064d77404ae858dac314.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PPFFC37E0415:EE_
x-ms-office365-filtering-correlation-id: 2b2610fa-f4a5-4d47-c393-08dda40ce4f4
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|8022599003|461199028|7092599006|8060799009|8062599006|15080799009|19110799006|41001999006|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ksC4vSAUcJpFzjFLPz5HLrbyoqJk4TXO3bIHokl7vMsPZL5EUUMHTlIND7?=
 =?iso-8859-1?Q?phWmjtgyOzLvoGNZ1ksScqZzbh/s8lwRDlCnWMfr5a5grv8BGTRsmigf1n?=
 =?iso-8859-1?Q?Xuyr0W2oTldWVTVFCLTpC63K0T+f+VUhuCn2ApFGScyWutQNk9E9CiqQYq?=
 =?iso-8859-1?Q?chBDfnwz2wX6OlJ5hVCTRfcA6SJYAG8+FLJiuKCln9i9qLdBoV9bbwBtTO?=
 =?iso-8859-1?Q?pMoVcS50dPgFXj8YRmtmuMiY68/HcbR35zcgOzgcZSIOdNRYtK6sxOxDyJ?=
 =?iso-8859-1?Q?Dq9gsvRElT2oVJnVvD1YpiYTrZPrOAlzkorN9aZtZX6BjYKj1zkH3Sfo/X?=
 =?iso-8859-1?Q?mitRjn3mm92r2gwJMhG9OlppNvSzFQ31XLCoLFlNMC2W/QgT8Gmcpw8Jaz?=
 =?iso-8859-1?Q?SvE24PlDPcebSAyxAAMoyRKoFyTg0xIoseXtxG69WTrkLlTyGJfWK16OqR?=
 =?iso-8859-1?Q?aD62XBiUaZbrqf7oWm7HJxzeA/1vjSI5pahhw2vVw9Z0s0/K5MbNxLsmKy?=
 =?iso-8859-1?Q?JiuqdQ+DKpnQTuOhgdzzNOxjxtXSxxXnzb4pXDlUBuFO9u7DlbYMhHkZjL?=
 =?iso-8859-1?Q?3T+vPU7783ko5cbOw1oCxLloMRsD4V70DtjPx+IZ6K1Vk+vCRgbZTVb6d7?=
 =?iso-8859-1?Q?Sviqo4BoTWp0CAQ9Reaz4qFyVoQTuN3Qva4Kl3t9lIiEGUmgew18DddQUN?=
 =?iso-8859-1?Q?BP315kyDEXtCKfnPXmmgrb9PZq88ZZdE7MfQM3AzQ49u1wr8c2uCZCFzOc?=
 =?iso-8859-1?Q?/319O/h8Ar2U5XxWavRq5wvPYjT9YTjwZ3ZwnQRoJltKrmCLJUJRufpl8N?=
 =?iso-8859-1?Q?X1pkYvoEeYOQzGdlokViWIlLXLGfBfP0sJpMD66qjZ9d1t7rwYvmVAddB7?=
 =?iso-8859-1?Q?yjdns5+5OkOvkMxriIVpeHu4ERPS+q6yZ+IqHJG0RqcBmUwq9yTPEZM/Sl?=
 =?iso-8859-1?Q?QU8ygXsT2f5R7A7oedzQl2mKpNrPxBxjv+2J1189MgYPtu+0vmeux/Q6+b?=
 =?iso-8859-1?Q?XNC7k8E9T2daCanIOZAeni/iymd2roFAp/itl5MblK7KZCh9XhdMyiqd1u?=
 =?iso-8859-1?Q?a0FTvqSxEXJ5WQx8ZlVhk4hw2na2KQzx8iV3MrB0GBAHXVy8DMPj8xjgtf?=
 =?iso-8859-1?Q?3k/xi7evxd+/MrVjnNPON/LeyHFFgJ8HoUvlvx3fJOPOwz+BHbtZ4Dkfot?=
 =?iso-8859-1?Q?9q7miMPMCriFmVCO33biHEPnqZVbzh7SIiTlzSueCj9LPiFTj7BO6X+hZ1?=
 =?iso-8859-1?Q?K89V/nt9c183llMv3GXc6ChSgNMu/osyAulVN1lDM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Cm7xRL/DxIzBVcL2qg2hip8PT/YFtveVRqeevzLANSp8jAK4RyKfwpaDq5?=
 =?iso-8859-1?Q?A5ucz1a3lXBxPdRa0rIYRFQdQD2aYy8L9hhRLhRURcOQnRoOErxF8NPOiB?=
 =?iso-8859-1?Q?F63g15LU6MDUnp2uC7ANq51MABa57X1EbwgqpoLTYO6VuowmksJXWQaBG9?=
 =?iso-8859-1?Q?Pbhb+wzSrit4bZ5E6na/RJ8fiics/v3dWCBv9rPBrqDZeZ/53LOuP9gWmu?=
 =?iso-8859-1?Q?VY7Adyfpy28OBq3yoVvb8Nx5TwLxGRN3kN80T2uv9hmrzIwm+Acz1gooMl?=
 =?iso-8859-1?Q?YYB1qU0hwVA3tHTtKDWxfkPJgIQXkjA5ATRwnpyRB390IY/Q0meFbJA/Pk?=
 =?iso-8859-1?Q?ma5YsROKQU4ZRa6VOy0qVkKCs99OK6vrSTihwm/9/S6IT2QupZdJ5roEbE?=
 =?iso-8859-1?Q?ADQP/k/qlq5SPM1IxEhMhi3XDuOdKXs4SDoqQXrXgf9ns56wOsUP6TuBux?=
 =?iso-8859-1?Q?XqJzqilGXFpgWWNfC0o6jIb3gAVOiotwtaJpVTFZhvM9EUm3vD1IwdKmvv?=
 =?iso-8859-1?Q?3a+uf0gAaEEHmd7lX6r5OoxHUwVUuWDDm4ndqVt1qEOi7Wj4JbKznws8f+?=
 =?iso-8859-1?Q?gXXO3r39qotrf2deup8DhAprRDTn5FPls+HTGBYemi0cQKFLKQu2vJl44U?=
 =?iso-8859-1?Q?WUbg64w1BGYJqnAA6AM9BBAT4ylewaZhr7LZVu+eAJ6CrxDrxlLIOsmhv+?=
 =?iso-8859-1?Q?PoQ8/pFmq5TP5FdoI8uxLtAxKVDVpXgw6IoXu5ZmbPcV2chOiHQD/S+ULp?=
 =?iso-8859-1?Q?E7vmWjv1lw+CTvEQJKZZeDiGbWgyM2fi9tUzedhDvI2ZDRrrDyuI7xX80K?=
 =?iso-8859-1?Q?tQtXlonN0B3PeSVcKdnp6qn7fhSlQD3lVgkurek1tSvUon1L1qaokR9TGR?=
 =?iso-8859-1?Q?n7w/NpKoapgrLrcMGFE9JwSxBAOKB5Tz9+guZAaiBEc3FVTyfASpUCSnWN?=
 =?iso-8859-1?Q?TN9KTxCIn8/rGkxperL24NXunoEZbtQt8iwR/TNDnYE3Fx9LM4+Qdl10P7?=
 =?iso-8859-1?Q?3yKfGwtivkg+NBQtMKDjM5bwTE0B3w7qwRdck7XTczuzBtOSj+cUQjU4R8?=
 =?iso-8859-1?Q?59QYMD0Mt4iAj1XYynB3K0MEE0PtGIHRvokKG3be9h7SJMJahCQ824PzUm?=
 =?iso-8859-1?Q?BqYu9jdbyhXDVf0gMgzzXDb1Qr5WAIvSVHmrnmOBehv2Foe59uXjyGS8wG?=
 =?iso-8859-1?Q?hZlzaUMEcSYKsOEK5J2Eq4z1a+2U5LxRbd8YVWjlX/tH4kwmW2BFJkDSGC?=
 =?iso-8859-1?Q?pSrH0Zpm4YFtC9dO9OopryRzvCX6LZFjYr1ELwVsw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2610fa-f4a5-4d47-c393-08dda40ce4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:24.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFFC37E0415

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07=
)
resulted a change in static int git_imap_config which resulted in cfg->fold=
er
being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel and
imap.authmethod were defined. Because of this, since Git 2.46.0,
git-imap-send is not usable at all. The bug seems to have been unnoticed fo=
r
a long time, likely due to better options like git-send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const c=
har *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port =3D git_config_int(var, val, ctx->kvi);
--=20
2.49.0.639.gf77f2423e1

