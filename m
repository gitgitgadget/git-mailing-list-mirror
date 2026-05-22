Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C443277026
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430626; cv=fail; b=RXwBChjfd0CzudxcpmB4NmKs6CiixpWiU2zlJt7udJ1SpUUnJr89aFU+7ngDOYyHJXRsWkIXE1G07iId5BGAQopq95WTV9BBo/YTwSeOgYufpeXK7JaXHGBGcVMQ4fmadzqfRzytHUA3zbfBKh8eRlq5EXqX1r5hoMs8k13WZak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430626; c=relaxed/simple;
	bh=eJ/TYeD7tSxQ4s2RvqzIcsXC1y86+8yO2o0R5WNpv08=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ODOehbT6GMtZJg7YdTqKFXC2fpeEqy3dI1SgKnMsbJAIJCdhADJbboK2I2FNtt6HlEhGrkyKXIzjAe/jh0IQVcEkQifOBYHKNYr/lsx/SVBjoBmXYc3qHChTs1ddPt5eIfL4RC2Lga+mCAYxA+pD2XiPeXXMChmZOtpj+kLOO/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxvWWbIx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W1dwRu2D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxvWWbIx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W1dwRu2D"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M4436Z2419443;
	Fri, 22 May 2026 06:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=vf0dDLhAsU99vuk9
	TNbuyP4MKNxpAq28DIb5n+2lJ0g=; b=dxvWWbIxpl38A9/Nm1qm+r/uWQPmtIID
	CNKHpYnVcMmyn1VEPsS12BTzbf0v/0s31w6+jKfNRr5cGavwNEoKd1E+s6Gzu0s1
	lnDt2vkbFviHmUFDy++ebiBVdupXMF88n6kGzOGabkFePWaFvVqapw7RjxVjgYWM
	yroqq34YVA7wUW3jU8MgfD6ARIxnIBSIF1mw/Ku9gXe6P3gSZDPmbprUzG3ET2nT
	rOL3AiNPEupuoAmcxslkr3FMuMSyCGNqiRV6JsHzyqX4flf6g+avFBfYkEbZ0MFg
	hBLWbU4ZAUUX1gYp624pXho/hW7XuKEHD4blW6yxPXmqhC46L1eIpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4qannm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 06:17:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64M69muG030390;
	Fri, 22 May 2026 06:17:00 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1kcv84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 06:17:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFx8Dxd27SF5yMNGibo/YiZV0gdct628r8GMG5DPhfxAFnOC2K0q6LAvAOU35jYXkyYY10F7gPLdt3uh/4uKOZiLhIvbDazEmKJRsN6Ex8SuQWGvvUwEDSrFO47XQTnertFdrd9ksl+6tJg/mSIflEyoPVYIm3o7sig5oeBdqS9LEZnjkSjeJMUOpyOr2afbYhy4WRjIrf5EtxbqB8lvGSEmA1qm9rYT7VaM0mfMlN0SAOLIksQ1f7oZGd+RkQm0aYP3vXvwKA8OA9y5wky+OAgH7AmOT6Q/mHgpCaawxj3g1t8mWk+0szH3+JUMrAYRAcSVAqrucTbK/EjY59+gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf0dDLhAsU99vuk9TNbuyP4MKNxpAq28DIb5n+2lJ0g=;
 b=KOi6ceXgTNeoCEnsFZNfnvJvSzFks6wwNSVgYnNoJEsrKmMRUv5fYUezVVxGL8JV204/0DaAYvATngbhFN9si+c7bXR9V7slV6xbLDLgPOIF1clf9sbYJHqCh46FXVEp3nULN73R65db70nkTaTRGyiufwrVJko8TJRXMD4bekfaJRiQFe6T+sNpeMej1S7WY6VHQpiB5GnKf3/gc/frVyViLpExAAgcVwz2aUKHCgIeANDzhkb9Lg1Mm34oPWhcb0hv36TIuC8/MgUc292SVoVkttGbhwi/ReFCJIE1PVg26kyAEnso84z1S4oB1Iroaq/L4Ps8hcBb0fuKtTjCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf0dDLhAsU99vuk9TNbuyP4MKNxpAq28DIb5n+2lJ0g=;
 b=W1dwRu2DAExFZkItBK1ntswD4zPxaFKWzTCx8IR9qdkJxCeRT0vXH2cTxQ4wUsZY8ZD3kawGqSKLgj49KdHLfiqCOBcU3aEhghGgET558yTqZUzkXyIs71Fn51Mc8+KgTKJYoFKVTaOj9Ynkne8uk857BjgxnSq+MT6eaT3b5Oo=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DSWPR10MB997911.namprd10.prod.outlook.com (2603:10b6:8:3b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:16:58 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:16:57 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] compat/mingw: Allow SIGKILL to kill in mingw_kill.
