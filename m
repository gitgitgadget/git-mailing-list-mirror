Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357528E60E
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452722; cv=fail; b=JKRG6lK//X8OC14/gCyJmlXPmYsgUEtDKp/jagFsYvrcOHahAzg9rswynRBtO8lh3IDpKzrLVIOpY83ffiQ12tcLFinbpcbPaxI3IY1QX/TonTM70BzU/EP4E19uowwYnWfkXZeHhsj6NChE65FGRzjzAJN2fMXOT1WXoaScu4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452722; c=relaxed/simple;
	bh=dy0SMhuOEHuZey9A5vnjCtNygSs91XxKecrW5vrlvNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhaX+fYhJWs6xvvl4jWSKLELBtKW6KLFCK6u61ipH9xeNYTiX2H5oOTVqQW7m78B28hjx75WC6yZeuxQzWhumA3a7f5q30fbj2zUj1JuWlI2Bu0kuI23lnKBLEocrLTaiKsR5Ij7wkaaOQ8mhzjVAGx7iGuWiI9joZTnmJoTU5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bPXG9E1n; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bPXG9E1n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APQuWEo42WSGAQIIuK/VVlMqlGz09U0lo5U32NWPMIT5kHZ9wPPQRKQW5/8iYz52Qd401yfIesNp9OVUlwDu9FQKDPUJdJIOHT71FOCkZ2C7uqVweso910wGFnYHMu0x65pxOtoUdln056gubvlvRI+Hasj3NM2LWtPDvLEwV4fspuFXZXW1yyTi5WEkpl2SbwLTlMbqsynIeiE8MA9FUQOP7VjKRGVjSPVP5nChoUG+tV+ZtpHRCNHPyrbzEfrg9Juo/6qvRyJ8XvLCo2/7iLihwmvIKeHzmFp8E52JpuypdRWRc4Nk/KwbHG5Pa7gWIGwrc9oW4Lxcx+rIa9PxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YPgEf6BnEjoK0pibbH+TohaiZmAokKTjrzgcFXx8ZQ=;
 b=rYZwR7JL4F4RtlRLDFp1r8ltqaV5tXEUnOjHPPfWWWgcnW6VHMLsMEsTCl326IjrEjpv2eqPhoYLhhPPRLlf6GKm5LLLaI/mWsFaHXxEPq3C8gngbIDT664y/UIwuidKF2vawPIaco2XTKUL1HOrnHNAIsQrlZ+NIpGvlVEB1FmMQr0XvWZyDPgHvxlYcZSzYdkXIDflJ8WmdFV0r/IOPuYsWCrkSBmFKq+RcyW+6XjPrDmQmp0unTeO5Fk5p1GxiPq97pq3gX/O5T/qDm46oxgMdETt6qEfD8yrETK3oD2/MuZBMkQ1lFK9XklgNeSsfLtlQ9NqOS/7P2/mp/KEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YPgEf6BnEjoK0pibbH+TohaiZmAokKTjrzgcFXx8ZQ=;
 b=bPXG9E1nxLxNHHmCJoREd45sp8Knl+Cy59TVQeS5YC3WjpDNGC0x+5H+1MiS6gvB2m5VOopRKKGRRf37FIzLIQervGvhdlOCTfR1QI9vYdNORbBq0VZiDA0Q3PMecR58IuOcqF0Cm7YKh2AdogdxTeGSYm7vNchLWhNu/xUQXmPu2EPhckcNohSnrzUX7boc6xD4yo+Dlnx4w+530m+xHe5OzeAvBtSaJMbsEO65joSTTZqqOdLGehxRfSEwfusiqt3HtMlgGUjonsBGOirfldnweLyxOGfAGkFGjcXGJ+EzNCm2803LKmnakK068QPytYpsNTnoiR1sYcYJOFyebg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 9/9] imap-send: display the destination mailbox when sending a message
