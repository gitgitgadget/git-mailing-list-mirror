Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012011.outbound.protection.outlook.com [52.103.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1F3B3C12
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908367; cv=fail; b=gs6BxlVhEoJUoAQOwuHNpcJSfLxGxUcWFr1tWukvoItF/r4MZy7M5jwoZ12EG8FekgvBGp9ekn+mDh/vzGZuKS2pREVL/NN7v9z9lG8JDZEq54ekVHqwcsuIL2sDC+al3hIy26EHbkISoJjzc7FoJdQEFnsrrXSF+06XIOvB1Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908367; c=relaxed/simple;
	bh=06Dss1ORBfQY+WfpnrGg34SnaKKkAxZPc/zJuwkm/yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obtOSCrvfYPOy9HRx4vbmh7Qyp3vaLede9hX/4c/7ilOZUfimQcYQQRqGo0mWLkd2h+kFUeWoLRa97TLpQG8RP35g4gKqRvERPT6UABDfAqUI1UN5a3As/WyfRTP47xH1Mu2AafflMpJpwVKTmFWp3zDb8l4jBUGNQu0+LdLSpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rIoO4Zrc; arc=fail smtp.client-ip=52.103.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rIoO4Zrc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSI1zRDbzLe2sLoSO0HVtXWBUa1DAf1HmLVNZ4Hal2k+Ep5U+ulb5oRiLH3vxjRCE6aL+s1Vw5h+N6CN7BhFSN5qJp28uxzwXqfKG1Ja0PwVZlxbMISSdgXj6OeZLNZE7ZdLJg0UbLGIBTqv5OwPR4Udwq5LtbBIlC6W07W3pdfAlWK8JB3aXI0mK+cOn/DE84iojfU2UzQVznqwS1xyp+ohRj+0N7eNzfJjum6tELmPqFesKvn/IFhF8waCS37vhXMqheAEtEClvekmtwGFyyMKNeaF9h9lztzDsU2NE8rUs6XX18SM7rJN1FWDYQ5BezZuL5gQc6yZlYto5WA9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES5lUqnrqmfwVzrS1cyQupmlLSgzOriYrCJuHhMstTg=;
 b=eFhwYJeENY6pMsqnsU1pjoLmDnol5mVP98zjAuJ8dcLSXrco0NmDnOI9wpFTzocdOrdw6O+x/ndfLqubJ8CWLA5kV/myGS/7UoUh25ey86Rc142wqfKQt/4uEQtJzOaD4U/uK1sWIYV9oUhZI1YT9U7I2r3r0ndVNbbKpC1tP0gc4fc7Baz7/seTSNR8ABimemhZxHDcKFoRseFd9VLvC5lsHnEijndb4fgzYpycWAcpxKAe2Xa4gev9nUo+dOmQEKGZ4nDP2/To/7Bv01GFt+Xdqt7IXpG3Q2kW52Te6shpmf/QKXH/rtAeDA8hZq/sFk2YnltNVVMSRSC24Ul/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES5lUqnrqmfwVzrS1cyQupmlLSgzOriYrCJuHhMstTg=;
 b=rIoO4ZrcKQbx4BCCS6XgFRuE7QmwlhKGD7t0aNHGz8X1vBg5eFLctlEGjivns8CYmgrAJnjo2XXXHEZ/wEE66ZFCHW3HcHFMaBlS8mlMV/3SoUQNnEsJsAOi/23KIpfybzakYii0lG9qj49E/3qx502E1xEqr65QLeR+Am10D6+t60wDUwpFeUregwi/bQECmlL634E08ODWM6ygJ7/WZIfTCu0rEFI/NoI2pQ/MqSkzd1mKgOU/T4q9/pTFqXDx4B/Te4ppJFVc+LOc2F6lZnXn04alLXEDLXI+T+KoSL6wi9Y10GRoPV/vpie5qjinevf0zEjQywZSS40TYeiEjA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0270.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:33 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:33 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 09/10] parseopt: add tests for subcommand autocorrection
