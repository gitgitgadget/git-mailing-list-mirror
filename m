Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5D2147F8
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621445; cv=fail; b=Y1NhBQoXJudTQ4dfCSOmkSwwAgixAZHcUxkgZyCZz+eO5YpbXaswZtPg0As/FHADaNxb7Jxf4J0d/fBo9GKe1d+64MMKcjbNsWg3PPtPMLVxOERtUH35uDH6cAmG+3gszXDbtJp/S1xvRRQCxjCo3yAnIGzDEUjGBE1Clon5/bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621445; c=relaxed/simple;
	bh=xaUnyG6H+SxGBRR1xcK6QtoH9JmDjZZg3XYJt5lOr0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jc4pAkZh/8H40CEvxfMa711Hq5tUBV17ZopsjBIVL4XqiNr4oHokHOmQMX4dik4TzCSgTjLxugKvzwyQT/kq2fv5tJ3HS4CgjdvUeaNQ9v44WufPoYwe0AUFWW9emNt4vqLCgjnXK+guw1Em9vx5WOCdrTmBmeKk/XhMoIOdpaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=p+MJWKJV; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="p+MJWKJV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayXGvbUV1Jwrdt3ZBpjSlBYxXHHNwVuxRnW4ImQPjjJ8MqCMnCTn3pDXjyyltGbAR+2VAfCkw0T90f0PwmNQX3jxB8vknKsr6rmWy0eKGMy+PLvcnzVQk3gpf19j/WXpeQZVSth/NwGpxiTAzaqAKbNcd4jMxOodzq83VTrbEEzfuub4gXpbwSsuXEGJ4zv/Rqzc0cISqyQx32YaFYRm6rYWhlOOfwU7/R1vRBCAbQ22mpYLEyKj45xSg9LyKDNbyba6QANkblPdHIaZuqAQ5X8q+481uKzjKJfSRen+Sin9okI18GHKeXIP4BbRK3odWjB4V/OEy2eWuqZqP67qyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAgmPa39Ue71dKvs5QVdA6+5zJioNZ6pPTbZS0M+epU=;
 b=nvZsz4n8ak3DIYHXBf+nBnmf+BhnoWSdqQdPxpRH41+nXb8bW0WK0qjA15lTvRI6SvazHUaBVmrbm0Xbyo974jN7+YzHuJ2/tKPiSH0tDeBHpJner4MvBmDC3KhgajbEsb6PVsJyCR00MeHQ+j7GfEMYx9rUmBfPgr9dycx7jpO9bBISh0tAfrIzkM23c0XxkFtNRlFoFF2AB8iqa5vYPgLIkd9ebTjmwGpTffxqh2snUm8kx7h13o+vlF6ov49iW+XpNuSmU//yKYo19vNhgsc77X4UB0PZEr8M7A95RjXzoHlGBTWWCsLKHW6kUT75FvVr6Xm6lQEtx/kQgXCcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAgmPa39Ue71dKvs5QVdA6+5zJioNZ6pPTbZS0M+epU=;
 b=p+MJWKJVxhknh1papEUbbq49WZnkLYw3vaRpJ8dhm1ILuf4MtNhXfeOHdLFObs9al1vNIqylZogODow8Vg3v1Dnsc9FMD6xIXN1qgwjotnOXMwXvx+67rql+Fc7JuckntVyFMA3JJyzYus/OpDCWfHkf/u0r0HhejSP22rzLPscQjrG4tErNQpd9SKMBpaTUWeaUBliY//nByQDsCsEqtZZkTgLr6VUsi5lW01L49Dv2hrOEk7sBTp0MI9NL2K+rXp99dlRDlpp+CnmY4fPIjSrcYtopP/AmFbmV+xomqX68DVI5S1yBlJlHBvXu+vtD0zY48p7OGwFEHvDA8gHLrw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9910.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 12:37:18 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 12:37:18 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 0/3] Improve checks for valid_fqdn in send-email and update documentation
