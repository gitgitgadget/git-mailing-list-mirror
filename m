Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAFE3451DA
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466212; cv=fail; b=VgGVfLWMkfiu9rTNv+ly0kRZDfnNNrNtaahAo29pbMx1mZZ+WF7iiBuqxIoqM3O4YOko1xmWorIhiTsz/q0U4vADtimf8RNtIOcs9Rw3ivY8Gz8vhrvAJNO4Rofmk4B0qhVZCH8W4+jkcmF8PObDS9yj8wYf8jboJmvZqzbZCa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466212; c=relaxed/simple;
	bh=mhMlcEHR0kyYhXQjT8dSgngqKZkUToJL/0FV/rBqimw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kVNQwdW8GI0lTeQ36Y+fUQ6GuvlkMJ27EpsPggZemQM+c1PYYK3u07pUrokGqENn+GfmE+HnEWSbthbrniiJur6Y2i54OvpZ4PpfjrHqecR7tiuf1PDe0oVKTmAuG0hvoi83ur+seVRHKd0aQ8v+j/bTHdgw8MXfCEL801fNZnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ViTOwI6G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zWiE1mhr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ViTOwI6G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zWiE1mhr"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MFmW9Y2077787;
	Fri, 22 May 2026 16:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=/BEvVecLwMWIP77O
	JtyUElGzgLNMvsamXe3u6HPvKaE=; b=ViTOwI6G0UfqjoBxN0vrLIkIMdWBYzu/
	d4xpsZBD1ub4DDiXEyJ0jNyJ/jb4M4bj4dkKEDVOyntH/SqHWSGl4lDWdIFtXb3o
	5tOCbW/gEJTq2DsmA/Wsx3Z4iH3Ni+GeL/lm4799GkHZXLA+9pcC2dJwklfO/VUD
	AQZx6Y8n/fcoX9mXA/qoZty2UyIB76/Ep3aX9PAFbxiAWu/P3VWkf2p9YJ7cF/69
	DibkpOgapZ+JeYaux6ZTRMcUO21sWwH4gsB551L5bhEdH/Bc+TrAo0Xe/8dApft2
	uX1p9Jurh12wtuR21HDyBkV/1Dv7W9Pb5t5FY6PlRfcl865E6JDMaw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4qbe8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:09:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64MG9jpe031440;
	Fri, 22 May 2026 16:09:50 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e84egp3bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:09:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxi5Vcf/JtTlHrHlbep/9fkrGWcGTZdAxzjsXsrRO9rmhIaMrR+pGBE6j85ySgfYEvPBck1Dp9mE4rN8nM2Z2OMdTbAmWb5ajgkbPPRECE564j2fvLNlU7wJock0QuOQpEr97PwgmuD5SUQ0AuXdWPch4oCTh3t2/O1tMGOr11Q28MeN3wkAAko6KmY6pMJErqixP7ItyPZKj7EIWbCKfIqHyMT3vs8GZk9Pl/oUYqp/R8YU30MF8H7BgnR+mQ/oeSRhV5JqTtB4c9zTlYcWlJMa+MpZIdPAwjv96TsooBlfk/AJOijE8k/P25kuLKLCQia/k3cx/D0DJLo6fmsGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BEvVecLwMWIP77OJtyUElGzgLNMvsamXe3u6HPvKaE=;
 b=haJ7aRdjuPvpplDIJpbBSRel8Ja49IQDuVEedE+FZv49nzzv+NVghSVJPfx8v5DkXTDNV8et7IAjTz9pnSL9E0O/FIMN9zPiS8Kxpl4g8iJPrxsM/qziERvUCg2+iPXbk7OR4kQRmKFa0LAN9VtH0RqGuPAX2cV3iLuBg8nO0q/slQZn+xolG68IEWep1kjF2++FWaybIR126sJ7z7/V7Lubol4LqpG9hQQbh/KePU8h5+rszMtEXH037tv6gb3+K2VGeUr0yQuo7SEJTcLX7WtrW0I6M071LJQAvlYHHWb/XeiS+7QDxuPLBXlxR1tDX5t8kRBhhNq4T5NqqyINtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BEvVecLwMWIP77OJtyUElGzgLNMvsamXe3u6HPvKaE=;
 b=zWiE1mhrNYL8qlh/RUcvxxq+csBq1xpclIICR/5fT4bwp+9sr+5iaPh1vAfRSuAgTaeYw/UGZ/IZsPD2NX+dtsBFsBL4mh6r8KJbM75quFtkl5PLU6RrU1pky+JIegdyKSUhqlR/gA2cvCsgV6DMBvxIFKzvAFmXAgzZUR9jqPk=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS4PPF18D5A7206.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 16:09:45 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:09:45 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 0/4] Add support for an external command for fetching notes
