Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280F25B080
	for <git@vger.kernel.org>; Sat, 23 May 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532761; cv=fail; b=dav6YNMVPXdKlPfivguXndHxyRJ0/fopjL5ndV97P9nbwoCV4poh+BC7xiL0nsPkxpKrdXa6+SJA26Z2GSUfmU+AHpBKNTC6A1s+nktApTgIKDL0et+tOzQNnE1HhTghSd/T8KQHQsA5VglV5ZWxeOIj5xeubHvf9NaW3f9hqEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532761; c=relaxed/simple;
	bh=mcfXRMYLLy1rGwq5zi1JpGyXCzZByMReY0v1oDbwQxc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OwCl8pmhedbrxNmmVLTyaOmLoYyvMI1hdGT7cmhqF/vNO1eG1g8ewdHnKaTKanjpUA/tBoqq+3IfNCBylAIz7Ouf1kREXl8UZilNxfEHo0XKrMw46U3ODXybj52iW5CX7sn9NJdlboL9E/BAcitamnfH/Wpzf7RroumjbwRL8ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fYZ338LD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fOLYWr3t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYZ338LD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fOLYWr3t"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N6f1Mh2939707;
	Sat, 23 May 2026 10:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=IDSLRKPc8TV2yPlh
	M+3gF0Ee8FZpvqKVTQYPZsKag7A=; b=fYZ338LDwz1FkmaOMSNp7qMwZMxRYd1E
	KaTE4hNlDK+rBxxE5p/zXaDBEwxPqiuY/zxseFJw/PO3nMG1Be2mDAtK+65SBEnT
	V6L3knRBhRYfHqoZqfwnOpJdyvzM//Hk/ymNJLP514OsP3FZ2Oz7SDYMv0wEMSl1
	m7MYx2yTvmoTrIUBmmU1Vj7tVDJ6daFSiYOqUoxg7BRyFiotoTEoJPHfrVc+dX0l
	njKf9ThWCM2aeOYIatPnc+sd82s++/O2wLSP83jmZwxDHJWRV46zzN7dym/J6BCQ
	svFOUYieylf8a/3S3mQCqa2O1oiNEKF0a0I8HIjLIRRHwB5QbvEZdA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4aw86vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64NAYlxU034616;
	Sat, 23 May 2026 10:39:06 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p5rp8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7ZkWJzwTDiOAxZbE1FXH7QY41jZFWh5QJKPq81j8eApUdSGvBVN24EfWqkDV+m3we84o8BWI9iwjY413mdXm2sT2dP788AK5ZRilic5lhSJ/Sl/Xh+pts395MW52a1skL5bh01KHqXgO2fTkZ/ZnhdzENG9q9huWy+vygXwsPXgyQZLZPtJWtgXlVMSG/KjmfrkBokadNDtylb9hVUS8L4rmvSRqLQbzE2gkDwGv2wQev6KktsKswFNlPVTZUW9e3OvX1TtsB4lEHNtWpmoa48PYhNk09VWvijPSSoxgQ2/r46/PYKnRYZHM7XVS/D8j8gTwzt/Vw9t0O1QWGM9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDSLRKPc8TV2yPlhM+3gF0Ee8FZpvqKVTQYPZsKag7A=;
 b=UcCYX0az0J+DjA3LqMrwhldUHCtn3r+u5+J/HcJOrj6ABniCalFhQTC+E14QiWp0syNm2jMjzOT9+rZCiro9c+8XzacbWm8V+qjsSM+fLBwo2SSSAlXWbKaUvtel8DnB9dnqxUn+jzJNVC6kW1J1Nk+oYwvKpBTAbPV78X1qwk3GU2SoQ8DW30QWNRsgyM/WJrgWwSJzjivA7jCQyg89nuznDtROvtol5mzwujFal3NAd0eeHF60QGuWCvBPyu9xOZ4N9ee43MqQ5JhnM87qI7T6maiBHMsu0i70zN65PXlR8asSexWQ/hNHaD6Aqr4p24KmkaDMSWuEIYDBswgyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDSLRKPc8TV2yPlhM+3gF0Ee8FZpvqKVTQYPZsKag7A=;
 b=fOLYWr3taHvU6rVvDIHABXjWYItsVbofLWpP59iIj4O+RusXQhYO5zRupH+Gksne0fq0WPlefWE7EjwhBIg6Ha9sm8GI1uUMcZAAH2Z/S8R/e6ban2uRtoqa0PLUUSsgowyPAJc6bGadL+VD42ncq7xi/CkxZtT0qpFQ97PA75A=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 10:39:03 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 10:39:02 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 0/4] Add support for an external command for fetching notes
