Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013076.outbound.protection.outlook.com [52.103.51.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A534F474
	for <git@vger.kernel.org>; Mon, 18 May 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124353; cv=fail; b=iYOJqNgaysIz+PajIx33/ARoP0io09WDoCIDgJSdprPXEOc6kI92OMQQp/6E5RdtCesnuZ9RwIojv4skMW3Xs/2vqx2L++YLMiX5nt5GaEWrwG3be989wEQckIsOUqFCY4jMcTYnqR933WLoBhCfyqkiz+COtK1e277VVRq7cqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124353; c=relaxed/simple;
	bh=RhPy7s+4H9sP00rJsovb8TKmuGCt0RNMiwGOeJhYzSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oz/ooMW4Rk+eAZCgGZdUADMZLUVfsskA8y/JBIjJaPhaoIllZFiv+z1faC6TjgdHu66QHS6iBrZCFGLzUUnxh9m9sLBY+LDLpJItd11vseU8Fu1kmUuWhiY0rwe0la0SB6lWABl4kzksZxqR+lx3trrrVnQFZ2ylokUDMQA1kOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QI3E0gwS; arc=fail smtp.client-ip=52.103.51.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QI3E0gwS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoCoX4GDoK3l4cRsYb3B8pBDow7kmXJxevaeItBvAGX9TntvQlzWz68UIq1BfTX85xtIs2k0htSoGbNTqfUz3487Qy4tBPnqBnxSSwzClRRuWv6PLWw6VyGwT+oF07+xzlo4j5CnkxqGxeskL1HWYNgXR0DSrNlh3f4Vn/kI0cqiK+bz3XCZfaDX+Uv05A2yHo3fiH0CTUmS6AF4S8dcfvqBXrrkzlFJ9auPZHk3RsfnfX5UCQGD9pl6pDXIeP6fnD4yOsVg9sf51rn263O9VuwsdsGHPZFqP+E/0rrTb1VD+M9DUGxAMWQO6iigumXDV309q1xWqdYYY4pmV5+gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVgDmvVmQ7d/1yQWZEBvP2WLjY1fRJAYZEA2o1SQQrk=;
 b=aPJspwxE4ESdr6x3ekZV0TnwZ8bSmZzLw0zxwYvpE+8tlHfPxvq7gh9jPufIEgHIslDKUh1iUhSNL3A88YIU446PFIoTstqvJHIv0VsZ2Bz450EFtkxqatSOM4jflre9FKhqzusczfU4ndhkYbzub2ptPkSLzqPLLsthgA0w1ah1sxUeBQNCFvVBidKA8heuOhQq+13jXiBOg69BY0Y+qidyDu+KLlVIthCTBM+2cVZIWgHT9TsmlmASzUBp9Bip7ONLGHtOh9K0uargOx33wuJcfDIsaeBE6WUKSIfpqZ4DlHcZ6BPherM7FnpoTe7t1jnZzC+wPqmUAvJjG3uZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVgDmvVmQ7d/1yQWZEBvP2WLjY1fRJAYZEA2o1SQQrk=;
 b=QI3E0gwSBqo7MbHPts1V1dxzHjfuPuQ24trbgbiofVieJf54znmNfiAaEhmhTBIv5c/ksMqMBCuE+wH9pHtEvVk+mjmcu7UjhV37TXDLiE/WntRPZXDbp9Pt97Yml19guC3kZPUqd4qaS7QAv7lptmcpKNUbxYZBEii30Bg6xyKLHDZedLNKCc+K29hguMt5Iogxl8Sekts/ZtgaQyfiWKihVYrjZkXzV2XgZkChUV9ItbFZub/uh0k2w52ZNskh+1RTF0+wfVYuL4YAwy2l1hPK9fEPfbEzT209GZR5rKTUDNAnAJKfuGoaek1w2aAIjvCODXA76WPW9MI2H7Ertg==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by DB9PR03MB7387.eurprd03.prod.outlook.com
 (2603:10a6:10:221::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 17:12:28 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 17:12:28 +0000
Message-ID:
 <VI0PR03MB1163443EECE427785282AB153C0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 18:12:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] fetch: add --negotiation-include option for
 negotiation
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <b4cd458fe0b7625736348655c3aa704affc541c9.1778762495.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <b4cd458fe0b7625736348655c3aa704affc541c9.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0111.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::8) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <d1635be6-ce9b-4f24-aa71-2554c6a63f78@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|DB9PR03MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edf02c9-ea1c-4883-a83c-08deb500a3af
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLQ65JHxOKBAnHTP2G7hs4ROpUJuhIKZ0W98B/o4zBoZBBrq8nkZdJtaUpv9njgjYCYDE+0bwiy+7Rq27sx1GA3aVGvB8W8v+HGvhzvYMxz5bUZWADYuHospB8O+gHkmYSyjV+KV/lu+Mmw7N4RZ2PaxRDFlNCgqvh7vOmR9ATUNxZRhtX5mX8SqxSyT+tvq0P75szrqAAEqDFkMcuF2tR8wnwgvh0XaBCO5Z4YjB3uYzMQeWk2ZuDeUScy8Gq2jWzHKJfX0Q3CpU5uXKyz7IyLKtqokJopWEML5+V+K62OvKzlONPSAvAUYKBRFAjiSYCXRqFh+xVoUKp44CqKgYTtRP45fFKp0DWl0oMh9Z/2ssQKvA3b7TKJ7b8N158wN7nRhlSAExGecfHqNoAlW2V2j3AuTBhDlaG+P9DyeQBIfba2v+tXSVn7OmcsFUUPPBlE8pRRwO04/mujGYn0PL7dvxSRI6+itp0o+YjLcPdseBBPJg7eTIgIaFdEeY1RE0w0W8vj/fBj/fV033VJYdcQtG1mduc1YGdjNRKeRCyT84NZSeDH+/tn9NLfg8Pnw8m+NBF6alQx37/xeCVDfZ0nExj4R8ZwYNIVe72mC6lAjid42owQlGB7fjzVuXIjIH1RcuK+1L1zYX9a8gLiBydenb/OdkN6ige033G7uv/UvdL11GZXb8hzd23ARJZ3NLdZXi9ztIw39Q4PQbHCY/VwnEctL71r59RrlW7dTja9VMWXMYX4aX1m4b29ECDeS6o/j8Wjvrjxwko6o7b/g0/jR
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|41001999006|19110799012|15080799012|6090799003|5072599009|23021999003|12121999013|24021099003|51005399006|37011999003|440099028|3412199025|12091999003|56899033|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHk1dUZSZldDQ1l1dS9yS21XQVQvazdIK2FKL3FGY3pGelN0dlNhTEpMSkZM?=
 =?utf-8?B?NUZvK1g3d211Rk40MDMxU3F3QWVWQ3ZkU3VObURidER2dFpYcnBoYzhUa0Vm?=
 =?utf-8?B?aWFEUHdXTkwySzUxZG4rK2VpU05TRG4wQmtSQkxVKzBBWGxHa0g3Q2k5WGdR?=
 =?utf-8?B?bzYwNTU3VzhXRHdaYk1rNnpEdVRZN05Gb1FIc2JqeFlrcDBVQ2pTSWJSRS9S?=
 =?utf-8?B?cS90d0xRS3hhRmlBNCttMFNCS20rNFhHM1F2N2xoSnBkNTdxUkoyL0xTdHI5?=
 =?utf-8?B?cUlFSVNxRGFCVmVBYi9aK3BreXNaL1JCL0R4d0F2aWtYRG9wRnZJd3cyQ3VZ?=
 =?utf-8?B?QW5teHJvc0dFU055QnRoR0xmQTRVcGVLZWtFMXZYWWF4c3hlM20xS3VFb2Vm?=
 =?utf-8?B?K0hwc2V5dXZOaEdhUlA3ZFdQNC9vQ1FGTmx3MGNBQ1d4QUVxT1VwWVFxMS9k?=
 =?utf-8?B?T2IvOXcyeDZ1RS9JTHVFcGFpcmlOYTE0WDBMMU0yc1hrcFE4a3kvK1drU3dD?=
 =?utf-8?B?dlRMakJnRVZybmI0aFBRbUFJc2dJN1pHM3FibFc2RWNyYmhzN1dHb1J5VXVp?=
 =?utf-8?B?dFI4WllrM2lBc3pQYjFtZEFzcTUvOFRKaFhFVnBzVTlZeVNYRnNaSndVeHE5?=
 =?utf-8?B?YjVvMkw0U0FoRURTRWhEVGdOTVpZaVZ1U0ozQzF1QVR5MGlEc005NC9zeU9m?=
 =?utf-8?B?NnM3VkJ0WUNFaGxJVEtWTkdBUThxOVlCMEZUYVRPb3lNQ2U3RDRKMDhDWEds?=
 =?utf-8?B?MU9nMU16K2JMNWVJTG5YRmhzQVE0RDM2NjRoeEhZR1JRTXJVenB0WkFrMFIy?=
 =?utf-8?B?a3dTaDhZMkZvbDdWbEZNZDJvNHg0NTlENFpsWi9Uc25od1F1YkN0YUZWMi9y?=
 =?utf-8?B?ejNzTXUwSk5MQ29TL2Q1aUdhNzNSWnl0VFZXOXJhVmt3eHNmU2ZORUlacVdz?=
 =?utf-8?B?dWFDZnB3ZVovTjdpZDZCcWx4VEx3dGR1bUszWlZBSkd4WVhiSlI1TW1kWm00?=
 =?utf-8?B?bWdPOUc5RVRMdkplRjRzQWFHdVVDdG1NWmRuNXcySG9ITDMyVFlCNElTYUFL?=
 =?utf-8?B?Q2JCSWxyeXlMTElHS0M4ZUFyMkhJVlBjbXBEMjE1dXBtcHcwcFJnTWthYnNV?=
 =?utf-8?B?cnprcUdFN083WHNJZU51UXl5c3o3SStYdFNqalViTE9xVEJHcnl2TTBmakQ5?=
 =?utf-8?B?V2laVG5OMkNsYnpKMU1TK0JOZ0dCaG5QaVNDZlVob2VFdTB6SXhXcmpnRHdj?=
 =?utf-8?B?R0tVaTg0eUoyRHJlNGQyNTB3c1dic21zSjh4OG8velk3R1Ara28xeWQ2LzlU?=
 =?utf-8?B?RHVGSGFaai9nU1hzeEpHTWVDU2Y3ZktXanZ3ZWNOaG1qY1RpVHB3dXBrTHY2?=
 =?utf-8?B?V250ZkNVN2gvL1UvVldGb1pVc1RuakUwNk1xMVhHK2Y5R2c3enYxZGQwNEZY?=
 =?utf-8?B?UElibnhML05xZ1o4L2lTK2M4a0tIaUUxL3RBNU1BPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGVCcVFOUTl0cTJNZ3E1MlNLQXhCNEFqeUdhMnNhazZ4cVY4NU1hYkFqMk1k?=
 =?utf-8?B?M0lYZTNaNEJ3OWo0dVVSSGVSSnVtRTRFV0p4VFRnSnNUUFMvVWRDTTlydDFJ?=
 =?utf-8?B?ZDEwZFZuUmtGaEs4K2RRY0NuOHA5MjNXbllwd21WRjM5MnZla3hnRXFENW56?=
 =?utf-8?B?L3djMmVkUFFGMXZ2dG9XSEU1RDNjWVE5VGw5ajBHTDFkc2xNRnJlb3c4WDdw?=
 =?utf-8?B?Skc4ZmdBRVVtVU1QTU55cXZCL2hneGNVTjlDQjB1TzhNdlFaTmMzekkrdkRH?=
 =?utf-8?B?RkFuc21MMzhwY3g2Rjc5YSswMlhOVVV4dWtZb3F1enhvcG9VelQyQk1pUWll?=
 =?utf-8?B?Z3MvOFJjMndRQ3lJTGxUNzdmMWhnNUlkdnMvcmtYcmlOejlWMmdXbTVSRGIx?=
 =?utf-8?B?bmxrTlRQNGtTczVUQmw3bzhOeXJ3TGxmLzNUTkozeHBSQklNemNzNTEzNk5x?=
 =?utf-8?B?QnhPVWp1cU1VblVROHFqcDhUVzFHRS9VMEQvaWpRZ2tsYzgyaXdQdmgyUXdz?=
 =?utf-8?B?dnZNMnNxL3dUUUk0MGhHWkIxY0luZ3FiaUZZMHNwdlJaMzgrYkw0bjVoUDVp?=
 =?utf-8?B?U1Z4QTN0aHFmTXJ5a1F3RXE5aFFKRWU2ZkpzenVwbHlab0tMV1BxSnN5aUFo?=
 =?utf-8?B?TkdUMVBvQmkzbUdOS3FzMzlSdnNRVnl5ZnJvQTNYZHVnZ1Q4TEFjdjQxVysw?=
 =?utf-8?B?RXFFS20wTDlYbm4veCtXRFBvdWp4VDhhYXlHM3NPeHBZeW94RktZUUxqWGI4?=
 =?utf-8?B?RjNsbzdoYi9lTCszZU5BeW1SU1NvUEJ0N29jbDJ1Vk5hbXRXaURRTUR6Nnht?=
 =?utf-8?B?c0FBZko2dmxkeTYwaU5WaVVuelBRM1IwbUlkelNKa2poMC9XZnhjamhnTCtl?=
 =?utf-8?B?UGI3NmE2MUFKc2g5VDN0U0V4WWtxdlNQSnhkaWF4RDJjR2J3K3VvTzBENXp5?=
 =?utf-8?B?dUNwWE9NWGxLMnljelpiL3hicU1IamRUSnVCb08weFpybjRsZEoxc2l5bmQ4?=
 =?utf-8?B?aklQbXl0REFzdnh0SXhIcWFEdVhjNVNrRW4wWkJIKytvejk4VVg3Mktqc2Vk?=
 =?utf-8?B?d05Ob3g1MmhsamxKeURDSCtESytUZ2h0TTRjUTZ3cVdITGhmdUFsSEcvdEM5?=
 =?utf-8?B?UFVTalFEZWRZRWpZc0R0TTcxQ0xoeGJTYmJkeUdveUdpVHBiR1Rqb2gyQWNQ?=
 =?utf-8?B?blo2Ulg4Slh1bk5jQVJJUWZYb2ZmaFRCUDFqNjM0Y1BYeWJMMndrR3JacFZz?=
 =?utf-8?B?bnJIVURDR3V6V0FQQlZSWEJXOWhGUmcyOXU1Njlxa0NBdFZYSGJNR00xMktT?=
 =?utf-8?B?MXVqQzJtVmVaZTZkb3VRdEdzWmswdU02eExncDVnZDVnaExhN2hzYkgvSi9V?=
 =?utf-8?B?bFRXS09oU0J4dVJZOGdBckttTk9pbGNHYjBqZnU5VGRsZVRJU1YvUUUwdFF6?=
 =?utf-8?B?RzZ2QUg3OUxKZzBMM2l3cjFzNXZDSlBuMmY0Q1NMa0I5ZE83eFlRd0FuVHJK?=
 =?utf-8?B?dnp1bmNXcm04RTRnSnl6OGhrMEFjLzFvRFAyWnlZby9lNDFxcndWc0xvakE4?=
 =?utf-8?B?ZGZ1N1piS3laRjJ4NEtFVDFENDJPTG9oRjZoKzl6TDRXYTcwZG9iR1pWNmpx?=
 =?utf-8?B?MEVrbFJnTFRjTUg0OTJIM0ZiZXBHYlN2cFNUd1BtbERKeUVJV1VidEVqd1Fj?=
 =?utf-8?B?TjQxZUFoRktra21NSFRPUEg5SUFwRWNTRVUwaUlQejV4eDFraDFFYVZ1Yitj?=
 =?utf-8?B?L3JXTmxkWFF1TnZVYyt0dytlN1R1VllJZEd1QXE4SWRsLzVteGJ2OTRtZHpB?=
 =?utf-8?B?MG82aFFad08xWXNwcUhxYTc1VC82VU11TERDWXNldkJHejM1eU1NcWI5ZTJl?=
 =?utf-8?Q?kqqTxtUEgoxtB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edf02c9-ea1c-4883-a83c-08deb500a3af
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:12:28.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7387

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> Add a new --negotiation-include option to 'git fetch', which ensures
> that certain ref tips are always sent as 'have' lines during fetch
> negotiation, regardless of what the negotiation algorithm selects.
> 
> This is useful when the repository has a large number of references, so
> the normal negotiation algorithm truncates the list. This is especially
> important in repositories with long parallel commit histories. For
> example, a repo could have a 'dev' branch for development and a
> 'release' branch for released versions. If the 'dev' branch isn't
> selected for negotiation, then it's not a big deal because there are
> many in-progress development branches with a shared history. However, if
> 'release' is not selected for negotiation, then the server may think
> that this is the first time the client has asked for that reference,
> causing a full download of its parallel commit history (and any extra
> data that may be unique to that branch). This is based on a real example
> where certain fetches would grow to 60+ GB when a release branch
> updated.
> 
> This option is a complement to --negotiation-restrict, which reduces the
> negotiation ref set to a specific list. In the earlier example, using
> --negotiation-restrict to focus the negotiation to 'dev' and 'release'
> would avoid those problematic downloads, but would still not allow
> advertising potentially-relevant user branches. In this way, the
> 'include' version solves the problem I mention while allowing
> negotiation to pick other references opportunistically. The two options
> can also be combined to allow the best of both worlds.

