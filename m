Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB637998A
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466263; cv=fail; b=s6QJT3pku1TQNgRsNzE8s8t2/8bcFLYYVaxHWth+NUDK4Ea40tqook5MQcxgYdsSOWBTK8vezf2L+oo0KOHEUwmGd1wAB6RqpzItnB+u7pip0lmxDaDCnBvw8j8E4U8Sb8z4Sj4gbg0ofFvWgZZKkXkqgiFgztH+wNCDFQYMQs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466263; c=relaxed/simple;
	bh=BmMe8CI4BTpX2idpc41NQ77yknCfnWIK6LQEXGj5yyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hGInHY5xmsDmFoUWurtoEzH5Bs6X7rlsLEr+LU2ZAI6mRcNK46JF1ov5WVnN+Rf/N+hB+PDjdbDFlYPJtmrONBTHZ6OeRUDm8+sqRUFp2pNT4rPtJ04AFmDXrhXGFCcI1o+5WzBQvME7UUKvVXrYj6DVF9H/hOi6bWvNioaDoWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W/QjAOJJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GpB5UvHV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W/QjAOJJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GpB5UvHV"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MD0UNu3753046;
	Fri, 22 May 2026 16:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=; b=
	W/QjAOJJkRPesbrg5Ngk5PuiN3j3CKrAc7CLZLXM6fBRNq1Q3NYI4vqxT5AjExc8
	F2+hm+8nEN6wDNoazMuBRK1+b3BP6h3yZ+1VWiu52xakctgCfgnggP27wFjmI8s7
	gM7A1zbSD4vx/ECiuXkV6LeyqlJSD8STYj4T/cS0Fr5lt6YSc7jq7/OzXbgOxBa5
	z5NP7kVml3V9I0O+B2YleEL0UAbnrDRyXv044udDWFaJtQMXdPJbb86ASl25Y/RO
	IviLVmwH98OnpBw26abi1g4LnTD/t6ytkumZr3t/CYg3mpx9aynGH4zGfMEUF+w2
	h2k/jfFjXcsHXQpuKBE52w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1t36ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:10:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64MGANim026158;
	Fri, 22 May 2026 16:10:43 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1m79ne-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:10:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FExjKWR+TQ144Tmcfc1tYShcNFRsQwQoK4w1lLr2/T8RFdDEekPGaVueoOmWXh4g4Wn1VDUKaoihSx8I1aYNqTxpOu2/wfWj96gxEl95+jc4UX7nk/OsEw8p8f8XsJ2mf7kZ7jwyeQ6HxY5CI1mgCbXZLKfYQEkfCITlAOMbSDMGquQthJUqr8e1ItayHvj6YiE6L8oMrJHBV5d+lmXN2cU7/2PPgR5pPVJSW4GJc7hnMOS3Fc+yQDRtuX5ZjQPeCgwoymyvckgsdAVX5BL6BKhC74eJniai4vjVkYkPWWLlqZPEY6Olw8MGvaL7LgNW/RxwTA2VbeUfmezvwtvTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=;
 b=QMFehNsc6UQcr4/9NLm1JiZAFeHR+2ivrLi7LRFh6/N7fZGJhEmIYGFi8bpCdoIkPrwE7AWlD0t9NxQubBArxB4X9kyEjXHzJrg3nr2Flg53wXNS75IXZWXo+WixvH0O7hgnBo1VO4UCQAwDA73H7WILWZEAOD6d4pKeolrF/hcz9ER6ma2kflEOG5HVXaO/STIl/gQTspG2YAoAB3WSxkz0kI0kMbVL1PMryH+Us6Mfbi70jvl1ABGdD7moLTDX6yFkFJA8A1uIRRUjqrqfCtZm31cRmNRHANqrsCzoBKslN1Pzx+VBL6Sz9b7J0s9M4e7IC4wu5D5PRN+90znR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=;
 b=GpB5UvHVBTV59AwFH+Rs2kn50mCiIDMd30v4olavoGVMlXatc2OGTBy5zbOKu1NpfEqoAmYd1cDqd03BL1UbLEYm8jRi48JPajZrVMHjeAtKBvopiSy+5+/54CfOh3NcQCr9rokfa5e8L05zgDwpcrc4pJyQ+WN/ovdC8xPkpzE=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS4PPF18D5A7206.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 16:10:01 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:10:01 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 3/4] t3301: cover generic displayed notes behavior
