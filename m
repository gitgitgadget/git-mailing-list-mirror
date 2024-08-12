Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2061.outbound.protection.outlook.com [40.92.98.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4517276D
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460254; cv=fail; b=fNXfC/rWQ/ljDwDeePFYiRrjHWOJ+42wEPPoe/HnuhkH7toJCDWDeIKx+EdPIhJ9I5GjaVdh1i7XfSnP4rRf9tNTCmSREkzjL6uONyh2q0lZmug96L5JTdc5KvgAHEPHaLeekuG8snVKaxwVa6daBt6EVnLHO+o903N2uWG7urA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460254; c=relaxed/simple;
	bh=TZVRHY28TQ2mC51n077G9Ne9082vXvpP7xpFrHY0Oa0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mAV9YnhAyMOeUreIAjiEOn2hpAaeRvGHal3qMTFFSDYOR4Ma6byVS+dQzp2lsKt9no2N6+RBvIdu1xzNw59FUW+m/HHQaPTrSXXSe5eR/VtPsHVpTcS0cjgXSh57GzXWkrhYEcBfSVlb3lYC09HDz3LZSAH7Nd21R7LSfd1s6Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p6XGdWwt; arc=fail smtp.client-ip=40.92.98.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p6XGdWwt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU7PbVHK3kYZozN8t0z4NZxPOMoG0hkLEfY6nAu9degjzEbxcL6kyXKRpzl0J2kw4C3+ry1PvVxmXiROjolfc+fwgKnUrID4Nj0jXNyBeDYQi8rYhhOTLCmtuhkgN0JPW/OTm6nWEpBsJGD6lEK+v1YaNDw6xsVQBKG1hCJxcfcpYyxrENgnrduKJCHUiqMZI5bFjbKIf2A5APcbXJIM1Cq4hV+zKhJEvTe+FWzL4IkQtSFQSeepc26t7FJLsGPc3PmDJ3gZBxClQcz8My1hLe/yAE2e3JyRLpToDyRKDPv0mOYrstmRdeCkc1kzCLYrWm62lJ2Zsd/mbr8Ds/l8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4lt35sFX0hY2hSVLUjO1IWPaQRCbuJlZeG0vkf8yyY=;
 b=honm/+//Mc85x1DLPJXXRj+f/Y/yZELLpB6D9a42la4NK0rUls9Gf+fSz2icEnYguvu78mqp+hz9kaGVMFQfM0FPzGNHRQy/3nBKw2wxHkJEQF+QvLvhn6KgK1WjkHaSlXzibB1VG2i7BMHKq/BOEgPCSegp/K5Py3NZDm6hZrKS220wCNpnTH/ogeRH+LnRDBDWhU5ehseCXBv5Fbv19AF+mhgnZGI7tcLxLXSAxQaU3dk7mwmyPaOKHjXMMxKM/+qhlf9T2WqMIghRBLQqPZEqDBTkMWdNHlGKUICYrehjBtSO84e6Vhi0HO6WZ13l6Q+ZZgPdmPox8cVAcZQrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4lt35sFX0hY2hSVLUjO1IWPaQRCbuJlZeG0vkf8yyY=;
 b=p6XGdWwtEnIzZw6qEfNau6q05XYZJfhN7p+C1bPmrehKk5LJZkH6ns/axJxOShumHJ2iIgJIleCUAiAUoPJxQ5Y38UEAic41GnQvrntxXhaRZ+ld/NRJJwdtZvh12U6Uf9HTR6dd83JcOKUG3nye1IOSKIeEctHnpA3pFx75smZxQJiJbdfwVaALEsfG6Ruvx2PRjjBTnSBCT25cj+fdyDKprYJUXLLz2sSseAJfFjDbePDlbVl2FAtSXgrdhikIt2G4Z1zUbwgiIQlp436nmc58CkA6SSqE6GxEstArWTEF8ue+50oqwicRT61yXOFpt6jVf5Bz25Jr6YYnOvYVeQ==
Received: from TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:442::7)
 by OS9P301MB1093.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 10:57:29 +0000
Received: from TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM
 ([fe80::4bf8:305e:e771:ef14]) by TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM
 ([fe80::4bf8:305e:e771:ef14%5]) with mapi id 15.20.7849.014; Mon, 12 Aug 2024
 10:57:29 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: git@vger.kernel.org
Subject:
 SIGSEGV Error Occurs When Attempting to Unbundle Without Initializing Git
 Repository.
Date: Mon, 12 Aug 2024 18:57:25 +0800
Message-ID:
 <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; boundary="nextPart12519906.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-TMN: [tAMREdn1+GaSeLKx/G9NJg31Bp9lYuygBO/CFoWYZk4=]
