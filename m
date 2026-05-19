Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B12EAB6F
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208254; cv=fail; b=uUU6IsbXPfqf4JM0bFlICCzIXaNNV3S/eL/PlpM5c2a9jzNCwp7bQ9Fa268XXvUNZiGBNx2Vc2ahu52+2Pa9jTGMt70WMad15b2CBlwSRZE9SSrdb0/jnnuzOx8DEsRSldbiYGjHS8ydwwwgtfZPW2jey3q8NoM9MY1Q4MOwukc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208254; c=relaxed/simple;
	bh=f56OCAvC5m8ZOyrpYYeuQKXegJarGbx+Sh17KfRSE9c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qOyCFZrAymM5e/HPmzoK8jD1Si1Ct/J/L12eIGM/2xk2jh9wro0Q6poplBbbucum/tzTWvWsHHBMDcGA/dFYNDb4GPa9KLuvNswkesGXPmv0wU5HJ6GBm3lx+9c/nfwWutAJGwf6ygcX4ieLS+cHEwlWrN9p2+x5h1d4K5rp/0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F9p5u9TP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WNWk09oP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9p5u9TP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WNWk09oP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JGCUcb2414109;
	Tue, 19 May 2026 16:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=+9w02W0Z3Nkmt02e
	xabmnCcu1asfZHtdU0f9+C1gZS4=; b=F9p5u9TP7HQjjMV6cA1Lv5pj2j6TxRXK
	lgPlHt1xAjbUhS71Ibgw0gadpvMkom2lY/o8P+0KDZ6BBCbnt12ZwrVjtFJltz6i
	IqcznocyuP/6A1c9gO3wfnoUFd8nQWEkLluCDcHhovkSrPTG6eIcyzcADVrUWpfu
	uqvaL7elDQGGzwiyDY9fcEPfc8fkFkhvnoVvGPhoC1ybnzisTms4ErGBY01T4B9l
	GOKf0X+gygxH96hO90kDz1vrwdIPDxTKNmyiggj6SwOokPdF0Lcmw0ry0xwf4olH
	JUu/TUHYyPN4WVhd1tOxKUopABkOD4K2POF0gTI+nX68nXek2h7Csw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxww07q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:30:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGTkOP019003;
	Tue, 19 May 2026 16:30:48 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1b0emv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:30:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAb0TIvx8MwohPxfZTNzxApT4rMIDmc6Ri+4XpV9r9HVmsgydRkIhcPfKoxWOfsqQqIGBXQnvykLu0UkBtaW9ds93QzQH6eUA/7syCp+/MXu1taKEWlqKaUa0F9bYn6UDlEsh2m3ejJK6veg/Lxty/fiUTOeWa6o6ddDswZxZmIPBgLSHwkubTyRv5GyrhdYgNOuj80FMR3yznXzQEFY8Ng55lmX01DR9+ejwyZMIbvWgOdYZ/MEjDOssQIVF6ImgqanV+NN+bxkHpO5Zxxqfl03N7DcwgCjKP1iY+1IfED17nX/WCM9aCReORaGhY3yv0Dezx3rUmzEj4w6KUiR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9w02W0Z3Nkmt02exabmnCcu1asfZHtdU0f9+C1gZS4=;
 b=hLl+qln0Tl5NsHCp2hjLJIjveFvH1IGDgoHhLcOsh+pDLzeAocg6ULWZotKBQD8+L8tMO8ZDaAdv5uxdwv1a/eswE8ICIBmQrmhRWaDlRYtbVYVyEt0JLGmnZUUcTCX2OBvy3WiECbAWlTE1vl2iJWtGOuSrUcLD3cVQy4I+IckbtfZLt/jwh3tKGk0gk0w0zKO4aZr3MiXqteidZXcSIqON/zGlmWQs+/yyYc/2TszwE2Cdic/OCH86u3Ewx9LYXoGtymkPmQT3AB8P22fp/4y2rlC3VA1E/JoRTjEXXpB89ClAFG+C6F2cO/0qdJOcMWWXq11Pjh1Q0TYPNMTwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9w02W0Z3Nkmt02exabmnCcu1asfZHtdU0f9+C1gZS4=;
 b=WNWk09oPOenPzR3nkUAX8RzlwwdPSNGa0pD4dAzOz5f74rFPS0Nt3Klt2sSvRx4gfKhs+bW16FjCxOuXv17PXZJ5kRNzUer6hfInlhH1ujXOhIqTl/Zda+MVzIz6vGhd49N4kCMRptKc4I4ygJMhvE5tXnZFnen50XO7edZ7c9g=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH5PR10MB997756.namprd10.prod.outlook.com (2603:10b6:510:39e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 16:30:45 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:30:44 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] Add support for an external command for fetching notes
