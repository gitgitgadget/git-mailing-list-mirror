Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020126.outbound.protection.outlook.com [52.101.191.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68C2080C1
	for <git@vger.kernel.org>; Wed,  7 May 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649429; cv=fail; b=LPtURVUPEOY53mti9N9z8BSVkk1KBDWn67lirg+gQl6XW+4I6si/0S09bodfxhyW62RBzoUvPh+T1blkvMM6h3ZsqDBDCI03I8IQJ+H7in+jqNW97+LlTp6ytgAnvfQ0m+IGT6w6lROWn7krPfbjixvZHpHgCmGOhEY8hj+EuNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649429; c=relaxed/simple;
	bh=SVGFFLN/i8hAk2dyV7sxUD4Z8K8MC7STpxczFMYvG9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aIWYk2BPXImuWN8lCH37+N8gQSGWnotZW1+0oc0IOZUjclSfdy1jX2O/8A6240SJMWjlC1QKi9oZSCoxavy11AK99Ii9BHHr8uFbvywoGt3yRrxRj4K3UjiMyHAx7i+F7GravSsyEDThIAbLXoHUg7X1AH9XpfI03i+0mhVhx9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=cJu1GB7B; arc=fail smtp.client-ip=52.101.191.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="cJu1GB7B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfTzu3AF1b8bxFjbpQDl6G0qUZy44lC1sUTQYGVLjye3wNxeRE8D0th7Z47uNKvvUUDFBsXxXxOs5DdIGP1ZcbrRrNFWFs+mwN0Lb8x1v8ZRyQeEtndmVFgEpfaAt8golpLkUEAzYXviN6GU3f6L/JQ+vBOQvEiqdYZ2Cc4M/zgA9nTNMv2SYbXseYQy1iHR1szCoICiGOr/6yZMHiTlA7a7PKA0xOFt2bZ54DegLye+ho4I+tzfFSJd8Pu+WdT6/HYBFNQHuPH1BvNLr6L4qMfRdfBUo6WX13lxQJd8ciO8liwt5+jmgI7UFg50Y+JVcoUxjBPJk+ZSqDJ9/AmhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3PK6HsooV5WqOVBAPCg0KwONPJPtTza4u+K/gj6rPA=;
 b=EmN/tv5MqUGPywFynxAdADuKZUu9OkSYk9vXj1PE9Pkp29cf91pxVTSkmfFhl4sd/8aD2I9/VG59tAu15Sz9GTX4wtNE7KFjY+wf1KMZReYyw3T6pZfXRRR68Ehd9JRriPqs0DARvmDXkoRxCcIroRRIWddMtEgCAM0QlBAW7HiWGngV2zkJ2YiXDqziyyNXK4QUfSFpRoOf+2XezgPCGPJk1WyJtfU0uHSmASUtYFKxxDkfh8oR2cwcqwLLctSnVVhcp7g3r84sqgntCE6t6BM8xVEq7blIc8JzDGZ+QyfHHHvEye/TbyweW1dTTvhS3UyHCmI6Oi26WrkjcYBazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3PK6HsooV5WqOVBAPCg0KwONPJPtTza4u+K/gj6rPA=;
 b=cJu1GB7B6vYHg9O+d7kCfMsTKS9ckkaHP1DS/Q4XZfrQijQlqXKzhf5EymziV0lwHJ8qN8VCIwczmsdzTDwh4pC/XHNrbe3GzFA23776yjq6TJBPlr05DbmHk3NZGIi+WlZe99BriBCIXrNii07qWQToVWXv2aEUMl1JKLYcwkqH8drGzqUm2vfVcoAyWVMcMXibUNWQgippqR8ABezJkFHUu78sWrW/B7dz7wCiiFRndf7vkzq6enmMcmWnAHPBvpPiH0BtwQeQGH1XQvSEad0h3XmmymyUmpUkTVExSygcTaNHATts3rvcyDLlNEnzmx1obl4kZFmbjOS9rWfhGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YQBPR0101MB5424.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:47::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 20:23:39 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 20:23:39 +0000
Message-ID: <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
Date: Wed, 7 May 2025 16:23:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <87ecx0ijqt.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::24) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YQBPR0101MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: e67243d5-b466-4e11-b323-08dd8da50d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qys2YnhWYmZMSU9lVFlHbDFZdGxTMHFSQkNpQUJhZXVpYktZa0U4TjZyWUJn?=
 =?utf-8?B?YksvYTlzMmo4Qi9HdnFPZFZ5ZG9CNUtLajRFK3hYREZMcExMcVR6MXlLSlh6?=
 =?utf-8?B?Q0ZUWW4vWElIM2ZhTFd5dU5lMTZpSlpWTS9KMTF2RnhnMlRCYjFydjcvdW1v?=
 =?utf-8?B?WVhCeXNCTm43VFBqRWw3R29SS010SzBpVE15RlUwaytGVGxiU01Eb1ZHL0Ju?=
 =?utf-8?B?eGZJNnVhenlJc05EUGdlK3V2WHJNbTg4NGs1bWNuYThqSXNwdG5NR1lET2Vp?=
 =?utf-8?B?UExFYU1xK1ZiUkxmSEI0WDZnRTRxRW56QTNtc29xOEJPYTA3NG1ZNHNNVXg3?=
 =?utf-8?B?ZjM1VUhSQlJDVUFBSUFlb2ZJZzlhM05QM004V3ZQbjlYZkEzVXRCVGdNQ3NV?=
 =?utf-8?B?Q1gxbzdhRmUvU0IweXI3RVdDcHR1SzN4TUoyQlR0cVo2cnhoNjlOMHZZaTlj?=
 =?utf-8?B?Q2thZHBtd2hBQkd5TUc0dUNSd0lQbmh6ZE9JNnR0NEpKUHBxdmlEQ2pNbnpJ?=
 =?utf-8?B?aUVqMXFnVkdmSjdydFZTYk9scW1PVnRpNVhqbDZXM1cwQkVhYnVPeE5aeUlV?=
 =?utf-8?B?SFZad1BCVWdtbW16Tm52ZXdlR2RvMFQzYjlpYmJ4bkU0QzRNUk1nOE8zaWVZ?=
 =?utf-8?B?bmg0ZzVXWWRiVytNemJrMjh3RHprMkszcVk0RkJ3OG5qNXk2Z0VPUDRBSCtQ?=
 =?utf-8?B?dWxPb3h0SWhTTzJjYUYxYTJBaXJHQmpBdk4wWDVTc2F0dEFrQzVuSTAwcEw3?=
 =?utf-8?B?RlB0VFVXejRSdG1McUszUThmMUtkaWd4R21CRXdhclNWd3AvV3ErVFgyOTVX?=
 =?utf-8?B?akx2VTJJVW5oTUhiRG9XM1MyV0xFSEtTOXRFWnlOdjN0ZDRMSUo4Y3VPT2FJ?=
 =?utf-8?B?djhWQU8wb1Rubk80cFczVUV1Wm1kWitCZUlSeEMwSDVZZ2s0bzV1cnc4VEYw?=
 =?utf-8?B?OFc5aW95SU1wVlljSUJxNy9WL1pZVlYyMURWa3VRTDJrRFN3K2dBcFVneDdz?=
 =?utf-8?B?UURTNG9iQUo0YnNYY09wNithbWJuclNOcGhRUlY0anRqdGQyeGt3N2VZSFo2?=
 =?utf-8?B?NnBhaHo3WGxpMVVZS0FkUjQwOFNuNzg4UkFiam1XclJ0cUZnK3pRU2FjdmRG?=
 =?utf-8?B?V2FqOXVnZlVNWUU3cHFCSHZySmppSktuWllqTG4yTDlCR3BFeU4vSjN4Zmda?=
 =?utf-8?B?QWtuM01PWXhUMUpjNERoSjJiUmFSWVNtd2t1RnUraG8yYmt0clVXa29XMXE3?=
 =?utf-8?B?dmFURU1vWGRheUt0WTJpK0xTUWJ1RmJrVXpHb0k2bncva3FTbDdmSlpjb1E1?=
 =?utf-8?B?aEJqcW56NFNSS0psVDA0Q3MvbS96dEozSnkrRUZpWEN4S0t3R0FrYXUwYXQ2?=
 =?utf-8?B?dFU0ODFrY2pnMzFFZUtIcTBiQnZDb0tCZEpDQjRTZnBBQTJXTVpxb0lKbkdV?=
 =?utf-8?B?MnE2RlVyZ3h4N3JMRGFIOUkvRENEOHhXYUJVcExwQ1pQU3JtaVlWMklOUi81?=
 =?utf-8?B?azVHckpMNU5QeXJtU1RZbm5RSld6eHVNQ2tFUXBLR1Y4bkhXWHZZb2FuazdU?=
 =?utf-8?B?NWhLY2YrSHRjbzlpWjNscHR0NXJYSlJwMy94VkhlSWNQS0FneURaVWYwWGtV?=
 =?utf-8?B?bzF4ZDJzUnNNV3ZIV0RkUkZFZDlDRGNrdng4aktZWS9PdWpwRmhmT3NwUElo?=
 =?utf-8?B?VVRuOVNMT2t2dVgzK0FPUXQxd3VaU0k1NDdUUXdwaHZjZndja3REZ2ZRWnZT?=
 =?utf-8?B?TWFybnN3c0kxdDFiSVNVTW5QVnFDOElFWkhscEVBSWJ6YjYwU0NBRldZRW5p?=
 =?utf-8?B?RUMxcmdja0ZRRHU2NjU3QzRlMlJ3dXBrV0MzaWw2bElDUlVoSGNBTkNVNC9T?=
 =?utf-8?B?Wk1OSm03STF0RFAvTDg0THNnZ3c4VG8xSFJ3MnBWdmlLaGN5MmFNOFc0U0Ri?=
 =?utf-8?Q?0dWG1ll3j+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azZLSzlIZXVzSXlnVVZjN3VUaHNDRmVLb3dxZTdaUnV6NThiakV1NVBCS2l0?=
 =?utf-8?B?M21DZEdOUks5S0xlUFRqK0J3QWJDeDMvVmRiWFpiZnBzT0I2MUVzYVR1T3BL?=
 =?utf-8?B?WHZYOG9oUXlFUWtEUzVoSlExSWl1cGxxZGx5RlQ1dGd2V1dLRTJGc3lKVHJ5?=
 =?utf-8?B?OVN3UDlWenpHVVFwSzNBWkRkMElIK3ZqL3RZS3JiNmNVMmxGL1F5ajBJdXlL?=
 =?utf-8?B?Y0FYVFNKUDhnL04rRTRkeEhPVlRDVzJOOEhLL0RZVzI0SjFnZWJDQ3NPVE10?=
 =?utf-8?B?dXB3dVNxai9ycG9JUnpON1dyYUkvL2F4TjFBUWRxdStoMHBWdXdWR3dYc0RS?=
 =?utf-8?B?M1MybjlzekUwN2lEQjA2dy96YUo5MVlVYVVDQTYwdWVxVTljUFhXcE4yVTFw?=
 =?utf-8?B?NHlZYzQxL0xsMXlua2UvMVR3bjhRVFUzeklRWnpYVno3WjJraEdOT2dKdDJL?=
 =?utf-8?B?d3NTTjRXbnY5NWdMYWVTaWJyay9wSjJ4YlhBT0FpSU92SHdKVHV4M1MwS1Zr?=
 =?utf-8?B?SnZTR3d0RnRNa01CeWd1MHVybCtKSEZoR0IxV29NUklYUktvZU5FSm5NZ3F1?=
 =?utf-8?B?QTlTTEJ1VHJQSER1ZlhSb2ZEeTNRNWhsM1dnMWszdS9EUGh2VUwwOGJ0eTQz?=
 =?utf-8?B?akpvZnBlVUNGdkt4N3FmV1dUdEUwYmkvN0R4aHQ0ZHlZcjNVQ2VjK1FFbFFI?=
 =?utf-8?B?L1dQVG5HMjN6bVVjdGRqaDZKc0JZcEdrTkFYaDhkcGk1TmRtQWUzNmtpYWpO?=
 =?utf-8?B?a0s5cDJHRnZRem02STBqU0pUTFNEbFpPK3hDV3dDZS9rakxFYmc0eTBmWDhL?=
 =?utf-8?B?b1VOaXVsWmZwY3E1bjdjU1JRaWVyZUg1OXNRTzJhRFBlSGJkMXdKenBPYlJl?=
 =?utf-8?B?WkMvcGNRQVpDUVdWaHBPRFArcFFBdVRDTnBScWxRcWI4VWRTRXVLRk50U1JL?=
 =?utf-8?B?b3NyMFNtQ3VLRzNRbmNRanNoMGdiblFKQXlKWmYyamJmdWRuRWducVNYZUc0?=
 =?utf-8?B?bTdLTWdnWlM3Y2VmVjBoTmxaM0NqNFhwVUtUWFhVN3RQZE54dDJLbTVGOEZH?=
 =?utf-8?B?cktpTUcvcmRYOHV2MmJtaW91OEZGTjQ3clpQbGdacmc3WndpYWNrTWFkeG9r?=
 =?utf-8?B?M2FwWHBSTHBBV0xXYXFKeWptZzdJM3JiMWhvOTFEd0tacW94YUVFY3pORUVH?=
 =?utf-8?B?cFlqOVpoc2lteEljemRDZFM0dUIrZnBqclhUUkxPUmFpUEo1bmU3VWlaS1c5?=
 =?utf-8?B?T1pmMHlOMnZQeDVNcEF6aEQ1bTVpK2dJa2FTb08vc3pUWEhzK2JZdkt2Tk1S?=
 =?utf-8?B?QktKOHdlWWpUbFJWVS9ycGw3eW9qcHhnY0dEVjJUWkg3eWdXc2JNcjZsbndp?=
 =?utf-8?B?Sy84WTJLeE1pWDdrZ3JkbWV6SFFvbUNHZm52TFZ4MEphY0lBNWhpcDdOdlZ2?=
 =?utf-8?B?ZGRNL3JFV08wd09kU21GV1JGWUVEVHhrbHk4bXlJL2xFZFg4MGNCc0NSNUpx?=
 =?utf-8?B?cWpBbXBsWktvSGlmazROblVWWU9xUlVjNVdvZHZZTXF2M25HWDVDQW9jUEo0?=
 =?utf-8?B?dzl3bFJ0KytPNkNDQUVMdjluZ2ZHdHJGM3BBd1E0WWx0VXQzcVNYRG1ma1Zk?=
 =?utf-8?B?c2s5NTVpRkZkQksrZ2JnUnZoVnhzYkRTZkVRdDFGNzB2SEtkTndleGdibS9Z?=
 =?utf-8?B?SURrWUlDU3ZLSWpEd3Jiak8wNWdIeCtpWml1MmFjZ0swOUFPL3gxQzAzQ2Ra?=
 =?utf-8?B?aGpkaHBFMXk5akFld2FJMTlJVDZMOUZGK29YRUMreGoxS0Y2RmtjZStvM2pO?=
 =?utf-8?B?amtWU2h6ZU4yR3JMSEt1SDN2TXdUalg2RVdOUEZ4SFczNHpST3AwdHpvMnVo?=
 =?utf-8?B?UmtiUkFRVHM0aFg4U2hXb2RTMUU0M0ttVjUvMlU3MnBaTS9CN3BiUWRDNXNq?=
 =?utf-8?B?ZEs5OXZ0MmJBQStoMU9Kc2RFUkdDRTlvMSt2VFFLcE1LZkZLRUh6cVAzMi9v?=
 =?utf-8?B?ZU9BcXkyN3dSK0t5VUs1RDFlRjR1WlVKQlhURkRaVWVFRXRUa2x4Y2U4dWd4?=
 =?utf-8?B?dWE3RmFOUVA1K0d2SE5sMC84V0tNcVhoL3F4UT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67243d5-b466-4e11-b323-08dd8da50d2a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 20:23:38.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: projUqCvvI8vyr90srCA6XPQmsYt4/tBIdYvAk7eMJeSAIQSPtT4DISigVGaWUSg2vDIwOpWvDuHeO9pnBNPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5424