Date: Fri, 22 May 2026 21:39:34 +0530
Message-ID: <cover.1779464886.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::7) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS4PPF18D5A7206:EE_
X-MS-Office365-Filtering-Correlation-Id: c7df572d-477a-4a5a-05e0-08deb81c8a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6iYHEQHgyTZsSJBi3F4FDrq4GQCu06Jg2M9TcXQXXmZHelTUq2SoNkrcqxbgqkqKpFTNhLlah4uupd2YA76BqPehp6/HxV4yqPHWxEVRKX08VX1qodbESqeNUdVfI6qblxeiLJPuF6aNHQmzqZB7kAafVDg74XPM4F6VigtkM0CswFT5TvPewR+AuvxJKtIO3bIuuNdWvcNJOCugAhv1gDxK2XtCBUj0a0SPOBhY1/Aw/H7R/ga9GV2X0G5/tK9Vczg1xWsw5WzkfkADLDpMU3mKw5gEqsS/3Th/dyaAXaTUr7xvTKo8MVtptva3BKC3jmsygiIvGLuNwnvTP5lUOkY+abWReTVTjexMXPpqwHvQnj1iHijgLC8y0KXxZl5DOeOjNU7KA11MCFOdTsMXujMkQZkv22YUDN7l+X5rvGewTKUCqbwnEydl9lNRX406AROt6kriihJnhlvE7qouQtYpBuX//3AL3qAbdwBfrS9mMqEXqYe+r4niMPFWo5AgAvrB7m3qoWmvsyd5tvp90cAcBYh6n+5u9tSS4dNoJ/bX+OQov1tSDQZhiFuZ5YLzTQjFKjX6r+XOFzzmbNCfP+rQzmdhHtqk6ug0ncjoC42Q2DAnCZjkCE/feFSuX6x68FMJMQI716z7ioIW1Wws4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0MjZpr1xiusFCbk/QB7/fQy3Cz2mKqCI9pOOI58czFmjgf8yPWgtfLhwuDG8?=
 =?us-ascii?Q?F8ssuagxCW25VWupAOCupnWSjlBfQlhTH7hHoiXQbzv4q+End/cePhdmH2b+?=
 =?us-ascii?Q?nHH56KwFohYUVF0lupQzZZTVJcl7I8iCwBuFjSQJoiTCTl60jks8KsxHnjR0?=
 =?us-ascii?Q?jJ5uB1Grq8gnB8ZvKs4BUC8AFXa2iARkbkJyCTXSQcn6uV6TkzvwGMTD1uMA?=
 =?us-ascii?Q?bHlKUgSfeSEf4/8Sk6T+Y1awHGMSHDK+bSn0lXAIBqlh4Bx0iNcAHoyaSNrv?=
 =?us-ascii?Q?/FOiDgBsahjhJAsfoA31lQRPIZY2/zZzeriHMekeZyxA9Q3rVC+yHg/CI8qQ?=
 =?us-ascii?Q?Z/1PRISjDE6VrtsAN/WaHlOJcnX32Q5pSStyBLD+dXOSM/7bNZO3vMbWuR9Z?=
 =?us-ascii?Q?4Ep4Tum5c1Ys88TKnNuyKG62+fI25fLzc6cmQpSIeLeiV8wct+7u6mjhvSWC?=
 =?us-ascii?Q?i/aIlo3bi3/x5JjZYBw/+uLdLAAsZwecDykmSRrU8SBX5m8yo9CvTiNtRb+J?=
 =?us-ascii?Q?HJ5xx2qLSjVCcHpfohAKLo5J0tBZ22YMcY8pPWI7QA5xcKtXrpB5sc6kH3Dt?=
 =?us-ascii?Q?VE18c6cjd7DATw+OLgYsImtR+k9/mMto9k5rVCt97A/ZqCXtAUWVfAij9K1s?=
 =?us-ascii?Q?iVIr+gUcidrQ2EFVpagn6sEoOArK+f0JdHQNt++3YjnrVpRm5l8Ax/mQAP0I?=
 =?us-ascii?Q?Twq22rkb8/dZSoiMpU4uXqWDeW0nzywR5WJ+qSrSdC6eiM4vHd8o2pQdLk0j?=
 =?us-ascii?Q?3f3QGFUHbBaWzONt+CdfKpdk1BdrW9K0OXBEA9BdKhqfiuXRacgGNF9LVqEW?=
 =?us-ascii?Q?8It4Icgkkh8DHDT3XNof8wW1zJ/y42kZglc7LQPtSFbosY1y1NTpTol3Rjzk?=
 =?us-ascii?Q?zQMsfTSMzLKDwudm1rHK1Aqi6n+c2qRPVQPI1ik0UCDXRhrKPRgo4g0XHeRR?=
 =?us-ascii?Q?8R2NRYv1uhYQvoOep+Z2QorC7H+OEYJqyhUQmr4FnqoCtC0IUUsH+hX2OOor?=
 =?us-ascii?Q?SA0p9dZq2xwaqd6fXw0aPvGW2VSNNppA7WcVEe5Dymal1clPZX81C2DJJfeh?=
 =?us-ascii?Q?edqjeqAhER6NBcB1Pouk+Cw31Hs9EYNO6va6NcQ7fuczCGH5mMuuaK0PT22d?=
 =?us-ascii?Q?SRNzp1BWasQZxGsVRrEvzxGpyRHe5IeqwMsqNcMY3JrRoZgXKSS2s6ZnfI6w?=
 =?us-ascii?Q?4G4Y1dk4VKkrXUmS6UY/z1MdRWgrrRAc6zEZHYXCHJM1CsERuqYM4LEYSvIt?=
 =?us-ascii?Q?41iJ4HQxHrY6/XsnXWDYAabTubK66uxbUKF0vmI/r3C1coZ6G52PH/XD+du1?=
 =?us-ascii?Q?TiuxC3dU7221AatBOXEJdPymSthiQHuAIRvwgUwuIDr/cU6I+qtMxOUxYP87?=
 =?us-ascii?Q?p4Nc0qWzlfLi/1Dg2GfVOo9BkiUOFMfLceK4gR/OGepAIBAdcoRC137Ak63g?=
 =?us-ascii?Q?0XoryOWuFU+Z79RfD80ca3F4Jfx1yV0Um7Y1D+/SFUHyUwq3F/ZCKvtPvdTf?=
 =?us-ascii?Q?CHa7KFSJ/DAv33BS6xURYLHVf1/UZDzTnma5ABrpodKjhiBBwt74iqZgFAJH?=
 =?us-ascii?Q?NnQOI7irZTkoKGI6BVx6Ou6tRkaCmA05HbdmP1QA7+WyLr7EJfm+axBrcPLF?=
 =?us-ascii?Q?WgAq2dKjPK96DwSCbUCCW1x9lilro/HMz9AwBR7d4Ml/jS81GF/bvOjzwYl3?=
 =?us-ascii?Q?6/gYL3kX4adzexcNrYiNjFAxpnpaOOWTe+/y2Ms2cNuZsmk7DHLqv7WOvxg3?=
 =?us-ascii?Q?aVYEkqXn4WcU/Gg8HhnfZxUxFogeSDyHB9I1cd8fhjEUIFBJncwSnZSPlWYK?=
