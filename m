Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2109.outbound.protection.outlook.com [40.107.116.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547F2E9EC1
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077396; cv=fail; b=U5O85raOiNrFhFS+6gnBO8ykpmz0tIoLxtc2N/tn5W0zaO0Kvf5zFyo1FKaG1FwO4+Bg8aD9pn7sEYECzY0wHuPbs70B4LRcTH6LQCWz0X6i6gMlDt7+WUxzSr0xPM3BJzckKuRjVk2ydvpzP8JvWFA1QArMTILKPDXuZfn7dz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077396; c=relaxed/simple;
	bh=SJ4VMKXsCkAq9JFQUZnoIqgVaUSwsKjmY8bP4ds1+vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDBRl9qAkgmA11OOS3ElCMmmvGt2BjMcLJ5LbnQPqEE5pEPAjvyKI9a3h56DGPAaYWiIg0RpVqJ8ex/eBrpp6g7F4PT9ueL3irUxUao0xw+X/X6v/UseD3Rarh8TUsEE56NwATQ7EE06HNoQi0ulOLPofg4AsIIab/zoxzrDIQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=FFIFkp77; arc=fail smtp.client-ip=40.107.116.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="FFIFkp77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpaCqKXfEhJkOCWIi3/Ahx4htEuUEJRRTmcDnFLwc/3iUFrlopO0pnfeJ98myYidYYSo92nZoql1aEDlljsteFnftEOO55+2xW0HOVH29CS+eRZIZqAXMLLBRqCqUs0bzpARgTnUBEjn/omCGm/D48MYwYsZ+DKWf3C+PzQ5Gs4JvXoyF1/b+8RthH1+D41BMBe4OiYha6qgIu2Bkc3pYYoOTg2wIGjz7op/S14XWVs4+esQuDXFd41mpsjICZfNEnmul+NPKEOsih9p0VROuurXKUYCuFHyMt/EhLOAys3S0IJoGVJ8Ohy+kB1VduisCdaZuyi1O4DAzsPFdH+DHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ourv7bWed5SWzZKpCPy1hz1A2ABvB92QrXdlXTFuvJU=;
 b=axlH6Nl5YV5pUeK63Tt/eP6zGstKQ+jeLw110IliPsD00kWjzcKY/ixJCkzAMXo9A62o2bPiySvLy0lqA8fmpMbPIn9BnwZRWAqGUdA+cGBpeKgk6lHSWom8P7R6Y0jXTmZloBJZMKqMm3myjF0WCrTHy0QWThX6IBkXt7PUxFMLXJefFOe9fqS9lJXQ93uo3eQujrqIy2BgDlYbhEq1Knd1CCDGIV+XNFKjCF1SR36cZeKYN83tPibxFsWQVTe2nzgvTFGHUTDvCss3+D9+ZekbKoJYznysdULKVnwkDvexRbp1ou2dTHVg7lOjGhhIDHIjXsIXXQKtEYEYfDyK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ourv7bWed5SWzZKpCPy1hz1A2ABvB92QrXdlXTFuvJU=;
 b=FFIFkp77BQHU6MkfdLW6lV2UT93sEqsSJEHxLhIhDRgf1eZyUoJgyCf+ZthZPreVony+uqhFgTSGJ598JsQajlYRSYw53IkZZo1Ub5jemRG5xcv/DAK34VIPZmC7lvC6t2+tzjnSYQnOIEnHipigl25auGLW9SZIu6Xi5xognFxR/8BnEX6Odob5WMcmZSFf0+6Y0iTsqmMh42HtN5w9w2lg1rXbl6DswRVUFPhr0+dBUDvntd+HJr1hzIyiSUiGvBu9Mw46RBfwjfDXr9Y0GwgG/Sa32DZ0EVJJkuVQxcaWaB81Xb9qRcErAZihbK7LvzBTCjUcKXfKu17chVy3kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT3PR01MB5511.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:63::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 16:09:50 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%7]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 16:09:50 +0000
