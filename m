Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C616439;
	Tue, 12 Mar 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256238; cv=fail; b=Tjt/krxYtYywvstZ5FopDVVpCJ6FwkJjFfnuPki+ds4NOP/pJC46EAQBHvZ63HkPvVF7tHGOfFQB0PWNgS87nct8L6FPOaRpKPN8XjBj0PmPkEh4tjzofR8/+LR9yGlNGY1VdRio4hy9d9wZUug1EnJPUZp3EHZv39Z7sLPB670=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256238; c=relaxed/simple;
	bh=Lqg44aJcE113rtN9Li2MFRBZgugiEdrVr2p1hmQDoYM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QXX1SePbsZkWukbuhYWQfnr1/IsJ7SWTPHMvyxeX5YF1WATIevL6ntxeGCEFiezZnUSr43aknCQZUZOLCQ1qp3GIwn7lH2tE/kXiVRG/kWSW1cyZL31bAjQyXzhGrLkjV1NZM24NoJ5hsjuoe4qdUWyHH+JAYzsQ8fsWWAH0Xlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h7J7r8Y6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KH1Arz2k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h7J7r8Y6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KH1Arz2k"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CE3r6F008833;
	Tue, 12 Mar 2024 15:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=iGfTMXOdSYCI9laYHOfRjErQrldzsPurYbZGYZB5ilY=;
 b=h7J7r8Y6ZhYTja2pPQ+Ey+WwEmq9ZmX5WRDbyJOdo0NsI9bsw8fLakSIfza6GaKMWd83
 j/EvL/LGTpDqT3d85aV56wW5pvlx6msPKPVClChztjZbFkh1yDkEOL7zicsiUr/njftr
 61iR9a23039z9mkALjkwkYgremI6pgV4GjI1xknhOl8X32a0pXa2buR5g4Gqfw3OqiN/
 6o6Q3kjw3JpzykKNYuLJLp9mXgaqMHWvMloyRQxvBZA+oImzCobEYNiCBJybCZ3t2l5N
 AcoLv1t58u+VPOXXqe4uzxHUtTGGuowquUtSrDeBJBOqR7Mdw9aUGsIPpTpIc60rIc/e 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdebqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 15:10:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CEASGM019728;
	Tue, 12 Mar 2024 15:10:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre77bw5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 15:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH/3700hoZXKedpPzwgs5Gv051WsRyLYlqGCdGHyQJbzo1TxJ7n4zBxscedrcC2TTxiVoK0uO97+IW/3EBtkrV0fDnWus3/tguMowWrJnKhricvEAkkn/Yxk7DCaPHJsBoPZGmdFzIgf26zeYBPiTaUH6i6Jh4t2fYNyh9RJxAVU9fWPDXqA5puz5I9XZG6VPifpi7A7+ZDdipb/aMAr2qcester/LsuGJC2SN2wgAXVggIJd1pIf+VTuUF9x2Xn2lOUToN8aDnHt8FRF61XPL875TbWkK/56jW5R0JKYJmpME9VHde4Bv77hF2MMe5cXGoO/7aXrlCM6q8ZoS2iiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGfTMXOdSYCI9laYHOfRjErQrldzsPurYbZGYZB5ilY=;
 b=Hc/Nx5UhlIlET0AtoykbKDNCSF+8K+CG9EMKuXlTyW0lBmq50TMIdrmAHjG04FFfH9m+1QRTlBTOAqyo/b1brZYRYJMO0SnaFlxOG7dUjYHV5u1QLMeRr5QBpVmrL4gyHVgfsz3NO+Y1xaUchb13poX6aAeCXh0ijRnmqhLKLwnrsHWfVZ9X+DPjUwxBBZbXKj3oRIRV8NFdHBT5UIQwQBaQH3IlALKgaztPri6pXelqFUpSrnYrc5aUnXvqFNQ06ihKZOADNtvOHeLa8z4bnTj42pFjVf3bmeQ8L7PRHkX4DY/PYs+skXmAv7OkrkoC3+USe96NstXfX6RA4xQygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGfTMXOdSYCI9laYHOfRjErQrldzsPurYbZGYZB5ilY=;
 b=KH1Arz2k6H+z4nqSYiXblYMg8IX7xbgsaGfs0VzvfkNX6aIo30v0lbf8epzzHOKC1peCicT/czkxTA2IP/m0R8X1TvPW3VlVlQsjXcoEaFVyXz+g1QeQMjb2eXZ1LqqNKGhLaAXj6tCLZrhtOna5rUWbswy7Kn1vc2/qC41z3dU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 15:10:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:10:32 +0000
