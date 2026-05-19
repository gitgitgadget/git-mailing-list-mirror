Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6B4CA293
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208297; cv=fail; b=UniSNRbjGNNH+8LZ+zQ/7Sw2MstB/qfQ8YB0gs3jnb64JMfZjwBgGbM83CgPYjRFfxi0ZA50auYSilDrWv7A3V/cSNVZev79zEkx/J5Dg5Ov35qL4vdqeOBTrxxWkV5tAR1g35QzfANUGiAZppyYWBOMBWNdI/ZRKMhpg90KhsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208297; c=relaxed/simple;
	bh=52Zv6AKw7uxNOsDeOaMLsxQIrh8lrxad/LfAWp31+5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRaRE/SpZonUy7cfigyDWh4FXCja48Uvz6wWV/LwuC8agn29iWoY1Z/BmiDsojfPaGwURY/Nmh+MpOSeVFPx2WMOCdOmxQjM9foHKDOrCMh5UE+AVMW4egm1LgsckrN1xMpRfB0O/u86BXV3sh9E6HCK4iIKwZPMa6p3y6i6kzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZHmhKRpg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D+gvxaff; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZHmhKRpg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D+gvxaff"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JGTalZ658661;
	Tue, 19 May 2026 16:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OVS5RYiNoTtZDAOy25XmgCRCE5AlA4D1X5gir4NU9gg=; b=
	ZHmhKRpguyCTAiLjdsLkV8G9lu3A/zDqYG3PWcVB2had8MKJV1PjBQBsGS5vZ14h
	SID+39sqkehcjO5hB54ZYesgzDDPSKTP2c/T5oisObaBWOfPFevHyCDJilDxSbaO
	bVbByvkSnU+3LJneKCwQz22CnCiJ7AyHiHvSC8ncznyv6eQ/278TE3yvv6taIe6q
	Gp9YVk8aE1YlZQKlYb6Wbxu4SfjdxUo72BuJPMbvnLjwakXoOQPPmhovSDp4nDp6
	NeVgclVETXMtmTheYngkdk19RmFMp9aNT+lv4/XsKhu3lh/epZ3eYYousDcz/GRc
	vRLqVKzx+fFyxGqxpOv25w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1sw3em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGTlZQ011897;
	Tue, 19 May 2026 16:31:28 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1b0sh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5yLJXYT5v1m4tKXI5qP4TZrPYAlhBY1NBQk77/2VoEjxmI6HPIpHHlM7FyGZThzLTvy+1i9BYUKOVsHe3iu3J3oF+hAr1xHEPEPSwfS+zpeD3zx0zFR3y+wWpsG88wh8bxqWaB6NVkdbAdL2cliYSlk5tpnYg6W37RX4OU0z2Uh9I/U4ZcfsQQ6xJt6orJ00XMHV3j1kTsgled08q4T5giTYqFzEJ5tbx0FeZY81ZUQr53LlHk+zUqJ4CX6gp2TcESLCFvNySSp0mpKDDWzux/qOF4wRia/k0oCCAMnFvWM3X6bZCXQjNn3cKWoVu4RqKFVA1ShxNLm2z106ckOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVS5RYiNoTtZDAOy25XmgCRCE5AlA4D1X5gir4NU9gg=;
 b=YA9POCvvBG579TkOZkthmpLNBSZ2pj5/7QktsLqRuz54uh/mNciiC3arlHre4yHk6gcVtvLoEEv9y/OhGPWMgb5ywdBRF6eKPpz7shlNK/u2stc3SKX6do8N9VFEcs/m905qA2aDR6MWygJDabErmc/IOagAZoE5diadqAufKTklHE4GxARROZsGNoHydCJIkkVBf5oTp0InH+bETOvZ57KuCnOiN8JAlCEWr7fvdWQRUFGb2iY520TwKhCj4t0k/pE3qB3+MH9lJZqD13r1XNSP7hZLBxF4zRHXAooIU8o0xqoB6xqASaIU60LveSzmDBsBSJxqYxQdKUF8g/NHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVS5RYiNoTtZDAOy25XmgCRCE5AlA4D1X5gir4NU9gg=;
 b=D+gvxaffcQIomy3pufUxBDiRxTDmdERcJ/TI6vgg0wq6akSJ6KNgKgeJbo/HnW1UYTvt9Xq5trt+FXddS65ZK4FWUcDhyWpBkm3JeKBsVNxFP2oWFgMH1hc16zGnIw0z8d+laK36vdVriZlRnmRWUadBT+q6GeUaHz5LcnkquDY=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Tue, 19 May 2026 16:31:25 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:31:25 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] Documentation: document external notes command options