On 2025-05-07 10:22, Toon Claes wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> I feel the need to get some bike-shedding off my chest, though:
> 
> Always welcome!
> 
>> "blame-tree" would be a terrible name for this command.
> 
> Do you feel this way because "blame" as a negative conotation?

Good question, but no, not at all.

My concern is about having two commands to do blaming (or "crediting" or 
whatever anyone wants to call it), instead of just one.

>> I think that if Git ends up with two blame-like commands it will
>> merely solidify Git's reputation for obscurity.
> 
> I think "blaming" is a well-concept in Git, and many people (familiar
> with Git) would understand in instant what `blame-tree` would do.

I agree that blaming is a well-(known) concept.  I also agree that most 
users would understand what blame-tree would do, *once they find it*.

But I think that's beside the point I'm trying to make.  Git is 
notorious for making users learn countless commands, and having two 
slightly-different commands for blaming is just going to make that worse.

I mean, from a usability point of view, it makes much more sense if "git 
blame" simply understood how to handle blaming a directory differently 
from blaming a file/blob:

Want to see which commit last touched each line of a file?  Just run
	git blame path/to/file

Want to see which commits last touched each file under a tree?  Just run
	git blame path/to/directory

Git should be smart enough to figure out what to do from just whether or 
not the last argument is a file or directory.

