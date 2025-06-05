Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D892135AC
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112960; cv=fail; b=PBM26GCjdQHKrJZxQKbV68fnyPMvRpi5p57tM1KqMTz1c84f7WG7EM98c7NOd3RJZ1WXw8i5LX5Uwiofg8o/hDLa/FsLrVAnKJOG+7qxsQz6K0I+iyVi2OqfBVzrFZ8Upg3K3kBL6m7jSXSV+Ne+VLhIvWUr4Ox7l1Yl1MJI9oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112960; c=relaxed/simple;
	bh=gy1KC3+Z6s5qNkfI0+b+WGkuWjLR9K7Caz5cesNN3xE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCTIilHSNIVOnJQiDj+BgXYjOlIhXn6FHdahgLISt4iq7kxLm5Ab238/+J/h9EnCIudA56GBKzeswx97J2tVos7ZMrrKW1z5Limv/csfpNhb/XNy2D3s7+tZNuCyQazRAAupvOpMfvEq+O9J6v3e6LoPieI9oodW2wT6CIizNQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Idp8nOss; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Idp8nOss"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0OH1rx1PlZrItb83QDe/NJnokdEtq9fP/19flUp1v/nagiGg0+xEGig3aPabxZ3UHXDlFfzWLWM7MwWP3nwRq2vgUg5EAVZCRE/SUGKTjcDh4BbwXKOvLJ1exobYY/vzdhriANbYOCX7uGDtWqjMp9eXEuZiAmetrmb1SLrlEMfC18y4fRyvgEIXkxY+Z7Oy7aCs0HbH52k4ubQiB5FqMTjLWjCE8hIKpwazGNrFsxUbQAls4VCPO0Twi3bzVmnibABWSwqcQ4Q7kQtvg7YCf7HepYLHm6FF79nVJd4TbYNGL8ZLxjV59j/0ixOCvvCAFq8SY23sFDtbYGXzWE41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbtIZrLAmBhrcUt4kzrSDt1TTBkjUgta3c9Ocq/Y5uo=;
 b=bIw/iQfyhcROF5SzpK0KEj9NOM257Od3j342wmv6vU1n505sSJPwZ2aQw/hnG5uRGQEBQtz6bhLD+wXLS2vmvy7bZhQl9HlE5KyI8UWyOG3gtxq6XBzV0RBVCKF/3lpSUpbPa87BQUOOrHHrX5Rl7mo2QBJphhHV0WNaoqo2gf0Qtm5pv3Tw4S1wb/LzLtaNB3qSIF0BQZymRSpBClxr2Vz18QsyeiUkdqEil4Rs3ZFUDf1Ihe4DA5GYBUCLulqK0cfRbSJxRT8ev6gqM59K8mBR2O5BqsdjKyWNLA0fQZdGp2UjrWciQ5W8hVzPi5Ckvl/4+GNJVyPYQbMVU6c9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbtIZrLAmBhrcUt4kzrSDt1TTBkjUgta3c9Ocq/Y5uo=;
 b=Idp8nOssiGfJAZaMpuJcWkMirh/2FDBKrgJudh8FEkbG0xWFivjTt3L593h6Rs5hwsStHdu9i7/ENYse6wbe1qUno+tOvyGRLpqkRHYZ+irIUP+sYxDFcLohHFEWwBtVAOuGaXLOopsVce0mXzA08wOz/9f9MOwU1CHSqgxfMn/EMV4IOIpogczvEI1dFGPbJpskEAoIfC9ttRvFookvavpsH30wdqKZyQpsjEfvqh6S5KF9FsR4iu1/Bt+zgRRhM4iK8yyCgq2bk4WXQDE2A9iw2XNiLUEyoXm2wWg1DpP9JXx87ercuI8MmbUYn0Luz/+ghCEC0XX3WuPxRSZToA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPFFC37E0415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 04/10] imap-send: fix memory leak in case auth_cram_md5
 fails
Thread-Topic: [PATCH v13 04/10] imap-send: fix memory leak in case
 auth_cram_md5 fails
Thread-Index: AQHb1fXD7TKfiuJfqEaiWUJQd12HiQ==
Date: Thu, 5 Jun 2025 08:42:26 +0000
Message-ID:
 <f2773c646f655e3d31b36aeb670bffd79c2c4fea.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PPFFC37E0415:EE_