Date: Sat, 23 May 2026 16:08:08 +0530
Message-ID: <cover.1779532562.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0117.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::11) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: a541d37a-fd1d-44e8-aeb8-08deb8b7818d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e5LXBS/AUTDr5DiqeqyUCN62PevnEDjwSp3TzUICuOeV420oiXJI1zV/nB3x8APr94DKjvIvdgrfv5hoW/Q7cwCPwXodO8DcFdiq70FNnhk01I73xrI10rtpVF5cUkNKniYK7+XPG7WkgagHixBTY3ErFOytSeDo+MdVRb2T3Dohlvyv+udPvzR5HVUtOPaHR0K9AFEzGgmLb7DYga3EJn23Q+rd//TdJG2NS0C6CcS0gNooqFCTAg8RS6nbiD7yZXpV4upZc23nH31xBD+ZEXdkJLVnhf3+OWlYy6G7yvle+A5rnUGuMvgB46Zs3SXsOAWY05OOVMM9hQdeodoCfz+i0g68ZiD38JCsTiSnW1k4LDbAwD1Oq/UCdsgVzal3MelciYOw4qQJMpngyBfatP2EpPMumOWOMK3XabOwC7ZeaC3CDstlIJVPI1qeYFsDJlGasps1/jfmaRVh5hyFcKFT3CE2c4DTpgXhuOEV81NWtzEwlZVnGQyCLoA/IaQc7HJKfDsgRcbcWmxPbcaFgvyoGEJjvBO//SNu5bf2m4AI6Hz7Z6vmFd0BRO4ZrSL1JPxqrzyTr8DVN3NzkNZ02gRJzgaqaTBMQ73R/jrg7vDroyG7dBj6V4XEJ0OH8ngwxqS45JWjU2bynDc/Gd7Kmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LvvTfBz+8U5VeL/lSDmwZA81lbLIXKLc8WJALB+gnh2KqQrvsf+k8Wbz9M1K?=
 =?us-ascii?Q?Nzy1YAm6pH2uCuSj1PzRxmg7HEMCVL4+DQKqmBFZQ2qiIpF7HiNj7iqCxtdm?=
 =?us-ascii?Q?Lx7lZ0bQCuaPpthpkEP+I3eeVnIyAIMQOz0w9HwTbs0n3wEXXFnhNEIWUazy?=
 =?us-ascii?Q?9iF5QUeUc8W172y0CPthRMELWkYwKbIjn5cjE2CFLJX9uvCUYs8VwQL+H024?=
 =?us-ascii?Q?l2VHDBL233XtvanLCn/tl0XEwbw5p0er8Epk9b9VZag3N8ifUEOOngJSPDKC?=
 =?us-ascii?Q?/eSkOmujlcmBLujcwn6FRk2MPM+3RDxOA2+bUblrdV5WRukMy6Ad6VDyEX79?=
 =?us-ascii?Q?6Rm0B3E4uijU5xx3ZAOm+Jnf+9Wnkdqwwj3Inw9ER6+LjxIgnhB0NnuDAzLP?=
 =?us-ascii?Q?Lr52HuRQoL3bT8Ensn8oleCaW/I9iJACZ4ixFEdYyYOeT1h4JMyss8Ppc6zV?=
 =?us-ascii?Q?KCDqYa+JiKv9asDzia2myZoY7BWdsSI7/QUpbFugyPXC/ypIvgxzOLEMR+n8?=
 =?us-ascii?Q?/WUDEyDVD8KU+yd4imlGLV6v9t1DoiAQxtX7F0adY4Wed0MAOZRYvRfKmAEY?=
 =?us-ascii?Q?O5rdMEKBd3/R5frQZEr93tIhWntrpFs7FN+9v5LpDUloZwRwljcaY8io6/MP?=
 =?us-ascii?Q?0q3Hn0tQza9DF7oXkojlABIZ0LhspStOPB5iJzyS5Zq5MGU4ecbtl84S5c8f?=
 =?us-ascii?Q?SWGJHzpRIT+k/HDXIhKUjhGPNO9fcDv6xp1GUJ0O+qdwDzCUUwPxEuQHrUbw?=
 =?us-ascii?Q?F6hkDMnmKkURayIEsT5bmHHrWQAmkKy1GsXdbDQDXNyplEQLEWlgwGHU7tIc?=
 =?us-ascii?Q?YAJBkWh8yLRxWYgWhOWKLVLLTQX3ts9Bo/oHOuwAK0DGgB5PBBnefmkl8bA/?=
 =?us-ascii?Q?dMHEAGZQ3fnRtACyiqDKlOeY4qufdOnTvMvha/EvFLrLKRfyhnU2ZN+fxW4b?=
 =?us-ascii?Q?KpraA6G71k7+TMzlglOIVcO3fsNYHH7YD9lLurluOESoRn92Ggt2i9CXU8SW?=
 =?us-ascii?Q?J5+ROM1YvEu2wUN6/cr/mYRbBHC69nJyxFiPfEz7YFvgGlh5o2NJ8adhGY45?=
 =?us-ascii?Q?IMfiwEAIFsqoG/2tfP6ZlLZIwfDGTlzZGC3GIqYjyhMdGsDAxgQOjIiTYbRF?=
 =?us-ascii?Q?jNl5Mzx9J7a6p0J8WwoE7+xKuCgBkyDdQiTgF/LOqAySdAuB0OyrM3ck1ywT?=
 =?us-ascii?Q?TLUXlpnZEavYXSPWoyHV1eLYv81HfvJGk4wc7dG5ib902BRAnzBiPM8tthKQ?=
 =?us-ascii?Q?X9wQDZalzihP+n+Ldeh3vMlI/woN2KbUYOQ3rPaZ5zZ86cX/K05cH4VrhpJV?=
 =?us-ascii?Q?e063HePAiZMaWgw60wo77eqls2kZm5ZkOKFtGsPTy9vXHBfUX11z3LsAztKk?=
 =?us-ascii?Q?VxN9MgqX8h+zDK8J9u40ZuBg8awOO8l03MfXQZsAZsHFrh9mYGpTXYmxGhtK?=
 =?us-ascii?Q?04wM5xtQjJQPX3lCWI2qQTDIK1r/eVHhcNfi8EF8G3ZVU5UZS+4wWlcMtvyQ?=
 =?us-ascii?Q?V751j0cy1wx+CrxvA8UbFebwxcHu9XuskCtsACbp94N0NhWtY/92wKyYKvx5?=
 =?us-ascii?Q?jz1kSBbHEJTGU2ksOV4MEsPe7pkE+O6ShnuZ18Wpd2Ei9hmm3/+1NjcnVoFr?=
 =?us-ascii?Q?1vmYIOecMV+nT9DRWjtfmozoGEI85h/7m6gLZQ/y3h7x1sPU28YsL5gR1gkv?=
 =?us-ascii?Q?o2wjpxbaVzGt9HhG3KXzP6qOZAF5BdCfn/a8YGXtfi3OGDUC/aS1UwMNrRnK?=
 =?us-ascii?Q?oyb/embKGUbOK46aZe+lpZyraGhmzW3/99f2UpeolybQ8+R0+wVR8zxn6pqK?=