Date: Tue, 19 May 2026 22:00:37 +0530
Message-ID: <12aa52077b4111892d2c966a2bff205d5b4ad170.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0061.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::10) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6ac86c-460d-4439-9aa5-08deb5c411a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	poLLS/7RpUHMEaLRRY/3bBWzxzDS+8SfhhTz+gMXM9vKWMyNniKxc7o/+NJWiCQbsV43eJmaWUgRRyT3cgiqAk4IaVCG680sES+0F9wF1nhGUavxBden/vesDOKGypqCXA3BRMEQjmrw0N7Mm21zBPuBUZ1K1K/q72DoRW1BS4QrlKzBIKikUiCB4A4xhpQWn9NuIAshjx8a6m4V4Bpfq5MII3ZckW78JVQWzwoCMkG0Ey22eILNoQERjvEgY6jQvb6qK4N0+6BQo5fJSoIbWXB1M5LfbE4aDYyn6Vn52TZ2iqrKy3hpoPAu8+EAkFbD48pxBUKF6wlEW5e7SVnJT2ICWQNfWC67UKDL5R6Hyk3xlQKvCaWF7EFw2VzNrNtF/ZbddJNBBZ4n+WD90+bUKOdn7C4YrBitFEfyTNiArzfSqtU21/ZVlo2OAB4YyRcl7GaakYFoc9kcg7tqloLMl1yScjboy8uMyC/v9ZgbnLMBYAwrhRg/LLtwGD8ZZvafPaI15Ba32vuz3QmRvlFviwBrsgKf+oe0hNr2dBxytevYRyOfAUfUEnh3DUcqT8mii31e3mptNNNAVnaHMEGUQcDR/do6DvqYkrPtlvVg2Y/V6CVt1KQdjnZJ3ZejzlD5Xa6xQ5cyJNUAMx3Mi9zwcsWbJrqKRp6YLH+juPNIt/btdV7kLfJbOqa8eB4R4bCW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USodwbM+/0Oi+BDf5y+Di36o5Yp+LKMpZfGzNWXTDc+P5rs1kfV9kRfd7Q9e?=
 =?us-ascii?Q?OfnRS64INGnUI59ZnSpQ9C3f8o8KMw9J/IdRxfrfiD5MG69ObC+KRUxjeErC?=
 =?us-ascii?Q?ARk6gmWGbN3Z2pIveTvnsuWfIq3vC8EU1OJfKAriAi+mdX0HC4wDmkjFGPOl?=
 =?us-ascii?Q?L8vgxEJNVILD6LOdY+IKh0vRxjxBLcm3dsWcF5MwXDu/1bX+oftx7/lfiLOu?=
 =?us-ascii?Q?oMkJNbDa9SQjeG3G7d/hzeu2vnKLDOhPUzN/vCxP1Np6wQ00+rMG0aekJbfx?=
 =?us-ascii?Q?kDnY/tWaY+FZUpcFl0LVGKrdJHB8ZTZeMn5c2dOchkEPn5GjHA97ozgmTmKe?=
 =?us-ascii?Q?Ly4im/iMCnJ6zz+/4xACTarPkBEAcdSccjFQnDeibUcZl4WGkS7++kXlNb76?=
 =?us-ascii?Q?qDaCY6AmiyIahpmjRlHU2g9Ld7h7H8iokM7xWw2GPIZvI3cl/A08FysZ/xSU?=
 =?us-ascii?Q?maA/4pp7lQWWwSVit8+kvOn+j2GDTcnQQhyjMzZMq6ou9kIcmclOu9RyN8oq?=
 =?us-ascii?Q?GY6R/jg33/3/g5GQQfkVkkyQNgnNGlrgXCC+l0ZCw41ONl3G5LwysWRvd/gv?=
 =?us-ascii?Q?YlKUJxIUJnMAU84ikd812DI6xT9d+7p61xmP+uSCePAP6TFIlvCKY8vVL+/H?=
 =?us-ascii?Q?AfhSQtNKkl8H2I8zi5vuBrAm45a94mtj3Tc/5Sr2LlZc5cz7VtTkxXS52rhU?=
 =?us-ascii?Q?AQoTofcuc/HViPnvL5HDUTXW0lGupf+kXKwyH0f8arXHdb5jCbQllAhG+gaR?=
 =?us-ascii?Q?HXddgjzWtwxHzN+jZ0VTYEIsMyhADNQ5k4UDZ5THoP3ZQsX8tdscFPF2JMPL?=
 =?us-ascii?Q?c6qxpHcYXmUV3HG2+An41i/yAcRvWtotPIImJbA/Zaz7OGXiDJJDvWYJhpZ0?=
 =?us-ascii?Q?Wc8YT3tA5tHCYqo1IfQ9KvStiu1Pn1fBxyW5JNGBGJqxv473S/XDsA227vu3?=
 =?us-ascii?Q?JUYdcatTeobbRXyU1c40E8jkKxWcJNurLlNn7JlLQtBc3JyHdWnCKuKSdeLa?=
 =?us-ascii?Q?SiUtfXbWxR4ut9y5x/BaxGF02bCM1hgMelNRhqxsCn2ETLpUaYjIPA6BPjtu?=
 =?us-ascii?Q?/a5bBa+npgew+E9o1Qx/djxE9QokNNWAHkhBwqODf6+GOM2vU+KLI2eQIStJ?=
 =?us-ascii?Q?mJtHNXCY7EBv2yTd9nl9kwhuVVDCNgIuRKT0JWNEkw/BSqaOsl/XuqKoXs/L?=
 =?us-ascii?Q?9m7lAcfRi2+jBoLfBbb+GdgdfYshX+CCkoQuvWwKDQOxk2NsaH/79UaSe6ku?=
 =?us-ascii?Q?FoGJotsuffDByC5WOCVS2sQodKhihTu3nHZgIzwDazDZm5FIQ4tY07iJsBgc?=
 =?us-ascii?Q?lopVD2Lf8wneVaOoEcDb1W6WZ6My61r6ZEmF6E3FiNRoj4m8dTdi2hEJLyDW?=
 =?us-ascii?Q?/Vj+6He4DbV8ACsXoL8Ma3GKmMRDZYxfyNpw6AlBQEO+NSbqrgcBHoZPW0ZN?=
 =?us-ascii?Q?H/Eri2hlOICOwrYfxQBLYZX1q9gHU+EV0PW1I510w0vc6X0t0K5ZD5FGWroz?=
 =?us-ascii?Q?lERagmPS8xzmxEhD88z9Og55cWBBdKGuHHc2jHcZtf4S5ww5q1istw0lD++n?=
 =?us-ascii?Q?S+266aT93OXzNheV9jYxn44RAfrBaGr43LOrfG4afQQAg8MtPd25454g1DGa?=
 =?us-ascii?Q?XfXCEjghpefFnZbzF2pjt6Afj1ITc1zTTSBM1PyoyiGl4YrlwEdn2BA6rtex?=
 =?us-ascii?Q?pH8CFf3MZvbAMlvzOL3QiIWeAy5NNUN+tdk7Ybd9VH4P03CHmpMEA3FCMDmd?=
 =?us-ascii?Q?ZfWjCeAqsM5PxVUbfDyWuJOiQJJGMO9n7dL1v+CRRXd9qbRV+Gc9eeLR1l9W?=
