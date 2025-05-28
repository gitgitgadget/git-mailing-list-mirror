Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775428B7E4
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452715; cv=fail; b=gTtGsksWGtFKxRJf2ojesqsHWI43MSc/N/7lsAaOATJ+1iE9ejQqRT0gIyQX4RUjIjhJu2fxdT9OSJCISS/6Dhhyld6rMpwlvyKRzqLEYDtPhxZMFIFnBDd63R5y0mVPG+TuCOr1cs7SbRV3eFPBRPA0ccrvJI1clCYMHUJMG3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452715; c=relaxed/simple;
	bh=onPXUdRP4vzPgINBmSX0viRegXNAvipKlEwcnQqB9aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8xpHfjRbpnq7BM5t1sRHEzzSAnsU5ytvbgyVDSEXjUAkcs1YwWM9fiSKWFbrp/GcarsdpygEF8q8jfbrhtXFO0ZLwl6tJwDHG0sN7tX+9L4fH9J6fG60PVgEZGSbfr/WzRxr+sl5caWC2DRQ2i1ZoQDOt1ftqOPStzGmSBaSKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QjbEZbU6; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QjbEZbU6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMPJ/HleAAvv5f1yGeMaPlF1nW/fRzu2uUo57ARsGfvRpgEs/uVCmaE9wWuBb3tzJMI6mkb2uiGVukNvmY7a7p4ovwZY9w4KGWJHq/T8MdztEMX4lWJIrrU/Oy2EyZqUMZQYaeXPPTR+tKnnZWS8DzQo0DWejqi6TG3HWknocf+CT3ZzahxKj0dxWfHhvuEl6M88nxxv32SKLnLELsOXNdsQP4FuSBFoWNdxgdB+CG3flNno8U6CqxZTQbyVX820b2EfIL7/ttqREHSRpB8zGolDUS0MwDZpZQ60+B0jrz5UiXklRG2Nq7uuCqGZAcpA0nzopks9u61HWAmeRvKC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqvfFU+ZkeuVfIDb2uQH8qH6oSTuhTXFqwQIxerYaj0=;
 b=LX243wgNk99i3xKc6UCmpjCkFeTdbkVLprbQOX+SBUY0TZg5PEcEwr0gGrGYUHhNbGkgvMLuH59aSIqNVdTvakF7Bm2y1Me74OGjHA1d5me/gATzGrQXUj4G2x503AGAhOSGQzUx1/AFelizZEQn4hkNCp+JVKMKdJLJro+ofTwGwHj3xF1OYD+FfdB9r1GgTcCiFMjvSik32gzf5rbrXuXpL4DCd0k+fjfEGwP406hYPp/7QA7YOHEdoHMQLOQT6oC5cRPD7l2EtBN8yN7gwdi82UXVEWhl4WNSbrkfcrupL/WcvBsQodxaqIsWGn7higBegU69OYKUQj+/HX8JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqvfFU+ZkeuVfIDb2uQH8qH6oSTuhTXFqwQIxerYaj0=;
 b=QjbEZbU6tvhksWF6YL1BSarw5HePkP73P2S6TKYJxt6OE+yKSdV+BFbJlXbq7qVUgTxNgPyYhZuLGt3soGZwrRkJGaXJJGT7GNyP0E+yQlk4RX0GqUb4xKPo+odHrkqKNPM6J5u84Q0pn9qpE6d+Y3SUnjl89TlGROz3S6dGilC3PRNahTyC9sXuMWoGBVtl/gBtflHvNo76hq52r5aovSTxwPUTMZj0iHNHUxULHce0q5VfMynQUlGvrsveCyZBYtBnOhdaHthe7OjI1v1l1ls0RoRdI79UcCjGKFIYpQ4j21X9BsozYSAeDwfUj9aSJ7FgWZfw6ojO2B4JWRsOjQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 4/9] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Wed, 28 May 2025 22:47:50 +0530