>> If this is really a form of blaming, then just make it an extension of
>> "git blame", like maybe "git blame --latest".
> 
> I'm afraid that won't work very well, because the code is very much
> different. If naming is the only motivation to shoehorn this in, then I
> think it's better to rethink the name?

It's not just "naming" but rather trying to help Git be intuitively 
useful to users.

Also, I think sacrificing usability because it makes the coding hard is 
unfortunate.

I personally think it's fine for blame.c to contain two different 
internal swathes of code that do different things.  The ~500 lines or so 
to implement blame-tree don't feel like a major burden to me, especially 
compared to the ~3000 lines already in blame.c...

But if combining the two features into a single C file is too much to 
bear, perhaps refactor the existing blame.c code?  Something like:

  - blame-file.c (the existing "git blame" implementation)
  - blame-tree.c (the new functionality)
  - blame.c (exposes both blame-file and blame-tree under "git blame")

>> Otherwise, please come up with a new command name.  "git latest"?  "git
>> "latest-revs"?  As long as it doesn't use the word "blame"...
> 
> I've been thinking about this a lot more, but I failed to come up with a
> better name.
> 
>> FYI, here's Peff's original explanation[1] of how he came up with the name:
>>
>>   > I wasn't sure at first what to call it or what the calling conventions
>>   > should be. The initial thought was to make it part of "ls-tree". But
>>   > that feels wrong, as ls-tree otherwise never cares about traversal.
>>   > The combination of traversal and diff made me think of blame, and
>>   > indeed, I think this is really just about blaming a whole tree at the
>>   > file-level, rather than at the content-level. Thus I called it blame-
>>   > tree, and I used the same calling conventions as blame:
>>   > "git blame-tree <path> <rev opts>".
>>
>> To me that reads like an argument for folding this into "git blame".
> 
> Forgive me, but I think folding into git-blame(1) will also solidify
> Git's reputation of obscurity.

Please elaborate.

> I think `blame-tree` is a fine name for this feature, but in the end I
> don't care too much about the exact name. If we end up naming it `git
> last-for-each`, `git annonate-files`, `git log-everyone`, or `git
> when-modified` ... It's all good for me.

But then, why not just expand "git blame"?

I feel that the
	git blame path/to/directory
use case I mentioned above is a compelling argument to fold the feature 
into standard "git blame", aside from any reputation-for-obscurity 
discussion.

		M.

