Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11010002.outbound.protection.outlook.com [52.101.169.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58EF2DE1E3
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053560; cv=fail; b=V9OiiXk9tGAohwYcmvG4wq3PCy+WOdwiWjjUXGUGY/AIFpNQ/irNgdzGd/qtodXgQMxzHCegv+zNCInDljwnbho9AvGJLUvSrv65N3LO+6h2VpaN+dkWBhj9L/np92s4xgaIxxUxZNsl9G1lmQx4iDuiO2Xy2cEILcVA9/XsvTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053560; c=relaxed/simple;
	bh=yhnoweluQphtuQg0A87Q+YXLUVl7S5uQmyD/XoRd2Gk=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=U1Jh/mEs/ZGhvm1bCy3YHkQDmojTDLstw3sF06ahGHQ3RwVnu3gXPoxEjA3ThhRvKzRlmPww8WAf+Hu+0sfD/JF7CB6np+OdAoYraZ3PfcJyUzPR9Gy4m7rrukSK0Xa48L2aFbhaPgWzl95/g2k/NzFpJBUCckJ0tL0zk6iPpyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=innomotics.com; dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b=C5Jsm199; arc=fail smtp.client-ip=52.101.169.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b="C5Jsm199"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX8xr0fgexLNYgCv7LpusAxy0rYY+mu1xlSDIkCSTdL4Q4cSIQaRyk/A+mw9UnnJTFZb6IgTUlPHE8NcKafwz400qUUJEQxHC3yKpxmzhrS1hySJrzky9VRn+JZ5oUwCqZdhIJkkK4aOmbGqWED5K/c1IwHIDQ6JUmsy+wJaYSqTKOAtgxKoCdKAen7pjLiNOGx4J/ugUpP4SCDCpFGq9UirIXSnui5JVWZZ+cGMa7oCt6t8PkOLm1TqDpekTwV9hGbl1P2S1M/k69LI10v08LyqpNOIVgtMqlvovGZPXbcW3oR877ZZzql6+590hOZaKWEqYpsPtDHCuqTmOc0E2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKeKX7dcnqy3XZPVMXqUfCg+6JDCyuR3NNT00mLxH84=;
 b=IztgCdbKDJDhpt81GztSXRk1Y8sVkGchbMqvOu+LiRmhhipFEzYhy2iKQ/y0xI/kiTu7yAOrVgnzFDIECqy+c3SRAC8lNVGgWWIF1Sab2nq5u0p3/1fdjZxfONyjpTAB4Lcp7fkk1avAUkm9a9ccid+qXcqk4NAn0GNVvfB9esDYnUIeDEUGvun9ZWhDEBRZ6qXrGn1uvL3VzOLE8X9LthNpcXdWRR8LTpC1q5nESl1fN0SJpGKforwX4Vkvd4xM/UCWl/HhdjaynIb+RO3zIWpa/aeRPhW0MdGavi7mYIlH/iNrLc8HFQ4TynskNVYVuzqRypBTI+ktPqCNaXcy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innomotics.com; dmarc=pass action=none
 header.from=innomotics.com; dkim=pass header.d=innomotics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innomotics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKeKX7dcnqy3XZPVMXqUfCg+6JDCyuR3NNT00mLxH84=;
 b=C5Jsm199IgeiHyc2Sv0utN4Ac1rXktfh142u3tEBx9mTSd/Jag8+jIvd6M7tElcwpSrIQ1mIZVONgyQbmd/sZX8PLSKKwwvS8eOdejva0NuctRFWaTwODYACpPxxNxWFQFMHYZEnF1fhxl/vIw4HxwmmIhDo4l8RWrxJ3b7bv5jHw53qHQ0disAjMBF0PHqxmLYgPnOE+COcAKPMVl3rmEn2xTQlT647KQ+vhHLJDfsWoTOq7KQb3Oad2h4raYqTFa+66TMUrKTW6DyToxdqCDkvU36EL6McIXBBPzuRksMiFSf7ed7mED4MIZzlMKgF14BLY56y9zqZLqnwc6ds6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=innomotics.com;
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::1af)
 by FR2P281MB2686.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 20:12:33 +0000
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::402e:ac99:8b73:e8b5]) by FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::402e:ac99:8b73:e8b5%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 20:12:33 +0000
Message-ID: <93cee8d0-0c1d-4329-ae93-7f900601995e@innomotics.com>
Date: Tue, 16 Sep 2025 22:12:33 +0200
User-Agent: Thunderbird Daily
Content-Language: en-US
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: [Bug] Unrealiable threading support detection (on HP-UX)
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::10) To FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::1af)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFFBD1D31FB:EE_|FR2P281MB2686:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ae385c-37e1-4090-27aa-08ddf55d5f22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTNMeWtoeW1LTE96TXQvc3p6ZDJ3YVB2QzkxeTlxVTZCbStZQUNYN1Qydm0w?=
 =?utf-8?B?RWN4cTJZU3BUVSs5dTNmZTBSMkdZRWI4b242cmVZN0FSZ1RQcWIya0dEd3hB?=
 =?utf-8?B?eDk0THNmdE9oVXhZZ0YxTVd3bXhsMDFaejFjZGhvWVh5dEV5alNITHFSOGFS?=
 =?utf-8?B?YWFHMlg2MUdQRXhDUERyczQ0TmpkaTUzNGJBZ2NWcDRTcUZGZXBTV0dMNkVx?=
 =?utf-8?B?SjZKVzlpa3I0bmlHRVBpckMvRU8vc1lNOW10Z0Frbk9XUUExMi9KYzlnWTZY?=
 =?utf-8?B?RGg3bDdpRG5UZ2YvMkNCOUlUdWpMRzQrcXYrZ2ppOFk4cjRrMkQram52OXRp?=
 =?utf-8?B?eXFpSDk1ZXBBaXVtZzJyWURVYnlMNVRoYzg5aGVrU1lJQytwT2pOeWp1R21X?=
 =?utf-8?B?bm1mV0dMdmdLeVQxbmZieXNScnplNXpjOHZ5akR0d3d5NE1qTjluZDlPQ25W?=
 =?utf-8?B?bVVKeUt4bnNHUVdQck92blVzV2tSMUJSSzB0SHFmNTdOdS9GSUhXeVQyN2tG?=
 =?utf-8?B?VnBUOEM3clFJdDdHM2VCNWZHS1pkam9wRDhqazlPZHcvN3ZXT3JlUUZ1eE9R?=
 =?utf-8?B?MHU1OFZGZ1Nta0lKdS9zYjVUR3hobkNCUzB5cVpxLzhkdGhRbHpGUXhGbkQv?=
 =?utf-8?B?eTVNTnlhMlVZOG5hWWg0MzYwRWNJYVdYT2JRWWk2cVhCaFF3YUlrRnN4Qkls?=
 =?utf-8?B?N2crc2U3cGppODhRUnRpYVFNS0l3ZkNXZmNEUXVKRmFtREozUk9nMjhpTEpa?=
 =?utf-8?B?RjBna0VWOExMZXZ3NzVTUHpmUFZYM2JlNktPY0xKc3M1SWI4UmF1WW0wUC9h?=
 =?utf-8?B?ZkhTNXVaMm5JMjRqbWIzVWRGTmhyeHdxN0Y0WXlETVMvdkJsaGdTcWJNQXNH?=
 =?utf-8?B?TVRYRCtuRUp4N3h1ODZBRGZwZmlZcjgrZVI2WmJRTDVQbU9vVUhXamNZQWFJ?=
 =?utf-8?B?WjJHNkU1ZFgvQUFvWlJxbDlRdHFqRTkvK1QrRHg0TUc3L1Vnb0tJSXBGSXRh?=
 =?utf-8?B?WFdZdnRuOHNJWUJrNFVoVHhVdGk2b0ovc081RlAwcSttSlRza1pJT1kvUDdE?=
 =?utf-8?B?UEk5Ly9JNWllVmIyWlVzYStoa09nOWdiUHJZZVZqL082bk1IL3pEcHZmSHR2?=
 =?utf-8?B?Q1JrRTVNYXpVNHl1VUw3QmVObnRnQUx4L1dJbHJBSFhmRVlwVjU2S3owVG1z?=
 =?utf-8?B?cS9FUENwODFaNFB2Ni96Njh2REpWZmVJSjhVUzAzYit4bzA2Y1ZhbTN6a2Nm?=
 =?utf-8?B?UjRWMXV0UnU2TDZIdEhtWW5kc1cySk15MHQxMndsWE9HZlE3elRiME5XaU1v?=
 =?utf-8?B?Y0c5Nno1YzJXWU1CK1lvSFlyVWVnVGNsUjVLanFwdmg4aUoxRGdsVUFVK3FV?=
 =?utf-8?B?TlJocmFzbkpMZEFtVytrQjBJMUFqblBTT3ZROTZDL0dCQWNGMnlGS0NxYUc1?=
 =?utf-8?B?NWdPTkRVZ3ZVcUxmbTBnYWM4b0N6VHR0MnVjMzF1T3JvcDhlWHYzT2RsbnNW?=
 =?utf-8?B?Ymlnc0s1WHVEbTY0YnJrZTNKQ3hxdHVOYThwSEloQjF6aFBMbFNFRHdUeHhW?=
 =?utf-8?B?dGxXNjFzNHJ5ZmN2cFJEVDBDbzloQUZmMzQxUGdqTW45VGZ6VHZ3THZkZW5m?=
 =?utf-8?B?cXg2M2Y3QWh4OUFLcnR0Zy9UaXFqQm94NE9lVkxMczZ1SFhubWYwci9TOVdI?=
 =?utf-8?B?L0N4OVUrOG94UHJQSWZCTStMem5ONU9odEhEcS84UDhBU3NBanJ6dk5DUEdG?=
 =?utf-8?B?eVJWK3QvQWROdEQ3cGZ1bEtOTHNQVjQ2ZU9oRERrWGp1VFlHT2VEdzRNc0NO?=
 =?utf-8?B?dFJQcmNwT2dzZUVmcGhQNFZjOGZMcXd6SzBvVTB5c1lBNmhrS0dCVXZ3RFJE?=
 =?utf-8?B?VFhxQ0FRTTAvSnVtZ3gveUJVZXJ5RmUzc0Vpd21mTmcvNUwrSk9pK3g2ZmRh?=
 =?utf-8?Q?5da0h5tfO8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUNaR0JvcE5PUThjVkZiQ25sZXY0U3ZOcE11MGxJS0tCR2pNMDErQUc0UUto?=
 =?utf-8?B?S21rOWtlZ25mdE9ZemxZcnUzR0RHeE1JL0M5Y2M2TWJ2OEx0USs4b1VzMHlR?=
 =?utf-8?B?RzNzSXJYY3RkamhVQkhuUmJTN2dJV0JpZjBncDdma0JFV1RCeVMzQm5EcGl0?=
 =?utf-8?B?blp5ZFJwd2FBb0tta05RUDZyZE1NMkQwdGE2VjF4b09iMzU4dkhJUEdLRU5G?=
 =?utf-8?B?U1BaMTRtVU1Hb2lRbWErSS9wZitwR1U2SGNQTkptQllJM0tQMjBvc013ZlRu?=
 =?utf-8?B?enJ2WVd2ZmNkcktjblJrSzFWNHNycWRHSkVqNFpXUnl2SWlyTUVqWlZQSWlX?=
 =?utf-8?B?MUV1MHJsSWRKTHRlM2FjQ2NWd2x6Wk8vYVpMUjFjUnZJS0czRE1CMU5sUU8y?=
 =?utf-8?B?R1dKam1DNUw4bUNsbEJBbGpvemtLZG8rbEtvTzJGamQySU9KVzcwU0FKR2Vl?=
 =?utf-8?B?Kys5YUF3QnNTcm44V216UllLa25vbnhOa0h2bEs1cWJ3SWZYYm9GRmJzY0l1?=
 =?utf-8?B?b2pDdUQ1Yk0vMUJLaEZRbytjT1hHU29ycDZocGRLS2ZoVzRWT1A4dnlxZmE4?=
 =?utf-8?B?V2pEVzNacWFYNnRMY2hWSFN0M1FSODNOWlRNZGtYandrNWgwTkR2TDBuTVZn?=
 =?utf-8?B?aDN2TnlmQ2xqZHpFV2RuZFhUektQOXpCOE9tOE1NSU1yU2NlRUFuTnNoMW9D?=
 =?utf-8?B?TTZLc05JWG9VMHRQUWxtbWhpcEdhM05qaHRVVkYvMDVrQStxc0dSRWtIOThQ?=
 =?utf-8?B?VzREbm5NRlpCTEsrNWVtcXFGWFdEdzNOL05nUG5sajNsdzBWVjRhc2dRZStm?=
 =?utf-8?B?K1FmNHJ0VHJRM0JjZVJSbE9jUXh4QVhhNXQ3K1o2T1JybjdXYjhLQ2ozWW8r?=
 =?utf-8?B?bEcwVlpQNlhhUiszUngrVXJkREMzTHlHdXZ2eXpCa00wV09iRHFtTVFSRGcy?=
 =?utf-8?B?M3pGakVtcmNVdEpKQWplbGtmY0JpVjBEb0JTZmljRWRGbzN2ZExWQzZIeHRI?=
 =?utf-8?B?WUVkdWY0enl6SzFyNFoySmdSTE1QUnNzZnQ0eGgyaGM5eDJmYlEvdjJTaFIr?=
 =?utf-8?B?QmpSZnptVkJZenBGdldIMU1xKysxb21vNUhzMUxyM0s3UXEwajFFdGl0b1Vv?=
 =?utf-8?B?SFFIcjNlY3A0b2NYYUU0WGN6OUlTQUdUU1QyQWhWNTJCUTR6eStsZFgwMzdB?=
 =?utf-8?B?YUhLQy9TMStwT1RBOExzeXhxN3NKVEt5Wm1qSlFXS3hRQXV3djZxcEhFbGI1?=
 =?utf-8?B?amVrMkIxelJrci85WStud2FjZnlicHRTZ2VhS096NTlsTnRXaFVmdTUwc1dO?=
 =?utf-8?B?ZWswMGtDM05OSTZ4OGhHZUttOFFMcDJUTEUvdFRkM05uQWpTZVR0WXppUTcy?=
 =?utf-8?B?TWJRZ05McDRzd1JlMmt4RGUwcVlOVUo3L24vK29VT2RMdklZYnNxcWFvcU56?=
 =?utf-8?B?R1VEVjU1RVIrQ2NvYlI1Zk01U2JxZ29wdEcrTk1kUnB0L0VmZ21ZM1hJd3BF?=
 =?utf-8?B?NEg2QWtIckhjQ293dklaaU4zWjRkR0IxeUgyYThUM2VhRWR4c1pNbzg3bURt?=
 =?utf-8?B?cUFvWU5tOVJkdDh0alA2NDhOTVdNQ0FCWjhtWGhZTXNCdHEzbkxTYUxEckh2?=
 =?utf-8?B?TGlFTlRaY0lPdVgyMjMwRzBzY0VtOHh5aWpjNVZnUklRamV5SW8xK1lqbEdD?=
 =?utf-8?B?ZVI2Szl4TjJIQWFPcEEyTm85b0U2eXNHZ3FwNVJqd0dqa21vOVdNV3A3RWg0?=
 =?utf-8?B?ZG5yRUFEcDJpUG9CUDdiNi9uNmtNU2FqbE9JcmFKdHYxaXA1UDBCbTc0S3dH?=
 =?utf-8?B?S0NwUUY4MndSTGwrbkdCTEFiNXluSDY2eEZHOEt1eXRXQXpMRmo1dm1idHc0?=
 =?utf-8?B?cTROcmhrTE1JaHN1ZDRIOTB4dmxaalVFdXhJSWxtc0RBMDB6NG16M3piNUw4?=
 =?utf-8?B?MThZV2pvSDE1djBHVFhCTDZpWGJBQjlIV0Y2SEIyYlJDNTNnMjRJckYwaDhS?=
 =?utf-8?B?cHNMKzd5ZFhITjVaaDFmNi80eW83Q2MrRUMxSlpOZE05S2NhUjM0bXlGdnhk?=
 =?utf-8?B?UjhWMW9rZmZzWWR2MDU5L3VoK3VEbDNDL1NWL2RBaDB1cjZnKzUzZlhRNmFv?=
 =?utf-8?B?UThOZkFRT2NQaDArcHI4eldWcTJUbUpLY1V1Uml3b0NjOW1rdnRLSVZYb0lP?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: innomotics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ae385c-37e1-4090-27aa-08ddf55d5f22
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 20:12:33.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 698c6ffb-74e3-4a84-be68-f22d8d3201a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shXDsrWPCqssFDmsItyv/Wt3rnVjbRO/7EShrJrRijpxJiEJcFWQQiQtMfJ/LMmx7imb29sCe53qs2LMN0gJHWKsYhz0iri7MtQAlDeUI8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2686

