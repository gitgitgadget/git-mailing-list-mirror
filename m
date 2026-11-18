Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795017737;
	b=E3NdgoVB/HeRCshlLPKdMid6AT237xax0jL6tp0XxrvJc2i8FxScMDdbTmWr418v0dRI
	 SszKGDE2M0Io54EeKitWxR1mC4lI/FN+MK9Xd1APXZAFZ81EXoX79XHOFi5GL3lM+tbkA
	 iNz3w7+fTJkerGjf1pOvDVQEmOosEbH7FpJH6bM13LM5oP7NuboqS5ig0Xy/XVr8/+OK3
	 KX8ls15wOLQD7Qfp+r9Fk17lOJApycVpxuvvl5+djIIT9U7J5++fO5ffy9GoG/aMUxBLo
	 KZOzuzitQI+Hz3TLQ/wwXZxccT1F7OQJV/dXamQwrmyGgukUHwZB+8+YKJeolpriyAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017737;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info;
	bh=C3LEXNKyVvIpcNSVLB6cQT6/SUAhUUxlH+xWeIZw8oc=;
	b=v46HPSnqKCvaC1kfr1CqbcL6qz9zsCAjJ9/0wIBHrze4xWAmitS9SxJkHlIey0F9aM0D
	 HL9MiYIFX0cVwR4F7Co6naMvasn0GsLsul+U+y4GrJufC7YSWqrG3gOIUTs81ZX/HzepM
	 J+JFLbdN5y+NKht3xYJKY3LZInWXcUoSVaWNZdWhumTEk+zs4mrd7EwDx2hq8GJ7QDC3E
	 l3V/mlqnLK+wT5mHj4XG9xAzeUEpGt4ZD3/tGYhuO/snNCgE9ibGN7aCtgqBI025D+Fuh
	 xHnehQl4tHvN1odbYsrfT/JoTKrlfCT3xvt6iroa/GHk4sTF9diw9F/LB+JuprCh2Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=FqTzbLl4;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=DLxDo5T1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92A606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F92A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=FqTzbLl4;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=DLxDo5T1
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIE3v6t370716;
	Wed, 18 Nov 2026 16:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C3LEXNKyVvIpcNSVLB6cQT6/SUAhUUxlH+xWeIZw8oc=; b=
	FqTzbLl4ZmpTD7wEwpBhzpTnF58zcnvBcxTMbOsmiu6TmWbwSZBKHn5z7lTYfzAZ
	18EYmJiil1bRvC8dCy1VSu3nhrhWjcoyBOY2w2jIxZp2QxZ+A9zbZsujvkxpZ26m
	GGRiZQ6DRSLyaS1MUACvDtYnolD7lUSn8bFHZMZmQbnR3BdVRHKSglFHlZ5wjobG
	5w4HJt013yGsmc3JdNmR77KQYc1n2FNGtJTmEiDq6qH6ZvOYibhNav4k9AK2sq2K
	mGCQbHM+5ST5Q7oyXeHUR5PbJyjy+aWaSLUlsmMYUnYAnnr7f/X9GycZ7e0ozM+7
	jEWcTv5rlz4AGx0ZjER+gg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytr9914-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 16:02:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIExDbm947378;
	Wed, 18 Nov 2026 16:02:07 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j1e8x2n7b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 16:02:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxLAlx04WvngdFCsN7/hQnBN5jkg05OkxB9Yfu/8wu6WTD7B7FV7RaP6PfNz4d5Bu1EyFmItTO7PqH0SL0wKMbNR+MY50B5p1W4JNUUNMmmqKs9v/OI7MhqXoYQyEYj6pj78v3HdmXcoR4WWVzSqLLs1lEkJ5rGSYxgAE7xdTq+O/JP4z8J65cxZxKMJuo/OLjQ5t2jQAzHHm7XWSBC44z5bAMLufpvGnj5pC9BLfy0m+jpzLPeJ6QPLMe3qpC64lIc844itDEz72MRJMPPto7IUVr4taBxrxTR0Y1dz4lDmFnEo8CyMylPL7RCP7XhfE5N6mPlW0TBbHEBNgdwmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3LEXNKyVvIpcNSVLB6cQT6/SUAhUUxlH+xWeIZw8oc=;
 b=AV/7CG6JvZrhnJEuVifWfEyD1R80sMtOTl/e0s2g9T3UzevZuVnQZ6xzNgx3DyVl1Yh/0qaPtCBMRpj8sz1d3sp16c16yD1As+4tNrMnBaX7vOx1iAdUCHZgw4m6izSUR5+NOow1fbBIpF29q6+1D5HFmVPcC0qSFHqXf04A/nmDUw55wXCYJqms0F9m4N8Z9IM8+RhhNeGk8YtnLnAlQE9ciY+uDeX1IydwRxOraGSsMwZTBUFZfoDr99Lq5Fn2Caj5+jpv6FVWtOFiCvKw4Njz4XTNHHssJI3nGvsSiN7JsedDQ4RWfY/NSJAPXGCPY1SNnFqamoeukSPeCUXBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3LEXNKyVvIpcNSVLB6cQT6/SUAhUUxlH+xWeIZw8oc=;
 b=DLxDo5T1Oj00wjSd/krqK40ZddU2aA0jZ9OhvjXTo2juRoC4EPk/dDs+I5TVm3dH6TOu2G+stAwZOj2mnwvZtTT/ZMaAUKEUhVeN33Gel744VDwJQ5yHO6YKDdmTKWQsnVwUQBX6iIQYDsziYOHKuzkg7kTolbNMGf5R/pS0UAU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7)
 by CC6PR10MB729833.namprd10.prod.outlook.com (2603:10b6:170:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:02:03 +0000
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de]) by SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de%3]) with mapi id 15.21.0615.012; Wed, 18 Nov 2026
 16:02:03 +0000
