Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2C215F7D
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483772; cv=fail; b=NseM1xeHPnw4qm4fBJuL4dapIjh12WPMZUCo2FRZZf8MXJTCyVBHDiygf/OP0oXkqKaUw9GlpVw781R9KnxvFtWlT1tWcTfMZ71xBKaeKDbX9UjsWOgS18ImsHIMBk7xqlkbmKYisLUr86vACcIREQ3NTzytk5Qp5/T/t1vfqAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483772; c=relaxed/simple;
	bh=2CgeQHiRX9q6D/3r0l2oTwIwQP7MGafpJU9JrvoWt0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH52F6z4qcuRYBK6EclttWkNxwen9pDwoVwR9QCfiqGwxa0RJ3qD3JqhsYFLAv8yYe5w1GFhzjkmeRzarBY/JDYP1rOGelHdudFVlNvd69zBDhHzmYa40ulJ9tEojIIvemFQ44lWbGRA6vfNqp3HDb8FF6GEl11r+6CWEAopF4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=HGuCtPN0; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="HGuCtPN0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3ZRoQMEMtLFvY0axMelMEZvKLDzMYASM/I4MuSmXBxIiZAEohNwVOEhXIki/pgmHS+B8eee67wV75Frpc05trJEY62shdBqdgUt3ycbzKYVgbFUUVkYMIkgJxiwgBwDKuKeithJBkQSzHS0gBsQZk8AiHZ8MSe+N4bBvlwlx8w8n9M++npOOQe1WPPkA9MInrF0Ewxw5j/JxRZ/7PRs4dtNkJObgWOeQ0EOc16FYYadC2jCO5y94zco27qG63nCOFI/b3MZmJFQZXqOCXj0+ssGk+IcB5ns/kdLog/Kq+pqQvcyBOBYq+OQLuLSTNevQA2TOHT0nMUrw6rYzT3tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avZYpSfsP0gv8OMo+OUMx5A8EWPR64yLG417tI6yIuI=;
 b=gr5eWPxwG0HqHVPQt3W8hRdRxDKaeUu6ocjU5IobsYOxFMGJGk0naigvuhx0mz/CF9eCUqBN5eMKT/+wU3BuLxDC/W6g12obKcCvmuME2mvDTZViHt85MXDu/mnvnurfcWi927UPnF8dTkBqLTFw7iUWdFA6U/ArDR937t9lLsI550yzR9eWcoY1yMsaBfX5WRjw78iuWVsUWVYrdQeuQsIaj61eP+py9B/3occyRHi6GVsb/GSHjbaUUvZDilYLi1cvp6EyMIzsvGP8ElMqtmGY0HLz2oqy2q9/A8R+JsZhD535d0r1GQOHHUd1+ZwUJ5VxbL7J8drRD7nuF/E77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avZYpSfsP0gv8OMo+OUMx5A8EWPR64yLG417tI6yIuI=;
 b=HGuCtPN0CRtN2SfdXJ/PTjdpT5VSjzrFPtCU0+zKcZIweZ4rUfsRHe/pcuD/ixQCAa6ZLnIXU74PK7+TvafKAKdVKOzueU6omjW07ChJXeD+qbW30GrGfT3gTgUJT0ZNUp5MUeq9IU4a2aOExXhHerzyr9uoZ7vNc0q+fBUov0Ejf/XKrOeHHWJZPj6KMQ+mog8zUymSj7qSZadgrnLy7yANNfv+doQMf8R/UEXxMhFHDsCepERieKGGG3qsLzSAKycrHpAQaP3GwxDESYn0mUmq6iQo4jy0yETSlshv4qs5x7NYHgDRIrqbqeVnwCsnv/dSOA1bX3BsVHLaILfvxw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:41 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:41 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 08/10] imap-send: display port alongwith host when git credential is invoked
