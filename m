Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C64BC03C
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208296; cv=fail; b=YQzXXAyNz+diYPT23p5SNhys2P8dWWO0PQOAmSTWKdW+oXwCezxBE9QRJswkasFTsLD9oBtlqaUsHKdjO+RYSFYkf+Vfm+itOaZg84x4iqqwu9HfuBOrP26ysfDv678Hgx6RaKZhXMJCQJ5GcoHWcpZ8o1v5zSidFom421jo8BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208296; c=relaxed/simple;
	bh=dUlUNX/ORxfw/JNk5jh/l0Zz8xWhRkgu03JP4vAdCHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZEzSbsaA8X8msT/3V1RBPhBgAbW4Pcve4DGaStAuP1JzQ79t1sBmImSozhY0VZB63O+mGGkUJKA8vkQmXv0VXVv98n4QupylfEpJlUh9s8jCrRGt9YOvLofIa+YMDycMOl06kpjPHDp5zhcHKyBumjOwNqCtICLGEFVzgobfJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kL/jDIYx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vYqJEqOp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kL/jDIYx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vYqJEqOp"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JG91GJ177948;
	Tue, 19 May 2026 16:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5hQjeupvO57qvXMORC5PIDbtSpWTIMznzQKLE3FhoFo=; b=
	kL/jDIYxnlw0Ym4Thwb0bO+NlUlGk4HsyswYSz7MDLd3pK9t/sH8G5fe8O10Oo1l
	0vVVy/qtQZMsO3W4Sxo7fjWOAUtWqoqAryvr9MZxiCqfrSym6jvtl3YEJjSPqxiU
	xjBA4Gh7c2rEMGhKhYTvOyf9H9nIWuUfCHiwRYBAV5kFe6qF4c5ddNUPZDJvcPG+
	elWhx63MiqF8B34Z49dMYpVjaNEa4O/CqelnXb42TpXmAYT9eFs0+PI6MEGBCBgl
	Vk5BCFcJs0D3El7/Nbx5EwBfuxlf1xne894I83TwuD/gLwMurcHmuGQLp7so3Pc8
	Eq/BijDZYHPQqbfugURdaQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h86w4ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGUrNB025525;
	Tue, 19 May 2026 16:31:29 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1ft6pu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbgecnJOMyzTB6BW00i0ay0lZWLn0ru1352nm7LwKS7Vmb/7WZ/Bi4BMks1VJlUkZCEdtAPR6AbIz0qbzWN3+E5t9BvKK2QlGuWk8zFcX9X7qtZLeRJM+TUVUfblInYWbHjbnWvmz+Xj0JQZqqc+gAuSWuH0Ennf1m3z+AeE6QoAtNLhcIhjoIFhJ2ifLmjpSqCESLAVQcS3X1jEQb+xg/xN18SxPaW6lA+7NVm9kOjd/I2IN+tfbVIDezZbcvO73ThARsbesJf76bWm1ReD6kmvGo6wZ+yQ4VL3Lz7OGynbBOXooHNESOLsD3wHMrZlMwOkWhtgQYsAeE7P8KJs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hQjeupvO57qvXMORC5PIDbtSpWTIMznzQKLE3FhoFo=;
 b=H7V3NSGXCQndGbB55ZrCssTDKIHPbYD7a+MMcN7ZvhdjOef5jWqHj5teeKCN9TFYt+uxtIA+fLQZ92yF6a9o/vAAfKm3pESrkktnLleSQ2vwKWgBd7Uxd6q6wK1FwOh3I8xx6/dQScdau4LrY/r+wEOAb4qs92z2gqfTUDU57OZmSqsuRXGL783AuBVlQ9nstm929Ar+iV71ce/EgYueOcuA2Nqh4DFwTUofUb9FxALw9I/vjXRIceosZtTy5Du3cT8FfY0N1CFNn2F2mSVSbfOYtKLs0Yh7Mr7xVmHkrfEuMrqsVEis2OTI+Io3GHvAPs0F96vTxxIppUjPzgBZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hQjeupvO57qvXMORC5PIDbtSpWTIMznzQKLE3FhoFo=;
 b=vYqJEqOpMQ5scC+fGpQU910aaJnfaBtUHO9suHpPWpUaVLPsLHAVII3iNqzSa4U8Z4m5RTz8760zVb3kiO1eDPSbsRxFhfaG4K49MiSi9+B5ZDBRvolNPQgGr5EfV3DBZoFXnFSMY3st8uztKPDBPRa7hUhznVYzpxiNwJBv534=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH5PR10MB997756.namprd10.prod.outlook.com (2603:10b6:510:39e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 16:31:00 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:31:00 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] wrapper: add sleep_nanosec
