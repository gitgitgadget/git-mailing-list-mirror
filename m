Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A6408009
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208295; cv=fail; b=ubOXLO3AwNfXLttFvZxmaxpKd4Osf+5zwtogUYWBi4Z8R/5tI+57LP47CRasZ0GbwIOA7cNWMb0etwO/Sp0YiEwSy7Izssxnglrj4RR36FXeC6t95BHuM+COTWfm51G3FczPtLFIZ03pRPnHATJM6eLpG9+VwIs5vXAcSGIURZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208295; c=relaxed/simple;
	bh=oN/bYL8VwcXhQc0zbU37UhFYds3Dibdn7ld7g0Jg308=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHruBMME+pKGnTYMxb7/NV+chggD8lH/Imsfl/TCW/cqFfs4v0kkuQzvbTyOV9ieHWJfwohr3CKcR8u8j/OgghlKFDjhZViPgKssqjO5rDeDJ4hU+dwntqnk2pBG08Ar6UK7a6TJpGyGnu0Z047gxQ8tAf6BzhNL7i/nOIbuZ30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dt122cJ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iU1vukd3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dt122cJ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iU1vukd3"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JFimsV355696;
	Tue, 19 May 2026 16:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=; b=
	dt122cJ3+amItOuLRhg1OCosZz7fV7bgg6XU/jb7NYJQgoHQ2hvIztQEFKyO8os5
	6LSqI5Ic/wnbXY/SLBxktnqmoZYcPzg6og9HqvbjdCNZepBcwx61PkbCsVJ72ReY
	itDWAUnh19mVi3E4ij950z8Q6JlhGbr+BArQI0hHLtgynabI9DRwG5gg92/5lxUx
	29pm/EVQCGX/ieEKknIehTOLdR9QRvZEzqou4ek9R0LvIhStzAg+3ohV83efU9UH
	1sTshdVqomka2jyAQu1GwzG3C3Kt59rsztFMeiyNAHg7M8vVg2OTFixq3MQDW2s6
	SlkWmjTk3r33KQ/3/IQdRQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4q5566-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGUrN6025525;
	Tue, 19 May 2026 16:31:28 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1ft6pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZZCXV8YENvhfXIwYihvYS13BnPIQdY0oGN7TH7Xc7DWnf3jQFVs+V75tUWmWkwegEIFMeOTnqksltehmhZxhgmMmkXUfOQaIKRjAKgfQDY9M0xgg1xVJSZQW5wMv3GboLyBpKl3IPEW5Sb9aQTmBuaqwEZ8lyGePKGlDw++OyYiYVxLjc+F4/UugpSL328Evsxmu7z4YDrKw1xtIvZTaBqRzAyK82mpKEo9twGjwF4H+M9jtELEYLYqMjSew5tQp9gIyF2FryvM5RkLfGa28DPq3D5VwiD0RVjZmKy4aIxkwKGatfgX8G+Gr+NXEYenVoHzMcfMLgTHYkUCNXT/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=;
 b=Jn8qs6t6BMEB06eGcBIdTA5mLs6SS5zL33UGtr5iugCPDQfgwZsu/aoKRHQ2m4oP+j/UChV0PrOk2SH1J+q/xlqckrg8vsSWAuwOkezgBDzRTrJcjwQoNc07h12ZWncvrlFPxefy2SFPL1sRl4dOHMMLkY8NUDMPwEmJM75kVFm/JMj+lrsgOVSeApZ5d+6bK0TNQHhxP7KuIYsl7iqEKzrmsS7H7qN8fzOEIhBuw1NEVyiqtY1mE4o87l11TmuezYDZJMXeSftyUjNusyHgGDGBwRQ7gxbHWq7d+UM1xntTpu0LKlMnFBX4Rt9ATPOS1RzxfRbn9VPnvnnRQseUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=;
 b=iU1vukd3xECRdREAmOjb01FmmclKIo56mxJGeqr5mjVTtXfVG9TCWMi+LEaBLKIB0NYJY3/yPNJEoqH74FrbX0BUaxN9LXKLejy2pvSPqWmizf4wL8fTU9EenFNwS3Yh3DlXZ4rlF6Cy5xn0hZLW9RXsG1/SMQt482Dt8vg4L+A=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH5PR10MB997756.namprd10.prod.outlook.com (2603:10b6:510:39e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 16:30:55 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:30:54 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] notes: convert raw arg in format_display_notes() to bool