X-MS-Exchange-AntiSpam-MessageData-1: US9EuEW1dCfT5d0ehB5qXBfCYCWeuiEXkeM=
X-Exchange-RoutingPolicyChecked:
	P1D3EZTEW7xLKq9AwmxKXOPbszvxrvAjiM6tYtbiA/E1pBoccwBDc5kCMqu5GdgTkGODxaC11JSr/+lRR0IpNbLJsCikAZs82q5LWiKbZ+AttinQG4w3mZSvTswJ/ZdAYNHXXksjAa0pGvsoh8ZA99ZVFRRRpl2Fl0JTtU38gZ4+z5D1zF0FHRFUIx73CIANCRq/42QVOwtDEbp0r8/bxpO0qaaMleyJEz65N9DxuiMf6UmaER9rBJH2BdV7EqTwnSCnuHCF3RR2T8iRvGOXJ+PGFo41PuxmSztiRO6V5Rllz/3AC9de70ucVwvXQYpe89bTNbwKGkE8JMjbizUAog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vXOp6OqajtOCGTKmPt8+h7RIaRSd0BLJAXwGQBoFAK0T8C5bGXj4e53MmK/mCaoqefvSz5j/rAm/iLoyqu01vVO/1xcdwe/WQisRkTKqp3QTrgv6FPBkRXgq0EcyjBiB2bJgotUmETZ59XPmE855RaOQcDRLVB4cKmXmwafYS7AetydNsH0uFv5reigONgMYuvRUQffD24h0iO2tBwtjPmE83Tz5U1TyGieD8Typ8FDW4CXw4cmZgAV1HIVyqJ8rQzfrlo/OCSG0KwqfSAQ3uhzsipR15GPBhAOVK10z9w5XaU8G6qlL4ODzTUmxzMEzkf//q5q4dArCgLGpd+bl6HOS3bCUkQKhpjBvgaoyt46WMo5RVInUDPWxqT2V5S9CEA351+h6BleIkpmz9wpk7B+kYQi4uixcXp4iRXQTbSSmu7yw6D+zXfDHhSF1eB16ue4pfDP/Y0vShqITY4VYb7L+ZDa1A8/yUd3y8fheB2fzCHu4JAND+pEbT8e8BC3VzMo0oQj81stADFZ/2kpRV6Ms0irpkvaWOszP0zh7xHC1fGca+qMfOcfHx5ETE+pVFhbyHHLVGrZ8bT0pi3ud5uQT0MIZ4nePL7+0eDfL3vo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a541d37a-fd1d-44e8-aeb8-08deb8b7818d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 10:39:02.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9z7LdRhtC0oZFuml3aaukVi2gE3N6Fz3ZHLgZ3bth2Cg7yPRun23CAyuX2TQGOSQjKem3XhmIvh4tcic6X5f6/QrsS7QjEvxXOTvc09tWE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605230107
