Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57F368264
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142897; cv=fail; b=mV59WRs1jWJ9XJkhwqytrCh7etKvnesiK6cT2SQ89Vt1E6sZ3AYvQiP2kWmIoPtKWBnMCDBPO38kpHuKlMTUCKr8hbk+NnvlUmY5vV7IhoDAK9QU410Wf63tYoWbRQNGUOBZ49vnHFINqzE+60UCEI1jBW50pEGYh6FSBQMOxnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142897; c=relaxed/simple;
	bh=5j6dkM0uIprnH+77t6TRBD7PC8ROV76nrD3JC+m16OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ofMAUYZiqiYm0/ZxXbqNG+hKdYk1JLMqAu7ENPvL6t/iWywLXoVWykzcv1fpZHBqg8RcqVYLoAgXqw9ghBQuj5JN8m/yhv2IaJtJHcq7U73MlipCHC4lqryPthu0URLjLadEgBIqgi3plwnHNhGnpQNx4yLIANenZ9j7GtnkSME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ScO0/rgh; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ScO0/rgh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrZeEOgETf86KyIIKnIHou+flpWlyv3ZnGx506ba2YNaKVxoqozhWTAa/51WGatFrGoCl2uesqqwMvf9nWo2+Av2PXCK0c/XJdhWmqtVthnD6jaBurdySmWlk+SaPrBcGwZHZ82pM5fSL9rvGvc47pyrSOLxU+Cv4XFh57N7qkVpoTv0SKOgVBBHTqQ5+1eSItrvgHqrHVSwNbVvFB8cLUl4SRAK4e+EcOWhpIYJFIC7DPNyyj8kAXlls2Px8H+cca5mJalKwq+A/klIVIuOt04HAByVL1JjHa9bYQ60K8dDE1pDPMwtaOTvU5V0jsqullSyr1LYArxxH67BkMMXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m11xbe1BHY184UOQR15Gn0LfmY2kkAVKrbCqC/nzCs0=;
 b=pfh97XS+8blKPebCfFSxVeXvKC/bS4hFnJ0CoOaHe2cEnibrez7L3ONnOj98znXvFpQcShY4nhW/qwcAC4tUWXgbAAhPj83N8W7iwdM65D6F524NTr7DC89J6DQ2y0pgaoJW3N4A2RoMsQEDTDiDtzzYUj05ux5BmvCh8IJwNugtAoYbBdRBfN0kU2StNhmiJY3Vd8XDHP8GAQ0tAUMACn57+GA4gI+CDMRVy5tuhgrf4xLVeFpK1HUfC/UARNiqsCRpQNlXBXD1t69SY2lnbu7Wcsv3E39iKF9xOnvM2jGriUA9+p+kgVKEhBNxlaj14tnrBvUnU5neNkLoCFOvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m11xbe1BHY184UOQR15Gn0LfmY2kkAVKrbCqC/nzCs0=;
 b=ScO0/rghRRZrCFisRO7hL+u5ZPY35QqNj/7KP+iMgy3T8KzYwIWCTtr5MniPfT8vk1vs++eieezeXRZin7Oz0qNmPnwEeKAKmev2GTPFxLBgcUYTg4JLUovUCt8j4hpRp6M331MFfjYzObzI7nlK9KYva6gsHqwQh+jGu0wKFGLrKR3Xg2LeUvkQyhHHlewDjKRLRF5IJxTI4rzRUutpemv/OMtXmWGRhhZYsaLRC8lOvbw4CsodLzfs99HzjcykColDdjvfQ6KBXqEhL7TzXRptZuDNOXv/zYdI+z9k4bDU9SnJjHewjVJ24U5LQoFeuZMr8g+nHCBktiTC6MMSuw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:26 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:25 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 8/8] help: add tests for subcommand autocorrection
