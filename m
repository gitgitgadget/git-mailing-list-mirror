Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABC48C8DA
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208274; cv=fail; b=ODsY1SnDUjBqdgI9leN/J6Itp4jE7LFyhRR95vGqR+CD7fob79u+VXi0DpJSCEadIlVpkAWzjZojGCDW0EgrPmxASWoQ/14iO3GTQuCyvIiZlSkhbVvackXyyswSeqcWdwz7VVu+82ovCv0FXtvkAdBl3a1JiKdC8MMxUpLKOMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208274; c=relaxed/simple;
	bh=nSGLbVjuYkXF4zzRg6etfNmEUiJcPZdv4x9gcJ21htc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TeYGKQxVRAm5BSb7Brkz/FuMCZGhyCaRRfY+V609lBSG4Nxosx2GC0A9gBT1Xu/Pdq7+ZFUXU7ErnyWjxXLsxOPhD0dK1w7isEY0vhV2RzvDgMAt9c71MYTHqVqegSOl9qMRYEixEWB4ZhWVEl07OBms3B2RSwbnLJg9/0Sthl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PBgire4s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rpMuTp3d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PBgire4s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rpMuTp3d"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JF8fVQ2763493;
	Tue, 19 May 2026 16:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=miEfacmteohOyFXoU7wzkcbAraQECufB1QOEoeQkoWw=; b=
	PBgire4sR2XIBYb0wbDJDCcy/L47dZKlZWxCPXAERNm4xLN+fnqBwVficW8hss01
	zmfBE1hiC8QRAcJka3pp1UrMEhJkpGCE0c5x0pm+Zqi5P8PEWim1kJosVuezaa0E
	a0zdjdyEnWQ3nGrM6zjObNDL4I9mNNzWLMox3o9IHDbmR4pcVi1XDQoUYOWIe4Hh
	2VlUNAHas6Ah2u/kN2xaKE0uvzUtAGquhXDd3Wr7pL+3A7JbcptAZUZUpVXTA03T
	Tp0eEnDogozhv7XCyA5uqA8GODaHkI6Q5iWbYiiCMjSBpra34Fr4Kuh5RUNBmFhp
	/9Zs0GENmuZde4fwOfMlnw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1svyw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGTor7004372;
	Tue, 19 May 2026 16:31:08 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1g22py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll/SCH+iLv574ThodNhQy5K2YJ2ZJC7PoipNFG/7dLQKpmwjzS968UbKgcq1hrnMiiRFwixiJ4pefkwMA/W4HcJc5ZqS5JoN1UnlGLnNlsfdqK3jtFOCxD4C1xjB4VTDv3QoOmSHsvY4BSez/z+sOKrFIOs+sl0A5ukX6pH1xrCxzDyk7BsiBiIRuYCxl8LzpFnUqK2oSU8oKO+Em94BVQsIvxeysyCxd+KMT9y+UZFoEXEMt91/fefj8Pv5o5SWptX6oVu3TqTxD6PL2/OKlrFvC+iWrOHUXYcpF7ayrg+aHKpmE3n4TXduVDRVGNrg4E74yQC6MesH7XcpNCXZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miEfacmteohOyFXoU7wzkcbAraQECufB1QOEoeQkoWw=;
 b=jspTl42/SSliBYWWSJFy7aczyB6AFVvwvQlMSh5EgDTKZyYuK24St7i7DGpui455cj+rnp2KmL85LmI0sd6v+QcLxxDJ9pmk8K5gDQsQkwv6e9J/NqzqjJk9TRWsS/I0JOe9S2ZTXTD9gDQjGMw7tHgf7uirnbhWmS6WjXTCzXJkzwSNbO7Mbwc2iOjAp94OuSEr+3VsHHlKVYpLoWvOjW3i9hmjW+N8uTnzGyST6acW4QF34NHqtNjqzDJMDdyyKE3dx9Bp07VAOGHXMdNa0GjCRxPqqoXzK3pcN1HjYzSt+TdArBz7pulOiJPIgv3G3T8WEKEoA92PpgnX7N+Knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miEfacmteohOyFXoU7wzkcbAraQECufB1QOEoeQkoWw=;
 b=rpMuTp3d+d8MLszmjL8ntbj59wliY7pqjsjndGlkNl8tJ3ouCM0HNSogJA7Na5l5EyD+yW7JQ37jSK/mb5KyRfpzXFltODDUZXprksKCjcfUeZvbRaAsh+M9INXHo0DIUSkdlJ8T9hONkJKum1CeSGUZHkxRl1DA6jibY4snZyQ=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 16:31:04 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:31:04 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] run-command: add support for timeout in command finisher