brances/branches from v3 fixed - thanks!

> The argument may be an exact ref name or a glob pattern. Non-existent
> refs are silently ignored. This behavior is also updated in the ref matching
> logic for the related --negotiation-restrict option to match.
> 
> The implementation outputs the requested objects as haves before the
> negotiator performs its own algorithm to choose the next haves. Use the new
> have_sent() interface to signal these have commits were sent before engaging
> with the negotiator's next() iterator.

Now references the new have_sent() API - good!

> Also add --negotiation-include to 'git pull' passthrough options.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/fetch-options.adoc | 19 +++++++
>   builtin/fetch.c                  | 32 ++++++++---
>   builtin/pull.c                   |  3 ++
>   fetch-pack.c                     | 81 +++++++++++++++++++++++++---
>   fetch-pack.h                     |  6 ++-
>   t/t5510-fetch.sh                 | 91 ++++++++++++++++++++++++++++++++
>   transport.c                      |  8 ++-
>   transport.h                      |  5 +-
>   8 files changed, 227 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index d39cecb446..7b897a7202 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -73,6 +73,25 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
>   configuration variables documented in linkgit:git-config[1], and the
>   `--negotiate-only` option below.
>   
> +`--negotiation-include=(<commit>|<glob>)`::
> +	Ensure that the commits at the given tips are always sent as "have"
> +	lines during fetch negotiation, regardless of what the negotiation
> +	algorithm selects.  This is useful to guarantee that common
> +	history reachable from specific refs is always considered, even
> +	when `--negotiation-restrict` restricts the set of tips or when
> +	the negotiation algorithm would otherwise skip them.
> ++
> +This option may be specified more than once; if so, each commit is sent
> +unconditionally.
> ++
> +The argument may be an exact ref name (e.g. `refs/heads/release`), an
> +object hash, or a glob pattern (e.g. `refs/heads/release/{asterisk}`).
> +The pattern syntax is the same as for `--negotiation-restrict`.
> ++
> +If `--negotiation-restrict` is used, the have set is first restricted by
> +that option and then increased to include the tips specified by
> +`--negotiation-include`.
> +

