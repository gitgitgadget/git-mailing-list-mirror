Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDE1C5D59
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411361; cv=fail; b=WZtIb+R2qLWWSiIncwNuHD9NRNarOb6HJUmShnurv+nJqgF6pSdvLmcftF0OMz7hL0vx+8M+5yHHw9HT6DYRgqZWMXP9FTXmNtakP+HNy+g1bm1LJUsP7xEz+gM7fb7uEEKlRjXW0E6xMbt12ckGiJn4J2PT2s3QziZYjyR4YIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411361; c=relaxed/simple;
	bh=oFkRf4f7+lMERq/PxdOVw4Ogt837Ec4VaEOAQ6/6nfA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F1tBWQqRyXcTVcPAtpSHaUjN2uSgqGjdKWX8Hdg4R8KgNBM7crnJf7q0GUi1bXsUEI0Yr4Q7E3LqFlnLgTx8JZs9/zcHYUt48MMfehx6YryyWCHM/7cfZAZvASI4KF9HSZyaw897/T/DF4REBY+pnfX5Wq8idle75BZFw4v3VDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hwmgbAkJ; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hwmgbAkJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmproTNS4BJ50c02FlFLq5ohO/1nyt65SJexVLu6E82elleVFPGEcr+WOBTzYfJq4UwbO++OwUZYfxCLgC84pAg+Cke8aJ9ZMmqDLLnzMks6/pEard5yHvA566wbQ6LyIFP4/CfY/pVAshmeV2P/fhlfYs3ueLscdttgzF/+XCXixvNQ1Gp+8dTbj/KXU+dnaVh70DtZOLF8P2t2XJzxSEcudN3JwcYVXBTzmmoWINAMH3XhDAqSQMUkYDCZffVck1GCSI4QAdhuLHdFHkZ+ZndW264ere1JoCD3R9+ehqEE4irgKiJ/wy7KmPmtdnNP5nKugpiNAypWI1b139uWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OVf1JK8T0cTVyjr7bEeCFx9C/elP23ZYqhyLaKFutA=;
 b=NmZe+cq0N4v1f77sQwwlce6Ef3oLuyfwFqwui77k/u6lJL3K2fHgQuW9U1qsua07NJCmf3LoztToaboxW6uyPlpVcjDhRwFZn9AYC+0VK/mGjjsKVnj5dhVIp6YZiMsHLZEZ2PjbsyfEk2RlwVWSK3MRh6un6FqVt98LWyJP4r375VjVrIAfTa8eNl9X4c2wS0rKUWNCya+1YWoUtoNb6edQyAv+NPvtHtWWb5WnwVLTak6rj8vj8Q5QffZUy6wfjACG3vTF7Zqw2V7ZQzOzZkmg9TnMLld2qRzf6M9ZCei0C0LHSZdogZrfuJTav+rRda+ViWIEjNSgS/U/EBcWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OVf1JK8T0cTVyjr7bEeCFx9C/elP23ZYqhyLaKFutA=;
 b=hwmgbAkJmo8nF/dQFok8defUBSYechPJURoLGNQMoPljPxxJK/cgL0KZvGB3bLBTFss2b/+/Yki/BEzJ0fvP483r50Msr/8NqgcjCMu2K7xF2MWLjrDk6qIw4YvrzAQmWri39DFMUYNHrAuXG3a5H5GDXol4wbQuupMedRqemrJLbjEX5esKGmL8U+kpAg2GeIbZWkwMjRIByj0VwYMQ6sCAycpILakQr+cxPUBvVMpVZen1Gb9vvwU3n+HZ5ml5VUxcv62/9VnXepM8NPn6Rrpe5WoxdJhSi0QQwC0ebqa2qtx5smRQgxh7JjTJKTvjZjiPcO+qPDYU93GENAv2PA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 12:29:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 12:29:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 0/3] send-email: add oauth2 support and fix outlook breaking threads
