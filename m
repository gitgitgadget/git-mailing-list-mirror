Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961612EAB6F
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208292; cv=fail; b=ATIt9DtNiYrX/K8MbtAwVauWYY0nf41HRTvMX12sk6itdie7RvEewDuJvIrIk70Deh53GAQ2zd3ekGsFCSrg7kg4qEeV8tMjNohVHN5DgTLBieNW9jxlSiF59kZMWj1UvWiVSGiWvtmqLFQTxXW1uYwBxOqWLWHxjpPdT4AuACg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208292; c=relaxed/simple;
	bh=Rz+UnQIr72gGW5wyFbbxnIOZuJhouxG+ZAc1Bgx4wBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DoWvZ/yh8MWvhCrLS+GxW2izFVrT0luuiSpcYUOK0JVoB7G5z1C1b97jbwBX4mf5nJiUDmWFXLq1YJR8KEalzU9HcyvQWIE6R8XlDwg6bJkb0sAk/d3RsNTXHGsYqtjbPYYRUS7SN7lI4RcIBeQ4vLPCRb5N+ElG05w4hUPaFbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E2X9mM3n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xkyqj8Uw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E2X9mM3n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xkyqj8Uw"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JGPAXB2283345;
	Tue, 19 May 2026 16:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xzgMCc720PAWkgTsngL0GAMxMTwKEXhwJ557Y+fmVhs=; b=
	E2X9mM3n5vvvkLzEwqd9W057Ur9BLXuXN+vUUMg4IGudrjcbXB7r7O6bgbbcmrDj
	3z+E9EtO9fXFirCU3EQz06rNtndfsRskjxjUOcx/TfP+8dVR1lpmFzeXR/sGDuwY
	ZiPkwksWKARRcYhQC3cyTt3pvL83pWzVuOX7J1tXCgzqjPRuhsk2YkarXFklN24p
	wnBf6pDTbaJjC7rF0q7AXkS505Dg7ybm+Gv7QLBEhpoBaNMH/ItJOlouLHWUUVou
	OBnCUXoijr5w5OAzZ/JWfcILj0cAvU5pTJO6lQHQ40JzulHazywuoDaudCIWDUUK
	T+6tmwwCRiMuh2JoR/7sZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h86w4kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGTi5O018818;
	Tue, 19 May 2026 16:31:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1b0fkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKGVuiKDtjaZCs10A02dgCAlWvvP0KW4GsvakL0QinzGt8YbXY31OCyw44vZ3x3hvXW8IdGOwHP3pyMk76gvFdJEzUIFmvOKjfC5hxGywy2OMvHgymoYyqCjjj+6Kffc6G5/je1KPdXuF55xzP1rQolYHwjAknl8Vzb0NW+BTsIXyMegIcZ1sBC9T1CSiB/PGhW8QjgtXGK48yicZDjoJSNKH1KNM6MKjbkbmMv6dmyHzmCOZEYG/MTSiZfxQ4ZSfc0fj4xR6NyHVhZleQi+1pAdHq89q8IGWTn31JN5RoC13rrrWXQOYGLSMM9zH11BQ27VkTgJ2Kan2pJCPtl4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzgMCc720PAWkgTsngL0GAMxMTwKEXhwJ557Y+fmVhs=;
 b=jQO5Sa0E6JOfJ+nhKQTM9EHHDXARBH/V/+p9IaR8qxDLXsITFbvsiOQlZC7oURpg/XpAgzhB1DN3BS594WSYMF6EHnFsXAzKtRwZiQAhKi1//CGymxCDhUy1lVABLy+gEfKL+AZNlzBk5IcVLucFJj9mYup8VhB9kt0DiffYDV926YjIvv3zsaSXMKDlWYSuvqBRH+S4J7eUiL7GBMN0rjDj5D9jXZP6JwrMYPJBusQeMr9EhN/lIVZN2TEGBafc+y5GNIPL5TfU50ZWelTFtSotidkNSjz3kmRgUrixghXUKaoLmhJLWB67HGGF2QbCtbgzh4y/d63HWFPXVQB57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzgMCc720PAWkgTsngL0GAMxMTwKEXhwJ557Y+fmVhs=;
 b=Xkyqj8Uw0utw+ZHMvVFskJiq0ktUR3FHlQk/h9ByFtedG8x+dpLLqMZ7h/t3o4T0zR7A36OcPmwpe910xiVO3AXJVCMPumbpNLrqbcE+XjL4ETFsLc3W3YzAK3fWSHmaNiJhekrn5zydHZpkXcOwYzAEapSo0FDtMrv24GClZrc=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Tue, 19 May 2026 16:31:20 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:31:20 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] notes: support an external command to display notes
