Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593D28137A
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453724; cv=fail; b=o0pPyIlPmtJswhVcKFeY59ob216lDiyMbkupKCWEfiAPh9opxZgdDDe03CxJMLc4zoBjr6aK+hhJK62FIevqCgIaiKuFbDED98Yk3wWzHzDeLclPdgjBpFNuRZNRT0yx9rB6TKhOHMz8RQIqNXqPhCl8bM2KhG+iIs1a3y0ofi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453724; c=relaxed/simple;
	bh=2Liy5AQDatTGZ1tj/tnd3mT5kwqAIA0L7auS9e2iZjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5YAFwrVGFG5LiaxhXZ/7Dywt90xoEiTGoS9+lGlAasTNNHZkYVER03FMfmWBf7yNBlUkWW3DxTpxex4HHgmc262NHxFcUmsZE2nL1gLDHd7kNI+u4wW7BPAepvhXJmiNSThMO8yKezuLF/CJfM+iJ57+KoH8+a0dn3cHa5X7bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PsWvhto4; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PsWvhto4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGRiyDVAGrxGz1mDZuW2ZC/YniDbACEfKsw+fFLer02nG25ggucBuPxEGHQvBOHkViqJkKpdih/bRIWPXHMuAOlVN8sjaFtB+jTM/HxTCuK601dgUzl0bdkFNdtdBh7Rw97HxLOnouXxLEMvqnmOBhi5Fmr/r8QhHX8HAJu450OY9vmB0cBRZmGVgRUyp6f0RLquXd0G2LYTu6NBknUAKL1patOOf1fJ6+w4E99K/d0utQRJcY/uE3xQCNh1Mvp4U4ZmBYoV4K+kqLmTxKeq75++3pPgfDoJUIGvSUpz9NFC9gV5zUIYXTzngT6ZrbzlyOGt9uYNcLGsfiXWVI2nyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbUYbDiyC1wGQuJcebwh2j0yYphyGHF2UCLZZjflBoI=;
 b=hLMjLS4lYXiJTEBwUwiLu7w45uYsiMQdtQr5PSAUDMViBSb9SF1T8NtkUPK6LvEA+ofHIjjRhQh+I93X1YrF9Q4ZoqUjuyUK2IQ1IFswXop1EgjkfIx8MMpt1Pznhtsx98YOaaME6QamEv+weAF13AY+/RBBhfylb5V3j0il+SWpbZvIvQDPIHebfNmU055UOAmCC/PosVieKRLt5uM0F6+ynV4diJl8zqkNrQaTwSlHCgdhL1voiUKa7dlxOONWrAZDZ53dL8wbxe3HjO+k+7Do8H04Q3c9S/FGDXWpfQFSXeOe+hKVU6dZTg/a6HXgzjBneaQdr6QU2DfJZ4ap+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbUYbDiyC1wGQuJcebwh2j0yYphyGHF2UCLZZjflBoI=;
 b=PsWvhto49+4/VQ7IBIgurIq72tx8KKad7H4Xo62jELMZViGKEiTJJiUdIwXWNBBohWqCSOwdQ7uKWqpPPFkkqbZgk6NqnMF0BJzv86p/R9a7fUJwCCsAP7U5haeB3YY5zyJMnNGcw4LhMZAbDeJWtBg2WBDPiAp7lfpXuOhKEktx95xoTFHG75DMNOLf410PBAZaV3ZvWDUn3uipLTo5NZQj3W1zj5Mu+qaBml2eBrzh986JnFyDv3fxNxheXjokRQdPKUDCRRg78sQZ3zxPNXeutc706O/3ltGFF2L973MMvQ5QyVosYOHU1+4zoc6f6N57nd1EmNa3HRUwINDUBA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 09/10] imap-send: display the destination mailbox when sending a message
Date: Mon,  9 Jun 2025 07:20:40 +0000
Message-ID:
 <PN3PR01MB9597647A1FE9451BF9EB1C6DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g6561d45bee