Date: Tue, 10 Mar 2026 20:41:07 +0900
Message-ID:
 <SY0P300MB080107A9E22F2C0959290BB0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-9-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB1392:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be4a055-70f9-48d2-6665-08de7e99f612
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HfAXJ8h0sYtIig8xGQSqokTJCLHCumbPGTgOxVAtrNDhyiN78E+ovjCkOtEW?=
 =?us-ascii?Q?E59pJhmJJ4TwNr3O/yEu2LjnMnUQgxTZOJOZt108Mskjajybu7NexWfoqG7N?=
 =?us-ascii?Q?CuSbEAJxaVJqic2zhx4DZhaWkct65KDY+rlk4a6wDZSPANhUn/mdilvKn+UQ?=
 =?us-ascii?Q?5Ox6VytMTj/znORlvd4pNZaD+65E3WN6GwYRb3/VAl2GtoKPXHV+GATQIixp?=
 =?us-ascii?Q?cr0y59/La79ETreMAcYcxcm5rVn0U5uhol9KY4NQQpu2FG4qYLJTC9wEgyoB?=
 =?us-ascii?Q?0snQ74eIHazF61i2VqF1SEUIcmn7e0V21tN0FLCae0SIjoBzbQ9JT5U99u7g?=
 =?us-ascii?Q?8QxCbzP9JnAcuiYl9bUYIWT1u6o4/+L8c1PzOG44A4CLWKEmqhva4XKDgd4G?=
 =?us-ascii?Q?s8oaW347EG8DuHyW5QdO6q8LOFbDrcUhXGwY2XeuGtEln7BVnn4k6eoNF6NQ?=
 =?us-ascii?Q?ysUk40T+NJ0WpDPH0vJ0SzYp9fFCUO33Qg3SnrKI4BaR5uFVRIAUdGFALnlg?=
 =?us-ascii?Q?b1WrkCgy0VmzD+hjRBRFFK8q15zowy4VGscmm6qjUk2YxtKSc3VTMAxmb/bk?=
 =?us-ascii?Q?It+4V5KBJCpRDnEZEcVAGEDgpGIqh8/CisYpa+Uik70eFLWVKlYl9dIg3Vjm?=
 =?us-ascii?Q?XCxRWV7XxqD9Nv8sJdl9IWC+P0SaeSKYOeBhObUPIrYN6ujwTR7DvYb2T8zz?=
 =?us-ascii?Q?Yy+si1gMcQkPDDrzx3OS+yDNQM1HcAs2+R2ckrymfyQeh/JEoM4mnvNQMqgp?=
 =?us-ascii?Q?V6/v2S64P/Hvlk+8kuI8+IEkpDMSg4sZAPYiH4oUWO3GFQFCNTD3qVlAX5tQ?=
 =?us-ascii?Q?KNELkp9+XPON3FA6VgKDdyj55b+UNyPv8NFzPESBMTOomYstKcFzcmhT2UGS?=
 =?us-ascii?Q?fUSL7IE6jOnCmPOPI/wbEgBOA/KPYLVDMyUdUnMipuS4/CtErquYJbsAIjbC?=
 =?us-ascii?Q?oIHYc8EQZg+D+tByUHCrmg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bcKovt5S74itSpxpra9CvQhR5sc5+F+wrE6j8Q0A/+BzK2VUQd1sCsg3PUaN?=
 =?us-ascii?Q?D1NFui73gCgZaTdeKrq62fWXoYkYzMtkYa2OGcbJai+Uj/jEutZbDI7Xhom9?=
 =?us-ascii?Q?L4eRW10Bo7vE3uMf9LYV313RzylajNuZmG0F9CPcZLNqv25hD6SDj1uDTRUK?=
 =?us-ascii?Q?ghYZBOeW/i06iIn9W6FP8PMV09gvsH9u7PLiGO1EwyQMBF4oy8kbtcbFkjrc?=
 =?us-ascii?Q?i80TyG7GOq7YoYlh6Pk7VaRSQVlotbD7OzsxcE3BlkOVxlnfXgfGOryEyf4O?=
 =?us-ascii?Q?KtPUrN332OCm58CkfBD0m460KriEAcjahFPquvy5kEhBOWhIu7huJeZnAGJd?=
 =?us-ascii?Q?UjAYSasaBBqBZPgu5xjxK11J9dso7A4tqv6xoLqr6YvG5Pl5AxiEUO/pm+mn?=
 =?us-ascii?Q?9wbCiNhMbK50Y5rp4lra72ShKZO2HzZaLCmi7JyRFnwANS4IsXtjaC4iU4Cs?=
 =?us-ascii?Q?v7JZ8S5iI2BJUepJWGfS60fU+We6se6x9N6uAiYQGeXqMh3lGl8uKPEoxL50?=
 =?us-ascii?Q?dfZKsCzTd7QI3IK9JFMwetaqWXwCWwT+MvotTBMJ9ngEIuFhyXKh23KGd7BW?=
 =?us-ascii?Q?U81GIOITuLDBi0o1qqxjDOA3fnTdM42rhYfz1d7ECXWPv/GB9zwF3AQ3hvlC?=
 =?us-ascii?Q?UWn8Z4sZXoLJrEf4iSNU2pRc+/eROCRsOJq7ov4fPffZPImiX5mDL+OWnzYX?=
 =?us-ascii?Q?FVSX94a1xw5Od/NsHC8Eqr4J2E5e7FXIHZU+Td2Zry7kqOhEZg7XzGZ4yF8k?=
 =?us-ascii?Q?nUTBHjFuPQO/ZFF+auwaF3Oan1iWf/9CWt2ZpFg2sbZJO/0+OnFN2Lx0e7A4?=
 =?us-ascii?Q?eBvoxayakeWhEUGvqyfzaHp2lE1fpEIcR8kYoCzpEteGkiai2XAiF2lA/USK?=
 =?us-ascii?Q?rNBf6wiAxzPVWXXtjyRFfwAu02zt1TLn1D/EZBnK5CifSeAl8PJgFxRaXATA?=
 =?us-ascii?Q?aoC2mIkt+fa1gf6RLhElNNtmkdifqrNXy30mfwFZkcg0XhnHL2PlPE7gkKaP?=
 =?us-ascii?Q?FAgLMztjaM7q/0Ustvjcbk+kd8HP7qJkDWsag2ZXXCMOhbzdzl8DFo7mcNma?=
 =?us-ascii?Q?kaqSjqJdzHADgGhzTS5mj688vW6i0UWE+ttXBbijexhQuBgF/QKLXNFSbEdO?=
 =?us-ascii?Q?yfFQu5Ds1PXn1B+9pJ5Yf0QoLfbFB5w//eB+loslVz7GKC6wE+ZvUhjeCYM8?=
 =?us-ascii?Q?cVD/53C5IV5JZq8iyRcjTtIRKssFI/xO6Blz+ExUWGhsozUoe1NenmXuXJlm?=
 =?us-ascii?Q?fV3SmCbqEavj+i61ZsaMMtDZ/vfVXb64nlaQytgqBL/bLed5YknVIi3ySI/p?=
 =?us-ascii?Q?HF9wi1nLt/JiUTScYOR2Z/6WXnCV+n6jlUaLklohTUMBN2BREIzihfkOEEyw?=
 =?us-ascii?Q?TImIAgrbS+mDVFufLTPB8VQiBdxB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be4a055-70f9-48d2-6665-08de7e99f612
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:25.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

