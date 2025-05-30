Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D81459F6
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626376; cv=fail; b=lUYed4oDsyqMrfniYUSByfedMNOqAD6KZOWT3wocaZlDHqv9MNLmzI4LhgdOyV7aGJhNZmrSLsgg8mvv0TDftc6elNfEJYqQaZwREjyXmyKhWeC2nXw0AXcNdk+P7XiTsZxU8HpoBLFhddYAyh8ah/Pm/bCpurppAETEBlucdSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626376; c=relaxed/simple;
	bh=kq9oF/GXYDaPFdxs32gaItRw/l9X/UNOpi95KKoBiJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIEXeEjxHUkdp3x8wR+xeZ7F68k77ZpYuErSXqlTzkrS5+2vcapg5XlQLy6t0/DcadxOTGCbSgaxoRoq/lMYF+v59D9FdrD6sbYZ85Qj+WRi+DXKkL8LbTWEz4zoaS41XjCZNQZMtG97PVZfLJt/4Va6JyzdsbKzdCejjPPfJfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=W8SgBQvO; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="W8SgBQvO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5S5GBMhhYyaRFTpp2PSVRfrCEHxBCnwrhhhjr7P/xQ91Cv2cG0VR8jUkVW6hoay+/LaffGRrszfFJT9jZDgx9qEw2Igf8C+/LooiNx8xX0IWJZNBqbJZbdIrZ+oIn6o/1HnU5WcwCbf4QD8/LRDKT8ZuHAyyFHQ9albvfA5fYSzanTb81sISwzLzHDVizDlsD4dwWp8rsYweBFVt0W8pTMSVyDMaR0pdKMzZpGtMhUHIZfMtrB6BqseLNJD+UCl821X7idMYvo5W9vViAWmfCSKWNOSHbkEmhBX874Vz5ukyEz0/T8VFyLdj+sX2N3Pot0dzXRSNMZjaDBIj+m04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGejdLtqqeqTS+LhzhVB/uCia4zr9wCcncoELhh5iE8=;
 b=OQxwUwSzTuGRsX9OwOA8iEqBGuKSNsGx58KxsPvpPTglXI4eWjPTbF9dd9V/VD+AuAmhYnO36rg1FYgzkFwnVLGl+aG4Adx4VXlkUQMlRWY35E+ctKikuS7JA9bxln/Co3G8Pf3Q55QM0fVOA8u2TXWGvTXlC6JIJ4ggBgTg2XwxBC2+dBUsofCelEEipJkkAKUUCNgJ4rJm1eQ+SqpfmbXo8JlA02VVjAs9DM6ZTsw1oi+Njj3jIqMYP2SkRxBMDGE4s1yfjUZ3R1PQF9m8asbVeozy8zYdsSy0ybhYFVOAdgqegaAfUyFanUlXRrDUuaxG8Zt01I/kiCSR+3uj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGejdLtqqeqTS+LhzhVB/uCia4zr9wCcncoELhh5iE8=;
 b=W8SgBQvOQNX2xl09dCnxg3tcjrpNFAdAsNNU9e8kp6NbEMvpDLkWCSJnU3muMWka4jb4zUbOmsZQ3+lBGQJLg4OKNYjqegbl0NqPy3zvnGN1ZmvEy+OTl3fQ8rqa7ixQhz3I+5eI4jZkuHTQaT8n3m8a3KLp5MvAQnPtrE6+qPnmJFXUnSAXSM39KQWBbYS6Lgv4XFqdUBIe0reeo/a7+fT4QCmj0BnBTZNhRXCChyl67ZptYgD3RMZjr3sDgMY/uTJWuktf6UAwJeFZt9QgIU/4g49UrZgunprmhuh5nKYjvGRPyHURgq7pkUeDYbNsm6U3ztYz0mHK53mSvgU8Wg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 4/9] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Fri, 30 May 2025 23:02:17 +0530