X-ClientProxiedBy: PS2PR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:300:5b::17) To TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:442::7)
X-Microsoft-Original-Message-ID: <2771064.mvXUDI8C0e@qlaptoparch>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP301MB0563:EE_|OS9P301MB1093:EE_
X-MS-Office365-Filtering-Correlation-Id: abc41dea-98d6-4155-8915-08dcbabd8f08
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799003|19110799003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	VLcuhQQJbOgP8Z6WXb+xOuzSpJmC4QQ+bvp6QyaEz+loICU4/EMWTsbLrnJt+su6xc/9pTSDweD5XrukCZEyT7zFl7nLxOEzU+M9vYDv2Ea6G7DKcr/GZplweArTCjjez6WQIru+XIMsnOsnHzLTdQXYZVRVlpCKuoS1D7nJBBJn8qhPWuNqS0Y/tuURrf/bTRJn5avkq18xOTwO9UH0ERLkh3ZLHhAzvCeVy7b5bFpr7zKSAxlhbhGxqzgSpSm7Y8uyod53KV37rcYH7bFpUps95uyjE2+sW+iScnvVhE/LmLvkGpsJ5+jD5l7yHKOpyYdFSErCjhrPFQyx4NL0cij/og6OsXhRuQXL0vmKiFyGjHvW//7B7/ltRrixJ8TUS1RLbG9sBiW9KX50rIu4ptNMej8/rnmeEP7CRxYi+8PRDVAF8rOtO1ljejaofYFzs5zNUJapBZ2iNZS4TMscbi/I2aIDrvgWftcvgTaYKNUehkpXPwvK2cO0EQ6CYvTpzec8DUN3bj71g/ZIqyKHjmwdhSse4GCNhO/OWTh6LumTZJdJgwp3zjDy/OXDz0kA+Oc+5h1V6Riw/jpOGWQJVnJbpO8Ra/tW9PEX57XtZRtCiMV5ygABGSu59fKe2Ec+7lU/nB3qaysXu/zyYVCnox4ryrBSOkEsQ5LRC6UIOxkWbRcnd5FM2PVV+5EsrR6UvBU/eiHd7tIxzGI9JzjRmw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmQzNjc3OFdzaGNLMWJHQWxWUU5xL25laGlFSFRHRlNmYyt1aEhVNTNuRUhB?=
 =?utf-8?B?ZXV5eUFTTVAzZDRiUXJ1QmsvNkZ4ejRESHU5WjE0Y1lNaTJ3cElpNm5Pbngr?=
 =?utf-8?B?VzNVVGxQejBTWFE1Rjh2S3M1eEVVYnJ4blg0TUdxU1g1ZGQvcC9LTjZ5WmxM?=
 =?utf-8?B?VDRWb0pGZEtxb1dQYkNVVFQ4WWVneXhTRU9PY093b1AwbXVPQVRPZ2QrZGRp?=
 =?utf-8?B?UitteTJScFJQaFdtM0d5RnYxMG56a29OcnJQaTlBaDVkSlF5UEtpTWlxTmdK?=
 =?utf-8?B?NlNsWFNQS3RSNEtlWGpEd0YralIwREVMQXQxZjlmb3lLQmxwVzE0MTlkME1t?=
 =?utf-8?B?em9PYmk0ZGJ3Z3NYRHczTkx1M1JCOGN6QStnY3pnb25yaDA5OTl5czNyV094?=
 =?utf-8?B?dUxpcWhMUWh3cGpNUEtvc2RQV0Qzb2ExVzhCUnJBVW1LRnlzSzVGR0RvYVN2?=
 =?utf-8?B?VXA4ZW9CeUdHR1VkclhVZkRQWnVBSUxORWpDdkFDZmdZY3NNb05WaWJxelF2?=
 =?utf-8?B?ZkxIQzNzZTFXSEFrUi9jRFQ1L0NqUE5hSkdZd3dOK3RpcGZpQTN1eUU5Z2RI?=
 =?utf-8?B?TXVCRU80bjJ5ZlFNdXZaZ2ZGNVFGblNZaTUzcmhEdzZQY2QwVjNDRld0RGhn?=
 =?utf-8?B?S2YxTmlaRWF1ZzdGQXRROXcxOWRVSXpVb2pya0VxeEJBaXZjN0lxcEYyS0M3?=
 =?utf-8?B?ZktwbkZYd3hDMVFvNElYeFI2R0NBYTljZnMvN1piWkpLbk9rNmF6V2NWK2Q0?=
 =?utf-8?B?ek9EOHpETlBHRU9XbzlVRnBmRFA4am9mSmhrYWdqL3p6TUREVVJoT09WZWU0?=
 =?utf-8?B?aWc5SkxGUGRZUXhVRCtHTEVVUjhQWWFINXdNK2NNcmhXdlRuWDkrbjV0c2N1?=
 =?utf-8?B?Y0Jac1RiWkg2dHZFQlFKcTUxc0NGdXlaZDF0TXhhS2dDQms4OVVCbFRnQll2?=
 =?utf-8?B?ZFY5QmhCa3J3c2xVenJTZkNzcmFyV0pCZkp2Q3Z1N0tpNlRoYWp5eWhBZmZB?=
 =?utf-8?B?Q0dIMWdpMHVEUGpCT0Nneng1dUZvVGJSbitWWS9pUTN6THZndUJTbTJrOTNK?=
 =?utf-8?B?c3g0c3NMWEV6enB5bDRST2tWQzNJRXJSWEd6MllxZ3cyYWJtYWtKbFpGT1U1?=
 =?utf-8?B?U21tV3ZLQU8xamt1V1FMYjdLdzIxTFdHdTlQeHJGYmpoMnFwbVU0a3hzOWRV?=
 =?utf-8?B?cnhLdVBXR0hlM3l4Z2J1RHZncmpJMTNVd0RlN3lHa0kvNGRXVFYwdE5SK2I0?=
 =?utf-8?B?YitYZFcvVlZ6NDVWVkYyNmlkaDZLVFUxY2hYYTFRSU4zSkpnS29rc0VUTnZS?=
 =?utf-8?B?RjlzNVBvRVowL3BneXY3R1JiVXdhRlBYVzNrMWZ1SmJ3emp5QWVHUGdzaHNW?=
 =?utf-8?B?MlllZ0pNWUVsWERBMW8vdWFENHRBM2hUUXlqa2d4MTByOUpjbVdqdzhIdFJF?=
 =?utf-8?B?VHNkaENIVERsZ3pDblpUeWZBZkZNV1Z2cUtwUFBFdFlJVTZYZFBkcWRRRW1R?=
 =?utf-8?B?TUxwd1U4dHoxNGxWZmY1VjZSbUpadEE0a1lIOUdlR2x6d2JVRVlRRjI0ZTJu?=
 =?utf-8?B?SDlYbFdDMDU2RUg3ajFvTk1hbktnb3RQNzhlazB6Y1dxR0xXb3U5ZFRURkY4?=
 =?utf-8?B?ckhZa3NFUXV1djNlRFlZek9ZOVhCbTRxUzZ3Q2tPOWRPNlpobEhiSG9zQW9l?=
 =?utf-8?Q?RpUo7rtQOSZ00Sp1q8IU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc41dea-98d6-4155-8915-08dcbabd8f08