In-Reply-To: <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B5.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609072041.12114-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: e859d0af-3ab7-41e1-7222-08dda72648d6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|15080799009|7092599006|8060799009|56899033|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhbpjVYtKi2CFNz8wtC6AZUiPVK2ezkEz9Jfshm3Uly01xuHcNYvrYeybjmj?=
 =?us-ascii?Q?lJPkI4pPsAkhkhPIzpW1MUUZLA+9JsPTvuF3mpN9Ws3nbKsuFgI0FOvuNEer?=
 =?us-ascii?Q?hfV7B392/3ovQ1RCbmJjCDx5/N3phWrRJYkz4KZb0Hl/26n6E6NJCZyqVqSO?=
 =?us-ascii?Q?LClj8aoXod+3afrglc8ZVmUaH65A0qJXWkqqzpQH4z6QZBi/IcZdvNbG7cWf?=
 =?us-ascii?Q?Swe6xUptqr1bmvinNaXvxa92Euu13K4XHdZiPT2qkJStFBtgLt2CZqGn6PXF?=
 =?us-ascii?Q?4lphX2PnH6DvHQep3n6MGOuPvobZu5P3EbS9Gs97c7jxERc3mkaeqspv5HpK?=
 =?us-ascii?Q?6jFyZ/UqgYKzdRtiEi0zHMGizsMuuogzgecZxmTfeLK7v9RXQLqSqZ1cYIlO?=
 =?us-ascii?Q?itevk+ASqnBKxmFq0lS1+Rmm2rURunTmBTNpP5q2s/qGsoWQJF+eO6ASijhU?=
 =?us-ascii?Q?XZdQ4Yt2yGp7JWaIVKBMxuwY5YefWWulYE5v/Ko8w6A9nuyDKUZpFITjD3CS?=
 =?us-ascii?Q?2Jx/76UFCqxNOyCOqDlGQmzcJZ92JZpBWD502x0F7a7XPT7XWHvlV13/G6Xk?=
 =?us-ascii?Q?nUQz0xoQ64jk2W6hF+KC91Ela+UYO6GdzdP/d9XRrYw4jKhRW3RZAx2b6ayz?=
 =?us-ascii?Q?o7+C8o9gHdLB1N4dWSQsLa8/d2wMgiq/ES6SI0nnCZ+GTZRU/QIHuR2lbVyF?=
 =?us-ascii?Q?5O4pRigThB9RW6+vF1Y61UyeYt9gYahds0CmYIYo9QLuqozM1yplrjE4D17s?=
 =?us-ascii?Q?nf6Ldr6KmSLN/5fs6O8L/NtAIhWw8sA0H3CXeYRa+8ftmseq4y+1CeMP0/UV?=
 =?us-ascii?Q?AKwS/1mdx0cTlzDosGeiv6Xa05FPNdX1p8GBx3zeDHK7NEQVSSnV3JglmR95?=
 =?us-ascii?Q?f97lgVom9BQDoBVuifE5hqzxcNL1Uu/X3UfiJvzVGUh0SY7wf/gJS/adUxDZ?=
 =?us-ascii?Q?gaZu45J1RhyvHotZh+s8wr3ECqw530cb4rRMUI+bHMepQFfQrNrDDZ3uItAD?=
 =?us-ascii?Q?W7r6VKXN+SiIMXz/ny2YBdBiA6K0veHrA6AD9XbPsO6t58tde9sJriUebLYN?=
 =?us-ascii?Q?y9MhodVHseNdwwrdwvxlCW9jD2GKWDogjwW16Nu2zVHzWqlDLbc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7e3YUMBlL3EqfeNdVdX/KaO0yfKmtSWCL5LlCa0Lf1dVobkurQRpNf4oMtLR?=
 =?us-ascii?Q?tF5sN2PoNnnYMMZIPddCR9sf+c0nnFmBeGQKLt0gYc87CnwhR0moqXk6MI92?=
 =?us-ascii?Q?tjwxsjMKYu0SP/p1h4zbMEX7tDREJBfZavDydlO+GKyiO6SswuoPkCkxK9Wq?=
 =?us-ascii?Q?y32+OvIFvPn1bRO2cXf8M8tdUt0yPDwt6FxoscW/VoilSOoRfzTAyYC+mLoB?=
 =?us-ascii?Q?YlF10af4uH1Xc2ZIUCUX1pt8+Tsd99LDbtRcJk6GM0RuPPp1HN9Ed8SSqDcX?=
 =?us-ascii?Q?wfVkBjwRBIFB0RWqNsCGVKdJZhyobFukmbSbOZ3orbnX2G6o8xS+zubQmEMh?=
 =?us-ascii?Q?jrZD3CceBoNUnq3suiHSdhUX794IDaw4H3voqnMT6gnjJQ/XuCwhCMWuFGFd?=
 =?us-ascii?Q?8F/j0lFanllxmm5YJEXtE1svvGL3PQBlN7HsVapk45SCCp7QAOgzCUl7kxVH?=
 =?us-ascii?Q?ULf8Jzm6iqfJudfVQmRmEX8Ynwca1TQJnI9IODE3z6P5w1R3w3ty3OHY4XBe?=
 =?us-ascii?Q?AUNxLi8waAErJUUDK7wrPpSmQsfrKz4MINOP4NqroUrInM9BxrvUklQGHLqv?=
 =?us-ascii?Q?GaVt7qB3YpnqTvi/45/oVIicBEG4D8Whk4hISIjN4tdIN5gTAVr7XfNzr4wu?=
 =?us-ascii?Q?/h3gCT11rVB7HtfLV7sGjiU2RYTkRhtMWiuoMvt0jRnIe+HizpOtr2zT3HS2?=
 =?us-ascii?Q?zQKdAGELu9o63B1X0vx2g+2N7fQj5GD8RC5Max2I+GYxSwkGmW5qEQ+Mhiqq?=
 =?us-ascii?Q?p09CWQrFXRdqTkOcxTaUrxJDIykhk+Aj4FtBZKvyqWRoCBU/OosmXFKW8V28?=
 =?us-ascii?Q?3nBYUokbKvvPLB0uBWrrGBcGML5qEwMckYIOBGYTZjcbKs6mbhdW5nXeht25?=
 =?us-ascii?Q?LSRdZDr+W0d5EYGA3VPONuZEi/6yyrtCh4At7RU0O878G5mariCoKe9Og8Hv?=
 =?us-ascii?Q?9CXFNAp16P3ltuof5T0/c4UULBhGNOZ6oeqXNIAyV4o/Zs8CGjiffeAI/Dtw?=
 =?us-ascii?Q?DLPP6d4PNSv/4aFdNy1VQPb1zLztWrF12q5hmhWhDJ4+UGH83yIFcn67y/yD?=
 =?us-ascii?Q?0PFjqO3IoNnfTKtlfHdgs/ke6DdOpoYtV2nFgYAiUbSQdzQa7+GR5mb+dWHM?=
 =?us-ascii?Q?tGK4Nw86/g/ngTh8Gz2xCO/95LbNvXqqDoj08DF1pOUIBTOEPRAEczFgMu01?=
 =?us-ascii?Q?4f7F2flzCPamOaaMGuE66CIfl3UBhmxbyfJidtFfz2gPDYRbM9ylYwMfe40?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e859d0af-3ab7-41e1-7222-08dda72648d6
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:43.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    sending 1 message
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
index 9807012169..3d6bcd7e88 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1563,7 +1563,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1699,7 +1700,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0