Date: Tue, 19 May 2026 22:00:33 +0530
Message-ID: <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 897ca38d-2e62-4386-ec6f-08deb5c40576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vf4PVODCH1KcFxoP3hKyp+35QF6mgvBlSUMIHerHcVb5G6KFC573BX46R+HklqOVcZWRVfg5Bny4n94Xidii70BkTGhHIssRuca8+Ovcw6IDnT4PbhDFpuhc1yJfy2nb2pEJuRYvxp9WowoSn8nOD1QO6T5SqfiIdlPuIek+WVUW84qqWhQUO5lg+AFWGvD1WOi6NCRZg5bzYKwWHm1S167Pdibcb+++CfO+IiKJqBuP5tIuPAcDQWFn37N3kp98y7sVCJ36QEo7WPG15YvJx5CUFZhMQGQXS4/JoXx413GS7pDZ1RoxkprNG1y65htjWHmjq18WZxmuq3myPflbul6XmWviyn+DcJM59a0/ZsnmiGH5yaI5sW454O6bSPq3jvyjsze2tqHQ2RAyG1cQtpcdEfYIk7pS+mLrFBFJrEHO2iWEfVvP0h1tpmhe3BlW18+zHvQU8c2nWEjQvDpWF44oaOUv7wU6srRj/huG4Wpmlgh2GovXX/TrRJcB3/cv2a4C43bHjoJLNFhBNJ/mGUH9A9BvxZ7Z46bReJgQ8zWXQNwxDj/0nIMOi6c1e+gscRs4g86YR3mO33cNXowVo6q1LqtW+4rm/MVomHzNMC+rBcB6LtJFMJylHEUUFifH2yy3QgWgcfkQ843X2OodeXYt+k/Y+i5E/agLczZDpPJmcuLJ3li52dIj8md2hyFd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8SeJiMFjDR7DJv5Byp9BDVk5wwv3rf8X2QfImF3buidxPKwtEPRyguDQvtzu?=
 =?us-ascii?Q?TYSj3TwmV300FDbl2dIKz7htfkZ+TOp36BaAFUCs9m7H6CjvE3vBMBXmK2ce?=
 =?us-ascii?Q?FwXUsBk0AYrfmSgJPeBeE3dRLHCbDH3NHq+i6g+V/GsFa3IuM7GlLjZaMF/M?=
 =?us-ascii?Q?M2RuP4yvz6Ye9UM+/oAuMIwCWrWwqrqYnZFwm6Th8NzvntJ0fn1GzvwkTj/F?=
 =?us-ascii?Q?wouF2Xd4XWtWOt+WFjZyQLwrM0GTl235h88T2OKzoMxDmlrHUt3A0fPf6+/8?=
 =?us-ascii?Q?ovEWRxLLCujAJnDhwsgkJ4Yb/HtJVp1TJDSJxQuu9a+ynzSAjT8i37aFxLaE?=
 =?us-ascii?Q?HnnnI+OU1ZE48cKPCMlFnPuxVXazHuBj98f01Z74q2geOOcI1Fq/DutkjdDU?=
 =?us-ascii?Q?GdBfB+I8FJ9qJVbrNC2aw6QXOL9wozpGFq1S2Bf/vtrJGByW16s77ahSnOPX?=
 =?us-ascii?Q?c7IrxGRue9JRLT6p+L77HEg0v+L4Mo7bMzPprMcpPKRK1xRWCXUnijMYLzC7?=
 =?us-ascii?Q?vY6qD27U4nirFxYtuNxm12/uwsT6fjQb+hT+1udCwY8nHWUCTvs2q9HLR7NU?=
 =?us-ascii?Q?Rq0RZSPyrjNWsRupT7bgCS4m0MciJrSJs22f4HzvpKB+A6D59uXs2zXhKFQB?=
 =?us-ascii?Q?KvOaMe4GlNK2EBP1M13QOUUUzz5nr6B3ql4v55fgROn21F60AmxH8BxW/V/T?=
 =?us-ascii?Q?TznVc+zb3ek8mElQegIiahFaQ7QGHPTSlFzhEM1pLg396tFpCqAp3bs5ytD/?=
 =?us-ascii?Q?e0mW8N3sBxx5ANrzOKZmz/YpnbkawCMKQTXsEwe4Eh+zJ0cZWhCJqtJLta/a?=
 =?us-ascii?Q?hPwuiTChLsQcOtmYHT3BIqPyORT1ixJurw+a9rj/YQ+7XpTqjVt7GpjFxo/d?=
 =?us-ascii?Q?8C4/sP5hJ2koO2TZ6kGuzw9hr/Hp27PZknGV0fgoUMLoFGLxOAyxIs6kfbT0?=
 =?us-ascii?Q?tWR8mHUr7vERxFOYPTWUjT/VjAa3xZqC3plyZ3IUAn++GbhbAD4aBxh0ZJI3?=
 =?us-ascii?Q?N+eoDxyc5dW+Z+9cxDcaeaKRiZ+sF4VRMJkABUJXGQVXzUbHTHsimLIvZzx/?=
 =?us-ascii?Q?dABbINHXPD2o4FkL3vmcUh084E1BLh8VTdUGH8qyOwfTZW4AHIxfTYBSavCV?=
 =?us-ascii?Q?8fyJyCWS5XVdqdLkqA1THEpN4vnLlKueoGq9kJoO2XgsX5NE+gaGFxkM/ALw?=
 =?us-ascii?Q?Vi5vrx/4c0+xzPdPa1J5EgyxpNaXoKCDeiTTejPg/8wdGgZ0XJKK2Mw2O/Cr?=
 =?us-ascii?Q?vonvMCXpkW81xLH9/rV9ZxtsdgY3wF5qRXm/NaJGUd/3M/9jY8AXzYPs1IVL?=
 =?us-ascii?Q?gd3l8BMaXIdu8NmPQ3RHs2mJ8FCKWwc0VeuxZbDRAh5JpPfj/pMnhz246Hfi?=
 =?us-ascii?Q?7zeS84TBxptzV6Z0wm0icQ0l7RXBt+MGOiV+KpCiQs5IzGLdo2HNlNSotPRf?=
 =?us-ascii?Q?oFkqMFHWrQUO5tOigWzh8iRNr/sb/hjbGGRxCuTrBJCuB6d5TXehDNq1ZcxP?=
 =?us-ascii?Q?fR/ryMEjd7KPIFfDbgpR5upgMhthzR3lp1xu36VM0qhgJAbM5QATf7goGZK4?=
 =?us-ascii?Q?21Tseo95uM4vmW4HaJ1iWbgwPrK+QSdeE+p/7SoSAbyoJywgjvfvopAcE9kN?=
 =?us-ascii?Q?k+vHxUCbzQSKoQjPqxAtQREgQMteKRWJnYjxIH8BZSQGlMg/g/kDgxKuFlA8?=
 =?us-ascii?Q?/rdOgA2g5UBHLFfep7NZzZ1n/KDLxJWxQZMqN/sliy0UvxZ7sQxqvYiwfrK9?=
 =?us-ascii?Q?yfwNblpUZwBEUs/pZM3rZIv21khwbyyMoIrV5ypBhDCDfu6xdgOdf92bxSXP?=
