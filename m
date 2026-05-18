Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010020.outbound.protection.outlook.com [52.103.33.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038048BD48
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122811; cv=fail; b=XNLPrSKiAuMA7k36no1eXrOSWjlKgPWLgibzefG7rzKpto/kuTj3bHT2O/jR439QCRPv6HzZlNeEsLjAYlwKMPXJVCzBSJDRESZT9B6tSxMka12mAJyTdUpzledE3218jXlzJJXMd9ijgyazftMx6rk0tzu08k/zVbOn1FdaS/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122811; c=relaxed/simple;
	bh=ZSNSc5Z7D+EFGwubSLV6FkfA5FID9HuqVH1XadlAt14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lwuc16fJgTiYRGqsYLiq4Xf42BdQSgn8NB6MMIAYA6OORiVXCwZQrsYHXwnIyYOZAVs5Krog7Y3eF1buVfUCYTV/e6Dz+u8/fVdZo87xsHT+zS2RcYzun7rcgdRjY6msQ0f8vQ6qaslItyCVMsO9j3SJ2cV7uCBOvEgdvkRMZVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KBss/vaD; arc=fail smtp.client-ip=52.103.33.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KBss/vaD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXCGV4BaCaqIbmd5NKADinWbnrhcqbR6be38ydIk34fZqTB/hLwUyYYzFztvJC5oq+BXZKPUJNly8xbH9Ur144Zr3LrNQ8c2iNXsrXnaGwi/ufz+gmxFc8aGeab66hfyLlCPv61PNvMpKshaNuv0ccAJcEBvbmJazyoQ44HK7kAABrLr0Hi7f+oyKfeuOC+7gHpnebTV4qAJCVKNakClfVIebWhIJFijVTKddrVNrK9jKQgQ4hcjYdu8Wu1Q6VFCY/ssAapuNmkd2sKXJ1PxUldvosr1Sc8Tni7wWTbwF3v8JjfSyONFHbUP7QWo6ZHLmdZ+7r0R8q7PwbZkJNFBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbSY6FbkCSvDJFygbZ/GOAsNGn0d6TwFWZCdmC+mBoo=;
 b=h43B/pQm58E4IH3plzBBTPPSLM6VLkhdBnPWd1JQbxIm6OtAr91b7A3labJV8yEb8aMGcFBe4coRb15yc95FODPa0G7j6tckUIIokcDhQ4cMxNHSBY6qEsE9G2Wm2CPHVr84tsN1jPxELc46NWF97uKUHbhXhUojk74LilVNZAQ342I2IPanH/ks0opcX4g69Nezcv9fihIsmtqEikzKVOK/RJz5woRlekeWVE36LVRaXfRxRLb+5+6NNhmvtFNLsZgbUJ7qK3ivYCCLv3CQB9zUrDWjMx8tj02Gr9j3utHd3K8/LIzwFtkzbqrE2SdUHCduO/LoCVr7Fw2vTpnhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbSY6FbkCSvDJFygbZ/GOAsNGn0d6TwFWZCdmC+mBoo=;
 b=KBss/vaD9wKjdtCCTNXz+LTSreA6qgic+0kYKP7Py8NTpcqyDVyzk+R/1qOv12oKK2YdoguC2ebNL5oQlZi0wraPD3n+X2fGmF51joynWAW8KrIeYW6/aEycuEXGlXgR5jN0cXJuBLIAUfpWCEe7pC0m+oAt1P6fF+lCx65s+EI/USEI9qZ6ROl59SBRebhM7n69ETvc3nFbWU4jtRAVITRr8e2bDvbXA26saSKajgbc5JJiFAQp1Y8cjVhULWZJC85Bk72/Y1KzV/qIyHjK0rUe9MsNYtramnTlsw/wGBX4+m0/2cwVA0kLyB4in0fU0z5cYDE83Cxi/trCnpm0+A==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by PA4PR03MB6941.eurprd03.prod.outlook.com
 (2603:10a6:102:e7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:46:45 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 16:46:45 +0000
Message-ID:
 <VI0PR03MB1163495D24C68C59B8CE02105C0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 17:46:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] remote: add remote.*.negotiationRestrict config
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <a14c568a1fd3680e40b70cf9ca14fd2a5305df5e.1778762495.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <a14c568a1fd3680e40b70cf9ca14fd2a5305df5e.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0110.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::16) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <473b1496-0bcf-485d-af44-065104156cf6@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|PA4PR03MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: ce18ba18-526d-4d01-48ad-08deb4fd0bbf
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLQ65JHxOKBAnHTP2G7hs4ROKy9IhQOLqxX1KxOrU51g1Pu7lcZBEZFp7Ya3DBD8LFLQ/9z0bwIDLubTeSNqKyLLV+88N7wAdGQ1A2YZQZ+tUcXftOITrcYmGp6PhFLRpkE3wUm5fmxBQ1O4LFG2EG8O27xurxECdPSTtLYllmpGx5QLPdCBmVng6xLAzX9S/NKqWuC0yQjSc2qhETVm5RYVZ8eVWzAZZAVHEuXuNYhp1zmRnK30ux2G+9pUicoqAViuPFN8TR/MTmm1s9WtCiBDuZfFF0OQiQ82pqqZNx7MNfq+XmYl4tex6ZsJc/xL/6wliySk4ru9VWH0qdGnHir+CsnILSblukRWH8/Cc7sUJ0fBXl7ixExjP401vzoSFdQvYkVG0hwCxbWKVYZ6koPBngy6L3LojSd/fUzVCjj/yI8KZvD0Y1lR9/Gxc6kWR+JVvZzM24EXWL1OQOupBgfGwDEHaTPzy9NA87FWU3s1wT4ZOHamIY3tnDo6zaObf9SMcLlxBUZlscMGOPr4YVD+LnThPpujLQF72pFwQjpZldhPRpULtlg+6DRN+6Hb3at2UgYEr5+bBTVkiJwhVrpIUbi78tmj8cP3NOaZO/EldXcr88M5pS/sQEWRovkDqh008Na1/1RMgvvCj7gGWg9nmsNjMYi7dGcvV77zPxoeXH0sQ4OlTllema9azc8WFTZ0f6wNeaqRwYSK8d+796C7SrPwt7ZK1w2t2jzbMbxNILMtsqmo/+rd+NTSB+seHM+hYU58Q2mdSzYqNN7ROYch
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|41001999006|24021099003|37011999003|8060799015|5072599009|19110799012|6090799003|15080799012|23021999003|12121999013|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVRrYnNZMld5c2srZ1lZbk9yQlpkT3hUZ3NZSFd6RmJIVDF6d1RDMUNlSkVO?=
 =?utf-8?B?L3VZZUZPYVIzMmJHMWw2My8vcWtwejRsaHlqaXZZU2JGRng3Q1R4cG9iSk45?=
 =?utf-8?B?MlRqQzc1ZFoxK0crK1lmRkFRY1oxZm5XVGFmZy9mbG45RWtNL0xydEtCUGdh?=
 =?utf-8?B?VjRYcFhhSCsyakJZaTdBU1JMeXEzQXBwaGhNaEgyWENhNmRObWVXNy80OXJw?=
 =?utf-8?B?UXZjTjd0MEk0QUt0ampYYjJOMHU3eVIwRWVoVVRSdWsrRzFmNUw3bDZJT200?=
 =?utf-8?B?TjJXRXJXNjgvQnVHUlY4NjhzTFZ1L01oTmdXK25Jay9qQXVVS2RqQVJMS2dH?=
 =?utf-8?B?UlRUUTF1cVpFZnpxNU4xSkVKSVpwS3JSVzQyRXVMMUl6N0N2c3FxQlhmVmhZ?=
 =?utf-8?B?UWIwQWhQNkUrTXMwVkNIenJuVXQ0dUNYTWFCNmt4ZEZTRDhXSzhnQ2NmU1NX?=
 =?utf-8?B?UGZyQ09OYldvMzBQWFUwbnVDdGtiZUlwcnBZb21vR3NQdjJlRnRPejN1Mmhw?=
 =?utf-8?B?dWd0bGU2eVBjME1nYUJhbkhUd2tLdnZvNGEwbGFUcVMyZlBWWHdoRUxZUVhS?=
 =?utf-8?B?ZEFQbWZ0K012MFNPaUs1RlVnMVRnSldmUWNFSUJtNXJPc2ZlWFplRlFjOUlt?=
 =?utf-8?B?djhTVzFvNkpBaWk0REdSbHpXaTU2NEM2THFiRC9GcTA0ajZ3ZTU2b3lRQ0NY?=
 =?utf-8?B?M2wxRms3NTJxRWEvL0Rjcm1SVEVnWXhPQU9GTDJKOHNpRTVuQmgvV2J5cnJt?=
 =?utf-8?B?aHJIYVV2dHJKNTNFcllndTZVOWp6ZmJIR2p0THhXTHhYMW1tY0pJV3RSb1JO?=
 =?utf-8?B?RzlET0RuVHduTS9EZ3Z0TXd4a2NrekxZMXJKVlZVcEVEL2F1aXdUNW1TYlhs?=
 =?utf-8?B?OUtnTUlFbXNPQi9NZzN1Z3lnWmRSM2p6VnlHRVg2OXdVQ2JydXNXdlFrR2Nn?=
 =?utf-8?B?WkNpSHVrU3kzZnQ4MDY0UmYwMStHZFpIVHBra3NEWTdSYTdtazNIaFJqbXlU?=
 =?utf-8?B?c2VKaEtPNHQ4eDRmLzZaVWZaMncyMm8rRC93SXdPdVFRUXdYVmNuRTRPY1c5?=
 =?utf-8?B?VzNONHNhVDg5d0VXc3Z5WVE4cmppOGZLaDN6N24xbThtRkxPQkVCcDZOUG9n?=
 =?utf-8?B?akJBNzZENHQxMWZtZWdrUU1XYlZlbDh4dk5SVVc2d043bUd3YkFUTUhPRHE3?=
 =?utf-8?B?VmVmbHYyWkxjWnVNVWkxTFBPQmt1Z2JRVEJtQnNsMkFWV1lBalI4Qm1hSVF0?=
 =?utf-8?B?R05sV3VqSEw4a05KaHA2djRaMlhFWGM5emtNSVQvTUlBRFAxK2pMVTNRaHNM?=
 =?utf-8?B?YjZrQ2VTZUY0bzhzb2Nadk5ZemZBUUkwelVQSVUvbVo2WWU4VVBaRWZGbFRH?=
 =?utf-8?B?bEltcVJ4YUZkMHJUWUEySGR5YmRuTTFhRFJqT3ZwUUZjaDZ2SFhmL2ZEZTJN?=
 =?utf-8?B?VnF5QkJya3lWNVpIMEFYTHI1UTBvN2J5TGpqakpnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJMbE5pMTdTMTNlOS9tOXlYZmFGMElST010UmhkZGhSaHFmaFRqRmwwa2RW?=
 =?utf-8?B?ZWZ6cCtCbEdEREdqUFBPeCtSNmpjMk5wUHhqMVFDeUNhdzFCTWZXTCs3dE1S?=
 =?utf-8?B?b1c3NmgwOVppUXVCNll5RkNub2ZHT0p0MW1rTmVSdHpMTnJzQ3dncWdvOGZN?=
 =?utf-8?B?Y2tMSmwwTHpWRjFWc2NYRFFGNjc3aTYydHVYeDVVUnJ3QlZmOEVkcEUxOEhv?=
 =?utf-8?B?eEUxRnBiWFRRL3Znc3ZhdmxhU2R6ZVVYQlFubStQZ2hpN0dxeHpsc1Z4UDVL?=
 =?utf-8?B?ei8xUGdpblVORTJuRGl0NENQdUxUTWZLRkR3ek5pK0w0VUc0TXR6Q0s4a0I0?=
 =?utf-8?B?ano2UC9hZkh3b3k1MWtYSlJLc0IyWC9pbkFXdDBiVlhIOFVGQytGd0hyRUEy?=
 =?utf-8?B?b3hiNzk1QlNNQ2hqRllnS2YzMzlJSHNxOGJGSVFNS3JSOTBXUmdSVXZPb0ZD?=
 =?utf-8?B?Nk1wcjNlN0s1YTBaNGJhbDRoTnNZWWR0c0JTQzdsUStaZ09ITWFiWGlRVUhU?=
 =?utf-8?B?aWk2MmN4L3h6QlVmSG82OXNWUnhwRGIzVGFJaUl1dUx0Z2pIREpJbndHWWxL?=
 =?utf-8?B?SEZYSjZneVBIeHRGQnZMM29SekJsRlNlcGdKSlVOSStUMzRiRzJEUjFKREo2?=
 =?utf-8?B?MjREZTRTNXU2dHFZMHBDdVVncGNsNGx3K1FtQjg3S2tFL0xJRTdnTWhMUmI0?=
 =?utf-8?B?b3A3Z2RzVENIRGtXUVhDVU1EakpYdEZ1S0xXZGFTclgwcEszeWRTejZkNGVP?=
 =?utf-8?B?aURvWmg5M0piRDNidUNFaWNJYnFXcFA4Sk12VXNlQWxtVFk0eE5vSVBNOFNt?=
 =?utf-8?B?SXZiamgzdWczYzRnQlkvenkvMWIyM2dlT2YyRWhZOUJ1aTdjSXdxSzdkWWd6?=
 =?utf-8?B?NUlqaEdVRllSMzVJZVJGTDM5UElVTi8weDdZcUVxOUhOS0xJRkFEYTNIdGxF?=
 =?utf-8?B?UHJsb3hRSWIxMkE4YVpOeVFVRjY1S1FPT3BrQnNUemFwRDU0L3dUd0JVWVdI?=
 =?utf-8?B?dG5GZ05xSDVkdUM5WFBLQ3Y5RjhsN3pRYjBqWkcyTjh5b3VOdFlsdVV1bCs1?=
 =?utf-8?B?T1BxUU96RlJhaERKQU5QbHFwSHZtMUZEdUNDS29XMzJmb2plbWI0V0M5QTJp?=
 =?utf-8?B?alQ3MHVtT2Fkbmk3VWRuOUVoVy9GOXdUajBQejlMMEFYaGFGMURyVTRXT0Nn?=
 =?utf-8?B?Z0NweThYdTVXZTAxT2xmcTJaOVVlQmpoeDlYTWFlUFQwUnpVaFlUYStTRzJR?=
 =?utf-8?B?VjB4dERPNzVtN1EyeDVOZ3RqelR3dVY4WXV1eVZ4QTdIMXFsblJobmNPWElG?=
 =?utf-8?B?TERRR2txcjU4NVdwenNpbmhQRzR0TXRUTjhPT0NBMGYwOTA3US9JSHAzMCtn?=
 =?utf-8?B?b2U4TlpiWkZ5K0ZtUm1uL1hGWCtrU3g5UUgrb3g0QjlLeGFXMDVqT0tGTEw5?=
 =?utf-8?B?bFQwc3QxSW5qU21CMjF4cTFoMDcvVmJ0Sk9hTG0vQ2paSm15NlZnZzYzRlpI?=
 =?utf-8?B?RlM2d2xZc1EwUk0yeU1YSS9IYzBuQkhHcnY2VzgyR1V2cTJ1eGlsV2phRys1?=
 =?utf-8?B?c3p4Y0k0ZVA1ZWpoNGlOeWdxbWlHb3B1czdxK0FQVFlvSnphbkU5dkJqNjJE?=
 =?utf-8?B?eU9XTlIzdzJEa2VCcGd4eTJxbG5QbUdCNGEzTmFJZkxLeE15R1NCY0dhWXhh?=
 =?utf-8?B?VHYxdjF0bzNhT2xacjhmTU9MQWJCOG4vUFc3cUxNNFh0MDVNZkYrdEZBQzY5?=
 =?utf-8?B?NU96bUNhTndjUENnRHNEYWp6OHZVS1pveXdDZkw3a1lRejBnQVFmeHRWMXNn?=
 =?utf-8?B?akllTm84ZDVMdTFQUVFldHEzUHEzanVqUUZUSExvalVpMjV3VW1pa0xnaFVZ?=
 =?utf-8?Q?ssAkjZi1S51oQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce18ba18-526d-4d01-48ad-08deb4fd0bbf
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:46:45.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6941

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> In a previous change, the --negotiation-restrict command-line option of 'git
> fetch' was added as a synonym of --negotiation-tip. Both of these options
> restrict the set of 'haves' the client can send as part of negotiation.
> 
> This was previously not available via a configuration option. Add a new
> 'remote.<name>.negotiationRestrict' multi-valued config option that updates
> 'git fetch <name>' to use these restrictions by default.
> 
> If the user provides even one --negotiation-restrict argument, then the
> config is ignored.
> 
> An empty value resets the value list to allow ignoring earlier config
> values, such as those that might be set in system or global config.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/config/remote.adoc | 18 ++++++++++++++++++
>   builtin/fetch.c                  | 28 +++++++++++++++++++++-------
>   remote.c                         |  5 +++++
>   remote.h                         |  1 +
>   t/t5510-fetch.sh                 | 26 ++++++++++++++++++++++++++
>   5 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
> index 91e46f66f5..4dcf81fbce 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -107,6 +107,24 @@ priority configuration file (e.g. `.git/config` in a repository) to clear
>   the values inherited from a lower priority configuration files (e.g.
>   `$HOME/.gitconfig`).
>   
> +remote.<name>.negotiationRestrict::
> +	When negotiating with this remote during `git fetch`, restrict the
> +	commits advertised as "have" lines to only those reachable from refs
> +	matching the given patterns.  This multi-valued config option behaves
> +	like `--negotiation-restrict` on the command line.
> ++
> +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
> +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the
> +same as for `--negotiation-restrict`.
> ++
> +These config values are used as defaults for the `--negotiation-restrict`
> +command-line option.  If `--negotiation-restrict` (or its synonym
> +`--negotiation-tip`) is specified on the command line, then the config
> +values are not used.
> ++
> +Blank values signal to ignore all previous values, allowing a reset of
> +the list from broader config scenarios.
> +
>   remote.<name>.followRemoteHEAD::
>   	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
>   	when fetching using the configured refspecs of a remote.

