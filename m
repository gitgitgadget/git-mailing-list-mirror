Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D602163BB
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380244; cv=fail; b=Uhte/UujvgBZv2yKQCs1j6LlUbUiAJ8zsxu1P7zkUxdbox13D2Gaa4agDRzmue0MKE1J1r2EshIbxtb/vj22Uowb4toc4ZB5bS8A52OKblGhjNxCNJssj80tIf4D/W+xmg8EhkPEo5I8t7BW4XKmF998UFChUEGrD0qBSu0c3oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380244; c=relaxed/simple;
	bh=vnGKV+o0MPCug1b0nCz5KSW9eULT05n/2eVT4xaTlWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=daoDUtl0TfoGkNNlszxFJkDMejnML9jChMxbQTNrB02Z9/cS/bEdk1SsCQwF9f5LKTUd0z6PWECvlokBoQ6pAw7ornkJAyvvjKhNfCNDXlV3a1RUzzC3CMKIW6CnwI6kNGHxaJqYdePu1HXXro0Z8iK7e0V3ShNSNYHgUfWXoGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=owAs22Fr; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="owAs22Fr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfVdIBA4b73x3ENnuBN6Haqk1+kJoK4Q/Dmu4kmYBS3nbDEnuYEJvrorhhGcfKjNI47GuctpH9gZYrdLZ34hVP6IczpCW16zpYS0IjlZHzP0NiaItpGqTtCP8AfI2obV+pwxWs+1/+dC4+UatkVVxzY4cKftZ5SBWzeUmmEgTDadTjV/OyTXD6RPPlSntOQnqncbHcYaGPKTG8bvAsgfMvJ6X5k7VRGWiYuvTELJ0mStYegKXAD4KqMJe8qVopN8pynJnno+owlwaHtSHugb2bb6wZ3DnVNIoYCwK59Kzw8D+0YsMEkAvvifmG9yHflkcligKERGgF3A0BNIbfmG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlb9Xf+bSbPqaGqx3X6k6rlbSwvzYF/nJvoxTZDX4XA=;
 b=KiDsabVgi30I9r3xYvp8/3CexbtG7rNyTLdg3mkbKbI7mYMw4elGxzJWvCMEHfQvu/lRJ/kLifwXaF4LvUu0COva3jvtJZ7VQJ7Lt+wuxtWz+/0C3ijAJhQ/yTS1wsZWHshnfyYFd1xzycu7WrOKYe0zJVPg4KKhy/6MM1yfyJaCHhuyWAJ8Fow1zKvma2vQeg6N58Q+fXTxbmqAgusEU56kofnKy0W8KOcuzlEeFmEUPmp20mvrmbf2Zd8XJ1nr1lRjAA8OpL+tTAXbbBFsn9JhUYGHhcpyQwp3lK+jpz+utKBL2KhewD7v8guRTaDHKsGPCbL7bj8pawTjNP0L+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlb9Xf+bSbPqaGqx3X6k6rlbSwvzYF/nJvoxTZDX4XA=;
 b=owAs22Fr4mwDidTpEM5SGC02Kx4jRfoK5gCqICLAmfP/i8gz572mhQUFrHg0XLix6t6WH1Wn9yJSrOCHRGfKUgcYq44IrxIQC2fNnzuxL3jrfqmr9ocyGiwDPFamYDzJK5ZjYcN3IksxGdILk16J5AkO2c40+0ZHALYSB0Z6Rlg2TGF0Pd/5JkdFXKTYNVowhCwyJLOGTwDmMgHFnUMDvPou49AC1XoQbRfm0NALma1CdhEdcyYyVzRp8vEgwzpKOzx+4nZ4JXBpxP/J3637/NwXK4pRPOwYkddpAUHT+Rw7mFU7+AXXn/3zTs3K0B71YOJKYoI3m8Q8i41PsmgDDg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF9841FCE60.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Sun, 8 Jun
 2025 10:57:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 08/10] imap-send: display port alongwith host when git credential is invoked