Date: Wed, 23 Apr 2025 12:19:44 +0000
Message-ID:
 <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250423122903.43547-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c38be2e-d0e5-4837-c77e-08dd82627350
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5062599005|8060799006|19110799003|5072599009|15080799006|7092599003|10035399004|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bnlvsvtpLCWqJ8aWDPPAU9b55GfmAH5SfYkwoKzlAhxzAzFJoV/nns2X6bYP?=
 =?us-ascii?Q?38Gzl5pTyhE0u7zYwIe591hmVYDJ/fPa3aplqA1gyi8elPAyglP9Nt//Y4jk?=
 =?us-ascii?Q?5WfcZTUl6WeLI8dqGDJuQd+0HmyZi9R2SuVSTt6qQi5ysiSnMjjAJgVHBz+D?=
 =?us-ascii?Q?g1OiP8KbBtXGG7ejqlTh6aUa8RxVEDVjbCi5R0WSu4Fy1eWhcOxxoCX0bDzg?=
 =?us-ascii?Q?UWyTfc3tgKgjznD6XUFLxIByAWMidQ0/ekigCivjipLBZVL/JNBA9jiOZdQf?=
 =?us-ascii?Q?1vrC1EV1Qikb0Xxik6QgUmhGgwwJVdBMKmDzOMgM243o4UUV1vxBgaoa5bAU?=
 =?us-ascii?Q?VrMU6rn2HKao4Zp4nC7sGvCgJw0aF0F3LpT2kBw4wDANNkb9Y7WXy/zKdJ4V?=
 =?us-ascii?Q?8v83c6wy7xh6Ld0ZaRmUn+8OcGYn6mRlFmIA/vtVXudr2CVS4RTuovOferHc?=
 =?us-ascii?Q?0Q1MXyokSbqAD3iGsSGV1unMFaGEwj3GSGL+AGYGBFtKLbqumQuaf6DGKVJB?=
 =?us-ascii?Q?fMY8qKmdXylybYgdvi5CLR08+yub+86/vqC9Ib+MQAXAtrvrVJuVP5vIyt7I?=
 =?us-ascii?Q?R8fO2MdR3b6w1B3vftMrWHcehwTGq1tJcKAYQlaSis+AH+mgsOUin6neWEE6?=
 =?us-ascii?Q?8CABehg2IgbUJIcxDu+/BXvg34eMbQ6Cc6kjnajnAWcRno3C06u/GgAawV5z?=
 =?us-ascii?Q?uXvzsauQAtyuIv2jOdtpiFzxYg4km4tvgZAQdKIqYJ1qvsM/Unr0n5cui7/T?=
 =?us-ascii?Q?dLkvzcd+2Ouugq1Re0LNJ4zjCbnbyW1cI6g19X+rcrUHj5azBDA0kYlSQyDC?=
 =?us-ascii?Q?ubJs7RNp/BWrwvy04mTx7C1RSmw4cmHOOWddwxIYjHhq2oHZ43/QOqCFylyx?=
 =?us-ascii?Q?pQGwL4cZsW66R+YsRmEYF2Jhyetg0naJViVD3tm58IdstB//eCzgP0wpIwdK?=
 =?us-ascii?Q?c1dOsHAdQkbvq9Se+MLWVZswBgux5lHjNr6e0l4Td6IGqc0rfkyBDOwA6Rd2?=
 =?us-ascii?Q?6M33RMbwk5JkZfiiIIqPiYlZSZdp+YdmZs+RZabmzcwpJ/27glbjr3OcIttC?=
 =?us-ascii?Q?7fw0mfA04McrXthNS0xP1NOw77IRtjgONEcNWuJx/IrpWIBw7yFV8JeBBVUO?=
 =?us-ascii?Q?4IFOS3UYrJu0KPYnpdjuZNiSZYIZYZW2T2zaEQERJlIRd5eGXJRhFofl8utX?=
 =?us-ascii?Q?XvbYz0r9tpF6f7CbkNQlTMxTtPtjawOSLedAZQY0+igUs6fihkK46Wa7FzCr?=
 =?us-ascii?Q?c0/C84gGGmra0WHW7v0i2LyUTMswMMFandwPE+X9gAUdlZptk+m/+DxBAddN?=
 =?us-ascii?Q?cNY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvxveNRe0slvR8zwn9Y45gV4JuqGFf2ozu8Ca1IWKnEfPYpi8o6zFlFjwR35?=
 =?us-ascii?Q?lIY92Snt3XJT0S8nRTBJs4p7JANL58bkwZtOFSMWyzyzl3+bVF746IEaa2WQ?=
 =?us-ascii?Q?RW3U3LIYOJkR3F3DR25khJ7KzdGMVjR6RyBjIOkaNs2UspUrx3J7b0CEfrrA?=
 =?us-ascii?Q?GanIk97BozU3sFlPLJDotSAKQU/fe9HOkaNMqTwtSnYhdFEvd1UQRMbpH0qR?=
 =?us-ascii?Q?zVzdTbw9KaBkfdlEONXQGhrkqzc+CfV8QhljiuH3y1zhGUjzWO3qROENwbdd?=
 =?us-ascii?Q?ewfKgcBpiLgih2FeX0cJupvfY4ZlWuCcN2VPT/yxyA67UlefAAZiVbYgDWLd?=
 =?us-ascii?Q?l5SrCJ5UFM1PfdSf4bn3f4ZDgkCslEQjUkoi14MSLgMkGHglcmpauIma8zN8?=
 =?us-ascii?Q?sLy6AnxOYduW0cvul/CMXFhnS9kjEuY9nSHzNYHCdcI2nZwHln/GgxiAjoBX?=
 =?us-ascii?Q?xPJkGV6CRwZS/K6Ojrvrnb4rfmzUXvAoBy8aquBR58fR9wVkKr9X7BAGUq/g?=
 =?us-ascii?Q?QecXbyk8uGB1FBgdO/dZAhOq+nfg5WDkE+c/fkdSV224Dd7utqg9A6Cc8dT5?=
 =?us-ascii?Q?E0nUJd0GOiaJ3npOXkPFmhqZY0kkexhieh561IjP/CBygnEAMS1C/5+NQ1Ps?=
 =?us-ascii?Q?Nsmm1YqgQSOg9P9IMZFdZ87QGaAQ7/9/HuZyB2cixkWqUm0zrJWDtnTYeVT+?=
 =?us-ascii?Q?wb0CJSKnL1Vd8oQQ6YvfxCLKIoEe7zVo0ymq9AzS66ycHBy5onY/g5dRV259?=
 =?us-ascii?Q?BRIBk3Esd3lAXxlDCcl92p39HjhmMLBDoPZR/lGyi0CFQZUUOHXFAIWBEd0s?=
 =?us-ascii?Q?q+TZZNz1H+CaYTAIVcyXLFtHZminrCFcCQfIL5/I4A+INVAY6XWx6DfrUjun?=
 =?us-ascii?Q?caeCbUsOhus2HGe42bMe0Ep4XDaw6k92BLxnbZHXDziISnXEcoXORjxFdMYH?=
 =?us-ascii?Q?q2Bxgo5YgBZ6Qr1X48qbMwEPMjX8UjJdLp8vaEHz9WdBkmj5VnPsJa/tVCgj?=
 =?us-ascii?Q?f0o6siCvNnVJC7zbctiH4gl2jhoibHH6Dw9NeINo6mjoBKE1Tzvan0rWKWFF?=
 =?us-ascii?Q?ZHOGbgDzzQkqGLMoTn6DkHyp2jy7Ux6i0io+Iwm/5ipWqx37bd9kRDyr/TQt?=
 =?us-ascii?Q?X6zSFKMJmJ/KAxrm7bzYdKD7JRP77seIAjxAJd+DevWvJtUN456h/0SXqZSN?=
 =?us-ascii?Q?PHFnCZLsHbMrZ3ZSiq/F+lTlAWdoz4/O/rumnJBiYkfS/OJaj7zQVJbU/Ck?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c38be2e-d0e5-4837-c77e-08dd82627350
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:29:11.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7143