X-Authority-Analysis: v=2.4 cv=QrluG1yd c=1 sm=1 tr=0 ts=6a1183cb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=j7_DEPc9-6Edas1kuEYA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13835
X-Proofpoint-GUID: q8b_PpQVsfsUAVBQTy1HndTw24dOviVJ
X-Proofpoint-ORIG-GUID: q8b_PpQVsfsUAVBQTy1HndTw24dOviVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDEwOCBTYWx0ZWRfXzOCTeNQR6TsV
 QCaPQUPy4Hwja21O0rKgeq6Mn2AVjLAJZJL1BSjsOElU5YroUoEYmfwSSFwBwQOJZEaO+zWdFlO
 wL7hezngD6bP2F7lz3Cvk1V19ZBi3PCWDsjVOuRjtwiEDWAou8KcMkhEQTpMNYOrnP4MXFb625M
 uev/9qNFTI6E3sNZPxOTqjE8UoK1aPZ1/vsNduzz+vfSAIfPBHXOiWGJOo6p4W3IIZ4CPr1PQ2z
 98W10g0ORafOZkvKO9gDN0YdBCapouB0rb6UJwj/T9ns6ry2EiW6oFTN01Ow1ZCPo92sVIDG61b
 hWfSznujzulTguDQNbahEyl34jGkP0YaRX6xj8U4oxx/glZJf1ea/hKTLHc1Zm7TZHZOdahy3vt
 1uqFgTvfdEjGFFXTQVKoRoYvUC74L1InwMtcuDuON+n06tId1QQuoAJxTTaNigcbs6nAYsNRsNZ
 K4YJlTIyTob+gAaGPklMkJp3jOIQvial32XYXnmo=

v2: https://lore.kernel.org/git/cover.1779464886.git.siddh.raman.pant@oracle.com/
v1: https://lore.kernel.org/git/cover.1779207350.git.siddh.raman.pant@oracle.com/

<...insert text from v1 cover here...>

Changes since v2:
- Removed stale help text talking about force-killing helper process.

Changes since v1:
- Removed Documentation commit and sent as a standalone patch.
- Removed finish_command_with_timeout addition (and thus sleep_nanosec).
- Squashed the external notes command code, doc, and test commits.
- Removed horizontal separators from note-external.c.
- Removed global variables from translation unit and instead store config in
  a dedicated new struct member in struct display_notes_opt.
- Reworded the main commit to have better explanation of the motivation.

Siddh Raman Pant (4):
  notes: convert raw arg in format_display_notes() to bool
  wrapper: add support for timeout and deadline in read helpers
  t3301: cover generic displayed notes behavior
  notes: support an external command to display notes

 Documentation/config/notes.adoc             |  59 +++
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
 29 files changed, 1691 insertions(+), 76 deletions(-)
 create mode 100644 notes-external.c
 create mode 100644 notes-external.h
 create mode 100755 t/helper/test-external-notes
 create mode 100644 t/helper/test-notes-external-config-reset.c
 create mode 100644 t/lib-notes.sh

-- 
2.53.0