Date: Fri, 22 May 2026 11:46:52 +0530
Message-ID: <20260522061652.50078-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DSWPR10MB997911:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7f1c50-a0a0-44ad-8d0a-08deb7c9ba2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nbcfdRu21R4VJlavE/+dZQAwkLeMaiP6cNt13HLiHkP0GwPsFLn1XYVzq3wQ5iHt5k4F/CSFo7oCzPNojPaThHyyy2HLqRb+hFUEWimIU1yxWaK5mE5T2eu9v6fHG+el/L/i91NQfL5rXr1AZkof/ptzcunTspeBslzSD4iE2smAKay/21IpLv9ZfWnghD5tZHw4jsuC1PXmL6SFObEqFwbXsHepr1/ZYY9bp5qgDcAx72FFP+x/25lZcPARVweKg5/ZWm9+LRzb8EQt2IhLJBjU9FpHNtZoV7Cc0nMgwA84s88bIMPLem6WItNm3l3cNFl7r1gZQVnfNAawexN4eQNV+oLYkOyMkLocQ/YIuFnSgLnrw88uu234sPr8mYd1RqwoEiDgSmZ+WKTg2p1Ltn+tisp98V4U6sHCQIOLDISU8uKACzbH7Gsl2Z5VkbDAtQAbtmo5ulE6XhozXbr1EYvOtj6X/p+CoG17weNQ5bDN0wmOMI3IrF9yfNckOI96l55mgm4nFuvmJ5ebpNVkYHBWEXdPFhFir1jHvf+jkw4zBdK9qfCBiiXQhXZtt6Ox2b9iAtwtdc+1m2xVjVhsbESD72UZ8x5sOitPs61D/rt6+2vRbCHLTge2667T/JfQ9Z5HaKWueLlp5ypMTHcQwEr3x9XQK4GHvNufWkFgQuucUbRFPihsRw1gs/KZ5HQx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0uoZrP0uocNl0g2KcN2HsBTkdJl3qZiOw2uPZW+qc8FDtqbxD5er3YKkqkW?=
 =?us-ascii?Q?HMZtbXDLfHLeYuxc1W5Taq6fdK7cye6wtcY+++DP4XQ5ohfoqtutLejlRr2G?=
 =?us-ascii?Q?+hcTMdg1LfncfKBgmKtBTzbANLuWfgftlic+UkOO9uH6Ro6xkv45z7G7M68x?=
 =?us-ascii?Q?dWEMdruqteeAZbqEG0GE1PZC2EcHPJsXcKbXTEfGrbH6lDibBIffU5/vYRFY?=
 =?us-ascii?Q?arA5HX4oJzwtl8SBC5+6tbNIeCVVKkScXMe2lJOtBaV9aZ+M50Bb3F3xGiFm?=
 =?us-ascii?Q?WcpoanHiZSl0hE1qUjoZO81XbbmuHo5D1X4pSdFLxEHX+sv6bawT0SDJelTc?=
 =?us-ascii?Q?6D+Gmw1egPVn9r9PArGPjCukRaiNWcCU+A23f7bVYyDj4lMiV9E46gB40GzF?=
 =?us-ascii?Q?k/jBtT4TbYJH11C5ViMszT7UXWa89Akez2WDoTFVO51gFbyr8gWWUiWA1KI2?=
 =?us-ascii?Q?v6tfi0brldQ+Kxgu95/inJTSEIv7fKMAv1/y/U7WkpeLR5wAkmF25Nw4IZKz?=
 =?us-ascii?Q?ieV5b4E3BJYdTv9cWOyTaMYOFUTn35Xn5YoAELZuoXOIFUWTpGJ8zMSrqH+Q?=
 =?us-ascii?Q?L9MEa6F0nTuTe5oEemv8HAe0xMyEOcXGVFk31Z7fHz1+6gJzNJR6O8zqlakh?=
 =?us-ascii?Q?OvDTgcpaOJ0zoGSFUtotoJuzHdAfL9IRzMHBPQc4VHllgP2MOrSVjivUGLj0?=
 =?us-ascii?Q?jswj6rdt/J4nAuoLCRcZlDrI8xZNmKiVKskTgckNdnTuD5BDUpEM5w3kErO3?=
 =?us-ascii?Q?bZsDiqhbAQ5ZudZ7Lfw6wTTGeEEGGDDJ3dlvGcULwH5Hjn5xKYV3bnUPyD1H?=
 =?us-ascii?Q?UeNuUBLHUQo3V0QP19Wk4BSLWBYEJNDYIeSgOdJ/ENjEniFixP2XDhY5rGDR?=
 =?us-ascii?Q?mrALKjHyNspwX5hx0zSRSsG981ExXPp3muzyO0wTjzfjDeVvKs2K8VVcQ063?=
 =?us-ascii?Q?lrlLD+caf4ov6sbCG+Ib8JXAnYBb+ErUchpwehm7NV1yRjtclhqrrlatcED8?=
 =?us-ascii?Q?WhSIrQWMYyOyFdNuSy4xGolOAC9GWEeStEg1+HNRpH642A3ie9ZInBEUpHdH?=
 =?us-ascii?Q?E6908dH0/X++IAmXbzfnVfw8PvPjR984EVBbmM16bX2aEzXM5xMWm+zreseR?=
 =?us-ascii?Q?c0Gd+kRCRX08dF1u+nYS76yGpOGElHvmtt3vnBs7lTQ0Z2Fq/f8DRyG6uSt+?=
 =?us-ascii?Q?j/rHqwOq2NdzCzzFl7VP9e//PwaVzQ4zPlbV3y0ogCkJpQIIJ61x3GTG+3qe?=
 =?us-ascii?Q?TFUTS7DX32irmYm9FIJaD9dSaSk8B2/NcfgoNPXNgiHw2xShgT3ff6oAoAa5?=
 =?us-ascii?Q?jC/rD0mxBrWI9vg1+DiwjrwElnvcCJfHqIkKQ5xRNiO5wCWUPqVuB6etBXFd?=
 =?us-ascii?Q?pDlMIHZ3qUVGiUawFfIv8AbLOdFTe6peIKE3v1H9X5Pkm5UwAqd4DNsiEVAS?=
 =?us-ascii?Q?IAywMhiASJNzP9y/l9ISEMMqfgymMXDD38kV2XjPEjAaZc36b5aHRKWXot7+?=
 =?us-ascii?Q?rFYiROT1BsZWrzEOIM2Cpc8YrZpv4s73k/hNOKr3E0Ngx1rpT2wXS3MAt5sm?=
 =?us-ascii?Q?GnNUEsBxk7ZGclQW9meGWmT2R+0yAL+MAS5tRf06njCt3vnI3cf1ZGpyqgFD?=
 =?us-ascii?Q?4ROGI0GyLVFZNjxeFCKCId6HDFdOVtoA4IK0TNq2xGZ3UOv3vtvMJznuzuPJ?=
 =?us-ascii?Q?GxHx+7pJuNB8gl3+9LR7CMy7cmGGtluvCBrMdDPqrJ0aYjkTkMr7I9sNa8L2?=
 =?us-ascii?Q?Vmq/TbT6NmbTONo1qp6dEOK/GFsIQhEMvqd321rLWkBuWaoRa+BJy+ghEjC6?=