Message-ID:
 <PN3PR01MB9597A0C8761F3E0E6B6A8539B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c52a6b-2bc1-4ef5-14bf-08dd9f9ffd66
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|41001999006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sg4eHLtbeFzk6W/GU7kAX6aehJc4Tnno/UsfkWacDv5RrcQy+kO9VN0OeJ8N?=
 =?us-ascii?Q?OtMvijxY0sA7hJk6kXBWiz3ygyqR3g9SMcx8oEzmFR0zLa54iZGnuDOtKEIy?=
 =?us-ascii?Q?f3ZlV1bIXe6xyxLurqREl2meB5eyUBEwKzjY7QuDR06l45eNYx0haOLO5bE6?=
 =?us-ascii?Q?IEk0Bc7H9/fgwqZogUBY6xMnI+WMj7KIAB+YDXIRS/FzJhC3s3sORD9B4Ghh?=
 =?us-ascii?Q?CDj5uX+GD3HjMGwh+MPEtNacTO8Wekz+sg8kJ210+1pvBB4X2JOd5Fm/5awP?=
 =?us-ascii?Q?+fAtI4PJOCqeY86g4ATqFYvQSu+2ngty4+uK+Ka0yE2zuOs2xGuOdvyafsx8?=
 =?us-ascii?Q?Z6x0dGwdrrkJHIPwSq7AOTyx3lZl8V0BXmZ2Uvz25ZpCPCZDTG6WOzlnbfQp?=
 =?us-ascii?Q?9qb63jS7Ciz21YZ0a/pxfkO5IY0RLAz5c0PFjP7HJhPMAHGf/8Ab9wtuEXrV?=
 =?us-ascii?Q?+TXhbG3L682CUP8RtxJRFZhQhGukc/+27iZsPvVSuUErTairV16xQFwUBIyb?=
 =?us-ascii?Q?7/gsga8nR8AuKwStrOAcppuZDF3EHhyE2lXm9cYq7j3YDsY/BoUrFpTTYQ29?=
 =?us-ascii?Q?n3I4ZzpvNj9gNTpzkg/5KnAWH2WKWw2Gp594Cbk6kiZCCPxKx1JQVOYfpsBt?=
 =?us-ascii?Q?hbSSZWWF2ZjNQ2UOSImxJGuJzkTv/6isYZSdCJF1+qEDkvHeVhRcYnZf4scd?=
 =?us-ascii?Q?7JRA/qsKBnPLcnw5rKrd6oT1sUnZykMjuxLwBbvgGaGIcHdwWIxizhl41/Yw?=
 =?us-ascii?Q?QhJqQOQbtAkl8hSzCIu9Ob1KIBpp73PtUSM54AkmKc7JrDiPXSBjXa5CUdIp?=
 =?us-ascii?Q?YwgMwuy+LXvwuPOmMiz29pFElS2Ri9hc1kHo0iZTpDMi3laSXr8GsFMDb+p2?=
 =?us-ascii?Q?vkFtZ2uFNKqAuM4XGppSkjuoJR6WN+QG+1nQzpFW+WQU2+K6lOaTgLs/+W9q?=
 =?us-ascii?Q?tIswwXdy+iiYGopAzO8Hntr1qWj/HAzZIlORDGGbKbSt+guWvJTzU8LL3oEx?=
 =?us-ascii?Q?SwFuEpeiACFi+e5EiFkHJYP3K2caww2QKqtF96uFJWRfWFNeNrTZIpqnAUBu?=
 =?us-ascii?Q?zZCyG0m08h/keW8SIcpmIu20Kqd/wvCX1IKRNK/3Y+vDoBPjHY8L8dpiHtv9?=
 =?us-ascii?Q?lOEkrTVmkBLPdEUdwjcMs87omqKcEwz+zh1KYowRAc3t/r3SyGOcKXQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVRSKG+1t4eoEAauH804/ltpk2cvQtfi4zQ1nxsQTcETSi9RtXvgXFdUrTmb?=
 =?us-ascii?Q?nFmaNP2OsdZcXfUJ77NoUpLASFGX8rP/9uySCyP1LD9GlYrfMAOnORGvmL5H?=
 =?us-ascii?Q?DPxQXe8ZKhNY0NDB0HtGGk64fkweCV/iwuBJA/rB/yPFexAxrRCDN5KD5MPX?=
 =?us-ascii?Q?SkYXEk7eioY6uSCfy7lU5301zafZ8zu9WvxgXmRAbXta7BqmyavWmY+MQ/wu?=
 =?us-ascii?Q?VmjbunH6W8aYF1zFa8XJUvQx21FrxMXSwJk5ldySLQBRa86bdKgWyaC9pz0D?=
 =?us-ascii?Q?zddDXfyysGskoCuN0hhENwPJ7TK83BFbZamUrylGTsPXqkYNztmFSkfkvykG?=
 =?us-ascii?Q?GpvVsBfzfH0WXNm+cdHndy6o8yFw4tAcNCUSZ3y2QqbCWL3o3ERViPLx1uV5?=
 =?us-ascii?Q?IqVpR2h0mqdh7WdDR/suH/ixqkmhH4szRij0NC3+SCEmSoozehw9+JRO65eK?=
 =?us-ascii?Q?J1PxXocCCPO0QehqK+6G6ZPai4Q1RlmDSGpTUU4YYZTlOYh8AsYw9exaarx2?=
 =?us-ascii?Q?Y2OgMW7pz86n8Hu2HQmFThB/mZwW6VEVj1JsHSu4e4Pzbjc4vXRCYgK11G6z?=
 =?us-ascii?Q?NUBJCHKG13aX3YBBgR3JbR9z9Dw/1G+Ed7FSoNfzC3NttXmoY637drj3JYnc?=
 =?us-ascii?Q?zZ+T/H8nRQ1koXTye94WsSkPHfLrOGMC8reQKUq8oh0FEpPwgNqiAMsV+UCC?=
 =?us-ascii?Q?fK1PvF+PwWerf7OQJc1A1Eu3m/dwZUcUD9YUJs6tAtJPNwxiH1MM5/DKKHh6?=
 =?us-ascii?Q?thtd57Kl9mXYncRlo71PxzpcslXYuilohUEFrdUZxJHyJ7Rzmu3QYm7QLqao?=
 =?us-ascii?Q?c6glsTH0miJZAJqFzheaJdMQujPJwlmq8BIEf2xH+xGKEXxbsngDVu/yhayZ?=
 =?us-ascii?Q?YAFVPzxGOEjURTvnFC2RKBTZDosPQN7LLny2rCCN1YV76A2txYWpUg041KQ2?=
 =?us-ascii?Q?X7Lf2a+M3gn6cf32SLhp+nbX10kV0WFIsRhwBDtYkDJC018cnijZGkfObIBA?=
 =?us-ascii?Q?qPyL0X7Yz6dicSH7paI4JbT8NZZpKnGqD8BeaWrmlRupzIIT1G8v4EjioMc2?=
 =?us-ascii?Q?YSCF9IKCdpPG1CMVZAB+njzcsxohc5Bw/wjiCUFv1z2hWd7fSViWRicyayds?=
 =?us-ascii?Q?etpnOPue3xdh0mSqfSfHeuuY7dlNO5F+fRA6Ddj+E6+3KpzRfTEgHPwuYBeS?=
 =?us-ascii?Q?inPr1Iuxz5ldOSZcbVopWo9GybPagLAyRIePCC9XaKOD4kbUCIfyIyyfe91w?=
 =?us-ascii?Q?NI3w4iE0N5kuZiR8H3HtfH2kmTpc+g7mFu63YBpOvurz4tkXueCGS1sN3uW/?=
 =?us-ascii?Q?/SZMMcrlQxFZhshHZdYRt4eX?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c52a6b-2bc1-4ef5-14bf-08dd9f9ffd66
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:45.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

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
2.49.0.639.ge2dd5d9d81