Date: Tue, 19 May 2026 22:00:36 +0530
Message-ID: <9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f4c14b-d2d1-4f70-0a21-08deb5c40eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	NJZghRV0ly1bo/4/cHl64aqWEMI2Qf/Em/zP/Jju18OGuIPnMulhmfCqumcmyMbsr4t/3XvzuqiW9gSzWOgzyHHd/fpfqSSMmmBWsnSHppzxphUtHR+lhUT93AxzuD9SPad43TY6gLrL77NU5p/WwQpylVYWPaUcCyJC5yROFF7WtZCqJ8O6kc3l5Oyvy8JRVpTcMupurE2Z3dbPa5ow/GtroxxVJyLvh/HnoXCYevnqpRtXdLKVVr2+Ho7KACaM5Pk2E2CKVAAOaeSkoY0upDtLRk3i4D3pH5PgGHqY9XvQWoPOs3Qo60J7PzXtIH/4cTVufqDR02LRn9B2dqBtaVU/vQ+mHlPQ5eFLhrvgfZVEE7/VDHDbwM03zo+rsCNNUlkVEB5LWeXFkci9aKOkge3HNyrv14Q2k6N1D3/sytE09s7sjJdw7KQUG4nZ7A9e4GdF2Y/suqvPjcDvVSSsJUsAEddL3OUXaXlJQixn2AcMV1ffnV7bLMxirsn0pqTWs2MiYwxiVpYiLjPpl0uxWMe+AtOWZi6U62LO4dNnHayjP4t3IdrjOpetngoTkKEPu8Vmz4/4LsVnYsrpsJDKLI8OC4mQUQ2t2Y3CivOrqxfeYVn/c3a32o14XVIRT2Crpd8gpNpu938v4A7lAuQuXm4lEo/xQTiRlC6//Sb4K0cHGQvuFI3z3Dr2FoPRPqEY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YP9XG2spd71b/40LobPjNEdrV5vFxDNWSJWSna6PEEmXTmGIg2OuHjn7k2BZ?=
 =?us-ascii?Q?b5Wzp5MdnXyKUhHKYZTRkg+HLuC9F8Hb4vSD5eT4ciDB6qrSCumUfIeCMrpF?=
 =?us-ascii?Q?dOUfGL9V8S7Z6E8PNCiiwQDPHQjRlFOtF7yeYTaHqCkzOqaE8HFEwdYd1n3y?=
 =?us-ascii?Q?yC1xwSRjbkm12iN8WCRjCA7t3WtPTXUnIw9Vv67ZBehoybpU5z/xRZAOuSOV?=
 =?us-ascii?Q?nvH9MvsPJWVmzFXamN11RfXs9kvBAKBrU6XpagLUBs3Yni0bbqxzb5tNmzdZ?=
 =?us-ascii?Q?v8CB/fWGvxboWnqTXtJ2a4SPBWqcHD+EJr9OQ3aCQT9+zA7JRSUeRWxkUT/K?=
 =?us-ascii?Q?dfnWCBzDF+cyDM23Dg9e5JtYRu44t7j2bUjhAJVPZMWlAw3rqnoN3j3ZMeWp?=
 =?us-ascii?Q?P12pSIVzpo9dCRLBqX8mWUPe6OJchN/bTAfiocmwavMChui+0fjmjUxmI5MO?=
 =?us-ascii?Q?X8yY2qy2awZ59jCO0fZOMIFpwi56mAAJke8pxAIGVU7RjYHtwseDw5xLcAlk?=
 =?us-ascii?Q?Hfzn3aP+5pWUCdBktqajlkdUvDttfHhyVouH0tQ6hWtKuETHudgugKTChnpq?=
 =?us-ascii?Q?v2BHJ0N+/rq19PiCGumaLMOjejYN/qJtgtN36t/v+8z151MmNASPJ5N2AQxI?=
 =?us-ascii?Q?xwxAHXY4hIQoA1NalxoC/QYt27pSVAFex5iqPRoxZV1GTVeQEXdsDe0qw1mR?=
 =?us-ascii?Q?+KUemabCiqd/LzcniMj2zd30s4q4PEpUYE1Gr95I17d61Wv6VZdJJGksHU/R?=
 =?us-ascii?Q?5ATICS4bvZ7NX0az1SIxZL1Do3ef8Y7nd1pwWrgJrCdmbRpCTTNUy9O1xX7o?=
 =?us-ascii?Q?m8/fVMTsllz3xSAMpvq85Kuk8tBgVMHXSCRlytpRPdZaSgGMETxnNJhpfYy5?=
 =?us-ascii?Q?q23x+sybq0LZ4skmk4lCYzaYhpDZOa4fWjZc83e5pqaN6fdgGPYThORAfGFK?=
 =?us-ascii?Q?tPDkMmRr2ug3FdlyXPPY/3PVOLLNJ+BKBCO36zvlPZ5TpDW0yPzJa16DeyH2?=
 =?us-ascii?Q?FN1QpCRQH1r9quZ4qMWPxJboyLsxeQ/XXPPHAzB275Q1pRkJHnq5X4KN7ER0?=
 =?us-ascii?Q?GyaJALyen+t4igLLH99DAQTz0H4N+s12DY7lB0rzqveTp5pNZcZWtBZe79BX?=
 =?us-ascii?Q?1tKh5nljUj0+MGqh7PW3SscCSyVWiKvXYI3IwoAzdmANQhS/tGAovvXVDKAX?=
 =?us-ascii?Q?FOOG9ywfdeBSFlOX0KmRtCh6KXPRNnGYk4Rir7W3Cm5QW/MhF8sooneLNRdm?=
 =?us-ascii?Q?YTzIvQfE12ZL9UHfi+a7Ppb5BqIVKkE+67Jp5DImULe4o8o9Du+znneyevc6?=
 =?us-ascii?Q?XgxobgLNAh2Xbn7nT9HBoJ9zNyj/T3aB/1etN8fR1sMeB/N96Ois6Ddtx/l+?=
 =?us-ascii?Q?OkKNeqU5SF7y8RnLUWkdVV/zUO0crXj6E43Bl9gpc/mbxI7Vkc4pdZ2gVIq7?=
 =?us-ascii?Q?nyaXd0BW8YqtUMWw7vntu76Mh8iF+/07zBqbD74yXASEhxIaM8m91zSfoIk2?=
 =?us-ascii?Q?6U4eeo3//GMKgxEyWjVyUtxbTbKCKmAQC5sro+eM0xNsf+WLRKsf9e7qwtEu?=
 =?us-ascii?Q?iHb1Fbr0rispR6ru0/NglQqBYUT4u3mcFwnqlDrM7WKeui4F+0zD2uznGD7Z?=
 =?us-ascii?Q?mS6RitIyPq5qowh5ui2hGwiowVi5CMh/sAUaX1qyFhBlb7/2tjLicP3JhANo?=
 =?us-ascii?Q?FMkuQA3YCUOZhdPnlRIk9zKqAW8+h3WwMVOpUfPtp93T1HTozzlMPIVhsBdx?=
 =?us-ascii?Q?QVikA8osZ4wHvZZvCAUt6legBQ0eb6C3GFqZX6TPxA81wzPhBiPNr/0RDNw+?=