Good - now we don't talk about 'git push' before we have wired that
functionality up.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 2ba0051d52..a957739f37 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1601,6 +1601,19 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   		else
>   			warning(_("ignoring %s because the protocol does not support it"),
>   				"--negotiation-restrict");
> +	} else if (remote->negotiation_restrict.nr) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, &remote->negotiation_restrict)
> +			string_list_append(&negotiation_restrict, item->string);
> +		if (transport->smart_options)
> +			add_negotiation_restrict_tips(transport->smart_options);
> +		else {
> +			struct strbuf config_name = STRBUF_INIT;
> +			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
> +			warning(_("ignoring %s because the protocol does not support it"),
> +				config_name.buf);
> +			strbuf_release(&config_name);
> +		}
>   	}
>   	return transport;
>   }

Unchanged from v3 and still reads cleanly. Good.

> @@ -2658,10 +2671,6 @@ int cmd_fetch(int argc,
>   		config.display_format = DISPLAY_FORMAT_PORCELAIN;
>   	}
>   
> -	if (negotiate_only && !negotiation_restrict.nr)
> -		die(_("%s needs one or more %s"), "--negotiate-only",
> -		    "--negotiation-restrict=*");
> -
>   	if (deepen_relative) {
>   		if (deepen_relative < 0)
>   			die(_("negative depth in --deepen is not supported"));
> @@ -2749,14 +2758,19 @@ int cmd_fetch(int argc,
>   		if (!remote)
>   			die(_("must supply remote when using --negotiate-only"));
>   		gtransport = prepare_transport(remote, 1, &filter_options);
> -		if (gtransport->smart_options) {
> -			gtransport->smart_options->acked_commits = &acked_commits;
> -		} else {
> +
> +		if (!gtransport->smart_options) {
>   			warning(_("protocol does not support --negotiate-only, exiting"));
>   			result = 1;
>   			trace2_region_leave("fetch", "negotiate-only", the_repository);
>   			goto cleanup;
>   		}
> +		if (!gtransport->smart_options->negotiation_restrict_tips)
> +			die(_("%s needs one or more %s"), "--negotiate-only",
> +			    "--negotiation-restrict=*");
> +
> +		gtransport->smart_options->acked_commits = &acked_commits;
> +
>   		if (server_options.nr)
>   			gtransport->server_options = &server_options;
>   		result = transport_fetch_refs(gtransport, NULL);

This is nice! Addressed my concerns in v3 about the wrong message being
shown, and makes it clearer with an up-front check for the protocol
support.

> diff --git a/remote.c b/remote.c
> index 7ca2a6501b..620086e16e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>   	refspec_init_push(&ret->push);
>   	refspec_init_fetch(&ret->fetch);
>   	string_list_init_dup(&ret->server_options);
> +	string_list_init_dup(&ret->negotiation_restrict);
>   
>   	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
>   		   remote_state->remotes_alloc);
> @@ -179,6 +180,7 @@ static void remote_clear(struct remote *remote)
>   	FREE_AND_NULL(remote->http_proxy);
>   	FREE_AND_NULL(remote->http_proxy_authmethod);
>   	string_list_clear(&remote->server_options, 0);
> +	string_list_clear(&remote->negotiation_restrict, 0);
>   }
>   
>   static void add_merge(struct branch *branch, const char *name)
> @@ -562,6 +564,9 @@ static int handle_config(const char *key, const char *value,
>   	} else if (!strcmp(subkey, "serveroption")) {
>   		return parse_transport_option(key, value,
>   					      &remote->server_options);
> +	} else if (!strcmp(subkey, "negotiationrestrict")) {
> +		return parse_transport_option(key, value,
> +					      &remote->negotiation_restrict);
>   	} else if (!strcmp(subkey, "followremotehead")) {
>   		const char *no_warn_branch;
>   		if (!strcmp(value, "never"))

Good - reusing the parse_transport_option() as suggested makes this a
smaller diff and consistent with 'serveroption' above.

> diff --git a/remote.h b/remote.h
> index fc052945ee..e6ec37c393 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -117,6 +117,7 @@ struct remote {
>   	char *http_proxy_authmethod;
>   
>   	struct string_list server_options;
> +	struct string_list negotiation_restrict;
>   
>   	enum follow_remote_head_settings follow_remote_head;
>   	const char *no_warn_branch;
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index dc3ce56d84..eff3ce8e2d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1485,6 +1485,32 @@ test_expect_success '--negotiation-restrict and --negotiation-tip can be mixed'
>   	check_negotiation_tip
>   '
>   
> +test_expect_success 'remote.<name>.negotiationRestrict used as default' '
> +	setup_negotiation_tip server server 0 &&
> +
> +	# test the reset of the list on an empty value
> +	git -C client config --add remote.origin.negotiationRestrict alpha_2 &&
> +	git -C client config --add remote.origin.negotiationRestrict "" &&
> +	git -C client config --add remote.origin.negotiationRestrict alpha_1 &&
> +	git -C client config --add remote.origin.negotiationRestrict beta_1 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		origin alpha_s beta_s &&
> +	check_negotiation_tip
> +'
> +
> +test_expect_success 'CLI --negotiation-restrict overrides remote config' '
> +	setup_negotiation_tip server server 0 &&
> +	git -C client config --add remote.origin.negotiationRestrict alpha_1 &&
> +	git -C client config --add remote.origin.negotiationRestrict beta_1 &&
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		origin alpha_s beta_s &&
> +	test_grep "fetch> have $ALPHA_1" trace &&
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep ! "fetch> have $BETA_1" trace
> +'
> +
>   test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
>   	git init df-conflict &&
>   	(

Again, this patch looks good to me and addresses my previous comments.

Thanks,
Matthew
