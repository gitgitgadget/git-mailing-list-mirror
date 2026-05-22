Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAC2EDD58
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466254; cv=fail; b=FhPFKRmyL+rjkKR1gkEK20TmtjpLOFnnzYgGhKAzqXPFs9kXhx09IK+9Ys+J6u6VfVoMzNW1GNXLfxjySAxaYEAFwTZwz1OEQYew6by6pkXiTkonjDvmAEhfwNyiUnk8sgE4PbrvQzt2lODqM7B9I2k7QEW1CpbqcavfoDVnR58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466254; c=relaxed/simple;
	bh=lCaBe5qJpFeSnHlkIECzNn4SlDrfC19xIoxZcB9cY4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGfh979g+S2Zog18biTksNH9tkNjIPsZkryOetT3YOqrUOzrrFPB4uXi/9113YDJC9HlYM6bWiLqXzuguvdycottHBUq5uxGCsZhA/Pr2lF82bzWLEPkRjrkoixFUMJbWs8Yej9XpOhJeTC2uEjhP4cM8jZJG+RlY9xP5ctLm2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lxFHmUaY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EvZXA7gD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lxFHmUaY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EvZXA7gD"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MD6fmQ3300693;
	Fri, 22 May 2026 16:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f5ywQv/rhsuqZeCDhqjC6WU4EZvQgW4j0cWKvbHLEzw=; b=
	lxFHmUaY1PnWE4lW75BzjnB9cpDfXU7Bnx5RSXhdiNkCs5F0g5OPQlX9VDOYgqfj
	rZOErCqQgA8nnwPgtoKmTAEPc+5F8K7c4kjNvpBGs937H25JmRrQs67k/OqVpJzr
	EJ1vPOFvMCLhUWigbuDvfK/qBptnofH7i4+YCv00skBLWoWLm6RqrVvS/pEHBBoj
	p99Pq+gme2ibFfTpUUYX6RG+DWgGtqvPMDIJkDy8//T6TvIbJ7DW5Uh10ZLeQhW2
	+dasul4wumhjpXShILRNkuX41gHSOs2fhh88RHMWuhfcEax8Pju8b/51H+AuJulp
	vka/R+Fe+FcQ8J2xgSGtpA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2sk3ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:10:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64MGANig026158;
	Fri, 22 May 2026 16:10:40 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1m79ne-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:10:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC9dc6UEq6CThDYPUdBm1ZFrY6zZAlwU5YZgysbOeZMfLzanL+3BhJlGY9NflqZsQyNpaBD8BygLAqaHPZC2BMZATSeAuB26tnSse7jtWLAVMUjhydZU2+LXiE5b4ac4Z4/7m46X5+lylD+co4CByDBMuSPzadjmOXpPuDMgQTouhpw7Rm1ppgihK4zXByThgGw4DM1DsBmirBxNw1tg9lFwW3Ai8qwajV6ReiGJUPS27EY36xsTHBiUdTqlUU4500T4gHzb6lK/teRx98cYZiqaRbcoyDAltnWWvazvK2oSPoGQ3UdQtnlmdwSM4m9eggV7QRsjd+l2M3qWV2pF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5ywQv/rhsuqZeCDhqjC6WU4EZvQgW4j0cWKvbHLEzw=;
 b=l1L9jOjvTGpBtdQYmMzkmMdUYElJdQJMAQfcHJjTmx+ARccpVwvcrWF44vLrB9jRYnbLfWJQI9BMhK+p+PTbXS1In9Jxsq5qRM1u9tgqKX+H8zLtkmjv60b4/dXfxfbXykF/qkZTOtVPBk4/77kmoChJH+5k0TSG+8YQqloCcFB0l6d9myrYZtY985IJv7yRn2f2dT7fImiAl/D640x3mi2g499BumdIcEa3oke3HfmBXJqkStR8VQiziishEKtroKNtCM0zKKdrt/yox0pyqdSUgL8haYwMylNerfaPdTuj/DWqGXu2p6rkj//2QNOY6nsNPKsjRdR2ULpg/+Xu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5ywQv/rhsuqZeCDhqjC6WU4EZvQgW4j0cWKvbHLEzw=;
 b=EvZXA7gDsMvKBcLpR5t/cd4ThncPgCiDmgLR9C0xGkCoySImaMQGvA7u1odbBGnPknx2s4zwna7D+dg0opEQMOvxR9zh6ydocYn3Erh4C5TOd4SpzCERnWogYMRxMSXuuAKGTRGTGgCgAnqyNIYIF5Nt6U9DNI8Bt4NiguKrPv4=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS4PPF18D5A7206.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 16:09:57 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:09:56 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 2/4] wrapper: add support for timeout and deadline in read helpers