X-MS-Exchange-AntiSpam-MessageData-1: eSYck0VVpfYS6+Uw33+qEVOA1gAPNjIgnBA=
X-Exchange-RoutingPolicyChecked:
	qsrSGV+oJ+KUbOv9K4iCO3rP/Qc+Xf0MLVgeFh9RnKWT8Yw6+Epp1HyJ+Ns8uEZXQjzKbE4OD4DN57rNoIPmqIGlW1RiXcAKBAYQNa9oUNw7cbLeco5h6mw4KqveuALeTACIxlt+yS2OteceutIjFlW5hgL3AAU5DKSI/XdMMhUlXRfKlfX3XoLODJv6DhkkX0bZYwwus5zBfOdhaao94m6YIBoqlD39SdU5+QYM9QgFeQn0d88MNwXotpUOLW92z3NlzdJmkHZSFJSES1ULfttZS8wsG5wImTSNOOmPCkzKTsb9BMLjAeMsGiTxxCqVM1XYZcHPvKLTtHFwbeqDwA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F1Tz/OXRp95L2/HZuGdFEW7ny4WAQhoY9pIKOM7Z/XJJuYpftC05X8YO5e9CKoyNyvCToHJPVXoWXaC6xckajWsShIr6HPmJ9VwKnI2P5wMIRrA4fWF3eTpjg7jrgnHPQNc4N7Y2nuz53ya3g3qSVoaWfLTO32239ADYxM0aMZkDqbH/oano8c5i9pGTW362UTj5Smpb+rN1zTZ5fxApERw5QRjL6wJgQWWbVwgSMCPxeKUES8znGHm/l0kUP/CcEYLJ1GhgjgtNJRoEonzZq2miGqNXG8mtvu89bsh1t/wcTUHuHIyePKvTQiOaZu9fUhzG8BZAwf8dAxmfjuMiefSoJT/yjgQ03+A1Q7QbRUbgR58bYlVpKDRPB77LC8sS/iH2UMnCe2uH05F4AUcDYUdPS0+zzWwKQCWNqdSverdthzWY+hldxSoTd9RfMJSGX/CgoIRN09+V06tGEDxfNpBofL3P8nIwOZwN4M4oPys/s6QpUTQat79WOVf+Qg1+xjNbHdr1CYBJGBD2W248l1NPwPNzMFUbIlIVvrGKBdZn6BuOuPk1mOvtBnutyPdBnLgLgjGlCyRLVIFvcVSHpGUU8sYH/PrCTGBOiFPH15o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f4c14b-d2d1-4f70-0a21-08deb5c40eb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:20.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISIVsHifz3B6I1475QTbAyNdMH1O5T135NUebxQTBN2mfJCN6HeetVeURhdLCtBzX6/JgEy6XBiA+4NPMQHM+p4tpAv2lYaxC6ORt49Ws0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX7SRPvoCd9x5S
 ctU+2m6uPFnRHXhlsWOP+noRLkO99R4BB5c9csF+ikbC6WqxrWB/5ayUBj0RuybkOsKRc794uO6
 ldrwAUAcSHH6qP9N2r2CxZ5gxqGiHzU2jrl6NbVj55HMExo5B6TPUto6WXX+wJfpMdpwQD/gSe7
 ZjaoGCFMoGOqfzaGGbSavrO84Ncd82mOpLIh1n29Scvavc/+8pD0LOupJ9jDgmSewQy6R/xtIiE
 mSOq7F7FuWUf+CCGV2lFE7f7PDxemVrdQs5ZhH19enliz/OD2y/jLI7LbjD4kNzxeajl/jMXeIg
 3PI+kw2sc0249zgf7NVI+0HPmRck/s2+JAFjm2dO9TA8nYWUEoA6PI8Nph0D/fJ25UgvfdX4g+Z
 ySHfaCO5c7jOfqEhETeufLrQPjbVICWXcurRNFX4mxl/r1/4/MB83Q+LfiAW2xXbJJ4vjD6VqoA
 2IvPBRge57XQqbh/kTA==
X-Proofpoint-GUID: svhdD95zz5KUIz3KIm7Y8qRLq70dFlky
X-Proofpoint-ORIG-GUID: svhdD95zz5KUIz3KIm7Y8qRLq70dFlky
X-Authority-Analysis: v=2.4 cv=TLN1jVla c=1 sm=1 tr=0 ts=6a0c905c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=_s7xoXZjJxAYuj9suEoA:9

git notes is a very very helpful feature to show user-supplied
information about a commit alongside its message transparently.

For distributed teams working on large git repos (huge number of
branches/refs, files, etc.) and using the notes feature to mark
information on git commits, a TOCTOU race can happen due to very
large size of the repo and notes ref:
	- Person A updates a note for commit X.
	- Person A pushes the notes but it takes some time.
	- Person B fetches notes and doesn't find the updated note.
	- Person B can come to know of it only when he overwrites it
	  and encounters a push failure.

This problem excaberates on scale.

One solution to this is a realtime fetch or faster updation via
external means, but unfortunately we lose the coherence in the
display of information, and the user would end up reinventing
git log.

So let's add support for an external command to display the notes.

We split the addition of documentation and tests from this commit for
easier review. The new help text added in Documentation/ in the next
commit should make the usage clear.

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 Makefile             |   2 +
 builtin/log.c        |  17 ++-
 builtin/name-rev.c   |   9 +-
 builtin/range-diff.c |   2 +
 log-tree.c           |   7 +-
 meson.build          |   1 +
 notes-external.c     | 330 +++++++++++++++++++++++++++++++++++++++++++
 notes-external.h     |  19 +++
 notes.c              | 242 ++++++++++++++++++++++++-------
 notes.h              |  32 ++++-
 revision.c           |  32 ++++-
 11 files changed, 633 insertions(+), 60 deletions(-)
 create mode 100644 notes-external.c
 create mode 100644 notes-external.h

diff --git a/Makefile b/Makefile
index c739ae78d0ef..a919bdd75f01 100644
--- a/Makefile
+++ b/Makefile
@@ -838,6 +838,7 @@ TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-name-hash.o
+TEST_BUILTINS_OBJS += test-notes-external-config-reset.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-deltas.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
@@ -1209,6 +1210,7 @@ LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
 LIB_OBJS += negotiator/skipping.o
 LIB_OBJS += notes-cache.o
+LIB_OBJS += notes-external.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
diff --git a/builtin/log.c b/builtin/log.c
index 8c0939dd42ad..bed4c1576f2d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1337,9 +1337,24 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
 		strvec_push(arg, "--notes");