Date: Tue, 19 May 2026 22:00:29 +0530
Message-ID: <cover.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH5PR10MB997756:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d929a5-9828-4834-1c58-08deb5c3f966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	ax6oY9JAObSAqg09YOXRiQgqP3Yxo0HhKXvLJuttIrRaL/bT4GSYucxK5Kk5XiFDZBLuYGIXkvIuQ6o1F+C6hX2l2D9JDHTBTgVfWgU6rXqHs8cXOS4c6uoR9Q3InXagMqvk96b0YGQDJOHlLL6biwCRTuMRnoe+8jzs0g6it6dXsl1RgqDs0009sxVNEBFJm2X++UfdVW14ul5YrLA7SDw0bD5KB+uzrX3GP61q4QeHSgd32SeiBVDzfeuMXv5PmtV7AYhcHfhaEQ91vI0tyy7N4IIMsRq7X+VXTv5gzc/GZw27tPqMX52lhiTem7LGbPudcHWNkGs84fqFQda32jwd1dOfyRTyTXoLGpTCDssezlqoyx/HXLf9d192NGJhmPGcFVxFDstYpGc+tSPmiT883NW6o9M+NRzn8rQto98QDauxjLc4rAoynu/aeqa40N5f56OliQbhxOohAhDT5Vr/mnKn4SbHxKjA00eu76TsBgJf2q13R+Y+VxNG2HhypWMnFAK3VypDItfQc6ZICdSTyiBunZWmkpVXW06nxOtnsxuiTH9Lg84BZO6FYQROUctmPutpTx5LhsUKAbRI5zr8pkkpfrVQc+dkZPV9nJL9rxmMO2xwfSuABuURFt6vGzj0TRuXVR1pzwAwmqxh169tupaoHdRO3DZxr2oo0cfESNYAhBKL84e440v5q/Fcq3z60nsrwPOjtMRVYCV+3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvNEiGSM7KweL1KRaS1Criak359dJYJHaYj5WyLI9tezGdz8aT6NmOReXacl?=
 =?us-ascii?Q?kYbtAev0pybe/kPdX4XcOQOQfK387S0TzhXYK54ilF/t7lcAS52+qf6eW3xh?=
 =?us-ascii?Q?qjlk5qG81+a2Peob3UpQHicQ2Y3xTZz2eZWHgy/FLj0io4WrFSLYZExmRlwU?=
 =?us-ascii?Q?TGghWUUeeDoBZNf/7vDSW+ktc0SXQmdLp4J1m6YjZV+qOYS53BFhNLCJE3aU?=
 =?us-ascii?Q?DWKzebHPS+Cn2xoHNgfR/zScN/g7UIaKkSPvADQABWVLGzsH5oCk1M/Sj1C6?=
 =?us-ascii?Q?u6kK91O4Ig4hwN0MMMbIrndlCzyfVN6hbkXpExC+s1sfBH/T1zDstDVpxZqy?=
 =?us-ascii?Q?+Dr3M4N5hSVkPNjPgWNSz5VTlkSSmlMIkICZgRB5oEWM7hN5bWFhuioVZCKn?=
 =?us-ascii?Q?vwZoJVcAR/rYhMZWQNGHVAQOZFLWrj3yLAtj8Mi34xuVTyfsfFgZiyKdQe7E?=
 =?us-ascii?Q?j5XAnnZTrP+7xRk3UZLcYFDIbEZSrFCbJ2/m+NEKljptC0On75MeQEdN0wd8?=
 =?us-ascii?Q?tK7+vqGSDfofbIUffulnnaTvsvYq9fUm7QG4o2sc+IGGWfOP9HaW/wVX1fC/?=
 =?us-ascii?Q?hA68BnvOsiKBQPmpp0ySSP3MPtKBlVzSIQ+3ri/o8dDpZjbEZulEwMd8XzZE?=
 =?us-ascii?Q?zhSQwLuUUCFemamsnfv5egd6Nlz4jsFXVFbXush/b8j+5ObYvgJNzvMzogKt?=
 =?us-ascii?Q?A7UMVmxkCP3L0DZJy/2thSoqieUFe9JX9wtMUcMIJTc+ynbEwqUBB5uAtzZ6?=
 =?us-ascii?Q?w2F0gr6YEvtihe2ZibhoV9rlLLkKx7ukioBK90DJ8Dh8Du2MtjLcmuwDT6dM?=
 =?us-ascii?Q?Wxe1+jk2iQ2njFq0NiQF3KvYGjeSy/ICdWoC1LciA5C45St0xFsBoY61an21?=
 =?us-ascii?Q?wB96qPrVf5DXFzr6kgXWtzfMR9RCRWOLsHQie/qBassB1c0JrCBs4okF6sE9?=
 =?us-ascii?Q?7vS6PPt9cAg0L/as+1ZIfZNhlcPTgLcYB84fmjm/234K7yY6sdD5kDAUzGmk?=
 =?us-ascii?Q?fJ0cNFCdLUhA77ZANatGCu8Bj5p0LEVsu72PPodDHJ4et1FV8leMNOjlkrJY?=
 =?us-ascii?Q?1CIosZg7wS6E5x68FL/eaZM4m511qrmUZ1C2VM2q46sXQO2CJGYpJqORlbPl?=
 =?us-ascii?Q?CNL7tyad2NzqFfz1X9fnbAjcdg2Tq0b6JkYIL7rrKtCFw47ng3lN3/vVvTrG?=
 =?us-ascii?Q?IzRJ/ZLT7ShUcAh8UBARQO7vDxpoz0snv6xSG7Hel9Oo6fXbm/680p9uc4UQ?=
 =?us-ascii?Q?cXJ3lzxEp7IHu8aSTxmVEWyTCMZrfRH5TUmc6a6iYa9v8hcxeYd9mBimnWic?=
 =?us-ascii?Q?5eJcwVEperH1sk+IGU9FCw5M60fCLOvVif2bkz71bblNtPyJltd2DKKGzwAG?=
 =?us-ascii?Q?251y8ou5qhuVYz4mZJn4B8suCweqE1RFgJyPnMDE99V+z/LZelZpCRNHeW8v?=
 =?us-ascii?Q?c2EekErB1nz8odBRmYHHBTJW4I9Z4jN3zAdApSaBdh+QMrHteeUvUr/Nzsh2?=
 =?us-ascii?Q?kDhNKHVIBol5IeWRUGZO2sKXn8B3xd3oQ9kpeJfV5iJYdphqzbpI23znOyVY?=
 =?us-ascii?Q?BHjqg49Zt6ABmwM69jJokO84B018ML0rth4ynLnMRMndfb/ANNa4KzeOUm/m?=
 =?us-ascii?Q?louUEeeXfza8RkOdV22jP1a4dxlJnQLotQOR6cHQ0YwfE1CMa6svNLtrZSE9?=
 =?us-ascii?Q?UZ0+OnUt31zBLWywFpYPR5Hfbsh+yBfa4eMTLza71JKYA68s8DueBR+ukMBT?=
 =?us-ascii?Q?bBf5Q1p1FxDOerqa7ilhwkA2yplhf6Y7l84IpqgDMO2e3CstnqZKnM8GpnLR?=
