Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021108.outbound.protection.outlook.com [40.107.130.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DC2B9A9
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008442; cv=fail; b=IltR9F1ntBydPEtEMA5P8e1pgwMvmq+pv6DwoBziHK/hnNYb58/67z0oiHbeGVo7d8plGZ8uCmIr8NEzgsTUqat1uLyFdz3fk/XnhKmdEDdgpvm7aANWzHtGdr+IMQzI+K4+3oKjFf7zaGU2qViozzymQhMsOAszXhyEt5a1EM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008442; c=relaxed/simple;
	bh=zesq5XfcCxjgFxDFb4BmpCCr3YlZgdaQaUISkrecc0g=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=KrnE3R0HshxWrXUM/CAQ0PXE3bWaCGsAGpGnJ+OnE9JlN1CAj4+/iTJEMj+kln0rIgqIMqZeOGSjmbr4tZVpWgMoDfxpLNC34qf9PNaAp+eMEA567N3MM3cLC9srNm4uqPHxrY08k+UM9vKVenAVWA1Q2EYcGy2jjwai+5OJXUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wszib.edu.pl; spf=pass smtp.mailfrom=wszib.edu.pl; dkim=pass (1024-bit key) header.d=wszib.onmicrosoft.com header.i=@wszib.onmicrosoft.com header.b=T9e/73kc; arc=fail smtp.client-ip=40.107.130.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wszib.edu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wszib.edu.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wszib.onmicrosoft.com header.i=@wszib.onmicrosoft.com header.b="T9e/73kc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqzvvosbRVD5w+RdQlDlThy8uOdKQqvVf86G5jYa/RwuKVFBDJV5JFVAuJ/q9CKQ6QRclR3ndUEMsumA3c2XrAEnBknyhYdcWGGkTMgTSqtw05FJ33pTVW2obEutuCgXWtGOrdY/n63MOacdEUTUupAdIj6auHOSuedI2UC1XqxSslPCUYcnaRlIa4SAQRMrkpuRTvLei8P4FLffiqZId5nxjvAn5IBUeOrJ8ToSFMbP8wbtTP8mIVHXloPWehMtnUWYgb7sGezwSHXiBfruk60wWeF59yS3sGbsESb99EEP+u08x6OgNo254b8vWwyck6GcGSXVsL4tS3qyUjWrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SRQdDnuXwakSbbP+HlG6VCA1aQlnjubJShHatmAsUw=;
 b=Ds4hbHmuAh+SXUKiyUvdUDSrzNzYQUblJt1Sel7H2n6Yj6OaLHZr4M9owOPk4A+jS7dbMNfw05CrT81SaZDKU94a1CWPkfD2WoxJ2pocd/+UyEOiuiMxob4IV8plfdVyXcgu6+V8nlfHc5UyvrFPjI3YuQrM/7n1lIFEfzpwvG9zMJfylsGG5GwaQTbAVL/r68XhBRH6Vetq4nR+YS0OhsHr9N8MXAp6189RX3zfRcmVoIKJvW1Z0ndv7+Js0oBaLQeQTSuJCRyZlqhhQD6VqFM/UOk16dXxNOd0f7DxeZ2a7V8nOUqwbbi1X+6sx0F7+OuC1fi1EtImUCaDrViFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wszib.edu.pl; dmarc=pass action=none header.from=wszib.edu.pl;
 dkim=pass header.d=wszib.edu.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wszib.onmicrosoft.com;
 s=selector2-wszib-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SRQdDnuXwakSbbP+HlG6VCA1aQlnjubJShHatmAsUw=;
 b=T9e/73kcesomWo6cU1r3Pmqkz6uUDQ/UOkWI7Qz6xzVPFMNYov//Rzozi3Rs4s9YXkYPEikkSUjj9Uee0Guo6PRoDQQNMo0kDlpPYblIkYNhCGG0rgdZScQnwSnO1JRiDxqCsra3MPTTazFCoT07Iu1GWSE4BU8zRimDlTbZ3yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wszib.edu.pl;
Received: from AM9PR04MB8700.eurprd04.prod.outlook.com (2603:10a6:20b:43f::8)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 10:20:36 +0000
Received: from AM9PR04MB8700.eurprd04.prod.outlook.com
 ([fe80::dbdd:df26:dcb6:16a7]) by AM9PR04MB8700.eurprd04.prod.outlook.com
 ([fe80::dbdd:df26:dcb6:16a7%4]) with mapi id 15.20.8678.025; Wed, 30 Apr 2025
 10:20:36 +0000
Message-ID: <10c9da5c-234c-4a40-bbff-91ba820dd970@wszib.edu.pl>
Date: Wed, 30 Apr 2025 12:18:24 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: git@vger.kernel.org
Reply-To: m.miklas@wszib.edu.pl
From: =?UTF-8?Q?Marcin_Mik=C5=82as?= <m.miklas@wszib.edu.pl>
Subject: basics - auto staging?
Organization: =?UTF-8?B?V3nFvHN6YSBTemtvxYJhIFphcnrEhWR6YW5pYSBpIEJhbmtvd28=?=
 =?UTF-8?Q?=C5=9Bci?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To AM9PR04MB8700.eurprd04.prod.outlook.com (2603:10a6:20b:43f::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8700:EE_|PAXPR04MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: b7afea2c-612e-441c-d38b-08dd87d0a5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|41320700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3JOeWZtdGZXd2xwNU5JeVdycDRESmxpa1k2bkRBOTRSUmhYQWJnQzFISFhQ?=
 =?utf-8?B?QzJneXpudUQ3bmcvNGY5aEpuTnBLK0lXaEtsRGRxL0VpcnQ2anpaVDlITllk?=
 =?utf-8?B?S3VyZDYwbDEwUjJ3ald1ZWdLdmZOaS85ZXJpQ1JMekcybEx2V1o2dDU5Q0Fq?=
 =?utf-8?B?R29VdzFWOVR0ZmxmMDI3R0l2MEVWM1J6VmY1V0NIdjVyMTJXVVl5U3AyNXdj?=
 =?utf-8?B?alJVWEowZitqVi9vRDR1NTdmaHdQNGQ2TnBLd28vNkNlTmtvTjdqSHFEODlZ?=
 =?utf-8?B?UzFVejBoMVVaaExIaktyZzlFakR1MFdxNUNvem9yTGhJU25PZWRFK2NXblow?=
 =?utf-8?B?QzVGU2g4eFlvNWsxNnBEMVVWcG93MUZJRjRwclZyeXgvZzVsS3lZMVV1S0Yz?=
 =?utf-8?B?Y0pTOEhEOVg0RWlwVzNrT09VUHd6NHIxMGw0eXo2NUE1Y0FlMEZsU1krc2J5?=
 =?utf-8?B?Y3QxcUJaV0Y4Qk5NNjNqdzR5eGhyOThEMldjN3NmYlYyQTQ0eGVWeWN0eHd2?=
 =?utf-8?B?U2x0bXZXOXJSTXlxeUh6ZDkyU2FvR0pQODE4K0JlU09qY0tkclBJRy81bTFk?=
 =?utf-8?B?MjlDU2ZaUW5DZ09hbngxeElnd24xSnJKamhpNlp0SE4vY3plVXVVVC9XbExh?=
 =?utf-8?B?THVsRk9wNFZ6amJuZWV6Y085U29Ba0xHMDFqTjhkK1VPejh3Q3FzaFZvYXlr?=
 =?utf-8?B?ZzVTNTd1UHBqTzhVR0VTQXovZkFZdnJmNDJOcjJMaExnb2VFUnhyU0t2dFMr?=
 =?utf-8?B?YW9ETm9WU2QrWFVMMEVTblc4cE1RNWZoMVhMRGRFM3o3ZU9HVVZrVnplU1Zi?=
 =?utf-8?B?U1VDbGM4SCsyeVoxZFRWc3VORXEzQWo3MldZcW1sSm96ZFZ0ZHFoaFdtZEZo?=
 =?utf-8?B?bHRqQ1ZGQXQ5cmo5NWNWNzErMDBjK3pUQVV3dUswbkZrSGZzUEl5dEJZL3Nw?=
 =?utf-8?B?VjFNMUN6YUhzaXdlNkFESmdmUkFVY0E2a2RIV1FvZXYvS2xZZFV6bUNDMFJp?=
 =?utf-8?B?OFNhZmxmcGE1ckozdWRHb2lpaDRHTkxaNVpiZlUvSVlQTE1ZcVRJZUVHZ3JE?=
 =?utf-8?B?aDNBTytLb2hrZFIvSzQxbUhsZ0pHa0tvM1UyL2lQT0xvU3prTDRnS2YycC9r?=
 =?utf-8?B?ZGw3MjV4TGZ6UEhJUEZuUFNVNnkxN0I3K1hxaUFkSUZDMWlYOTRjWTc4M3Rw?=
 =?utf-8?B?Y0lHKzBPaFltV2FYL0RxL0t2UEtzYk5mTlNkQ1VOREpUekE4S3FDUkhiWVpl?=
 =?utf-8?B?RG1RTmYxc1FRQy8wWXRXK2hVNDNXNFNwZjRWdDRDdXpjR1dFQTRBZkJhMDdm?=
 =?utf-8?B?dEtEbHorU1VqS1kvdVlsRWs3UEdxbnNFazg0blZ6SVQwdSs1ZEtwN0tGRU5E?=
 =?utf-8?B?dWxXZU9scFFhSkFacnJXSjlFREFjR1pMUkNaZDltZmxSVFBacVd5ZHBnV2ow?=
 =?utf-8?B?Z2JtcGJYamFrZzZlWWJzdWJ1dUlsTEdCbUJlOTdvdjVqaXhzSG53OFA4Vkl2?=
 =?utf-8?B?aU1qNlAxREpjZkc4Qmh0aDRVSDJUVnlTNms0VmF0amRvT214ZkZaWnFGVmNi?=
 =?utf-8?B?YkdQYTYwOTlmWFdJdmNaOTVDR0dKNlpUbHFLWWtXdjlZK3hONHlPTm1kcXRS?=
 =?utf-8?B?UExmbEJmRGhGVUVsR0V5OU5XS2YxVS9VNUNWOUI5bDUwRit2QTYwYzJtQWtp?=
 =?utf-8?B?Nm1WM1RlUlpoK05FZXRFbGNWYzZuOW5UT0JpY2dTMFRsaE83N1I3MFkrMG5N?=
 =?utf-8?B?eU9LelBsanMyR2NyUGpRYnlTTFpPZDVSWVAyeEo0K21STWozdElpL2xKSlpq?=
 =?utf-8?B?ZXQwNEcwZDdPanBnT3QwN3BPOG1BMFd5MWI3STFqQjVsK25taVRsOExMWkE1?=
 =?utf-8?B?QTBKaWFsTDZRVitlSlR5TllWMnM2UWJWU0lEUjAwelNyb29MVkhOODRNZVdW?=
 =?utf-8?Q?mOVZTVQLffc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8700.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXR0bXA1VTN4OTE1dmNhUEhxbTIvdytwMk9Xdks5YnBGY0EyMTlzMW5mUmlI?=
 =?utf-8?B?QjAzSmY2eHVEQUhRN3J3bVFrcHFPR3Z0UHp2U0M5bjBheUJoL1ZRMnUyN05p?=
 =?utf-8?B?bmUxV0hTa3hMTnNzYVJDa0RrSG5wTEhtMWxpMVdOaWd0MGp0SktXRFlRdlp3?=
 =?utf-8?B?L2dQTkxUVkF0SHBWcE15Y1pLU1FKTE1Xc05Zb1B1TTkzQkNaM2JiRFlCb2Zr?=
 =?utf-8?B?SU5mbGt4Z2FtYk1aa2RscGI1c05McFlzRXRPZGlVK21SalBEOEV6K0hWMFdh?=
 =?utf-8?B?cFBCVncreVZRVEY2VDBiWFJwc2FydzNTK1JWaW52cnRLbWxEQXVRaTV3VTQ4?=
 =?utf-8?B?S1dmYkw5SWFnbmpRRWR1WU9seFM5ZDE4MitaaXJOeFd2UnFsa0tYcFNUWVg5?=
 =?utf-8?B?ZCtFVThYNi8rbExsbkhhVUZRc1NiamxScVpweTVncGg2eHN6OFNJb2FGQWFB?=
 =?utf-8?B?Mk5XYndxbDRmL2JONkZjN3ZJVWRibDVuVU85QzBXVzMrOUV5MFlIa0MwY2d5?=
 =?utf-8?B?QkpBTi9sTmd1RGlFUXBJSk01Y3JIUlRJQlBBZTQ5SXhZSEkxOFVQQ29CcUV3?=
 =?utf-8?B?ZlBHTEd5WGRBN3RRMEhUUnZDeks0VWdmOVVBMmJBbXhLdEFuL3FUY2pObDJY?=
 =?utf-8?B?MzFhaDJSVHMvL2JVN09Jb3NoN081eXNuQ3AzUnVUdG0vcGhRVlRmUUwzSSt3?=
 =?utf-8?B?Nk80OUFlRnZwaFhWYTJsL3F2cFpjQ3RKQ3pyZEJnUGJXUWhjdFJ6ZXllT0tU?=
 =?utf-8?B?WFlzVzg1cXVEc29zRjhnNXQ3ek1McitpV1dIZ0xqenFJVTFQbVVzWFVuVG05?=
 =?utf-8?B?NnVoWmFOaFk5SC9EUFZHTUc3ZE5UZUNOZWZpVDRvU2R4VEZ0eEZYWFllSjNX?=
 =?utf-8?B?c3JoMEZpbk56OGpqeFlUYVhZcVBDWVVtaWtLOGRwNFEvYmttK0hlOUNhdHdu?=
 =?utf-8?B?U2w3VGZwMEVWcjR1Z1JMKy9scUE4QW4vQVZrbnd6YWg1ZXpvVmcxNHc2c05T?=
 =?utf-8?B?Ui9lNEVBbEZ0VThuU29JUEI5d0NTMURvT3Y2K28wM21ha3pPTWcrUWt5K29p?=
 =?utf-8?B?RHRSMFFrTkYzbFB5eXBxMEVPWUNTZ1RjbjAzLytKMHoyeGRnV1c2cTdaQ0F3?=
 =?utf-8?B?Si90NVpuZFhjbDNsUG5uYkovYnVNbS9WNnc5Wm0yNEZRQmd3NWN2QUZSQm1z?=
 =?utf-8?B?YnJxVnNtQUxWKzdzUW5QdVN2bXNOOTJSY2dDeTgxR0Z1MmMyY0VKMTlGbTJD?=
 =?utf-8?B?YXRhL01NSXZITnZ0SVl3UktuaVUzTEwvYXVhbU5JdzRoZG1uRXBGY2hubDJo?=
 =?utf-8?B?bVh1ck9zSTNtMnhFa2hacGtsejgzT0daZUJ4eGVWKzVld2Y1bGNpNEJmYkxn?=
 =?utf-8?B?Ry9OS2UrS2FPNEZzZ1ZWSzJoUGlFV0lCUnk0bVVFZ1A3T1BVcHZHRFhuWWZF?=
 =?utf-8?B?UXRkaisrbGM4cEhQWFRwUVpyalF0YkpZcmxmeFZVVVoxQ1hHVXc5S0dtWUc0?=
 =?utf-8?B?NmFpNjlFemRGSVhNTG1jcGkxd3JiMW9WQXpZZjZpZFVuL01EN1p2c09JV3h4?=
 =?utf-8?B?THF2cEpaS1F0WEF6QmN1VTVuMktIRmovYktpYjJ1VzZqUWk1MlhtU1N0dC82?=
 =?utf-8?B?K1pqcnZtWlNHdnd3NHA0RXNwSThwQi9naXJNbWFuV0pPV2swUnB5TTFPYU5W?=
 =?utf-8?B?M1JSRXlrZm1SV1dsZUxTbGN0alhFeWZYam15ZmM2UXEvcnlwSUZsLzJJNm5p?=
 =?utf-8?B?T0sxdDhKb2paMzU3ZTgrZEFweXI0RFc1dTkxWXNIbUVOcE1ZZ2FyMjB3TnRq?=
 =?utf-8?B?V0c5Zi91enpsUnJXSjZXWWNieHBSeVJxME91VjQrdkxJcWdkWjEvYnppS3oy?=
 =?utf-8?B?RkFlYUpCeXY3VVRNdEI2Q04yb01LYThGSTRUQWJxNlNhajc0ME1tUVlzNnlC?=
 =?utf-8?B?T1BRamo2NnlONENQNm9IbXdtUnJZSVhUYXdIVDQ2QnpVdGhNbkJFblJmRjNY?=
 =?utf-8?B?VFprWEhMVno5eGNlTnh1KzdTUGY1MmE4ajZHRGxwZ2hIZ3RHZEREUkgrVjcz?=
 =?utf-8?B?R2g2N3dSb3FOWUJMUlZuQXByaHE5NHA2NmNFSW51NGZ0YmlWWEJrTUttZVNl?=
 =?utf-8?Q?WcZ+wAfoSTWdxNYF3Gi5feJ8O?=
X-OriginatorOrg: wszib.edu.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: b7afea2c-612e-441c-d38b-08dd87d0a5d4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8700.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:20:36.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 785acb66-71d5-49f6-b377-37a292991048
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/BoLFvS8gqxye0Ry6dZgVrvB0brZyMS/1c75MtH5TgnuERblUqDyd4WXq8wC/Zfb6NYo8NTv2r0jwC67G7nJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767

Hello,

when I execute
git commit file.txt
(by listing file as argumentbut without the -a switch) for a file 
file.txt that I have made changes without staged them in the index, the 
changes are still commited.
Is there a way to make this work like command
git commit
without committing the changes that are not staged in the index?

Best
Marcin

