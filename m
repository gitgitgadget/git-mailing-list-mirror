Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B42BEFF5
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490602; cv=fail; b=pDRsk+ZFRLdE61JqbQHG38ao+dFj+l3E1ZNC/K+nsuYipt3H4NzibdqO37qG6AxQcM2fPJfhvr1HnRRGDzkPxmNsiQ1/ZCGNtehilo2xHs90i+pc2HkmxhXrcywwikqqcKMJxzu1BDAl47b620pIm9urzJcBr246erzpsgyNmdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490602; c=relaxed/simple;
	bh=edDIuXdrA0wGyW+SvCG6LjITN4DNpXanm4xRQLe2xMw=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=tMalbUZpvZczm7rWj5xq9HeLloQUJ/s23nW5DAXAIajy9S4Q54Y2qzEqnrfSTfaH6Ha978PG5GIDyF71zsZb7w+qD1ltQYPXBAWxCvRyOZOL8gRfdSD3N3FqfcdhzqltrVe+1n04KgBWchDmVOy8oW6p55y1+zrfey5G/sxrG+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=1iL1u8OY; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=tozMQljf; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="1iL1u8OY";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="tozMQljf"
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7xNKf4149246
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 02:05:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=9cGegj7eWXI8i
	fZkgnoFfb2kZ1ycbtKZpH+GPxXAVjE=; b=1iL1u8OYwJVCIG3m/b1cXOKBcKfjo
	7oHr7a/dD020Xw5x27ssC8rkuZxIdfkRM2ONxtrFVaLFfwOxoPnhhKYEFBbFuoOq
	AoL6hk6ZC84XAvqasfKuvLPVtaVKZjNGnO0QrOMaX8i9lwbeFOjgmEuH73y1MRPe
	MZ7APwwRIF35GuKPb5Nk6VmQJS2dchwQFwvuGeQoXYLlvdbY1ZSniSN7ivbL71zB
	L2swyg+ulY7eptHznQEQkv0K3OuXAkhwirrf6EC34qQHZXgdDRa09hFSHTCTSQX7
	pYDmP4NcYu04HUOtOGvv/ChpIbh3pvYHECK7tkbwgKaI4dwGfBQlfSKzA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022101.outbound.protection.outlook.com [52.101.53.101])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4frqg2g5jh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 02:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts7VDofZOtjtrDe8+KFpXuOdM1Gb0dR0210MFVZnTaHgo3290DWm54UCByWkKeeSvywfC31JcCF/ygtBDVG4jj5vXEMPeUyFCnx+vJ/qBu47ffU4kC330UyzDlug2vvxi8XqW3ZYOM4KOKyp/TxEobglwhMpWp7UE5jeyDBNX6oxmhmm/QbSKamhYvuNngt+xcKjgrXsXxXC07GPyLYhbDHahSIKFNFtLnilxprLgw1i1RfhVs2nIIY+W4AOMRRqErHOoRRss6OuNk06CKDIrWt3ZzHkTkK1+Xz91yvRpONDAguNK6i0Xso2VQSVsO7gVWLWU04E1GzDzGfadiyr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cGegj7eWXI8ifZkgnoFfb2kZ1ycbtKZpH+GPxXAVjE=;
 b=cvtQ8dMBhDaroBKdUZOpiQ1HFpGAL+ivhV674IafEGnqKlR7kbOy9MQCob4lKQOJg2O02gkFwVup7zCaH/rNzi2amnSmMmkz9ckNseF1kvSgq3M/zANCiWrxUGmGrWm+lFSAYFMb3EHu1Tt+WK+Fg016rZ/2BVACn2XAFsDAoGbtejBG+N4SueUHXb/zykwXLbAUFM1TEUbIgbE1FkKYnosT6WmyAJr0gHvroz0aZSZy/am/RmI5e+EKo5ScdT52ZVS2nlEqcp36aUOA3hkbEwy7nWERCo3WL2hozYFWFa7EOJAxlnmWBj86m4449WptfvMVHY7YOyLVBLhQ0qg7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cGegj7eWXI8ifZkgnoFfb2kZ1ycbtKZpH+GPxXAVjE=;
 b=tozMQljfeZMCSxPMI5nvgu8VnbV0P+7hZEc9fdUJ2VFU4N33wiSCgBGVwKV/cQEYc/WZ83EUdERhE42QINmdB5u0Vans50iheKTYMRCfz1mg07tT+KEr2OCLwIKUoymDOZe30PQNQo5uZUNhOQo2fTUx2vMPkIE4vQX4qdTVeKnbU/I3UmdTKPajL061PSKsKSMwEy7GxL9rCFiKC/3tK5LF+RldOWqA2kLJc9c8IpidRoeyc4Q2kSViqbX09RIdQi8pfm0pJvZ9Ma0u4lD8cNQanFSAucjFwduuU7j13nwyx9C+jHGOEQoWZ2r49bmpNWyz3B1zza7hpgEzLK4C3A==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by CH2PR02MB6645.namprd02.prod.outlook.com (2603:10b6:610:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:05:26 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:05:26 +0000
Message-ID: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com>
Date: Fri, 31 Jul 2026 10:05:20 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Florian Schmidt <flosch@nutanix.com>
Subject: [BUG] "commit graph is likely corrupt" on git rebase
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::12) To BY5PR02MB6196.namprd02.prod.outlook.com
 (2603:10b6:a03:1fc::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|CH2PR02MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cf7dc3-4342-4b23-5ca0-08deeee2dbbc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DfKRROOd57eqonqur9+yX/lZnNKEVyXovZGBMKfWfIk3IMKHWywjXXAX/gF4Doco9PRTdz9gNFw/3BLJQ2Gojk95aJcyFB+jULN8bAqR+4SNqTCo5uUU+LnRVVJen62349EeDtOeSQY4l7AaFyp08cG6J/C2M9H95pZcydzwpCElevLc9tMlMAWuruNqwiHfNvbMonbzPlFIvhyVeByoOj72wFnpdhWx/IWd5+hR82bEBd18YFxARzEGYYDO6zcr7vtFLLriI6GB5hu7eYmFwGTd8OGLZtnNDJiTPdhtfYhgjq8uwjWQ1JSG7HgE6QRq0ZoJOkL/s1kY4WcwBP5DJxFYzuXBbb6leo6BamtIuqVBGT8Mgg0LWhN38O1WMEZHU6iFP33wxWplZy3cZoOWEJVrPY9B0ohmuXeuCy1yw54M3S8S8jmgg4eU8TbTg1uYKy4WORbMsyvKB2uTpmzMSlxGJx2k6emToJjAGS34dnpr5JSxeIzFk2oPiB7qmUnNY8TfGKEj0gmJD+28beN8hg2RHkg32Cv3aPVUQrzVSmGwjG6nS9kK6tEk6u0va5R7gOaB3UpDSrWDLeRLtmkqKbVHkwnWlirer3b5Y9OOuclbBtHXPH7WB7TmiCQrYCkCDSCsj2pjp7gqgcwUIcwRVKZ3jkN8Qevjoty2Ud0PF8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6197.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHc4Z2h3b01mRmg2WnpQclZ0TEhoWUJ4eU1USVlOM3dUWGMwbHFsSUVTMlN5?=
 =?utf-8?B?eVVMK2J1ZmFIaXR4ZHE3aWVRcUhpTnVIeXVrMTBkYVBTSkhmUjZubm84c2NP?=
 =?utf-8?B?TENuYVFLYUdpN1pqakYwVm5GeUtURkM3TUZIZ0FVNjlWSVZ5ZEdRaDhwUS9Q?=
 =?utf-8?B?UFRGbTNmdlZBUTY5SitVQlJuai8xM2U3MjByRXZ3VlZSSVVucHdXUm41cSs1?=
 =?utf-8?B?MDM3NXZ0L1Vxak0zUlBXaG4zcWlDNjBiYVR3MUZnb1JGVEJIbi9DeDdzYkFQ?=
 =?utf-8?B?M2NzTi9tSWJxY1JUZFRSYVc0ankzNmNXNHQ0R3dLTWh5UTZwNWYvaVgxWXhX?=
 =?utf-8?B?SlkzMGFlR0NCZDd5dHBIcE43VW9lRlVmYUZtdmFCYmFpT2lud3JFNnpHS1J5?=
 =?utf-8?B?YkVnUjdzVWp3bzhJUWdXdndpUENISyt4UWhVOTJoY2p0eE5JSDFJSjZPODFV?=
 =?utf-8?B?NE9UbExDQ3hoZjBTcnlTd2M2TTd2UzZ6Wm8weXJRVkk1TWJiR3poTFBzNSs4?=
 =?utf-8?B?OHBVWTRHQ1d1VnhObkVVai8zMmp3bjVPR0dTNUtNM3ZKUmdWZU04MGVONFo3?=
 =?utf-8?B?Mkw2a25xR2Y1YURuaG91UnFCbndnSTh3RHo1MTJzUDF0c2lpMTh3M1JSNDA4?=
 =?utf-8?B?VmtoT0ozT0c5TExqTEU5TDI5V1dPK2F2dTZPRUlHTmN5Zm5kekx6RHR2T0RF?=
 =?utf-8?B?RlhMUzJlbXhHQXY3OFZNek1td0tSUzZrTWV0WFp0dlh2cDFtTXk0alEvbFFK?=
 =?utf-8?B?bzdRcVdTQ3VIR1JVZm1QOVk0Q2pTMjdWQ1lqTzlQcmdqaXQvRHVKT3NBMTJt?=
 =?utf-8?B?cm1td2lnT094cW5HREl3ckFWTThraHpIUG43WVM0amdiWjVKUjNrcElhK2No?=
 =?utf-8?B?cEFYWE5oQU9lanJWYlZqNzg5bmI2dyt5OFhUVUJUR1JIaTIvcU1MSjYveGEw?=
 =?utf-8?B?ZTZnS0JxejdhVkFDRmxnN251NXdzclBIYy80KzdPOW8xYmFUazJsN1RXTlln?=
 =?utf-8?B?YXRYVEV5dHdJWVNKT3lDMFFGeEU2SDJHZkJiQlE1WHhpbkJjZHRnbkxTc080?=
 =?utf-8?B?bXk4RkFCajYzRnBudklacWhkVjE5dUFPL2RGTncvM0djRHZHYlluVFdUaTly?=
 =?utf-8?B?NE92UGU1Mmplb3hPbDRUcFJKd2Z3RGRJWHdTbENaODNzc1JWM2x6elhsbU95?=
 =?utf-8?B?R2ZaV0hHekhRUFF2dEdoUnBIUVp6V1FicjF2TmVjQTcza2E1T3BqOFJkUmdl?=
 =?utf-8?B?Z0xzMkprY2RmWmRFN0NTc2hBTTF0RmxRYTJjVjloVEt1bWZYZDMyUVVjdE9D?=
 =?utf-8?B?SVc5MVM2YlM2U3g2YWlRQ3hvMmR4cXZtcE5lU0prZm5aQllvVFU5UENtUjlS?=
 =?utf-8?B?cVVCWHFOdHlFaXZTTHNZNXIyZEJjcEFSUTNTQ085amJad0MyREtQT2tNN0o4?=
 =?utf-8?B?KzlSWVRmK1RXemFIenZKOVAvU2IwalpLSUYyb2RzUWJnNlFnQVFXcHowdWpv?=
 =?utf-8?B?NHFNdEdJc3hDNTFHMmNweSsrVEpFRW5BblJhVEw4Y1hQcVpJaU44SkxmTEFy?=
 =?utf-8?B?bW4yOWZ3S2R0UGl6c3JyM01wSEY0ZVlJM0JqTWxvRjdhb0FJdU9URVpkNEVu?=
 =?utf-8?B?M0JHYjltN3FmUHlaOFk2SThjcVg0V2Ivb3UwR2FCcW1mZHg5elU4SytyWHRW?=
 =?utf-8?B?OHlvaG9GRTVJMDg5ekVTamJXbmhmSk5admpnM0MxTlpOY0s2Sjc2NTN1bGZu?=
 =?utf-8?B?REVoc1F1dHUzMzlqZmdUVTNDUjhDYVVEOGN5ZFo3SnNrMUFjSmp6STlTMGNT?=
 =?utf-8?B?cG5RNEVQYWRlTk9sWUZBTUI3T0VpUGZxcG1SbFlKRHltN1ZkV05aR2EzOW9X?=
 =?utf-8?B?UVFFYWUzb3RaQnRtUzIvcHF4SFFyZ2MxUDc5MEtEUWFZY1pkSWx1NlFQbjB3?=
 =?utf-8?B?Q1d2S0FNOHRvVUxxUGRRYXZjNG04T0NaU1RlWVgydkhIMDhsVDFyOVVEODNi?=
 =?utf-8?B?S3Z6aGpvNUsvQi9MQmRxNE9yeWVlNWRaTnZMbURKb2lHRnN5SmllZDVtYVJr?=
 =?utf-8?B?ODVFYk5QVWRtUGFrNCtwMTQwZTRKY3Z0TzVDbEpkWnJyeVlsQ083Zm1wQTFU?=
 =?utf-8?B?dE9CMFpudDVGRFplZmx2K2NVNk8zLzh5MkFab2NCUzQrODkxaGxFUDFnZXdY?=
 =?utf-8?B?dGcxQzk3WVRaNkVsWjRMc0NkMTJMUGxTNGFGcGNNV0RHRk5zMzZWVjdhNndY?=
 =?utf-8?B?Mnk2R3NBNWFVbXZaUVNaNDYyNnYzNVZWckI3ZXFmWGt6WjZERXlsV1VCeWxy?=
 =?utf-8?B?K3FrZEw3Rmxua1prc1NIeDdEZDg5OEt3d1h5THMxUEFWRXd2T2lwbzU4TWs3?=
 =?utf-8?Q?YivAZ4Heb6jTvgN4=3D?=
X-Exchange-RoutingPolicyChecked:
	ARQAgEdjYH5QcFZBPjyLflr3DuRL8Eypk31YWK+zA5bCyQ0owfKwYrfxl4IgKKrMjYuhE9DMe5ejH8BkoOdcWjIw4aVFlryJNnXp5EO5HNmZ1hy8xC8k62Ay6Jm4f7i5ksCJXLj1xTHcK66g3ZNTkGvCDO4bNtttCUvZ06ZN02IC8iTczXHt4KTeVbp4Antw5wOUVAat7reyS6LPtNqlQZwa510cCmFXgFtTaSHNm1lhFbEjDQ0LbH/d/X2plv6DbWDQj7GzVx97rUD/kYGRc4QPSjo2K55ogr1j1QrWP5aoWNEDEbagucTJ9ReT0zU30HxJmx4I9xpMT0qzNs3Wow==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cf7dc3-4342-4b23-5ca0-08deeee2dbbc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6196.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:05:26.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1036oYdwiR0CNTAZz/r3FOXm8X563lerXNMgHF3CsFKIg9q+gBHZTPLes++LMSVRtpWMrZc/AcL/w1CIkmsmAUoEh/qlVqWWTrNyGYMK1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6645
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2NSBTYWx0ZWRfX5yNbslEwnaoh
 EaBi2HEnmG5kx+5F49B4UD/2CqA5ZhwT9UQVTFpKJuFXGsX6IqfLCA8Z64LW2goX7XLBy6PMVmf
 5GOHy6+EOWLA4kVrFbPne71sxFjD8ro3gakhY86KU3rXhRWaQ3QcYnLly1finxxU/jGrAgupyWy
 u3oX3sR/wvsEatHrsIZblGDCpv0+8yspEZUfdWAz7qgXGN6wJ2s75d+g/+IYhd+8n1vv0QT7MiY
 qbgqIAWNNwzsDjGBxOznUct65of8TdYvu6Dk1csteHt6XfTQemR+XjArxtzNAALiJC3c68S79/w
 /GHH+aDelNuQ8K8eDkSwd4N3twjE9vKckcSEBVnH7Hz/witUx34tDR5fJaVHF00NmsAmsVQSLDF
 xdYBpseOaA8Wgs4P5SrNFGdKboK4+eeqv694huWAvPwU84EzkJHzD7yXvdtV461ww3gArYW8vvI
 9eXMv9fUm650+JuQKrA==
X-Proofpoint-GUID: DTWPfIQlmb-pAPzCUuStaI1KU5PSzf0K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2NSBTYWx0ZWRfX56q1OpP3KRpb
 q+a+i4pgTSecmlH6m+M5FY9JuQSUj4y/olMbpUHzBtx3JczjWD8FfzrVw2UP6T8LuhW3oWvgOmw
 B+dLLc3Sc6Ab5lkveQx3tur295TEkmU=
X-Authority-Analysis: v=2.4 cv=MoBiLWae c=1 sm=1 tr=0 ts=6a6c6559 cx=c_pps
 a=ZOOYKzJuauqLjokEqQd8dQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=WZf07Cwjq8wu9pxtO1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DTWPfIQlmb-pAPzCUuStaI1KU5PSzf0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Hiya,

Hitting an issue during git rebase. I am starting to suspect git is 
possibly getting confused between main and submodule repos. I noticed 
this with a self-compiled git 2.54, but I compiled git v2.55 just now, 
and seem to hit the same issue still. Full bisect at the end of the message.

The first-order issue, trying to rebase a work/foo branch which is 
tracking origin/master.  There's only one commit difference, a commit 
that changes two submodule pointers:

> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git show --format="" -p
> diff --git a/rpmsrc/kernel b/rpmsrc/kernel
> index d8d411244..17006b605 160000
> --- a/rpmsrc/kernel
> +++ b/rpmsrc/kernel
> @@ -1 +1 @@
> -Subproject commit d8d411244cfb3463ce09b9577970f7955073ed14
> +Subproject commit 17006b605eaed1820ae1c717d4782728b9afc6d3
> diff --git a/rpmsrc/qemu-kvm b/rpmsrc/qemu-kvm
> index e7d525d0f..8bf4019df 160000
> --- a/rpmsrc/qemu-kvm
> +++ b/rpmsrc/qemu-kvm
> @@ -1 +1 @@
> -Subproject commit e7d525d0fdc42fca65c2b70bb5f56adc5aa1d7b1
> +Subproject commit 8bf4019dfcb320108a0f014d92d926320a4c8058
> 
> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git rebase
> error: Could not read 157b7492624beac3ac667dd3a84de9969377866b
> fatal: invalid commit position. commit-graph is likely corrupt
> 
> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git cat-file -t 157b7492624beac3ac667dd3a84de9969377866b
> fatal: git cat-file: could not get object info

git fsck reported no corruption, just a bunch of dangling 
commits/trees/blobs, no warnings about 
157b7492624beac3ac667dd3a84de9969377866b

Now, hint 1: the rebase *does* work when disabling commit-graphs:

> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git -c core.commitGraph=false rebase origin/master
> Rebasing (1/1)
> [... thinking thinking thinking for a long time ...]
> Failed to merge submodule rpmsrc/kernel
> CONFLICT (submodule): Merge conflict in rpmsrc/kernel
> Failed to merge submodule rpmsrc/qemu-kvm
> CONFLICT (submodule): Merge conflict in rpmsrc/qemu-kvm
> [...]

which is fair enough, the submodule pointers moved.
And hint 2:

> $ git cat-file -t 157b7492624beac3ac667dd3a84de9969377866b
> fatal: git cat-file: could not get object info
> $ git -C rpmsrc/kernel cat-file -t 157b7492624beac3ac667dd3a84de9969377866b
> fatal: git cat-file: could not get object info
> $ git -C rpmsrc/qemu-kvm cat-file -t 157b7492624beac3ac667dd3a84de9969377866b
> commit

So it tries to identify something on the submodule? Maybe it gets 
confused between submodule and main repo(?)

For good measure, I did a git fsck --full on rpmsrc/qemu-kvm, but again 
only a few dangling warnings, and no change to the issue.
So I went to bisect and noticed the issue appeared somewhere between 
v2.53 and v2.54. v2.53 also complains, but then continues:

> $ ~/upstream/git/git rebase
> error: Could not read 157b7492624beac3ac667dd3a84de9969377866b
> error: Could not read 95d676ad199191d81a000761733ea25c17172d8b
> Failed to merge submodule rpmsrc/kernel (commits don't follow merge-base)
> CONFLICT (submodule): Merge conflict in rpmsrc/kernel
> Failed to merge submodule rpmsrc/qemu-kvm (commits don't follow merge-base)
> CONFLICT (submodule): Merge conflict in rpmsrc/qemu-kvm
> [...]

In any case, to figure out the cause, I bisected it down to commit 
bb5da75d61 ("commit: use commit graph in 
`lookup_commit_reference_gently()`"), which makes sense in the context 
of "it works with commit-graph disabled".

At this point, I wonder what the best next step is. I notice that there 
are two errors listed even when the "git rebase" works on v2.53.0, which 
are not there in the commitGraph=false case. I wonder whether that's a 
sign that something deeper is not as it should be. I'm happy to provide 
more details as needed, but I didn't want to touch the repo at this 
point and possibly lose the repro.

Cheers,
Florian