X-MS-Exchange-AntiSpam-MessageData-1: 3y4/01KTvdbLSaNPPjMysJXN2jGggZLlKx0=
X-Exchange-RoutingPolicyChecked:
	PFRBF3QXoR91gpOdDu7OEAXjQoWXIZrY4reiEgLcph6zlk6gtRVsXtDU8XYiWrEkeK1jKEsZZBjC85+Y/SyCSTi7rCUv4LVZKCaSpTDyomtII9X8MykKOBnddZJBx4rXHqGDVahpx1fCo538F9QhIsjHkrY8lHaaS0MsTadw1eB/pcGzFD6sxsJkHsabMkQ0rnKsPGFmcO6UmBIw3Kv9Ad2ET+l7agu717ZAXqjV2UZsHVpjIAYjxBl9KvGsab3W73MV73IsNxfzI7gJM6ZBcwdDGe0p6us/Go2V8jQBOqAYKSirRVZUkVFqeHDUiezL4dslEf8hFHDqq+f4DUlgew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4OIJSAwStMD7Jd5Gyof/amLqmIzqsV4aehDl+ki/LIgTEA6O9NSAiLmDBbPu+P6eNIripTYC6ivL3FYc8DKVEYLJvGUgjhsXtd4BEJ93p/zrU/KE8+wSAt8HIERZGKGteQaKxbkeV+YQYC7Jb8vjvUuzo3qoW9A7xqK24GXnnWyt4/PVFQsZuP4Ys28v8ZnOp7uEgGycMUmQ/Fkcu7nqqACLYKmqib3nxN5vlCcIFmJyO41XwGXztBg9LIThgWMTVAFac1FcSfdHjCmr//pZok9eplH7zYpiWaikVCvibfd7tYA5vZpbump2oK3QEedG/nndbjuaIJzht52tQdmB/xJOlSo4Bj3+LiP50jIzErzQHlmTKTLFX3EbeyDIfciikCC+pZVo6sCC4lb5fdJhjGc3UXT1TUhkW08sscyHnenevoK4nGtMTuqmscPMrtxoSdx7XrRgT0gLbGwKiWC7Oo6/CeS6lTVmYoRLsRUEor83L6MNs0vUaB/yJ0a8HgjCX8xEOkFgu8BiVV0Ng+cGLTsW/ZZUaSqqRJZbKbglg3x88oEsAFFN5gZGrl9Upl9HPcAsyVwgPJ8yJRI5OCnAvSRaNWzyni1yck8hBuR8RRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d929a5-9828-4834-1c58-08deb5c3f966
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:30:44.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qo0EIS+O7WDbpO2HsoumfKtabQp5UGGrTDdqhb0SlPQg5VMTTkD+0fWC/HNZxtT8FMK8EbvFIPvCkNWtYg4nH393vtzF3hUTjInelwYyIsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0c9038 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=NEAV23lmAAAA:8 a=WRypXAl5eOba1LDCZDQA:9
X-Proofpoint-ORIG-GUID: L_2_x0CdNbMC1ANM6G_zZ9bvytuL8k6o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX1huwhzPTLXfu
 HWeCGdB+XmW4oyohE4VIYbMFuC2YFUEjiyBOt19yZOefFNqUVdM/LnSGxSduD7nX0f1Rg4tN63u
 90KwPpSPWfGZxQLQ1nbGxw+pYlSlu5M7eFVuPwg4Xapav5Fffp3g++ttI/KFItKGdzumbG/j+23
 JOJLFUp+Fy4H+YvrqL/el7V6/UOfG7czJlaZaDz6V6AXxneq/TyYotCH/4ds/SuM9TQsTV14jWw
 vSC2wjeN0zfPYQX4UjdLs+Rs4aCKUZmCoMFL3nl7OIYeOPfQagIi1XyBaCEh05KB6cNE/IV4ZPk
 Dn0AMyWV8Yt6O00uvPvnsG57rvbwLcZUOtWjRAElCC6s63WHxqSagVl23PeEsPfMIkzCGtAF0rA
 AVkcxTKQkwcWDL1JeDPA0n/+jYAtzww2gcdv3q9VLOXudxuyQrfKZkkeAXO7aTTrdCYKJ1fTAda
 0lkntkhBBMpV5PAlYvQ==