From: Jakub Kulik <jakub.kulik@oracle.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, Jakub Kulik <jakub.kulik@oracle.com>
Subject: [PATCH] version: accept positive uname(2) return values
Date: Wed, 18 Nov 2026 17:01:47 +0100
Message-ID: <20261118160146.60429-2-jakub.kulik@oracle.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <xmqqcxs9j1bp.fsf@gitster.g>
References: <xmqqcxs9j1bp.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To SJ0PR10MB5785.namprd10.prod.outlook.com
 (2603:10b6:a03:3d1::7)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5785:EE_|CC6PR10MB729833:EE_
X-MS-Office365-Filtering-Correlation-Id: e4278edb-3deb-42fb-aa36-08df458d490a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261021123027099003|10067099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TAZqvGwUx+QW9+fEs2eLQcZzkMKoAbTemVN4qDFrl7B2XZr2LfOZPl965nj563o6vmErzJguRNxxbSgHveHTUxqaOKkQxjwft9pKPTU3meqkT/dzOlnlgThlA/zgmNeJoXckldNXsU2Rv+H0eIoK+dekwhdRhLpNYDTQGpRmVzQNUqM0W8SFAuTSqjDyx6ihg97kUoWTIchuvsqY41Suy/CI0xM1/bGBvR7LuCe/MoiCZbn8CqkUYiu0aFclHW2o7NatajwFUWxNuF1uqw5JDHm0MIRJPGpZWF8lZp8aM7//Gxd7rskXrNGs8XrDlH7RxCAXOHsHY3gP2PWcGdvpn7ENbA9AW9Hwf804K/yh6CpOuIJVU1JhfkWA5+sxZv1yjrqGN1kzEIfSRGgeS+D46Dhj/M7kk5/lJTJwS60BpotlwVcwobsrWAY1PZ/aGE4MfuK4u7Ef0gWkTBt9X7t86KB1WvxFdaXHVe3VTflM3adMamiVihweiOe/L+OrVRmMvEbGwP6fKRhxjdpc5JR4lZMW3WfGHseSoUJ0sk/eQNs3hScB2WwZXHdfuCr+FXM7x7D+FK980nQ6D1NO3T/PuMUysO1y7jicYHAGV73GUhVK5bnmSsZbO77GpeoH9UnyWwYyqRlTDKTumoZ9gMh+qP6Oj8KQl9xqE6mavw81UJI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5785.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021123027099003)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3AOj8m4Kw9P05bWD3oK6Mho183NGWmiM7ohn2ggRGroNsB5XzAWUMJrC0jm4?=
 =?us-ascii?Q?dm3Tg/QtMwWfIBhe78ChQZ2DqMCzZAG5jAm/mT7L7ZnG6Qk6d+OWVbIM9Q3H?=
 =?us-ascii?Q?3UCFWz7PhtpsfABT6/jdy9WaxQcB2i6qatNbAn4JihdxbjsoDoFkS+a8f7uQ?=
 =?us-ascii?Q?SxhjRmytTDXqpO57oaoHq5vkIatTtgNEHRSRq3ZmqagliDpIN+DZlttW7Ju+?=
 =?us-ascii?Q?KcR1xJvwQCn1bFYr66f0nlqGgdajQKAfRFKekYh4/tps/khqGLBsfWWOpgve?=
 =?us-ascii?Q?q6kAM/slo9+W2MVV0zNVrNxGo8JgYsbdL5lyat5c7InOXAKgx8VRam49ViGT?=
 =?us-ascii?Q?66LdLhja/MVjwW48UNNpLtoTcPveg2BXRnStLB7PIGRKxkEUkHl0OvLObCJM?=
 =?us-ascii?Q?zSMKfYOX8YAphRC6SImE+wTbXaz50nYg8xvvICq/lRGfF9h0TJrrAc7snMCE?=
 =?us-ascii?Q?R4M07n9n0EP2QOYvQ1wMitF6iokZlmIJu+gJBf/pqU+sqdpMmB3LqwxUoi02?=
 =?us-ascii?Q?a+czPicT52NsSBUsvWWH/n2pgPAF8Yme84Vyyu9gqh3EnLaF4dUhVv1nkJjM?=
 =?us-ascii?Q?rWxxyO7MgcLJozlQmAkpmcpiomK4Ip4oH6vFZY75JMf+3GizPEmt98NLJNo9?=
 =?us-ascii?Q?yRThlhXuDBIoQhYOhGFccQS59nPrsQMdusDgB037MamqHRziHsw0Vh1EIvyx?=
 =?us-ascii?Q?j9HUi1jT/vlWRnxNUlncJuLdx7f99dR0SorUARa2N7BYgGSUuqO6h0WeN9RP?=
 =?us-ascii?Q?BgEIS4s8F9rl77SYYcm65uPctakizK5UfOV/ov6siiRuPtukZuFdj20M8T4q?=
 =?us-ascii?Q?2ygtweIjGYWEzMyiYvtsmSAEHFAI+Oj9pQnuy0yODy5U4ipfZnZHP+nGuqUH?=
 =?us-ascii?Q?MQ6WRogqWdfR7EFdZqndRW/yoxyHAx9tuKn7FNhzVDUoIBvVXrRLBQOQEowm?=
 =?us-ascii?Q?hr1/UxNsRSoHUeBr6P0+ZhjSF5O6fzgqjIasP0x3/MRUf0vKSdm6Rk2B/aH/?=
 =?us-ascii?Q?37Ul7o8/+n1sIq4YMEe351DtVxZpY40/p9TYqftPOhuzBJioqMi8Kwd4MkK7?=
 =?us-ascii?Q?j0UCJJjNuBgz8sbY8I2X6brksOHLv+chzelRAZZ0fxAevK53qirS/FdFBq0J?=
 =?us-ascii?Q?zQmX4S/xJ814pX741kCszs4rPpOp0X4J9HIldFSlnhYZMasiUgAkTFbo/0kM?=
 =?us-ascii?Q?Gq+aJ2tHP4h1EsOAG8nyVlYBuam/KHA1H/6edNof8gj3EeJksQykNUFCbs25?=
 =?us-ascii?Q?/xay2+fIBixEN0X5AAedGzW+i8bez6v5BOhpny8H3l4TuvNBFzJ9K6DfAAUD?=
 =?us-ascii?Q?yYhkv51lvE9Q/Endn1QfCRZw5snhYCGfTmFw5blgNZkO1HdH3exmZWlkhA56?=
 =?us-ascii?Q?JFj1VyQ7zFuupVRDmu6ltCneagmbZZE+nKsjpjTXCB3TRcqFGct4bTEwSXYm?=
 =?us-ascii?Q?fdEC26fxgwim2wY9Crb3J8N643g7GfFIv1N6gO7zV24Tq0lTj1vhYdI2i8mX?=
 =?us-ascii?Q?z+SG+hnyVfqRKfAUXDsDCwolkUdquOAhgVOTC+Pcve2eM0idWTXwoEY/MXNV?=
 =?us-ascii?Q?wi1m4w8WqrN9ZuQsEep+nMq0Ge7qpgVPO6q1Iv4La+5iiY4ze9UxmWYRGDWk?=
 =?us-ascii?Q?cYXx+sdIa9TjYTW275JO+G6KAW+FhYmnGO6pZPol0ETO74xkB1GxKytzTm0b?=
 =?us-ascii?Q?2MqMDcko/n20LpCctz52XSGrp0x+CDY0t8+xV5QvCkr66LSX5URJCZksWRV3?=
 =?us-ascii?Q?nkHn22LonQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	z/nCcMz0CsiPJekYvE/RRLHpOrDr1suL1YxcPXjH5EW34eM5h3jwVbylhUbuVCz6WiglLq+GiU55EJ3/R/C0UYumtXJpw2Ih1YTUD8x6eizlm3BrzlQkWlzAQAvJxpEsGY4VkmwxpLLE+GAHskVTtnrp1LBNpFSCrcLkV4TkCknM7uCNp/vxseDw+kosWB4gKz5r5Rt4Ho1ir+ChlOHMVmu89QCboWDpOavyICpXJBEyuAtHi9S+HN8i76VF1q+wxR/BRHm+ISZiXxnLJACR9F7NWXeRagwD0P036AVY0h6xkcI5dY5yzesV8tnwpmg/q8oR4L5UK8A5j015W1JVKw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BFN/76TUY5ey8mAusAEP3T7cXNnWpKjj8+YqIdFviUgw4lUhQNsyq8Kn/fYvfgQ48YL9Wv99TiQmqSnEr4H7LirDrSSmky9jYsSDuf9kAK0GzWEABxO/PhoL/otYdth3CHOB5Iibr4urxSY0xGM0ZwjUgv1yZnv5tTxf1F8n5a/MsIIzXJVe3v7zEhRXxGfysy33ELoebeRW2+1SFaUb8q0bx7FBi5xybFhdEYBIaIcCWejBTmRf9tNdtWX3e4jt5K0Iqgj0jOQbtvP/n0wOdm3/aqmVKob04LQywl3HcECXD1oPdzI0OQKGdJGbaBFZOcQW8GGthy4IxK+IewUWxgqSx2ZhaAFBeR9OokRokOH/0tAtQJVVJ+JkngGZrq8iTephtDg6GLr/HGtcF+zEMxdbT78M5sFk1xaCF14XFb8/hlkHJGF6P3QxNzCOgWPTEzPh+LTq/M6ADW2jBXAxJPmbF439/KLIHDMx55EnDhr+f51kVRq7TJ2/WnAKE45eoMnreCHTO3DXNDDSxlbo5fHGAc5dBfTdGpMOfGpjC6pmNYU2CJcIpovdzTSK6waDQaIzZ/5d6bLFI1dq+4Wur8eJRoEGBE5l7p0MJea+KS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4278edb-3deb-42fb-aa36-08df458d490a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5785.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:02:03.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NwR+qGWvRbM8/4sjI+QNggPHBAxpwsxSIy2B2Ya6jCqyvKywUO27dLwLazM80dP93ibjalk2DrcbPeCurzjXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR10MB729833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611180063
