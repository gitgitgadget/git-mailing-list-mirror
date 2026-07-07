Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645412D47E9
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452094; cv=fail; b=B2wQRiGLUNR62k8/482gyfY3jSSKQn46mb6XAAEn7LCNJ3UYVL82olALtl0KHpvZ/OUYk4L5rio7Q4npuXuzUwGJI1V764d25IOYeHevPIKE2FrweWJH6ttzxxPm0G44ZtgUHNqjL/J14xjtmRHViCfzZkG8R2ur6dnfMueIOcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452094; c=relaxed/simple;
	bh=8ABpU8oWLW1ZZpbb4EHyknFnaKPt+304a4FJMn3U1s0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RM4ZR9uK81yKsUBzszVdM0PpadMHYkIXjXaAqELRdWDuLdhKl5i/r/GdAvfVEM2e35lJ9avAr3Yc1K7SI5kvb2QH/3q1qDsan2Cmr+N8OM3UQvatFnYDQKi+14bdn/rgINH0t+7/oxkdNtetPkWaZPKAFD+C3/SWsfjDKv4MmWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nuX3oEJL; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nuX3oEJL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUAzdVSyFWwb6XYrrBR2woQPGlQMig8XlNhFY4GHKT/wlEOOfyh1GgwAH+68pVtwAdGqeHVk5yCwiIxw7coQ9v23lRGbgpTVC4T0k7uqtGpWFnIKfH3o6+g61yyVx2P9o6NmR8ARlhu9HgJS3A+86Z3cK5DK0X2CAFRjD0IfEbrjJJ4NgKp5t3zITABci/3q7a2EvgmnCnMkBP75Mnr5zbZfrIp6+KLFVyWhIH1BEC0dZ48A8WW7NhTKcBrMuNsQUejuJvjzOEDeU13wG1k7WqLFH9toj8v3Ii7m/Wbg3yWxqnloA9Q4hOs3wYqyUOTW/37IenT0C07uIHGeP/hfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49OkG1DvB/+xQa8MvVnkqzsN5RrnuFTi5kCAEHCyNNk=;
 b=SaOPK2nNamD3KfEysjDvLa50uGqWYPfAWWjEX6CyJNU7q2aRvGJM4wXkfg0X2kAEwSjkk7YTllF0ocnazMV81EdceERvEVTs9lke8tvdJrVgr638yc1LyPrbyiQ9bY8vGsb17SmqYhWVAPDvejqQA0LmVfzYJVI9KeqAOBDiNcvErwPr2GsKQkg9/r83/QmNH59uJy62oqoRuvq9NO8pnwCoI/Fk8scSF1peIVTyhKmS0XzC+M1uoxojalfc089h8XtM6oqva0wrpHNpPf97Dnn3AJ66kai8VGz92upN5RdhRx+3aw5hzpqLV7un/XtXmKVxKl94gXYdDd6X8VfVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49OkG1DvB/+xQa8MvVnkqzsN5RrnuFTi5kCAEHCyNNk=;
 b=nuX3oEJL2k77Lj7RGiglH+F1Pf15JfCtDKt63juMM82+l9gVbKpOb/XO9ONqm7jZXyGyxbQm2QN53bi+f8Y/YwctAuLMqJhyfm0tyazF1i/Fl/bFZpanVfF3RR2r6sC/2wdNuKTHHoGl7c+BDl4MPbxyNraj95Gy6kgbu6lrWW9UNvN8bsDIWH+SdOeD+6gLSpN05vFzF2K9EwkZTC0Sew3mzByndATIyI4ztzZTL9c+d1G0yNRIuM66413OmMNcKvwaW0v8j6yA0uBY+GejQaE6JNK3DXpV76uJanGf7cyK8okqSJ6saIdi96bSZwn46uWPcAwpPD+jdPU1u92p/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 19:21:28 +0000