Date: Tue, 19 May 2026 22:00:31 +0530
Message-ID: <9f83b482a38bf76e29a4d12a0cfe80ae7bfc4bb8.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0064.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::8) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH5PR10MB997756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f492867-7671-4ca5-d868-08deb5c3ff8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	w0g+DzgsTi96D8Tu2EmORqBmtdTRwK3kowuRnLbs9YBI/gMefvrPeRhXqbOexWlFv23fOMv+kN3Lai5Zlvr/Hp2MO2W7GQenkcEUp4D84gkvKQ0wts5TqMDxXaDGI/KXZXnrJF/0E2aqE2nLkDvjLrf8n7Px6iLpH2n3QrAyhkO1qgX0dkGcTQacgEW+lsg+zeoJGJwH1O8o+QbEymguWlYqRH1XRsCqPfKdQ8gd4kQQ4EQuu/iYOsQ1FsAStQgsmM5sUoQtNm6mOgNHW6hG3x2jF6VaYGvrFGRub9Y8cJ+2t+uhbcjG7aO6Ozu4TN1D3PDcmaCaqwiNvEQJDI0hzJCMkAoVJZA/v9+zlVr+oYhj9MzWbLoJsegRLTECO77IxJTN4CMYuts9YU5yBan5o5oZddfepca9Er/Zg8lxGe46Rf2nZVtGkXLVj6DRvD0f0F0i1z1G9QwS1tZPsBb5h6Kmy++XBDJRFe4yf2eQpAMkJM8ySw29S6FtsrkJW0SN7T5hXGsF3u3ANaEvpsDN7Dv7khDHzoadEj5CyySkPeD/k9jVZ88FuqdCplD4ebsAFbE58D0TN+A+TH1wFOBoQhG0SlrJn2QyYyrINrxcBmkzTNzZJKLvWoS8GZ3CN7Xw7N49p6NxIS/OCOJOQitQeGy2mM7m7bFMn41crRkjpqPMAN1V2bHGj3BGJSDvYm4b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BoryJAaXB3QsmI0ydYIHveJpFZ0ivn9J7IpcQ2FSr+dv9Ceatm5L8VF09TS1?=
 =?us-ascii?Q?3QVOmKknR20DkhJ+FxxZ4Qhb6VxtbEotAS2N6SuzbHGACBk5mGniq1FQ61Io?=
 =?us-ascii?Q?kwaf2tOq9RSCD7lOrtF4TWBVZ9qBru13uK7aKzSRZ+vI4k7LYm7yzex24eHg?=
 =?us-ascii?Q?TT3dneo1xODFqDrjCnCM4GW+7CM0IHkaMfMeYTfAcxTs3Pcr1/pkhx+ML/sW?=
 =?us-ascii?Q?hy+DNrh+7xDugphBNjiN+CAZYZ+nSM5O9VX8hrMM/hSl8/UumVs/qAvjdIVT?=
 =?us-ascii?Q?FlyfN6l2oYKk91FN7HoHyX9ZD8OggCyNtKcNxJX5qkYBW0fYLaKR64mn4QUk?=
 =?us-ascii?Q?X97/vKhTze45VjtD7Qk/bbPCeL8yqpWrXP3Ub5t2HvPtN0TQ6GKs9mzM/+qS?=
 =?us-ascii?Q?z9XwZ/Pjj2lxInA+kSu5q9pPvXBqOC4R23lNQhJbVqSiw1Fw6YHED//G5r1e?=
 =?us-ascii?Q?IHqD6aO9RyxrVYEimOOqKKLZFmPi27pIaGF1IrTRfvFNb88sB/i736BF3AIq?=
 =?us-ascii?Q?cwWbsOeR8QmKUNig1bmYa1dT6y1uoj//M+gXYTfvt2QDlBblUk3ybv2sILIa?=
 =?us-ascii?Q?QvR5Z1TTtRCsQYSBgrdqLVeC8g6KYL8vtYdHxN1bFiSJ+tH0vetQ2fZhsxIv?=
 =?us-ascii?Q?3glU7EYLT8q+8pQKzB00bYEGlc6A8Q5v6iivRu/glIbnJRF4Bo+C+fJAfcAc?=
 =?us-ascii?Q?Kih3Di6EQnuPeSCCwOoMBy+8MxWDy/C8YAopaiLzqx33d2+kbMMRRH5UPHX0?=
 =?us-ascii?Q?Yt3VhugtujYjDV6bkyNBB0ORrR6zZsHGf8ncWTZnGUMqqtaywbcdIhTSIt+n?=
 =?us-ascii?Q?gr45A4RGhE+EGoFP+4H+48N2z8eUL5a3p0X2U+PuCWZ779yh88O7sW90d865?=
 =?us-ascii?Q?HeSlqsuImV0yeybVOUniUKY7Sg0lCYR0sKmnlbaIIUKuwj7AG5EEJ9S+e7zh?=
 =?us-ascii?Q?nKRp7kMWg1got/WtwBD9XXSGPRJQ0UhsmdvgiLaG4R+Uqcyo/EzQNzGAMQdV?=
 =?us-ascii?Q?IP0Jp1ZhVUdl61dwp9XrS1By6cLr8Cy+Fa2GS8OIICA27Sk7MwPkn5U9vk6Q?=
 =?us-ascii?Q?+u26o8QzqNRKFqAPCzffMKsnn4CaV5t/pEFtTxsSDbNPxp1MoCSS/mTGqbmS?=
 =?us-ascii?Q?80erSo++QQkCt8YW8Xq8x+hGC6mJhte95VAX2Eo429jUlWFNDTkcIJ57C0vi?=
 =?us-ascii?Q?U0VMe3fMdVnNvWtT5tfTk5ornCG9LTPZe6iUiFT8YwFYK/OuM7d6AMzwX05y?=
 =?us-ascii?Q?T/Fb1hM+w+NbcaLPkRwYycwdPMUtbuaoOniDJXCNnzsImQxSBcADqZJ0WrSd?=
 =?us-ascii?Q?QawOzxUplULBsYzbehdeFP3LfkfcMde4H+AzIDot7qkeBaQJ7eT4fRQFkVDD?=
 =?us-ascii?Q?KCYFOHEekHeuUyrsiCKI1kVtlc2eUCY6wMsb04l3Fww3JTCzi5vAoPQAEJeH?=
 =?us-ascii?Q?9zAa+RqoiVoUSSh9++DeUuBCfuSaV/lkD/MRIPB34aGshltrspz/XHzLs4sc?=
 =?us-ascii?Q?VAW/WWep7of5n1+CeREvAufqQs9aRjLLVFs6+98THKcwvh/G2Hp0HW1KBh7Q?=
 =?us-ascii?Q?9ps/ydL7H6hhU5Nn14mS4KjlXHMuv+WJRp0aGJUkiXGd38eP+9w0w5575K0A?=
 =?us-ascii?Q?lu16W12oqjOwVBPo+kDe6vaN2xHrFH2K69XBX76INEXvJVz/ucooBfZMIjZI?=
 =?us-ascii?Q?NUp/dOIYxO7pSm7UIgtAQyEXJniQKFmgqMoGuE+l4U2VKc1lN2LSferqfL+4?=
 =?us-ascii?Q?HwvS4/SV3+BOHsuLT8HGjjiGS+zn6A882QmUpqB/w9KRj2aUsCA5BAV+TeVX?=