X-MS-Exchange-AntiSpam-MessageData-1: UeYGnBudiO6tEjGuARIgHiisNnxRluX1b2w=
X-Exchange-RoutingPolicyChecked:
	khs+UNwD1RNQ3BaLTGuZD+LK+N7qz453AXKGiAQR05Crgyxq2/eXkvEYfgJk/uCf7bLPsFA46uz93k2BmxmsjavVhCpQPUgKCTxtkDwyUpvfxDjWNmDteeCdNyVGN5URZfNoMcYSUFuefhCao69cxOK9Po8vnGWfRKyjguINf2rF+2/Bk6VDKOq5W9oktz/Cg2a2u8OZbO6JjHMk3ctz5XptAaZpav3holytG7IVJKhguRNFOe6+9VDWxlhiiJ7aRsmOsbP4SN4Lf6qfWJqOBdAwKKDun24bZFL/jsg9x8ZYCy7Xh3HXc5DIwesAQq0E34L4XnEz5C4L/yAU1XIVGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6e44zZKIAZOKnzPwVE8lI/D28kApZF9hKvFBOtxMvFkwVtKXVR05f59jNS/WN2hsMU7vZO4RNJ+8pygS26MLrzgeMMMMaNVHO7t0DJOrRAvS9m8O889V/f0uSQCDp+8zjBR6+jOtZRFb/e5phqtxT/2KH/qfFmQqQix5loXJfeBoDLBo8mI9DsTXckYcHeX/NwrYIEpDZ8ZSuoMizhCek9900UBH0aYgtBWGcXM+y1/ZVSHNcwf7jC2pOIi6eshDlGTPnOmkWNel5RUgCmp081KCU4FFK44VxonbkHLcaY/rv0Yc5IVBn2kt26X0ew2jHpK2bgwtR6wGgq9XTO3W7zCw9ZPA40OR79JD9NNOYyOlfRoDpVYHDYl8sq+gWDr9eGbsHlCHgXNLcNWl5a3u8H9L0K9OPb97zpXfmsubsNWagSEq6aOqClkPn1JrY6y5/qWFzQwfqFI5q0GNtd2BzNUe1bo0NMnLTULl4JP9JtQXjCeDsjWRAmtNO5vrSczMbGZWYAer8Sa20FDI5sAarGoZHXtUDRO03SlE2Y/M5UpSrTp8mg7HQiSQK6lwWzToH4Izl3Wyr9z52CtOXLd3VJ/DcZjcoFRh8hKOfzWe290=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6ac86c-460d-4439-9aa5-08deb5c411a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:24.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKICZobiMjVCsbCVigNkYmA1PKoGTcJOML57a1GWCNJSV1Z8KmjxPje3MmjsmOZADJbYgagsSiWBnbIuywDyZ+XbILy8aV9Hk/HlFF1X9n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Proofpoint-GUID: eEhpE-r0KW3e5GUofsGyJza-lS4lS-bN
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=6a0c9061 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=xw003-oIY7mu9iacZTsA:9
X-Proofpoint-ORIG-GUID: eEhpE-r0KW3e5GUofsGyJza-lS4lS-bN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfXx4I/gBvMlqtu
 kh2MhMnsqIzqvU1BxHjuDR3OFcqTMVbxyLXE+VgXx1+fl+11G09qE49KFTww2JckvPr/lX8iV0u
 4U4l1kY1ofsw6170yTsLNdZSVuqTrvMo+zEg5NweXw6lJ30dUagZw1HzSzc5+3vOhfsS/yuTpOj
 CK+/u/4BxogRNqgsyeP/OLZzgZ+M0gJhcKMuE8EhXLX50ud/j/ZhdOGW6DmoCyNA9mEteK17dnF
 I6/NxkWgdibrTi0yR4t2KBFb9YAWRI6ZHniERXtO8DQjd6O2Q+u/PT+aXnmnOHn+HWIAWn89Ev9
 PBIlNV5zdhxZhnauduE8aXw0XT4D3XBMQf3do/Cx0ljj26ZgUByFNTIocsCm5NA9nvTP6wm04FY
 NcR70SuZTO6bfQScMzqQA/6NVHtLXCmFPT01Aqkh1O26pZq2sk5Lfyf/UvjaGRvYwjQpI3CB9X3
 daXs27KQblpbwS9C3hw==

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 Documentation/config/notes.adoc        | 57 ++++++++++++++++++++++++++
 Documentation/git-format-patch.adoc    | 11 ++++-
 Documentation/git-range-diff.adoc      |  6 +++
 Documentation/pretty-options.adoc      |  9 ++++
 contrib/completion/git-completion.bash |  4 +-
 5 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/notes.adoc b/Documentation/config/notes.adoc