Date: Fri, 22 May 2026 21:39:36 +0530
Message-ID: <49efc097154be9f7c387ecbaafcf54e612028d9e.1779464886.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779464886.git.siddh.raman.pant@oracle.com>
References: <cover.1779464886.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::10) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS4PPF18D5A7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 647ab8c6-2c47-4005-e9b0-08deb81c909d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|3023799007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9bqjc1WEnKEhaduT31TVMl3zfBrzjEhTCoYNhhViEGtvZF7FmJg1jzP4zw9UtSJcPuWjLsXLiqXPeF5eBMApsn08vqinkbxjmrksJx6DLEmFEorzPa5D6DQOdoPgJrI2LbzeNCo3yGCwNd69pz7O8epmAFN3XnRFu7H0yliXoshbCk4q2RJ9u1r6UEGi/y+w0oULymK/o3RhGDgsDZ06YPYgLj6qhYdBQMlbTrmJatrTSgWhnVwh1FNEHdyBsjiXVMbrvh2rOyGoTj32qL7auCbGV28WLvKdRXT9d6muSgFBlhK/Fpb97aNlSUTV6ve+f56GRClzup4A2Y2fw9Fft9Ho0yjN2t0o5tu+E7hC70d05IkKADsnJhwITdZ8ld4AZ2UP4BOGvhfkIAcAt0mSOsUzZSfxDI6C4WS/XkTGmACnr+tF21qjRd9ijVI5G7r2Q6QIfOq0lHXasu/2mLw+hEJ7vuNHHcArb0jIAd45YfH63NqzOJF+focENkp8lAsG36/6qWYeeces3YqWEExeDh8tKVP7Q/sbbV4wt6yz13Fspqkyb3xwnHyxyiz5HHmx0ns4d18v/Es+/ahVKVmGfIQ5wjZnp+FqPMjHcSokl0rohrBsMJOBcmkGFtDMfsVpDBZ+N5n5lMhVFviMZKP/swslvoaw64PTNchzel1/QsFExadlfo2v6LhDCUpjiQhA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(3023799007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EW0XbfUC2oBWUvCqZX6UhEVtdiw9sJN4+SvQA/NlvPHTvXpPMLEetSIu3r5q?=
 =?us-ascii?Q?poW8umkh3P9IVgE/+KFf6azRLDP8Fjx7RItuXSxaG/BCe2w8cKrLTeInapfs?=
 =?us-ascii?Q?6VSRd3NgH36bXLpMf2pac4mLx1QmEx+NCK0ZqKdGpOwp9I2aWbnx30y6xAO8?=
 =?us-ascii?Q?kg/SI+Bxr6zbab2tEuwSgXJ5JSLxTEHsMxzcVOT1nChDT4G5a3QuIAAmnD1g?=
 =?us-ascii?Q?b3BJypKDvOXZC9h54h9Ud8GhAv+oHYF4IWvhe/CNmZJB23qOt/dkgFg5r0oM?=
 =?us-ascii?Q?5wkMYSzoFH/rEq7YKw7/HL+sVip/fDDjxklg3wevlHmgwQnuxFhVcbFhJR51?=
 =?us-ascii?Q?/rZcQvdfXgYDEO4IL/wLX1tHGcHcLYS6E5H5b+zKz/4KEYd5qE2apaNEAymT?=
 =?us-ascii?Q?XsKIoPhhDW/wRzhUrMlWDs0qcuqCNvgiR9m/e97AzeJn+ZUEUcKANoZOBArF?=
 =?us-ascii?Q?NA1xvdwnvzEiLB5YFWwDN4uLxiZtSvLcmkKwmrxUXHI/kyv+Kgn8+S1cXG9p?=
 =?us-ascii?Q?KuVBKrZehpOobQRfVzkBWZCK1iuJAsOBtRqliZSpwJFHUAHBUIukKHNyBb8x?=
 =?us-ascii?Q?xGXuI/TE+iM7udW+GGAF4RoQmLrjci8WrvOfcykB4kIeEjwccaalCAgxyMSI?=
 =?us-ascii?Q?pqZKYZ/hrq8kqzv/czNkWhHhg5oKvfiMWnYOhq1gSeZDWRI8Wi0j+G4u67WX?=
 =?us-ascii?Q?BDVDUxOlwAiWvaCdyPxpSLja8/AKrZtrroHmFSEZ5w2M+CDsRDSykHMxQkmT?=
 =?us-ascii?Q?+bAbRKdxAMcGOJMgZ+036y4w8xWLy1ErpmbSKk6vs5voCbgiBZUlIDnlS4Na?=
 =?us-ascii?Q?6n9hBXTkFgIClSC3UleC9XSx1WjS8cF/ZHtbbpyGqSXrvqB6gS3Sph+7R8HF?=
 =?us-ascii?Q?wxhft6ArqvuAPP104TZQnV9onw5oR/moQJksrpGhErRYn97McxyUsNz1REEf?=
 =?us-ascii?Q?HRr5p9dpRsGwo+6cinHhWuYumnIrzRg63+3oo1JP2lHmmFi/3c3zPcrEfNdW?=
 =?us-ascii?Q?6AhP1HU3/1lj1uNLRkEWWyLL+dZCkQvYUsw5AbX0OJ8ZOwbi45kWhJkmU1//?=
 =?us-ascii?Q?HPlta1CXkC+sXWbkFiq6uwLfYwFPRb91wC/K/k8XoOj1mUGBX5KeeMBM+pDG?=
 =?us-ascii?Q?hz542xyA9a01JrBl13mruIea7+FI3s96O6buITF+xJptDFZXKCoWDzi63uWR?=
 =?us-ascii?Q?3jjqdYYuvrnNAFKonZUCy9fAQ9QtyHi1PCYZDPffdcBPtIjTpqqLYz/xdSX+?=
 =?us-ascii?Q?EiNdDyt6awQ6uvEGgJklNIQIbtptFW4/VJudR8QlwiOY0sb2hroku5W+eZRR?=
 =?us-ascii?Q?/ndmTiYfsSbgBj/6MuP7DZuwscSscmE/Hjd0IjtEtNvhvtxB7slbddzNlUwM?=
 =?us-ascii?Q?vTowwRGNPrgSvnou6l7x7ZKguEjqyI1mOkzVb1U6ln7P5YMiC1bWPeeMKCKt?=
 =?us-ascii?Q?baCY5M9Po28+pCH0zWtWLDN3/+PzcFsd3Ww+wRebR91mxRwG8rRSYLbt4PKx?=
 =?us-ascii?Q?xlCiYRifI8GKOpyZHL2o+aTc2b9sftRNVXrO7Wae5Ra+8GefLFeXy7DUNtw4?=
 =?us-ascii?Q?rCtXUkxc6thvbhPhE0J2iHhaPH0JKY8aIZksUkOhHCviEDh17Y2CXWEq+DCb?=
 =?us-ascii?Q?xT4FiR+51KuHs0XqGWGSDuCiJ5CYKcU8OdRo/O274+9PJfmHew+1yONpUU6b?=
 =?us-ascii?Q?x0pPxHfCb408iJtWFtIrV3AQf6Bu6RLcBgrddEL3Pi+7xV5NgYN7ROR5WI0u?=
 =?us-ascii?Q?K66An5OPyGyu4QEijQnbI0GHOJuR4bSaFqVL2OFuNKe9uktUakKQQoGKpKaf?=
X-MS-Exchange-AntiSpam-MessageData-1: Q9tDWcFMfn1ryAfkE5Xos8lWC09UMydJcy8=
X-Exchange-RoutingPolicyChecked:
	boNl/MyvsvhHEdrluemvuOvJbFn59C7LGhdSYk2RtkZ99C0+iuvuWNVf11Ob9YQlJJBc44tUISZ6ExlDWTTFg+nD9BnLSHLDLmk0X2Jij3Ab0wdCNQngeWtsMd5iJ1UAZWyMCoxL2t9lonRtc9qf76d/rA1bUjUefoqwvsZsX/V9y7GL8Gyi/hIhVjlCw2aruljj5/rPoZwi0f3aVSPtUZSq2H3UB/YywY+Lcal5kCQULM1hSNjGIqhEsT6U0IxII01n2df9Olk8SNGyylaGTf0sv31CpVG1UL1GfJThf8jw4TpGhyd0DOWxIigV6JLrfnD5KyrsM5osJ2PGGfQtaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tRe4MCljDW1ZetCKCgzc9m4V/A0ntSQlYZ3l6Y9rNsIRnb8K/HpvM6yMx8sTLP5k2PHaiyQC51fELg4M+NSlr2CS1j0s2VgrUZSnaavSYoEwnX2WJay6PLSsVGBvBIbPcETBVxlryiEF6WHO4+98QV83HCmvVLnM4tq0O/cB+KrwWd3SIbxAAPR+J7G8uPr4zZUPXP7rXGQP1JnFw/T3XXuXvo5aUca0AXN54DsEXofQ65TDk/AS0ZjbEPl09+fQCByS2zaNth/iS2S9jLCZnSzihnESdWZ89r6c99jED9ac0H80P3MBqjEIdah1B+HoEA9NtaUkjZnozA9UtUSpJBIfaGTMrrMgJ60Ro2TW2EsEaZeZmHF4nIfkWZgEo65wq3GKaqZnjxJjLVpm13zAxZrqbolybl/5zU2+Naa6GakFoB/4uI03Gp8cdCHOAZLeJCNMPX8PAvJYrPhKv/udXzpI1soL8ReiP4IAgY35zODPKYTdTF+WFsJTTKgXKkC4qFbzLirQ8kObH7DWezjc7kGsYXvxiMxltitUSyf8lzoB35ovGEN/MrcUn3OIj/+sZUVwj7gTEVhmmI7Fr2RMYONXrfHmaY28x2OCWx4+Q8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647ab8c6-2c47-4005-e9b0-08deb81c909d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:09:55.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7TpqGqk8kv0a5Ea6TQq2xlrMKYiMmE3u0nsb/+yWJ/hy8scxqZAb/VbeNWooSeHIP0KTaNR4bHHKlerwPrD/FGHUzPrBVtkzYYF+5qi1aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF18D5A7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605220161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfX9bGbVuBSb/ot
 Y/XkIR2LSZawkyTRoXUfcbkx6PEn3s81YucTYxIUEPdYuhyBqqsFh1xnyOs8UjQUb5QeHy5nMjs
 oBqBS3TIlyJIvi5ESIFcXq7Ry+ewwjR/DZVT68/YDo+vARNhUlwHb5U6dXVprwxNjYWJ9BULmkX
 GejPnqKLKTUPMnmMeOvnT2GEF4AghSlihDAYuFpAKLF78/VrnclHT/qpnVjm55CRmek/BajsBxE
 EYS8wovm3DHwtdWrzPEGjEW5IU9gw7Cp7xCVsTWv0huPNGLaBAHYv2OToK0mgNvm3EH2e0mXPcr
 lFm7fhez9YOxoD/3ElukNmDXwXNAY3rb/MTEhISb4IcJTFMM81zousRjmhLQUE3jvDreCFMubrF
 yqEcOTWkmqtYLlUrESsp2m15ZRqGGzhSPZnkqo2osXkChg1QDfCuVVCfq/uZSXdCvg9WyApavN0
 PWbB0Aknsz3yJiNwd7KUuxCZQP8lV1EQhrZ66wTg=
X-Proofpoint-ORIG-GUID: MHv9ilvh1qMRq88zz2hZqUeGltGaz_5M
X-Authority-Analysis: v=2.4 cv=dc6wG3Xe c=1 sm=1 tr=0 ts=6a108001 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=ElfticSEwONjoEU1SbMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12301
X-Proofpoint-GUID: MHv9ilvh1qMRq88zz2hZqUeGltGaz_5M

Add read helpers which allow a caller to enforce a timeout per read,
and a deadline for the read in case multiple reads have to be done
under a common timeout.

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 strbuf.c  |  26 +++++++++-
 strbuf.h  |   4 ++
 wrapper.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 wrapper.h |  23 +++++++++
 4 files changed, 182 insertions(+), 10 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 3e04addc22fe..b3fc7c624aa2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -749,13 +749,15 @@ int strbuf_getline_nul(struct strbuf *sb, FILE *fp)
 	return strbuf_getdelim(sb, fp, '\0');
 }
 