X-MS-Exchange-CrossTenant-AuthSource: TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:57:29.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P301MB1093

--nextPart12519906.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: git@vger.kernel.org
Date: Mon, 12 Aug 2024 18:57:25 +0800
Message-ID: <2771064.mvXUDI8C0e@qlaptoparch>
MIME-Version: 1.0

#### Steps to Reproduce
I attempted to unbundle a pack but forgot to execute `git init` beforehand.

#### Expected Behavior
An error message should have been displayed, reminding me to run `git init`.

#### Actual Behavior
The process unexpectedly terminated with a SIGSEGV (Address boundary error).

#### Difference Between Expected and Actual Behavior
Instead of gracefully exiting, the process terminated abruptly.

#### System Info
- Git Version: 2.46.0
- CPU: x86_64
- No commit associated with this build
- Size of `long`: 8 bytes
- Size of `size_t`: 8 bytes
- Shell Path: /bin/sh
- libcurl Version: 8.9.0
- OpenSSL Version: 3.3.1 (4 Jun 2024)
- zlib Version: 1.3.1
- uname: Linux 6.10.3-arch1-2 #1 SMP PREEMPT_DYNAMIC Tue, 06 Aug 2024 07:21:19 
+0000 x86_64
- Compiler Info: GNU Compiler Collection (GCC) 14.1
- libc Version: glibc 2.40
- Interactive Shell: /usr/bin/fish

--nextPart12519906.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR9qIFcEPzauMbRHEvccqJRnnfWzwUCZrnqlQAKCRDccqJRnnfW
z7I3AQCNHwzk4DdBrUXh87z/hFIdLnIKRxZSeidTLTPGCIUAUwD/Xe5FGc5PqRkr
IqpQ8HW3GWrqSYNWEccoaJq0NQT0lw8=
=tgD6
-----END PGP SIGNATURE-----

--nextPart12519906.O9o76ZdvQC--