X-MS-Exchange-AntiSpam-MessageData-1: RhyfgI+0ynexYCzcABsuus2TRzH1kmwwvj0=
X-Exchange-RoutingPolicyChecked:
	WNV82EhRl+5W1cBLrKMYRzi40xwnk9w2i+u64RzU6ENkrFmx383dQDAHVbcjhw3Zq2D2kzbGvTfsF7qj4iwODT5tFSx6ObLsxl9k2e7rqaOGKAdhiX1EOCAbBCzbBhyiw7OZniE/fSMln87/dPrZbz/DFkJPke1vTEmwC6FhCXELeG+mPiOsqdktWb0iwru/n34AFx3HQyIL1XQEzSUU7YN2GeiIwBpLB7AQt3f5zcdTOgO+wjPSQe9c5il6sh5L4gQIvSnHretB6zHQoKex6EBBffazUzp0h5sVdQLUTPCE2P9m3Dgm8JY5hlSArZK0xRNfVlX5z6R0JJtNX49Qew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NWZNIMnAm4/Ys5+yK7SqiYBBU1ugXEzYW7UkZ550Wfb2Yu1+Vv8w2bbY5xV8L/7/aK8GbOXjlLF0sZ008ZRM9gQ8BEReO4okSTiYye0GFtqFWIlhueUZt9yDb4nVpT5LguUQmUAlAuu8gZWtfk+OJbQed+u9fcAS3GOx4QmLqY+UsK1hF/LH1f5Xg5ry1MYzIITPwiZ0bW627ZoHh6Bs8WVY8rOEvWByuAICzrFiCTTciI2cgZzIOVl65hTbH1Ynahq6ph53hu3HD8T3OdUYS1vG0s3s1CENu5Ow+Gyec+eR0JPoK2G+D+pxYRgYb4P7QZvZw+pqOGAfkesCUsusv86HLdSjk4n9kzk4lVJFof/rGRx2A+7ciSJEWUxV7yIzjc49BDrmOQ1oHaN5xFG0tuOYUJzqKw23KkInMZqPC2hOcIhRtab2qiVSJJTS9VrobRHoCxoCNR98uKFl3EwI/hwz87YmPLyWUiSdZXyea4aUaOB/xnLJEdjJP1QgRooEPAVki4213zt76MzT+CKPFhB4GCQcDB7tP/APyuurNou6thRV28fpikiEDhX0Cu0KpCzfWTXrL91RZyLA93Lqtk3ZXLLUgTeyWk9cYre+P64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897ca38d-2e62-4386-ec6f-08deb5c40576
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:04.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7bjVQy15RXmYzl3NCG4XuR/wqBTdntnAo5H9Fv38Mhi33nuMz1KZv5fSkKAIN+RhWeZefY0kfsfaamoJmnopaPDlTJc6ljas/OKmHIEQco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Proofpoint-ORIG-GUID: UHPj5I9G_z_AAfjbDfZ66vVCGEZxeB2c
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a0c904c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=0tnfI2DNpDxUHnmf4JoA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12299
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfXyxRsIfYZi90S
 c607GzPj59Oz2Q4+RdWuQPG0SOqlJ/YhKKHJhaEAxVGijA5E/kChVSwuWgNYtzpkNxxk3Br+MUX
 bVZ/n78gJJdMTQBwc3lCnLfn6SZ9LSzWZbkqnwS+W5bZz9r7aroFWCTukEfUulbF4UqhOKowKoA
 Gfv0S8cOQ4HhVj1gxFjQrfW+g7ir9U/Ucd8+b/m1VXeikCkfrtEyUG1fDCUZek5Qw+slCpWskJu
 NAnas1UdbXDeupgAvntnc6UsjCh9gJRA5nzivD3IeAE6Jfu6fJrucOM2WNUwBniEcHXaPpLFdlZ
 9TdsselYaDwfp4fz4eYdo2F1NWjojF6gJRZpvZ5OxyA3tAdtqTHW4/hVHJNR7uhoXG5Rb+dkza7
 wHl9puHVj8kDvd0uDtaQSBD3N4t+LLADvEklR938bSA97IDOl5v3MtWxgs0sz0NQsF/0sU8SdAc
 r2OYTym7s1aOvLUGmV62czrOQvCwlx4yRYwE8gLA=