Date: Tue, 19 May 2026 22:00:32 +0530
Message-ID: <6a8c2093643a385641ef0b2cde33839dc98d8678.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::7) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH5PR10MB997756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8846153f-dcc0-4d3f-f047-08deb5c402cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|18002099003|10063799003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aYL3Zj/r77jfg3WClrU6jshZrWEHnGFzYTm2BtkAoXtpWw+KmPbQGc8HJnz+qveBzUFg0OMnNEPsQsxE+/mi5qirr2OUvamVJ67OhoxMW8GPLBJ+vkDVvtGRElDmtpEJJSmdVwuMW5hqv2JdifKXVK88owT6dWt0wQz5hGIW68adrd72fwy0r3autjAjCx2v7kv+qf6chAu7pxFV/qqisgZKO1z9ckLFak93D0mYpchH+Z8LcxiS3xMmUrgpJqFEbZMsnMuJyg17e2I6meN7Es7br91YQbreRUbFSQQTAWBioSmJqPfWc01ZZeivMAz/auHa3s7h5ttBGdBJFKRn7uxd+aBDXnZTJzKW6SZIwrdoF+nY+COwYbcCVx1MEVdd/NEkaquu266Ctc8jMC43j21AjZKdKf5s7BTY+1+5ukgLNRi0ObtSwtpIxIwdkFt80YODZMMlksT6ifbfWD/Ey06NOwVOdFwN6v5RIdhMC6NeyrX/7KmVDHOANj/8jLrO9YyMLvX0lvcvXi6xbR1QgssWU/Ci41I3lFUZXt5LhrK5IZDNlUNcoGHMMMOeiGSGqBk6t3JV1nOXs7ueMSfhVRIInpR+HtPw3LEvWcAkzvME+BFRHhICmGWosQf9CxRTe83qPzpDKulWzLLkGu+7pcS1lfgVMPJ0+LeRSGTnlWY9qihJmGZU+gcl5VFBIYHe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(10063799003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRaax4kekIop/z91Xswshm5N/ywDmhbAbv6yhb+ElOz0biFLkfBnmlpU6Gb/?=
 =?us-ascii?Q?63Cu4FRxnenl6rDTto7+QiOHyGsqyoc5Kpe/uar+hOMEWU0jny04i6sQulTj?=
 =?us-ascii?Q?Y8qDVR/tGEMzA5jcmekVLm8eDd30U7Iiav4TkLrL+RPYsEExi47c6W3wrP8Y?=
 =?us-ascii?Q?nGQucqtRbYNMzhXVojA31ggaCx7+w3e6GEBjJDzI7etPAS8XREQqMua8XlT6?=
 =?us-ascii?Q?wUmmPGLlfCgy54AFHtRfNS1HSx0IroGjvUb367ONgQH97YcimcwaePv6Y3pi?=
 =?us-ascii?Q?jBtRqT6L3mv9n0zkQrxfp189tp5U5ea6YqETaaaEgAarGlw+J/PSfTzcywoS?=
 =?us-ascii?Q?nodwErc/nXDZ4jbT8MqBKmqljrolDPRGPI2iktkAVyFXaBsDZiPnXT8O7+zu?=
 =?us-ascii?Q?/GaZ4Q+11zC1nM9CN+dPo0EKC0GE69uDaL/UW9Gup4Ad4h0wbc116z34/jO2?=
 =?us-ascii?Q?hfiOcIeBkAHckhvz7fVIvujstg/j5Uv5XNvCm1s3aC7gqhoV1fFYfTjxSN5r?=
 =?us-ascii?Q?kZt7mD3IamGTwH1+ulHzKvkmGmLq+HMAhoZ1m45VhEu+WEBrhSn7WXeXHuXL?=
 =?us-ascii?Q?3U+eHYjLLCN0XYFb3+hcuOV18KOzGVm0Shm2NICkhegugm1Hw7dBynJRfDxR?=
 =?us-ascii?Q?xI6rluBtFrCRlHKdKryT5xNOmhbwj50iTnQRc79LJ1+CghJCoNo4aG9kahYU?=
 =?us-ascii?Q?82YNLAN34q4mLVtPBTN6Julq7koZ0xhbsQ4WLXJnN5ToOrgmsJ4pBP1AXzAN?=
 =?us-ascii?Q?hUJMKBy7czBKqN8jYtW5TKYDhWKojotJDrtDTooI+oKadT+p0JcjXekWtYlM?=
 =?us-ascii?Q?h6EJ5Muqhz0yPXxYYXYigTElMfJObn7zfUUteq9WokPSuOjsRlK/N2S7U5o7?=
 =?us-ascii?Q?4s7ofH3EGq+5rLmQLIWo3o3Tmo/Pzo3qK0k+5YDGHsRcJ4DAKfxeBtgId1w+?=
 =?us-ascii?Q?8nodtLjqudhlnp2FR7Ns01HVic8Q8SNIqOHE4kU+ezT6S0QP2rPPDsWIrU03?=
 =?us-ascii?Q?4f00EKZ1I06gZHN9Ski73knRZg6WymRId+xmZ+Wn6/jzk7aG6/MYA6xk17Wm?=
 =?us-ascii?Q?PjZtZYXTuK4exNrSlzwlaT/hTbq+7sPk8B/cO1qZvtuz7LpjqBJELbJVNOZT?=
 =?us-ascii?Q?Nd/Y1qi12x7ZqDUKkJMaQnzjMdg02NBoIwxUXY3H6JRhWkJ5iZWItDEIfxeg?=
 =?us-ascii?Q?GfH6udq1mDRQ+X5iTKDRr3SGjfgENnPOoHR67P6plBdrGOMqapnC9pNPnvCk?=
 =?us-ascii?Q?ADufsya0mbXzck2CQAyzQRKrY5d5pxMU18hvWd4NL0v86caS6fN2Sd/2rsnw?=
 =?us-ascii?Q?iIXob9HKDKAWsLDcZvWgHAS73Bq5uFDmwnoLDRCJa229v5uD+QimmAgyurjS?=
 =?us-ascii?Q?Rqh+o5r+yJaEaccSN5e6+tEMkuX0nl5o5JNcPDjDKaXg4p4sF91KbrYoKZ8Q?=
 =?us-ascii?Q?uKV1Zmn0JD/kLUHQZNQLtWZwLCOH91G1JNJysM8sgmh27ZgHs8sQTx2NAUhZ?=
 =?us-ascii?Q?c4AJh+QuXRjy1wZ75+BKjM7cHFBGjlRzyNLlnNdvV0EBHZ0k7eJhNYJGlAfV?=
 =?us-ascii?Q?mJkk6+F6WubUe92knC8zHsUU4ryjd0JkDMGM3eDkR2HhkStx8S8GWsRQP2NH?=
 =?us-ascii?Q?eGhIklSS3OIIPTHi3+2zJorIzG8/wxXPf0RuwTUUKnWvDY8FHO3JdpNp+Age?=
 =?us-ascii?Q?mzZH2Q6XXB9Vw7DPEP/O584/VgtdudnVAImMKxZJatWlJncin8gaFrr18w1D?=
 =?us-ascii?Q?NnYeiq+y5fLVAYrcSP+c04vJwulYrtSuFqD36iXWxqEA7+lxhKRZBvizz0L1?=
X-MS-Exchange-AntiSpam-MessageData-1: +YDoq3rCFFCxBqqy/purjg9TcS6ajBHykjw=
X-Exchange-RoutingPolicyChecked:
	NGPUu36lfzqIebAmJcbVd5Rm26j+4stAo8TD3GQ2EGAU2WUbX5hY7ojtTNvokTdznnWssvX1MvyUlANIFozU/p6DQgE58apRZoPe5TX76LsBQKoU/hu8Ky0J+94xYu4EbYzIew4FpQGjdgZ1lxEJs+cMBiqGtWCRqNF0pv+I5de4n5H9BC8S3Ghc4b1cQ80hk+xiBodM7TkyRGV7emBd2jbDYz0sYQq170C831M2xVNHCMG1m3uNdPQbqWmSGjiXeYSNFrh92yLPIFMUuFZHY1xq9jhrGTtEOHh0AgmvDk1TSS7trhxQjMWys7EKScByw0cMEAucXUZyyPXGKd4zoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KPydcPD8+awvKRqNGD6rat6T50/JPgzqdIoW5ihLrqpS2y2vVs7ksATbSXveUcQaRN/ERkBj298Jv0qNmd4BCv+DnBwOnJKTi0/kZoQNFruztZecSOqmHqkkVcMkr7TrRV4eCEBRT7X5Hv19flIRsTtpt7vvBCo8DTlE7eSxrrgZb+VxjjM1/2HgVKkRpxUTEPCdO/7H0zeSrnp4nOmMf4qhMmh42JsVKkDfIUY0RDaGyosnsL5HiRHN/0Led+CIgyNCT0d+ztCU3nzr2eug2+Yd1cGQwL+Z1hyGor0i9atzcN93oRlghElJnLiamorUYi/DrJvJvX0gc7Dw00wNx66yDWAlNzNo33aHyrly47oovwWvffXDL1IGa68vAF0VVunV9G73IEQCDtUFDDjcVZVC5z6WSUCNnCMuDGxguE3zOR/pjSgWZv9evkPqKIkHN/Tl5zIEPhW6CC4ykUj6rqHbhyeZ7uGaj7kcg/ZtmS5imofWMDiDojK3PpJi66DJo9pkBqpsFTlPiCXwy5W//iDBV2hw9nAlqMXNGDYXt9at9xYKmKqtUlY2FB94JokMoXCjvm7zkH8u8V1OiaK4n6Oll+3J6/USid3S1+xW3mQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8846153f-dcc0-4d3f-f047-08deb5c402cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:30:59.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuMF6Nl7bChB8OPvt+WQQ8KZVzIF+OEgSNl61p3DZB9FyK9URnjpCARd1fCn4T34uwgOMCaMwEu/ITx1mkhvaDSZIqm+JLNVgi9WqwkR29U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=966
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX6p7BWs/6jutR
 MvoEBPTLBh7oyWo2slMnDPbFDhCWBOMR6Etbyc0engdvnVfFU+j5y8Bsrv/9uU3eUkwWXUhz33Q
 a/ZlibmnXRu8Hq0DKVhFlUnSV/a6I+qbQSczo3TzK01YMBn3VVYcCHS3wOFeIAVnhAeNK2BB/TJ
 4bbV+9VvCXazKQWtRhKDadXpSk4N6Ncjgr7djRhnuu2yALM6nZbTEsOKJT8YU4Z2GqXpMaGHon0
 KPx/LmzEL2MOL6GFhztdLKMB8LhCYmV+hp1kh9fnNip92xhc15pynw98sf6idTUg+6bdGHGaQ5w
 8m+Y36HX66kBtlrOZpegN18SmYNyMIxKEuXVf3zeD22ZzoWaMP1TrVX14GGA1ABv3GRStqefCgX
 c8ZYQphr1/Qo5uKkkHfYqzOmnRqgOoIAmuEAQLAN3TY6K3ddbbL//eHOVQeeH2C8Qe8gfY1ZQOv
 x/f1Z0oALdv/vjcWjRZmnqzZ6Gont1PmLOIWYEbM=
X-Proofpoint-GUID: yGCj1_PVmBOY9bx2IP1oGLWnxeNX2wZW
X-Proofpoint-ORIG-GUID: yGCj1_PVmBOY9bx2IP1oGLWnxeNX2wZW
X-Authority-Analysis: v=2.4 cv=TLN1jVla c=1 sm=1 tr=0 ts=6a0c9063 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=1XrOGu6-xn8UHQLeDBkA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 wrapper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 wrapper.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index 16f5a63fbb61..1349255f1eb4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -10,6 +10,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "trace2.h"
+#include <time.h>
 
 #ifdef HAVE_RTLGENRANDOM
 /* This is required to get access to RtlGenRandom. */
@@ -708,6 +709,54 @@ void sleep_millisec(int millisec)
 	poll(NULL, 0, millisec);
 }
 