Date: Fri, 22 May 2026 21:39:37 +0530
Message-ID: <e494bea038262847ea14d223718f6059e52c1f40.1779464886.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779464886.git.siddh.raman.pant@oracle.com>
References: <cover.1779464886.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::12) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS4PPF18D5A7206:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e7c3ef-5bb6-44f0-411a-08deb81c93ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XNDX/IbOtqmrdJDU9lW6MZbQtl1vP2mq90xsUWDWMpfoyJER+FW6TjuWx8GozNouv1JRew3QyZrobxDycpmHaxhgQWy0rLOJm3EoXo9k7Pv7x7fZRM/OkUxZUh2oT4Vgd0Hg3mk16v9eKspStrlXMsyk5EvCj/H4NY2jDVQQGlOuo0+pz/MlNNm8CaIcFVhEPBaG521+KJfogRnoNkMTNgt1xLB7xSbTC3chR4aoz73l719oPyXAVWEgMwGTjE7nC2Npk/4yrbjMaizsSb7PK7Izv/Axl70ECkhC4Ezlb9aUbb+4l1cDj/qguvZakGyG6G7lGuV3iMxp66yQ3rD+6ZkXUmaSNcNaMTqEWnA1Kx7P/ubbxZx1ToaG6x/FP19mAe+PMaZrphFZS1u6vnIa7MMEKbhiENdAp5TC3lXyAETAF79cbHWSFKPscSfnI9nZNCCvrEXp6+qU/2mJcIW2abxmuDo9ILpguBzdjCXTd4FMWrU8vaS8DHLDqBSfEbpJNuU6T+7ymCWg4HDsq7p9p3xLEyd5DJYE+XdzKydx8qeQroD0EJpT0eJhj1TdbbsZpmialY5Ob2BlRayY/AGTWVMjfhUxzoOt7UlSR5BoDarXwudJnCWXmI9JNpEQisycSXt9lzRqsD1CFXifv7SrQYinGyReIK3mnB3FqCMzttziGBhLrEVoknzAIPjVrhXw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hq+Zbday6Y/diQisfWlzhoLcQDIX+PLARHSgiAas1tzq1VhHltozmWn4JJ5L?=
 =?us-ascii?Q?9/IMwiltR3wlc6fJCtZSXXsk06kkrAtwBIyUL5wccrKwF8oFaCLsbfEo0nZH?=
 =?us-ascii?Q?HXiKeamEzWm0iyzwq+AKa6i1LfeLVZq/ZkQYHOlgD0/rIeqcCHHohcEKkjHD?=
 =?us-ascii?Q?/vTVIUUrW96/L2YtvWqbx6H+zQL7t2MMxB+ydMQWNBIhcwQ7+Lp+nc5v6SD2?=
 =?us-ascii?Q?pJ7kOGo1wccBQZh3i9lA3jOjghEzBXEFOuF1WtZgiXxGmgJH6u/Rk1B2/jXQ?=
 =?us-ascii?Q?9QQkh7MnNuMh0txRtwdi44SvwZhuj0wJN9hrEbzCwjtGQkC/YBK/Rq9HL2cE?=
 =?us-ascii?Q?UH9WGj1dOXnWdb0JxYYbOWG3AZanzLQhgbcNtxU/kgY+70UYGLqPcIR9ihze?=
 =?us-ascii?Q?NS+ZAN6NQR3XA65f3cy8M92xS75GCvOAIxP+7QVPaMFv5jlpVJegu4Mv6nsN?=
 =?us-ascii?Q?/qwPqObNI7oUk0w9tCjpLgwrFSp2A0WZnKVdkfuU+6gTds1Uy/5MUuaOmRHJ?=
 =?us-ascii?Q?Y8x+CQyRgmJPMNytT1SGsPUAoLAYF3dRvYIEmSZftZBChaJGLhiKngBoV3px?=
 =?us-ascii?Q?0qdUUXfK/suSA8HCfA4uKSZ1t5N+tzxmLZIaGtr7mwpZGsJ2iv4qieqwiXB5?=
 =?us-ascii?Q?XGYg2eB+6kDc+raJmURznVjzWYofQfQdVL+3drEKmwqmVsPhQqrZvM77H/q2?=
 =?us-ascii?Q?8moSEQr82NCNrwgGKsmw5r/QD2KWpsFrYabYHOZoH6jUUMiwWjFMxCk1wYdt?=
 =?us-ascii?Q?9ZTZJYItMU8g+1RacZdTDaff/WIQkaJGooB8VNnMYzhCRbbGG30vLnuUDzFv?=
 =?us-ascii?Q?xbjJJdPgMO1/85Jv3V2AL0yVN1U06TtkBrEK8E2eHmv7vOvizUvYP3Vd11tU?=
 =?us-ascii?Q?sL3kbGL5APCBpPNLExyCnZwFO89kJMwrbLzyVjWvDucDJuZUlcLeAc+ybH5v?=
 =?us-ascii?Q?AKroV6JCZ3opWeB9AiBlTYZbT1Hi7Gnk030mLbxzDMcYTMOujWbA9Li6ZUOq?=
 =?us-ascii?Q?VkpQ1UAYfyu5kJ9sLK03JPccU80mRqEiAqyAt8gtuDXY1mvJhgaC9mSLH39N?=
 =?us-ascii?Q?P7tfn9uQYND3FITOeOeFBTDDaKozVDNVq2qfuXjkcS5h4up5ug2zrLIMj5Wo?=
 =?us-ascii?Q?Aea+77lk2f5/bGXfb+FTUbDUgqP82Qsql0CiTcFHRV1SY+FVTaPgxCnmkLe9?=
 =?us-ascii?Q?OL2FvywPy9Cow7zWYy3/1dIu09RtUU04213swO722QjSj8I2gj4JmCwQFZpn?=
 =?us-ascii?Q?I5kofXPIBOlFwXImeeIOdGnYAHpPbBi1btIjslKFQ2VzvNLRFI1gLF75BVZX?=
 =?us-ascii?Q?fvdldLwy9hHjWjx0GWhM7VixnV4+Sh2DRK1ad1dn9MIp1qc8+nytc7iz0xXz?=
 =?us-ascii?Q?FAJYqQK2XiRBcTArZHj5FFZF6/XKXu9TmQN2qKzTMbVI+GKxeewy1xOOcXUk?=
 =?us-ascii?Q?bp9dlrpUWS/WLCEIhPPdSPGkZMqVxF/YEpbuLNhrKZiz85kc8zz5mPJrJI0T?=
 =?us-ascii?Q?nJ/RPqsrVZDG7QAq3bK0mXbzPVBy7UN/H91U86BvQHXJfVtBtwwfFD40melu?=
 =?us-ascii?Q?Aru0vYNfHVSuDVaZTiYu5rQdZ/92hLa10KICGImRb6ZLvVfxB63vi+j+MvKo?=
 =?us-ascii?Q?Jy22fji3tSZSB3YafcjQY8k7TYoRE+AYLWgTXunRrktWlzMRQi5T2xiCPfus?=
 =?us-ascii?Q?fu9eSTeMbvs7THKwjuuNgNE8Q/ENjVdKcpm/z5Bq5HSg2iHuXVHpCbLXp48F?=
 =?us-ascii?Q?W8JvJVL4Tshr5YFO/tonA2EU/Z8v3OOQcnPCbM3moLmPz6hWWts7DgK8xOqM?=
