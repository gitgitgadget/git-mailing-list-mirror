Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383432A3EC
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036446; cv=fail; b=hGRb6VQufTaaOeUJNkr2EqJnVw2lmQG7OfynJ73fbBTNLgGUYRORUui7d3n15prr2K1vglJwh/XP6Vxa6EHqgiVT8z346z5TTZeVkIXpWvZ5esVTyF3yVpP786iXb5Rpt3+1ydKpIav6cyEdqjFyzOPICVQLmD1mDrPDcMaThYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036446; c=relaxed/simple;
	bh=GjpKorlIhYnu95M8bwaaEekDojjnxxRBdA9Tfo17ACA=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=cUsFjVzHr5e1JKVAEPpPhE/P0AuhMdlopqnZd+8/MAKTRNFoXjV6YeTtxhNlRzIWBD1xYDW3gjVBUF/trKFfyeWpHNg81sDT3r0X0WoGEF8u7RYnBPMvPTsSN1PWCmXgEAF6vaD3C+j/NF1GhC/Thivopdzf+oZmjb5noRPp6HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vDzI9GRd; arc=fail smtp.client-ip=52.101.57.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vDzI9GRd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm0pB41mqT61BRlKBiGGXKp9N1rOCS8KQ+mBjBqsE9aUOn5kTsaSGpr3yYSduuOnJEVeOQLKwuFjLymC/kYS+08eFX4Kk4/bUPUJzf07OMT95iu+2Tn+0RX/IT3NEGqw2+eS1b9ADb11kW+lOEpEGKKc5VtJYxPxPmOYDlkkru99sMZkLCtzHou9ECK8JgQU4/tZuIJss/D+zHQa59vQYHGbjkn7NSXbUUKgOXAErcdZ4DsESwkYjLnb/hyHPhb6gptSKoTHSKjjkQ8hCJcXCXwwBtjWMXU+uE7+zMxJhSTvcm6RY2hJwmEwaj99BQYbmNhXfZvGSZVW71vFwFSMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjpKorlIhYnu95M8bwaaEekDojjnxxRBdA9Tfo17ACA=;
 b=kDiKMnheulhzfKc3dcnuLU+cUo300114SuWo4m/Kkd5/utwiwrED0geTO/9KThueqPyBAcxY8BtKJRpSnK8loAvVyT7CIqlCVPDj8fwibKuT/uFI+Wzx7azxlso0pd1MZWxeJ/IsqHQcG8RCkbq0ei/2g3oqu0N1CyylgCL2gbmfDcYJi+fpcu2X6oVqdp6T6rKi+4evT2iDDcB7z7rH88Svf1Vsk/rQlf7oJL8EBIx5dHcpVAzX/O0JTeDInbRUnxMUSk7v6UE42fUinDPoCgHhUNU+cGYWMo4Jfnu20f4+DGN6kX9nsp9nTwgmPa+mddDYQ0/jOy2uAiT8DLmSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjpKorlIhYnu95M8bwaaEekDojjnxxRBdA9Tfo17ACA=;
 b=vDzI9GRdpFErmhe5iIT+wlLEmtxyDI2zEvgB8Sr+ra3u3lM2SiEvfrqIJ5zEqMct6mPEdn+qaea/Q7kFjv+B0vrWuly/RmBghGmzIilbu+avucrZZ4HE3rur/8VB3QZYc1QWOr08y1R7obCHmkM8qSvgIUnG5jB7BlMVeyY+CxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 13:14:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 13:14:01 +0000