X-MS-Exchange-AntiSpam-MessageData-1: mVWSjbTxkluppKke3+wq11T+W1MEVIDS5DY=
X-Exchange-RoutingPolicyChecked:
	aL+DeAL8cLwRHwA4QUyzalb2BvFKXwJEnBBc9ZDesXcmFEh+VHJ0QFUlV32T9DDMijy+8x5DWcXRGuBh/Na0UaEAW0mFNp/8twSNlEwMV7e6NwSr0dNeuk4iqCwr6ZWIimGG0xOh+4DHKO3Co8YkRmnH1/ELw1EYKhpiiz9rH9Kd2lUCjgrz8ohBgWKMRnSBSlB6G0TxK0uvCU9G11+RLauqxM/Vd4fjpk8Hij/FgpnFYAJjb5nHXD4VvkZ2J9gUWqcDHtUyZtryOqtRIGNE6LzKXDILQ5iuprW7OkIYNVREmuU4N/9b4+CIe3YfY+z9wKVCUSqOvKtzK3TBn0eI4A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+RFZQhHcgGspSmd459lunYYM8WJtCjU/DnN8oRpCUdUHQE5R5/t2OCIBfpcdw4+mjh1BQqpppB5hzt1/E5aDj5WqxT0XWIy1gH1HiStfBeURsY3wy9Q3C1mtQpR9XAIXa1uY7HkZOsGtwNUmF71M7zR3frjaxevTqmDD3/aEIr0S+byf5oZEKDvUQi8SW96uHpbMP+6GEt4EXT4/yZz5XuL2OpEFBv1Dd9JzuuL2AbWX8PZparzP/54xZRpaDkZphHNhYAjUz5K1uEDz67On4zec9Mq5soGvktZrP78P8A+Lf2rbJGsFdz6LZaGidmpUk8vgIgPfdL2efMzRkmttI94wm91rTScSJfeNoXDSBc6ciFP5A3qloInwIBD1Cg6kuJUCYq/p3FlqckQ6lyrMk0G7jBrw5yw1p5ov/8d+7B2ODwM0eLhN+N3xd8oXWu2IiCRCnS6XTsoNVCcJ4+O0qkPDafrxFkh4S/7bAOqiSiyXJpYKg79+rHokNu0fJglzyA8+09Q0Q15P/05Wc6x9JIJxM2ebCFeIkdKxsYOmbZ+xwI1ao56fbmb4gwVkZTattpC1WvesiNwDjIyWcQ/wCEfQ4wek8wHtpr+gS7XCPXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7df572d-477a-4a5a-05e0-08deb81c8a6d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:09:45.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcJW0kkqmfxScv/Rp2uhkU2eCy+5v+VBLEzSZ/QBX5cqp/97cDf/oUpLyE1LjOnoW/eSRrOH5a7MJvbFHKmvy5if7ojxfSogijAdzCofUTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF18D5A7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605220161
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a107fcf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8
 a=j7_DEPc9-6Edas1kuEYA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13835
