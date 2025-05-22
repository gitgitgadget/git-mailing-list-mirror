Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F802BEC59
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943510; cv=fail; b=jElpCSiO8ovhOWb/mz1JZt9eAvZCppf8+OXDQI+61jN5W89tCeEr1g9jlGf7Fl/uJDpPTPhVNn8JEzBJ3tm1whTH4jp+7PotFZy4UlgXOvhJtTasU4Cq9f+yA4iEUFIM19+U9Ky6KPqmt97TZ9XloFm/BgcJcnublPg2GLzzkXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943510; c=relaxed/simple;
	bh=4hWbqgVypnfT9VVnnKBZJWfc8Do9s70Q1lliVI59Twg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T7Fi4pG4+CVdMvG4JhhS6Fmss7aiUBrCjqBevpZrmljxY0rST7bzp/X7GxZLXP4OR7FAJbSAt33RMr0xHAvQwlfi2KKvVSfW0jOeNQcanTg1fDJFr/vfw5tnKyJRbY4kwYAyNeirz+fkBMDHT+kblFpnRutZRRO8/YQag7dIAc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=XXXdfGre; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="XXXdfGre"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9P3tDPmTGtxZ7oZvFtuEReGGDfS3rbx9RXMD/agoHSjG6vo/X8p6TmACtQcM3dw9flgmcwlCossf38k0oLi/TNAIyntFbw1mEKvhi/reEL1fnxI56FzE3m0hHJyyYVfGPScgA8++6JrCDMha/dZ2RbhKy/spsK7sUCoyA4r6LURO4IsP70rtHuI1wI6/dJPU2sZ3ooH8ZXdP+9xrqfOyx746iQXtkzxV+fq8gjORczLDgB5dy3XZyHeh7RE450cRkOxwsdjFSkkvNS8d5v6HkxkjNiAqNwPNXnLtQhzrnaIg36/euMB9Wo5pwsRC8sJRKCZN9Rw7RqFD8eV8Z1AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9cxtohJvq4vx7JFRf/QYxOKDBvw5VQkxHeR9G+P7kQ=;
 b=qywYNBvEmTPOU7zwnCKuRaVbeo8RNmwkx5RcRf8qEDvctZTqaDb6T8lIqGcg6qKzMVJLWL0855Z3p6VnGnsQD2f/tBComOhrHOr9YrQ+Pk7afBiBEzrJWBLuszZBq6bAif89gBjlalyAVN/ARmH1CiISwlKkLUf6eQ2YSM0+tcjlL1vp3hOyQnUh+cJt63mSoFk1o6nsZs49dyMD+l6YykFXx6Gj0t4u/LBw8BnOgxEFSlQvqfDd64pW9kR6LxqgKn1YpPE3L7pkPAXIm1uqnaMbNESJyNj6Sp8PruXnZStV2UeSYDzNIvYruEUwEGj0ZW7Gc6htrkyC/8zvrSRMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9cxtohJvq4vx7JFRf/QYxOKDBvw5VQkxHeR9G+P7kQ=;
 b=XXXdfGreXm6yajS1GM5OirQCFvETy41WyFMdGHuuZfrIufiTIxb9+kDUP20mQixdjP73reQ8jD3bazJNBeXFr7XSvYbpqDHJ5kSTtz5Zzwsop1St7LkwkEX7zehxWp1O0mog295y1EBUjcGhDVSI6G0AdcEsw7G5ZhgWBy0F30d/w6GH2DJkjiUg2EvH1XZM97Uxbroy2meUn8bLk3SnvCXWVLz3tcbTuxdE+z5w7ySIU0jykQZQmBBUND2oLplaoHlRBCxXLx++geOKu/8n3TOPxFHKT8u3LIahUV/wPahMVfEizwFtGFfqOXUcSQc/Fi/QFE31AtUQqR+a0TESmw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6385.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 19:51:44 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:51:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] imap-send: make it usable again and add OAuth2.0 support
