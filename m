Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D801246772
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417937; cv=fail; b=Ct5R7eS1GjScJEdmjAgE2wEXireB00Eru3IggB9e7OK9PC7dohuK+Q73p7hbOkXxw+Kgfe9FYqbMwBVC2wnI6t5D+RK1MPD+JFqTkfxkSdWNN8HeDW4EJup3stCkkl796tsfBBzqr0sBM8Xtw40wqctYKAOCe2AHXXJxY/rgxEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417937; c=relaxed/simple;
	bh=ii77DN/6GfoOlct9FGUezop4pfH+q4ZvjP3TPmjj99Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r73yeI+q0R6Kewv6bcSSDwN7fQEKo7gSC48M4dzoobC81WJlnbbmyhUR+nGTFI2VIs8VF8nmIVgDb0HRBs0NG+0tir1SJhrzK0PM/3jg8pPCPssOFZvmvDVyhyVv5pXcoctQnU3l+0izQXgV2BZyXVlc+OEgyP98iNL8I+pfTyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=m/mqUwA5; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="m/mqUwA5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQbDNiu/Ft1u+mvHOis7DKymMjxyGPFBU0ViP+G0Cik/vRcMU05RDRqBFcBP5s0wX0xIe2Uae7qfHtLdnfNB7H1WLsOScoLOoMSYoHaIB10ZJqBNqSlHXzjblrtZOdyyWMUjAjfggFTXE5kW0HymHJ79Dc3X9NSyDrMvvtEyiO7D9u35dpsBVPPtvNt5DmOPYAQ/JuEdkAyaoGsV1GtLi1DrfMJdRkL88D7LJ8Nrlk3f7/Xxi2GYFvF+3jLpQ713TBKObsCzMZZ1WYN0lWPFVG3GELanqcwyiJfzFFaWRWiaIzSRalucHfAnnWlsI1/XGKYV+bQLLVvYh6YlCVvjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVB89eGsc0KRAjlLHJhCTy+d2VKQDAAdAbabYwqMmw8=;
 b=gHTiF212gbx7FDxHfPcAMKNi6BjIAxMbyfk31D/n8DfhD7fSnefnN6JiKcxa4QECaSLR4Lxk5dTX/Qb9LX7RwniPGSorVzJz8ZtLZQjfvRIiMccN0w667i6zqW2YNUx7FMrSioCtoB1Os6xL3+SCW76+h1yXZsXTW3iQ/YihbyGFPx7q3l3qoPmsjnax2cGu6RG6j5qkpkYWE+vvw7X91M73b85HEye0Rus6qyVL3WpL4Kl4GRT0kTgKxd5/KJ1heRyUswjfJ5CCUVD7GMwKqLBO/SafCJ/0S0f5eCuHEsL0I/1eYe5fnvUJM2kvY4URnfwitjrVkH46cazxtgcNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVB89eGsc0KRAjlLHJhCTy+d2VKQDAAdAbabYwqMmw8=;
 b=m/mqUwA5090tplrCPVio1J0TDTIYmDQpKCZmKuV+7MFbFhtmOorvjjVTrxYFwphuYiEZAClQq0qalX+mGQWxP97dNJ2mnK3IopjPG0lH7mo0l6KXAFgKBTU9CSNBRTcIthh7FNBwhbrd6koPeODkBKUadDx0rJ6RfnvsisqiNyt/qUSH6uGB/3ayTmeqomHKqyUp3vEiGpQ3Y33E64hYu/t723kDcIo3/SlRQxbkkh1Btlz3NpeC2Lx/t3avuosx5CN3zTHnMwdNnX7ONswHOU1iZa0O0ywbnrfrfPda6TDD+NvBqBhdlpGmh+WuWdwAy2yASJcpW/ZmPpBiYGTNFg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7904.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:38:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:38:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v6 3/6] imap-send: add PLAIN authentication method to OpenSSL
Date: Wed, 28 May 2025 13:08:11 +0530
Message-ID:
 <PN3PR01MB95978FD46BD02C9EB6CD27D2B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g4769924781
