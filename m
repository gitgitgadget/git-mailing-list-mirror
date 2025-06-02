Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404202080E8
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862046; cv=fail; b=Jfb862PklAW5WD0ff5zi4PKV/tIYuTWuus1VWt6DLtzDx/GyXBWeYCovZR34Fnw0Xkz7sTZUFjRY9Ye51IzfpbtD6QUFfQQasNpFEtmADtsTGBFLbVWNRJqfy2k/zI82920h6xvY1gsdXKdAjftdngKqb+rfYy+NNGb9/XvwvBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862046; c=relaxed/simple;
	bh=fJYdYgBaYsQK8yhw85buy03ZixJKM3mfLtioGb4pXYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4mEztg5pBPzkiUm+drcZ9Io8dT6T3Q5Q/k+LaBRvQc7a5aHVaaNhok72gnDTp3jHvDGU+5f5EHFPxYzHHCz2ete+cTL4zqP8QLN1ZZDPDbdSXbIDhiL6W2OPZYAFRyde+cDMmuWk+dHkXtHR81xg++qTDEzmWvVgsOWf1jGcq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=imFVcLrx; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="imFVcLrx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sE3OKI3l6sPm0t9fN9LKvrCYfumwIlheb8BTi9v4QUcrAWufXpovf5Qzr+6zSU+5atoNmrDoJSx929recxSxF05Ldmr1EnB5VmJYTggqV7wH/AChbRw4ggUqfIdmBkPjLdrcA44io2nlMbf4+eVVszg5cqmMHlMwMUKR/x7MARGh1XxFeGvhDf5b8ua/duXG2MZy/1FzoR/ouDOqQhdGOun0fkh1GsTH0v+iFX3X2si7ZeMkvDTLOb/xf6BNERTeOAVe9rKx3QZAoxRePam0SYlM1mGYpwtFkLOIgoPrqHBD7pEsyJT4K77M4dolfcgZCBlj0n/P6n9WIJq+TtYdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQLd3td8X1x3y45So9ULr07sJVt++WYxQOCBEy+ttnE=;
 b=pQm3oqt0I+l9MmJvF5wD0GjfzB2w8MgjP5CqtaDtU+746lZm169qFYA+ZN+xfIaa8vKfL23JY6yiXd2goXhuzztCQvwHNuReNCBI3NwNrDE+LvzBNW1dqTEamZe2AtfW7hWrWlUprCIUsT8JMW5o9gw6KCWRj/YZtOPEND/UAoZGbWHd5jwlKKiVUDJWv3iWWVS2ZgVYW9kyxgGOpESaP2K+fmK6pJmBOl8bRHY+pEkwgARK0bURzcegQcs2wZZ2qcGquAbanhXFn7XtcvowzL1IoZvWMPYtPqcoSConMu1SxtJ91CM74TENFpMRzmoq91Z8gRVSY8ydjYeO89tTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQLd3td8X1x3y45So9ULr07sJVt++WYxQOCBEy+ttnE=;
 b=imFVcLrxuTJcl94weB4Nq1En1KSPVplIHUI/cf4oKGNenx1T/5QHGX6aTZj8nNEqZBpUknmG3Zd8NhFBapO8arCeon1g06MFcZaLM/3eFpoufgRH0DBQxSthvxJcUA61vrwGjq0tQjUGNM725XGVUXGf7q3UVVwwar3ppGoX90d6bfAZJ4zL0ZWb0u5rAlDRdevGlos69LAZFqtyqpw6k0pNm6aRibBsZvJRDQCeQOWDGFz6ZKeevw+pJAMVsF9/P4MLXujf1zpO9PJicPjZIZfekcPvf6J02r/aWIehlY9+46PgKOGk5kDdLJP2T0ijdUSQFMJa0UUf09vtcBJzGQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 09/10] imap-send: display the destination mailbox when sending a message
Date: Mon,  2 Jun 2025 16:29:40 +0530
Message-ID:
 <PN3PR01MB95979FD5B527675DFC036B74B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g36d50d01f0.dirty