Date: Wed, 28 May 2025 22:47:55 +0530
Message-ID:
 <PN3PR01MB9597747297F1569DE7106B8BB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250528171755.90367-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: d572b105-3f86-4337-6369-08dd9e0bab1b
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnF5oAkD/pH/rmlyDdSJoN79Z0e0hqI3e05w9HeY0fG0LrTSFIE0u4jnDPMCkyOEB2VVU05atmxGcipEqDV4Ul2G05k6TJln51TEmcfJylqJaKwbghOSZCpHb8mfbkZOTf5IvhpH7MZgTRcOp90Qb0KrumObvP5VS/dUGe2TPhThHXDlXp9hx+aWHWI9UvdVyUKnSw1qavbbCrg1oAOZdtbvXU7qRNQyNQDxeXlMkR3t3xXZsX/31VdqStiC+3SSJlcC0Go6uj4UIZRDBpyv1Fktqz9SM07Qq9iYWlJm6Qmnvkg2FLzOJFUQGzhNhYg/lyaBuzOmorbJyQMqU9xiA0eK/IOKkenrQXXnIwNSpJgP0EPLuwObbE0FIO+b8VoysUUURHvX8qOAzowEMYX8cWGJmuO5g4nQwLED/4uwhSlNr6/DTAHs0fa0L+b6UevzTnWPCYHJlPiqsAwOn8kShv0Zn4MkNebc9r+smdwMOtQtGBCneEDuBva+kuvz9mrZAx9vl+6OJ/NaYwHc8ya1OUNznXDLoHU3F4D59VzuniRZBLYyX8GnntFroVb1ut4Y5zQLMO9wff6uD6XrEfafRlHz2YV9zooIDVcdkQQdZfOwED7cjGUfK8sLztHnLmOgf8+oHx+19KgqG+t2yapZePw1veRhIbCy2N7iZkbPQP0U7mRPDUQmlb1IjTY6R7co1h3JiJKdInQ68JcRdzX5PHpUJMlcQNkqdreywt76+GHeU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|5072599009|461199028|3412199025|440099028|56899033;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RqEnebxFtW/E6aBn08fNlxYL/xtb4R7/FAhoDW8Cm6vXutD4FlxZhtR5bTj0?=
 =?us-ascii?Q?MageoDPSPpsX59xl4bOnPEvTIibZul1qd+c9yPk1Tv/HJpH5ycMNcpMe5nID?=
 =?us-ascii?Q?XABpLOeRngKxcJMuzxJ5jLzit6acjWUuj+VLkHm35Xlx9do0T7CwHD/TKYOY?=
 =?us-ascii?Q?5fw1az32sjagBvCjQ3TkTfQjuOg1rrvknq9BD3FU++CBLwDN18QqhgXA7kZs?=
 =?us-ascii?Q?iF+b1Y7LOPqmB20u94CVISva/FKyohp7+yp9/dIiLjgAA3JG9JWNsIe/hwIV?=
 =?us-ascii?Q?gfaC3JsvSQe0KpghgKgvcO4ytJgx0o/AaDp5tvoyKrGO6LP1pz1OzfolwPpf?=
 =?us-ascii?Q?1RuTAfATEVkCypZ9ueM10DsG/N/PvJ/5rg+uTd+N4ONXsyjXo0LeSCfl6oNi?=
 =?us-ascii?Q?N31Yi2eTodkIwBqZt1SowqpDzLyn/ZnrU4mByc8+3hYInSsl6kmswkFnLLis?=
 =?us-ascii?Q?wufLeOHRXTJ7h1nzK5WsgKtM4EdtfrwCLS8+Kwb/hqtvyaB8Y/LYJCxyFgys?=
 =?us-ascii?Q?uBEI1bqmA6OUaysdZBLzwXnU8DvYMwsprwo4GyME7M5Vm/e0SCeeC25MLmvk?=
 =?us-ascii?Q?Ch+aTfmfA/wrGVlLfM2uD1dNx7wRu7P0b57TJ7GDo5iDdqaGl+2MzTo6ghNr?=
 =?us-ascii?Q?w/SeVbNIN3E/nkA+MX8YuZ2erPkNSOcvJDagYNPbyR/HthW2ScVbeE7IH4KG?=
 =?us-ascii?Q?2yy4BrBaHt6TEEjTyFAdCpOWhWnshmLUZD7OVffELys5neCpZRAG9jEXzlxX?=
 =?us-ascii?Q?LGRQ35GrlOCxSVmrU976H3Bs9tMvHgnt3MWcO2YoaaJL4SUj7bCQD1gMnisY?=
 =?us-ascii?Q?ZijkZxojnUr2EhajVf+23JqryQ3vLvt9UcSxWvG+dcElZLiKWlIT1zaVjgsY?=
 =?us-ascii?Q?Z1InYzSRXXbrjVZAg0ROLANualZzCUvzwbWM5jCp/WOwTZd9oq0C6WNHlvGa?=
 =?us-ascii?Q?GO1etLb7Tcv+ce3OwpsoB9G3pqmiNCE31L+QOJn+m0TihbpLX/1NoZUUxxap?=
 =?us-ascii?Q?CYi0OtdnvwQnTnhL060gSWOdvw0p9/cpNJsflX1ZNhCUlt6fPV2Mty2lAhlr?=
 =?us-ascii?Q?y9X1vy7FSHilMGa3Yc1n14/oemVyO6TDSWg6xhX7n3y1FDhA5nc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VH17lqb6JymA7nU39jK168HY0kAG0ajqYCL5yOFPjb8Qnhk6qgvVgy3r7z0+?=
 =?us-ascii?Q?PSCWIrZh/vJuXftHsFjPQn9lF9saeFVBwzzkaJhjWGZ41LF0sOzOw6OOlf2f?=
 =?us-ascii?Q?j4f2xypCejh82a9RR4qeYMVlEXsA3ZIIupmATYZMkXdxLlo/fsIE24cdbPfP?=
 =?us-ascii?Q?awUXt33ojpMwqtOSF4V4XfgLqaNGVMF/ZeGsXQmDYmYb7scpbCYJGac9BKFB?=
 =?us-ascii?Q?Q77pIAvWjzUHl0hbSEjOMHHp4jHhtmL+WAP6Sv19PRNqS/3WaqFbu9GBMT9U?=
 =?us-ascii?Q?/p8m4+i/i1f1j5y9Vz66yTdYlbArJJ5oec6Wzcs6radA8huDU6KMJQJS0TL9?=
 =?us-ascii?Q?N2Z2JLLMjqkBKupmalpQx6zKG+wmJythzYJ4Lot6DFT49sVmbuBujJljvcE5?=
 =?us-ascii?Q?arnkO3a4JoY69MiUu34f4AenpxYOS1rFzAnB5JWkfvlRVbPbyG/HdQhCdzQe?=
 =?us-ascii?Q?G2GVXuA6sJN+fXU1zeODzQ9rWg2+RiI5REEHemkv0ywDjWC8qHQ31Cprw/Kk?=
 =?us-ascii?Q?hAe/GlttW0kHVCekgqpb9qIXZKsMmXB1E9z0RD/rkN3bFGK7LayqiC9z7pEp?=
 =?us-ascii?Q?qe8nffw14/8IxaTEkoN96bLSzl3Da45VtSrhb9kkombvOMsr9AW26dbzOlgf?=
 =?us-ascii?Q?BlFpRjNUMCs3XLZJtMHlbxa+3qRtSQcIUmv+UYGbdUJQmrWLGtMj8B8cIUb7?=
 =?us-ascii?Q?WvFKG46gLPiJuoSuw1w5Vb//sWAFEr3RlMAtlkzqUhG6EVr560Vuldh7qhkD?=
 =?us-ascii?Q?AMgcMRDu6M9P4A9a63QSieDPUF6Ej1fHb5zuFZ6awSTvXhnQKrsRtGlzEiXm?=
 =?us-ascii?Q?WyqrFUOlnh2lLKxqvA7ZtsIDPP+p1/HLhYZSsZNuOyulJU0RyDQTyt47YVKB?=
 =?us-ascii?Q?KDh6VKXquABFSORGyeA7oieq/66r26Rp4EhnvQ4cp54QV/hN1kWzd1jlJTvy?=
 =?us-ascii?Q?HIWyILO0cmQaNYi2bS/e8FR4UKMOz2WuBFVQwcXqvzFvc0yXqY8ijJdAKMeX?=
 =?us-ascii?Q?gNx56ggDmqYn1m/jGD7Es8Mfswg1BRiSbiG13ACd94WQqNHcgqB0xhtCdEJL?=
 =?us-ascii?Q?qTUp11fYVzHDX5C4pLMAIASs2/ARoYmJTU+mq7bXkMI4exuQU2wi7s9B/KvE?=
 =?us-ascii?Q?wOpPQykpmjOrjPGL2pPFQGqAOJgOpvV0XSpUpNbn70KF9XTxxZpYgqeAiVdS?=
 =?us-ascii?Q?JYNOMq7pouqcQ7/Q9s+y8ShvV6vBpbW2ouDEt/LVMrZWGXZg9QcW0a75N4eu?=
 =?us-ascii?Q?Xm1RqDUW9CQXMUeqKAg1slUvD0V+ZLimjSRAt8+65Lc/w8J43y1MvJtKH9+v?=
 =?us-ascii?Q?N/mGeDATMwqFXN4oX9U5hMFw?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d572b105-3f86-4337-6369-08dd9e0bab1b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:31.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

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
index 3172cd5191..fd589f8aa1 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1598,7 +1598,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1706,7 +1707,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0.638.g5db5b64a3b.dirty