X-Authority-Analysis: v=2.4 cv=IuiL47/g c=1 sm=1 tr=0 ts=6afdcbff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=oJav66JHqgLKexc9k-AA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX03U8V9ep1KHG
 jF/PhBsp8skMWfGg61Hz4lmFm3ETm8dENbSa45XfdLnDNSXpr/jm65+jB8NtJqI+DETtimYz3P6
 g0qV1pwsIb0xG0RkGH7mDJoiEgNBZqwYQPB3SKxPfs0l3p5OYGObktj9ZwCr6m+biewxmYuELr3
 ahR5l7vf2gTwoYN++4DJ781t7K8pG3vhKTOw/Rn2H+YCGtVMc4YdJ/jeJIb6fEjoeIjZHMRCjah
 my6iH004luldKg1mWyo/RmxPMwStMRRNqsnZRDrsBJhZAVO54Ulb1TS93tgIfAVNxXtnyalRp2a
 x3GOrMbKuMq4RTTyQ36/7S0yit63CkBFqR50mPEjiqoopWohHDi2U4irRSRTpxierRuI4dANl/H
 c7pnT0EEzzGsJydXVIZGwLi1U6qzwP8mt0Eq2LXjHtMlFQEKMD+tjOU7e/Acsv9jqg6xAdVzC/5
 Dn9wd3wHl0jUCoGFBaLuhjknaFJkjOKIOMGmebSQ=