X-MS-Exchange-AntiSpam-MessageData-1: hthoD33ppItH0F3FDJ7fXq2SSWz4Dsn92OM=
X-Exchange-RoutingPolicyChecked:
	dRBiHVlb1QQCpkFygkPjvmBO1m11TorTFIJlsI9Q4mqYVEjplXcmpBPm6DNOmpgKRWY31bngbJDCwRXsf4Y5+jtJlFWgNOG69yB/qhpIdWeSCXJ9Jq6wPuf10jWApTmR/M7huVL6Z5+h7HHROemIDF60uX7glVb+2sJ+Tcf/e2RmK+mRfBzTE5AhzpL/5RjEXGNA25ARAmOR5hswqdkql5MgO5tj14tVfpwVBFsRNHyLwaSezsmuBFciMGpvcdgTS0/p0Qi6JzEWA6n1I9Tp5RBgwV2JKyyzkY9QboD00obZridb4ICQg0nDRTybGTqEMdHXBywigeah9dh4a5Kbxw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t6C9gNSvJskjWHFcbMug1bUz3TC5g4ZcwQMfQ+nhVWY8R2ikSO4DYY7nV+rR5go9s5MoU8SY1XljFh+t2bYBD/7EbYsx0rfB++HK8dS0XWqhCo/yE0MnlyA5dEHNGSAS8dE/JhUgbMsQgaUxk8i52MqBHAQgVB6m6JWl/fSGrLOSPzEc0/gWdO4DR3gQ+MmC7HS2CVaXWg0AhGGEp32vINDbEcWKh+qfZ4LSZM8jsW1f1RbKQ2WIzsdmiJhxB4MyweH9QNkNA2j0N2jXYvyZec5o1Ho9CVd3x1N3FRhC+oI3JgDxQotTEcZDNBIszqz7Snyo+tcaVmy/VpM3M6nqdB7IuiocnUhu4xKrpi39l3p5lUKJz0wDUY2F3Ih8SohvaH4Nb5jx9STCEi+Xlc2Gcjq0IaL44eq9k9dadSm2oXKmQ8x7ZI+K72fcbq1ebtiVBqHh16Vs4DL3ZvaFGQNZixuM8Zl1xa76JNx4IxO0EJzXl+/P+eVpKxG68s81qT8b0EVNNmt1ZKPP76y7QWpg1jFUv4q97Mfbf7vJ9efncz0PcIxvPEEKW4y20M0HiTSCdKraMPmMRA/cwcpsVqVtieFdepLOvnp4XAL406/RJkY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e7c3ef-5bb6-44f0-411a-08deb81c93ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:10:01.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elvKI3Dd/yNjGrLijozmcIM9LANlXp8/KjDPwgJAxP/77xf5AnT0vFgH1hwLnmr8ZHVUtu+IG3BepTmP+l4XjJKjL5dJTGenwNOy4R4I7ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF18D5A7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605220161