Hi folks,

I have stumbled upon an issue on HP-UX where the detection of threading 
(pthreads) is incorrect or unreliable. There are actually two issues: 
incorrect display and incorrect detection.

Consider:
> root@deblndw001x:/var/tmp/ports/work/git-2.51.0
> # CPPFLAGS="$CPPFLAGS -D_XOPEN_SOURCE=600" $CONFIGURE --with-editor=vim --with-zlib=$PREFIX   --with-perl=/usr/bin/perl --with-iconv=$PREFIX --with-libpcre2=$PREFIX   --with-gitconfig=$SYSCONFDIR/gitconfig --with-gitattributes=$SYSCONFDIR/gitattributes --without-tcltk --with-lib=lib/hpux32
> configure: Setting lib to 'lib/hpux32'
> configure: Will try -pthread then -lpthread to enable POSIX Threads.
> ...
> checking for POSIX Threads with ''... yes
> configure: creating ./config.status
> config.status: creating config.mak.autogen
> config.status: executing config.mak.autogen commands

Looking at configure.ac the message "Will try..." is not correct because 
much more is tried:
> for opt in -mt -pthread -lpthread; do

So either the message needs to be extended *or* the values removed from 
the message to avoid updating both.

The output tells us that pthread support is in libc since no library is 
required. Let's try:
> # git clone https://github.com/freebsd/freebsd-src.git
> Cloning into 'freebsd-src'...
> error: cannot create async thread: Function is not available
> fatal: fetch-pack: unable to fork off sideband demultiplexer