-int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
+static int strbuf_getwholeline_fd_with(struct strbuf *sb, int fd, int term,
+				       xread_cb_t xread_cb,
+				       void *cb_data)
 {
 	strbuf_reset(sb);
 
 	while (1) {
 		char ch;
-		ssize_t len = xread(fd, &ch, 1);
+		ssize_t len = xread_cb(fd, &ch, 1, cb_data);
 		if (len <= 0)
 			return EOF;
 		strbuf_addch(sb, ch);
@@ -765,6 +767,26 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
 	return 0;
 }
 
+int strbuf_getwholeline_fd_deadline(struct strbuf *sb, int fd, int term,
+				    uint64_t deadline_ns)
+{
+	return strbuf_getwholeline_fd_with(sb, fd, term, xread_deadline_fn,
+					   &deadline_ns);
+}
+
+int strbuf_getwholeline_fd_timeout(struct strbuf *sb, int fd, int term,
+				   int timeout_ms)
+{
+	return strbuf_getwholeline_fd_with(sb, fd, term, xread_timeout_fn,
+					   &timeout_ms);
+}
+
+/* Non-timeout version for compatibility. */
+int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
+{
+	return strbuf_getwholeline_fd_timeout(sb, fd, term, 0);
+}
+
 ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
 	int fd;
diff --git a/strbuf.h b/strbuf.h
index 06e284f9cca4..f896da1277a6 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -535,6 +535,10 @@ int strbuf_appendwholeline(struct strbuf *sb, FILE *file, int term);
  * descriptor.
  */
 int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);