Date: Thu, 22 May 2025 19:49:51 +0000
Message-ID:
 <PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250522195133.9170-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8ee9d1-e15d-4aa1-eef3-08dd996a13d9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|15080799009|19110799006|8060799009|5072599009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ACYSNqw/bPYgYiQqOESnN4/0snk1aLwIXlSWq0UvfnApU9VbZODjAl8taVnP?=
 =?us-ascii?Q?xQnx3mnD3ZmbmcupC/gynt2PQeC2dEb/d8YB0Wd4hO6UHQAIY+ccFrbDKOKt?=
 =?us-ascii?Q?ZANUZbDmfEBsBMdT+ctna8xrnCsP60y+zPOSx+wKENDaOSxuemcJCfEBn5qA?=
 =?us-ascii?Q?8MTLWosnD7qCMbz4thUy826z6SGrHjbHhYkQCD/Sxb/1BAK27CP0vBFjMR6S?=
 =?us-ascii?Q?F9kxRJTeO9Yt3rXXQMz65iVZrrkR1ukt//Lr28co3AT2Kn9GlhuLOuKXp6LF?=
 =?us-ascii?Q?cBCiQkZdq8z8pKtVppAZQevWqZVvCAsf/0dRQ+INDvENtFfGj+KmyoxMtc1m?=
 =?us-ascii?Q?uS1763J10+Gg5o10hvlu3Y2rM2147fGEFWYrHnehOPqOGB28Rqw/OvazsHyp?=
 =?us-ascii?Q?w/gJ9j6V/Fq5Nu+/TKFIC34SUHPjTnfJFtIAuFN9fILSA0ILzz/hiSWo4wi6?=
 =?us-ascii?Q?w1/VCq3JcUEl5eIFAHN8K+lKbFfdsJ44VhSrD036ImboJzI80ukelEDNDkr0?=
 =?us-ascii?Q?1IW95Zl+iKhz7IF45EJlfDFsyfDLIssc4rdTpxDABRQKrAYNOK547eZSm+ia?=
 =?us-ascii?Q?vvsXUWLuai9V0f8ACxVxzP+zza65Uo5rpQJjtk0+nh8GrDZsrRAuJyUahCQR?=
 =?us-ascii?Q?Z7VdcOwaapKUL3Kb9x4BEKua09esyGQ8UJA6Lif20ODjK6yOQPgMF3IMvXLw?=
 =?us-ascii?Q?Yj/gyQzVZD1rDhxdCPVpFqM6NwBosh99SFgj6q8xO7+ox0/Y3NCaGay/pLHy?=
 =?us-ascii?Q?3e9qKgVlwIXw2A3KgquxT7GaGKxmBY7mD16THbCrI4Hk+SSIVLVF79TJWbnk?=
 =?us-ascii?Q?6iCgIsleBhzUqp3VpmH8v34KmZPqe8z5biOivcHo1nPr+WJOMVjb9YmeVuyf?=
 =?us-ascii?Q?0O2CaopX3f3vjDAkdr+/Nn2BuPGf0cR2iUgAWwN9lJ+79WdoNcZ0DwjqbflG?=
 =?us-ascii?Q?PEYm8s3TXUdmM0gkWYe40vyUtIp7Tqcxga2bJn5aaNhlYoSBCUEVVCH/RVkl?=
 =?us-ascii?Q?5Y3k4UcnhvEV5DeiEEYPr95Kos7gE9WM6niuENGjQ4mej2Qot+/ld7l4CX3S?=
 =?us-ascii?Q?FKGp/c7ZPgbr4hdtnvyZilv9dgu4mBehjA18tfp3Ayvc0AtFEqI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/tjQSggImGSqj8cx62t71eSbB9M+TdPgK+QnC/jq2glBGQZS3pfbnn4Ib5w3?=
 =?us-ascii?Q?JgUZz9iQyjsAdLO0G0JgxQvMnkHfXbvOL3kcFafAAKCJm1H7Bs2AvYoT8DlG?=
 =?us-ascii?Q?c0JvcJLV6zdf+3FMTdHfHErZnew7pFYn/beTyOn8wRYr0NrjXh65CkAdmvKQ?=
 =?us-ascii?Q?/NY9tn7oP+03iVJWu7npuG9i1a+Fei3hwUKaekdQbgCaQh+6px8p/ozoVWmQ?=
 =?us-ascii?Q?KDsrJwptgm8c7yIHSx3Q/b95hf4XKNlRG4bggfY0bLo7678bQ6UlbhC/MDE9?=
 =?us-ascii?Q?9Wrb6+7lh1N3WMNUVGS7PgP99RALaKXvZOUVvuqr3o37ZGIlfwO5tZ44qkN3?=
 =?us-ascii?Q?CPhEt0kBpaN6qhJsTLjixqBr2qedHdcFofRJAo65lJVyftKBrjmnXZGQeFme?=
 =?us-ascii?Q?T3pvrsukiKdp6WgFu41U+A+BM3U9Lo2uKmQdLs9iO6RKNnfWjvnCE1kX44aS?=
 =?us-ascii?Q?bQEWSiESjT99jkCEFZOZewkSJgLsE4j2lLp9APfgPzH47P/OOleSCXSX5f0L?=
 =?us-ascii?Q?v2pAXIUcgaMXPLECHFE6WUqhb2jW1YpOBWpRvO8tCzi1I1xIce2SmQ+u9bEg?=
 =?us-ascii?Q?9c8p+RidJOA01hGNIqviAYzE2s1xf0d6+WdBmDDYzvryN4jW9Htea7ABa+9M?=
 =?us-ascii?Q?naPs/6LYaw4pk9t4ZIoIS3eGmpNkNdvCj6lCiL3qKRoxV4t1MLhi/oSMR7oD?=
 =?us-ascii?Q?LJRVw86rhSh1NcRUMzzw7B9GpI7dCMm/CFf2RBUeD8mYy9ycZFXQZUINtheP?=
 =?us-ascii?Q?NPsW84AL3WfluRYc9lJbpwspZ/YUrqtO7mtGgi39gZTUa1DvcxTtAXHUIPbD?=
 =?us-ascii?Q?pxW14gZOb8lJRs0ZUAPSn+tebxKhqnOjiKB4K4lhpKPgvYaoMxbGujZigSF7?=
 =?us-ascii?Q?e2z+iIPyiyVB/kf2pCGL4oqlK9eIbNziXWPLWOMQ98r+v8O+8eVzXpXmyvvF?=
 =?us-ascii?Q?twwkB0xiSqvx6C60+9slkzv+Gyt7EuRaxyssuOaTozrn/zwD49VAWBazza57?=
 =?us-ascii?Q?1zd6SwoACcFspesjoiUGPJAZemnQkZMG8fQMHfGusAl2RQ8qmBjFjLbWc2z2?=
 =?us-ascii?Q?VVsmP9JTf/Xg2/mLMJbHITr8QseIGDZ2NVyK08wINXZO/q6fmSASXv7IG6On?=
 =?us-ascii?Q?830QXn2NGgQ1vZ7MoCN4G2UaelCUmDNXnr1Ev4HjbJkhX5RJyUl2kRd+cNaX?=
 =?us-ascii?Q?d6JeV+wGllzqMIWg1dGuvPmf5Sm7gXz55icdvy9TaN8nmTQa6m5GHDruouY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8ee9d1-e15d-4aa1-eef3-08dd996a13d9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:51:43.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6385

This patch series does 2 things. Firstly it basically makes the imap-send
command usable again since it was broken because of not being able to correctly
parse the config file. The second patch adds support for OAuth2.0 authentication
to git imap-send.

P.S.: I am surprised this thing even exists xD.

v2: Added support for OAuth2.0 with curl.
    Fixed the memory leak in case auth_cram_md5 fails.

Aditya Garg (3):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: fix memory leak in case auth_cram_md5 fails

 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  43 ++++++-
 imap-send.c                      | 188 +++++++++++++++++++++++++++++--
 3 files changed, 218 insertions(+), 18 deletions(-)

-- 
2.49.0

