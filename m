Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397873B841D
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607611; cv=fail; b=aoaixiqBg1s4LV7FHcjbpOPCJ23eYMuG+sCaUmEhq3OtXUYF+FKXNTy4379YSFnQdgclkXr+pSEV++ABcdSJiowdwIM1xeaccpBDmuzwuF0t734DuDsB0FdNua29XMo7rLwRVgNhky0gIxrKE+dLq1SAOz5dRQ4Zl0eYTigJXgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607611; c=relaxed/simple;
	bh=usdd8Bont2WzZKnOlUvHi83lyY0LhDxJKBfvOUwEZX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pl71tSaie5liGS5/VuHdmRNMNRTi1vMo9UWG/2kZFHiJqYRzy1VFYkDSV/NQHITgUbUo5G42naW8CiRpssHtd7EasITZWVinWnTIDnXD78lheSJ+oYCOVGgfH5t/JkwyYr4isw7j1q+OLTbEMaYlXmqiy29s7S7R2GWI8P7htGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EYNeWrIN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VJKJECnZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EYNeWrIN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VJKJECnZ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G4Lnm22982423;
	Tue, 16 Jun 2026 10:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yXeT51FBpQT5TN+NSZ
	DGJ9rbHlR+mfQ7HRtgNUH5jMA=; b=EYNeWrINs971hxuA0CA5ppYLSCn6gvXa5s
	xHCQPslT09dwFy4IfCWVf+gXTJTVC8+OBJbTAhT38Bc4aqsHz2Aen7vZ2UpwDvUp
	VnWUMYpfZQy/K7L81Sqw4yBSof+FrvqQqhCCznu1gY4fgJ30zOdpsvICTg98Xul6
	QGyuSQZv9/1boaHKcTG+OXJmlsVkfg4yWmqUnKkIF04xPwAIX0z/9k9jaYUYKYqW
	QvIOPM5DNg2CnomUz5IFt7iRtRFYLaGPvhNJTV5rhHvo87ye/MYqjfmj5D5iLO9L
	tWbhLqO2Rjhe3Zl7Mdm63JZxV9WoQxguHykVia9kr2lHWrCY/JLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es1h6m4ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 10:59:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65GAw8gZ026505;
	Tue, 16 Jun 2026 10:59:48 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4erwncj2yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 10:59:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs0rJrLbNSdSe/hmcuNZeUm7ZHPRl0PC6VYA5bg/D76Eprtj5y2VDnkDnWskoWwbcPlC2Q7yYCPkxwkErixE8HzaqA4vdOl2dcyQQhirqiw2388fLU5YCheAH+AoUwTVMQ2yYmtMcWPoehEWrGXfNpI/C58OCgi5hxyx51l0dAI0q6+pJT7W6MsZPoI2Qu0bbPvfjJdNbD7KyTWwqpfTYB3qAzoemPty8mhFXtS+Um0qBnjouDPoZEPbloshc6BZ84wbQKPbtCIoqrYnoXaYVV0Jv2OYx94tALoh7VVSVoR3dGzHipojNw7OuCsT6guAEAqoIGXJ3KNb7G8KMAFtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXeT51FBpQT5TN+NSZDGJ9rbHlR+mfQ7HRtgNUH5jMA=;
 b=GL6+lRPBFJjkjeqbsSs7ajR1q5d/aqt7T/nxqZFzQyBwMO0pSpvTwn+pv8fRBORQIdYK2/jAF/zzAq6Tn5vKXB92BQ5mVePEaSEKNyBP8LPxIg2lfzD01Sd313bem3EWGA2iOqF+z3xJ5vfvduGSsenoZ4TRXX+x0UrgjsSk2D4s4K12/4x6PZoinK0r/qbsz2Dk8TlDkd8jKfFUaxhXvr7kHPUSdqIjQYqNOIB0R8bpxbLjOQ1C5AjFjx2rlVlTg98FOCyY08cdRONz8KjqrupYefxuwUJkjApoNgZt4ZnMlfAnVgvD6Q2erzacZPzCesT+1psBi0MA5K6wHTUlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXeT51FBpQT5TN+NSZDGJ9rbHlR+mfQ7HRtgNUH5jMA=;
 b=VJKJECnZBHetHI1xuS2plelXwTPd68mcrgwq30bxF2xtQts8o1UL0/lDnUDL/EnCgDXVzMiW0ZRjww02WY9vfxvsl1A4j2VfL1pVpyLr4lTmknp3enEEzgFItV4+YRlta+PhbXlcm+XTcTxfSprw+NTdEqGRDE6iUSF02Yx959o=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CO6PR10MB5792.namprd10.prod.outlook.com (2603:10b6:303:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:59:42 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:59:42 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "code@khaugsbakk.name"
	<code@khaugsbakk.name>,
        "j6t@kdbg.org" <j6t@kdbg.org>, "peff@peff.net"
	<peff@peff.net>,
        "ps@pks.im" <ps@pks.im>,
        "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>,
        "newren@gmail.com" <newren@gmail.com>
Subject: Re: [PATCH v3 0/4] Add support for an external command for fetching
 notes
Thread-Topic: [PATCH v3 0/4] Add support for an external command for fetching
 notes
Thread-Index: AQHc6qBfXizhJ6cAakOZoOY3SLPW5bZBKS8A
Date: Tue, 16 Jun 2026 10:59:42 +0000
Message-ID: <d266c22f90d7140d14fe5dd84d91601d8fad7d73.camel@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
In-Reply-To: <cover.1779532562.git.siddh.raman.pant@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|CO6PR10MB5792:EE_
x-ms-office365-filtering-correlation-id: 0963637d-1c7f-4951-441a-08decb965e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|6049299003|10070799003|23010399003|376014|38070700021|4053099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 W61GC7XGsFLWyzNaRuUddtkVS4TRpw37A4FnKX/TauO8hDsNUQu3tZmg51t0VGjw9luwtx7C7yXKUAAXKF6hvIRbh3NVahwq9k82ymbvqGBDOu77arln1qrPhYtY6iTbR6IZjzhlyQ3MHlUJg0MRIGiXDb20mffsOWfmkWoYb1o42VQBnXEihHL+mYNzxqwKGLeiK6lYRvah1D8T7y1RY5le8MX1agi8ewLX0HGrqA1NIvM8i8Uwe9Yow1cgh8PvO8N1URtKur3knxsN7Ks0FpbCBDp4A1ckJ7XCKoCzWMjBRhKEKRNexflECaIo36R4QrVCqcnwPNmn/deNot4RRzcv93k5Gw4sjY1sZPtQlSzTPjGepE+SsTE00B8YDkjibTtdhs4RCmhIFuKubm7IQuHPa7AcrcG3WsteW6d1Db3kic+GwyeFCb9YwhGnIzQcz0IxUFOCqWYILJ1i9WZ1c9hnWnKdaLjar3Oqsm1sz+fTaYDgQazFLPVrz4MU3nVme2TAnv7r0dP8RjhWHYsw7G09K1ngU9U7y/JSwHlVak33yqHAqgd9CIbtewKC8GqPy1Ld+HcHcgvqKJjry8rg0Tw7nOa9FbwL5WTO+KiMr1c94evaAgtrTx9dbgytR1BUv1or4FBTEeOlNOyoVjX/a7Go4BILGgJctIzOCaY0Mss7QHGEysvD1EBDbNWzvoryuCjQUom22elfBDjkK3Z3D5lrmKeIBbyzl1sHMHSNoRmigkONctEyzM4O/0ZX5mp0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(6049299003)(10070799003)(23010399003)(376014)(38070700021)(4053099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um16azMzUm8xekordGx2SWpXRHF4RnRFTU5qb2xZc21yQ0xyRFJnSEVnWmU5?=
 =?utf-8?B?V0FVMXl3ZGlUeUNZRHpyWHlabGtkOGczVUp0ZTNNQ09hc0lEaTNjWlA1OUJv?=
 =?utf-8?B?UUVnMGYrd2J6L0ZJbkg5TnJEdU13ckZhLzUzVFdQWmZvSXZ0Z2s2V3JRZUlD?=
 =?utf-8?B?Q0poZE5hZUhHUjRvT0U1dzVUTWpSaE5xeTlXVEEwNGRFM0d0S2NXUHR6N1No?=
 =?utf-8?B?MjRvK2ZGMkFPa2VvQmh2aCtTM2JlcTJJTjVTQUtXckRxU1pQcUpWUE53azk4?=
 =?utf-8?B?Y05EbEE3eitudnNZbk9FT1NlQXRsZXhoZUh5RzFNY3BBUjBiS0MyRVNFak5O?=
 =?utf-8?B?MUtyRzU5V3RKSGhqdVRURHJiZ29halJEekN4N2QzOXBjOW5nWWVlQTZDZ0Zz?=
 =?utf-8?B?VGhwL1RMR3hkQjRkekhyaHhTaXZqQ3BnSDM5YlAwRktRSTZpTHJVSDVJT3pr?=
 =?utf-8?B?a2xOUGd5c1lzRys5ZG1YOC9EaHViTklUYUZvNllnS3JlUndLRElzMEY3ekVj?=
 =?utf-8?B?bHh2N0tvd2RHb1liR3ZETnB0SlRGbURic21wdis5K3NQNUwrWGI4dGVlTGJh?=
 =?utf-8?B?TlVCUGs1b2I1VnB5eTZKN1JXN0pSb3llcGxSWTdnZFU1SnJ3LzNUcHpRYnkv?=
 =?utf-8?B?TFYyNWRxWmJaY3h0NEsvYktHUGRpQXorSHcrRCs4YzdtbWJ2Qkt6UXdCSE51?=
 =?utf-8?B?UEdVTm56SEFxNzhGZHcwR3FrYVVaWjNneUdLQk1MVTVHWng2QmV4VlN0eTRj?=
 =?utf-8?B?bnJ2T01qbkFEeXZRaHdJWHVVa2h5cmFNWmJFd0ovcGZ2VHZFemFUZVZ3SmtY?=
 =?utf-8?B?SW5ReDlWLzd5YU1DRG5qeXBmSEtzVTR2WHFLN3FrK2NjT3JqWXVVR3lEWHkw?=
 =?utf-8?B?QWNXblZyMS9JL0diSjB4YW9SbGR6YllVL1VIWjNIRmdSd25yQ3pmbmJTbkhu?=
 =?utf-8?B?SzVmekM1eUxCRWNDaTIyWTVUYSs0K0gyNUdsbnlZbm1VeC9xTTN1ZThCV010?=
 =?utf-8?B?ZlhqNHM3UXE4Y20vSEp2QmRnKzJybHNkNExiUzJQYnRoa1VWREVMamdGMXVL?=
 =?utf-8?B?WEpCT1d3TDM4NGVFRGl0NnkrWFNRRzdaK1VCL1I2UjFWRDJRaUsxcXo4aDFL?=
 =?utf-8?B?YU5kZENXdy9MVUNRdDdOczhQVDhRZmFrSCtXaDRLVUNYb3NtY2RsVEQ5aTVV?=
 =?utf-8?B?WWxaL3A4TnBGUloyOXZqaVlUQnBDdU9wc3dRN3JnWnowUE81Qlc5WFNaR2ZQ?=
 =?utf-8?B?TkVKRUlZUVR1bnZqdG9BN01tTzN4c0dlK20vcFpOVVd0WVFFZFp3UDlneXJY?=
 =?utf-8?B?VjZXSllKL0ZXR3NBZmlnY1NwcWU5SzR3dHByWDRyaEJkZWhWS2t2M2JpYnVN?=
 =?utf-8?B?YmNhbjQ0T0htWmk0cE1PWDdobXZNbEFjQ3VDRG9qQVN0d3VwU0xXcDdwRUJr?=
 =?utf-8?B?Ym0rbDhZUEZQdXVSYWVOVFF5YjlvbWFZbThFTHNHbnFySlhqcmxRZlkvY1J3?=
 =?utf-8?B?UDUvQ0tWbm91UTVKRGNXZjZGTW1GN0V6akFyRENrQTJTb2NpeVJiV0pvb3J5?=
 =?utf-8?B?cTZjQ0hsTTUxOTBrbDJva0RvQ09QZW5OYTdNZlJkK2hXcktBNXdCZCtuWkJF?=
 =?utf-8?B?QkNCYnpURC8yNVUwR1FCQ3p5dVlJK2VlWTl6OG56NUhRd1EzdDJKZS9pbk5V?=
 =?utf-8?B?MDIwdkVqeFlNcHZoMlAxZU82cTcvUXZMUHNJMnBKVWdIdVVCUUNBUlhSMGZo?=
 =?utf-8?B?bCttRC9oZ2dUL09zd094OU01UzBmZ2FqYjJXaUZ0OW9MUUUrRDEzSzQ3UzU3?=
 =?utf-8?B?UGJ1MEVMb3k5cStZa05UL3prS1JlbnU1QW9jdVdmOUxoczF0bjZWdUxpK3pI?=
 =?utf-8?B?MHgvY29sS3RqQWc2MUFmdXRoVWZaRDA4c2xmekRDUC8yUTRkWHpPRUFPTWE5?=
 =?utf-8?B?UE5GZkx5MkVjT2NXUmxBZ0RaMXVwOU1RSnVNZGtseHQ3ajUyRng3NmJiQjRK?=
 =?utf-8?B?YnhhN1ZJak9HTGZlQU80ajRxamZGWkptWWlRNU1nMSt1aFBpY2x5Nlg2Vldv?=
 =?utf-8?B?aDlUVkliaFZJbFR5UFhZQ3lHaG9YcG9WY1Z6V1BNRjZmTVRIeFF6am9mS3lz?=
 =?utf-8?B?NTJ4ZGgwOFF0SzhvUkg3TXpqNXhwYzRacy8xeVpNY0Q3S2kzUU16bWx3clJN?=
 =?utf-8?B?SnB2M1hYeElCYlVpb2NrV2UyZS95UCsxdU5tNTU0K29GSlVQNjI3bEExOXNy?=
 =?utf-8?B?a1Z2Qk1TN2FVWm5rUVk5d2o0T1BPUXRCVnFxTExaREFEbk9ZNmovYnEzUFM3?=
 =?utf-8?B?dTc3YVFKT3VIRkdmWitMYlRWelpOZE9uWCtWTytIcnlJRkk0enhlNld6TTZP?=
 =?utf-8?Q?drTz/+XV0ye4kuUMrdvBKdyspVyhwjUeP1TEQ8clmV7t0?=
x-ms-exchange-antispam-messagedata-1: Tscl3WX+awxI4DZlIB2JrqRyZUl2rCxNofQ=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-Ju255GlZACM5J5VuyxXy"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jdLjlYiryNp0EnMncCABjAcc8eyBBDds6N6CPWc+ZweY1OmAA+Pfi0DMQcYKHaKqVcVN56btReIN2zzGmGKAB+xRwDoO9ZpWNUbLHagAgkHGWDe0FQw66ljbucXPALqsaXx+WgV0tJAVWNthoUfW+N9Hgm4pOQa9cr4rM4bTfHptaZC5DBJlpuNqApBS6O4pYqv97mNpCFL33cZNbvF4WfJFca5vF7pzaAcziunkuvweqRWz5L3Uoa6uCj6lpTGdjxJj9Hg8Zh2l1cjq1iyWzttTFdKtP3RyLb7RWf+XflB2U+XwDW5KCH4eCT8fQqFBum0AdlBOXmtrfSRn1M8vZw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gnkltbXSZENRXj++p5SBloBb4WZ0Y95oDy3fXYfreax5xRy+kqUboTtBeLyZXNAljf1xhTlvZCS9vMvwwE+vyn0tzGph6CkkRaYaMFBkdr5hZTndlQIysIe82SXfzVAInnTMUCu+OZLYL22YlhJEmsOGj522BaqfFYPs7Q4+m1UA4DUPs/F3lrlKJL0JSu46F+WvqSK+qJqMDhHJSBAXTtJB7tW9xrbCFphtzy12jzHLpyA/W1kYMmYxn7OA84N5MpyiXHGRsHv3T9Jef628+acDTWH+Il7op+s0sWWVYpiLMKJTHoS8JwlLrdUWoBcAHXq8rTj05excVZm/3SvwiQyxfu+FmllEl4XmLQ9wrVonBb16kBv2pdXAUU+Vj1R+OhQRmSXCTXT+6usYYbBu9cMgopQYyOaWh98rerot5Iv2oyAJZa8dtQmbpDZkwhPxfuuDc8l7Jxqw8MBK0MIymsbkh78PEzTahIuQH/ietQQbNb9HgpqrDRVmpPFRtXZe9plL8dTr+5VUHoxNPS2nYedM3IqEpkfuV2BxezkURMJ5U3Tx74TAXaW3NhnHcWeEctS/l48PdDJQSwp2J31WUw97KumziImohVp2GjBKgNA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0963637d-1c7f-4951-441a-08decb965e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 10:59:42.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhXU24FMRAxYByBbOvGRnwLRSQad2xonD+uZNLHcbHFHjIV+AeWxmTAbpBVOmgd8x40kPyP01zrKCszzY2gqWNJmPpIpxMIM607SElOuF8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606160111
X-Proofpoint-GUID: 67sSrjdxrKvb6X-5UdxnGZwq8TkSd1_6
X-Proofpoint-ORIG-GUID: 67sSrjdxrKvb6X-5UdxnGZwq8TkSd1_6
X-Authority-Analysis: v=2.4 cv=CM0amxrD c=1 sm=1 tr=0 ts=6a312ca6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=kjtO8AbF9QlfHcqC9bMA:9 a=QEXdDO2ut3YA:10
 a=YYqEgMja3zCeyVr4qKcA:9 a=FfaGCDsud1wA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExMSBTYWx0ZWRfX6QJxq1xoLAYi
 SqMWXgHcL/92bF3/lUCyUwpg8L9R6kMg5JAehM3hfSP97ePtJvSku1Wk1phXrgsAOlISjAVBaBK
 MLSarB9jzFe51P05sRC25OWPXVJ+sVG9HGegT72mcejqOxXMlXKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExMSBTYWx0ZWRfXzXJ6AM4gzJI+
 FFDrAVSJgCgCSFI2O/ea7NIewH4UlW5cHtBhbQLY9nAWU5MHdK8U/sBn4eTt2+2odysoiJNr5m1
 4kg7wuj+XrM8kQynK8Cd3dT8mzDQoocIXi3CokHKy47KEbY9Q1yEm1bEEs03NfLJmJHml9CeW0E
 IHRIKTZfiTwaJm3Qwni77IWrho7l5kMBw/7x8YI0W2oChROgY8MHNheZTJDPXVo3hRp6XcgXCLr
 rN7tUnEs0EsYwDGuyNQZjkAw8nD9a2BK+t8Xxa/m8TLG6uzzihKKTH4nYRuh9H74Iqe+aBUGBLf
 o92ExvXuenUa3R2d90qcS/G6BT+NDKPAR+MsuUqo5rgAq/VFMVhU1/+PB7h3m+AKt0ZEA0Zyj4q
 jdcCcGgX3PdRYe3G1uP1VDKrCzMF1jN4uHxnBT9cnmhqsolMJLbgarcdDA+JTT4COK7KR4XAgSE
 Uj6pXMNSXyvwRJTz2Og==

--=-Ju255GlZACM5J5VuyxXy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping...

Thread link:
https://lore.kernel.org/git/cover.1779532562.git.siddh.raman.pant@oracle.co=
m/

Thanks,
Siddh

On Sat, May 23 2026 at 16:08:08 +0530, Siddh Raman Pant wrote:
> v2: https://lore.kernel.org/git/cover.1779464886.git.siddh.raman.pant@ora=
cle.com/
> v1: https://lore.kernel.org/git/cover.1779207350.git.siddh.raman.pant@ora=
cle.com/
>=20
> <...insert text from v1 cover here...>
>=20
> Changes since v2:
> - Removed stale help text talking about force-killing helper process.
>=20
> Changes since v1:
> - Removed Documentation commit and sent as a standalone patch.
> - Removed finish_command_with_timeout addition (and thus sleep_nanosec).
> - Squashed the external notes command code, doc, and test commits.
> - Removed horizontal separators from note-external.c.
> - Removed global variables from translation unit and instead store config=
 in
>   a dedicated new struct member in struct display_notes_opt.
> - Reworded the main commit to have better explanation of the motivation.
>=20
> Siddh Raman Pant (4):
>   notes: convert raw arg in format_display_notes() to bool
>   wrapper: add support for timeout and deadline in read helpers
>   t3301: cover generic displayed notes behavior
>   notes: support an external command to display notes
>=20
>  Documentation/config/notes.adoc             |  59 +++
>  Documentation/git-format-patch.adoc         |  11 +-
>  Documentation/git-range-diff.adoc           |   6 +
>  Documentation/pretty-options.adoc           |   9 +
>  Makefile                                    |   2 +
>  builtin/log.c                               |  17 +-
>  builtin/name-rev.c                          |   9 +-
>  builtin/range-diff.c                        |   2 +
>  contrib/completion/git-completion.bash      |   4 +-
>  log-tree.c                                  |  10 +-
>  meson.build                                 |   1 +
>  notes-external.c                            | 414 ++++++++++++++++++
>  notes-external.h                            |  53 +++
>  notes.c                                     | 266 +++++++++---
>  notes.h                                     |  33 +-
>  revision.c                                  |  36 +-
>  strbuf.c                                    |  26 +-
>  strbuf.h                                    |   4 +
>  t/helper/meson.build                        |   1 +
>  t/helper/test-external-notes                |  64 +++
>  t/helper/test-notes-external-config-reset.c |  24 ++
>  t/helper/test-tool.c                        |   1 +
>  t/helper/test-tool.h                        |   1 +
>  t/lib-notes.sh                              |  19 +
>  t/t3206-range-diff.sh                       |  68 +++
>  t/t3301-notes.sh                            | 448 ++++++++++++++++++++
>  t/t6120-describe.sh                         |  17 +
>  wrapper.c                                   | 139 +++++-
>  wrapper.h                                   |  23 +
>  29 files changed, 1691 insertions(+), 76 deletions(-)
>  create mode 100644 notes-external.c
>  create mode 100644 notes-external.h
>  create mode 100755 t/helper/test-external-notes
>  create mode 100644 t/helper/test-notes-external-config-reset.c
>  create mode 100644 t/lib-notes.sh

--=-Ju255GlZACM5J5VuyxXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoxLJcACgkQBwq/MEwk
8iovBxAAkl3cpJ76QxtE6NQopdKwkO+xt9+2b4Ra4z3DPyWjmy8kvxpVecVKlMyp
lc6ejGtx0f+JQtcIbfzrsfN5n+rwolOcdBhwmU1TD6K7Er7IdGeNFqVJO/kor4VD
uCfxyIKtFo/i5mKSB8pVfWNHqroGHrjxXiHaUNZBNiG3bW2KCP9pQvSOOe70gNtM
Dj7ta1+zVMEfJMR6VB9gPzkRlOLE1In0jAMTpZThsuvwXDm87OW5q6ulYWsuyEd+
RoNUeNLw8bHPzJ0epqhsxps2ddgG9uPo6mjSHqvVDhpcRdHohvJVH8GfKY/oOHvs
ozAyVFSIBWtEekCy8VZijdxHF6uNbQ1cL5sEz9kXHrzj/kKcsM1xOBH9QEX5XEDS
sfnWbp4pVUDPRpZYnL7/wwXwkOgYEmAWCSwD1sjXU4jNPAFZ1i4AgJoMr8jLodVX
gs35ZLeR6Y96H85BOiKh5QntQzAidbGMT8IZ53hW7UulbX4uLl3KPEnVRdWYe+6s
jNPEwE8HQsIqUmBpgbz7SeiVibIKWJU9uEDGmc+JaZJk+ZQJ5HvFLhdes5E+FMin
FvSyD2uTgxMEyoUYz/3xzhM4iwJRx1L5D/4BOCA2eF6lGD/SIq0e6CKPvihC16PA
48AEUY/Pil6MyDwYVwS+7N4q0RlbDR3Fb5o7qlRe/os/vPKpgY8=
=OXC2
-----END PGP SIGNATURE-----

--=-Ju255GlZACM5J5VuyxXy--