X-MS-Exchange-AntiSpam-MessageData-1: Q55jSNK880ZeSt5o2qSFX02DzbXYcY5Gd7w=
X-Exchange-RoutingPolicyChecked:
	M/UOJ9R/MFASJ8gBwAGoNxU0o6iSFizRjai+uXcsr2bTnR6v6XloE44LKh7zsSy/NaI8hfLtbJ5yUjzhnTa1rgw+EMVIoMVgvGHX964uK4KDqS/GREEDucOIQ7nvY96OA7HOUt9eurV3nTMGGvuOuYHy0uX3FSOmzqi3FCmd+IrNFcaPllibgOas+uQxdFhcgCeXuCTu5UYC2L6m+WHR5Bx67k8iZYWPFM90d2sa8tuH1+FPsgvzKUlZBA3Adk4QGTWt+mWyMEhcjZBpGSHs78UMc+atkpccbumzqlzod/LXO2BHKxfSr4s176cfRwFck3sp4uf9fTee9B8upFdofA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+hxiHbvucUuRHBdwBPkU0dI5tzH0QCtjJfXNZhTiSKuVogqLA2gjGmn58nuVby/UjzQH3oc8wZJjVSjNMTshPxE5KYuOh4P15GutJaZQgBMU1TVA6xv5gIbb+RNZInKqy+/KdHgxUhfrF2OOHYSFUv+r/s0ZBIV++/iIlfPLYJnDrdg/0PVXlI9Tdw3SsaAylbV2nkjPJZacJWauVbd5qlj/YXuHdMmNVm1DAD8hrU+AoHblEOBUoAh6B+qyVzvJIOiXeoHvPc3uf2bJicxkhgROqh/+Z0wy8rstUh5NoqHDVzC78iPS4tLZzKa1cjfmYPmzTaaolOM7rAdBj051yGyAzCI5YWG67NQglhM7nUPpryJ2yFe13tX8PviKDVRe/Rmrq16BU/fVJOd9KvUGYPfI3LWtbgTyq/GP+otU/uafZxjqiC5o32W78bstBni9F2LrhzrtTAlApei/TzkV33tFpz+V/Eg4IxgMRMF3oEZGjAjFfoVVtaJYmAvPnCSiJRBbnUaszejIFNiXovZKQ34CwqchjG3rpWt1m3wQ/3KN+sT8GvuZZVABw0690Gml/SkC/3HQCkvKE4Mz02J7cJYy0BdKPImxvBOe4+QC8II=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f492867-7671-4ca5-d868-08deb5c3ff8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:30:54.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5dpVgkT9dQ+/zaDukyEkzo02u/HJh3B9NESB+5nRGAl5qtZpAbocNZgZrijclmrw5g05GFq3wgs9ef+Nrx0bWyf/ijJwsw7HVJsbFV1tRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a0c9061 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=5U6ET3mjoD1Y2LAbGjMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-GUID: SZZGau4Siou56hdmXEdlhsXlVJ-3PnGK