X-Proofpoint-GUID: UHPj5I9G_z_AAfjbDfZ66vVCGEZxeB2c

A called command may not respond to the initial signal and will get
stuck in finish_command() -> wait_or_whine().

So let's add timeout support into the finisher so that if a deadline
occurs, we can send a force-kill signal.

The force-kill signal is in the argument because a program may trap a
signal, so it is the responsibility of caller to pass the correct kill
signal.

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 run-command.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++----
 run-command.h | 13 ++++++++
 2 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index c146a56532a1..60b84610d1f0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -554,16 +554,63 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
+#define NS_IN_10MS 10000000ULL	/* 10 ms = 10^-2 s = 10^(9-2) ns = 10^7 ns */
+
+/* If timeout_ns == 0, no timeout happens (the timeout path is not taken). */
+static int wait_or_whine_timeout(pid_t pid, const char *argv0, int in_signal,
+				 uint64_t timeout_ns)
 {
 	int status, code = -1;
 	pid_t waiting;
 	int failed_errno = 0;
+	int flags = timeout_ns ? WNOHANG : 0;
+	bool timed_out = false;
+	uint64_t deadline_ns = getnanotime() + timeout_ns;
+
+	while(1) {
+		uint64_t current_time_ns, remaining_ns;
+		waiting = waitpid(pid, &status, flags);
+
+		/* Retry if interrupted. */
+		if (waiting < 0 && errno == EINTR)
+			continue;
+
+		/* Break if exited. */
+		if (waiting)
+			break;
+
+		/* If no timeout is specified, retry till it exits. */
+		if (!timeout_ns)
+			continue;
 
-	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
-		;	/* nothing */
+		current_time_ns = getnanotime();
+
+		/* If we are past the deadline, set errno and break. */
+		if (deadline_ns <= current_time_ns) {
+			errno = ETIMEDOUT;
+			timed_out = true;
+			break;
+		}
+
+		/**
+		 * Retry after a sleep(min(remaining, default_chunk)).
+		 *
+		 * We don't blindly sleep for the entire remaining time because
+		 * the process can exit early.
+		 *
+		 * The subtraction of uint64_t is safe here since we have
+		 * already established that deadline_ns > current_time_ns.
+		 */
+		remaining_ns = deadline_ns - current_time_ns;
+		sleep_nanosec(remaining_ns < NS_IN_10MS ?
+			      remaining_ns : NS_IN_10MS);
+	}
 
-	if (waiting < 0) {
+	if (timed_out) {
+		failed_errno = errno;
+		if (!in_signal)
+			error_errno("waitpid for %s timed out", argv0);
+	} else if (waiting < 0) {
 		failed_errno = errno;
 		if (!in_signal)
 			error_errno("waitpid for %s failed", argv0);
@@ -587,13 +634,28 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 			error("waitpid is confused (%s)", argv0);
 	}
 
-	if (!in_signal)
+	/**
+	 * Signal handlers use the cleanup list while reaping children, so only
+	 * non-signal waiters (in_signal != 0) should update it.
+	 *
+	 * In case of a timeout, we keep the child registered since it is
+	 * actually not reaped so removing would be wrong. It is the
+	 * responsibility of the caller to detect the timeout and do cleanup,
+	 * like sending a kill signal using this function without a timeout.
+	 */
+	if (!in_signal && !timed_out)
 		clear_child_for_cleanup(pid);
 
 	errno = failed_errno;
 	return code;
 }
 
+/* Non-timeout wrapper for compatibility. */
+static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
+{
+	return wait_or_whine_timeout(pid, argv0, in_signal, 0);
+}
+
 static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 {
 	struct string_list envs = STRING_LIST_INIT_DUP;
@@ -989,15 +1051,31 @@ int start_command(struct child_process *cmd)
 	return 0;
 }
 
-int finish_command(struct child_process *cmd)
+/* See comment in the header file for executive summary. */
+int finish_command_with_timeout(struct child_process *cmd, uint64_t timeout_ns,
+				int signal_on_timeout)
 {
-	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 0);
+	int ret = wait_or_whine_timeout(cmd->pid, cmd->args.v[0], 0,
+					timeout_ns);
+
+	if (timeout_ns && ret < 0 && errno == ETIMEDOUT) {
+		kill(cmd->pid, signal_on_timeout);
+		ret = wait_or_whine(cmd->pid, cmd->args.v[0], 0);
+	}
+
 	trace2_child_exit(cmd, ret);
 	child_process_clear(cmd);
 	invalidate_lstat_cache();
 	return ret;
 }
 
+/* Non-timeout wrapper for compatibility. */
+int finish_command(struct child_process *cmd)
+{
+	return finish_command_with_timeout(cmd, 0, 0);
+}
+
+
 int finish_command_in_signal(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
diff --git a/run-command.h b/run-command.h
index 8ca496d7bdeb..cb1c8ba4ec01 100644
--- a/run-command.h
+++ b/run-command.h
@@ -215,6 +215,19 @@ int start_command(struct child_process *);
  */
 int finish_command(struct child_process *);
 
+/**
+ * Wait for the completion of a sub-process that was started with
+ * start_command(), but uptil a given timeout duration timeout_ns.
+ *
+ * If it has not exited after timeout_ns, signal_on_timeout is sent to the
+ * process. We don't enforce a timeout for the second wait after sending
+ * the signal (as the process cleanup needs to happen), so it will block there.
+ *
+ * If timeout_ns == 0, no timeout happens and signal_on_timeout is ignored.
+ */
+int finish_command_with_timeout(struct child_process *cmd, uint64_t timeout_ns,
+				int signal_on_timeout);
+
 int finish_command_in_signal(struct child_process *);
 
 /**
-- 
2.53.0