Good - the syntax placeholder matches --negotiate-restrict, and we
mention object hashes being valid input.

>   `--negotiate-only`::
>   	Do not fetch anything from the server, and instead print the
>   	ancestors of the provided `--negotiation-restrict=` arguments,
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a957739f37..6b456b3689 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -99,6 +99,7 @@ static struct transport *gsecondary;
>   static struct refspec refmap = REFSPEC_INIT_FETCH;
>   static struct string_list server_options = STRING_LIST_INIT_DUP;
>   static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
> +static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
>   
>   struct fetch_config {
>   	enum display_format display_format;
> @@ -1534,23 +1535,28 @@ static int add_oid(const struct reference *ref, void *cb_data)
>   	return 0;
>   }
>   
> -static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
> +static void add_negotiation_tips(struct string_list *input_list,
> +				 struct oid_array **output_list)
>   {
>   	struct oid_array *oids = xcalloc(1, sizeof(*oids));
>   	int i;
>   
> -	for (i = 0; i < negotiation_restrict.nr; i++) {
> -		const char *s = negotiation_restrict.items[i].string;
> +	for (i = 0; i < input_list->nr; i++) {
> +		const char *s = input_list->items[i].string;
>   		struct refs_for_each_ref_options opts = {
>   			.pattern = s,
>   		};
>   		int old_nr;
>   		if (!has_glob_specials(s)) {
>   			struct object_id oid;
> +
> +			/* Ignore missing reference. */
>   			if (repo_get_oid(the_repository, s, &oid))
> -				die(_("%s is not a valid object"), s);
> +				continue;
> +			/* Fail on missing object pointed by ref. */
>   			if (!odb_has_object(the_repository->objects, &oid, 0))
>   				die(_("the object %s does not exist"), s);
> +
>   			oid_array_append(oids, &oid);
>   			continue;
>   		}
> @@ -1561,7 +1567,7 @@ static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
>   			warning(_("ignoring %s=%s because it does not match any refs"),
>   				"--negotiation-restrict", s);
>   	}
> -	smart_options->negotiation_restrict_tips = oids;
> +	*output_list = oids;
>   }
>   
>   static struct transport *prepare_transport(struct remote *remote, int deepen,

Great! Now we have a unified implementation that takes a string_list
and ouputs an oid_array, used for both restrict and include lists.
We pre-resolve so that fetch-pack gets the oid_array so the ref
resolution happens in the same layer for both.

Just one small issue I see - the function emits a warning for
"--negotiate-restrict" when we don't match a ref, even if this is
handling a --negotiate-include value. Perhaps we should pass the
option name in as a parameter?

   add_negotiation_tips(&negotiation_include,
                        "--negotiation-include",
                        &transport->smart_opt->negotiation_include_tips);

> @@ -1597,7 +1603,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   	}
>   	if (negotiation_restrict.nr) {
>   		if (transport->smart_options)
> -			add_negotiation_restrict_tips(transport->smart_options);
> +			add_negotiation_tips(&negotiation_restrict,
> +					     &transport->smart_options->negotiation_restrict_tips);
>   		else
>   			warning(_("ignoring %s because the protocol does not support it"),
>   				"--negotiation-restrict");
> @@ -1606,7 +1613,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   		for_each_string_list_item(item, &remote->negotiation_restrict)
>   			string_list_append(&negotiation_restrict, item->string);
>   		if (transport->smart_options)
> -			add_negotiation_restrict_tips(transport->smart_options);
> +			add_negotiation_tips(&negotiation_restrict,
> +					     &transport->smart_options->negotiation_restrict_tips);
>   		else {
>   			struct strbuf config_name = STRBUF_INIT;
>   			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
> @@ -1615,6 +1623,14 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   			strbuf_release(&config_name);
>   		}
>   	}
> +	if (negotiation_include.nr) {
> +		if (transport->smart_options)
> +			add_negotiation_tips(&negotiation_include,
> +					     &transport->smart_options->negotiation_include_tips);
> +		else
> +			warning(_("ignoring %s because the protocol does not support it"),
> +				"--negotiation-include");
> +	}
>   	return transport;
>   }