X-Proofpoint-GUID: L_2_x0CdNbMC1ANM6G_zZ9bvytuL8k6o

Hi,

This series teaches the notes display machinery to obtain note text from a
long-lived external helper configured by `notes.externalCommand`.

The motivation is mentioned in the main commit message (PATCH 7/9).

The helper protocol is intentionally narrow. Git starts the command once,
sends one commit object ID per request, and expects either:

	<object-id> missing
	<object-id> ok <n>
	<n bytes of UTF-8 note text>

with the documented trailing newlines. The command is read only from protected
configuration, so an untrusted repository cannot make ordinary note display run
arbitrary commands. If the helper cannot be started, times out, exits, or sends
an invalid response, Git warns once, disables it for the rest of the process,
and continues without external notes.

Users can control from command line too with `--external-notes` and
`--no-external-notes`. The semantics are close to `--notes=<ref>`:
`--external-notes` implies naming an explicit notes source by itself, while
`--external-notes --notes` combines it with the default notes refs, and
`--external-notes --notes=<ref>` combines it with specific notes refs. The
series also adds `notes.externalCommandName`, `notes.externalCommandTimeoutMs`,
and the opt-in `notes.externalCommandForGrep` knob for installations that want
external notes to participate in `--grep` matching.

Because this puts an external process on the log-formatting path, the series
also adds the small support pieces needed to keep that boundary bounded:
timeout/deadline variants of the read helpers, a timeout-aware command
finisher, and cleanup that escalates if the helper does not exit promptly.