In-Reply-To: <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528073814.29138-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 526db0c0-468e-427f-dd29-08dd9dbaad3b
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBLERCSHXadvhc9ELuiLr8N5ggUrDJKCLnnq1kUjw5dKd503P0d66C9EGDK8pbFBcEH+UOFlqWUu6H+QEB/6tmK5XV1UlaUMiIHuQWIuikrEgTtY3HZ9w7ag8mgwB2PMO7SL2YocRSkOxDHV2PnfElIC4zmotZtlA2X4gD7rn2WUzqaBojlwqUfXwoXnRqXGOuado75/pz0JQDf4h8kYcI/Ta4L/ktQI5uI83iFoY02NHr/4p/PIGCgtfrQsda/OWvqG5G3Q22sWE5r4WAlQQu9es4sEaQgXYROdy+OGvr//UZGRxW7sQQD5AyEgdi27SAIwzRZAyq3zvU0T4m2ovWWrMhUJ3G9ySnFts9ud37LOu+aYa4rJzhN+15x2oFJ+FHM4C1JcVxbHHSmzRwAUhl/ibTW7XQd/C8FO9LAfaaxa8t0xb+FKD1I95+p9ekexe3Z/+/zcDCIrC3qReLDo5bMFGiNyRdNcyNMUvxJX0pN690OFOPumY6O7whWByJ0X/MCy9Gl9wffZKGQmh7y1k+fx93RHU1IdWGqIbNPW2SJnCvZsR1Y88Mr//btslkGh0giHR++o1rwP2tCqg7PZ6XcMDrrZSSadA2zpbLlVZlqeuNdhFOLC7bldtDfox97FK9KrIXZRomZrqCKjAK6ycXpJLreJ/zGAoNI9fORdmXa8NkK4holmjtVIoupO4D8dBM12JnCrw0e1UfgvudKmpLPB7U3ZEyiGbwBRG+FpXDBI4NnlUuODjHU7vVAEcA4ZzV+VM12A9/8BYjEWeawYjvjlftbVV9Zw9S8QW16wHQGihuoN2ZdYqbauPAVcFSVEa/9x+Pt5Oa2Xzg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|41001999006|5072599009|15080799009|461199028|3412199025|440099028|4302099013|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x6yVdCpfy3fWrt6VxD7D6AW6ZBUSL3fzP6Ewp0a5za79yxeV+Q7IctOQMy8t?=
 =?us-ascii?Q?GPI1Se3dR7sNtAHmomxbYhI/fu0vBHxw9HoMI+bNw/1+3VHKEpTV9XPAzvIM?=
 =?us-ascii?Q?/r62WYy0J9/tLBPXKOxKsnY6ASb00wAStfuNlQ8a8bfLUXTEXjTHXHPhOQpx?=
 =?us-ascii?Q?/j7+HFQOjuy+nE/i3P52at2u8MECXE4uQuKH+xqutaeHlOf/dnTJ/n7rQYWU?=
 =?us-ascii?Q?ht6ZNngRplS23AzgJcTsBmenOz2Bm5crADmDpiJAH37ehdIxdhVjUkE38Rey?=
 =?us-ascii?Q?8dJBZ4olp0uCqARwmoCaU7xrmVRwLteEM5DIJDYHhKfnjQ3v6mtfS9O602mg?=
 =?us-ascii?Q?LXSN9NBeZHmy5VBBiV2svCItw7gcZmX1PPUq2cY/fd6KfCAyvVptbn8YKrXv?=
 =?us-ascii?Q?wcR1UGTJnVEk4gQ8bK9Kjjqc9eoOyViphg8eT4zMtVB8QByPkjINaqDH1aEC?=
 =?us-ascii?Q?VuCBFextG3wsrW8QXXjwt6fcaUJE3kxaF/CV3E9tb7DFQ4CHLlHBkXVm6v71?=
 =?us-ascii?Q?82iC1gbtY3+5AUDkFCVA+adWfJI9LfyxDq9sEOssfto7S/UQWY1601cRyXu+?=
 =?us-ascii?Q?JeBYVm6Sv5qpHa4OLpzbHDWn715bD8C711U3Ry45GcHHsL9EX/5AxAfjTlvP?=
 =?us-ascii?Q?KWIAUaeOPIuzn2hQEcY0YEo9XsnaHr3W0oTJqahigS5nRFpj480RAHarjRzJ?=
 =?us-ascii?Q?/rS3Yf/0qD2IP0e45D0VpbK0HOKs5rMBFqrU7KkRaUr6HtK1FEpMn0eqNpEw?=
 =?us-ascii?Q?ouYdswj4YnXxxkF10BbGNtlicsi9wVXwHj0JXwakvxjCwG8bJw+3CitXCdry?=
 =?us-ascii?Q?aX8cCtLIl2Zi96gAELRVOtcs6s2gDtcJqHaxkKX1IOCWPtPk0uKlAJxJxHy5?=
 =?us-ascii?Q?5nJbGuXudA9gMd3uZslqFzOoig85tuPCOke/PP5EftT3bwpM6UJ1bSwWvsFj?=
 =?us-ascii?Q?C0mzj3il8gdhCMi5YYhoFcQ0BuZ3NZr2PRN3+b7jbwRlKBI7tDANmHX1kMlu?=
 =?us-ascii?Q?yuSSRZ5dgTnOxGdNQgGiLwp8ujzTm5FTQSSSXKXQmOyjSYungSEvEEmQxZYR?=
 =?us-ascii?Q?f7R0mlSycb9RTZPUhUEaJNH+V1jHzO6MNQTja6+Mgp+QfQhAf0D6vgoiymcA?=
 =?us-ascii?Q?3WidgXfj+wZdGltRyreIu0Odn8cGBK5g3kGoHuqN1sV0lP4jDD2YiiwC8hgI?=
 =?us-ascii?Q?ViEu+wRF/TaJ2wwmDf5QhkrIF01TOjelSvmZZmLAfeFCUlsZRJxh/Ko6VH15?=
 =?us-ascii?Q?aiwxPmK5wQTxDvb9EJunRfDUBzosL7ia+2uEUH9qQh6FJD5xmw9LpCU5CzUl?=
 =?us-ascii?Q?A5UQWBtJflueyPmH2KdsdTWeehG7bw6XJa6FNcrJojbmElEyGcH8U8obzESy?=
 =?us-ascii?Q?Oc6W2g1FOgzfautZ7rmx1rBdsXl4?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dr265s2URRK23+fFktn+jVcZQl72cTksvA+ZzYUdWuZEHHJaGMgUl6Txulrs?=
 =?us-ascii?Q?AQS9gqZEovftUPr+jhIeBpPGpJ3eREA76zrzFH01zbWUO40VCX9MAgYFMovu?=
 =?us-ascii?Q?1HiVxjeJhEQYVPS8FmIwIyKOahYG/AKE1NLLdV/RtQWwL9ja7I1LVj8FGTgy?=
 =?us-ascii?Q?RMefr6K7msjAUkdwwOoLwlLQjfvu9f2IbFTbZ57jeq0RIe6vcOXxtLNpWL8X?=
 =?us-ascii?Q?++Cadjlobv3MzQH33lIENu8dtD0osX80f1X85TMS6Fl1GMYE1E0MNH3Ma6LF?=
 =?us-ascii?Q?opYelDGSDE3P+W2GcDe6qVJfeRHOJJTiqn3gcT0ktruA6gqcJk6UdO5mj8YC?=
 =?us-ascii?Q?GoUqilDAfJlShTyIaSFBryhVwuX1QsJ1tH/I54lsdsuIbnEjDJElaH1PQvyd?=
 =?us-ascii?Q?p1sEeN11PEvHmQWzIb55Gjiyn0vr0/MCbyom42y9s+kNb6MAUXpfwaRuz7gt?=
 =?us-ascii?Q?6Ns4fMoaRkmZ3m0VRLxjvCrG8hrFZTkOu7YLhnSCsfeUVNWSV1zdO6kFtrLs?=
 =?us-ascii?Q?9Vd6tFRATgtJNdKSHJWL6PbKPpS4EIHRX1e1MZhty4IM8YxjZbT+c5VMuvPN?=
 =?us-ascii?Q?4mYpVgPPQKtYLodctvolkJLwJv6Gut6FPrPw9bTenxtmQHoRkZfGNmXeSkhA?=
 =?us-ascii?Q?Ue5BXF9tUgkskkNoPH6DKLo3meOAYbA/fdciOsUvoiegP1KdKtJKKyzOdJ9Y?=
 =?us-ascii?Q?S7T69oGmj67/9bqmPblotaorpHbePO5aXEcZ8NPNNKFTJl/veCW+C8rzVz/T?=
 =?us-ascii?Q?v1tm5t00/0Z4354HbhTXTU2dBsQfKIW46ZGSfHHGnVh2sOEDcnNteTwHcerD?=
 =?us-ascii?Q?AFmkgKfer1EZPys5wK2D5KOpOy3Un7Jr2RAd9JtHb8wbi7prUuFwL/hhYu34?=
 =?us-ascii?Q?9LjLCdpSe9uWurcMz/ETiBOP5Mw/0P7glw5omdY6IbEVwriiSjhMAneBlPLf?=
 =?us-ascii?Q?WL3jOF5CCTVwb42gwW2o35tjapxXzi2u1nPoKUGfMv651PU86xSnxvk6+Lld?=
 =?us-ascii?Q?33EJ9OwMU6solfgZ7A9v4epxgoVeBG7mYcyL6N6HL45MxHqdIOD2UmysfEZR?=
 =?us-ascii?Q?TUek6ogFz+XXC3v3INBdCZCvOD7K9rGszIJMihSqYI7qIyoO7Vpd8seTqW0N?=
 =?us-ascii?Q?sKjI5+BSuEXBzKetsgtQSvKY06PzcOpnfc7NAEYYZ3v84wZyfb0gt2zhPaCU?=
 =?us-ascii?Q?xR9crz9/14TWMeDmoADATh0zd/brnVZET+n1FjoGT8N/qx5Lv5wI9hcOBxPY?=
 =?us-ascii?Q?0BRAqAWx4pOTrDRimhsoi8fpc++5r/EUUYPXqV+2z9fHgjwOfj/tNr5M1+7z?=
 =?us-ascii?Q?acI=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 526db0c0-468e-427f-dd29-08dd9dbaad3b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:38:45.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7904

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +-
 imap-send.c                    | 80 +++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index fef6487293..24e88228d0 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