Having the shared helper makes this much nicer. Good!

> @@ -2582,6 +2598,8 @@ int cmd_fetch(int argc,
>   		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
>   				N_("report that we have only objects reachable from this object")),
>   		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
> +		OPT_STRING_LIST(0, "negotiation-include", &negotiation_include, N_("revision"),
> +				N_("ensure this ref is always sent as a negotiation have")),
>   		OPT_BOOL(0, "negotiate-only", &negotiate_only,
>   			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
>   		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
> diff --git a/builtin/pull.c b/builtin/pull.c
> index cc6ce485fc..d49b09114a 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1000,6 +1000,9 @@ int cmd_pull(int argc,
>   			N_("report that we have only objects reachable from this object"),
>   			0),
>   		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
> +		OPT_PASSTHRU_ARGV(0, "negotiation-include", &opt_fetch, N_("revision"),
> +			N_("ensure this ref is always sent as a negotiation have"),
> +			0),
>   		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
>   			 N_("check for forced-updates on all updated branches")),
>   		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,

LGTM

> diff --git a/fetch-pack.c b/fetch-pack.c
> index baf239adf9..96071434b8 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -25,6 +25,7 @@
>   #include "oidset.h"
>   #include "packfile.h"
>   #include "odb.h"
> +#include "object-name.h"
>   #include "path.h"
>   #include "connected.h"
>   #include "fetch-negotiator.h"
> @@ -332,6 +333,21 @@ static void send_filter(struct fetch_pack_args *args,
>   	}
>   }
>   
> +static void add_oids_to_set(const struct oid_array *array,
> +			    struct oidset *set)
> +{
> +	if (!array)
> +		return;
> +
> +	for (size_t i = 0; i < array->nr; i++) {
> +		struct object_id *oid = &array->oid[i];
> +		if (!odb_has_object(the_repository->objects, oid, 0))
> +			die(_("the object %s does not exist"), oid_to_hex(oid));
> +
> +		oidset_insert(set, oid);
> +	}
> +}
> +