Date: Thu, 23 Apr 2026 10:37:59 +0900
Message-ID:
 <SY0P300MB08017300D45E29F36F4B2408CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-10-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1714ad44-f8db-42f5-4fe2-08dea0d9072d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|2604032031799003|19110799012|15080799012|8060799015|461199028|5072599009|25031999004|23021999003|51005399006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YIkf/49gf3GtbqxOL/QAiBRI7qACpgb7ytSxVYOk6J5GH8fwtXd2QIHzuX0C?=
 =?us-ascii?Q?5GfCfS8pIDEQzdYhdC5BxOh17rMbkQkGf++igMFsalm+g1JrgQ6m/NEWOEGH?=
 =?us-ascii?Q?I/DF3wY0g14Qf5cVYHPq7XNcyzqw3D+F5aJvwf7UgMdL4Jy2jd+kOqn2ybXN?=
 =?us-ascii?Q?yZxxMZwb2hb4cI85m/DMoEaAem/IY2GWz74gChEtKvxWVr2+8Jnv0S3SvIpz?=
 =?us-ascii?Q?C1902IMfusetPQ1NxTHWat1LZPEftCTi9ZqupH/CLcbkduq/BjZgl37jMLGT?=
 =?us-ascii?Q?5AeRIe2x6Au1PQEk8kUNq4m4pl1Xn4O2OFFxhFThixLhJOeNs/GQdDmTBq5j?=
 =?us-ascii?Q?cEnKc1GRxlbklhSbRyNV7rUWMNUIwanG+XVrUdLYrtJXDLcsmP3XH3Qa0xd9?=
 =?us-ascii?Q?VexlwnEVumw6NS0zbzPik4w30D+1gNPRpdJpqpvq5MB446rl44ZYviMuHQkY?=
 =?us-ascii?Q?vRvy7aNxFJZ8caBt40WDQWDeq2fvGegrKbAyaN4yOrvAJHRjT801MuEqrrFN?=
 =?us-ascii?Q?BlYuCsMmS+uXH+eydoTmGeyssTeiNlRGeapyjnE6+4Bs3nxacnPv8HO0wB35?=
 =?us-ascii?Q?yGFpg1Yi5CvNqpn3mfZaoo0ptDhX+2DX6k2BJ2CQTSsOGt5A1aaqlse28otF?=
 =?us-ascii?Q?cngnqDB3FkDInlyRepN1nOMpVitor0CR0PqgF0oczFFJ9hrGgJH3/oH1eOaL?=
 =?us-ascii?Q?0HU77hENuAf2fpx2kxS0wt1INhTpEeB4G7cw5oW+d/eFCCuQc5dP9N+fsUhV?=
 =?us-ascii?Q?S/q6tbodiddNtS+2g88s7AbjfWXT2pR/ToDEE1NpNCA1IRgt3hbis6NkF6Uo?=
 =?us-ascii?Q?KBwhWJLnEJMm6uGhQmOiB4fxyoBp9NP84nG3uGNKUtlvtkTKCSdo+0OtosXe?=
 =?us-ascii?Q?W/eVf7YBHdR50X2Ic6PDXm6Pd0CTyEQodjiLwhqflVvCU2AoEF1I8FIrP7cS?=
 =?us-ascii?Q?7iq7zq2VJ3qBJKuPpymITbxLbcyW5+W6F6HTxwVt0cRUTuf1YvsKVjWngL8N?=
 =?us-ascii?Q?r6aY4aL7v8dIgVS3yUuXTJ91MVw739RcKt+aID+L+Sw9zauk7FrprJIy6nxp?=
 =?us-ascii?Q?K9rvm5KdLmyWbu++kzC76P2QUF6IbQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KU+KygWFoHGEJ7zFGv0qoWXDt6GTzQQqbCvj7We1lV3wIbqY8EDkCNGBR0W2?=
 =?us-ascii?Q?EJpeO/0dUjCAmP2dL2eI4etNv9GDzLbVq7d3EnISLFYmNPNy6iH67AA7co4H?=
 =?us-ascii?Q?lqjxcLEjL4E2GbGpU3JMgQFSbko4ichvEmvYirh5QPNBMwnEjTuxlhyFOpj7?=
 =?us-ascii?Q?YrXkbHA3f0K9ajhYcVRPNLEzp+kkEawnFFn4UetFVaLSuWlhtYklE1alTcEP?=
 =?us-ascii?Q?BHQU14ZDfM8nhQkgi4pFBviD/JHMg3Fn6ArG7OHI1N426J7BpEILzVXBUSDz?=
 =?us-ascii?Q?A/kkRAbUGLWXlb2zYIE5VzQ6OKt1LFG+1NlwmRSCVkTzaxix1VsGccEDtY00?=
 =?us-ascii?Q?tt30uDmSX+JKG6AlL/iHkz5ZivILe0IBYMIwe4GBenSFSsmfycpm9BVTileo?=
 =?us-ascii?Q?twBYs2ABv39YMzEJTNbf+9eiir9/QSxT0m+OIeB9aH6s/dyKXIcLQMntrha2?=
 =?us-ascii?Q?s4RzfDhfUB+SawVQHJE6prOAXBIyuzBRu99ztoOMEqQt14X6Vi+s7DEsGByO?=
 =?us-ascii?Q?+vRi5DOP9M8jYqsB1Yzh9Zdqv4RjDwJ+vH9lQd647CNSjtRPYkwBBFMMiy3M?=
 =?us-ascii?Q?7noLcwIxR4j4oZsbDQuGVaKi+6UOuHmw4Mim/PGAQRNTYgLJQJrJYJDQATUe?=
 =?us-ascii?Q?VTAXWl6E3p8ddOyoingGfjo3bd/XMTWuauL0a2aIl280RBaxH0m+Kf8OSVoT?=
 =?us-ascii?Q?Nu2s7hbiSWF3eD6GzlH4xBJd06xX+txJles367ZcN03ixw2BurXOUnbC73ta?=
 =?us-ascii?Q?IBBSPhvlJfVctJNi8Ydk6dB3H9tJxifUvBOlYI8g3ZB2nXmTQ1S1uV0keGqG?=
 =?us-ascii?Q?yCjAug4qCudSA0Q8uHxaf4rVz3UN7FoiAz/XwKllVVFJ7iqUHCnzaOC2cnG6?=
 =?us-ascii?Q?impOL86SwKX9mgYbqJElXnffYV5qfv+O3Y+JahjeeCC+ziQDO7pWaEjbRHpM?=
 =?us-ascii?Q?4Rg2FsejJ+P5PxSh1STBknyAFcM1TSAAfx3CZxzPRonDRmoTknR+SUdZCfCK?=
 =?us-ascii?Q?BSEv100y7lLfjU9cdFqBZmGjirBtD4sc+H/mhMr3XCAD8LHSjGkIwemc/iCk?=
 =?us-ascii?Q?oSQuLCdWeK/AeDkFzeUHDKaBNEhe/20hTL3QViOLe/iXVd5lWnaB38F+HJ34?=
 =?us-ascii?Q?zbfSyq0FeCyCgPNSxOWqp7BU1Yb83yVJAfk4wohmrua/GfD+dB4YGJGUaoNd?=
 =?us-ascii?Q?7c5xzTZ3uq3ztPstSnapShZ38YrP40/1AN3gOldNYQw88imxfhQZfu2orAkF?=
 =?us-ascii?Q?pDyq60SS1bqyRtG+g1pu9vwZ3zbOXr2i7UVa+zcPTBTW2KrldqcY186KtqnQ?=
 =?us-ascii?Q?QYoHbVxTw7MQcGPCoTBzYp3UHIAkBhTqmu4bhbGBZzsRsklI8GmG+q1X+Q3L?=
 =?us-ascii?Q?u2d6cDlHfmKD7ZWrKObUxcuY2z9b?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1714ad44-f8db-42f5-4fe2-08dea0d9072d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:32.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0270