Doesn't work. HP-UX requires either -lphtread or better -mt.

> # diff configure.ac.orig configure.ac
> --- configure.ac.orig   2025-09-16 18:05:44 +0200
> +++ configure.ac        2025-09-16 18:05:55 +0200
> @@ -1272,7 +1272,7 @@
>    # trigger a warning about an unused flag). Hence if we checked for
>    # "-mt" before "" we would end up picking it. But unfortunately this
>    # would then trigger compiler warnings on every single file we compile.
> -  for opt in "" -mt -pthread -lpthread; do
> +  for opt in -mt -pthread -lpthread; do
>       old_CFLAGS="$CFLAGS"
>       old_LIBS="$LIBS"
>       case "$opt" in

does the trick. But why did it apparently work during configuration?.. 
and here is now the bug:
> configure:8609: checking for POSIX Threads with ''
> configure:8639: /opt/aCC/bin/aCC -AC99 -AC99 -o conftest  +We901 -I/opt/ports/include -D_XOPEN_SOURCE=600 -L/opt/ports/lib/hpux32 conftest.c  -lintl >&5
> "conftest.c", line 45: warning #2111-D: statement is unreachable
>     return 0;
>     ^
> 
> configure:8639: $? = 0
> configure:8641: result: yes

$LIBS is passed and libs contain -lintl. GNU gettext nowaways (since 
0.23) links by default against libpthread, so it is a transitive 
dependency and goes unnoticed. The manpage for pthread says the following:
>       A multithreaded application must define the appropriate POSIX revision
>       level (199506) at compile time and link against the pthread library
>       with -lpthread.  For example:
> 
>            cc -D_POSIX_C_SOURCE=199506L -o myapp myapp.c -lpthread
> 
>       All program sources must also include the header file <pthread.h>.
> 
>       Note: If -lc is explicitly specified in the link line, then it must be
>       after the -lpthread.  Refer to pthread_stubs(5) for more details.

So, git and everything in libexec *must* be linked with -mt otherwise it 
will fail at runtime.

To sum up, we have two bugs:
* Incorrect display of the values to tried (./configure --help is 
incorrect as well)
* Incorrect detection during configuration

As a workaround I can pass "--enable-pthreads=-mt", but I'd rather 
either have no threading or correct threading by default, but not 
something broken at runtime.

Let me know what you think!

Michael

PS: FWIW, I have reported a similar issue for MIT Kerberos with GNU 
gettext and Cyrus SASL today: 
https://mailman.mit.edu/pipermail/kerberos/2025-September/023286.html