index b7e536496f51..b3ef3fa52950 100644
--- a/Documentation/config/notes.adoc
+++ b/Documentation/config/notes.adoc
@@ -34,6 +34,63 @@ The effective value of `core.notesRef` (possibly overridden by
 `GIT_NOTES_REF`) is also implicitly added to the list of refs to be
 displayed.
 
+`notes.externalCommand`::
+	Command to invoke as a long-lived helper when showing commit messages
+	with the `git log` family of commands. Git sends one commit object ID
+	per request on the command's standard input:
++
+------------
+<hex-commit-id>
+------------
++
+For each request, the command must respond on its standard output with either
+`<hex-commit-id> missing` followed by a newline, or `<hex-commit-id> ok <n>`
+followed by a newline and exactly `<n>` bytes of UTF-8 note text followed by a
+newline. The command must respond to each request as it is received; Git does
+not send all commit object IDs before reading responses. Empty note text is not
+displayed. If Git cannot start or communicate with the command, or the command
+sends an invalid response, Git warns once and disables it for the rest of the
+command. External notes are only used while formatting output by default; see
+`notes.externalCommandForGrep` to include them when matching commits.
++
+This setting is only respected in protected configuration (see
+linkgit:git-config[1]). This prevents untrusted repositories from running
+arbitrary commands when notes are displayed.
++
+This setting does not take effect when:
++
+--
+* the value is empty;
+* `--no-notes` is given;
+* `--no-external-notes` is given; or
+* `--notes=<ref>` is given by itself without `--external-notes` or `--notes`.
+--
+
+`notes.externalCommandName`::
+	Name to use in the `Notes (<name>):` header for notes returned by
+	`notes.externalCommand`. Defaults to `external`. This setting is only
+	respected in protected configuration.
+
+`notes.externalCommandTimeoutMs`::
+	Number of milliseconds to wait when reading each response from
+	`notes.externalCommand`. Defaults to `100`. If the command does not
+	produce the expected response in time, Git warns once and disables it
+	for the rest of the command. A value of `0` disables timeout handling,
+	so reads can block until the command writes output or exits. This
+	setting is only	respected in protected configuration.
+
+`notes.externalCommandForGrep`::
+	Boolean indicating whether notes returned by `notes.externalCommand`
+	are included when matching commits with `--grep`, wherever notes would
+	normally participate in grep matching. Defaults to false. This does
+	not make hidden notes searchable in formats such as `--oneline` or
+	`--pretty=%s`; use `--notes` or `--external-notes` if those formats
+	should search notes too. When enabled, revision traversal may invoke
+	the external command for many commits that are not ultimately
+	displayed, which can be expensive for slow commands. The note output
+	can also change which commits match. This setting is only respected in
+	protected configuration.
+
 `notes.rewrite.<command>`::
 	When rewriting commits with _<command>_ (currently `amend` or
 	`rebase`), if this variable is `false`, git will not copy
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 566238245028..472b37e5237a 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -26,7 +26,7 @@ SYNOPSIS
 		   [--[no-]cover-letter] [--quiet]
 		   [--commit-list-format=<format-spec>]
 		   [--[no-]encode-email-headers]