x-ms-office365-filtering-correlation-id: 7e8e3152-563b-4725-32f5-08dda40ce67e
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|8022599003|461199028|7092599006|8060799009|8062599006|15080799009|19110799006|41001999006|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GwJgHRHIoCITflXVfcOQ+N0lbxWbjG0Yl5XEq3UiM6BUfoiYYwaGgbwUzy?=
 =?iso-8859-1?Q?8FHQ6bY5hzbKv/uD8H1BZB6F87iKQyOOaVqVq9tAlZFBEbnPrgLueCPet6?=
 =?iso-8859-1?Q?K8Dtt+89ckrRrmBbuXOG35u7OXfs+9OzZzjOoV1PI6xc/Ear6leGZZwLxy?=
 =?iso-8859-1?Q?vg1RB0DZVsrq/B88BDAgCNtiBoR76ZWE1oB0m7jKt43K6xTpCxO2QwxHSm?=
 =?iso-8859-1?Q?uxYEPRWV5QnxlsfInhgUULoZz8Mgu0KHj3PPFIHwQ/LtFjIFo2JOqvGh3w?=
 =?iso-8859-1?Q?dBPVgFgZHaxYvggTlCOpEh4xwbyrdykXlgIfqYk1ophN4x2nEhhi4oqUYG?=
 =?iso-8859-1?Q?j4AzIGM9kBHj9v6WzFrivRdbfjRagcDNMeS7qSr1CvAjCIoQ32c08iNROZ?=
 =?iso-8859-1?Q?chjIkwmyx/Cwrq4NHuJ9EEydaGOYwWS/IQJlwtoZZQWB/afVKDcVC8W7ve?=
 =?iso-8859-1?Q?jSrMXD7G5Zn9+gGP00+RmfU33sXMdPNHl5E5X2ztagkGMJC1BfSHj8iEyM?=
 =?iso-8859-1?Q?6FR34vmDyiHzoiCyNExj1pEhNjyly0E0+rnnbphwaIHha4WICYENaCiv3Y?=
 =?iso-8859-1?Q?PLRZg/32ljT+yG+BqwGNiPXY/FqA5lpEP8LIodkLxi7TNZbxvzUeFCYGhR?=
 =?iso-8859-1?Q?slLuhfRn4kJ26dsUZI0Qykm0CtZojyQJnuDIRpEC0ltCVgqCJioBoJBf8J?=
 =?iso-8859-1?Q?TfaoLmzT99RjD9hn5AikwjbvttXqH48eLikZOXK/e3bcd39p9pe+/N8Ko0?=
 =?iso-8859-1?Q?K90ScMHyZZSRMFZB1pHV86wUbtg1bTh8f0Qf+LAu3fy6t8fQos5aaFBR+1?=
 =?iso-8859-1?Q?ML4KVmQ0xhzBh+euK3EIHYxQCvV2MrJMjerNdqJ8ACMUGYCTP0Dt0UswpN?=
 =?iso-8859-1?Q?Q2kPm6nhQChLZV6pNG5VNkfZodB6XaZl3Io9iGkybTIAVqkWbiZxuhIjMk?=
 =?iso-8859-1?Q?vQ7ynAsbENO1nYsaHGnC31MTZDWo9qTqq9r5h3NFEb9eMs2N1fvKHcHL6g?=
 =?iso-8859-1?Q?GGUwP+8sqJu3taK9iYU/EC3oo7/4WwyO2vG8keBfsdULl3s/2tkzEwFfEv?=
 =?iso-8859-1?Q?xKRaoBXopmHfLoMbuXU8Xm2fkhUWBhGSWf8bwP3fbcs2iITMomhOW5nBjX?=
 =?iso-8859-1?Q?sQiYnJ8B1utMUB4OLM1fzld/RaIx64Fp6k09ESVAAbEciEzXtmB+AV6H1M?=
 =?iso-8859-1?Q?WXiJ1fNHjuJnhkC/mh+fWq0bwI9cdKJi//7T4NHHU0f1Lwm2u+uUs1eMdx?=
 =?iso-8859-1?Q?KVH7b9R3RPNNhMB/kB6zUuQ00HPUfh+SiWRmUGM48=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YexEQbQwB1BNJJ8MhjNPyWot+skIQDIqk2SM4asAkeWznN4odAePS38PGE?=
 =?iso-8859-1?Q?UMTBBw1AB4mwx1GjPPmYkurLFmfkFFeFfgXa+7G5EAL4I0r9EjEHzsDZsR?=
 =?iso-8859-1?Q?k4TruHKLOOXMwPU6LjOomepiz4f10GDYsSq9k7si4AHUqiNxNuSczfh18o?=
 =?iso-8859-1?Q?IO+XRJfN0aHNpirAES7p8AAjK5kD0QalAxGImADM4leD/OsNS28T/fieNS?=
 =?iso-8859-1?Q?auteEwVtxUPWh202yvL3clx6sUL9bMeXf1JTBRusDqgp28g+0Ap+R/w+FL?=
 =?iso-8859-1?Q?bMP/OHX4E/8xjAHg08K8YNfJbyeux4taLsmCLHUJPsa4TixNSlAxg4K2CO?=
 =?iso-8859-1?Q?YfMNS6CXYbzUrxQI1gTMyL3c7EwylK8HmLEB+N+PmHOp4+EWMiaImu3S9j?=
 =?iso-8859-1?Q?VITY5nErEaJ+kzlwdrJuJTnOcXpvc12mu6q03m75HcSyJ+5rbniRnV0oDF?=
 =?iso-8859-1?Q?mR4YfWRwcO6aCNTZ3i82USyQUbf8xpPidennw3N5uI7kGA8bcMedVBatt1?=
 =?iso-8859-1?Q?khceZeOZcv0y6J60eTX0G0fU0X8r27E+EMnnbM8UFZD/gqh5OhQBG2WacH?=
 =?iso-8859-1?Q?/hGJXRknWUrHiCy6ijyMD5b0eH4vNb5Aql8BIsGxgQqbxQgy4PGgysirL8?=
 =?iso-8859-1?Q?2XPOr2cB/dfXlgU3Tdi6Inaar88C8RzL1vwaR1Qn6gbff4sq1+HGNHEjvE?=
 =?iso-8859-1?Q?ARmFK1ouIf6juze9MdGF1ujKreTHdl80ZolaU7qveEKM7SRwB1yiRJi09j?=
 =?iso-8859-1?Q?6MhgKX/HD1XggttAfgIGbrA2dwEUhg7N5GI00Ypk6BNFteVs+qd+nSfGBz?=
 =?iso-8859-1?Q?7xpr1J2Nt1T7qU2H5yNj7Ed65zHvmlWgc8VUH3vnEq014Ugg7MV7/BjwE0?=
 =?iso-8859-1?Q?uYRFfQpcBIaj3+TbQnjDeccwo8JxcwYVNZqBuTfWap6J2l14GvlAg1JqUQ?=
 =?iso-8859-1?Q?7u9kRoM+cXXRv+oZS7ahDNAHSInJ3RCHiXjKfuSBnRqehEkyJI9VDIQh2t?=
 =?iso-8859-1?Q?j7I5KdRA+CGuEIna200pbuf0SEFZ9x2oYrjcqd+0+rNc4YbZ3ftHsHoj8D?=
 =?iso-8859-1?Q?leFqdCOfRRhrUBOgvqfxtBLrbFbPlokctUZZuEtv8wI7pBfCVpcl1Wr5/H?=
 =?iso-8859-1?Q?Fr2qoF4osgBwXXvpHiT8MC7thrAuLF2mNRO74lZ+PN4VVyEO0bFLrx5hlk?=
 =?iso-8859-1?Q?Ovj+apnG+yiUpfI3idzWnJ79i2TdiOI/9KH5A7f27SqSP8ivj/0mYCbB3v?=
 =?iso-8859-1?Q?oEDR3pofwRYIDnawK7QbDJdqIqcAcGM05L5pGwbbA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8e3152-563b-4725-32f5-08dda40ce67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:26.9495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFFC37E0415

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 38f09f1f02..072c8f4e39 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1072,8 +1072,10 @@ static int auth_cram_md5(struct imap_store *ctx, con=
st char *prompt)
 	response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
=20
 	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret !=3D strlen(response))
+	if (ret !=3D strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
=20
 	free(response);
=20
--=20
2.49.0.639.gf77f2423e1