In-Reply-To: <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250602105940.75439-11-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8644d8-1482-4570-3957-08dda1c4b137
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrN1Uple1Eat7kdR7nOrSpOlCrDzVJ3mCIVwkQ9ahmGgYIti/ixha9oB8Xm8k9ssCBixUzQ1dax7SPbuNEISqcaWY75tPT8ME7R/38XNIG1x24OJFksuNP1Q0Tzw0R+SqyKTz4e9nx3679gnDmZ3YIu4NTs3OVBnema7/7WDflyLJ/Ww0GzCI+bs1dv8x3JSQBx9whMJsULRBU/UO1aRUyC2RDa2dqw30r1yHqv96wO3VhvudSgyBm+w2Jzc0kOA/v7mtW7nWNoGJSLGPHAkkFAO7ZXUbi+esVrIsigibQaaukdPd2NZq/e2VkWIAhpghccWy1QV36yOm5v4kprkHn8vJ9gAlgqzZ98O3ooYcB/rnTgIaYz3ksewoPIvnBkKCQ/JmBpbGu0TzC4Q1ORUKL+kEm5hLQrwTZ5VC4+PfTZFPj7sXbkMFjXh6to3mw+y20mkFB/YZZoWnKaVmDvkb9IzLvrTSkIZZ2Can5GCBCbd11+N1OnT8ac5Y0Fw+2DZDPOeM/5C/3xRzUDgkcZpcgLBIUXL4uf7y/WdDA8sMr6GZBXKowrUozkGYqLNB04BYBPn3gadv8LOr1pl0LkhUXRyA4w6V5cxyn64PSPitV18Jdw7+1Eo5Fn+JW4OXmO8FBPxdHgrPyauFYUZEOpLK/HxmJhguUfEDpJYkYqEdX8S9QU4YQphWk2tFP81EZZJuZq7sADGqtX0usIIi9FOxWHKRvo2FAYdL2BNJ9TYntj/rcCVpabvNhxi1sOYlh+x7w8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|15080799009|19110799006|5072599009|461199028|3412199025|440099028|56899033;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4OGMkTcuM8SeZ2WZYAygUuf5W+HKCcnOUtvuKTd5sLmFCPZ0L2gcmqsg51JE?=
 =?us-ascii?Q?y+7yur3ZZHQdajRczT5IFhc8OueRe3h6/NnMlCIOGUZp0OaQmfROa+S5BWx+?=
 =?us-ascii?Q?D2ByFeW4PH6wV4DuKC6gGiIP7OPat29vWQVRcZobi24PVsEZ81trjpWt0oLK?=
 =?us-ascii?Q?9YuL/1hlrnkYEEjrSSfsTXltUlm5GzdRCCsl7wL/0CVPIq7JO5S0Yy4/P7i7?=
 =?us-ascii?Q?s9KhdgDWWs6DOkg2Qu7lfFLZsdTKKXpY7mJgzPjBai5lmRgmC2uaebbLdCCs?=
 =?us-ascii?Q?99e3R0ZFLWE1k1aCXUrDALjjwgpzJUK358v5j19cHLmC5KHUKT1i4/cgSiOn?=
 =?us-ascii?Q?+TUkAeE0cc1nlEVIViZDRNs7Oxwtzhjb2A1GzOpK+tp3AHok7vx6Q3G8t+kN?=
 =?us-ascii?Q?/FOxjSv1qQyPx7D0Jsh/y1aRJ4ijasVIWuwA/Gv/DP5K2VZ4wOQarwXmB5xj?=
 =?us-ascii?Q?o1UPr7dgpobreoG2olV+tOl1V3vn38NqIymM8bwdvO49VVHoCH2sSw3U9Dp8?=
 =?us-ascii?Q?VH0TeB/OTb79T2PtdK79WS9m/tEkEpd5d56lgtfzvFfONbn1lTuhw9DXa+Px?=
 =?us-ascii?Q?oH8gO1G6CgTN2JX9kBixG3NB96ar02DIDkpMN/cGO4voIkeOIrsx7HafrV7o?=
 =?us-ascii?Q?wE3IYMOok0LyJqRjZyrroTAITYhBr3EYFzdwoI/p4ZTao/rHuqmTwkKHVNzS?=
 =?us-ascii?Q?Xgs6mwjIgQepfrhowzZahxuhI1/uCQ3JGGqMrAS9KhRPWV0oV4EUiZgNLJTX?=
 =?us-ascii?Q?OtwRpknPew3MbtjU5Qir3rmZtkl2YX2Q+ok6AUR/VWnhebh6UYysvLb+R38r?=
 =?us-ascii?Q?xs6UJRiCENnCUgCqdAZj0tkdWeRsbXJHVEo+5vrJCJLG/4B+QClV7Q1ScN69?=
 =?us-ascii?Q?rRx2sqCAj/iUUKd+r6+J6Ftsb+HhLIg1Rtub0HahReHgz5//wC0hkL+mYc7t?=
 =?us-ascii?Q?wthqMPxiGk/+ay8MnzwfCZSSns+QuDhdTkMe7wnlOm2yilRBcfHQWlSgPhCS?=
 =?us-ascii?Q?R3d2M96dFNMvQimDeAtsprbJcc2boMsWZ8t66yRY4+ZXJZcJ284Si94e7WhM?=
 =?us-ascii?Q?/vYycajt3TM8nOpQ4mFDsvrb3yrKOzvfmi5ddI53SI2rAeRa8bk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kW6RUayfKkPoGRjeEqZ8UtiVSbT/Wq7UJ4y5oyCVwECFx/PFEZY4rjCQbIGa?=
 =?us-ascii?Q?YSOIlQBkUJVxVoVmxVYmWLYRqAjLBxiPDbIGEY00hU9Vjg9XJHTwvbett/Go?=
 =?us-ascii?Q?EME/uFt0hWavlaBWTzX780O3A4sL8s3F6cc3u0Eyc66G9JB9/Hc6Z9AMn81L?=
 =?us-ascii?Q?PzIebr1fxKGqrihZ3GfZSV9VGY9z6lqoK+UFG+Tw2FkENJWVsBSPfUQrNPPY?=
 =?us-ascii?Q?+U17gP2fhAR3sTjPEx/vNKnybrYYKL8RQRUBf+gVPjeCKunEBTmBJ+RoFX4X?=
 =?us-ascii?Q?OkINQv18ZzPLwT+ptGrdIgR+0rAoUsqvzQjBXqQ0N5mK5UwRQblrxWEXO96l?=
 =?us-ascii?Q?gSrIGkMyfeGPdmbozbYGSPkKU1SCKGEQ8u4udurarTUaDd0bXjvJ+FQWJWb0?=
 =?us-ascii?Q?LreMiUQzabDxH+a3r7MBLpi/YhT2rzCjmVeMUHEL2XrGwzZ7Ipb1KP9Ll/Fb?=
 =?us-ascii?Q?WVZCq1qF1i1Z7Hn71V+PCmgepTcgm4s0mQpsN6vcqO8c2Hbmkbq0AfvYjWkv?=
 =?us-ascii?Q?Xi7qJj4NN9nVyWtgTGrLY/aqTe6RHkWycgwiUrxVVhsy4LPtCYIW1xD6ecE/?=
 =?us-ascii?Q?Z/Z1blVVdTA9uBZsL2z74QAHVB9X4Gan/0/SUjnt7eYTb10TG0SHtFKOp1Ni?=
 =?us-ascii?Q?/YrkWudo2fphI+A45aIBDDf1WIRbbO9Wd7wPR+fBPnaxNiwwgEU2WWdtWW3B?=
 =?us-ascii?Q?SIUZtSH+qANYYhLKDOdhNl9RBm23PlBHk7JdLedns3lcd3EKYRS6xVKjo8Iw?=
 =?us-ascii?Q?I3iCv7W6p3P50C9A7N5lr1aFtRJIx8lI7cLR9ntw3f+7Ye+cjgus+4D88lUR?=
 =?us-ascii?Q?8PCm6Exhu6ISwuHeLL8Z8cNtMVaQoaXdniZM611iDwsw6MZOxV1XXazGLZa7?=
 =?us-ascii?Q?OLels85+wWT8HMZLLUDMrq/4P+cpiVQim9c7rHThkGq9t4QnGmuW2l/MtLkO?=
 =?us-ascii?Q?n2zAhngjFBlOrtvq17bnJ7JreqZVABZfzcO1bNWAAGtwpDVAQjU/GTrCobY3?=
 =?us-ascii?Q?padKrBZv4HD3Lj2+VTJ5z9yMUEvAoCvIZmePkrlnkh4Ubt1aCUME9S6WjzuG?=
 =?us-ascii?Q?IUr8Z2lIRaWbIb2Yn8sHEujzGtvf2eQYwDaAeBaEtc6dESu0SACUb7kw7+8o?=
 =?us-ascii?Q?RZKISeMunK5TVp3K8vsmiNNzxLoyXHS8BUGd7pBwsEqsnRUSCXA1NioCHhHx?=
 =?us-ascii?Q?nEzG1kai0cV5wjWfFeYgwjr4zHmreLeVEYGMMApf8HrHHsHlLiV/CQJHHZ3S?=
 =?us-ascii?Q?dI0vgxADlb0ql6Ca7E8YMNaTQj7g3iXXF7FEJ2u8w4HicVs6Z0e0EQfwumf5?=
 =?us-ascii?Q?/ZVnDT1zKEOKNZmVZCjpB2QM?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8644d8-1482-4570-3957-08dda1c4b137
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:31.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

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
index 61d52878c9..39a42e6bc8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1603,7 +1603,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1712,7 +1713,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0.639.g36d50d01f0