-		   [--no-notes | --notes[=<ref>]]
+		   [--no-notes | --notes[=<ref>]] [--[no-]external-notes]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--filename-max-length=<n>]
@@ -395,6 +395,15 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 The default is `--no-notes`, unless the `format.notes` configuration is
 set.
 
+--external-notes::
+--no-external-notes::
+	Invoke or do not invoke `notes.externalCommand` to obtain external
+	notes. Like `--notes=<ref>`, `--external-notes` names an explicit
+	note source and by itself does not include the default notes refs.
+	Use `--external-notes --notes` to include the default notes refs
+	too, or combine `--external-notes` with `--notes=<ref>` to include
+	external notes with specific notes refs.
+
 --signature=<signature>::
 --no-signature::
 	Add a signature to each message produced. Per RFC 3676 the signature
diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index 5cc5e2ed5673..1de23f300517 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -12,6 +12,7 @@ git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only] [--diff-merges=<format>]
 	[--remerge-diff] [--no-notes | --notes[=<ref>]]
+	[--[no-]external-notes]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
 
@@ -101,6 +102,11 @@ diff.
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
 
+`--external-notes`::
+`--no-external-notes`::
+	This flag is passed to the `git log` program
+	(see linkgit:git-log[1]) that generates the patches.
+
 `<range1> <range2>`::
 	Compare the commits specified by the two ranges, where
 	_<range1>_ is considered an older version of _<range2>_.
diff --git a/Documentation/pretty-options.adoc b/Documentation/pretty-options.adoc
index 658e462b2533..aad851c92cfd 100644
--- a/Documentation/pretty-options.adoc
+++ b/Documentation/pretty-options.adoc
@@ -93,6 +93,15 @@ being displayed. Examples: "`--notes=foo`" will show only notes from
 	"`--notes --notes=foo --no-notes --notes=bar`" will only show notes
 	from `refs/notes/bar`.
 
+`--external-notes`::
+`--no-external-notes`::
+	Invoke or do not invoke `notes.externalCommand` to obtain external
+	notes. Like `--notes=<ref>`, `--external-notes` names an explicit
+	note source and by itself does not include the default notes refs.
+	Use `--external-notes --notes` to include the default notes refs
+	too, or combine `--external-notes` with `--notes=<ref>` to include
+	external notes with specific notes refs.
+
 `--show-notes-by-default`::
 	Show the default notes unless options for displaying specific
 	notes are given.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a8e7c6ddbfb2..146444e65860 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2023,7 +2023,7 @@ _git_fetch ()
 
 __git_format_patch_extra_options="
 	--full-index --not --all --no-prefix --src-prefix=
-	--dst-prefix= --notes
+	--dst-prefix= --notes --external-notes --no-external-notes
 "
 
 _git_format_patch ()
@@ -2215,7 +2215,7 @@ __git_log_common_options="
 __git_log_gitk_options="
 	--dense --sparse --full-history
 	--simplify-merges --simplify-by-decoration
-	--left-right --notes --no-notes
+	--left-right --notes --no-notes --external-notes --no-external-notes
 "
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
-- 
2.53.0

