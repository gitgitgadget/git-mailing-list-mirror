Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F31CD1B
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798135; cv=fail; b=bdo3qDYMYoZmKHmS7kg6ZY/bwVmxvUfpy4vi6pLuh91dLSTdp7U4jX5VyAzzE1/JSnjZKtDGt6wdf9jI7NEgda+GanCZf3HbgPVJjxeboRWqgPWc559K8cNyXVFCqV6ck/cmj96LMJKNno7yzfa1OPUZbzyVKtXEQeksr3HHQoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798135; c=relaxed/simple;
	bh=Jb9OS8r4MB9360h0sF7/WyX74d0etaGuc029WGU8BBQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qPeZtyKMLIfHKOR5aaolbYmoZsYWEpByIPumBA+/BS3DhrNZXPu6vHOo83DmP/PgSgeSQNTTCXeCKYtLnuhVTcY75CaS6FLc0gt923M20YM6LiF0MUak07MCHAX3pJhOllXaDyL8KPghl8/Pmm6uDCLIgVMeba2ZU/vm/N2hqaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T1ib97Zk; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T1ib97Zk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O3wXEL023253
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=pp1; bh=Jb9OS8r4MB936
	0h0sF7/WyX74d0etaGuc029WGU8BBQ=; b=T1ib97ZkyQOXEPEBXsEXEu95LbqO+
	mVbIh5r3t+OuZwCKKmloxzqtFY5TxFDB6xpUF+l/L3ARwuPUbXBuTTujiWRPIOUP
	3l9YsCDRFJubJa3Vvgtw8m6TLllUwXTI+WeA8HdfPa8QUN95nVWtiWZNtDXbCZS6
	DuL8jNJULrWE2ueyJYH7460ghtaaIKCzGvrFOrCXx7EvgzY2KTDnaXrZjQSCKFD6
	OBiXvIZ525d2grZisVzw0Jp0BU2Do36f0ek1xIzU36ccY2hBlRAqHR0WCWAWri2l
	38yQVN4567zN2MI3gVOXUeaNDFZMxTIGty2xK/nuXEJhWTvbZb8l+Rb+A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jt648442-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:15:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDCL1eQ7hRAs5MWeBJvvfre9uEeW/5SAUSKGyoBLng1TO6Xc2RkDsM/YcG0JBSpBcfMDJpRGsa+7gCS4xe3+TeykFxxzi67YVxS4NfOztS/ekGZy1TfnDcsg6VoBedHPcTy2TmjNN5mcoTHAx6BkX+9d/kxX3SoYOWNLZDp3MwXaY/lCIErXJefKwcOSxh8QEwI1QKk8vfc3jUNIvWS9a6loQHCF/S0NqBh+uqkLE/00PSwnQ71g5gzs3XgQFODnLe0fe59D7aZpDUTcfBnah8OOzjU9sKtR9e41ctiGmRnvYQYzTTW5BP5yFmEs0LLPjyCdu9swKCz+mYKZmKeb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb9OS8r4MB9360h0sF7/WyX74d0etaGuc029WGU8BBQ=;
 b=rVl3MughQUVgmZcMhiQF9eOACtXXtLnrU7Fxdg63PRA5Z4IgMRe2vsHkA9jLZsXS5czyxN9PfTBgIC+L5SXneZUaGU2GXDIIRtdZJeOOQxFuATxTxpDiesHQyUtA6kTXzP1x8ZbyivDzbR5Oj4eD/VGKFF/Bdzl2pVn3lCo+3oVZXDVEgd8OernXCZllaF3hKPfaD0zPjN+oGAjk+2JQrl6uidjcb2sXkTaFH9CxJoJ1z7YMwaFrRkJlg1zJxOr3KE0+UKdcp08mz0UsWb+IJq2+19zvKzuA1XuZqqJydtJiU6SVISy11QA70C4OkfIajC29Lb/FDUvP2Va0eCbCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 SJ2PR15MB5718.namprd15.prod.outlook.com (2603:10b6:a03:4c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Wed, 24 Jul 2024 05:15:30 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52%5]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 05:15:29 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Build: support - Fix to avoid high memory footprint