Testing: https://github.com/siddhpant/git/actions/runs/26107938855

Thanks,
Siddh

Siddh Raman Pant (9):
  Documentation/git-range-diff: add missing notes options in synopsis
  notes: convert raw arg in format_display_notes() to bool
  wrapper: add sleep_nanosec
  run-command: add support for timeout in command finisher
  wrapper: add support for timeout and deadline in read helpers
  t3301: cover generic displayed notes behavior
  notes: support an external command to display notes
  Documentation: document external notes command options
  t: add tests for external notes command

 Documentation/config/notes.adoc             |  57 +++
 Documentation/git-format-patch.adoc         |  11 +-
 Documentation/git-range-diff.adoc           |   8 +-
 Documentation/pretty-options.adoc           |   9 +
 Makefile                                    |   2 +
 builtin/log.c                               |  17 +-
 builtin/name-rev.c                          |   9 +-
 builtin/range-diff.c                        |   2 +
 contrib/completion/git-completion.bash      |   4 +-
 log-tree.c                                  |  10 +-
 meson.build                                 |   1 +
 notes-external.c                            | 330 ++++++++++++++
 notes-external.h                            |  19 +
 notes.c                                     | 244 ++++++++---
 notes.h                                     |  32 +-
 revision.c                                  |  32 +-
 run-command.c                               |  92 +++-
 run-command.h                               |  13 +
 strbuf.c                                    |  26 +-
 strbuf.h                                    |   4 +
 t/helper/meson.build                        |   1 +
 t/helper/test-external-notes                |  64 +++
 t/helper/test-notes-external-config-reset.c |  20 +
 t/helper/test-tool.c                        |   1 +
 t/helper/test-tool.h                        |   1 +
 t/lib-notes.sh                              |  19 +
 t/t3206-range-diff.sh                       |  68 +++
 t/t3301-notes.sh                            | 461 ++++++++++++++++++++
 t/t6120-describe.sh                         |  17 +
 wrapper.c                                   | 188 +++++++-
 wrapper.h                                   |  24 +
 31 files changed, 1702 insertions(+), 84 deletions(-)
 create mode 100644 notes-external.c
 create mode 100644 notes-external.h
 create mode 100755 t/helper/test-external-notes
 create mode 100644 t/helper/test-notes-external-config-reset.c
 create mode 100644 t/lib-notes.sh

-- 
2.53.0

