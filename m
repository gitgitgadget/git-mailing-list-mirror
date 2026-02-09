Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013085.outbound.protection.outlook.com [52.103.35.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E62E88BD
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649993; cv=fail; b=RlNRO/YO32IjhkSXsCUVnNOG7Ehx2ICpgiGO1RBALChXVokgr2ONNZdBOI6wzHCdH2tFgXXi+7EkccDYE/e/P8D1VDJu/6IlILjZaVGV2A37QBAgLJsY5RXvpqLYua0LX1uAIetqk0yrGGsaMXig61gv8ifBPia5/mitOpmO3EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649993; c=relaxed/simple;
	bh=rjRqf+oDFbmqsXubOVI1wb3jDmSZJwuVhJPkrHtKJWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XTCZDDsLzmZJQi9VBSpVpBiHjGgXyPDVnvGxhMqxgZD+mHR8Ns+zMcsKNG9XPDbxhNrSpaWeeDHXY4eLZOXjPjAEQQ9rXTrob+HFEE4gw61DVc6rt0I40kEh9Dltfyyj4pC8vfqN3daZMjRQKseonZq3q2uqKWNL0PpRkyi3L2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fAW5r4t2; arc=fail smtp.client-ip=52.103.35.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fAW5r4t2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt25Z9dy7yK5n19XgvO6NB/794AgsXPPNcaV+Lm+lAeZsJHP7Xy8qJ8A6tFd87aUmnMAui+EOvtbizcQSw6t/2VhMTwyP/VrcJsnqwZQveBjOSeTclyjggQmLt26zkVSXjhKEGvwfB/a82GxuTEmBEb3kk87d+uqbKZozy+XD+ir9hR4H//txcyyeBMACk9P0BN49GSTPFjohFE98LndVQ8i/7wgXybe1XRB98Sq8ozQib4CgW9t51X0/LGrvVmyB+33gYKzlPaWvFe0jqkWFgx/Gk1cIqD0ljtNnZYVaej0J/3JoMVf2Xh7JyleSA6XKRb6EVUSFBdo8fwFXVTbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1J2xAA7VFVHF0A0vOguniA+XaqVlYRT7Y8mNFqqEms=;
 b=xrVOGRkKIFYEVHM/os/fmSxSGp4hPVibn5+TzayWa32RkMRvuY8hZxTHzRf+UaCbWNBJExmKW/GRAMQq0w5sB68dJ0Uc1awulQr3AQ22geX0V4m8BSmZff598LprB33ffqbHXepZN/oKAH4o9bebE85gS5JvNYgh67AhhFZzd5YiJFUPDS0fxJTc5GSK62V7jzk0lFUsbTg9QS6rGUL95sIRAiczCcbXL2q/6dMfFrfKgI520A5QLvP/LXZFmxm96KzbYiJCEy5xidtFnHVEDMeVVn4PD9wonMg1KKLDonprMp1npYjOMxdaDfuG1OCCJCh9rhw/4NBgUIbHoXX64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1J2xAA7VFVHF0A0vOguniA+XaqVlYRT7Y8mNFqqEms=;
 b=fAW5r4t2CFTpsGJ/tIDX+Xo+kMWX5o3s42k7BU/cR/NEbdwEKRK36rDChYojw4XEZjrYUhZmCTxEl//xoGa+K53FFlA9hQLJrRwc8PTdCyJ6+6rPw9nb2W/vsTL1eEKPR+OIT9yG5XQn2E8xDoCqoeOrjS45qbIvd2FiKuyR8+51IBy1cXoMI+w26tqhbsJOkVPMiljamd7dIo0ezjqVv5uzdoiUcEGY/gtswvcI1i9S6NsyTuL2xfTgI0O0Yr3tcXm4FvDn9kVvRhX4Kam6dUIQ/12yU4yYLFkJhf5mKwRUIYaoPQpn0CzcIvu6cUueRY8Crzpe1zprew6EhoSgJg==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AS8PR03MB6695.eurprd03.prod.outlook.com
 (2603:10a6:20b:29e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 15:13:09 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 15:13:09 +0000
Message-ID:
 <VI0PR03MB1163484F620092CD9CE36C836C065A@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 9 Feb 2026 15:13:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] trace2: add macOS process ancestry tracing
To: Derrick Stolee <stolee@gmail.com>,
 Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <d99a30a1a77f0f23468dba987da08b32dd9a92fa.1770307510.git.gitgitgadget@gmail.com>
 <7390e189-16ac-43b3-a63c-a8b942d5934b@gmail.com>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <7390e189-16ac-43b3-a63c-a8b942d5934b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::6) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <1425c650-9815-4115-821a-01cfd570e469@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AS8PR03MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: cda0b506-0819-4db4-688b-08de67edbbcd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799012|23021999003|15080799012|8060799015|41001999006|5072599009|6090799003|51005399006|12121999013|440099028|3412199025|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDQvR0Vad09vQVRnRHVhZUF1QkFWa0xsdzRGdkpmMHljdFl4SFNpOHZXV3k5?=
 =?utf-8?B?ZG04azAra3l1VzNNSWtkK3RoS1luek9JUm1MbmhiZVcyYytSdkFxV1lqVDl6?=
 =?utf-8?B?M3RJb0VVRVcwUXV3YmZnVUpyT3BGdmppTHVGeC9VZzJlVFpteVN6N3NoMGxp?=
 =?utf-8?B?aFhPSjNlTVZIT3JWS3p4Z3ZocDRCb1Z0QjZtL0Y3TERnSFUrWS9ZZ1RyMlV5?=
 =?utf-8?B?b1kxSE9FRXFXOXo0NEtaKzlZeHMySUtXTWlISTFTcndZRzg2eTVTZ3RrYUoy?=
 =?utf-8?B?TEVNRUg4MEpCV1YyelZUSjFCSGxJaE12NFljaWtYalI5alBvWHMrZUp4M0ZX?=
 =?utf-8?B?Und6a3FGKzExVkJqaFlXczk0TmtpOGRhV0V5RllDQmFzMVRjSEMyREZQbVNS?=
 =?utf-8?B?b3N3ZktPeWYvSGFZOW5MTTJ5S0I4b3JyYllMSC9HZGNJWGJIZGZLVjJXcXd1?=
 =?utf-8?B?aTlnRGhEd3JENCtCNU1sby8vVHQreHdNSGkvM1o0ejFwb1d2R3d0Z3RwOXZR?=
 =?utf-8?B?eDBmbEExbWJGWldQS1VzWEE3ejNaVndiNGhaWWdWck0xbC83bWh4Y09kU0hB?=
 =?utf-8?B?UjhKMEZDRzNtai9lT2drRno3Y2trYk1wUTlReVdKZGlCTktkTjE1Y3plSXY2?=
 =?utf-8?B?V1hjeDBlWnpBeXRDb0tTM3gzc3hlMTJIV2lXeDdBc1B0Y0M2RDM3ZzBWb2Nt?=
 =?utf-8?B?TkVtRktlZHFqTHZTa0I3cEwwSEo0dGN2WGFmOEZjMjZMeXpnUXFFaUtGNUI1?=
 =?utf-8?B?a3VhRk04b05tL3hIeG5Hc1ZXUVBwNU9CeVBRei9ZREoydTNkMXlsUHZZT0JT?=
 =?utf-8?B?Mk4rbVRoeUtWMGYxK2FselNwUitJRVVMazVQNzhLNmxjYUcwWE9yREZTZW44?=
 =?utf-8?B?ZDRZWDlPNmc3OUJxNGdXL1phN2JOdHdIMEt2cUlDVWoyWDJVK0d3S0Qza2NY?=
 =?utf-8?B?TGpIemd4anRua0RHdEVabUdvcTg3QTlvaUc5OHlLdE1VYjZKczcwVC9sam53?=
 =?utf-8?B?Y3VkS1J4OTJnbSsrVHUwandLdmx4MFh0blRhYzB6aHNhMVFxUDkxcyt6L2RF?=
 =?utf-8?B?UE5KYmVBNGhRUWUyQnNjNHlYOEFqNGc1cFhRcnZrV1pWVlpHNzNyTmw2dmNQ?=
 =?utf-8?B?MlFtVjBBYmJQelhjbisvK1RGbG9IenRrMlA4VGJ6NER4UnFGdDNiY2ZmU3Zw?=
 =?utf-8?B?Sy9oSWlhMUtLWUxXYU90OE84UDI3eU1LelNCZThEenVQTE8zUFdzdHNRcFdy?=
 =?utf-8?B?NmdBSzZuVGJYWDcrbVNUUThKMGxEekNzSk9FQTFOa2tpSXJaSU9IY0NiVGhB?=
 =?utf-8?B?QjlJaUNtS1hRd2hUT2tVeWhMUEVuNkJJQk9ZYlFvemtzMGlsTE1sL0JOOWpY?=
 =?utf-8?B?MkMwN000L0dzYkliN0RJNHFrdU1YOSt0ck9ZQTE0bTJGNlVyYUlkQjlxa1lD?=
 =?utf-8?B?cExvNWFQR0x2eE9TRWRkckM1SENXOTB3QStjZnVndzloMkE2ZmRUcEJlSC93?=
 =?utf-8?B?alVaNHRIcjNXSzljTkFvUWs5UXB3YXBobC8zMnJzenc0YjlUcjI1S1NqOGRw?=
 =?utf-8?B?d1BlbitZeXpIbHFVS2Jab201Z0FBYm9jeHBHc3RDOHZHeDN2Qy9vdG04S25F?=
 =?utf-8?B?TTV2cC90VWZPaEtFRnRRNG1aMGZlSnFZZkVSM1B3aE42SUYvdngyRVdlUC9t?=
 =?utf-8?B?ODVtS3M1dXo4bXp1UnZHYzVLM1V4ZWtIYVNuc0NaS1RLc2hieFJ1YUNOdVgz?=
 =?utf-8?Q?OHdUhV4INAbATwIXkHdsWarrYwimMH5/1mSU6A4?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHBEYlBYZDM3bDlJeEs0WUg3ZW1sMXl2amg0QUM3dHV5SlcvYVlkWWZmZXAz?=
 =?utf-8?B?TUVHVHQ0OEpEYlF6elltZGp6Wm9ZNkNxSElWc3FNWHl4VlBScWZzYjBxMUpM?=
 =?utf-8?B?bExpSXRMdWZURWRYVzdTTE1jMVl0RGNDVWtSQWh0Z0FWY3kzQ0hVN3p4L3Fz?=
 =?utf-8?B?VFZsWkZOc3RTVWJZWkE0ZlNSS2pQaklMZFVlZmV1NHRaT00za3N6VWFpeWZn?=
 =?utf-8?B?aEhUd0xacjRuSHd0UUJFclhaT1VabThaRFdPSW5QY1pXKy9Fc0xrRFJYMXpo?=
 =?utf-8?B?ckxkNXdzdVFlSFA0ZzIwWEQ0K0RqTjZvQjZiWTBXZklySi8yQ2VjZTFxc2tw?=
 =?utf-8?B?NVpuOXoyZVh2dVRxMHVLczlFSmRhK1FxUXA3eUZYTTNBV1JnMXpYSVUyTzB4?=
 =?utf-8?B?aHhVNHd6OXV5RElRODFyYnFpdElVa0Q2WS9rV3ZmUVhrdDF1dnZiQWhQTnlG?=
 =?utf-8?B?SzVrMHpra3hzaE9zZGM4dld5eTFiZ2hHYnhITmtRNGVBU0FOTmQzVEowdDcy?=
 =?utf-8?B?bWhFSUltVDVja293aWNTS3E1VVAvQU92OUF6dU5idEtpZ3NwOEttd01KQTF3?=
 =?utf-8?B?MkV3dkRJYUphQUwxVmZtMC95WnZFYVJ3QVNVOXFaVnpXaGd2cTJPV2htUFJL?=
 =?utf-8?B?U2llVHlMSjZINS9JUTQ0L1daTHJkWUJNZnVaZFZWWE85bUY1NEtBTnNQZC9D?=
 =?utf-8?B?dmxNdjQvWkxMcElYdWs4UTZNbkF1MHgwRjFUa2FHRTFHbEVjY050cHVUZ0Yr?=
 =?utf-8?B?c3BtSmFVd3RkczVMeUNzU3JlQXFsNTlWczFweGF2K2pYWEx2UTkxTTEvdWJl?=
 =?utf-8?B?d2toSDUrVU9HK3VnZGQ5eGRIVHRSOVkzazJocFJmNlR5U01tZCs5Tnl5NG4y?=
 =?utf-8?B?Q0J6aHZweDhtZlhTWUx4WlZHK290ZE1xWjRqbVRhSU9YVTFnTEM1RXBUQU1I?=
 =?utf-8?B?b3lDZGtNY0FPWlhwai9iWVdnVDFqTVZDem5adC9aMmlrRVdFOXY3MWNjMmh3?=
 =?utf-8?B?Q04zaXFWQmx6eXJZcjl1Z25ZQmQ3aFJxSVVaMFN4Wk5GQUFHeW5hSFdKV041?=
 =?utf-8?B?aTc5VlY4NTgxNks5dlBCdVBwenZxMGttMjZqSHdNTnFRYkVEUDRmQUZRb1Na?=
 =?utf-8?B?WU1vZnVDbHdyT3BUY0tYRU13MHk1VTFBakdXUTlxbDdQQ2Q1cXBLUk5hUlo4?=
 =?utf-8?B?NzhRVThxbFdlS1hhYjQ4cHRTRWpGRyt3SjNXbW5COEU5QlJRQWsvUHVkWGps?=
 =?utf-8?B?V21senNnd2ZWbmJ4akxsWnlsYXZ5V3Y0RkFpYzZ4NEdvbWR5RC9nMUhhcjJU?=
 =?utf-8?B?ZVd0YU9oam1PaTZxODdUQ3Z3bzFnZWtXeTlqTG9kL2Z6NVNleGR5dHY5K2tt?=
 =?utf-8?B?Y2k4NStOWDNUeVM3QkNlOW1CZHhLVjFFNzM3QUQ0bHVtenVxR0RZdjQ2OUly?=
 =?utf-8?B?KzRrVXVEVzNjeS9WYkhNd1d4RUdjM1ZjR3p1ajBGWFdRUU9Na2FjcVA5RzV2?=
 =?utf-8?B?UTM2bXYvTUtENW5YbGJhU3M5Z2plbTgxMTc1aE9Od3NLM1MvSmZkb05RTFov?=
 =?utf-8?B?ZktHRXpCeFROVGxpYVB5Y2JSTDBlcTQvYzRmaGU5ODZ3VVpCWlVzeHc1Ykdq?=
 =?utf-8?B?U0Z6VjN1bE9EWVpUL3NFR01IY2x0WWJwcUlzR1hSaDNwZVhYWFJvT055WG9Y?=
 =?utf-8?B?NFdxbDhBRTNlT2N1UlNzUXBxeUM1WUJFYjZSM3RJVWNidEdDT2cvaXBZckF6?=
 =?utf-8?B?WXZCS2VQOUVoTWxkbE9UYmQ2aXRlRER6R2pyTEJqWFZvNEgxZytRcThVWVRH?=
 =?utf-8?B?TjFnOHlwOUUvL09ad0E2ai9IWnorci9FMW1tdm0xMjhsZ0FLRWtFWHErWW5z?=
 =?utf-8?Q?KDEqRLJhzUZ3P?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda0b506-0819-4db4-688b-08de67edbbcd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:13:09.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6695