Date: Sun,  8 Jun 2025 10:55:17 +0000
Message-ID:
 <PN3PR01MB959770615068AD5047DD7728B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF9841FCE60:EE_
X-MS-Office365-Filtering-Correlation-Id: c55d08e0-4eac-4e0c-268a-08dda67b379c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|7092599006|461199028|19110799006|15080799009|41001999006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mz/tZZNJ2b8XiReqogauiUcqThiD6yG3esDckiVJxI/pbg3Jv2DnskbB/GCb?=
 =?us-ascii?Q?UH2FtKeiDEXl49iC1tV0YTcQ+g6U/YNyvx7widRmP/4o46/WwMhja1je+Qzv?=
 =?us-ascii?Q?BV5wIL6bSN4qp0kgCM8Pg/SJ0VgxTPxZ1digdfD6NlZJsl2jI2Kka/j6bXiz?=
 =?us-ascii?Q?fEyZgh7fMb91atMgp2SJgEMIYEa+nVW+YiJ+NnGIVQewsczA8ESu1P9dpoia?=
 =?us-ascii?Q?AV11BR9qGgqtNEL66OE+r67j826qScnHKlJUObr/PvNcQMpbqMnMci+Y/GSB?=
 =?us-ascii?Q?5zZePMzo7Y58rRcaWgZ+u8PMip++5MiNCX8SC+9HnRAvzuzWkbR1ruyjidVc?=
 =?us-ascii?Q?YFGEUxvzgNqRvQP0canGr6CGlgRXD+FzvMfOZH1MvI5KgRxCBUyF4IKMrs15?=
 =?us-ascii?Q?tIyqyEk0HiqhEbZ4ekyOobcM5LAFSTEIAQdssyVHglaZEN7J4wNBaI64nSZO?=
 =?us-ascii?Q?2Uh5JgMsdbfldvu1tVui3rO2BXquPITYOYTwSVi05QdPbr7FwtulRqirD5UK?=
 =?us-ascii?Q?5wK8g4Qe5EzstTz7zcwpIxqwV93vnWfXTNHiEv1BlUT9fKz5TiR49Uc/9nA1?=
 =?us-ascii?Q?Jf7aD6nq8fByj0fKjUCjAdMK9RB62ymeolf5OcJoTvaT6/PCYKmuWTlvT977?=
 =?us-ascii?Q?GA3KV4SgmjQRm4BmnXEaejTmI/AlVnbca/Wb9+p/vhaEcculBga7fK+MHx+A?=
 =?us-ascii?Q?mKjalokpJmv2GHiG+sOfuGphEUoZ81cVJ2x/u62YXsIqa3I4Yzm67ST3UpCA?=
 =?us-ascii?Q?2SY6jPrtpoowfhXEiiXPoms68pyBBk2rbcvju0OO0xI05pJQwil4SXIMOhE3?=
 =?us-ascii?Q?qut77sM7lvIZkEEeiriy7ucWXG9fqPXvrbDAmoDLPuJrm/zelrDkJPWDFV/T?=
 =?us-ascii?Q?hk0hvLexHtKKI9bNJ1vUj6av9aeRzzKtg2DB1VukOZyv+aPnaywUDxGyxGdl?=
 =?us-ascii?Q?Tt2Aee8ts4Fs81B3ybYMIqADIWN/yQtjlQTzkV2OzZ4UZoERfWn8t+4qT2+1?=
 =?us-ascii?Q?HkyjDWVZmSWQlTEkU2YDbmtIDN2PMX40Pcp0AwnYjsRyZBRwtuRDxdfBYKeZ?=
 =?us-ascii?Q?eaCLqEERB4JQ4bl7ytFfu86lZdl7g2ZjaSiEbt/ZIzxNQ21NvGpE+H1fJtl/?=
 =?us-ascii?Q?Z50LVKNKrNFO2tCDNEpPwaEBB/8BIldkDw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ihXLbq1D+zL8hYBwg07tZKJ37cryBZIW5ldjFGPZsbMIS8c2AWI+ZC+9pygU?=
 =?us-ascii?Q?HeOV0QNm90B5iiKfb7E8zoxDwfKZ5Z5oSkvfE1zt5Iaa/vdndF5cct0EcFWA?=
 =?us-ascii?Q?bM7a5axfqW/FIsbmj6v3DY+UNik2Ekx+DoccfJXw2aU93le05Ik+I2hBT4nj?=
 =?us-ascii?Q?2jFZVUIgYiibScKGp8bAb/GgMf+sqNfxJQpK/dHVk9VmRotB8TNehcI1BUpo?=
 =?us-ascii?Q?Am+wiQ5I9T8DfPiyEEWRNGtVWrrf8wDLWQ1XvXMH/YGMFDjSi0Qam50BDixf?=
 =?us-ascii?Q?tf5oGe3pD17T3Bb8fwDNq1Rv322mDiAzLxdqJXKknVKJZXU4D4WspNw2qJbI?=
 =?us-ascii?Q?M00kfQFLavK2YfLBrnAa66dSvnazrl1NJPE7lH0pKihkmw0X041n/mcbTHXl?=
 =?us-ascii?Q?OoErKZRu5H7TIwJTqtnapu0zY0fqxF9Q0+DLH7NvSZJ0yHM18gpGp7AJ4cVy?=
 =?us-ascii?Q?pdyc0x/oGwy738O+KT27W6lo+l2bHfOuZV2ZQrFX0zRlF5TBgWvl9pZe8Anu?=
 =?us-ascii?Q?gU/gNzXnKtQgIdyvghFGEuws8JBO9F3Vu0tIv22c3RQoNDiGz01b/9pLWX0K?=
 =?us-ascii?Q?jpgXz6lq0VY8hf2Oa/FljzlLynkdO2zyMBaVWdko0+YrChjjhIOYd3M4gq1g?=
 =?us-ascii?Q?tCbg0xXi17p4Aa0S9Hyp5Qxohti0due/1oI/A5pce2OjXaqnpk8QWPpxOyXX?=
 =?us-ascii?Q?5H+xPZEsH3M+iZCw8NL8CY0w3RTSoxDNCr2q9ntfjR2tCRNtAF5xrguGr9cq?=
 =?us-ascii?Q?RioxIP3OzyyiEoYh8Za8pePgLzSmOQh/KUvmsxiItJ4fGKpmIjGbKi5ermdW?=
 =?us-ascii?Q?I692l6tUymtJ46AeHvriu6f2g1UfkNiZh46Sqk8Eia31IhQpmUGJ9QMnzB5l?=
 =?us-ascii?Q?dbALUeZIKtluqg01dHW3ycz0ESp3Bl/VNaFXAlmxR385dUGNpCSjgjzKcMvX?=
 =?us-ascii?Q?LvNjt+JkHADsMjsy9bKZwWEiXaKELqV+5cIfJOxW+wVXm7A3oN9pDf/7Pc/5?=
 =?us-ascii?Q?fsDpdRUzYY81UmZgC9/KJZ5xE27gsvUTVJtT7GLowtBDQW3GOpLlv7X55QF2?=
 =?us-ascii?Q?ykXua6WkObRrPrzCNtrXZdVekzLeT1xYY//mrfY5hrLOireVsDCXukJHIe3n?=
 =?us-ascii?Q?P4bWLC4HYUvVNNTxnyM0BXkrX1Yc9xznRG87BeoIXkEO63tvr7QGrg73nzdC?=
 =?us-ascii?Q?kEfRnxlzsPlmN+DrcrlDk+/1ILtzsGkMsAHftMJiFzbMqD2RVsWngxHZUzo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c55d08e0-4eac-4e0c-268a-08dda67b379c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:10.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF9841FCE60

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

FWIW, if no port is specified by the user, the default port, 993 for
IMAPS and 143 for IMAP is used by the code. So, the case of no port
defined for the helper is not possible, and therefore is not added.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index a9dc6cfad6..e3068ef1fe 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1083,7 +1083,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0