Hi all!

This patch series includes three changes:

1. It adds support for Oauth2 authentication, which is now compulsory by Microsoft.
   This patch has been rebased to the latest version from the original version
   at https://lore.kernel.org/git/20250125190131.48717-1-julian@swagemakers.org/

2. The second patch makes the script reply to the message id set by the outlook,
   since outlook has its own proprietary way to handle message ids,
   and does not allow user to set their own. As a result, threads were breaking.

3. The final patch adds a new option to generate passwords like OAuth2 tokens.
   This is useful for users who want to use a script which generates tokens for
   OAuth2 authentication.

Detailed description of each patch has been done in the respective patches

BTW, I am sending this series using the patched send-email by these patches from
Outlook!

v2:
- Fix errors flagged by the CI

v3:
- Add third patch to generate passwords like OAuth2 tokens

v4:
- Make log message of the second patch more clear.
- Change "Outlook: Retrieved Message-ID:" to "Outlook reassigned Message-ID to:"
- Update documentation for smtp-passeval.

Aditya Garg (2):
  send-email: retrieve Message-ID from outlook SMTP server
  send-email: add option to generate passswords like OAuth2 tokens

Julian Swagemakers (1):
  send-email: implement SMTP bearer authentication

 Documentation/git-send-email.adoc | 13 +++-
 git-send-email.perl               | 99 ++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

-- 
2.49.0

