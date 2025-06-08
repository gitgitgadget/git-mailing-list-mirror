Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1B217660
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380245; cv=fail; b=WzY13ly/q0FiP88akNu6BHpRuH+HPe0tHMlL+iMlqAXk+pVVjXo+3pYMfnItJeKHDZ0WVXQCXKIwzK4Vfk6pfkSCXWpq3rcMmcvFo/dB913uhNBvbmI6Tfl4L89oCIZ7D0/RXej4f48lL8Ha1IGkNRDJtQEycKQDd8I9ff8nHBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380245; c=relaxed/simple;
	bh=iVexQj3ZkMF18cOKy8JRTgIUKuxukEVHUmFMayp84L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itwQLq3urLLYGDon/93KLFrIMYDq8tRZA6pSK1E6TSppSyGqsDzODxN3zrzotTW5iDB+GJ2lvBZO0jEOKiZwD+baXU5MUfxHkzelusLI1CE+SrJjQGPHmE6IaLPsrEpyPx6lixemt64Brphp1IGIywWGypDW1s5O1X1TTP8gCSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fpXEfZJ7; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fpXEfZJ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv5TTlL4QKZsM9EHTBOfJls4Gyx1GZzDcvpxYmyEsd5IiEBCCFdxHJyzCiN5rDU+t2MniPMIbzqCcTzcEQhkQewJOPv7PwlPyu7b2THfbonp309Y5BCF7kYEa3ZWvTBti/c2rURcU35VSkzDVQzqbLJ4TDvIFKnmZiG74d4z3b3O8NleUL2GUmsF0uY1aBhTrC/M0F6InDRnUxrXIBO+WhsQdkX/ZhyhTvOw7+iH6qqGNC9FFdf6c+rIb12vqsKhwfSULjkiBZJsLKYZl1cc83vz6Ym3cmBPCjC4oc2m2ZHznZEIZXcUPpwdIHFj18i3EMkvUF/lOFCKcj9EWTW4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER++bDmWJOSOP9Z9grLaV7/lOOHQYGc2CGArGUVCr34=;
 b=doYFZbr5gqoG2YhlAvlohVLh0hPy70+LdEoioCT8ckBeKv4tznKkZf9og1wtL34i31sFEK9weV3jiLa8CJk2gUrfXwLowAuz/Uzgm27NZa63AnrIjcAwpuLuR4P6DIaXJOGF/Fzq8T0HaZFwPJJNyrQsLeukyl6IKqqCc6nxLT8tY2bYZeWyqpmCy9vvNESFswv3a59UbF88otN1HbRrZC8Db3Q4ekwE95MJbBmNx3NFQZam6bLxfNNUyxxVDLM5Q1T4YpwS5GbNx382lKY0u23rJr2yN6pGBictmAQYdJ7zIcVMhitGDLR2UM8JX9xIQM0TBhdm1rCbju2qrl1c1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER++bDmWJOSOP9Z9grLaV7/lOOHQYGc2CGArGUVCr34=;
 b=fpXEfZJ7IrL7DnWDDOAw7LG2P1bqYA4Nb/a8n2LT/5ioEvxnvsz+O/y0rD2q0VKMKrX1i+spxn91LER1sRkReMZCJDYR6dAIT8pGF0s/mVGl/EAFGp2bh1D1BNKRBRPZ6KFex9jCgnbdx/lXo77MWnOY/JEs7mtCQPf8gqW1itlM50MWg+ZJAezE6JJOacta7J3PqN5yykSOrNi87+G8v4mDV9Rmd1zlawJ/zg7ak6kyHcAG+yW5qip4w8T45DbNmhj5cb6PZDPuHav7kihTd0/pQMbgyS3839i74CAV3u9x8sSubwG2AmQzsrFKB+416Q1HzCxSUtqcilt6lPLc1Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF9841FCE60.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Sun, 8 Jun
 2025 10:57:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 09/10] imap-send: display the destination mailbox when sending a message