+int strbuf_getwholeline_fd_timeout(struct strbuf *sb, int fd, int term,
+				   int timeout_ms);
+int strbuf_getwholeline_fd_deadline(struct strbuf *sb, int fd, int term,
+				    uint64_t deadline_ns);
 
 /**
  * Set the buffer to the path of the current working directory.
diff --git a/wrapper.c b/wrapper.c
index 16f5a63fbb61..1f42845e031e 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -9,6 +9,7 @@
 #include "parse.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "trace.h"
 #include "trace2.h"
 
 #ifdef HAVE_RTLGENRANDOM
@@ -220,28 +221,129 @@ static int handle_nonblock(int fd, short poll_events, int err)
 	return 1;
 }
 
-/*
- * xread() is the same a read(), but it automatically restarts read()
- * operations with a recoverable error (EAGAIN and EINTR). xread()
+static int wait_for_fd(int fd, short poll_events, int timeout_ms)
+{
+	struct pollfd pfd;
+
+	if (timeout_ms < 0) {
+		/* Negative timeout makes no sense. */
+		errno = EINVAL;
+		return -1;
+	}
+
+	pfd.fd = fd;
+	pfd.events = poll_events;
+
+	while(1) {
+		int ret = poll(&pfd, 1, timeout_ms);
+
+		if (ret <= 0) {
+			/* Retry if interrupted. */
+			if (ret < 0 && errno == EINTR)
+				continue;
+
+			/* Set errno if timeout happened. */
+			if (ret == 0)
+				errno = ETIMEDOUT;
+
+			return -1;
+		}
+
+		/* Invalid FD passed. */
+		if (pfd.revents & POLLNVAL) {
+			errno = EBADF;
+			return -1;
+		}
+
+		/* Some error happened. */
+		if (pfd.revents & POLLERR) {
+			errno = EIO;
+			return -1;
+		}
+
+		/* HangUp => We are ready to consume output till EOF. */
+		if (pfd.revents & (poll_events | POLLHUP))
+			return 0;
+	}
+}
+
+/**
+ * xread_timeout() is the same as read(), but it automatically restarts read()
+ * operations with a recoverable error (EAGAIN and EINTR). xread_timeout()
  * DOES NOT GUARANTEE that "len" bytes is read even if the data is available.
+ *
+ * Fails with ETIMEDOUT when no bytes become available within timeout_ms
+ * milliseconds. A zero timeout disables timeout handling, so reads can
+ * block until the file descriptor is readable. Negative timeouts are invalid.
  */