-	} else {
+	} else if (rev->notes_opt.extra_notes_refs.nr) {
 		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+	} else if (rev->notes_opt.use_external_notes <= 0) {
+		/*
+		 * rev->show_notes can stay set after
+		 * --external-notes --no-external-notes.
+		 *
+		 * Since range-diff's child log starts with
+		 * --show-notes-by-default, explicitly suppress
+		 * notes when no notes source remains.
+		 */
+		strvec_push(arg, "--no-notes");
 	}
+
+	if (rev->notes_opt.use_external_notes > 0)
+		strvec_push(arg, "--external-notes");
+	else if (rev->notes_opt.use_external_notes == 0)
+		strvec_push(arg, "--no-external-notes");
 }
 
 static void generate_shortlog_cover_letter(struct shortlog *log,
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 60cbbfb4b7d1..95d5e076e24b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -277,6 +277,7 @@ struct name_ref_data {
 struct pretty_format {
 	struct pretty_print_context ctx;
 	struct userformat_want want;
+	bool show_external_notes;
 };
 
 enum command_type {
@@ -525,9 +526,9 @@ static const char *get_format_rev(const struct commit *c,
 	if (format_ctx->want.notes) {
 		struct strbuf notebuf = STRBUF_INIT;
 
-		format_display_notes(&c->object.oid, &notebuf,
-				     get_log_output_encoding(),
-				     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
+		format_display_notes(c, &notebuf, get_log_output_encoding(),
+				     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT,
+				     format_ctx->show_external_notes);
 		format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
@@ -878,6 +879,8 @@ int cmd_format_rev(int argc,
 			enable_ref_display_notes(&format_notes_opt,
 						 &ignore_show_notes,
 						 n->string);
+		format_pp.show_external_notes =
+			display_notes_use_external(&format_notes_opt);
 		load_display_notes(&format_notes_opt);
 	}
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e54c0f7fe156..41c27250404a 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -56,6 +56,8 @@ int cmd_range_diff(int argc,
 		OPT_PASSTHRU_ARGV(0, "notes", &log_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
+		OPT_PASSTHRU_ARGV(0, "external-notes", &log_arg, NULL,
+				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
 				  N_("style"), N_("passed to 'git log'"), 0),
 		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
diff --git a/log-tree.c b/log-tree.c
index 4503a42dde6b..3289a085f66b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -856,9 +856,12 @@ void show_log(struct rev_info *opt)
 	if (opt->show_notes) {
 		struct strbuf notebuf = STRBUF_INIT;
 		bool raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
+		const struct display_notes_opt *notes_opt = &opt->notes_opt;
+
+		format_display_notes(commit, &notebuf,
+				     get_log_output_encoding(), raw,
+				     display_notes_use_external(notes_opt));
 
-		format_display_notes(&commit->object.oid, &notebuf,
-				     get_log_output_encoding(), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
diff --git a/meson.build b/meson.build
index de917bcf1146..21cdbc15aa18 100644
--- a/meson.build
+++ b/meson.build
@@ -397,6 +397,7 @@ libgit_sources = [
   'notes-merge.c',
   'notes-utils.c',
   'notes.c',
+  'notes-external.c',
   'object-file-convert.c',
   'object-file.c',
   'object-name.c',
diff --git a/notes-external.c b/notes-external.c
new file mode 100644
index 000000000000..7d6b2c6060e0
--- /dev/null
+++ b/notes-external.c
@@ -0,0 +1,330 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "notes-external.h"
+#include "run-command.h"
+#include "sigchain.h"
+#include "strbuf.h"
+#include "trace.h"
+
+#define convert_ms_to_ns(ms) (uint64_t)(ms) * 1000000ULL
+#define convert_ns_to_ms(ns) (uint64_t)(ns) / 1000000ULL
+#define EXTERNAL_NOTES_TERMINATE_GRACE_NS 100000000ULL	/* 100 ms = 10^8 ns */
+#define EXTERNAL_NOTES_READ_CHUNK_SIZE 16384	/* (16 * 1024) bytes */
+
+#ifdef GIT_WINDOWS_NATIVE
+#define EXTERNAL_NOTES_FORCE_KILL_SIGNAL SIGTERM
+#else
+#define EXTERNAL_NOTES_FORCE_KILL_SIGNAL SIGKILL
+#endif
+
+/* ------------------------------------------------------------------------- */
+
+/* Configuration helpers. */
+
+static char *external_notes_command;
+static char *external_notes_command_name_value;
+static uint64_t external_notes_read_timeout_ns = convert_ms_to_ns(100);
+static int external_notes_command_failed;
+static int external_notes_for_grep;
+static bool external_notes_started;
+
+void set_external_notes_command(const char *command)
+{
+	FREE_AND_NULL(external_notes_command);
+	if (command && *command)
+		external_notes_command = xstrdup(command);
+}
+
+void set_external_notes_command_name(const char *name)
+{
+	FREE_AND_NULL(external_notes_command_name_value);
+	if (name && *name)
+		external_notes_command_name_value = xstrdup(name);
+}
+
+void set_external_notes_command_timeout_ms(int timeout_ms)
+{
+	if (timeout_ms < 0)
+		BUG("negative notes.externalCommandTimeoutMs");
+
+	external_notes_read_timeout_ns = convert_ms_to_ns(timeout_ms);
+}
+
+void reset_external_notes_command(void)
+{
+	if (external_notes_started)
+		BUG("cannot reset external notes config while cmd is running");
+
+	FREE_AND_NULL(external_notes_command);
+	FREE_AND_NULL(external_notes_command_name_value);
+	external_notes_read_timeout_ns = convert_ms_to_ns(100);
+	external_notes_command_failed = 0;
+	external_notes_for_grep = 0;
+}
+
+int external_notes_command_configured(void)
+{
+	return external_notes_command && !external_notes_command_failed;
+}
+
+const char *external_notes_command_name(void)
+{
+	return external_notes_command_name_value ?
+		external_notes_command_name_value : "external";
+}
+
+int external_notes_command_timeout_ms(void)
+{
+	return (int)convert_ns_to_ms(external_notes_read_timeout_ns);
+}
+
+void set_external_notes_for_grep(int enabled)
+{
+	external_notes_for_grep = enabled;
+}
+
+int external_notes_for_grep_enabled(void)
+{
+	return external_notes_for_grep;
+}
+
+/* ------------------------------------------------------------------------- */
+
+/* Process management helpers. */
+
+static struct child_process external_notes_process = CHILD_PROCESS_INIT;
+static FILE *external_notes_in;
+static int external_notes_out_fd = -1;
+
+static void mute_routine(const char *msg UNUSED, va_list params UNUSED)
+{
+	/* do nothing */
+}
+
+static void close_external_notes_process_pipes(struct child_process *process)
+{
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	if (external_notes_in) {
+		fclose(external_notes_in);
+		external_notes_in = NULL;
+	} else {
+		close(process->in);
+	}
+
+	if (external_notes_out_fd >= 0) {
+		close(external_notes_out_fd);
+		external_notes_out_fd = -1;
+	} else {
+		close(process->out);
+	}
+
+	sigchain_pop(SIGPIPE);
+}
+
+/* We set this as callback later, so can't have void argument. */
+static void cleanup_external_notes_process(struct child_process *process)
+{
+	report_fn old_error = NULL;
+
+	/**
+	 * The helper may still be sleeping with its pipes open, or may not
+	 * exit promptly after EOF. Ask it to stop, then use a bounded wait
+	 * that escalates if it ignores the signal.
+	 */
+	kill(process->pid, SIGTERM);
+	old_error = get_error_routine();
+	set_error_routine(mute_routine);
+
+	close_external_notes_process_pipes(process);
+	finish_command_with_timeout(process, EXTERNAL_NOTES_TERMINATE_GRACE_NS,
+				    EXTERNAL_NOTES_FORCE_KILL_SIGNAL);
+
+	if (old_error)
+		set_error_routine(old_error);
+
+	external_notes_started = false;
+}
+
+static void stop_external_notes_process(void)
+{
+	if (!external_notes_started)
+		return;
+
+	external_notes_process.clean_on_exit = 0;
+	cleanup_external_notes_process(&external_notes_process);
+	child_process_init(&external_notes_process);
+}
+
+static int fail_external_notes_command(void)
+{
+	if (!external_notes_command_failed)
+		warning(_("notes.externalCommand failed: %s"),
+			external_notes_command);
+
+	external_notes_command_failed = 1;
+	stop_external_notes_process();
+	return -1;
+}
+
+static int start_external_notes_command(void)
+{
+	struct child_process *cmd = &external_notes_process;
+
+	if (external_notes_started)
+		return 0;
+
+	if (!external_notes_command || external_notes_command_failed)
+		return -1;
+
+	child_process_init(cmd);
+	strvec_push(&cmd->args, external_notes_command);
+	cmd->use_shell = 1;
+	cmd->in = -1;
+	cmd->out = -1;
+	cmd->clean_on_exit = 1;
+	cmd->clean_on_exit_handler = cleanup_external_notes_process;
+	cmd->trace2_child_class = "notes-external";
+
+	if (start_command(cmd))
+		return fail_external_notes_command();
+
+	external_notes_in = xfdopen(cmd->in, "wb");
+	external_notes_out_fd = cmd->out;
+	external_notes_started = true;
+	return 0;
+}
+
+/* ------------------------------------------------------------------------- */
+
+/* Command parser. Essentially the main() function of this file. */
+int format_external_note(const struct object_id *object_oid,
+			 struct strbuf *note_buf)
+{
+	struct strbuf status = STRBUF_INIT;
+	char commit_id_hex_str[GIT_MAX_HEXSZ + 1];
+	const char *arg;
+	char *end;
+	char ch;
+	unsigned long len;
+	uint64_t deadline_ns;
+	bool input_fail;
+	int ret = 0;
+
+	if (start_external_notes_command())
+		return -1;
+
+	/* Fetch the commit ID hex. */
+	oid_to_hex_r(commit_id_hex_str, object_oid);
+
+	/* Pass the input to the external command. */
+	sigchain_push(SIGPIPE, SIG_IGN);
+	input_fail = fprintf(external_notes_in, "%s\n", commit_id_hex_str) < 0
+		     || fflush(external_notes_in) != 0;
+	sigchain_pop(SIGPIPE);
+
+	if (input_fail)
+		goto out_fail;
+
+	if (external_notes_read_timeout_ns == 0)
+		deadline_ns = 0;
+	else
+		deadline_ns = getnanotime() + external_notes_read_timeout_ns;
+
+	/**
+	 * The output for each commit is either of the two:
+	 * 	"{commit id} missing\n"
+	 * 	"{commit id} ok {num_bytes}\n{str_of_num_bytes}\n"
+	 *
+	 * We can have "\r\n" instead of "\n" due to Windows.
+	 */
+
+	/* Read the first line with its delimiter. */
+	if (strbuf_getwholeline_fd_deadline(&status, external_notes_out_fd,
+					    '\n', deadline_ns) == EOF)
+		goto out_fail;
+
+	/* Reject EOF-terminated partial lines. */
+	if (!status.len || status.buf[status.len - 1] != '\n')
+		goto out_fail;
+
+	/**
+	 * Strip LF and then optional CR so both LF and CRLF protocol lines
+	 * are accepted.
+	 */
+	strbuf_setlen(&status, status.len - 1);
+	strbuf_strip_suffix(&status, "\r");
+
+	/* Check if line starts with the commit ID. */
+	if (!skip_prefix(status.buf, commit_id_hex_str, &arg))
+		goto out_fail;
+
+	if (*arg++ != ' ')  /* After commit ID there should be a space. */
+		goto out_fail;
+
+	if (strcmp(arg, "missing") == 0)  /* No note available. */
+		goto out_success;  /* Ending newline is already ensured. */
+
+	if (!skip_prefix(arg, "ok ", &arg))  /* Neither missing nor ok. */
+		goto out_fail;
+
+	/* We are in "ok" case. */
+
+	/* The next thing is length of the note. It must be unsigned digits. */
+	if (!isdigit(*arg))
+		goto out_fail;
+
+	/* Get the length of note. */
+	errno = 0;
+	len = strtoul(arg, &end, 10);
+	if (errno != 0 || *end != '\0' || end == arg)
+		goto out_fail;
+
+	/* Ending newline is already ensured. */
+
+	/* Read the trailing note in bounded-chunks. */
+	while (note_buf->len < len) {
+		ssize_t got;
+		size_t remaining = len - note_buf->len;
+		size_t want = remaining < EXTERNAL_NOTES_READ_CHUNK_SIZE ?
+			      remaining : EXTERNAL_NOTES_READ_CHUNK_SIZE;
+
+		strbuf_grow(note_buf, want);
+
+		got = read_in_full_deadline(external_notes_out_fd,
+					    note_buf->buf + note_buf->len,
+					    want, deadline_ns);
+		if (got < 0 || (size_t)got != want)
+			goto out_fail;
+
+		strbuf_setlen(note_buf, note_buf->len + (size_t)got);
+	}
+
+	/* Ensure the ending newline (LF/CRLF) after the note. */
+	if (xread_deadline(external_notes_out_fd, &ch, 1, deadline_ns) != 1)
+		goto out_fail;
+
+	if (ch != '\n') {  /* Not a LF. */
+		if (ch != '\r')  /* Not a CRLF. */
+			goto out_fail;
+
+		/* We have '\r', let's read the next char. */
+		if (xread_deadline(external_notes_out_fd, &ch, 1,
+				   deadline_ns) != 1)
+			goto out_fail;
+
+		if (ch != '\n')  /* Not a CRLF. */
+			goto out_fail;
+	}
+
+	goto out_success;
+
+out_fail:
+	ret = fail_external_notes_command();
+out_success:
+	strbuf_release(&status);
+	return ret;
+}
+
+/* ------------------------------------------------------------------------- */
diff --git a/notes-external.h b/notes-external.h
new file mode 100644
index 000000000000..e49a50b09063
--- /dev/null
+++ b/notes-external.h
@@ -0,0 +1,19 @@
+#ifndef NOTES_EXTERNAL_H
+#define NOTES_EXTERNAL_H
+
+struct object_id;
+struct strbuf;
+
+void set_external_notes_command(const char *command);
+void set_external_notes_command_name(const char *name);
+void set_external_notes_command_timeout_ms(int timeout_ms);
+void set_external_notes_for_grep(int enabled);
+void reset_external_notes_command(void);
+int external_notes_command_configured(void);
+const char *external_notes_command_name(void);
+int external_notes_command_timeout_ms(void);
+int external_notes_for_grep_enabled(void);
+int format_external_note(const struct object_id *object_oid,
+			 struct strbuf *out);
+
+#endif  /* NOTES_EXTERNAL_H */
diff --git a/notes.c b/notes.c
index 201f1df3dc29..0ff8ba94afc5 100644
--- a/notes.c
+++ b/notes.c
@@ -3,9 +3,12 @@
 
 #include "git-compat-util.h"
 #include "config.h"
+#include "commit.h"
 #include "environment.h"
+#include "gettext.h"
 #include "hex.h"
 #include "notes.h"
+#include "notes-external.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
@@ -983,18 +986,56 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }
 
+struct notes_display_config_data {
+	int load_refs;
+	int load_command;
+};
+
 static int notes_display_config(const char *k, const char *v,
-				const struct config_context *ctx UNUSED,
+				const struct config_context *ctx,
 				void *cb)
 {
-	int *load_refs = cb;
+	struct notes_display_config_data *data = cb;
 
-	if (*load_refs && !strcmp(k, "notes.displayref")) {
+	if (data->load_refs && !strcmp(k, "notes.displayref")) {
 		if (!v)
 			return config_error_nonbool(k);
 		string_list_add_refs_by_glob(&display_notes_refs, v);
 	}
 
+	if (data->load_command && !strcmp(k, "notes.externalcommand")) {
+		if (!v)
+			return config_error_nonbool(k);
+
+		set_external_notes_command(v);
+	}
+
+	if (data->load_command && !strcmp(k, "notes.externalcommandname")) {
+		if (!v)
+			return config_error_nonbool(k);
+
+		if (strchr(v, '\n') || strchr(v, '\r'))
+			return error(_("notes.externalCommandName must not contain a newline"));
+
+		set_external_notes_command_name(v);
+	}
+
+	if (data->load_command && !strcmp(k, "notes.externalcommandtimeoutms")) {
+		int timeout_ms;
+
+		if (!v)
+			return config_error_nonbool(k);
+
+		timeout_ms = git_config_int(k, v, ctx->kvi);
+		if (timeout_ms < 0)
+			return error(_("notes.externalCommandTimeoutMs must be non-negative"));
+
+		set_external_notes_command_timeout_ms(timeout_ms);
+	}
+
+	if (data->load_command && !strcmp(k, "notes.externalcommandforgrep"))
+		set_external_notes_for_grep(git_config_bool(k, v));
+
 	return 0;
 }
 
@@ -1075,6 +1116,7 @@ void init_display_notes(struct display_notes_opt *opt)
 {
 	memset(opt, 0, sizeof(*opt));
 	opt->use_default_notes = -1;
+	opt->use_external_notes = -1;
 	string_list_init_dup(&opt->extra_notes_refs);
 }
 
@@ -1086,6 +1128,7 @@ void release_display_notes(struct display_notes_opt *opt)
 void enable_default_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
 	opt->use_default_notes = 1;
+	opt->default_notes_suppressed_by_external = 0;
 	*show_notes = 1;
 }
 
@@ -1102,31 +1145,85 @@ void enable_ref_display_notes(struct display_notes_opt *opt, int *show_notes,
 void disable_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
 	opt->use_default_notes = -1;
+	opt->use_external_notes = -1;
+	opt->default_notes_suppressed_by_external = 0;
 	string_list_clear(&opt->extra_notes_refs, 0);
 	*show_notes = 0;
 }
 
+/*
+ * Resolve the default-notes tri-state in one place. Callers must not test
+ * use_default_notes directly unless they specifically need the unresolved
+ * command-line state.
+ */
+static bool display_notes_use_default(const struct display_notes_opt *opt)
+{
+	/* Options aren't specified, default to true. */
+	if (!opt)
+		return true;
+
+	/* Explicitly enabled. */
+	if (opt->use_default_notes > 0)
+		return true;
+
+	/* Undefined and no explicit notes-ref specified, default to true. */
+	if (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)
+		return true;
+
+	return false;
+}
+
+/*
+ * Resolve the external-notes tri-state. The unset value follows the resolved
+ * default-notes decision, which means "git log" runs the helper by default
+ * but "git log --notes=<ref>" does not.
+ */
+bool display_notes_use_external(const struct display_notes_opt *opt)
+{
+	/* Options aren't specified, default to true. */
+	if (!opt)
+		return true;
+
+	/* Explicitly enabled. */
+	if (opt->use_external_notes > 0)
+		return true;
+
+	/* Undefined and to use default notes set, default to true. */
+	if (opt->use_external_notes < 0 && display_notes_use_default(opt))
+		return true;
+
+	return false;
+}
+
 void load_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
-	int load_config_refs = 0;
+	struct notes_display_config_data config = { 0, 0 };
+	struct notes_display_config_data protected_config = { 0, 0 };
+	bool use_default_notes = display_notes_use_default(opt);
+	bool use_external_notes = display_notes_use_external(opt);
+
 	display_notes_refs.strdup_strings = 1;
+	reset_external_notes_command();
 
 	assert(!display_notes_trees);
 
-	if (!opt || opt->use_default_notes > 0 ||
-	    (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)) {
+	if (use_default_notes) {
 		string_list_append_nodup(&display_notes_refs, default_notes_ref(the_repository));
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
 			string_list_add_refs_from_colon_sep(&display_notes_refs,
 							    display_ref_env);
-			load_config_refs = 0;
+			config.load_refs = 0;
 		} else
-			load_config_refs = 1;
+			config.load_refs = 1;
 	}
 
-	repo_config(the_repository, notes_display_config, &load_config_refs);
+	if (use_external_notes)
+		protected_config.load_command = 1;
+
+	repo_config(the_repository, notes_display_config, &config);
+	git_protected_config(notes_display_config, &protected_config);
 
 	if (opt) {
 		struct string_list_item *item;
@@ -1266,47 +1363,31 @@ void free_notes(struct notes_tree *t)
 }
 
 /*
- * Fill the given strbuf with the notes associated with the given object.
+ * Append one already-loaded note message to the given strbuf.
  *
- * If the given notes_tree structure is not initialized, it will be auto-
- * initialized to the default value (see documentation for init_notes() above).
- * If the given notes_tree is NULL, the internal/default notes_tree will be
- * used instead.
+ * Notes read from refs and notes obtained from notes.externalCommand both use
+ * this helper so they share the same encoding, header, and indentation rules.
  *
  * (raw == true) gives the %N userformat; otherwise, the note message is given
  * for human consumption.
  */
-static void format_note(struct notes_tree *t, const struct object_id *object_oid,
-			struct strbuf *sb, const char *output_encoding, bool raw)
+static void format_note_data(const char *ref, const char *msg, size_t msglen,
+			     struct strbuf *sb, const char *output_encoding,
+			     bool raw, bool literal_ref)
 {
 	static const char utf8[] = "utf-8";
-	const struct object_id *oid;
-	char *msg, *msg_p;
-	unsigned long linelen, msglen;
-	enum object_type type;
-
-	if (!t)
-		t = &default_notes_tree;
-	if (!t->initialized)
-		init_notes(t, NULL, NULL, 0);
-
-	oid = get_note(t, object_oid);
-	if (!oid)
-		return;
-
-	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
-	    type != OBJ_BLOB) {
-		free(msg);
-		return;
-	}
+	char *reencoded = NULL;
+	const char *msg_p, *msg_end;
 
+	/* Convert the note text from UTF-8 to the requested output encoding. */
 	if (output_encoding && *output_encoding &&
 	    !is_encoding_utf8(output_encoding)) {
-		char *reencoded = reencode_string(msg, output_encoding, utf8);
+		size_t reencoded_len;
+		reencoded = reencode_string_len(msg, msglen, output_encoding,
+						 utf8, &reencoded_len);
 		if (reencoded) {
-			free(msg);
 			msg = reencoded;
-			msglen = strlen(msg);
+			msglen = reencoded_len;
 		}
 	}
 
@@ -1314,37 +1395,100 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
+	/* Raw mode is the %N userformat, so it omits the "Notes" header. */
 	if (!raw) {
-		const char *ref = t->ref;
-		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
+		if (!ref)
 			strbuf_addstr(sb, "\nNotes:\n");
-		} else {
-			skip_prefix(ref, "refs/", &ref);
-			skip_prefix(ref, "notes/", &ref);
+		else if (!literal_ref && !strcmp(ref, GIT_NOTES_DEFAULT_REF))
+			strbuf_addstr(sb, "\nNotes:\n");
+		else {
+			if (!literal_ref) {
+				skip_prefix(ref, "refs/", &ref);
+				skip_prefix(ref, "notes/", &ref);
+			}
 			strbuf_addf(sb, "\nNotes (%s):\n", ref);
 		}
 	}
 
-	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
-		linelen = strchrnul(msg_p, '\n') - msg_p;
+	msg_end = msg + msglen;
+	for (msg_p = msg; msg_p < msg_end; ) {
+		const char *eol = memchr(msg_p, '\n', msg_end - msg_p);
+		size_t linelen = eol ? eol - msg_p : msg_end - msg_p;
 
+		/* Human output indents note body lines under the header. */
 		if (!raw)
 			strbuf_addstr(sb, "    ");
+
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
+
+		msg_p += linelen;
+		if (msg_p < msg_end)
+			msg_p++;
+	}
+
+	free(reencoded);
+}
+
+/*
+ * Fill the given strbuf with the notes associated with the given object.
+ *
+ * If the given notes_tree structure is not initialized, it will be auto-
+ * initialized to the default value (see documentation for init_notes() above).
+ * If the given notes_tree is NULL, the internal/default notes_tree will be
+ * used instead.
+ */
+static void format_note_from_tree(struct notes_tree *t,
+				  const struct object_id *object_oid,
+				  struct strbuf *sb,
+				  const char *output_encoding, bool raw)
+{
+	const struct object_id *oid;
+	char *msg;
+	unsigned long msglen;
+	enum object_type type;
+
+	if (!t)
+		t = &default_notes_tree;
+	if (!t->initialized)
+		init_notes(t, NULL, NULL, 0);
+
+	oid = get_note(t, object_oid);
+	if (!oid)
+		return;
+
+	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
+	    type != OBJ_BLOB) {
+		free(msg);
+		return;
 	}
 
+	format_note_data(t->ref, msg, msglen, sb, output_encoding, raw, false);
+
 	free(msg);
 }
 
-void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, bool raw)
+void format_display_notes(const struct commit *commit,
+			  struct strbuf *sb, const char *output_encoding,
+			  bool raw, bool show_external)
 {
 	int i;
+	const struct object_id *commit_oid = &commit->object.oid;
+
 	assert(display_notes_trees);
 	for (i = 0; display_notes_trees[i]; i++)
-		format_note(display_notes_trees[i], object_oid, sb,
-			    output_encoding, raw);
+		format_note_from_tree(display_notes_trees[i], commit_oid, sb,
+				      output_encoding, raw);
+
+	if (show_external && external_notes_command_configured()) {
+		struct strbuf out = STRBUF_INIT;
+
+		if (format_external_note(commit_oid, &out) == 0 && out.len)
+			format_note_data(external_notes_command_name(),
+					 out.buf, out.len, sb,
+					 output_encoding, raw, true);
+		strbuf_release(&out);
+	}
 }
 
 int copy_note(struct notes_tree *t,
diff --git a/notes.h b/notes.h
index f6410b31e1c9..748af70e34af 100644
--- a/notes.h
+++ b/notes.h
@@ -6,6 +6,7 @@
 struct object_id;
 struct repository;
 struct strbuf;
+struct commit;
 
 /*
  * Function type for combining two notes annotating the same object.
@@ -264,6 +265,20 @@ struct display_notes_opt {
 	 */
 	int use_default_notes;
 
+	/*
+	 * Less than `0` is "unset", which means external notes are shown iff
+	 * the default notes are shown. Otherwise, treat it like a boolean.
+	 */
+	int use_external_notes;
+
+	/*
+	 * Tracks the synthetic "default notes off" state introduced by
+	 * `--external-notes`, so a later deprecated `--show-notes=<ref>`
+	 * can still preserve its historical additive behavior without
+	 * overriding an explicit `--no-standard-notes`.
+	 */
+	int default_notes_suppressed_by_external;
+
 	/*
 	 * A list of globs (in the same style as notes.displayRef) where
 	 * notes should be loaded from.
@@ -304,16 +319,27 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
 void load_display_notes(struct display_notes_opt *opt);
 
 /*
- * Append notes for the given 'object_sha1' from all trees set up by
+ * Return true if notes.externalCommand should be used for 'opt'.
+ *
+ * 'opt' may be NULL.
+ */
+bool display_notes_use_external(const struct display_notes_opt *opt);
+
+/*
+ * Append notes for the given commit from all trees set up by
  * load_display_notes() to 'sb'.
  *
  * If 'raw' is false the note will be indented by 4 places and
  * a 'Notes (refname):' header added.
  *
+ * If 'show_external' is true then notes.externalCommand will be used to append
+ * the note from external source.
+ *
  * You *must* call load_display_notes() before using this function.
  */
-void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, bool raw);
+void format_display_notes(const struct commit *commit,
+			  struct strbuf *sb, const char *output_encoding,
+			  bool raw, bool show_external);
 
 /*
  * Load the notes tree from each ref listed in 'refs'.  The output is
diff --git a/revision.c b/revision.c
index cd9fcefa0a88..84d9af961988 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "notes-external.h"
 #include "object-name.h"
 #include "object-file.h"
 #include "odb.h"
@@ -2583,18 +2584,40 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
 		   skip_prefix(arg, "--notes=", &optarg)) {
 		if (starts_with(arg, "--show-notes=") &&
-		    revs->notes_opt.use_default_notes < 0)
+		    (revs->notes_opt.use_default_notes < 0 ||
+		     revs->notes_opt.default_notes_suppressed_by_external)) {
 			revs->notes_opt.use_default_notes = 1;
+			revs->notes_opt.default_notes_suppressed_by_external = 0;
+		}
 		enable_ref_display_notes(&revs->notes_opt, &revs->show_notes, optarg);
 		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--no-notes")) {
 		disable_display_notes(&revs->notes_opt, &revs->show_notes);
 		revs->show_notes_given = 1;
+	} else if (!strcmp(arg, "--external-notes")) {
+		revs->notes_opt.use_external_notes = 1;
+		revs->show_notes = 1;
+		revs->show_notes_given = 1;
+		/*
+		 * `--external-notes` names a note source on its own. If the
+		 * default notes ref is still undecided, settle it to "off" so
+		 * this option does not also trigger the "no explicit notes
+		 * refs" fallback. A later use of `--notes` or the deprecated
+		 * `--show-notes=<ref>` can still turn the default ref on.
+		 */
+		if (revs->notes_opt.use_default_notes < 0) {
+			revs->notes_opt.use_default_notes = 0;
+			revs->notes_opt.default_notes_suppressed_by_external = 1;
+		}
+	} else if (!strcmp(arg, "--no-external-notes")) {
+		revs->notes_opt.use_external_notes = 0;
 	} else if (!strcmp(arg, "--standard-notes")) {
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
+		revs->notes_opt.default_notes_suppressed_by_external = 0;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes = 0;
+		revs->notes_opt.default_notes_suppressed_by_external = 0;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
@@ -4105,9 +4128,14 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 
 	/* Append "fake" message parts as needed */
 	if (opt->show_notes) {
+		const struct display_notes_opt *notes_opt = &opt->notes_opt;
+
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-		format_display_notes(&commit->object.oid, &buf, encoding, true);
+
+		format_display_notes(commit, &buf, encoding, true,
+				     (display_notes_use_external(notes_opt)
+				      && external_notes_for_grep_enabled()));
 	}
 
 	/*
-- 
2.53.0