These tests cover default behavior (help.autocorrect is unset), no
correction, immediate correction, delayed correction, and rejection
when the typo is too dissimilar.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 t/meson.build                     |  1 +
 t/t9004-autocorrect-subcommand.sh | 58 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100755 t/t9004-autocorrect-subcommand.sh

diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5fe..871cd7ab0a08 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -980,6 +980,7 @@ integration_tests = [
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
+  't9004-autocorrect-subcommand.sh',
   't9100-git-svn-basic.sh',
   't9101-git-svn-props.sh',
   't9102-git-svn-deep-rmdir.sh',
diff --git a/t/t9004-autocorrect-subcommand.sh b/t/t9004-autocorrect-subcommand.sh
new file mode 100755
index 000000000000..09d281bd105b
--- /dev/null
+++ b/t/t9004-autocorrect-subcommand.sh
@@ -0,0 +1,58 @@
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
+test_expect_success 'default is show hint only' '
+	test_must_fail git worktree lsit 2>actual &&
+	test_grep "most similar subcommand" actual
+'
+
+test_expect_success "'never' disables autocorrection" '
+	test_config help.autocorrect never &&
+
+	test_must_fail git worktree lsit 2>actual &&
+	head -n1 actual >first && test_grep -f grep_unknown first
+'
+
+for mode in false no off 0 show
+do
+	test_expect_success "'$mode' disables autocorrection and shows hints" "
+		test_config help.autocorrect $mode &&
+
+		test_must_fail git worktree lsit 2>actual &&
+		test_grep 'most similar subcommand' actual
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
2.54.0