+#ifdef GIT_WINDOWS_NATIVE
+/* No nanosleep() on Windows, so fall-back to using sleep_millisec(). */
+int sleep_nanosec(uint64_t nanosec)
+{
+	uint64_t ns_in_1ms = 1000000ULL;	/* 1 ms = 10^6 ns */
+
+	uint64_t millisec = nanosec / ns_in_1ms;
+	if (nanosec % ns_in_1ms)
+		millisec++;
+
+	/* Chunked sleep if we can't represent in integer. */
+	while (millisec > INT_MAX) {
+		sleep_millisec(INT_MAX);
+		millisec -= INT_MAX;
+	}
+
+	sleep_millisec((int)millisec);
+
+	return 0;
+}
+#else
+/* Not Windows, so use the more exact nanosleep(). */
+int sleep_nanosec(uint64_t nanosec)
+{
+	int ret;
+	struct timespec duration, remaining;
+
+	/* Construct the duration by dividing the given total (1s = 10^9ns). */
+	duration.tv_sec = nanosec / 1000000000ULL;
+	duration.tv_nsec = nanosec % 1000000000ULL;
+
+	while(1) {
+		ret = nanosleep(&duration, &remaining);
+
+		/* Continue sleeping if interrupted. */
+		if (ret == -1 && errno == EINTR) {
+			duration = remaining;
+			continue;
+		}
+
+		/* Either success or an error. */
+		break;
+	}
+
+	return ret;
+}
+#endif  /* GIT_WINDOWS_NATIVE */
+
 int xgethostname(char *buf, size_t len)
 {
 	/*
diff --git a/wrapper.h b/wrapper.h
index 15ac3bab6e97..c39992893a81 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -130,6 +130,7 @@ int warn_on_fopen_errors(const char *path);
 int open_nofollow(const char *path, int flags);
 
 void sleep_millisec(int millisec);
+int sleep_nanosec(uint64_t nanosec);
 
 enum {
 	/*
-- 
2.53.0