These tests cover default behavior (help.autocorrect is unset), no
correction, immediate correction, delayed correction, and rejection
when the typo is too dissimilar.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
Changes in v3:
  - Fix coding style issue

 t/t9004-autocorrect-subcommand.sh | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 t/t9004-autocorrect-subcommand.sh

diff --git a/t/t9004-autocorrect-subcommand.sh b/t/t9004-autocorrect-subcommand.sh
new file mode 100755
index 000000000000..d10031659b94
--- /dev/null
+++ b/t/t9004-autocorrect-subcommand.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='subcommand auto-correction test
+
+Test autocorrection for subcommands with different
+help.autocorrect mode.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' "
+	echo '^error: unknown subcommand: ' >grep_unknown
+"
+
+test_expect_success 'default is not to autocorrect' '
+	test_must_fail git worktree lsit 2>actual &&
+	head -n1 actual >first && test_grep -f grep_unknown first
+'
+
+for mode in false no off 0 show never
+do
+	test_expect_success "'$mode' disables autocorrection" "
+		test_config help.autocorrect $mode &&
+
+		test_must_fail git worktree lsit 2>actual &&
+		head -n1 actual >first && test_grep -f grep_unknown first
+	"
+done
+
+for mode in -39 immediate 1
+do
+	test_expect_success "autocorrect immediately with '$mode'" - <<-EOT
+		test_config help.autocorrect $mode &&
+
+		git worktree lsit 2>actual &&
+		test_grep "you meant 'list'\.$" actual
+	EOT
+done
+
+test_expect_success 'delay path is executed' - <<-\EOT
+	test_config help.autocorrect 2 &&
+
+	git worktree lsit 2>actual &&
+	test_grep '^Continuing in 0.2 seconds, ' actual
+EOT
+
+test_expect_success 'deny if too dissimilar' - <<-\EOT
+	test_must_fail git remote rensnr 2>actual &&
+	head -n1 actual >first && test_grep -f grep_unknown first
+EOT
+
+test_done
-- 
2.53.0