Thread-Topic: Build: support - Fix to avoid high memory footprint
Thread-Index: AQHa3YiA9SVvinzgfkC7up+5JymsBg==
Date: Wed, 24 Jul 2024 05:15:29 +0000
Message-ID: <194BFBB9-FCF0-43F7-BFC2-B055351B5376@ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|SJ2PR15MB5718:EE_
x-ms-office365-filtering-correlation-id: 3db76771-7694-40d2-a1d7-08dcab9fa2b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFdPV3N3Y2dhUUxSc0xNUWZJR0h1L055MnJrSjFPbXdMZHppT2c3R3h0SG9h?=
 =?utf-8?B?OGJFY2ZVd28wNlJ1NWN3aUNoNS9iQVNzZEx4ZER3VDQ1UXZRRVpsLzJQNmRj?=
 =?utf-8?B?Z2RTdFZHUWJ6UlZHUEwvQU1BbU9JcVprNVdSUEJwWmVlUGxOV1dYeDA3a2pq?=
 =?utf-8?B?TXozRVdZcWQ1bnZSMXVzRHg0M3VwVDRQRm9WYnJrYTgzcFlmZzJjdEx4QkYx?=
 =?utf-8?B?cTlBYUd3QTg5SXQrY0VuZzEwZUJyUVFncy9oVkhmdjZ4eXFoNkdBMjZjOUxs?=
 =?utf-8?B?OTNiOFE1SmQ5dU5Lc3dLSFNYMjFMa2x6Nk4xRUE1SW5FZnRzR1ZJWkVZbk1C?=
 =?utf-8?B?NWNNRGhTNC9jSUdtVGsxMHRJVWUzaTBWSmNiZWxQazZYNFBNWGJQa1B3d3ZX?=
 =?utf-8?B?eXcvc3U5dWNyaEQvOG1nK3pjVnNXZ3NrUmo2UkNUdjZvTjJtVjNkcVpZL3FB?=
 =?utf-8?B?NW9ONGw0QjJNMHdNUVFKaDNFcTY5TkJjZFUyTmZxUldFWThETVV5dHFMZ2tq?=
 =?utf-8?B?TEFBUXM0WW83T0c0VGRQOTl4VDJlZHIycVZ2WHF3b25sUzlqVG8xdkdld1o3?=
 =?utf-8?B?N1VQbmd3ZENWR0ZpTEx0aEdRdVhlK3hneUJudUN3cU4rakZ4akpHSS9mRE9a?=
 =?utf-8?B?dk5VRjdyZ085MjQ2K3F2N2F0clRXNkpQUFF3SXFqdUw3KzVMK2ZadE9HbEJG?=
 =?utf-8?B?Ky9wOG9yWGxlY0tkMXNiSFJDdUdZNm5NZW9rYUlYYmhTRUxpbll5TUJSWHdF?=
 =?utf-8?B?cFdQRndsVWtjbDNLc1ZvdzBIbjBxYng5blh2Z3pSYVpaWFZ6UFRTRENTMGpa?=
 =?utf-8?B?cnJsazcyK0wwNkprUnpNRkFXOG8xZXYxU01RUVVEYmVjUEJwUjV4MGh3TnZO?=
 =?utf-8?B?bm8wdmtlSGh5alBmMFJrelVwOEhldndUVk92ZVR5NFdNd0Ntd1M4ZCtkdVN6?=
 =?utf-8?B?R1EyZ1FKOG1pand2Ry9FYis1cVRwZm5xWW01aEQyVHNmbnVxZkt4aVMydlY4?=
 =?utf-8?B?ZDB0c0d3RUZ1UUsrenJ2OWl4SDIrU3hiRDA4T0poRFp6SEQ1VTdWdldVbGVC?=
 =?utf-8?B?L0psTnA1QzhjdDhuTU9IT3dlcTc5bXBXaEUwUVErbmdmSGQvTmljMXYySkNy?=
 =?utf-8?B?SjZiSERUc1V1czRub3h5V2RDT3MydHF4S1R6MVh3eEhoYzIyU1BKYXFUa3BO?=
 =?utf-8?B?Zkc1a2tXcVpWN0hGaEFTN0Y4OHpzRzBzZlpyMys1N3Y5MjR1NzRDa0VKcXZu?=
 =?utf-8?B?U3NQRTlmakE4a1lQRDVESlNsb0dQWDNWZW4zZ2xZckx3VTkzRnFkVTFza1ls?=
 =?utf-8?B?czhNNGhzaDVjRWRHbmtLK0s2ZDhUd2w5OWhhUWwyZ2wvVDJadVhRSEt2Tktt?=
 =?utf-8?B?L2ZMUGhiVVhIMTcrQzU1SGZ0T3lPTGVPQ0dWOUFKSFZZYk91aTQ1d3ZEd0Jk?=
 =?utf-8?B?MitzNkdxMU9IclBDSXc2NG9vT3dtMW02ZWxaNWlrR2d4Qy9YT09QTlZ1TzJJ?=
 =?utf-8?B?SGpYY2ZDbitPZmZIYUh2aTRwRGZvUUwvLzBic0hCWTJKWnJuM3hxTUhHdXA2?=
 =?utf-8?B?cXRrMytVYkp4OWhwY3RjUVJSMFVhb21aaXgvMUZHNnZMNUl6SEYxMFcvYWxj?=
 =?utf-8?B?UGVuWm9JQlJwcUEraGo2cm5rYlF0NjdmdGdzdExUNW5SdFJKL1gvV1RBSk16?=
 =?utf-8?B?OE9uU3pRTlJJbkFlUXU4NWk1RGlkdmhNUm94dW5LVVhOUUgxQmZURytTOTQz?=
 =?utf-8?B?TVdoRkhnb010MzRSb2xhazNSK1BaK1N0QWxDUEgzSy95cjQ1RWJPQm5VSkRC?=
 =?utf-8?Q?QIQZHrRfGwcYcU4dGGLjSOT2Y0Cn76/YGGb7M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDBqWjRnM3BaY2dOMkNEK25Tc3RFNGJHb3c2cWVWK204ajVFU0VEbHlHMHJn?=
 =?utf-8?B?QzdsUjZBaGp5cFYwaitoa0RPa3JKVWNsMkRBYUxkcDdrNXpQSitBUzFHMVFh?=
 =?utf-8?B?c09JYmlEWllwa3Y3ZW9vbjFFdk1vdnpBcWVjQU1wdWo3V2pWc0RFUUR2T3VP?=
 =?utf-8?B?Y0NhSVE2RU9HOE9OYTYySG1FRnNEeFlqN25VYVhZeHp6V0tiRTNFNkh6UGZN?=
 =?utf-8?B?cFVZcnJodS9TajFKWmFOUTJOUjEzSUhMdktVUjBBQlFoUHZaSFAySU0ydGdz?=
 =?utf-8?B?Uzl4ZmVpdVkzamg1MkowZHkzendCNWUwSmdXeXRMb1p5V3E1enAvTW1rNU5H?=
 =?utf-8?B?azcxaUZnQXoyeS82bEw1cWduMVpJTHNwNndmWUM5TytwUFdnNlR3dzAwdHBU?=
 =?utf-8?B?ZFFRQXQrcm93TlQ2ZzhIeEtOUmZrWmR2eklEa0ZoRllDTHlVVTk3MHNTUFY5?=
 =?utf-8?B?YmNPN0c2VEZyOS9ldDVlVHp5bTlnMTJxUG1JSjBzOHowZGVGdEV0Y0RqZ24y?=
 =?utf-8?B?aE44UmhxVWZyenoyTlY3Q3JqQjZKNGtBV3MvL2I0Q0VXdUlwdGpkVGF3T3k2?=
 =?utf-8?B?SU1oVEtDTUdlajRKUmFUZGZZKzQyNGpucGo5bitSQWI1aXZuMlIwYmFqTS84?=
 =?utf-8?B?R2lPejlheDhibmRNaURsRm9pYW9TKzd1bXN6WUdDb1BoZm5mT29rdTRXbEwy?=
 =?utf-8?B?QnJBbVI4cjdsYnB4NDdjc2xwdVFaeVlnNk1acUVEQnNnbUVtNGtTNG1QTG1v?=
 =?utf-8?B?eVNNS1B4bmFJeVhjUGpKSjh0ZWZuVzRrUmVFZmFVU2JEQ3FVMUowdHlOKzAv?=
 =?utf-8?B?QXNpeDZ1eHBkNnNtODhxQkFueUVzYTd6UWhEdW55OUhKRU4wbzRJM3Fkd1V2?=
 =?utf-8?B?T1JLc0lvd1JRVjA3WnNHemJOZ2FIN1Uvemo5bEpHSVJxUDdZQTM5dlhEQzFk?=
 =?utf-8?B?UU8vRGlSYlVIL1pHdWZSZk84Y2lzRi9CTmpjSjRNdTh0MyszczZWR0NBTURp?=
 =?utf-8?B?RW9TZTQwMTFCTDJtLzloOWNPWFA5bk95bVJTbjhHS2FqUTVkZFp0dDUyZDJs?=
 =?utf-8?B?STRLWjdLVzlZQkh4Q1Y3TElwc3U5a2c2Y283ZHdJZXFJTTFXemJ0S1RSZC9B?=
 =?utf-8?B?eGczbnVtOFpOVHo0eWVjUlBYNHB4MGptUnFwaVZnMFY0VkovcEMzdmxnb1Rv?=
 =?utf-8?B?M0FjZU1TbTg3SzhrY2lqTzRyQTE0NElIR3FNaXE0akpiRTFiN0JuWkt3OTN0?=
 =?utf-8?B?NFBqMlNOYWxNdlJSTGFOSys4ZmRZWFdLYW5qb1pwVjI5RU44ckJFN1g3ZXd2?=
 =?utf-8?B?ekl6YXdpbE1xZXQrdGNocG5PMVNJbENWSTA3Uk1DOWtxQnJEM056VVJFaGpy?=
 =?utf-8?B?U1RjeC9PeHU3N2NIa1IzN0tWYWhSQUdKQ2hSYjYwcmxNcXY3U0pRUlhoS3VR?=
 =?utf-8?B?Qzh3TnlzZXY5RW8xeDJOZ0RzZ3pISllVdUFJek4rZlBmMElrdmovWTRSa1lx?=
 =?utf-8?B?SEFlRHVmS1UrMEtjYVZPWlJzekQvaHRrdk5rN3llV3NsUnRQSWJQOE9JdmhD?=
 =?utf-8?B?MDJVOWR5NFlBcGhISTZzWjNRR2JReEZyZjZLOTlJT3U1WkRBRDIyWXFlZGlW?=
 =?utf-8?B?Yi8rdEN0NGJwZDdBSHQ4dmRuK3owdFJaRkpocHdwZWRhT0k1dDM5YkdDZlhw?=
 =?utf-8?B?dXBjNHB3a0pGZlFwenk2NjEyVXI4L0ZKcVRHM25HanlQbGNEaExkb2MxZDNr?=
 =?utf-8?B?bk4zU3l2OWlJOUFFQXJxdTJENU9GSWtjQS9GS3lDMWxWd29Ib1o1ZENyY2NM?=
 =?utf-8?B?YXZiSmRVN3NnOUYwSEFTdVlVcklBMEtTMml1TE8wVzZTTld4SlhVdjEzKzAw?=
 =?utf-8?B?MUlQOWFhWWprc1RYNHlwYUZ6TEpaa2hxcTJ0ZFVqVkhhYmxMMTd3cnhLL3o3?=
 =?utf-8?B?UllUSURnN2dtYUlsYkIxTUtob1N0eDhHZ3lzc2tlU2JDY2Z1NE01SU8vbi9I?=
 =?utf-8?B?MmFUdHl6bFBkQldNc3QvVmtQVWRuVGtJemNOM2NkUTMyNTZnYS93VnNzMnFJ?=
 =?utf-8?B?UkRNQ2JROGFabXIrTmI2YjhkaEJYVDFXaHJFUXdUMTNZQXN6dk5wUFc1NVpp?=
 =?utf-8?B?bzk4dnd3b0VGcFk4Vm04RGh6NGhBYTJVQ1pzY01jV0pKN2ZnbUFpY1Bra0J6?=
 =?utf-8?Q?Zlz6UPc5zyCMDBczP4uQOsU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA3930CBACC3D843856BC6F46D3A6102@namprd15.prod.outlook.com>
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db76771-7694-40d2-a1d7-08dcab9fa2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 05:15:29.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48AYBl5OLAOkgiGRcnhbnfKzXcTt9LAN3p2vC+57++vwigZ8oht6K9c5lJkAEeREvK9vHGbNeALzwFqOFg50/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5718
X-Proofpoint-ORIG-GUID: 7XxasPeM2-zVNnELvuAOoL8l5OHL0i3Q
X-Proofpoint-GUID: 7XxasPeM2-zVNnELvuAOoL8l5OHL0i3Q
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_02,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=692 mlxscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240034

SGkgVGVhbSwNCiANCkkgaGF2ZSByYWlzZWQgaHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQvcHVs
bC8xNzQ0Lg0KVGhlIHdpbiB0ZXN0KDUpIHRlc3QgY2FzZSBmYWlsZWQgc3RhdGluZyB0aGUgcmVh
c29uIGFzICJUaGUgT3BlcmF0aW9uIGNhbmNlbGxlZCIuIEkgc2F3IHRoYXQgaXQgZmFpbGVkIGFm
dGVyIDUgaG91cnMgNTkgbWludXRlcyBvZiBydW5uaW5nIHRoZSB0ZXN0IGNhc2VzKGJ1aWxkKS4g
SG93IGRvIEkgaGFuZGxlIHRoaXM/DQogDQpQbGVhc2Ugc3VnZ2VzdC4NCiANCkJlc3QgcmVnYXJk
cw0KSGFyaXRoYQ0KDQo=