On 09/02/2026 14:36, Derrick Stolee wrote:

> On 2/5/2026 11:05 AM, Matthew John Cheetham via GitGitGadget wrote:
>> Teach Git to also log process ancestry on macOS using the sysctl with
>> KERN_PROC to get process information (PPID and process name).
>> Like the Linux implementation, we use the cmd_ancestry TRACE2 event
>> rather than using a data_json event and creating another custom data
>> point.
> 
>> +#define USE_THE_REPOSITORY_VARIABLE
> 
> If we are creating a new file, then it would be best if we avoid this
> macro, which is intended for older code to still work until it can be
> fixed.
> 
> But also it seems that you don't use the_repository anywhere, so this
> can be deleted without consequence!

You are correct - I neglected to remove this macro when preparing to
submit the series. I can remove on the next iteration.

>> +/*
>> + * Recursively push process names onto the ancestry array.
>> + * We guard against cycles by limiting the depth to NR_PIDS_LIMIT.
>> + */
>> +static void push_ancestry_name(struct strvec *names, pid_t pid, int depth)
>> +{
>> +	struct strbuf name = STRBUF_INIT;
>> +	pid_t ppid;
>> +
>> +	if (depth >= NR_PIDS_LIMIT)
>> +		return;
> 
> Here is the recursion limit check.
> 
>> +	if (pid <= 0)
>> +		return;
>> +
>> +	if (get_proc_info(pid, &name, &ppid) < 0)
>> +		goto cleanup;
>> +
>> +	strvec_push(names, name.buf);
> 
> This is copying the buffer, which is why you release it later.
> 
> Question: could we stop copying here and use strbuf_detach() at this
> point? That would be a very minor improvement, so feel free to ignore!
> 
> I took a look and rediscovered that strvecs do not have an option to not
> copy. I'm thinking about string_list. I'm not sure if there is any value
> in converting your code just to avoid some string duplication at this
> scale.
> 
>> +	/*
>> +	 * Recurse to the parent process. Stop if ppid is 0 or 1
>> +	 * (init/launchd) or if we've reached ourselves (cycle).
>> +	 */
>> +	if (ppid > 1 && ppid != pid)
>> +		push_ancestry_name(names, ppid, depth + 1);
> 
> This kind of tail recursion could be easily converted into a loop. I
> usually prefer loops to recursion when possible, in case we want to allow
> an unlimited number of parents in the future.

I had based this on the compat/linux/procinfo.c implementation which
also uses recursion to walk the parent processes (and also defines an
upper limit to the number of processes to walk).

If I were to transform this to a loop, would we not also be wanting to
update linux/procinfo.c too?

>> +cleanup:
>> +	strbuf_release(&name);
>> +}
> 
> I got a little confused by the lack of a .h file, but that's probably due
> to the extra magic being done at compile time to pick this file on a per-
> platform basis.
> 
> Indeed, trace2_collect_process_info() is defined in trace2.h.
> 
> Thanks,
> -Stolee

Thanks,
Matthew

