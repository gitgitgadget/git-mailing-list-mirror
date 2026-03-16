Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B033A2541
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675415; cv=fail; b=ObeY/6052D6p4spwsrXwvReZyOZzWd8pB67dtA32f34lSMl48JiP0S6PAXzW3DklBoB8slfSMvKN41yG4U41IyZzjTVMIFglArdhsnn6khXAPJH1bcBdZcgngkQ2cnc8Fe+LWn2nu2AyNvoXtm6UGJkQZhXSxMueE+VBhm+OpE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675415; c=relaxed/simple;
	bh=z3stphgIGvsy3qM6RMMQlU+osqMF26aThZtDQD4hCW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smg96AeS8Ti326XBnLw9Q8oIF7+j8CgnagtAnYj25YN8nRXZE2/QHLyoAzRMU4UHfCGyhD+jET/b+uuGrWH1bLBw9rXr3iyRPCzcSyLKnOqp+DBvlLLrRwQG40DgxJ/cMgIqDdem/ajimLSGvK0cGgaE68mM/7H60176s8ajRYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jfQ1jE2A; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jfQ1jE2A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpDUiw/k2hPLr0atZ/1BJd2zspeoxA83iabHXatEtRjl3FNwjC4W+uxKiJ1pcvQ8znXxMGb4ogkLthwU9D6vjjTATD35xU/aI/uO8Q5z0LEaX0EIwCRHS51FKBhqm+M9p6fX5NXO3o2wC2d8XAmx8DsfOeWDBS8AG4VENBl7hpYjg4kvHIju1jbdCIOhB6+NcjvERIBFx6+ohIbWs7BEd88lekxSukfwK0UzkIa+tHLqZK2SRbhISYjd3Bv+q9MAK0dMQP27+wr/+bHjq0OKVKWEPmKuVX7MGOId8Z09k2B5KZ9r/TgjsE9WJkqSv0dfA+bhweRfccIyQ6H13ARFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoO5FCKMd+wUoOjB08MMYrBsCiSgG9aeB/u0LHlAHfI=;
 b=qfhLeOBuDxcAaBAGVKpaEazyplH+J0tf+lEpus66xvqo3+UxmxwPjjhhN3kiZarFUMXPoYYu3rW1isdb/wV/VTlcYRMbk341khPMvwtHDHEDbGyJNtz71FgwUnHemdVsGTW7fNg34pu+Ktfvyai23SuiQ2k3IbBCycXOY05jdydiZklxiBz6O8SVwUA/LTGEJafqzOMNbJ6E6MKKaVrhn3MxUQ1hREpv7JjDX2Z33hhao5wFd5lhOPWpuP0TVAe1mnoTjOU5r6mpmf61vprNuXM1qhLTRYGyHr14BgQ9UjNFxv+3AoRS2t3u7c8V+M5mekuS/mI0g8fKJfkcu+wtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoO5FCKMd+wUoOjB08MMYrBsCiSgG9aeB/u0LHlAHfI=;
 b=jfQ1jE2AzrrVuf8DkePr3onGAEvfTPGdGOj3X2jVntlLqooofvGXuyiqt+qHE+xgcUUXejNjmjMvIofTtsMUaPU4tM+pzbsnRHgFyDuLC8zu1TEDkoEAeUwHXal7OqpSV8sN4TI34OXxzFjQvdyxxSZ16CpnOPyBRJHG6GJ3Hns/bkt+Pa0LFlDZt6RiWg4580JKmIv5Ty/nhtDcBoU4oNoGlYE0VrQ3kD6i4aAhVg8cx4dS6PisVVAoer5nzl2rZ0wtwumofgdSINHun4u7su/chASfBEjo7e5jfWwGJcsBWk0zpMQ6TEQ7D5UmCUwEwnQgeGi5m8Qy7DSWU1pDaw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:45 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:45 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 09/10] parseopt: add tests for subcommand autocorrection