X-MS-Exchange-AntiSpam-MessageData-1: 9jVNl/OEVyW82b87sWykwOkVXYcNDNj60RY=
X-Exchange-RoutingPolicyChecked:
	iB7LWP0losLNOSHQNYfzohcEPv1GWnd3gKHDuDyHCMRlvSXewaWgaorkYnb8jzLppYYHCGoQTHpAZq7+StldcBWy0a8Gy7uG0xCRvQlE5beFo9ikfL1NMAw2NtPorY+UfnKgrm5HjcD7Tl9cueRF5v1tSvQwn2MjzwSCEc96BaID2nCtnU6w4/QYQWpl6p4GcPVaj3C8KiM8Lz+RAv91jIN4B0nQYkchpNDs33BXalytF1crPRCR8WNYOSGd4WA93qPHHcr7UQGnHJyl8b38WVglPF3RCw2gaXvbcyiOFNQ9UwtH1Bi8rKE5vunV/O4i3X9NfMCqO1YRHuLWm+bffQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C7mb1NohuSBO6USCnVAXRVgvl/wn80KahPvMwE4IY1HtMGDSKgqAnnDX0IvZbPboGXIOnXCV+JlSpNnw9V1E1YWwIW9wr1Qm+WTWGeZBR/9fN3VZseaenfuyoWOlc9aCiX6utQeO1tJmFMrb/3GjhBoV00BcHEOA4DXyT/OJ3w1vCUZa89cOCKtaemWFZPwRSf7uifCDpRUkQRZkK/E7x+AiKbuDQus0H1XrfA4T1nZQzBW6mh0+5qDM8op3kI2XhCJQIr7XAGXRcwbucAFo6wDpKoPvP+E6wN3aI3zcllbX5Yqi/bjcFGN96Pl+X4uPITjqloeLOII8q3w2u5wnD3Vz/bfbsNMt6Ov/xw+veJaUa5eR71vGE1enEJSHapqSERLyPx1Zj144FWk/UQvE+JsjOOfR2WtQzYY0mQEUL1YjNyJA40zGC4AaIObutzD67WFs12eLeXNtgb7TPuwaKBRfEHjR/28yIWERku2cWkUVKgCuekET3KvSMA/uM3LjEhm/duTSsmvqaeVspyz+Ago4mz1d6EIir8tI+tYy2KcJvevikGsJ7PA9El2QNOssRQV0aVvah8nRkCiehZwrOGWzIbd5yPguMSOmQQ/INB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7f1c50-a0a0-44ad-8d0a-08deb7c9ba2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 06:16:57.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urEidfeK3cvdvdfvm9sy+HhhCQ6pAskJwSW3RgDae417w+rnCb1YnlI+u8XlmS8y0Xw6LKHBkjl7NEIVFGG+e6EFIBC4Bgw6YvBBkrnuu1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605220060
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a0ff4dd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=tzHnuQL2NnupJZF2_0kA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-GUID: 00gmede4J4xQPw-HOipuvD76AvayZaVr
X-Proofpoint-ORIG-GUID: 00gmede4J4xQPw-HOipuvD76AvayZaVr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA2MCBTYWx0ZWRfX4fbUXvYxOfEe
 UknIx2g2EXJhjPm/2YWXG6h/Jsu+Rj4Ofu5EwoQe8nxlyJ3pO/3crEu3brmBEhuIHTV01ZZkA+r
 61KeNNCzCKOvfdoyk5uEPZYdMRObSMvyBn8qBi5r2baWXO1Y9uvjiu1g50Mml+V1v87m+MPJ4fs
 +rdNJJLLcHFjq95M+u4imj75dygWiLcVi+lZba2pxS94tW+fBEej8XLk8JX9dhJhhu7rzo987u/
 EA8u/z+OyZa1CG3kgnCnxpn0DSHKeVdiMB/9k1MFufEt5UYq72Ggn6OyqF7huwXmVI0lxFWHhgP
 EDmB8NxDmJ3v7r4+h03b2l6huqSBPNqUDrhLSMqH7xNiFG4WEZevCvFwYHaFiGOFt9EIQhUSt4F
 U6OcwTD46TVM9F9mvjSc13ixBaWD1mM8aIoyj9mG2iORTTcrclw/4f4kSIIFKOSkxJcTFK1AFIY
 C3WC0Ww5A3dG6b839YnYHPxjgqfcDW+7IvP2E8ns=

mingw_kill() only allows SIGTERM for killing a process.

Let's also allow the natural SIGKILL for the same so that callers don't
have to do ifdef soup for special Windows handling.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index aa7525f419cb..00a994aa9f47 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2250,7 +2250,7 @@ int mingw_execvp(const char *cmd, char *const *argv)
 
 int mingw_kill(pid_t pid, int sig)
 {
-	if (pid > 0 && sig == SIGTERM) {
+	if (pid > 0 && (sig == SIGTERM || sig == SIGKILL)) {
 		HANDLE h = OpenProcess(PROCESS_TERMINATE, FALSE, pid);
 
 		if (TerminateProcess(h, -1)) {
-- 
2.53.0