Message-ID: <5733c746-96dd-4375-8a68-5b42934ded45@xiplink.com>
Date: Wed, 9 Jul 2025 12:09:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: gitk: visually indicate whether a tag exists on a remote
To: Chris Torek <chris.torek@gmail.com>, Adi Shavit <adishavit@gmail.com>
Cc: git@vger.kernel.org, paulus@samba.org
References: <CAEWUs4iWwrOw4sXT9PhdccZyWtcvTgQfHDbeavTk-2kOdjUMdA@mail.gmail.com>
 <CAEWUs4gEsASB3Fog2Zc5tEfACPURjHPqaS6e2XNWj0i50O-e5Q@mail.gmail.com>
 <CAPx1Gvd+XwN1YbbTiVCM-6rSr=9o5mB+T-=c8x5gpLkUp_hZ8A@mail.gmail.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <CAPx1Gvd+XwN1YbbTiVCM-6rSr=9o5mB+T-=c8x5gpLkUp_hZ8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::25) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT3PR01MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bffd4d7-e36e-43cf-5d7d-08ddbf03081d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3JldFErMFpKOW5hVUY2aFQxUmV1MTFtUWlqU3BQUXlFeHlXZHhGMlAxSE1L?=
 =?utf-8?B?TGt2akJsS0ZTSG1leU83U3FFTUJwUTRRWGpWU3VPQUtPZFVSaUNCbDkzbjNj?=
 =?utf-8?B?RnJ5QXdKMHBqYU4vR1g2dFdDN0pNUkYyYUpIdkF3cWVRMGpoSXhTWG51OG5w?=
 =?utf-8?B?ZEYyNDcvRm9WZTk3dGJ3YUV4amUvekVPK0ZMWGtBdFRaM0doR08wbTBoRmVp?=
 =?utf-8?B?Y00vaXJJU1lqc2krbFIxUnhrL2hpZVE4VW15UjR2R0ROcU40eDhUVjcxUTFE?=
 =?utf-8?B?eHhjU3NCdVM3VVcycmJyMXkyR1EwVC9Zd3JJcTNLNnFxcUNRc3A0Zm9HZWpH?=
 =?utf-8?B?RTVuQzQ5VnVPMUp6YWN2c00wQk9JTTJoWVFDR202YVNvMmtHTzFsUThlcGZN?=
 =?utf-8?B?end0RTBtYlY0VmhRdDYxQ3hBTU82MXdQNjE4enRrSEhma2x2bzc3ODIwbUI2?=
 =?utf-8?B?aHJyMEJsajNpaTJIKzdpOXc4L2VDZTIzczBzVnFFaE1XT2ZBakdwY0haSmQ3?=
 =?utf-8?B?Y2xsMDdNdFlGYlFoa25tZnliR0ZRNllvaFpoUE9lVHRPRVg2b2RmeWdLb0Jk?=
 =?utf-8?B?T1ZRTURPTlh3M3Z0d28xaWFxZ3RwRjVPQzFaTjFpM3kwU2pNYUJOVllIWE5B?=
 =?utf-8?B?NnVUVEo2dERKQXRFUjBsQ3I5N01BUENtR0ZRL1F3QThuc0dLNXNscnFJQTdS?=
 =?utf-8?B?NVM4dlNURVM5TGZHZ2I3clkwWitwdE1tUGRJU2NPN1VocWphMTVnN29YeXR0?=
 =?utf-8?B?MnQ1TjhPbVpBR2R4VE9YLzZjNjl0SlhXSmZTNWFFdmRHaTRKd0g1U285NGNK?=
 =?utf-8?B?MHdrSmpoWGdOWW1XM29XRzhidnF0ak1DSlZjZTBkUGQ1eXRRd2pPa3hibnkr?=
 =?utf-8?B?UWNhVDdRMnpNbTB1RTJBMEVFU3JBUFYyQlR2VXZQL20xckdha1d0RnhaeXZK?=
 =?utf-8?B?NHAzanh4S0cyZTBEaENwRFZTaHkvdXZ5VVRvNlRiN3ZnbnpXTUJuM0hzLzR1?=
 =?utf-8?B?WENjazg3aGcwTGE1T29tYkhBMzM5WHlWNlJqNkk1UWpUSlY0VmJGVTJEUXRP?=
 =?utf-8?B?YnBsQmxtcVA2aGdOWDZpQ3pZWE9IMjVNWnpkaGpIWHVCRTB4UWgxU1AzaWg4?=
 =?utf-8?B?cW0zU3pvM3owbEdRQ0N0dm9ySHplWE9Xbm9wTEtxVzFEUlk1SzR1UTdyNjJx?=
 =?utf-8?B?UVBNc2lubklFL3ZRQjFjV2VxR05iWE9KaityaktjcGY5cHc2dUhaNTRMMS9T?=
 =?utf-8?B?c0lIQ1BXckIxTDIzNURXVU1GU0Evc0FpQ2s0L2xGelBLdWtmdjFkRTQ0cVlk?=
 =?utf-8?B?S0JrcUloZnZhOXVWMnhqM1VGU2ZPNzhIMjZyS0Jsc0t0ZW5PazZyZzBobG5V?=
 =?utf-8?B?S2ZXMzVId3liZ0xwVkVTVFdRR3pyMGdYVXZXelB1L2cydVZXcG9qMi8ySFNU?=
 =?utf-8?B?RW1JWjBVQkFxWTVXRTV1OHJndjZVOFlJSDl2TkxXUTRqWkY4NlVRNWR4RTJt?=
 =?utf-8?B?cGI4MFZ2UyszcVgxM1VoRmtXQVUxc3hNZHlsQ0E0MEJPWHgvV1o1dStZZ2FM?=
 =?utf-8?B?THAxaXE5UHk1NngzV3F6M3g5WDUyemlwZ2JWbmRlSWh5TVp4a1F4Rkp2cytj?=
 =?utf-8?B?aHduUnBxMlNUcXVTaE11Y1VRTXlySVk1YnJZaXg3Y2lPdVk0MmxDeU9sRzly?=
 =?utf-8?B?TXlLS09sK1dyRnZMRy9DVXZUR2ZBR1hkRzc2d01wekhHZlRwbXZsa1N4RDFj?=
 =?utf-8?B?Q01XMndTTFRBa1kzRmJDRmZ6Mk5aaEd2am1leFlaNTFRVWUvQ2kvZTkrS29p?=
 =?utf-8?Q?pb7YbjjeH9dx1XT0u0+/orqiBTLhiSi7b+hJM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHhxTW1jcjRTbWxQcHlJdFdqYzQ3SWd0RGJhVVRjeE9ZMmx5TlYrbld6U1hM?=
 =?utf-8?B?RlFHbW1FT1Z5S3ZEMkdIb2pXZVNDUWd2U3FUZldwdVd2SjNXTldHRmlDNTQ5?=
 =?utf-8?B?RmpaNGhLODNheUhOVFE5WXY2RVl1MXQyMmVNUVc0Q0ZOMlVaUEhYUngwd05E?=
 =?utf-8?B?Z29PU1RDOEZ6aktZdFVHd3AzaWlGYTlvOXgzK05leFZDQUMzdWNDTG04UkVU?=
 =?utf-8?B?Nkk1VS9TVUJIQW9Td3Z0dnlPY0xOZkpYd1k5LzBxdy9keFpNZUtTSWVocXI4?=
 =?utf-8?B?K0o0V2FlU0d1RTF4SzNwblpnU242MkVKWDlSaXZ5MzFuYlpoY1JWaWExYUFy?=
 =?utf-8?B?OEZDWHlqSkQ5NUprUU5YMG9aQlhLUVVGVUttSlJHU3VnZ0hralhXNDBYNTM0?=
 =?utf-8?B?aVZ3U1RnemN2dmNZbm52WFhvSTJ1N21ReVYya1NrYTNZV0FRdmFES0ZLMExk?=
 =?utf-8?B?cEZ0N0FVcURTa01rZ04xeGczaUZCZExNS0cwZitnN3lHdk0yclVWTTA1T3hu?=
 =?utf-8?B?aytDVkdhYWFjRS8yU2JmVWJ2NmxMVmtyUkpLZ3NLVUtmVTdrL1ZhTFJzbDU2?=
 =?utf-8?B?M0UvaWVkRXR1WU9sc253VnhpME8wZDZzaFZvb2trSEM0ZGxiai9vd21aMGdl?=
 =?utf-8?B?MzBUd2FvTDMwdVVXOFZvZVBGdi9SZFVHVnhZZTVOblRXOGV4Q21FdEo2QVRZ?=
 =?utf-8?B?VGNPSjVBVlpIcVRkNW0xa2E1SWlRdUxxUkIvMk1XZlFmdThBemJKRzMzNVkx?=
 =?utf-8?B?Z0UvdFEyNXJWdlVNM3NWckFXWXU1dTh3RDNqZHB4WHE2UlRzQTlXYlBkdmZ2?=
 =?utf-8?B?UE1WNm1sTi9zOWxGaGhsN25oV1hiK3FqbGUyZ3d6d09IRzk5WFgrVDc4LzF4?=
 =?utf-8?B?MDltZk1uclQ2MzlFTEhUc1Q4MG5YNWhheFl3b29GZkNVZk1BdEdSQ0NrVk5p?=
 =?utf-8?B?R1Y3M0V1SmJPSFl1cEVwdG9vanJYU29YRys4UVE0dGVweFVVa2RZU3ZIRWVt?=
 =?utf-8?B?NmhERVNNd3hLU0NzZnNBOU45WitTK2RhWFJrRWFEeGFvenVLVW1yUDZCNHdF?=
 =?utf-8?B?N3dlK1ZVd2p5UzJQVDlCODlHdGlUcDM5YkhwZWg3SG5zR2tXM0czQm14Nlpt?=
 =?utf-8?B?MlZTYUlSWExHNDcrQ2k3eXdZTG1GN09RSFNpcytCRWNUd1ZucUxXK1dKVmk0?=
 =?utf-8?B?eFpWKzZNMWR1WTNBeGptRS9BbXI4aTVCQk84a3owMUJQbk42aVVWbElqWXZI?=
 =?utf-8?B?OWZaVGZUR0gyZjJjUXBJV21wYUZZZTUxeXFzSmp0UWQ5cDVma1Ird2NsbXkw?=
 =?utf-8?B?RVZIRHB0Zy9XcmpVWjFLdnVrTU11M1JROG5rZW44WEg0MnNFT3RrdmJaU3Uy?=
 =?utf-8?B?azJqU1NDMWZOSDMzd0wxbldXTTgxWXkvZzAxWHkvb0dGWGdoYUJueXZnVnZ3?=
 =?utf-8?B?cHZrVzlYdDB4N1Fsd0ZEVnhpWVNjcDdiN2VXMXBLOFdWRmlXcjY1Nzd4SFlW?=
 =?utf-8?B?ZjdBQ1pGMGxMUGZMYUt2Zldja1pQOVpDUlBmbXBOOHFwREwyeGJzcFFGR0VC?=
 =?utf-8?B?aUluWkl4dTJQM1A1ZmI5MXJ0TGJSNkJvYmFlNGtjZUd2d2t6bVZQWmw4SGRk?=
 =?utf-8?B?MDVVRk1HVEoySjQySGlOZVN6eFdSWFVieXp1dnZ1UUYwV21odjhqMnhtM3N2?=
 =?utf-8?B?OFM3anlMa2tBMmxhanJNdEVBcEE3V3ZzM25MZklCM1c3VER0d0xkbzhEUlRJ?=
 =?utf-8?B?d09vK3JVWDQ4a1djdkdORHFNMndORm4wRElDZHVUOTVqQnZPeVFxUmZWWlo3?=
 =?utf-8?B?UmNKYWlwek82VXpiSVNNYVNzOE9HVDlIbmRaRDJqa0QxWEVpWGxpU2pCR2o0?=
 =?utf-8?B?bVd3L1F0dzhmSml5WVVReUtDYVFSL29QWnZucDZRbWppZDhWNzJqaFF4M1lw?=
 =?utf-8?B?V3FMclc0SEpxTFI2L2U1TGxJTytwVHlBK0F2dVBET3NGNU92VDBBcmhqUDRu?=
 =?utf-8?B?QmkyK3AyaDgycy9mZ2ZFZEEvZVhTamg5L0NQOFgrZDNCYnNVNUxoeE1wekl5?=
 =?utf-8?B?ZmJGY1d5WVMrS0I2QXBUV1FIRml5TGVTWU1JZz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bffd4d7-e36e-43cf-5d7d-08ddbf03081d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:09:50.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwayQpvzvBO0sbpjM2ZSGMFHZ6E25k7RgiG9U3N6rd+t9pa5m0/82FuyT51PwVqYklszA4O5Xzh4SnSlc1RytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5511


On 2025-07-09 04:45, Chris Torek wrote:
> 
>   * collect information from the remote during `git fetch`
> 
> The latter would be possible by adding the concept of "remote tags" to
> Git, but this is a pretty big change (not technically difficult but
> probably controversial).

This was discussed long ago.  See:

https://lore.kernel.org/git/201011040149.47968.johan@herland.net/

and

https://lore.kernel.org/git/CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com/

		M.