Date: Tue, 17 Mar 2026 00:36:22 +0900
Message-ID:
 <SY0P300MB0801E27A59F6CC1894167806CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-10-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f50c05e-2be5-442c-c73e-08de8371d431
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qiqDwBiRxRj5nHhIAtm8OwZSPHp7mtB+o/YFvTECAAIxD5ypfsctTl+D1fOD?=
 =?us-ascii?Q?w0LwCz3SE8wE9GrpJsdtUAfTRyb9GNNCjZGR3ssocKpI+hM0CYXpJ4Tv71ut?=
 =?us-ascii?Q?9PMpQJyb+NLXPWn7cv6T9BHFz6aQHYFAMaBNKUo7pXOL2xDUmZwVrn7AyIyP?=
 =?us-ascii?Q?GGblWlZo/QbinfLAiuWPmQubsEPgIn+gd5V5I1yukVH/P+GfkUOt0sc6d/8n?=
 =?us-ascii?Q?lX7VYR3IMxUR/G5T1K0NcHc6GWFLolPkXYeGZBBMCerDjfc5Q46DtJ3VlaAK?=
 =?us-ascii?Q?TznLyw31ZWn+GeG+5TZ0fEJy0QgD+CvS/njtBLu2oDkbGl0cSUd10WFysQ9u?=
 =?us-ascii?Q?dKZkoYpBkiGVZ5Fqao1cC0k1YBRixl0/gx/4IxwzdtG0fpvaLGbp9fL/6Ytl?=
 =?us-ascii?Q?ztDF0FG3AVzBnVA314yRVLvDsiQsHLhP7uiB8adL/5dSBvEascjeeQZ2Zyjt?=
 =?us-ascii?Q?CO+BoAwfTnWp5XRISXvnZFmgIvUZG5DjvSE6J+S1oQ18Ri+b+RsKrp9eJc/R?=
 =?us-ascii?Q?EpfUkbNQxVrHPfx8fOZZ7gHWmSnzR4jb16Pf06YvqpKYjQLTRszr27UFqR8i?=
 =?us-ascii?Q?N4I9MBxi+9rS8UTL1NiHRI2+SKKLsV4uaZ8696nikyJ/Mk4gGgsr5optOwve?=
 =?us-ascii?Q?s2oAC5/vf5dR7cTKVgXiODAAohgnuhat9gxTvbFDWEGVomz6cqJPhsD4CdR+?=
 =?us-ascii?Q?/bVU/XgzfDoAq/dFHJKr9Q2CBq6D3leZJ5/jQ/1e2XzXCX9F97tNbrrU+aEc?=
 =?us-ascii?Q?yw39nZIEsYlXDiFKjyLbpyytnN2WKw1in5KUOxNOtFsM4Is+CBJPZuk6097V?=
 =?us-ascii?Q?+SfnHV9sOsxaYJFa7HVGDBAScRrc8RwpEs6QyEo0jSSD0d5Xxw9/0WwnMY1v?=
 =?us-ascii?Q?OMhOQUZwDklz/zn5rMubfQayPp6OnPFVa3KbCQ2MkJtwrr5/KfKUqUBY8Ixc?=
 =?us-ascii?Q?BQReCmFChe44SXD0rZNeMA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSctHSUR3h3WvcLnM5XqwG5Crs1LyKbilk5Z5qt2URMambgq44QaGNMHr/Fy?=
 =?us-ascii?Q?hRVu2k8aNiqxvUua4Q7l7fRDqqBxsjvEvwKCtisqqYUQf9f8vtzcnLjTzL7d?=
 =?us-ascii?Q?CS/HiSw5u3kjiunPSF+7+Ljv8RFkypQ4pDJE9+oSILQZbhKdazJ94RoqlZrm?=
 =?us-ascii?Q?nQxZn2yUuP5XA9+a+EYcB9VgGt5qDOes4jcKOxDCST6RSks0PpZXub6vSjHk?=
 =?us-ascii?Q?h02/K0536W9s/NghYFxIW/mGK6FHiUFPk9KIePFsjJiO8HQjFhUwe6lwawvo?=
 =?us-ascii?Q?ibctjnX3tli6p5v/lpBl3KISXc6mXkCo4fHkmkNaIXoE6I5ecWIfB0KlYzVA?=
 =?us-ascii?Q?XXNoe0C7snv9M+CyA+zKq7bgcobImoAqlNR3DfeGX9cQt83LdtskrzW5nOdk?=
 =?us-ascii?Q?PVWUxsSfwf1EIjw4qAYRXPWhEnZSPS0mDxZZVFu9FINpqjnErcL8nRQjNqVE?=
 =?us-ascii?Q?6sOzvSl21mS+bw7K5APlbV42S9MbSoqHzuQqy20IAQOCrolngdYvLcEssUuM?=
 =?us-ascii?Q?lXgphxyb+oNpL4dadR1UEj8D5Nhr7WxWKUzTSIWttLvZenFdpfmJXJ/jcwuc?=
 =?us-ascii?Q?LA4loQI5+34So/QCubWBIFf3eTsy3jDJi/+wuboXZ1kn9mUIvwCXgNchcauC?=
 =?us-ascii?Q?3+1tIDNZEyOPUHre4mHCVtTiXxhhuqtadjL6KFMOh/trBHDS4J4Q6zhl+Qv2?=
 =?us-ascii?Q?nLSi6HS7yoblsjgKQrPCdOdxf4ZuTKfO11v2QmkWFo/EoVXZGhb3c3eIhGNX?=
 =?us-ascii?Q?23Q+Mu/4NTqDIGE26PaKC1hZ7u/cOFwu0x5SCYObTIUJC7Zcpg2ibE8x2C3z?=
 =?us-ascii?Q?OelvfgriCFhMFWgtl8L82ITiNjPWfAlfoTNgpz2umqS8kT0iCEiKOZZ0G+4R?=
 =?us-ascii?Q?icl3o3DBgMmJwFVWFT3O+1YmRE1KH6zC0NZdXDTJ+VWeZR58eWVEgmdA3YHD?=
 =?us-ascii?Q?DRvgvCuyi8G9G8y4x12+YrVDiMVk/oZRqBere7xMt0wUGL9Yue3mCOs5UHgG?=
 =?us-ascii?Q?cafdp2k4vBwbHKVoWDFoQWP5juBqa/d2FSLesMqpodl6/8zSGiF0rN5j6tUj?=
 =?us-ascii?Q?/lBODJu34lWHF6ONhij9PlM26Woyd+zZvLHBDnvf6cXiVu0oOJQR+BpdY8sz?=
 =?us-ascii?Q?6s6ZfXmUByPukiCEf19XmTgNc7RGWOkTJb7D6NlvTiubOUqTpwnvRl5RBABw?=
 =?us-ascii?Q?B9tcRy3lOntlqJqDDzU/m9h/IU2eitc5kunSwE8Tbgzuvh5PsGBzZqiC4MA5?=
 =?us-ascii?Q?z0dNDX3TdA3w3DXJE5cxEpNbdNj7Yu2emLdVoE0gopyhf9hsjnGLs+/uIB07?=
 =?us-ascii?Q?vvzSUd2Ru8F/qHk6BLDpf3NFVqmvIcujQRlEH0XduBl+eUf07Sil81Q7Heux?=
 =?us-ascii?Q?BWUUYtDo3k34NrzDXzzA8J5BA5BM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f50c05e-2be5-442c-c73e-08de8371d431
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:45.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

These tests cover default behavior (help.autocorrect is unset), no
correction, immediate correction, delayed correction, and rejection
when the typo is too dissimilar.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 t/meson.build                     |  1 +
 t/t9004-autocorrect-subcommand.sh | 51 +++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100755 t/t9004-autocorrect-subcommand.sh

diff --git a/t/meson.build b/t/meson.build
index 106c68df3d01..311be82af346 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -972,6 +972,7 @@ integration_tests = [
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
+  't9004-autocorrect-subcommand.sh',
   't9100-git-svn-basic.sh',
   't9101-git-svn-props.sh',
   't9102-git-svn-deep-rmdir.sh',
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