X-Proofpoint-GUID: el6_qELtBUkKC-st64cIzg9tdi35BhB9
X-Proofpoint-ORIG-GUID: el6_qELtBUkKC-st64cIzg9tdi35BhB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfXxgKwt3/sMW2u
 GvLfD0PFpIt5e+6/d12cDr7n5Ed2qO4+6V+ePZ5qtWKsIaKlEWWhO+X8NYujJOnDIKuM73k+Op9
 pZeMg5vNk7tUT97EwE0iRQ0byVdD0ICpKPRGR23GkIj2voTiXB9TdDQrOjYczSSvxRsCkvqQJDJ
 XWYFUrVSpeTtWSHT6KF9nP5xOinEE01g4USrjWAF4w4CUMP/67OiG1tSR+JD65b+qUoF0sZWww/
 Omuo+YY93415WDd52oZSUDPFADD1FPgbSla6CxaAf4qIuqgMRSpE/Tp4uVooUYW/D8rp5RQsEHx
 yrGJMVFMdH9Fi1jDI7l3BajLSO5eIEdl4fk6UJ9+RJksnZkUIcUGz+O9+i88NNtTHAD0Rxqtj6W
 3hdZOMla8iqjNeXvh4PnFkJB5VfrCw7bl2SmrTapn3oCAu3TCjrjstc8hNahul4jEPg4HE7s++o
 k4qh6GShltfOO5+2oWGEQBGMje0LN6kW+8UhLLI8=

v1: https://lore.kernel.org/git/cover.1779207350.git.siddh.raman.pant@oracle.com/

<...insert text from v1 cover here...>

Changes since v1:
- Removed Documentation commit and sent as a standalone patch.
- Removed finish_command_with_timeout addition (and thus sleep_nanosec).
- Squashed the external notes command code, doc, and test commits.
- Removed horizontal separators from note-external.c.
- Removed global variables from translation unit and instead store config in
  a dedicated new struct member in struct display_notes_opt.
- Reworded the main commit to have better explanation of the motivation.

Testing: https://github.com/siddhpant/git/actions/runs/26295998442

Please review and let me know if any changes are needed or errors are there,
hopefully this gets accepted.

Thanks,
Siddh

Siddh Raman Pant (4):
  notes: convert raw arg in format_display_notes() to bool
  wrapper: add support for timeout and deadline in read helpers
  t3301: cover generic displayed notes behavior
  notes: support an external command to display notes

 Documentation/config/notes.adoc             |  61 +++
 Documentation/git-format-patch.adoc         |  11 +-
 Documentation/git-range-diff.adoc           |   6 +
 Documentation/pretty-options.adoc           |   9 +
 Makefile                                    |   2 +
 builtin/log.c                               |  17 +-
 builtin/name-rev.c                          |   9 +-
 builtin/range-diff.c                        |   2 +
 contrib/completion/git-completion.bash      |   4 +-
 log-tree.c                                  |  10 +-
 meson.build                                 |   1 +
 notes-external.c                            | 414 ++++++++++++++++++
 notes-external.h                            |  53 +++
 notes.c                                     | 266 +++++++++---
 notes.h                                     |  33 +-
 revision.c                                  |  36 +-
 strbuf.c                                    |  26 +-
 strbuf.h                                    |   4 +
 t/helper/meson.build                        |   1 +
 t/helper/test-external-notes                |  64 +++
 t/helper/test-notes-external-config-reset.c |  24 ++
 t/helper/test-tool.c                        |   1 +
 t/helper/test-tool.h                        |   1 +
 t/lib-notes.sh                              |  19 +
 t/t3206-range-diff.sh                       |  68 +++
 t/t3301-notes.sh                            | 448 ++++++++++++++++++++
 t/t6120-describe.sh                         |  17 +
 wrapper.c                                   | 139 +++++-
 wrapper.h                                   |  23 +
 29 files changed, 1693 insertions(+), 76 deletions(-)
 create mode 100644 notes-external.c
 create mode 100644 notes-external.h
 create mode 100755 t/helper/test-external-notes
 create mode 100644 t/helper/test-notes-external-config-reset.c
 create mode 100644 t/lib-notes.sh

-- 
2.53.0