X-Proofpoint-ORIG-GUID: SZZGau4Siou56hdmXEdlhsXlVJ-3PnGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX+e2HIre3U4Ns
 yU4inY++fL4K8FWb/iJBBjPnlwBlCCsMPCxfL9UVJZcIeR9pHYOQS++bcyn0FiVjFbSMyy7MgcM
 gk9ryHIEhlZYmO/4l+rwPkPMl8RZVQLzM4CLMGzRBtL6yk//M991kTXuASLQOBl/1bKjpVjicP0
 QXSTEWfKD9WL5OdfHLN4jgrxCBH9uDHjWAlTS0UpxAkzbvPBb0sruAhgrgYjiKgVXDwOU0/rgoB
 ChV+pTzskmgIJu0Q6W/CnwVLAw+508g5OAF3jPMsAges+9HrVHdXpuENFhfDrwfaZYm0/dNxds+
 NJnR4dPtkcjZJIyWQbyHlhNyZZwCUycN/qQkWgk4it5TkkKC564jjbdOtyUFlE3LdYBGVm0VF/h
 8c3wZclaBk5Kk1syBjGBlPSiLAznsg9MRpggk2Jf8tSPDOZUufv3q8h1FKKKTP1c2kFTAOKRkcZ
 tXZDugzWec7sr546iHFxnp8QFAre/eZ5HcNNi62Y=

It's used as a boolean flag, let's not use an int.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 log-tree.c | 3 +--
 notes.c    | 6 +++---
 notes.h    | 2 +-
 revision.c | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7e048701d0c5..4503a42dde6b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -854,10 +854,9 @@ void show_log(struct rev_info *opt)
 	}
 
 	if (opt->show_notes) {
-		int raw;
 		struct strbuf notebuf = STRBUF_INIT;
+		bool raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 
-		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
diff --git a/notes.c b/notes.c
index 8f315e2a00d2..201f1df3dc29 100644
--- a/notes.c
+++ b/notes.c
@@ -1273,11 +1273,11 @@ void free_notes(struct notes_tree *t)
  * If the given notes_tree is NULL, the internal/default notes_tree will be
  * used instead.
  *
- * (raw != 0) gives the %N userformat; otherwise, the note message is given
+ * (raw == true) gives the %N userformat; otherwise, the note message is given
  * for human consumption.
  */
 static void format_note(struct notes_tree *t, const struct object_id *object_oid,
-			struct strbuf *sb, const char *output_encoding, int raw)
+			struct strbuf *sb, const char *output_encoding, bool raw)
 {
 	static const char utf8[] = "utf-8";
 	const struct object_id *oid;
@@ -1338,7 +1338,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 }
 
 void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, int raw)
+			  struct strbuf *sb, const char *output_encoding, bool raw)
 {
 	int i;
 	assert(display_notes_trees);
diff --git a/notes.h b/notes.h
index 6dc6d7b26548..f6410b31e1c9 100644
--- a/notes.h
+++ b/notes.h
@@ -313,7 +313,7 @@ void load_display_notes(struct display_notes_opt *opt);
  * You *must* call load_display_notes() before using this function.
  */
 void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, int raw);
+			  struct strbuf *sb, const char *output_encoding, bool raw);
 
 /*
  * Load the notes tree from each ref listed in 'refs'.  The output is
diff --git a/revision.c b/revision.c
index 599b3a66c369..cd9fcefa0a88 100644
--- a/revision.c
+++ b/revision.c
@@ -4107,7 +4107,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (opt->show_notes) {
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-		format_display_notes(&commit->object.oid, &buf, encoding, 1);
+		format_display_notes(&commit->object.oid, &buf, encoding, true);
 	}
 
 	/*
-- 
2.53.0