Received: from PH7PR12MB5783.namprd12.prod.outlook.com
 ([fe80::c659:3078:24ca:3fb4]) by PH7PR12MB5783.namprd12.prod.outlook.com
 ([fe80::c659:3078:24ca:3fb4%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 19:21:28 +0000
Message-ID: <68c2b88f-8976-474b-8965-97733eba5a99@nvidia.com>
Date: Tue, 7 Jul 2026 12:21:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] http: preserve wwwauth_headers across redirects
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20260602161150.1527493-1-aplattner@nvidia.com>
 <xmqqpl28scll.fsf@gitster.g>
 <5144a29d-a53f-4446-beff-e1f549345bf9@nvidia.com>
 <xmqqo6gi3905.fsf@gitster.g>
Content-Language: en-US
X-Nvconfidentiality: public
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqo6gi3905.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To PH7PR12MB5783.namprd12.prod.outlook.com
 (2603:10b6:510:1d2::9)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5783:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: eb979fe2-1a57-4055-085f-08dedc5cf1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|23010399003|366016|3023799007|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	8EgfX88UBOmDAUjyLGK4k42yfqknElF80sq/Td2MRd4P5MsTqWPbtz8w+mwQT4kM9Ux7yA/ff246UEGQHIp0ISC89yYBoj63PLndi2v4msHnrs1bYYdcE7fJTyXieDYDbQTSwBhWOCn+RzPWMeOJ8sj/GH+f1PJ8XCrSsQVsZcqb4jY0FTpBWmugUZWNcaLRbr53LaoRRiRTDwhdfvPvhlHu7WYp7ta7YrPxB5z1tQvV33GU1+R37iaD+z5wW61d9zM6+xU04XwDMeWwwTH7Edon+ZrUiK7bJIzCd7eS3WsfhrbbFJ4HUqzL0CY4welUxZAiRpXD+cCdk+KvAE5PqyBcmRZUTMgXko+rw1nFSLNaXi/5kbeIL+mMjnCer5av+EkISCI4IxVuibr0+gQrnyl4hzeqEsrj7vdzhlQVdoZ21+dMLJ0+PYFDXOY1wGKHYfQQWMfVHC7dvU1aVkmEd6fZvXYLfnfNyTrhLZXe86gbLfYBL/Bj+YS1HDRgy4oer02QCoyTc4mw80fMef7WiT/x0BOwe46cN4zIbZuZ9Adnvl7OhsslynpVEDaJBtDp8AerjcYnzM8jq/54komcR9LNgT0kJma4ViJ2tpeP0qDOoLB3AHMEUO1/hB2ZMVC5Gt3I5F8joQtiljmoqbcYDqyPAmPMrtIaa+HgCsvd1Ao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5783.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(3023799007)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVIrampBaTdlUlo0Vkg1b1JiakpjeFpFVnN5S0RwS3hTN296QmQ2ZmhMRDBj?=
 =?utf-8?B?WlNrV3NVbUIyaTVWeG05a0RHMlBxSVl1aTdjaVlvNVd5T1pDMGNYU3lLRlFZ?=
 =?utf-8?B?TVo3Y2RvZFNmU0VNcFQycmFYd1dSaGszMVl4S3pYb2c1eDhNMjZFVlJCOUo3?=
 =?utf-8?B?cU1yK0pyNm83S01xMXFUdEkyK0xlS2RsYUZOcHpwaXB6bkRhVnlKdWw1TGR3?=
 =?utf-8?B?bUxZODNFY1djVTFjRmM2clFwdlJ0ZlcxOFFOUkpJUnlPVyt3eHh4NkdVN3N4?=
 =?utf-8?B?cHNDandKeXJYRGRIT2kxRUtUSXpqbStTUWdZUXMwalQ1TkplQ0dPV0R5MUFM?=
 =?utf-8?B?Y3p3V0Zyd2dFWWhUQk50dlM5RFE0ekRHa1dYYlJWSVhsV3A3RTlMeS9zMTZr?=
 =?utf-8?B?eEhSeUlKUk1pUjhhYkc3WUEwdlYrbUY5K054WkRLZ09sUEJXWVBoM1FtbTl3?=
 =?utf-8?B?dWdqb1ViRFdWdWdlMUJiQnFNamhHd1Z5MWhGMTJib3hCbGxXdC9UVm1vSjli?=
 =?utf-8?B?dTJSTXJMMm11YUhmVnlCdGFkZnFUVG90SG5US21yVDB5N1lwamQ5cVM5VGRk?=
 =?utf-8?B?ZktSRWZOUVpjdEZVUzFhNXNuRCt4TUxPWnVMU1JkZ2U0dUdqZGowYUJ4QXd6?=
 =?utf-8?B?d2toOWtuaHkwVzBneWY5c3ZLQUVIb0JNTjV3QlhjWUdRWU92ekpFUzlzM1pa?=
 =?utf-8?B?MTV6S0VXOG5Tdnp5YS9Pa0xrdSttc3NLZkdlOEFoS0JGMDlEbHE0ZTdkMmR5?=
 =?utf-8?B?LzkvMFNwWWRTZFJFMzVONWdiWmRybDRuOXV1TmxLbEFZb01LdUF0SHFRN0Z5?=
 =?utf-8?B?UTlDRitpdloxWXU2R1JLOERGYnV6UVNXQTR3eUp1Q2NXY2daTkJSQXNrT3Zv?=
 =?utf-8?B?eDRwa3p4WTUwL1hyQm5rcS9Kbm5wY01vOENKMU8xNm9KbjVZVUlvako3bEgz?=
 =?utf-8?B?SnRPd25oU1dmR3pFRnE4U2tnMWdDRWNjTjkzSUdJcUQvVXcwUGpCNVRWSDZS?=
 =?utf-8?B?Si9oN0VNODZjd0lFVmtURHR1dXVCRVZzRGtLeGxnY053MFU5aWRpcWxnMDVF?=
 =?utf-8?B?R3RDQS9LSWxHNEg4SENYTUt6SEdSTXlHbVFrYlJXQXZ2Y2JKNzJBNDZ6aXZQ?=
 =?utf-8?B?TU8rcEV0RXU2c3cxT3lFdFRJam5TNDU3bmgxdjdrQ0NiUm96YWJENXNIRU9q?=
 =?utf-8?B?UWhoWkk1YVI1aWhUaExQeHE0L1dWVnBBVXloS3dIdXZPdlo5NitEeEVDS0VN?=
 =?utf-8?B?eGkya2UzZUtiY1RWRXVRcFZORnVjQVROY0I2WXlsdkkxRlNacnNXbEZ5ZWpp?=
 =?utf-8?B?VHJZNDhmNnYrN2w1dWhsSVNSTm9FSTU0bGRuc1h0dGh2WkIvNURqbXdKQmlT?=
 =?utf-8?B?ZUFobkVRS0s4SEdodmMxODZUdlZSenVUS2htZkhJM0gwazMySVpGa25jc0dH?=
 =?utf-8?B?ZWgwTTh1RGFlcjZ0aG53OThlRUxXRnprRzBKRm1GT3VPUmt3a1o3ZUYyeU13?=
 =?utf-8?B?OUdRWmJpdFlPa1V5NHR3eHpVcmdQL0RDYTNlL1EyS3c4RDFyUjJqOGtaL1B2?=
 =?utf-8?B?MThjNzFoNVBDaHR2MjkrcXJxKzJ5aFRLZWR6cE9jOU90U3d2UENtZEZlZEdC?=
 =?utf-8?B?NURmeklvaWFlVG0wTnFxWnJEVVBlR2NVRUQycjExbit3a2hwbitBY3djdU4v?=
 =?utf-8?B?NWVVRTRzcVMyZVFUMDFEN1cwbmNHOGFXbnBpQUFGQ0ZhbXJyME8wNGRNUHdG?=
 =?utf-8?B?MGNZUVkvTXZYSXQwYnBkM1pQRkFhZ2F0NXVqQnU4SWVwdEhiNTlpd1hTY0NR?=
 =?utf-8?B?UFpkWHJINUhJemlGaVlNM3pCRG84ZHRibDhzdWNwYkF5QVEzWmd2enpKY2V0?=
 =?utf-8?B?WXZrSXZEM3VDRUlmSjM3UXY3QnJweUlJaHlxNEpLaGZJNmVHQ25Jc2Z4dytG?=
 =?utf-8?B?dVFPbzd2TDRISytIN3I0b3pYSkNrT3FraDhvd3BBcDdzUkp4V3NwQld4emZN?=
 =?utf-8?B?dXNRdEg4eWNuQjB1cS93L2dzaDgreVBrRVZXNkRlSnRQWEZyRktpbmdTRG9S?=
 =?utf-8?B?SXBlZ0I5YW45TysrRnhJdU83dWM0c2V5a1I3ZTNRMSs5cnFEY1lSTU85Qk1Q?=
 =?utf-8?B?VEsveFRqKzFhZ2NVT243ODNTblY1SnYxMlM0N2drR0MwdDJvWFBFZEo2NlFn?=
 =?utf-8?B?SS9xLzViUnIrb3BhQXArT016cmRib0ZObG1IVlBsNTRzWHZReWFjVDhKWnJx?=
 =?utf-8?B?ZjNSaUFHUGNxM0Q0YmE4S2hGeDJqamJvdE05T0RBT0RvRFJPNW1sUWxNd09i?=
 =?utf-8?B?ZTl2ZnVGY2JyelZhYjBObnN5dlhVait5b3laUkovdVJnZkh5WXM0ZzNKUG1m?=
 =?utf-8?Q?IlMd6VEiKOxL2MX5HgxfFVFsDllfYkh4dxjn2Vp8FYVty?=
X-MS-Exchange-AntiSpam-MessageData-1: FXrBPc9tLcsVng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb979fe2-1a57-4055-085f-08dedc5cf1b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5783.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 19:21:28.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1A/Iu3LmiaDtoBiP8mzeDXmXf7XuPExWniuijl6yPgFflTmue9AnGihBWhskSj7XImkzqV+s2C2FU7x4xIyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493

On 7/7/26 12:16 PM, Junio C Hamano wrote:
> Aaron Plattner <aplattner@nvidia.com> writes:
> 
>>> I wonder if it would make the design more robust and future-proof to
>>> encapsulate this logic in credential.c instead.  For example, we
>>> could introduce a helper function:
>>>
>>>       void credential_update_url(struct credential *c, const char *url)
>>>
>>> that does what the new code added around credential_from_url() by
>>> this patch does, perhaps?
>>
>> Yeah, maybe. I'll think about this design some more.
> 
> Sorry, I lost track.
> 
> Did anything come of that discussion?  No rush, since this change
> fixes an immediate issue and the helper suggestion is for long-term
> future-proofing.  We can treat them as separate steps.
> 
> Thanks.

No, I got sidetracked with other work and didn't get a chance to get 
back to this, sorry. It's not directly impacting my users since I can 
just tell them they have to use my server's FQDN, so fine with me to 
treat this as a low-priority issue.

-- Aaron