Message-ID:
 <PN3PR01MB959757C4C2C376A0E44F1AE6B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1d412e-4d79-4279-80a4-08dd9e0ba7dd
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6otDHf//Td+jEHbeJKNOR26bn+6u2OACNZubIkMcf2KXSyi8+GyvtRZK9RBIVxYcz+UQJ9ZaY8bosrhhlGNbOLk9JP+/TGCi40o5GBngt5gOKnsCG23m+ilS240mH+zWl55JSbZNvAj91NsBOZ7LE0zTDwni/YkffXhdwwkQ2rP4e/g7VQsIVX1N+avI7hFnJALkXr6O4y6DM6gOeKot6Tmq6LcbbGBIRRINudiDyZByIMIjaVRNYm6P+JS8CHrx4cv69lB4RTDu3kl50Xu0PAgTvs+VU2H4594oTIEvI0opIX/S0u7pLGCcDNwFnEJyO2j/G2O8xzyTM+NeiR1Qo8QQTx2s6ZoWEzT6g5Rql1cxrzhoHWBaifwPObj6ATb/EztWabiRVT6/eeTAYIJSefCWiphC7cFEKVdgOIAIjSdWEa2evMmTIEhjHvL93JEfcvZKFBTDSuEwKJ+ewti2qqL7biFan+nftluYdsdYHnr+8i1H+d+501mJ84rcW00da71fHgQMOd9zZ/j1u1XIkmqf1pRfVD77L11ACyKfnE3SB13eCDc4sSFdS8mlyfodZgXosDtufqxHniezcfJFmvL2lvdOCeC7Y8ZL0DiVgHQcM0CaBa1RRgBJuLYl4+k3GRKYq6YWZekT6PGyajsdfCZJ0BBNZLVsK784/iyBtZUbzM8Hbq5FrMmOoJVUjnXC5sfUWgYJMMvw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|41001999006|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bd0kUY4GTok9I65a+iqG6TdqHdIogEHdJwodDx4FBgW9QbMcR96oJH3Vwf5M?=
 =?us-ascii?Q?LaOyxwFMrePrerynL11Zyww3TG28cvHbR5IEGd59HhETaZaICabknsjX2NZT?=
 =?us-ascii?Q?XZQTFNN6oMMBeK98QdQrXi/8yofNuIQBsMMf4NCREMOrhS7GZ7ojZXLO+g9i?=
 =?us-ascii?Q?OW3Y3cWt6qJpmxPU/xLoRNn00a+XNwhpLwQ/mbOlzKnbZkBGD4zH5EhHqjH9?=
 =?us-ascii?Q?TVw8Op9YxzOV8z6rvN1AZmbspFFG9yS/acL8ZzxAU9C/L97/mXa/5aLLkUbD?=
 =?us-ascii?Q?cvVfTW6MYrE2kou93MXyyhfGn9riMmuO6Mq/vHF024M4nJMYvc0azqSOiggV?=
 =?us-ascii?Q?VoAZI5peDLe4eAgTp7Nk/25/eNLqcJsZjRpjmAV2V5JrpAcPUl0OUDvneH/k?=
 =?us-ascii?Q?g+aA84pu+dX9wuWR8Le1xmClbZd3OfWdDiWWhbrCnAZS+TdLPdnDiBRnwDaC?=
 =?us-ascii?Q?EuEXjl8LerQeWH3Bg0kLGo6gs2nN0I4SfEKOdlKyflRkJEKkWD8s+jtrtMQS?=
 =?us-ascii?Q?HnHkHdLcLGAi/jUb6UcrNpm7eWxqHCvJcJw4b8pX15FjtJ6k/qs7sKEZtwI7?=
 =?us-ascii?Q?mPETT8z97K0vFEra+HdNuYFzSj3WUILPi4wMIEsnnSOPPq3Q56TfbPcgORm1?=
 =?us-ascii?Q?P64oI0CUo6QbkbvcJvgkRprbpDk9ylQctlRIx7R0M7XDXQA0icE/STlcGeK8?=
 =?us-ascii?Q?f2mezOuxS78CxKP9YYs7yraAz9+tWzAO7jumeua1na0aodJyE+0+TeIp2glG?=
 =?us-ascii?Q?qrWrZFJyA6lr1huXPtnnbhXS6w5VO/S8cvg8rZOuGtK+bFksNY8HAkqgL18z?=
 =?us-ascii?Q?uxXspGMoG5520Lw6w4sWyfJHHVcNw9osGflamMzqOfDYQPjNpPEtxbKmiTnv?=
 =?us-ascii?Q?oKA6KAHWvYZPOi0ylFDhrHprSl94klmwkZhP17UqcWgQ4YZj8D0gr1kemkLw?=
 =?us-ascii?Q?9hyUZJR42mzrZcLv05Pg9nQLWNdQvkFdpFkS4WNySKQoSDOd26R8Q1b9/QGF?=
 =?us-ascii?Q?6/ujRmKpH7Voswrlsv4wxxGn3/8CtNvnaVRiR0nmXnxveZgA0y2nRc1Dyh2E?=
 =?us-ascii?Q?arwUfUbwMxhzPQnpOymzNTwUxLC7M/ScfsMSTzrz2t+SvdNQjTRGMsn8dWYN?=
 =?us-ascii?Q?o1v96QGVOcP+nh+c9HIvpSZsDoP43Q9+hGg9rMs+gsXDUEat3qlcZZo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+518qOf+82iSKmCyfHTSfAf39JMCRts9oBUJLuHcN81OPfeiQW3P8urrzBWR?=
 =?us-ascii?Q?z5nDZqO35JVtQlEUwN3VonUl8k9MvouRbAYFB4yMcKSmSjvFa1Fk2DyQc7kC?=
 =?us-ascii?Q?QW0uN1SjK5v/L8MjpiYn7TWsF02E60ZjRP1jhXANbpKU+e55maCoQpw86eD0?=
 =?us-ascii?Q?NQrIi11jIIBar6ArY7oAoDek3Bvguv1onHlwheM1p1WHE14DU5iuXnng4QuR?=
 =?us-ascii?Q?cOS07YLPXI56elMpVkk5J/aB5Zul+PAYa2+UEK+5aGqh55lspkovFBd+57l6?=
 =?us-ascii?Q?o7cdiEoXVgPtno+gGvJsK5LC7Su+IAtiYZVj/v/cuxLucreLXitO6Ycqzt+H?=
 =?us-ascii?Q?shrg8BWYlscg6KudmnW2H1t1STEEwPOdh2AzmObeYH8qLNW52SccowT9pw8w?=
 =?us-ascii?Q?MmY3Mj0iYNR2Vee+vb09AIrWskgmXTWlqYg2sKVVQYNooaZ0wICsGHSwCOMC?=
 =?us-ascii?Q?ceLND+tObyUXmwNPvBvZn9TCoWSMKsPCmnDGaFjt+GsUG7LkC++vLJvHK7YA?=
 =?us-ascii?Q?TogpTNTZLmeATZ0npsKxbOHMp62DKrc0wiKYn57JAdFVYpuW2E85ueF+/ZF5?=
 =?us-ascii?Q?yM0Dfg/dENRGA9q0iVC6r78RgWQA58G11KyjTFeA/zuzKgE7xyV2YWj9hMRW?=
 =?us-ascii?Q?yOa0IGm73NhcLaw0RpN9nPzcH+8bYnXJyxnWLR/WFuPsnzvyBqFiVANJDlun?=
 =?us-ascii?Q?b3HHaTV2g1WsK3IwLP/06WY7/CpDTKOSxreVdZLNFCJnEhOoI67jBmyt6PuH?=
 =?us-ascii?Q?MfFIqM7WmKJY0awCeGz0+4JUCbAnQjdEgjOfqvDzbRpWm3Sd9/BYlkyctz7S?=
 =?us-ascii?Q?7xiN4KRB8wCcdQjfZmKRgQPpfdlIX6Ej64VjKX00pwHCZzLHnvqYI7k2qnxL?=
 =?us-ascii?Q?LDrHgf7Uadf5ljce+F8oJNUi7lpHpld6Fp9bbAyWfVbox52K1Je2carHc6Yr?=
 =?us-ascii?Q?aq+ynajO/W98CGMZSRf7TvVG8VDpitSX/W6PpvgAHKSLmmUd4Q/JXiq0cXzR?=
 =?us-ascii?Q?b2EwjNSkf3XuDnbQ5DnALeVh/rLUPh2Fbr4cCLKdyanRz+x0h9380t3LggNE?=
 =?us-ascii?Q?9Jua4zwLxobUOC3lgttpsBNIYk+UDO9OAeT9RftjobLQ258LFdQn2/BJ0LL2?=
 =?us-ascii?Q?hDulVlEnz9zTeU+yS/+j9ZB9khRK5OhtYavG6GJYmN+428Zb+1Ond7ctavCO?=
 =?us-ascii?Q?4I4eH93xto96wq3NbrSwQtd30W+4oTJKV5Z1DMBPzZJUb3lqp+SNayvBXp2K?=
 =?us-ascii?Q?7gNtZVOLI8+3xyFhNQ6FHGXplnXrL8wkWb1/WKkoRU9Ymd+GglJnUGJToX1U?=
 =?us-ascii?Q?hFrTFIueOQWLJz+yFNtHcAWA?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1d412e-4d79-4279-80a4-08dd9e0ba7dd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:25.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index c07ff98c3a..d0c7bac030 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1046,8 +1046,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.49.0.638.g5db5b64a3b.dirty