Nice - this is much simpler since ref resolution has been hoisted up
and we only deal with pre-resolved OIDs.

>   static int find_common(struct fetch_negotiator *negotiator,
>   		       struct fetch_pack_args *args,
>   		       int fd[2], struct object_id *result_oid,
> @@ -347,6 +363,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>   	struct strbuf req_buf = STRBUF_INIT;
>   	size_t state_len = 0;
>   	struct packet_reader reader;
> +	struct oidset negotiation_include_oids = OIDSET_INIT;
>   
>   	if (args->stateless_rpc && multi_ack == 1)
>   		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
> @@ -474,6 +491,27 @@ static int find_common(struct fetch_negotiator *negotiator,
>   	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
>   	flushes = 0;
>   	retval = -1;
> +
> +	/* Send unconditional haves from --negotiation-include */
> +	add_oids_to_set(args->negotiation_include_tips,
> +			&negotiation_include_oids);
> +	if (oidset_size(&negotiation_include_oids)) {
> +		struct oidset_iter iter;
> +		oidset_iter_init(&negotiation_include_oids, &iter);
> +
> +		while ((oid = oidset_iter_next(&iter))) {
> +			struct commit *commit;
> +			packet_buf_write(&req_buf, "have %s\n",
> +					 oid_to_hex(oid));
> +			print_verbose(args, "have %s", oid_to_hex(oid));
> +			count++;
> +
> +			commit = lookup_commit(the_repository, oid);
> +			if (commit)
> +				negotiator->have_sent(negotiator, commit);
> +		}
> +	}
> +
>   	while ((oid = negotiator->next(negotiator))) {
>   		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
>   		print_verbose(args, "have %s", oid_to_hex(oid));
> @@ -584,6 +622,7 @@ done:
>   		flushes++;
>   	}
>   	strbuf_release(&req_buf);
> +	oidset_clear(&negotiation_include_oids);
>   
>   	if (!got_ready || !no_done)
>   		consume_shallow_list(args, &reader);
> @@ -1305,11 +1344,27 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
>   
>   static int add_haves(struct fetch_negotiator *negotiator,
>   		     struct strbuf *req_buf,
> -		     int *haves_to_send)
> +		     int *haves_to_send,
> +		     struct oidset *negotiation_include_oids)
>   {
>   	int haves_added = 0;
>   	const struct object_id *oid;
>   
> +	/* Send unconditional haves from --negotiation-include */
> +	if (negotiation_include_oids) {
> +		struct oidset_iter iter;
> +		oidset_iter_init(negotiation_include_oids, &iter);
> +
> +		while ((oid = oidset_iter_next(&iter))) {
> +			struct commit *commit = lookup_commit(the_repository, oid);
> +			if (commit) {
> +				packet_buf_write(req_buf, "have %s\n",
> +						 oid_to_hex(oid));
> +				negotiator->have_sent(negotiator, commit);
> +			}
> +		}
> +	}
> +
>   	while ((oid = negotiator->next(negotiator))) {
>   		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
>   		if (++haves_added >= *haves_to_send)

Here we're using the new have_sent() API and replaces the manual COMMON
bit flipping.

> @@ -1358,7 +1413,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>   			      struct fetch_pack_args *args,
>   			      const struct ref *wants, struct oidset *common,
>   			      int *haves_to_send, int *in_vain,
> -			      int sideband_all, int seen_ack)
> +			      int sideband_all, int seen_ack,
> +			      struct oidset *negotiation_include_oids)
>   {
>   	int haves_added;
>   	int done_sent = 0;
> @@ -1413,7 +1469,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>   	/* Add all of the common commits we've found in previous rounds */
>   	add_common(&req_buf, common);
>   
> -	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
> +	haves_added = add_haves(negotiator, &req_buf, haves_to_send,
> +			       negotiation_include_oids);
>   	*in_vain += haves_added;
>   	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
>   	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
> @@ -1657,6 +1714,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>   	struct ref *ref = copy_ref_list(orig_ref);
>   	enum fetch_state state = FETCH_CHECK_LOCAL;
>   	struct oidset common = OIDSET_INIT;
> +	struct oidset negotiation_include_oids = OIDSET_INIT;
>   	struct packet_reader reader;
>   	int in_vain = 0, negotiation_started = 0;
>   	int negotiation_round = 0;
> @@ -1729,6 +1787,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>   				state = FETCH_SEND_REQUEST;
>   
>   			mark_tips(negotiator, args->negotiation_restrict_tips);
> +			add_oids_to_set(args->negotiation_include_tips,
> +					&negotiation_include_oids);
>   			for_each_cached_alternate(negotiator,
>   						  insert_one_alternate_object);
>   			break;
> @@ -1747,7 +1807,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>   					       &common,
>   					       &haves_to_send, &in_vain,
>   					       reader.use_sideband,
> -					       seen_ack)) {
> +					       seen_ack,
> +					       &negotiation_include_oids)) {
>   				trace2_region_leave_printf("negotiation_v2", "round",
>   							   the_repository, "%d",
>   							   negotiation_round);
> @@ -1883,6 +1944,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>   		negotiator->release(negotiator);
>   
>   	oidset_clear(&common);
> +	oidset_clear(&negotiation_include_oids);
>   	return ref;
>   }