X-Proofpoint-ORIG-GUID: zuO1f_uXmVYBw4ldKfhdrSVVncYKAr8Y
X-Proofpoint-GUID: zuO1f_uXmVYBw4ldKfhdrSVVncYKAr8Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX+r9poEfz/CCz
 BzMNi5Bvv7O54ePFzIm4wtfu0Fp7xjFS6tudPiHWdhgu0E0Jwwk3D9D1gtQ4/DI46DXr4cQ+jTx
 Yw8Gy3X0HCnOEK3kRC4Y7eLXaz6TdSIZcpTmf0gBZQxlKX8alFO8

POSIX specifies that uname(2) can return any non-negative value on
success. Update the get_uname_info() check to follow this.

Signed-off-by: Jakub Kulik <jakub.kulik@oracle.com>
---
Thank you. Hope this is how it should look.

 version.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/version.c b/version.c
index 21ec7c0fbe..ca3be6d610 100644
--- a/version.c
+++ b/version.c
@@ -83,7 +83,7 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
 {
 	struct utsname uname_info;
 
-	if (uname(&uname_info)) {
+	if (uname(&uname_info) < 0) {
 		strbuf_addf(buf, _("uname() failed with error '%s' (%d)\n"),
 			    strerror(errno),
 			    errno);
-- 
2.50.1