-	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are 'PLAIN', 'CRAM-MD5', 'OAUTHBEARER'
+	and 'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext LOGIN command.
diff --git a/imap-send.c b/imap-send.c
index 04b507fc14..ad54aceb28 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,6 +139,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_PLAIN,
 	AUTH_CRAM_MD5,
 	AUTH_OAUTHBEARER,
 	AUTH_XOAUTH2
@@ -150,6 +151,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=PLAIN",
 	"AUTH=CRAM-MD5",
 	"AUTH=OAUTHBEARER",
 	"AUTH=XOAUTH2",
@@ -851,6 +853,40 @@ static char hexchar(unsigned int b)
 }
 
 #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
+static char *plain_base64(const char *user, const char *pass)
+{
+	int user_len = strlen(user);
+	int pass_len = strlen(pass);
+	int raw_len = 1 + user_len + 1 + pass_len;
+	int b64_len;
+	char *raw, *b64;
+
+	/* Compose the PLAIN string
+	 *
+	 * The username and password are combined to one string and base64 encoded.
+	 * "\0user\0pass"
+	 *
+	 * The method has been described in RFC4616.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc4616
+	 */
+	raw = xmallocz(raw_len);
+	raw[0] = '\0';
+	memcpy(raw + 1, user, user_len);
+	raw[1 + user_len] = '\0';
+	memcpy(raw + 2 + user_len, pass, pass_len);
+
+	b64 = xmallocz(ENCODED_SIZE(raw_len));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, raw_len);
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
 	int i, resp_len, encoded_len, decoded_len;
@@ -951,6 +987,13 @@ static char *xoauth2_base64(const char *user, const char *access_token)
 
 #else
 
+static char *plain_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use PLAIN authenticate method "
+	    "with OpenSSL library, but it's support has not been compiled in.");
+}
+
 static char *cram(const char *challenge_64 UNUSED,
 		  const char *user UNUSED,
 		  const char *pass UNUSED)
@@ -975,6 +1018,26 @@ static char *xoauth2_base64(const char *user UNUSED,
 
 #endif
 
+static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = plain_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("PLAIN: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending PLAIN response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -1207,7 +1270,22 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
 
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (!CAP(AUTH_PLAIN)) {
+					fprintf(stderr, "You specified "
+						"PLAIN as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* PLAIN */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_plain;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (!CAP(AUTH_CRAM_MD5)) {
 					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
-- 
2.43.0