Message-ID: <26f3a5b2-1656-482a-9349-ca3592b8bba1@amd.com>
Date: Fri, 24 Apr 2026 15:13:57 +0200
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Problem with git send-email and --reply-to
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0dd92b-9a88-4696-3ed2-08dea2035a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|20052099010|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5vJ+l42SxYYFDrE88RINaV8pgdfZp2jEellU8BToDHcrFWwbhaxSAk6rthrtHo1oS6Kqnc7S99A6dQrDliftXnjS2YZ+ksSlTWRQORWvjfQLCSRfk29m81IasYZmypu0rutnGnPEv2h09KOobsh3mMBWKcmLW6Uj8I7VNkn36WsHQoPJADSDGl2B6zqTljpFdk4l7Dyu0nrkAxKVTWBybHsyTfRhEMXyJCPE9cO4VxijZkS8cXDztxtN4GJl07JJh3s2fY0Jv1n+6Pi90XK0ZYYiTTsJIHJKciiu+StF6/VICukw0MxfLCKLdxQEHK8pNZezNXs6C7XisfmEPhBDJVsELs/WDO+4N0WsVGfkyWkxg+j5JDlb1uOWB0iQ1C5V7vkLdVfHQW6IQvlWEaPU//U+oW/DkNZ5Zi4CesJprDCq99Y6ljquQo3G2kB+plCuVd4CdrAXzmVS0pbkK+3LwPPUh2XuuGJutg/tQOuwsdAev0eRWXYg1VEysdpDO9LFio311l53bEodcnEM1/X7innGMP0fBCL+V0P2V7G/vaiNjhAPGQlyyUGvi7W8gCfjw5m3uMFNLOlEzHdKrvjbHxL4oLJfNDZSEcmWlwkK1BPyj0Glaonksm7+y5Z081yUyonTlSLzWA1HX7bRB5iMX5/uZCQYj8GGjHk9vz51LHLfdeIguMBqevEa+ODlBlMlTJoAYypW2tIGmNDs5FIIoMojZAVrzd3HBsrtYCPsii8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(20052099010)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0VWVHdid2dKNExWM1ArWGlIM3RSQ3JHcTRYRlpFZE9RNDk2Si9ZUUp2MWRU?=
 =?utf-8?B?ZnFjV0FMTFl1NTNkMFptVE9ZdnFZUFhTZHVFOFpJRUNjNHFKbldBQ2JDc05y?=
 =?utf-8?B?Z1pNYkIyV3pBTGZmdTVKczZkTFRCekU5bm5oVC80d05maS9UcE9kMU1POEN5?=
 =?utf-8?B?OHpFanVDS3MrR1J3UlFJc0NUVEhzMVRtclU5SEp6dytxaGtGOWtqZEx5NnJY?=
 =?utf-8?B?aVdRMkVDZ1JUS1lTakJLV0s3WWpnT0hYMGdTS1lHZUkvRVpjQTNtWFJISUZW?=
 =?utf-8?B?UWg3RktodWVJbGJHbjJObWNscHo5b3Z6dWQ3cy8yN2FyOHBDTmJiWXVYZzV6?=
 =?utf-8?B?Q3ZIa1piQ2l0Q0pjSzRYNk5YajRYZHI3d2haYnRiTnFtREtDbWJoRDZlNWFw?=
 =?utf-8?B?U1lSVElQK0J2aWdJdkV4MTU0VnFPdlVKODhOenFYVFVWNTUvMDBrUHVwUkc4?=
 =?utf-8?B?bW04dnlOS2Zjei9DMVRWMkw3Y2FZK0dlK09UbTZoeGRNV1luTzJjZjNUTHZ5?=
 =?utf-8?B?Qm9FdlVuRkR3ZDRwR3JUUkpQN0FDc1Q0dUYwYkE5UVRZTFd3Ryt0VFBHZFl3?=
 =?utf-8?B?bHhTRVNJd3RrOGJxV21zVFE5M0JpczkyWVh1UWtEYUlXU3NYVkJRM2Q4Nkcw?=
 =?utf-8?B?a3FwSzFqMDgxWDdFNHgxZTZQWmlaVU9pd0hFMDc1NEVNTXN4KzNMcUdFajlK?=
 =?utf-8?B?UUtzU0hBdWU5WCtHVjlnL0J6Z1UrT3N3MWRNWFo3WHB0eEl6YlQveWl2WCtq?=
 =?utf-8?B?bjZDcnJSV3Y4QnA0MTlVbEtnZ0lySlhheFQvMmJoTXgvQmx0ZVpHMjRFa3lv?=
 =?utf-8?B?MWIzV0xERTZlYWZGak44RDhwQUY3TllDRGg0NGhYdzJDOTMyQU1LU1hYNWdH?=
 =?utf-8?B?amZLTGtkejlYZFlNYjFsSXQxejJhOUovb3dzRm50UndUSkE5aE9zekFOTkx1?=
 =?utf-8?B?NjNSZDFkM3ZRN2cvU0dDTDAwNEs3dkZaa1JKNzVxQjV3bXFOWFZBdzZiK0lm?=
 =?utf-8?B?QWZHVHpZQ1M4SFpPdUdOcGQ5dUNFUTFJYkdJOUVVTHh3WUNVUWw5cmxWNTJC?=
 =?utf-8?B?OUJ0dFBEYlNZek43emc1Yk9oVkFsSWxuNURCUFdSdjJXeVFCUytzbnN0Vjg4?=
 =?utf-8?B?WXlNU1VVVDJFVWxsNENCN0hGZGRWYkl4eHVuQkEyMk5kdUQ1N1NYN243Z0tI?=
 =?utf-8?B?dHJrb0d0U1UyMnVzZWprOWZoK2ZPcVhtUVRPclJrS3RUWFNBTXFSMWlCSnhz?=
 =?utf-8?B?UFVkQ1QwRkRsSFp3TW5IVUl2TS9Zd3FGUmhscWk0eUFxaFQvcDN2dno4bTQw?=
 =?utf-8?B?NlVmZDRDWTdTOHdVWExFdEkwSllFUS9Tbmp5Y3J2RFJxYUduTHBNYVY1djV1?=
 =?utf-8?B?Vm5IQ29KaW5jTThxTVEzK2FwZXlmckhPMGhxZjZWenJtSU40cGFhd3l1Y3NF?=
 =?utf-8?B?bWs3V1hCZ2hvdUl0UTVNWlByZDBEK2M0NkMyOUtod1RUQ21QamNjVWRZcnVE?=
 =?utf-8?B?U082UGdFZTdBeWdjamhNallYUXBTemMwaXRPZGJSc1dUOGhVTEI5eWRHR0Fz?=
 =?utf-8?B?UlJUeDhoU1ROVU9ONytud0t4VThFNG5GMHpzWjJOSmMwc1BBUlFad0FnYzNS?=
 =?utf-8?B?MDZkUW9rM3NPeFZKMXNkUER5NnlUNUE0NEZRWUtrdUFWVGhiS0VaV216Nzd5?=
 =?utf-8?B?UlZ1dE84d2tEdGxxNFpkdGdaVG1HTkNITERhemsxaXJHbjhXTk9kMVlXOEpj?=
 =?utf-8?B?L1NPUW9EK1d5UldtbUlRdHFUeDNvckJ2Y0E5TGNGM3NRTDI3dU0xWnZJbVNM?=
 =?utf-8?B?YUVoaERaWE1Hbm5vSUdCZWlmdmtKQ3pVZ2ZZajc5OUNnNlhGc21QMURFbE1y?=
 =?utf-8?B?SU43QlgySE50Sm5yYzZRS2NVZ2t6ZHR3aDdqV2lDUkNyQndPMi9vTWZ0c0sx?=
 =?utf-8?B?eDQwWTNGYitBcDVka2pBSjEwTTdEUjBjNjVEbmZTekhJR0xjZDZsR0prUVMz?=
 =?utf-8?B?UlUrakk1dUZLMHdSd1FZaS82dkQ4TnhveDV0dFdjSjRBYUpFcnhLY3Bkd2ox?=
 =?utf-8?B?SFJXVTdqU0hIbUM1NENmRDF3ODl6aWJQN1hZVlpNYXBNMHdYYmxIWk1PSnk4?=
 =?utf-8?B?V3FFakNRa2pKOWR6anlEZjFINmpaVlFCN0l5MGJBWEUza1VJc01jandjTGRV?=
 =?utf-8?B?cHdVSS8wQUJ5ajczYVJwU3JLanFMYmpxMmlKdUtYZnd4RktMT2ZyR2tlMjNS?=
 =?utf-8?B?RTJjTk0veGtZS1dPc1VuWlRxbzREN3gzY3ZwSHFpSWtXU1dSYkhTNU5abDlx?=
 =?utf-8?Q?tV3jCHVIfnu1KlF9eA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0dd92b-9a88-4696-3ed2-08dea2035a46
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 13:14:01.8834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtkxpQ2dQnGoD+pEN3tqzj0povh3zMLxnpsCj524jk2MCTvPo7OOqnLiyh1FTVMz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404

Hello everybody,

either I've found a bug or there is something absolutely not obvious going on here with git send-email.

I want to use the --reply-to option with git send-email to make sure that people reply to my AMD mail address and not my gmail address used for sending mails.

When I use the option on the command line it works fine, but when I put that into my .gitconfig it doesn't seem to have any effect.

Any idea what could be wrong here?

.gitconfig looks like this:

[user]
    name = Christian König
    email = christian.koenig@amd.com
[sendemail]
    reply-to = christian.koenig@amd.com

Thanks in advance,
Christian.