X-Proofpoint-ORIG-GUID: hSwm-NNuCxQRRIo9-soysiQMEJ0alNqQ
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a108003 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=zp6zO9qf0PI-K8SJbKMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12301
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfX7FjIu5rO+jNh
 yV8mk6gI2W4IlNzRKMxbwIx2tHHQcHJpNlSiH90bL0VUCO+i3X5douP4vWB4/99UKuzUqlY1ynu
 36FEiUQAUIT3OoTWx+/lytV5DU1fRpDXg1kqY8V0Djxa5R5piUb5auFUwi4ZjCHtXWbQkguQEk7
 cf6UXs/SFKNxj1jVkil0/lKri6vFfx7JvGp2+dIi0FkuUSWxLiPUYUG4vXEx22GDsGK1sKyxBPo
 BhL10E7G7tHEkOoNN1Mq3hg6bba1d9L0G8WOol08fhjsaObIbGAHC3M4agSGCxpAWfZAAmR+8ER
 j/n5Tj0WLl72LlRwnyFVVBjzzQozrlbSeHkAgQMS09lrTmkhKJ744GZL9xdcz3PENnlpDtMfaMq
 crJQLxfFDE2Iq/Bab1zTcb1PpqavLhLNwKGRROE7fR63HY1GNqYpy7MTLlq6F5UHw2vMGcpLXzr
 iMPY85GwmEGggEjby9C3s6AroncKeiDve6pJCHJY=
X-Proofpoint-GUID: hSwm-NNuCxQRRIo9-soysiQMEJ0alNqQ

Displayed notes already participate in common log behavior.
Add explicit coverage for raw notes formatting, --no-notes
suppression, explicit notes refs, and --grep matching before
teaching external notes to feed the same display path.

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 t/t3301-notes.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d6c50460d086..27439010dfbc 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -885,6 +885,30 @@ test_expect_success '--show-notes=ref accumulates' '
 	test_cmp expect-both-reversed actual
 '
 
+test_expect_success 'displayed notes honor raw notes formatting' '
+	git show -s --format=%N >actual &&
+	test_grep "^order test$" actual &&
+	! grep "Notes" actual
+'
+
+test_expect_success 'displayed notes are suppressed by --no-notes' '
+	git log --no-notes -1 >actual &&
+	test_cmp expect-not-other actual
+'
+
+test_expect_success 'explicit notes ref replaces default displayed notes' '
+	git log --notes=other -1 >actual &&
+	test_cmp expect-other actual
+'
+
+test_expect_success 'displayed notes are used for grep matching' '
+	commit=$(git rev-parse HEAD) &&
+	git log --grep="order test" -1 >actual &&
+	test_grep "^commit $commit$" actual &&
+	git log --no-notes --grep="order test" -1 >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	test_config core.notesRef refs/notes/other &&
 	echo "Note on a tree" >expect &&
-- 
2.53.0