-ssize_t xread(int fd, void *buf, size_t len)
+ssize_t xread_timeout(int fd, void *buf, size_t len, int timeout_ms)
 {
 	ssize_t nr;
+
 	if (len > MAX_IO_SIZE)
 		len = MAX_IO_SIZE;
+
 	while (1) {
+		if (timeout_ms && wait_for_fd(fd, POLLIN, timeout_ms))
+			return -1;
+
 		nr = read(fd, buf, len);
+
 		if (nr < 0) {
 			if (errno == EINTR)
 				continue;
-			if (handle_nonblock(fd, POLLIN, errno))
-				continue;
+
+			if (timeout_ms) {
+				if (errno == EAGAIN || errno == EWOULDBLOCK)
+					continue;
+			} else {
+				if (handle_nonblock(fd, POLLIN, errno))
+					continue;
+			}
 		}
+
 		return nr;
 	}
 }
 
+/* Non-timeout version for compatibility. */
+ssize_t xread(int fd, void *buf, size_t len)
+{
+	return xread_timeout(fd, buf, len, 0);
+}
+
+static int remaining_timeout_ms(uint64_t deadline_ns)
+{
+	uint64_t now, remaining_ns;
+
+	if (!deadline_ns)
+		return 0;
+
+	now = getnanotime();
+	if (now >= deadline_ns) {
+		errno = ETIMEDOUT;
+		return -1;
+	}
+
+	remaining_ns = deadline_ns - now;
+	return (int)((remaining_ns + 999999ULL) / 1000000ULL);
+}
+
+/* (deadline_ns = 0) disables the deadline and short-circuits to xread(). */
+ssize_t xread_deadline(int fd, void *buf, size_t len, uint64_t deadline_ns)
+{
+	int timeout_ms;
+
+	if (deadline_ns == 0)
+		return xread(fd, buf, len);
+
+	timeout_ms = remaining_timeout_ms(deadline_ns);
+	if (timeout_ms < 0)
+		return -1;
+
+	return xread_timeout(fd, buf, len, timeout_ms);
+}
+
 /*
  * xwrite() is the same a write(), but it automatically restarts write()
  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
@@ -283,13 +385,15 @@ ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
 	}
 }
 
-ssize_t read_in_full(int fd, void *buf, size_t count)
+static ssize_t read_in_full_with(int fd, void *buf, size_t count,
+				 xread_cb_t xread_cb,
+				 void *cb_data)
 {
 	char *p = buf;
 	ssize_t total = 0;
 
 	while (count > 0) {
-		ssize_t loaded = xread(fd, p, count);
+		ssize_t loaded = xread_cb(fd, p, count, cb_data);
 		if (loaded < 0)
 			return -1;
 		if (loaded == 0)
@@ -302,6 +406,25 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	return total;
 }
 
+ssize_t read_in_full_deadline(int fd, void *buf, size_t count,
+			      uint64_t deadline_ns)
+{
+	return read_in_full_with(fd, buf, count, xread_deadline_fn,
+				 &deadline_ns);
+}
+
+ssize_t read_in_full_timeout(int fd, void *buf, size_t count, int timeout_ms)
+{
+	return read_in_full_with(fd, buf, count, xread_timeout_fn,
+				 &timeout_ms);
+}
+
+/* Non-timeout version for compatibility. */
+ssize_t read_in_full(int fd, void *buf, size_t count)
+{
+	return read_in_full_timeout(fd, buf, count, 0);
+}
+
 ssize_t write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