Date: Wed,  7 May 2025 12:33:04 +0000
Message-ID:
 <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001AE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::a) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250507123704.18348-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a60495-187b-42d8-32f8-08dd8d63e7a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|15080799009|8060799009|19110799006|461199028|7092599006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9X0uio1KcN82qjLvt1A1eM3ZHtygt0mapO2Tefkgqn/kwAfXoYwLUp1Xw/XE?=
 =?us-ascii?Q?PWEATpGfPqMs2p3aMcuhlnTTnqIAJAC7wU4H0w2WI1IC2PAyAUfzWRy5H+fg?=
 =?us-ascii?Q?kyJFXZNsXFwRY1+QnHW7BK2djjwTs39pcNMdiUax3bul90TJg24ueFJfxKKk?=
 =?us-ascii?Q?LPrQAG31OnFWethskYyYGGPzyNNMt7NhsX3Pge2na+WgLseqZrbVGI35dS9L?=
 =?us-ascii?Q?eQJcfDhHMqHDcPXczChf3TQZsjI+QrLDOEuLRZCZO2JgWoWztDnc1hj3gtVx?=
 =?us-ascii?Q?oGoqwr5ghlRlwD0JS7kioUVJar90zqMyuH4eoD92B6OSdVLfc1cMjjPAq/kw?=
 =?us-ascii?Q?Rk11P8A/v/oHysWUuz02MQjyY9jUfQCdVCCd0qTpm84WNhcJklmILmmgJB2D?=
 =?us-ascii?Q?j7X1xr3AayyxC9I8+gvK88Yr+pO8GLPX8LgcZCrq55Y9aV0yWTISoHrVdAg0?=
 =?us-ascii?Q?huy5+jcr7fF1U5AVrVwqzpWXpwlD0M1XheRubEMc2nt30VqNeZBEtoii5uLG?=
 =?us-ascii?Q?/AR7WVIGah54AKRflQ2eTXgHp1ckjD/kitGjSXjnrMNwsPvva5qqwUARfhW9?=
 =?us-ascii?Q?v2azrmXgBiQTfge/PeTTq+g6zILgqW+x+iavwlOZFveWKUIys7xOSLSA7gJO?=
 =?us-ascii?Q?Qf0rIZ/zqN8Ga9+s15+Mr+MDPRuGNHFID8PU4geV+a1LxZpjL7G7yUgOmBqS?=
 =?us-ascii?Q?bQ7RJ+2uCU5JGKLJ8kiZC/A8stUckzF2udqxflF5EH808PTL2/A/9AS3o6HD?=
 =?us-ascii?Q?rg8VQ0oOkCfudLryT92KdYT1itUV99nZWmE4nX3KUAKkDbKl5jbNrzKKfIrW?=
 =?us-ascii?Q?z2QRXjyy3FT/+/S0u98Sw9chJIf0ItVKMWB/T0aiQPZKqLVG0B+oTiwKqgRg?=
 =?us-ascii?Q?UdG5Ap07gXH+yUaVDyKPo0BAEzADExSa4+zrXqygLFFg+h6O7Zi6r9kXFzzu?=
 =?us-ascii?Q?SAzogFJYKmgTykHLTmXYTb3FZhYOu4Y+xn4jTXbUs4k1ADebXKCiYIBfwxCb?=
 =?us-ascii?Q?F/3Q56gesC2MF4091LqIDRAVpne6D5Z35JrYIrRzagXuZ1iiG8T+i0F9b9gT?=
 =?us-ascii?Q?Y1MyIwcBZ5Nor5i1nkqWcwWbqDr/+GZ5rQDqKAF1mD7AWbQricTmEonBqJlF?=
 =?us-ascii?Q?+O4cP9Q2Sbqy+13UntP7WCgy53v06xD2DA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOk5cnRWYg05nKfberz1zaXMdX+SRfnofwrPh6xKrToOph2w4aUSe2CMXiB2?=
 =?us-ascii?Q?UKLMs5LowCmDUNiQBsxLgIr3QLvZqoageR5Kcdc9dwOprZ/YaKZeX2VI/oP5?=
 =?us-ascii?Q?Z0uxxMDTwgOo0pO9JMBI4Cj8FEBvRv5raz7e8dsTpJOmaLzCNYKa9ccspjHM?=
 =?us-ascii?Q?1Fv+f6ERSCWK8BbbXSbwxcLcAC8tVi+/adF/+T/CZ2jZYjbdPSx+NvQkDUE8?=
 =?us-ascii?Q?XOxWkB++0s8s0jeucKb1wyULXotaNz6HTBTSQLLuV0OMni3qG4MUx+WVr+KA?=
 =?us-ascii?Q?BNvwUQ5Z/lR0r5ra1jeCxd1awJfBMf0wDxpSJhDlMvitAODxlIHxv0+Ldila?=
 =?us-ascii?Q?GljS9PoPtQ9w1FwKCNntbFcudvZr+ZcFA8L8+CtJ+GPQkl/n4/KmQiBNOJ7Y?=
 =?us-ascii?Q?jg/f1xi0wwKdzMRR45Zr11H9H58BR6Lma0Ah3DWhIYgYn062atoDsPZhgFrP?=
 =?us-ascii?Q?6lrYgzPgWQwj05InRw/B980i6vacUaoheCtomOGKJclGS+gBL2Sv+mZBcCmR?=
 =?us-ascii?Q?4uu36UrA+A3mcrg/V95SyLEna6sK9QfJ2gyAus+rxyOv4DxRwujz8YoFhd16?=
 =?us-ascii?Q?Pikj38X5/rjv0uNx0f3WgwK68KJFCr5VdIqg32A/6LRu/YyuXeJQT3IfeuB5?=
 =?us-ascii?Q?84miPYQLN0SGCoA39thv+rUPAkziBVWU2/0zZPmXxkUF1anmnDKjhz40NJ2F?=
 =?us-ascii?Q?v7HTG9ndxd8qoZ3p5FmhRzszJ+ZOyQP3oM2LsTO5mlg5eS6GQfGb4AhPMUOZ?=
 =?us-ascii?Q?Pspbg3jZDv8GoagoO5TSP34LAuwS5I0XPBhKLSz77MpxLO8FQm3Z2dw2Vy5Z?=
 =?us-ascii?Q?Jgsohqm4EVFNuNsyPy99q+G9kxpZQMGz5slenb8t8PwU1kLtRpRc9x3KqF4Y?=
 =?us-ascii?Q?VR0cmFAnMwlVQraaEvcPRkasXUOGTfKCVmswUG3XqP9dTbMDdS41jSc/frK+?=
 =?us-ascii?Q?2IyWEOaqeE6DaNJoD/q1zA0dWPWR1PEtOR2mgR7KBI/NqPYzjxKJB511bnxy?=
 =?us-ascii?Q?q+B4WlVoktdFB2mLigJkGtI2d3fhp8qiC/uldxNOl4G+LwZsu6MRMVN7et+2?=
 =?us-ascii?Q?k98nQLoLpF+TGy+TmPrE0v9rgORQ674LYlwsLyaaCEEwWDbXcW4eNPTMjHcl?=
 =?us-ascii?Q?eKi7vtiT5SKLbuymxnofF8R92+nvOud2+V4Eqe9mLXSbRjIvT6ImhvkviHhR?=
 =?us-ascii?Q?NFW0H2IpWlXSrwSthdJ/taclim638F4A0jzaQDhBKLfbesMu0dGbaVZfgRA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a60495-187b-42d8-32f8-08dd8d63e7a6
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:37:18.7063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9910