Date: Tue, 12 Mar 2024 11:10:29 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: git@vger.kernel.org
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: t0032 fails on NFS mounts
Message-ID: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:610:38::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: a4de53c3-e693-4dd7-c4e9-08dc42a68fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LouTRkdfH91SIWR8/jwTrx5w051w8m6wO7Lj6mIr7eJcO1v+v2DUFUjvLcgLOS1/56a0KAwAlpyaeg+PEYvBxlZ+E8W7cOY/LXJOTq+eRWErM2j9LihjB/qy78bhUssE2vgHj3Q+Jxw79lDw1qXZ7UbFojmQRxqVU2tSS5GpChO2p4ZBqAtuuIM9qWJ0MQMT1u9CuzNQdooudjLUagc5GROIGvlT2iDLbLk0q8mUZQh5C6qfhBamxffnyWdbcbNOmeOnakHlBNd/vcOMeFvHPm6S8PhsOPVA4aKvLsTO3U0cr6dRhUPO1J12xM4BHHpbiHmPa/DMVhA6D/mcdr7oZ3RgorDSy1x8osKhHtoa2aMgU7d4zO6GaSnBZuSvvmHB5O3KV9WWndyOGAT5FeAfZHzvPmuF9yiv4qE23Nxl7LubiAH+xSQzln/Ef7f2DusdH6rzlLZVqYtkcWlYUe2Iqvh+8C9tyHEqwazgmc32RTGRc4vjIBOYQ6917MhhJck2S2z0+mEjgJ+/3mLbzU0Ax3QnFXMjCsgwSBoBM7JreCFNGzplHXglAfJ4C/tcasw+vxuf65n/g4JRADG9C/9YdQnSySFAERstrG1UjLJeDXCVd2uMWzD9OHgDKyjgoR8KlanKlW/dyXyc4DSbHEmGCXmALh9gapFijNXsN5344jo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GTj4Zlov5d+1P4VSnLCfOoUagf/BSyFtZc2i+JgouuLbEV1vTsuyfvMJwjvR?=
 =?us-ascii?Q?Ib1KncGKHZw0x6+XbpV0JwvJgIscX7fyhyBmnKU5Y6mrb4HoGM6iLjCTTG8Z?=
 =?us-ascii?Q?yo/7J+G10L9Pro9/XxEKklVJPZchk/qxqg49sU4DfiaxO3//96SSB6a4H5ub?=
 =?us-ascii?Q?qbDYHzRSQRr3HTWTS+qpVL5RabS1JerUOut1Vv1+jnYDUh2S4EoKGRdku+Zc?=
 =?us-ascii?Q?GVH6foLhqZwbqfj64kk/VrGULRFNJHS6VccQhV7FSmo6RW/5UWXKn6MpsTk1?=
 =?us-ascii?Q?JP/A+wzTIrEuODyPgUeEFCTMqmF6i517eCAMXKLxIbhf5SN9H+R1FAi0HPYI?=
 =?us-ascii?Q?u2PshoaG6KRlgVp4ZdsnqgA7ZtmdvqGVTB1Hlwj9A9wqmoO92KiLTViPqXL+?=
 =?us-ascii?Q?YjbBa+kevu6UVkwcZM5aLPeylt5vtyvl3dQMjXNrxLE2jez/TnBlZPhbfDZM?=
 =?us-ascii?Q?w1LtOpSQh/om40ukM48hNT4azdJoeqLG4qI/+ny95cbm40EVSsNu/LrWAyq/?=
 =?us-ascii?Q?P2eS3fnyzhIs+oOzee+p26JL+cJHSh4B2VcmceIb2L2uvFFcArqcRaf+nCiJ?=
 =?us-ascii?Q?AW+LKxQy0QdQav9P//mAo5orZfPwb8dPdvEagfk98TiykrWvw/uhkRr1MBMk?=
 =?us-ascii?Q?DmLleN7jooSFZuDfj6d9f4QVCHQVF0MmD6sVhCPGmRtUbkRmCnmyJbsmwAYF?=
 =?us-ascii?Q?8zcK4/OYZBAz+qpwUyeIjjdq7ur7ob/4eTJa6HKWkqibbjA2X2ha46r3Y98z?=
 =?us-ascii?Q?172FAAWQYZyaeoV0hOgwI+dS7D57nAb/SkHRN+S+i0aVtCgbE7fSR9veB9Og?=
 =?us-ascii?Q?P4yrVdUyMVK1n5Dx1Jr8zm5CDG4aQbZ7pWVbtIiKfdmt0S27WJtDOuc/367W?=
 =?us-ascii?Q?jPlVCbQHq5OeO5lZth1oe8FsI591VbShus6tRYQkHpOTlINwAh/3Ueg0TLzf?=
 =?us-ascii?Q?Q23d8FKEMSap1VuJeFYD56Fm4V864bx8Nn1HOb9WblW/7No/wTBwcoFqpfuD?=
 =?us-ascii?Q?KqiK3Cz4GZOJuJtp7YH1yfEAga7wNJhEFIJB5pSWfkvohmR0bRXeHn1Zwqw1?=
 =?us-ascii?Q?mGT5vAFigknqgtvDCFTrrkSWbKXS16MR7ufW8oCJlPvZ7jUT5O5q2z4ma0DL?=
 =?us-ascii?Q?2sKimbgYzycCiSrXme8WmPOOEr2fhzG5S3hyQlhf9aU5ITXEnKt0+wIlU8M1?=
 =?us-ascii?Q?vs35wK63BWHM3Uau/2qE1RWeWtKMb8EpJvoZJgjabbj/FXYqNDbsNVYl9VXH?=
 =?us-ascii?Q?UPlU7YAH5oNJdLABjXLTkWZ3p+x8RSo7Y2r4c4ylBH0sPoj6cHd3Nm03zuq3?=
 =?us-ascii?Q?jsEGqbx6gXzsWm2w3KDprD5CLnRLFTsWTLc6H2bUUEV94kjopHVaohrHdx80?=
 =?us-ascii?Q?5zN2+mflxj5rPUIhlaS02v2CIMHpnxm37uIPNuyVkfX7SQFCz6DvUuCt6CR/?=
 =?us-ascii?Q?yZIAns72k04sxaqK620xz+eUNyJyijrEYMzRcRQwC639fow04I0sSnuB55FC?=
 =?us-ascii?Q?3BiKP0CnoE5OTgtq88ebOKRNFlYmg2rzbTorygUL+KKgjBwGKQl/KX3yqzp1?=
 =?us-ascii?Q?0wnM642buH/wkoV8R1OSHAQ7OvglRGGWNlmc8xXBbBodbTJ1t56YM4HBi0/O?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h3YdumTVOkGlNzFTZ68RK8EEExM5pRXPCGND7ISkEauJ0evHh2Q5bguXs7IzqyUPnNEsHtXsJpeuXOp8oyOozHqz2vMgrPNp+v81EfAKE3nSOxcDPwhiA9QQ5nJpJcvYFTd+K5WhIRU96sQXBGN1gTIS5EUhcPZN+QIZRnJRCl6nYxTzNbipD+8Bu9u1KJsQ2e0ebB2psbHyuZ2ltmoXI6vDilCEcvWlNJay0rBSM6+xmQLJBlITfEqXbdpTl3+ZM75aNNuCOk6hGQCzrnKtHczU1Qq13vhTbRHy1lJfuG8Ma2ehhcjYioWVr4XMqjpvW9OIef73DmCjEJeHBbElQVSM90Gj3naCdUoQhy3r6kQ1uTKvlAb2y8d+OPGuFQaQ4A3qSWx5AevoVp1xuvX3vZKyvtcPF8vINZ3tQUIH33SaKdmwKMM4KFRjBa1TeaRINXqlY3LGu/sJyqoZOEwQrOgsj+bQYatLY6OJNp8+GvOTTy+WVNct0JER2If8lCFkPvnmGuiUJAPz/rmQTNhIMgQO0zXPnpSwwCL8xX4zFT7ZtOR6YMiNy0t4Yc2MXobf+RHxYC5Df7aforS3zq3yyle+qxcsYHAhMgLZGmvfNro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de53c3-e693-4dd7-c4e9-08dc42a68fd3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:10:32.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chUo3z0LJRpQqpVqi4F//NIuIG3cEvg1JuLnxrsxbWfasUWufjQgYMTcWyjmCPsWkg/xCzSdlNY4VoyDYGXcuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=754
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403120115
X-Proofpoint-ORIG-GUID: BGZvEwKla_DMDE_lkgVBQuTOQCmyq7aw
X-Proofpoint-GUID: BGZvEwKla_DMDE_lkgVBQuTOQCmyq7aw

Hi-

I've checked out "maint".

Unit test t0032 fails when run on an NFS mount:

[vagrant@cel t]$ ./t0032-reftable-unittest.sh 
not ok 1 - unittests
#	
#		TMPDIR=$(pwd) && export TMPDIR &&
#		test-tool reftable
#	
# failed 1 among 1 test(s)
1..1
[vagrant@cel t]$

But not on XFS:

[vagrant@cel t]$ ./t0032-reftable-unittest.sh 
ok 1 - unittests
# passed all 1 test(s)
1..1
[vagrant@cel t]$ cd ..
[vagrant@cel git]$ ./git --version
git version 2.44.0
[vagrant@cel git]$

v2.43.2 seems to work OK.

-- 
Chuck Lever
