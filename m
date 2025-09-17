Received: from mx0a-000e4101.pphosted.com (mx0a-000e4101.pphosted.com [67.231.144.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAB31159B
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.144.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151414; cv=fail; b=leMa/108t6ZIQJxPq402x+0qCGeZyqFSZbdMLsUYp6HtfSis7MtKVVikCF7CYUpbgSOb+biuN92yFyzl8By6jMf+GqKIuC+F9PC+dMTzpJaP7u6ygOE9rc3Ik3F7RjFCtIkSNRtKnmZUPYyIKy9pqLxokoi5Igko8hmZMFRtcjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151414; c=relaxed/simple;
	bh=Bt/LCFkp/okruCHPEFuP+4VNbCzsCE6p2lDeR9kikQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kgIugdrMuEa66gc1OaIvPLxHKG9w7c+8hbhukIUx8vmJLcEpb64bkNV0Mm0IogWUoHZJViJ5pqJc49/X2QrgeiV0oAvF1Wq4e3nznap23OOnMzqH4mkRETSGWXF2HD7XHoQegbHvTdsoB9QY+1KJ+pKkxnqkQ2IHyEYzO8kx8Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=johndeere.com; spf=pass smtp.mailfrom=johndeere.com; dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b=qiBDrvh1; arc=fail smtp.client-ip=67.231.144.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=johndeere.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johndeere.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b="qiBDrvh1"
Received: from pps.filterd (m0001688.ppops.net [127.0.0.1])
	by mx0a-000e4101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMVAID024151;
	Wed, 17 Sep 2025 18:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johndeere.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	S1-Feb19; bh=OITjIKghPGDGvPW6c+79AxWcM/mqG9S7lTQ6STZp1Kc=; b=qiB
	Drvh1Pl8+4AKNo4KYVziFWvxY7CE6TiWIaGCR4zYiJdCl104MBdmj07HmWmIVsRS
	+RjKmDg6xrRUbcw9WX1xo5Pi+WKmfC+gjyqrcPcAxx1OMcz+e8k43nT67s2Hi1fI
	L+a6D2EH9duBjfxN/KH6TMCvdB/2vMhg/m/n1VOrrWzWUtI/om4aRmUOiB95gaVU
	y9psyLRLcUzu+xJ1/rUn2c1K36Ec0ELy6Pr0ysxtPRtSESAazkB9xRHBckJENuR2
	vbyozqGKt1nqJaQNaHm2b2dK0PJQkSYQkiH1adt+xg+4qImOcrafvujpF6IbqZ8h
	2hYz8zx/dWjHiLNVdJg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	by mx0a-000e4101.pphosted.com (PPS) with ESMTPS id 4985up869c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 18:23:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEbTibOyhk9t2LUvz7Jh7taIwWyQGF3sfXVzZ0jBwhtokgzTtMgkkYIpNPdHZXl2/Sy5bEnXd5YZ5d2k85deQeRRW1A4R3ZKbnuUxH8XyTjfg8IbarEX2rBx/THmTUEV/3NsiarFGGihJeQ1NGR8bDann+NXpB7KpLCz4aOK2/T4h+09bgoqKqllgWOuQ/YHX9tsl0/YqnEts0zoC37VvLWPwz0bPaIZkPr4KnP/bqgjFhZrRbV+M/P9UW6FSVs6hft491ThnJEbwtY56hyveJ1z7YUiU20NArPb7KuIyKZvJquAJS7P34IKEj2g6qmn4jOxcGtj2fm1Z/t+vgiKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OITjIKghPGDGvPW6c+79AxWcM/mqG9S7lTQ6STZp1Kc=;
 b=PeOH5cNJC57kvM1ahPUS0aoSn0fBl9auTcgKAKF88MICoZngpeD3J4UduKJA8EL9v+ODlekDOkTXYVhf9Rv5sBidxsGjX8p0KKsOjaceNzSxNdd+I63UpwTDzR3VzEYIle1tU2kNGBH/hQArdBKWJ2BPh8R2bi9d4swFcgy5QyMl5GPOwGJsMfg2BdKh9+IBn3vv9z2FDe/Z4oXKQjVcaTyvfhTc6CxILFAT+b1/y315oyC0Gm9neNf0SnApBzNW1DDjSfTJJRwoT7jo5QPfJzpBJShy5Mo9/DW4v45FPVU457LMVCwJ02j78wEtm8VVmzCpDK8t1xbQEDiZAsJKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=johndeere.com; dmarc=pass action=none
 header.from=johndeere.com; dkim=pass header.d=johndeere.com; arc=none
Received: from DS0PR05MB10013.namprd05.prod.outlook.com (2603:10b6:8:dc::9) by
 CH4PR05MB10904.namprd05.prod.outlook.com (2603:10b6:610:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 23:23:22 +0000
Received: from DS0PR05MB10013.namprd05.prod.outlook.com
 ([fe80::9fee:64a0:138c:ac3d]) by DS0PR05MB10013.namprd05.prod.outlook.com
 ([fe80::9fee:64a0:138c:ac3d%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 23:23:21 +0000
From: Kevin Puetz <PuetzKevinA@johndeere.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Topic: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Index: Adwn4L+L8mwJ2RsSTrSupH686MDnlwAOFSCAAAMzZEA=
Date: Wed, 17 Sep 2025 23:23:21 +0000
Message-ID:
 <DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>
References:
 <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
 <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
In-Reply-To: <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Enabled=True;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SiteId=39b03722-b836-496a-85ec-850f0957ca6b;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SetDate=2025-09-17T23:23:20.0000000Z;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Name=Public;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_ContentBits=3;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR05MB10013:EE_|CH4PR05MB10904:EE_
x-ms-office365-filtering-correlation-id: 606d35dc-4ad8-4396-7f5e-08ddf641312f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-7?B?TFpzNU9oYnlhNFFFbVVMR0NtRVl1NnlLM2kyc1VhMnZEcFNRYlJJZHNlY3VH?=
 =?utf-7?B?ZjFsZlIyeDZRcEhuQjZNdTd4SUFESnQzKy1rRnZkTFZuclZCUE9hTk9YZ0hL?=
 =?utf-7?B?eVFYcERsQlIrLVIxNFAvbDFlZHlORnNKOCstZzNTSjQwUFN4M2dGY1RQS0I1?=
 =?utf-7?B?RXFKUEFvQnR6bVg2T3kvMHk5cU5CcE1nNWtqN2pqclc5Ti9lYUNyRDNxTzdO?=
 =?utf-7?B?WVVZU3o5bU5Hbi84Q2Y4dkU3eWFDUnJXalB0Y2RIOUhTZ2dWY3ExU2tJWVRw?=
 =?utf-7?B?UW9qVk9EclVvWkNyNGk2Y21WUFA1WlJrc3VpMlpQeFVubFZ3WFhOUG11SEVS?=
 =?utf-7?B?MXl2SFR2ZXpFUTFGM2RJT0VHL3JackpNNWNXV2tPbG5qN1dUUVl2V2gwQUNx?=
 =?utf-7?B?NnR2ZENhcjNiY1BhN0x6Q09aNnJsVlJtdDUxQ24zKy1vSk5NQystMkplcTY5?=
 =?utf-7?B?b25Xc1pidXoyNG9jS3BiNFVWaTI2Z1V2c0NkZjlCWEJEU1B0SFZxRDVBVlZ4?=
 =?utf-7?B?R21mZnYwaDFYS3NrNHBhaFlZTURrU2dTRSstOGFGNVRWTWVsMUF2ZE5wUTV2?=
 =?utf-7?B?QXNJcHBDMVlYcm12WFIwNEpBaVptOTJxOU5mcG54N2ZGYVVTVng5d05aMCst?=
 =?utf-7?B?enJTMEkxWUNycHZMclFLQzRGZjd5UFlRcjNEUjhVZHdtVnJFaG54QVlFYWFa?=
 =?utf-7?B?ejhGYTljUU1CQ0tsaTZuSzdmL3VUeW9za0llcFBhQnpkdms3V3dDbGlCNXI3?=
 =?utf-7?B?QzdaVnVhTjJ5SzBQTEk4aGltMTFJU2RMODMzN2RjbE8zaTlLREk2a3R4dUlz?=
 =?utf-7?B?c2RsVklvTG5SclpQNmgvM1RUTXFmbU8wOEhDUndza2RaZFVqcXlXUTR5blRn?=
 =?utf-7?B?WFozdDlOTDNqVml1T2x2TU9hdXhNVVFoNzl0V0gvUHh2WFlCNGx3cDdNSzUx?=
 =?utf-7?B?dmY0aDFRVGNCaTJSNVlHZEFhVHJvREYzUlNyU2xEbnRacWJVcE1JNEdjZWJw?=
 =?utf-7?B?S0I4WXFrNmdndDlMb0cxd0gwMHBCT2dxTHBHYVo5a3Ezd0hDNU44by9udE5R?=
 =?utf-7?B?a0JIMWN4Q20zN29lRGk1aDZIVHBJZk1pdklMLzNuNGRSU0tlOGRyaTBTd3ZP?=
 =?utf-7?B?VHFya2drVjB1djdCaEJVdzVQa0l0elI4MDhUY005aXc4WDBwUzRzTEoxYyst?=
 =?utf-7?B?MllGYURHeFpObnZldTRzN1JhSEtid2Vvd0lDdjdIOHhGQXhpT0xoSkFqSjNW?=
 =?utf-7?B?RS95TWdWTmE3VEcybVc4WWdnYTJ2RDFqMVU1c1gzVG1GMW1zWHJ0b2E3ZE8y?=
 =?utf-7?B?SHBMYUw2NG96cG1FNjlEMDJWWUh0a0RoZm1lekpTd0J0OFl4bnR0ck1hMW4x?=
 =?utf-7?B?Z0dnKy1mSlhGRW9uSlpzdElrOEM2SDVtekd5dUlZQlBaL0xXRlhxNDRlL3M2?=
 =?utf-7?B?Mm5xS3F3V3QyazZEbzBsZktqV0ZrY3BXZ21jVU50YU5tdVVZODJFeHUybUFD?=
 =?utf-7?B?OHVEd3NNU0VQTEpqeUtxeVh4aWVIOGt4ay9QcHN4SWdOUnJOU01RVXpaQUxr?=
 =?utf-7?B?SFB1M2oyTlBHZGtCWVV0YVhMRGZwKy1la1B4Ky1zKy1XdHBqL3cvTjNyTnkx?=
 =?utf-7?B?Y0xLZistdmJNWXBPVDhzQnplWER0dUN4azJrVU10VHgvbXp4U3VrbXNneXQx?=
 =?utf-7?B?SDQrLUF6SnJ6WDVwNEFYVmFqZWFEM1VUKy1SbURxMldvWXRKTkttNXlmN0k1?=
 =?utf-7?B?Ym9aNHpiZ1YvUkQzZmdpQ21PdFUyTDJLandOeVF5UzRnazdhcFJ0TjlXNnFC?=
 =?utf-7?B?M2pOakR3THI2dWREY0RwRktqd3ZwNUFVRUZ2RlBnOVBIQ3BoYUhYc1V4ZUxv?=
 =?utf-7?B?dWFFRmViVW1JSXpxbystazRPY2Rkc0hhdVBPdHM2d2EyOXErLXVlMzNoY2V3?=
 =?utf-7?B?dmlXWldoVklwQ1dKWjY0Ky1aOWd4WHpRSHpGNml1V2RuZGNhOXBzTEMwM0w=?=
 =?utf-7?B?WCstd2hNOE5YdUVUeDBVcXViVi9YRTNBUDZOTEppWERlUXUrLTZCYVZSTE14?=
 =?utf-7?B?WlRHamdzK0FEMC0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR05MB10013.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?clRyQ2RXRDhndWxnVU5ySjZscnRGKy1OSXVHZnhRcWNlZnRGZWRTN2IwZzlH?=
 =?utf-7?B?SDBOdHUzNHNzQ0pYbDY1ZGdkZnVvdVF0NGZidHN0c0M0MldjOER3b29OTmk4?=
 =?utf-7?B?MGNMempQdnpNYkEvekRmUDVUQUxQeWhzKy1WZVJORmloRi9nd0tIaE9GM2pO?=
 =?utf-7?B?bVd2MEFWaS9tRDUzSXZsRVdVSW4rLTFpTEMxVkVLNHZYRU53V0R4ODdnaTla?=
 =?utf-7?B?VGhoWjNQN0o2Tk5NQTBmWXByQW16TE9JTHZTTmFuNERXekpOY3Y1dFI2L2xB?=
 =?utf-7?B?WjM5WnhnNE1vWGY4SVJjczdPWSstVDFzNG05cUlQWE5XYm9zeUFuZGRybEVK?=
 =?utf-7?B?YVZ0aGdLZVdxNmlYY3VpbXBLSnRza0F1ZDZYajU5Ky0xRmhNRmpQdGcxN0Ux?=
 =?utf-7?B?aG5venNlbHdxOUZpNlo5V3dsYkpFZnNNa0EyeGs4bi9HZjd5dlZ4dXR6cDR6?=
 =?utf-7?B?aTZSUm14emEvY20xekhQejdFR1FhRUd6SElCTHZGVDdlbXpBNkxSTDZvTmd5?=
 =?utf-7?B?MEpoRTJYWEFucndBa0FzdjNIZXpzKy1pcistZk1WVU1Xb3BPb3B6TmZkZUdC?=
 =?utf-7?B?NkM0RVYrLTMwV3BXNktyTmN5TmpzbFB0RmU1cVpTMmVqMW80UDQ2b2hvN2tp?=
 =?utf-7?B?SGQxQ216NGpranlJNVhiTHZ1dnJlcEp2bkFUTVVIczBhazZIeE1MUk5SVUNW?=
 =?utf-7?B?SUFlVzZ0QVhpd3d4bzg3amp3ZkkrLWJxcEExUHZ0eVNkZ3pNVEpIRHJuMGlS?=
 =?utf-7?B?Um9MMnYzd3FvWmVQNUhmTDgvQmpkem9hN0Q2b2ZQRWZueEhISG14WU9wRXhv?=
 =?utf-7?B?NGd5Z3YrLSstWWJjMDVNOGNVV0NqSHpQc1NBS201elJGMXdkQUNyWDVFZTBH?=
 =?utf-7?B?WFB5TDJubkYrLTBYT0p3OVh2MEgzWCstTjlCNDNEakR4WXBvbnBXaVNmeEVT?=
 =?utf-7?B?RS9DczJ3Slg0T1puSE5jRmJBb1VUWWFxaVJxVTRLa2cyTVlaZ2ZxQzE2clBs?=
 =?utf-7?B?ZmRKUEFFN3ZpQ2N0dEVCTzl2bjJxbjZYZGZVTGNhd2pEakFzT3A4REhNTU9k?=
 =?utf-7?B?V0hmVXhQU21RZ0pMZlhGc1FHbUxwVmlhYXJCMVAzZWFiWk1WbHA0c3JkbVBZ?=
 =?utf-7?B?YlFsUW5yYzZCMDVYcGRLVGpiMHNBVmdDMDdzL1RDOHFhUGVGT2pvTFBIRmJE?=
 =?utf-7?B?TFhYMkdwMngxKy0xcHZaVVk1ajVLbmdkcmhRaXNvVHQ3b2s0Z0V4YU1SSURN?=
 =?utf-7?B?dTNNdmNWMEkyYjdnUnRRWmtKeGRpbE1OekxXcHpmSmxYQ3hjUWZUNUlBU1px?=
 =?utf-7?B?VlVjRnNLSTBWT1hid3ZMaElCdXM4WTAxd1hRTUo1Rkc1QjFQVEtDM2Zaay9C?=
 =?utf-7?B?bktWd1BVY3VaTk1FTW50YlhYc0R6VU81YWxYQWpQNkdyLzJiSXl3UXMvaEpK?=
 =?utf-7?B?aGRLNEVIVE9yNHVjMlAzcS9OdXgwdXlKMEc0TTczUEZHQnd3cWorLVBLb0hz?=
 =?utf-7?B?Sjh0UHF3TFVzcU94bUR5V2dsZFdxcElkZGNaMXJCQWxtQUVRN2dLYkpRSUZQ?=
 =?utf-7?B?WVpFTUlXNEN3TjdkWUx0ZXZPRVcyQnI5QUN1M1A0bDlwTnhSOHU4OHc5REw5?=
 =?utf-7?B?c0VyYlZrdDRVQ1U5bm5WZmlUTU5jRG5vcFk3aGgvYU1qa0FyZ2hMZFV6c3Jy?=
 =?utf-7?B?emJPYlJDbTBXbk9POUZvY2JOdklTNistaTlublVRKy1iSC9lNXR2a0FQbmR2?=
 =?utf-7?B?dUhrb1llM1k2b3JWMHIyV1dXYkMrLTdOMzlsNnNkYzFDY1JPSE0rLTh0NVRK?=
 =?utf-7?B?MVByYlBWYXozYmlkZ0Zla0JBMUNxcU1TejVnaDRWOUxhYTBUVldENlR2Ynk=?=
 =?utf-7?B?Ky1laWpkdzByUlFvQ3ZJSDJ6U1VQWEREZ21BYmJQQWMrLXA0ZmlWRndPTGJE?=
 =?utf-7?B?b2NZYnFMMlJpRzdHUzlSVEd4eEFSMWNMNFN1cVRwSG03aEhKajJVSkxReEM3?=
 =?utf-7?B?VERISWRDTHpDeWc2OHMzRkNyM1JIZERCci9uLystOGxwWjdnQ0ZjaFZsV2VH?=
 =?utf-7?B?dGppZDBhTE9xVGJuKy0wLzlRSFN3RDJJT1MvQVFsYzRsMGdtMkJxazNQOXo4?=
 =?utf-7?B?SmZzeHZhL0U4TWdzUEtSMzdaL0F4TzRINjMxclVsaWkxSVNycXpiTW9UTSst?=
 =?utf-7?B?Y2s4b28=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: johndeere.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR05MB10013.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606d35dc-4ad8-4396-7f5e-08ddf641312f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 23:23:21.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39b03722-b836-496a-85ec-850f0957ca6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2IsLGuoH51Zjf8QNdA6ZMn1TEi4yY8V/5PZ0V14atXIsKCmFOJ7x3RMrbhd43ywXpvg8Mi/jUK0j/1jv0sBkIwcYmm5mRSRpluSfFgVh/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR05MB10904
X-Proofpoint-GUID: hAGGQui0QGXuLMZyxPo6lWn-r2cx41mo
X-Authority-Analysis: v=2.4 cv=Ldw86ifi c=1 sm=1 tr=0 ts=68cb42ec cx=c_pps a=BcPl/o76WFXIZ3b3OvynCQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=9awoZWdA_bYA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=IyeSnNmU22RWXG49K6MA:9 a=avxi3fN6y70A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOCBTYWx0ZWRfXx5XYQGy2+Lxc n8NCTAUidQFTDBz8+xbcn/jd7WVJ74HtjDX438KPxNIoT6aEqOGbR53AQlgU1heS5C7/s8eF827 lWcQ6FWjMe9ON4rdYbuf5txsYpQelQTaxSL/W4ntooI7dFYFguc4EqUruuBQOL/u+h5IFQzhU/t
 alFNt6wtgLX+XqKKmwbNaVNSdcBJIbWM6wx3gsdkk3Ea09muDDNmElSthFb42UUooEcEUPLmSMe TKjP/y72uY40IMNYysUFlewvr1Oi25GVJXxHrbqV+BHUaGHccY8dXYG90UvZBAdXWuOSIxNwjI5 sLsbCSuCJ6xmNodfLCGNZTgV9n0dpXnhKdiKv3VnJ4lFIf0UNrj88GvAzeOz2tlz42sjaBNNSgs ZqbnXhy9
X-Proofpoint-ORIG-GUID: hAGGQui0QGXuLMZyxPo6lWn-r2cx41mo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170218



Public
On 2025-09-17 at 14:44:00, Kevin Puetz wrote:

+AD4- +AD4-     the .git/config file was modified, adding
+AD4- +AD4-
+AD4- +AD4-     +AFs-remote +ACI-origin+ACIAXQ-
+AD4- +AD4-         promisor +AD0- true
+AD4- +AD4-         partialclonefilter +AD0- tree:0

+AD4- I will note that if this command actually downloads any data, this is
+AD4- required.  That's because your repository is incomplete: you want to
+AD4- download exactly one commit and without marking the promisor remote, =
you
+AD4- will lack the ability to acquire trees or blobs and your repository w=
ill
+AD4- then be corrupt.

I agree - had I actually stored the fetch, this would be correct behavior.
It was surprising/wrong +ACo-only+ACo- because --dry-run threw away the res=
ulting objects

+AD4- +AD4- I did not expect any changes to the local clone (due to the use=
 of --dry-run)

+AD4- I agree --dry-run should not change your repository.  However, I woul=
d
+AD4- also say that it should not contact the server, either

Hmm. I'm not sure I agree there. Usually --dry-run is intended as a way
to find out of the command is going to give any errors, and that's the sens=
e
in which conan is using it. I could see it not actually downloading the pac=
k from
the server, but I'd of expect it to at least negotiate which refs are neede=
d
(and thus fail if the server doesn't have them). Which it currently does.

But I wasn't expecting it to make any lasting changes to the local clone,
So that seemed like a bug I ought to report (though it's admittedly quite a=
 corner-case)

+AD4- +AD4- Context is https://github.com/conan-io/conan/issues/18949
+AD4- +AD4- trying to avoid a full-re-download in the process of checking
+AD4- +AD4- whether the HEAD commit hash exists in a remote.
+AD4- +AD4- The command was expected to either be a no-op success, or fail
+AD4-
+AD4- I don't think that the command you've provided is a good or efficient
+AD4- way of doing what you want, but I'm also not sure that there's a good=
 or
+AD4- efficient way to do what you want using command line Git (you might n=
eed
+AD4- to write a small portion of the protocol, for instance).

I certainly agree that the +AGA-fetch --refetch+AGA- conan 2.0 is currently=
 doing is a very inefficient
way to check if a remote has a certain commit or not - which is why I was
experimenting with blobless/treeless to minimize the useless transfer.

Today I also found +AGA-git fetch +ACQ-REMOTE --negotiate-only --negotiatio=
n-tip+AD0AJA-COMMIT+AGA-.
That supposedly (and seemingly in practice) replies with the list of ancest=
ors,
we have in common, i.e. it will print the same +ACQ-COMMIT if the server ha=
s it,
or some list of ancestor(s) we share if it does not. That seems like a much=
 more
sensible command to check whether the remote has a commit,
so I'd also appreciate any feedback if I'm there's something wrong with usi=
ng it this way.

I did find one odd quirk. When the remote and the requested commit are unre=
lated
e.g. I'm taking to the wrong remote, or have done +AGA-git checkout --orpha=
n+AGA-), I get

+ACQ- git fetch https://github.com/git/git --negotiate-only --negotiation-t=
ip+AD0AJA-COMMIT
fatal: expected 'acknowledgments', received 'packfile'

This still works for conan's purpose (exiting with an error means it didn't=
 print a matching commit hash),
but I expected something more like the +ACI-fatal: remote error: upload-pac=
k: not our ref: ...+ACI-
error that you get from git fetch +AHs-remote+AH0- --refetch +ACQ-COMMIT. O=
f course, unexpectly sending a packfile
could be a problem with github's server implementation, rather than the git=
 client.

--
brian m. carlson (they/them)
Toronto, Ontario, CA