Hi all

This series of patches mainly has two changes:

1. Improve the checks for valid_fqdn in send-email to be more strict and
   compliant with RFC1035.
2. Update the documentation for send-email to include examples of using
   OAuth2.0 with Gmail and Outlook, as well as links to the credential
   helpers for these services.

P.S. I have used `git-credential-outlook` linked in the second and third
patch for this email!

v2: - Improve grammar and add missing "" in second patch.
    - Separate footnotes and the trailer block with a blank line in the first
      patch.

v3: - Change link for email helpers since old one was too long.

v4: - Improve log message of first and second patch.
    - Update valid_fqdn check in first patch to allow one or more <upto 63
      octet run of alnum or hyphen that does not begin or end with hyphen>,
      separated by a single dot in between each.
    - Revert the documentation regarding sending patches to a mailing list
      in the second patch.

Aditya Garg (3):
  send-mail: improve checks for valid_fqdn
  docs: improve send-email documentation
  docs: add credential helper for outlook and gmail in OAuth list of
    helpers

 Documentation/git-send-email.adoc | 61 +++++++++++++++++++++++++++----
 Documentation/gitcredentials.adoc |  4 ++
 git-send-email.perl               |  3 +-
 3 files changed, 59 insertions(+), 9 deletions(-)

-- 
2.49.0