The v2 wiring looks correct.

> @@ -2181,12 +2243,14 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   			   const struct string_list *server_options,
>   			   int stateless_rpc,
>   			   int fd[],
> -			   struct oidset *acked_commits)
> +			   struct oidset *acked_commits,
> +			   const struct oid_array *negotiation_include_tips)
>   {
>   	struct fetch_negotiator negotiator;
>   	struct packet_reader reader;
>   	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
>   	struct strbuf req_buf = STRBUF_INIT;
> +	struct oidset negotiation_include_oids = OIDSET_INIT;
>   	int haves_to_send = INITIAL_FLUSH;
>   	int in_vain = 0;
>   	int seen_ack = 0;
> @@ -2197,6 +2261,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   	fetch_negotiator_init(the_repository, &negotiator);
>   	mark_tips(&negotiator, negotiation_restrict_tips);
>   
> +	add_oids_to_set(negotiation_include_tips,
> +			&negotiation_include_oids);
> +
>   	packet_reader_init(&reader, fd[0], NULL, 0,
>   			   PACKET_READ_CHOMP_NEWLINE |
>   			   PACKET_READ_DIE_ON_ERR_PACKET);
> @@ -2221,7 +2288,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   
>   		packet_buf_write(&req_buf, "wait-for-done");
>   
> -		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
> +		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send,
> +				       &negotiation_include_oids);
>   		in_vain += haves_added;
>   		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
>   			last_iteration = 1;
> @@ -2273,6 +2341,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   
>   	clear_common_flag(acked_commits);
>   	object_array_clear(&nt_object_array);
> +	oidset_clear(&negotiation_include_oids);
>   	negotiator.release(&negotiator);
>   	strbuf_release(&req_buf);
>   }
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 6c70c942c2..6d0dec7f41 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -19,9 +19,10 @@ struct fetch_pack_args {
>   
>   	/*
>   	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
> -	 * lines only with these tips and their ancestors.
> +	 * lines for all _include_ tips and then a subset of the _restrict_ tips.
>   	 */
>   	const struct oid_array *negotiation_restrict_tips;
> +	const struct oid_array *negotiation_include_tips;
>   
>   	unsigned deepen_relative:1;
>   	unsigned quiet:1;
> @@ -93,7 +94,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   			   const struct string_list *server_options,
>   			   int stateless_rpc,
>   			   int fd[],
> -			   struct oidset *acked_commits);
> +			   struct oidset *acked_commits,
> +			   const struct oid_array *negotiation_include_tips);
>   
>   /*
>    * Print an appropriate error message for each sought ref that wasn't
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index eff3ce8e2d..bc2e2af959 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1460,6 +1460,16 @@ EOF
>   	test_cmp fatal-expect fatal-actual
>   '
>   
> +test_expect_success '--negotiation-tip ignores missing refs and invalid hashes' '
> +	setup_negotiation_tip server server 0 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-tip=alpha_1 --negotiation-tip=beta_1 \
> +		--negotiation-tip=no-such-ref \
> +		--negotiation-tip=invalid-hash \
> +		origin alpha_s beta_s &&
> +	check_negotiation_tip
> +'
> +

Good! This checks for missing refs (not just invalid ones with all
zeros).

>   test_expect_success '--negotiation-restrict limits "have" lines sent' '
>   	setup_negotiation_tip server server 0 &&
>   	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> @@ -1511,6 +1521,87 @@ test_expect_success 'CLI --negotiation-restrict overrides remote config' '
>   	test_grep ! "fetch> have $BETA_1" trace
>   '
>   
> +test_expect_success '--negotiation-include includes configured refs as haves' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		--negotiation-include=refs/tags/beta_1 \
> +		origin alpha_s beta_s &&
> +
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	test_grep "fetch> have $ALPHA_1" trace &&
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep "fetch> have $BETA_1" trace
> +'
> +
> +test_expect_success '--negotiation-include works with glob patterns' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		--negotiation-include="refs/tags/beta_*" \
> +		origin alpha_s beta_s &&
> +
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep "fetch> have $BETA_1" trace &&
> +	BETA_2=$(git -C client rev-parse beta_2) &&
> +	test_grep "fetch> have $BETA_2" trace
> +'
> +
> +test_expect_success '--negotiation-include is additive with negotiation' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-include=refs/tags/beta_1 \
> +		origin alpha_s beta_s &&
> +
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep "fetch> have $BETA_1" trace
> +'
> +
> +test_expect_success '--negotiation-include ignores non-existent refs silently' '
> +	setup_negotiation_tip server server 0 &&
> +
> +	git -C client fetch --quiet \
> +		--negotiation-restrict=alpha_1 \
> +		--negotiation-include=refs/tags/nonexistent \
> +		origin alpha_s beta_s 2>err &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success '--negotiation-include avoids duplicates with negotiator' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		--negotiation-include=refs/tags/alpha_1 \
> +		origin alpha_s beta_s &&
> +
> +	test_grep "fetch> have $ALPHA_1" trace >matches &&
> +	test_line_count = 1 matches
> +'
> +
> +test_expect_success '--negotiation-include avoids duplicates with v0' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
> +		-c protocol.version=0 fetch \
> +		--negotiation-restrict=alpha_1 \
> +		--negotiation-include=refs/tags/alpha_1 \
> +		origin alpha_s beta_s &&
> +
> +	test_grep "fetch> have $ALPHA_1" trace >matches &&
> +	test_line_count = 1 matches
> +'
> +
>   test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
>   	git init df-conflict &&
>   	(
> diff --git a/transport.c b/transport.c
> index a3051f6733..fa54928966 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -464,6 +464,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>   	args.stateless_rpc = transport->stateless_rpc;
>   	args.server_options = transport->server_options;
>   	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
> +	args.negotiation_include_tips = data->options.negotiation_include_tips;
>   	args.reject_shallow_remote = transport->smart_options->reject_shallow;
>   
>   	if (!data->finished_handshake) {
> @@ -495,7 +496,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>   					      transport->server_options,
>   					      transport->stateless_rpc,
>   					      data->fd,
> -					      data->options.acked_commits);
> +					      data->options.acked_commits,
> +					      data->options.negotiation_include_tips);
>   			ret = 0;
>   		}
>   		goto cleanup;
> @@ -983,6 +985,10 @@ static int disconnect_git(struct transport *transport)
>   		oid_array_clear(data->options.negotiation_restrict_tips);
>   		free(data->options.negotiation_restrict_tips);
>   	}
> +	if (data->options.negotiation_include_tips) {
> +		oid_array_clear(data->options.negotiation_include_tips);
> +		free(data->options.negotiation_include_tips);
> +	}
>   	list_objects_filter_release(&data->options.filter_options);
>   	oid_array_clear(&data->extra_have);
>   	oid_array_clear(&data->shallow);
> diff --git a/transport.h b/transport.h
> index cdeb33c16f..97d905ecc0 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -40,13 +40,14 @@ struct git_transport_options {
>   
>   	/*
>   	 * This is only used during fetch. See the documentation of
> -	 * negotiation_restrict_tips in struct fetch_pack_args.
> +	 * these member names in struct fetch_pack_args.
>   	 *
> -	 * This field is only supported by transports that support connect or
> +	 * These fields are only supported by transports that support connect or
>   	 * stateless_connect. Set this field directly instead of using
>   	 * transport_set_option().
>   	 */
>   	struct oid_array *negotiation_restrict_tips;
> +	struct oid_array *negotiation_include_tips;
>   
>   	/*
>   	 * If allocated, whenever transport_fetch_refs() is called, add known

Overall this version of the patch is much better IMO! Just that one
comment about the incorrect option name in the warning message.

Thanks,
Matthew