Date: Sun,  8 Jun 2025 10:55:18 +0000
Message-ID:
 <PN3PR01MB95979829E7BBDC5D49E3A023B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250608105520.18264-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF9841FCE60:EE_
X-MS-Office365-Filtering-Correlation-Id: c08eb318-d845-443e-8366-08dda67b37cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|7092599006|461199028|19110799006|15080799009|3412199025|440099028|56899033;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtBnrED8GLYxLHzcxEgZKrXGgvbM3x12zOEXKyNVv3tEFRS1lx2P2LJq3VCi?=
 =?us-ascii?Q?ZWYGi3qFupX/sa4RU5qSwXO9dyfXEw60TwfmI7YwifCC48Dxx1ozZWUnAdIv?=
 =?us-ascii?Q?FE2uEKXgQgpK2zr/85PKBjlS+RpYryVDHjvrOnsdOBPQeMYNJKkhdn0m9R/C?=
 =?us-ascii?Q?AtgoO+upnlf5a8DIg9NIBSv9a3vmvyJmKh+YwKJB7yprcaBKeZ1hyRAV1n0f?=
 =?us-ascii?Q?P8P2Iqlo80/ziFbkK1DUrYWT5092HPvp3yVRv+IN7pe5Z8u84EA9bn1zxYTv?=
 =?us-ascii?Q?QSsJgONbZVtGstvpli9G4nyLg0O57LQVozHKkhU4/8CequCAcjEGIxOJo/zy?=
 =?us-ascii?Q?QUrcOmoq6MB9bQgEhrZi+/93ihRpbuz89w38KM18nFFB593bGdnQ9k84ujCl?=
 =?us-ascii?Q?ByxbkkRC5rIu2rsnmYjQmBeMi0Qebn5WmvxSnxXIvCFee2ywBLbFzviextrM?=
 =?us-ascii?Q?rWYoKlEpm/TUWeJzbzkYS6lzSnaoweNGLqQjT6jZJIBA1TLuwn/PFqjni6hI?=
 =?us-ascii?Q?VSDb3xsWoqRIT6hQtIIVBhMSxPf9NIsY6qK4+2Z1Jdt6sBBrPcuZAEW+2GGg?=
 =?us-ascii?Q?ecjcFpH2OhMrGozRTsRb9rSzmFWbS4Eobog7XW6PyK6GTau3/ywn9ZYsyDgF?=
 =?us-ascii?Q?GVI96gvG7Fr1/nPFcgXjSIOBqjyuIhAl6k0cQi9DFfLCEB8l7Qgzt+SDL3zY?=
 =?us-ascii?Q?bDhneHQjGsv3h7jmcJ0pRbvrPvx+7ic2K6BzRLAIaMHrTPD/ezn2JGM9Cy+k?=
 =?us-ascii?Q?KtxYCpdbVWq4/8eZujJe7cmXqVwgbfm6pn0Q2sauBwqSqmR0kmv2jL7wrcnm?=
 =?us-ascii?Q?shKC/xgEmxXmWzMekpYJEn6NPXSeSKAqWdhSPbzyRfLFyVkDfMMMro6kxHtU?=
 =?us-ascii?Q?EhNwuFt1e0pv9tBdpBLr2dJKnmHH2ylHtK/c8Ml8U6H4/TsozUAMW2uB3zoW?=
 =?us-ascii?Q?7T3stfRadEf59yieLj1ZQRZUhrFSXTP2tL7THR6LfE+fdCgfyXAaiNmennGg?=
 =?us-ascii?Q?CUVA5lY9O6Z/pmSuCSZ1LLi1Cflou/q/dKlcGtxR0V4YqfgVwkFz9vZP8sv0?=
 =?us-ascii?Q?AtZEeEvpfWQEmWJdBMoRnCwJjjcCuqapLYrbJuMfOAlXXnBanYc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLdUbcJLWGIwfbf++nAcCChXn+yBeyWII9G8E/esm6BPll328HrTjM0D+9Cx?=
 =?us-ascii?Q?Oi1kc4HVOElyXwFohdgOJ8QP4gybSHjDdiv+D1jKc9kXuDXZ6IaWuSs59fTi?=
 =?us-ascii?Q?Pi3zrLoleVv5caKcNvFMmdZ8NW7kSOUbuDR9yoPJBlSZvNEZjMD4O6e3nDPY?=
 =?us-ascii?Q?G1znJHMOnNFHSEeVNbZiUKmA4yS83VTTGGp6T9VnhyoUzfd3kEmXUEmT47Ll?=
 =?us-ascii?Q?O9OHJdxwGxj+irSPfKqCEy4m6bM7+G5Kwbc5YqKdQrIrvJNxt9myzS/soAHT?=
 =?us-ascii?Q?H1ma05cc2T8XGCTzOrIR5WEVk5648XnL2QchEn2sBIgscZN4wZAjUJWGSnoi?=
 =?us-ascii?Q?oEi+gxv5E7z3op2RFuaUtOMlWk/D1DsLaUZA8nuIpTaqBgxUEw1KzwS323jo?=
 =?us-ascii?Q?KzXuEzPKUf1MYV+QPQYvJcWgZtAxTyGgOGdDl8YAaLYv6dY+ADCJwHrStXoo?=
 =?us-ascii?Q?ClSdkQUCIonqkoY1jYGAjXKIt9XCg6LUk70ypVj2SZd+42/+lkJ+5h1MrnK/?=
 =?us-ascii?Q?o6CexQXk7KJji/TZCDq7N+V5o5H+oaLwPxE6SnFZGFMpRAD211EW15thE75k?=
 =?us-ascii?Q?uktHl9u99Y0YBzMCamNFOl8yS2vYBQKG/+rVYOOK6nDEYso4foP/JwE0HfPD?=
 =?us-ascii?Q?Cl9SNY76d70jKHiJUuWxe1UMAw+1aBMmGTfXhpjV3GX31pXRQU+2cWWnYcn7?=
 =?us-ascii?Q?hJJzhbGKIN3KFkiuEUjPRTXj9y7aWlnfQxWwxpT3hH5DaFaGnwTtRbVq1za0?=
 =?us-ascii?Q?huv/78ol0AaYuAG3Ub+N1BT2hVTQ6VfD8H5BlPjvmhz8S8Gyqs4cuXJfBYvV?=
 =?us-ascii?Q?MfbTGg3x3um5/aFQBzpkGznPuqlA7JHIohz8iJdSHwxJ4qf4wErQlWYbn89S?=
 =?us-ascii?Q?vjhfNrvWmT6WbtD55XjjKTIfG/GZKMxD7SC5eFwMjCJjewaAc9/xYkG7vMkG?=
 =?us-ascii?Q?l62bZAIzk3Q4XxnDZVzWuqGIR1Jdx3QioAEQIa/KUiKYpOrn8fRGIC/jH/lB?=
 =?us-ascii?Q?wGwsaPzZt642Q2jGI7zAVlrvoaVrmQvvUSgVZth4dZx/1QjnwDNNMGOToUhf?=
 =?us-ascii?Q?6eh77GywWRYwukn8ISvXQPVWCHi2hFRZFKswzyaUMGR+S3L6a8wNZemNRjMA?=
 =?us-ascii?Q?Rr+FEj9/Tt1ggaqGD+i9P0Pw7oz9jj7JRb2H4Afixk/bPcpGE3y0EY83YQnp?=
 =?us-ascii?Q?QMH8ATRIMpeBW8IbOO0Q+80UkJap+XGz4NYD4MAMMKgV/L3l8QeBQYRCsb0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c08eb318-d845-443e-8366-08dda67b37cd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:10.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF9841FCE60

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
index e3068ef1fe..9281112bea 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1557,7 +1557,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1671,7 +1672,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0