Date: Mon,  9 Jun 2025 15:41:27 +0000
Message-ID:
 <PN3PR01MB9597EA21705B87F9F5B83A9AB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bb4986-64f0-4a10-f643-08dda76c4091
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qq8hmKUB5esHcmPC9pLDrGBOqSf4qHAaD+D6DANpfcFAFYW30HALPoyFD8NC?=
 =?us-ascii?Q?j/HgI46N39aWUOHb9IvCYIlUAJcjJd175iC+2p2FowqPf3wyvZ2/3IkokA4B?=
 =?us-ascii?Q?eOs77AOtVRRNTJ9Nn+Jc8B4u+GmihxRL5vz6myqnu2GnvXpPT34hQzdapI9a?=
 =?us-ascii?Q?qd3i/UZpveGbX54uQqcwTTKqGuTMV6tnWHbLqwOmhfq/5OqZdjnzSPlv6nqK?=
 =?us-ascii?Q?AextdI7WLfsLDWOirNiyHq09yVSjL8NPgL+pMsVfkv5b9JcO2UBm8fsjJo/G?=
 =?us-ascii?Q?Jd0h2oWitnGny3ljmKxfMZNccqevj+r1D/COL7S4MTuDhKKCsyPc3Ok0tLgM?=
 =?us-ascii?Q?+8wdF617SSKkUiABK8lZfoOTbpdZ29O/QOXFyukYp7NuUYQVT8j6y5ln38yA?=
 =?us-ascii?Q?JoY1eXwAPNJM0LCIq5bjW179akNXqa9wiRKwOPoRvsy4fts0dx8y9WKnO7MM?=
 =?us-ascii?Q?ZbpL1Fxpmjg+fSP5SklfwHFENcyGS/OkPyrqxaS+NbAb+1l/vj8ayWwlXTq6?=
 =?us-ascii?Q?fNBnsGEbQ8Jcjd1HJSTmbJRhPLFundZOsMyaRqwMDeMI/EBCSqExTMywcWXw?=
 =?us-ascii?Q?Hugh3Ru2g8wnMIEh3gZVhpFBrnGBJ26aA7AG7YoIQQw3QfTMx7bPLsEBMa0N?=
 =?us-ascii?Q?Ow19lLF1JMY+gGADmkIDPSOh/d0OOebmnFYJAIFWOo3IN+/emr8ovT/rIRAN?=
 =?us-ascii?Q?i3SUQ7LegipTXnOhwIB+v1sfZivqQzEcOTusmsN8XmrdxQ92o8CHDni/mY5S?=
 =?us-ascii?Q?fEbxtz/F6CPiKTMYGvgjpGQ0UL86LofRPQmm5ck6BDJdaVnm3EuDgrz28Paq?=
 =?us-ascii?Q?8ExpTypL0hbwTKcev+e6LT4v7Y2LzDXyW1TrMfJHlUDCXlbItfZRrdmFEFDO?=
 =?us-ascii?Q?v9yjzDQOtgIUarHm2C5HRXbyPez4sdXrRU3bCVS2SbEy6UUtXi9HAcvuCswp?=
 =?us-ascii?Q?JxEq2+n9/S7wjF3l4gi3BidS40bzPlXeTscOiK27PgFwaptJ39zUY3mNph5k?=
 =?us-ascii?Q?2eX7nQREjDnnkhJJZvEvOQXAlSEMqcVpDa/BI/XJ/sVBrHxmGJzFSXWEjDgl?=
 =?us-ascii?Q?+l/bJUeE7tfuJSGETcoB3ZhAxfNce8cUlaymzdEjqLtVr7JB8X1PEHsfwYnl?=
 =?us-ascii?Q?C6cRmVBNObXX9+VEfcS0+JyH/qbtIBtIiCo7wk1dx2MiHBjwKt38kRE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GDuqvxJnA3dXRQamTls/wh6DzgvJjHni6MZ5Sp57VcDlfA3zenz6rO/+9FOk?=
 =?us-ascii?Q?sT4rovTS4RBpnEwa489gdYSenzTCzZnIO1M1BgcL+FjiQpQINbeIIG90Ifwo?=
 =?us-ascii?Q?5rakstSbZI2HC7tmNekbr8zc3vYkefzKxUfU+378KuRUlGo4lZuJ4VfIItcJ?=
 =?us-ascii?Q?rDXcRzeF1yINgUfDhfQvBPYfZKd9qhgSjDvN/XcNTuQY4mRjGxliibXjbzDG?=
 =?us-ascii?Q?8hW2mzCP011k5tetmzoJJpl/mXsu6oj5f8iy11NfJVaYhICywq3L17PaA1Jj?=
 =?us-ascii?Q?w9YJXB8RXUAFuuui1g0LaLBHLE8tzqlYSSwsK79tWfNAIb7XTxOIyfGdkIxi?=
 =?us-ascii?Q?6wE3lEf7VbKR2s+viOkJ8pnAb5y9zPYGHc8mlUZCi9+a2k8v3/ShaFhMm2le?=
 =?us-ascii?Q?gmABeCo3dLknu97GVkvXFhgGi67Dm3kth3getbJiAMowoseFZsB/lpRVChyq?=
 =?us-ascii?Q?nXwwhgwpyy61jTR3fkf1DBHN5GZKsDZUCyPJkZTeK3ZApGJRy7Tk5OrA9SS/?=
 =?us-ascii?Q?QPtNmGqv+6Dc21jN47XuKsQMRpohRfSExLra5LVLHriloKlc6oLg6SuXpqXD?=
 =?us-ascii?Q?ztALEMrcSUs0xpLh/6uMPPD54a37qrZozgNQj92l+KLC2PTaKitGC4H+12rD?=
 =?us-ascii?Q?eMAb2jAf4LCbZHlj5bskJXneUbODY0g55+IgUt9ymY5tQMxTrBTIFA5NcAjz?=
 =?us-ascii?Q?rEurrJXhFx+4fN9puE9s/+sLbiEyDEy9V+wVyEAePP8TFme4kKEOslV1lO+8?=
 =?us-ascii?Q?6pucEPeAmn+kuqxRn6Z7ELVxqzGHmdEZZCq3VjyE0A85tNipbZuvTumXkuWH?=
 =?us-ascii?Q?IakVEBrSPRSw/9fhrGwWH6wsarn/emN1vm68o/UtG7DALdqj59e5AzIyYxxF?=
 =?us-ascii?Q?/q9sgXLirwwd1RV6lGU83E2w+zoBUdHg4msFCdUor9ObwlZokPAG3Sc9yvvY?=
 =?us-ascii?Q?8/Gw83KDx1dqo1RGLw7bxLVIVVTV4dx6GXA8F8PY5J0jnM1ueBtVbx6g6P3c?=
 =?us-ascii?Q?5mJSmyg96fSmWXDD2EnEcCGLkjsmvyvomnOWktlR98JoLh/dwEI7khrRq/e2?=
 =?us-ascii?Q?qGxFcH7zw9BNRrcPutZg0u99eMIaVT4Mitt7DlPcUrSBfebPIYMKmzpRyARO?=
 =?us-ascii?Q?O1j568Infjm5QjzcQHtwnC8L4kaw+xLzJBYtzoAWL5gImDzsZ7VViKqt4cOQ?=
 =?us-ascii?Q?wVCZTuLw5LwooEtRY8raXaCGU62KodDK9aLTYfRp05VKpny1QOBEYCPnSE4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bb4986-64f0-4a10-f643-08dda76c4091
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:34.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

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
index 4ac0ba606c..da85a6ee9e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1089,7 +1089,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0.824.geaff4db692

