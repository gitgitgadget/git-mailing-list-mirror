Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020075.outbound.protection.outlook.com [52.101.46.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7D1FFC60
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973532; cv=fail; b=hDEJLrpX+tDwRfrelUaBhHFAz3Byt23AH7RUQOCU6WtgpiRLSmraEO7lWS04gfC39oucdm50ozJd/RX2SMRCMNnpRcAVMNeJw9Wn8a3ZeOonR3gG/JwOb4iOfSOgDmKsCBLbMWEqZWHs6BF0hzdIn8u8/NrIWEl/p5H1Ang8J3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973532; c=relaxed/simple;
	bh=nqCD7gGZ6+B9qbzRjhGTQU0mFXGM4A5DMr4DSRgiZr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9WxScTYAJcr5zbh2/OredQchxG0NZ2EFkH3Q+kb/Sj6sW4b5WrM1hmE3dZNNAFORxZu6bP8zIn6BBghNQP/dNL8EnNOJIPBH/txIwBbKMw25r2eVKeVHxGXTet2AiPYACMi5SBNbi0vj6cEbI6bjEWlx751VuoKYmDYleBZuSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dEetu+uJ; arc=fail smtp.client-ip=52.101.46.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dEetu+uJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHuqjk8m9NaA3MDTP43muAO3UGk3UOqj7JMCyI7UPzmsDVHch4+qw9CswJVuR+wxg8Gm7z9nVZR7cyVl4eqxVg6d0ZEVkZfDNOC/70TTttOZJ/5NuHWB4LjO47hRaOWqsPRLa0zRomi4aKc74gpAqlmoVVwPi29VTgApuiW5fmzL3Z7dLa8GvvUfz0lAYnYhP1u98Mfu849gfLK9M1MKFvnv3EwTbkOCkHbQtF8NV4tJnY8DBvv1QwVLKZQ8kHX8ilAQWr/pP+r7ykfH1+fA9e+5K1QlbCgTMsndwAD198Yc7Tsvaz/y09IXSayMp+Nl56m8FIVeUnOz9Pxb/FZGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqCD7gGZ6+B9qbzRjhGTQU0mFXGM4A5DMr4DSRgiZr8=;
 b=LDWNc9X96GspgkrJaL+C+CJh6Z44iae89lQcLcIdLNo/5ORQ3U5PRl9+GLCUYWf2IB/EHhwIOpRtpZndStC3DZ9Qcl/C5P2tQlcFSv3B/ObJYI2kPKImj96Go0UlxVjD+gf5xMhM2MSipJC9VH3gHm4uQLrIX2Xk9Oi88US4sm0WFONDi9aN+nfgYA9sad4I5UxDLP2SHwoA1vmBfZERTqcAthHmOBgxrNn6KNums/YKwajXIj8nafl2H58axWUQl8xsRAgBZj4MkeY/AN8nhVvnT+ANakl4D4RhT6/TyFXU6pvj6RsX/0ZGDK/2zgBE4TM/T4UdRFBTwq1XyIYgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqCD7gGZ6+B9qbzRjhGTQU0mFXGM4A5DMr4DSRgiZr8=;
 b=dEetu+uJlmJLn4tZJKzqFs8L1st2hdknCab5pKn5OuLgu1PzVzZEKy2EjI8UkRFWfPogAsJcBPF2gzwn1+Uoh3woAR8dlLasAfPfQQmirrpXjeGMnTOBRdLK50L1Go4Gc8+bc7mBdJiC0JYbQRp/wJPQf5CQwAw0sB7tTutxWwg=
Received: from DM6PR21MB1291.namprd21.prod.outlook.com (2603:10b6:5:161::27)
 by DS7PR21MB3455.namprd21.prod.outlook.com (2603:10b6:8:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 17:32:08 +0000
Received: from DM6PR21MB1291.namprd21.prod.outlook.com
 ([fe80::e20:a64e:f835:1a6f]) by DM6PR21MB1291.namprd21.prod.outlook.com
 ([fe80::e20:a64e:f835:1a6f%2]) with mapi id 15.20.8511.000; Fri, 14 Mar 2025
 17:32:07 +0000
From: "Haifang Wang (Centific Technologies Inc)" <v-haiwang@microsoft.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Windows Application Issue | Git | REF # 56282410
Thread-Topic: [EXTERNAL] Re: Windows Application Issue | Git | REF # 56282410
Thread-Index: AQHbk40/kc6f216w7k+hrNR1Nzo7P7Nv98JAgAHA9YCAAS4K8A==
Date: Fri, 14 Mar 2025 17:32:07 +0000
Message-ID:
 <DM6PR21MB12918FEDD3E30D8CAA5FFD63E5D22@DM6PR21MB1291.namprd21.prod.outlook.com>
References:
 <CH2PR00MB0812B85F95651EC133D38264D255A@CH2PR00MB0812.namprd00.prod.outlook.com>
 <BYAPR02MB49983AE922A5690EB86BFD2DA155A@BYAPR02MB4998.namprd02.prod.outlook.com>
 <CY8PR00MB1459EF0E020DABD52F63460AD20BA@CY8PR00MB1459.namprd00.prod.outlook.com>
 <BL1PR21MB320858BAF11193AB06109B2DE50BA@BL1PR21MB3208.namprd21.prod.outlook.com>
 <DM8PR02MB80213198F9A71571EB92D989CD08A@DM8PR02MB8021.namprd02.prod.outlook.com>
 <PH7PR21MB3263AB0D6C1DE7D56E9613AEE5F12@PH7PR21MB3263.namprd21.prod.outlook.com>
 <DM8PR02MB802134089B95821DF4174A14CDF22@DM8PR02MB8021.namprd02.prod.outlook.com>
 <DM6PR21MB12917960F9D9D488A03FCF19E5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
 <DM6PR21MB129188369F4FE0C0DF306B80E5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
 <DM6PR21MB129127285D6FDFF80A1AE87CE5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
 <Z9Nql1ZnoD6dzoO-@tapette.crustytoothpaste.net>
In-Reply-To: <Z9Nql1ZnoD6dzoO-@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=772a8e80-b735-4950-a4fd-bc1f501abfa2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-14T17:31:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1291:EE_|DS7PR21MB3455:EE_
x-ms-office365-filtering-correlation-id: 9cb778d9-ccfa-4d00-c1a3-08dd631e24fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVZQMXZRbFh6OFN1c08vZlQzWEhjbjU4cThKRmRHNVFKSVV5L3I2d3I1c1hr?=
 =?utf-8?B?M3Z6QmJXT3RlZTlsa2xNSHBhSy9RcElLWGRzeHFNL3JaaTVuME1WVStpWjF0?=
 =?utf-8?B?Z2ZjMkdiUmpXVzZLTlJDVjQ2d2hVSzZ3b1laZVB0OEhPbkRsKzBLdzBJZnRx?=
 =?utf-8?B?VjF5SE41SEJhYXppYW5tdjJJT1pJMlhtajJwT0Iwcm5LN2cyTGVDWDhsQTJz?=
 =?utf-8?B?Qi8zekFnQkMrcjZVYkJkaXg2a0dRcVBoSk4wZ0FFeHZ2WWp3TStNRkkreGd0?=
 =?utf-8?B?RnEzSXROdnRnRlhBMUwxWDVmUndxdkpxU2FHUS9POSt1MXBwV3A3MXJlVUpn?=
 =?utf-8?B?Uis1V0d6UGtOTVZ5ZU9GSzRuK0J0VnUvTHl4ekExRkd2YWtRQWlhYVUwLzVU?=
 =?utf-8?B?VnFGVmNTYklTK244S1dFbUtRY3N6T0xnL2xtM01DaTNIdW5QOERveXlwSnVt?=
 =?utf-8?B?NTVuVXB6Wi9GNmt0WlY4UWFqRDZPcFBpaXBqVTl1dGJlOWtxUDhEbW9URU01?=
 =?utf-8?B?MWFyWmxZRUJHb3dwQ2xkZU40VjdRdDF6OW1sMDV5b0NTRjJ5TGJWRUh3TmJT?=
 =?utf-8?B?ZGZKY3FZcUUyT1lUNFVCeFU2QlpvcWtGWlpralJCVkpKRlBkT28vYkI3RHcr?=
 =?utf-8?B?blZIOFFyWmpjYkJKMEhUSUpDeDFCUjlFSFBpQmRBc0xUblZXNm94SHVTVHBX?=
 =?utf-8?B?dTdtNjZJUzQ0c3p3R25XdG5wamQ2elUrOHhHWU9WSDFrZlNzYWMvdjJGdVIy?=
 =?utf-8?B?L1BHNmZTS3pWdnJVZ3RZTXUrWVRkeFlPbk96MW5SbFBja0NNS2xkUGdBQmpx?=
 =?utf-8?B?ek1nVU9FTjlHY3RhbTlQc21HQUl6ZWtYWW9BUUNPNkY4RFpyemNGU3lmWmJO?=
 =?utf-8?B?QVkrcVQxLy9aTDc1bWtkY05WNXB0MEZmTmtEYSt4MEhIRytQLzA5QXRBeExD?=
 =?utf-8?B?VVpTZlZ5bCtYN3NjWHhpcnZMSE92ZDBKbWVNb1RZcXREZkxFUUZQc0ZpaE85?=
 =?utf-8?B?d2YzMWdsVXlWTGtsMVJuOHlKRWt3M3NqTnhrcEZ4bzFhN0hlZDd6NXBlMFJ0?=
 =?utf-8?B?VEp4OXBZRGFYSUREdTdQUmRObXp5SjlOMUR2R0djaDJGZmVYZ25WRzZCODE1?=
 =?utf-8?B?LzBsZGhNREdmQ3JnVnFEaUdnemdZYlM0S2dLVU1hYm55Ym9MN0dFb1BzQjVh?=
 =?utf-8?B?YUtaemFiMjVtTk5QOVZwdXFUUEJoSUg4NE1SZytuWno1bEV4bWVtWDV5WkQw?=
 =?utf-8?B?bW1XbllSVzVoK2VTRXhZR2tXd1JhTnIwZGw0aXBsY3BOeFVkR2dMSjE3eEhl?=
 =?utf-8?B?MjNYTTF5TkQxd1dIZ2tvZndjaTlJQ3RCYzNveS9YN3pqbFVmMkZ3SGtudkFX?=
 =?utf-8?B?UGd2TFAvYUhzYy95WTFrMElKbHdncFFGTDFhUkRLNjhZRVcvWkJHZExBd2or?=
 =?utf-8?B?VS9YWDF3NDNjWmdGNGNjczRKaHRKTEhHWlNQeDFoOU9NVnFtSkdpbUZOOGpD?=
 =?utf-8?B?amNGcWRmbHAwWXBpUnIrQnAvYXcvK0M3K2x5U3BCYmZsTEF3anpzVURFWGpI?=
 =?utf-8?B?Y0Z0WXZjS2lJZjJJWFQ4K3NSVER6ZVBTVU8ydkpxZ3ZXWnBuS3ZHNVIydWtP?=
 =?utf-8?B?d0t3M2hLOXQzai9PdXBIQkVLTjJSZjl4MDI5VU04eFFSMk1CN0ZzR01Pa1kv?=
 =?utf-8?B?eEVJTVYvbTNoOUYrSVNESGZuYUt2S2w3OHQrMTNYQnNuUC9QSHpkSERkaDBB?=
 =?utf-8?B?TXZ5NkEwTUdDMFk2WisxWXdBQkdVWGhteS9pY0lNUWJDMG9neWFIbTVwTkJr?=
 =?utf-8?B?YW9FQUVBNllUZVMwSGNtVUl3dkhzT3hhK1RyTVY2U0F0blF0QldOdHptQ2tn?=
 =?utf-8?Q?rIYfpbMXJf1sG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1291.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0VENU80MVJSV2F0V2xIVS9CUE1BNnlxYWdEZEI2cjNjbEovYndUQ3c4clJO?=
 =?utf-8?B?UHVpUDdOVEx4UGZkVEhDd1RlS3ltT29XMmZ0eG1KNzlSYzY3NHJaS3BGQUs0?=
 =?utf-8?B?VUJyZWkxOHZxMDZKUDZ1dmFyRXNPVlBYcFBtNXh3SG5KZDA0VG92dHdKZzUz?=
 =?utf-8?B?ZVgzOCtpRUdveTBhcWUwcWRFamRROUoxVTV4ZG81cFE2Q3JlRittTGMyYUhL?=
 =?utf-8?B?QlQzMWFmWWM5STc3dlUwSHNQc0lPRFRLc1RKWXlleXZ4OGlUL3N1MFlvRGhk?=
 =?utf-8?B?S2YxR1lWdmtITER0R2xsMEpGcGRweDRZb3MvQTBJVk40cy9BUVg2am9wY2VQ?=
 =?utf-8?B?a2FLa2I4ZGNNS3JRQWpXU1VESnRlbG11NEJSeFBsQVdFcmFDbEdSMU5aeVNq?=
 =?utf-8?B?ekFPV01LZm0xalB5SVNGS2dVb0xENWJwV2I0a2hiaC9Sb1RYdWp3VEdCZEdu?=
 =?utf-8?B?T2tZU3BSTDRSQUI2dFF0SytMZXoxKzl2Mms5YTFyWkRTRHdCbnY0T0I5empG?=
 =?utf-8?B?Qjgvb0FmSlRTbE1pQmRjWWM2VHlFdWRCQkRYeGI0bnVsOTB3b0FWdVYrTW1q?=
 =?utf-8?B?SHQ5dy9hREttS09LOU8yUjBCK3lLbEl0d2ErYkRaTUE4TUtCVURyZW5FbFBV?=
 =?utf-8?B?K0tqNUFUWkdVc1Z3WHpNZmI5a0RVNVF2Q2NxLzQ2RndDQWpRcVYvYS83TytL?=
 =?utf-8?B?L1hIZzB2Mk8rZ3E4TkwrQkdaZkxXcFNLK1YwYTJUSGFDRmhNaXJ1VXNIUml1?=
 =?utf-8?B?SlVXcmZkZVIzYTdCeDIwS2orVFM4bmZtdUpTc3BSQWoxR05jWC9nanFMcHFt?=
 =?utf-8?B?c1R0amV1Q1lOVHJzSldzVjZLckVsOWEzUG9OUVFUOXBmeDNTNlZpd1AvOExT?=
 =?utf-8?B?bVBsZEFWSDVNMTQ4S1pQaVZhK2tlRy9aeVVpRlFzRzVtMUFzRDZISlErSjd4?=
 =?utf-8?B?d2Z0Wk1RaVBNZE1pUDFvUS9VS3pUZjVuTUNmU3JydHlGRXc1amtVVGszSDBo?=
 =?utf-8?B?aXRvK0VlZlp3T0VXUE9KYmRUbnlLcldGT1RpdFoyeWRyNVczU0RtVmJ2UWI1?=
 =?utf-8?B?RTdncmxxZkFwQXdld3VibmVicStPVHZyTnFpekRLaTNzeGZiS3N2NzQ3OGJ4?=
 =?utf-8?B?SmdRczBXQlg4RkE5clJieEFibWdtdC9hUUllOFd3VTN1UVI0L00rajE2eDFP?=
 =?utf-8?B?Y3JSZnFDSkYwV05RdVJXUGZMVEVYalh3U1B4VlE4Lzc2Y01zckFFVXpmcWJy?=
 =?utf-8?B?N0poQm5JOFdPSDMraDRZYWRycW1TS3VEZGlJQTFPN1d3NjVYWkxTemFNTjFt?=
 =?utf-8?B?b0VVZjNuOExpc3F1YlBBWVhoZzVrMWhtd3R3TDBCQ2UvOExRa1llNVE5RE9o?=
 =?utf-8?B?NXJ3dGw2dGl6VWNvdDdjY2VneHhDU1JXdmJSMHdJU0FmeENnSHF5bXRhREx6?=
 =?utf-8?B?ZysydURiWll5Mjl1eldsa2JaOExtSTlmZGhlUGZxZjRGS09PU04yR3p0TDVQ?=
 =?utf-8?B?TkMwUUdKcUN3d256d082RzhKai85ZFlaWFg2WWIwamZtYnRlekFpVXlDako2?=
 =?utf-8?B?UkFibTNPQmF5dytQdUlaaHU3aE5kM3JYZnc3K2VpTFZaMVM3M1R1eUdrWDRV?=
 =?utf-8?B?UDdyMmY3ZDBVZFcxanREYWRiajdtUVpuZk5DUWRudyt2NGsxb1lOSWFabFd4?=
 =?utf-8?B?N1dLVmM0azZjc2VJUzdFMFdVUmp1ZTZudFNFRDNjZmdpMHZTY0orR044YVg0?=
 =?utf-8?B?T3Y2czc5UEsvaTVZOUNDQjQxOVk2QXgrcDhKWkp0MzU4Si9JSnZlbnpGQTJ6?=
 =?utf-8?B?MlVsYzFhS2xBV1Zkb2Z0clBmN25YdXlYVzFzWmlJSkJMVmpXZDRGN2hCMnlj?=
 =?utf-8?B?UFQydkdORUc5VElwS0tVVHdPZnhXSVFqWi92aE00WExmQno0eElGRHhMY2NC?=
 =?utf-8?B?N0pqSzYwNklNTWdkdzMzYkdUVmFOQllmUENsQ2EyenkwdmVDaWh2TlJXMnlG?=
 =?utf-8?B?S1Z1eXpSL2I2SW9FL3N0UDZQNU9iTWpmTXp3YUl0dVMrYkFTVnMrVG8vTTY0?=
 =?utf-8?B?b1cvalJ4dWVNUkdBTmd0N2VyOC8vQmloRlNFVllSTDVGM1kyTDVtR1p4Y2ZP?=
 =?utf-8?Q?s/nJFkR3jemWm/4Hraao7ipqb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1291.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb778d9-ccfa-4d00-c1a3-08dd631e24fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 17:32:07.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhQJZGaCzx66bpAeH7y/KqRU3xC6gcYbj3O/87EYSMhXagukj8fYKYaktDQ2y+XgBmuCLzIEVvy8PqjrNimaCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3455

VGhhbmsgeW91IHNvIG11Y2ggZm9yIHRoZSByZXBseSBhbmQgc3VnZ2VzdGlvbiwgQnJpYW4uIEkg
d2lsbCByZXBvcnQgYSBpc3N1ZSB3aXRoIHRoZSBsaW5rIHlvdSBzaGFyZWQgYmVsb3cuDQoNClJl
Z2FyZHMhDQpIYWlmYW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBicmlh
biBtLiBjYXJsc29uIDxzYW5kYWxzQGNydXN0eXRvb3RocGFzdGUubmV0PiANClNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCAxMywgMjAyNSA0OjMxIFBNDQpUbzogSGFpZmFuZyBXYW5nIChDZW50aWZpYyBU
ZWNobm9sb2dpZXMgSW5jKSA8di1oYWl3YW5nQG1pY3Jvc29mdC5jb20+DQpDYzogZ2l0QHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogW0VYVEVSTkFMXSBSZTogV2luZG93cyBBcHBsaWNhdGlvbiBJ
c3N1ZSB8IEdpdCB8IFJFRiAjIDU2MjgyNDEwDQoNCk9uIDIwMjUtMDMtMTIgYXQgMjA6NDQ6MjEs
IEhhaWZhbmcgV2FuZyAoQ2VudGlmaWMgVGVjaG5vbG9naWVzIEluYykgd3JvdGU6DQo+IEhpIFRl
YW0NCg0KSGksDQoNCj4gRW52aXJvbm1lbnQ6IERlc2t0b3ANCj4gT1M6IFdpbmRvd3MgMTENCj4g
QXBwIFZlcnNpb246IDIuNDguMQ0KPiANCj4gUmVwcm8gU3RlcHM6DQo+IDEuIERlcGxveSBsYXRl
c3QgT1MNCj4gMi4gUGVyZm9ybSBXaW5kb3dzIGFuZCBTdG9yZSB1cGRhdGVzDQo+IDMuIERvd25s
b2FkIHRoZSBhcHBsaWNhdGlvbiBmcm9tIHZlbmRvcihodHRwczovL2dpdC1zY20uY29tL2Rvd25s
b2Fkcy93aW4pLg0KPiA0LiBJbnN0YWxsIHRoZSBhcHBsaWNhdGlvbiBieSBEZWZhdWx0IE5leHQg
U3RlcHMuDQo+IDUuIExhdW5jaCBHaXQgR3VpIGFuZCBDcmVhdGUgYSBuZXcgUmVwb3NpdG9yeS4N
Cj4gNi4gQ2xpY2sgb24gaGVscCBhbmQgY2xpY2sgb24gT25saW5lIERvY3VtZW50YXRpb24gLg0K
PiA3LiBPYnNlcnZlDQo+IMKgDQo+IE9ic2VydmF0aW9uczoNCj4gRW5jb3VudGVyZWQgYW4gZXJy
b3IgcHJvbXB0IG9ic2VydmVkIGluIGZvcmVncm91bmQgd2hlbiBjbGlja2luZyBvbiBIZWxwIERv
Y3VtZW50YXRpb24uDQo+IA0KPiBFeHBlY3RlZCBSZXN1bHRzOg0KPiBObyBFcnJvciBwcm9tcHQg
c2hvdWxkIGJlIG9ic2VydmVkIHdoaWxlIHJlZGlyZWN0aW5nIHRvIGVkZ2UNCg0KV2hpbGUgdGhl
IEdpdCBwcm9qZWN0IGRvZXMgZGlzdHJpYnV0ZSBHaXQgR1VJLCB3ZSBkb24ndCBkaXN0cmlidXRl
IGFueSBiaW5hcmllcywgaW5jbHVkaW5nIGZvciBXaW5kb3dzLiAgSSBkaWQgdHJ5IHlvdXIgZXhh
bXBsZSBvbiBteSBEZWJpYW4gdW5zdGFibGUgc3lzdGVtLCBhbmQgSSBnb3QgYSBsaW5rIHRvIGh0
dHBzOi8vd3d3Lmtlcm5lbC5vcmcvcHViL3NvZnR3YXJlL3NjbS9naXQvZG9jcy8gaW4gbXkgcHJl
ZmVycmVkIHdlYiBicm93c2VyLg0KDQpNeSBndWVzcyBpcyB0aGF0IHRoaXMgaXMganVzdCBhbiBv
cmRpbmFyeSBwYWNrYWdpbmcgYnVnLCBhbmQgYXMgc3VjaCBzaG91bGQgYmUgc2VudCB0byB0aGUg
R2l0IGZvciBXaW5kb3dzIHByb2plY3QsIHdoaWNoIGRpc3RyaWJ1dGVzIHRoZSBXaW5kb3dzIGJp
bmFyaWVzLCBhdCB0aGVpciBpc3N1ZSB0cmFja2VyOg0KaHR0cHM6Ly9naXRodWIuY29tL2dpdC1m
b3Itd2luZG93cy9naXQvaXNzdWVzLiAgSSdkIHN1Z2dlc3QgdGhhdCB5b3UgcmVhY2ggb3V0IHRo
ZXJlIGFmdGVyIHNlYXJjaGluZyBmaXJzdCB0byBzZWUgaWYgaXQncyBhbHJlYWR5IGJlZW4gcmVw
b3J0ZWQuICBJIHdpbGwgd2FybiB5b3UgdGhhdCB0aGUgbWFpbnRhaW5lciBpcyBidXN5LCBhcyBp
cyB1c3VhbCB3aXRoIG9wZW4gc291cmNlIHByb2plY3RzLCBzbyBpdCBtYXkgdGFrZSBzb21lIHRp
bWUgdG8gZ2V0IGZpeGVkLg0KLS0NCmJyaWFuIG0uIGNhcmxzb24gKHRoZXkvdGhlbSBvciBoZS9o
aW0pDQpUb3JvbnRvLCBPbnRhcmlvLCBDQQ0K