diff --git a/wrapper.h b/wrapper.h
index 15ac3bab6e97..10d85c467b86 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -15,6 +15,8 @@ const char *mmap_os_err(void);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
+ssize_t xread_timeout(int fd, void *buf, size_t len, int timeout_ms);
+ssize_t xread_deadline(int fd, void *buf, size_t len, uint64_t deadline_ns);
 ssize_t xwrite(int fd, const void *buf, size_t len);
 ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 int xdup(int fd);
@@ -44,9 +46,30 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
 
 ssize_t read_in_full(int fd, void *buf, size_t count);
+ssize_t read_in_full_timeout(int fd, void *buf, size_t count, int timeout_ms);
+ssize_t read_in_full_deadline(int fd, void *buf, size_t count,
+			      uint64_t deadline_ns);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
+typedef ssize_t xread_cb_t(int fd, void *buf, size_t len, const void *cb_data);
+
+static inline ssize_t xread_timeout_fn(int fd, void *buf, size_t len,
+				       const void *cb_data)
+{
+	const int *timeout_ms = cb_data;
+
+	return xread_timeout(fd, buf, len, *timeout_ms);
+}
+
+static inline ssize_t xread_deadline_fn(int fd, void *buf, size_t len,
+					const void *cb_data)
+{
+	const uint64_t *deadline_ns = cb_data;
+
+	return xread_deadline(fd, buf, len, *deadline_ns);
+}
+
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
-- 
2.53.0

