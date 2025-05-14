Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020114.outbound.protection.outlook.com [52.101.191.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE92040B0
	for <git@vger.kernel.org>; Wed, 14 May 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257340; cv=fail; b=oq6aKseJi2W55hXtjlm9Bjui/dhxjp4zhdw3IgcleK5y3LqiMSk0+jpKPVUh/JB1eUk1jfbrTWN4/OyHYwgolP+JFBKBBbsZaVldAqHWR6FXXHKPbiDKfsQPb9Rrtb/qofY0qVikcy6ICviOxrOnxYoIgyCvZIrlPzaUhgfo8xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257340; c=relaxed/simple;
	bh=4nMSPTBfqRfNQjFXQwXcIVlcT8j6cJc1KEZL/2rzUQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=okyQ1nXt1eDt1iIFy07smGqGR5o8UpCN1pb+2VY/nDRShlFXq0swWild2pzSptb3LMlg50vM4yDS4kTj5lZ0RCOzaZnSoqQ6iunfTVgkdPQ26IftCJfQYF5ByOrMi1v1iZUCcQk0DOoIg5kPzcIf1tDtbmhR+hEuZ7Dp/rf37go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=cqhF+VnQ; arc=fail smtp.client-ip=52.101.191.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="cqhF+VnQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti3uGE2WcrSS1enMnn+GYeG73+dW0fNWZHY4iH0p86Ptotgl0ZNV4KT2UUofoWlO2Cjq8B0LBWoiPSNNl4DLvTy3R7vz0TuAZijoP3+xEY3ghhY2Ens/4yzJXUrG5jxGBO0v9EOs3Zey+ZpzUJ9SjawdJUcvIlQW66JHxZqe3BwnGR++u+vJdHqbb14fGwjD0vmk0bd371kbN/n6PoIJnDezJHRyY1Wl0jzqm2cYa20Q/smN2SLEnRSik9cRCcDPq9Y1i+YpsTF9uowwu0wf1VWXRwxsIqVCIHImXkCXGUTvZbEdLOU6ejV9rMZ6HKnAmuluJGAKWbRavxyBHsPGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeQdBI1UT7wLHjZcKXEgptupVsAgyyT3GQ9yaTby6Hs=;
 b=gm1XF9IJxK06U1yKQGZEZh2hscAewlWOC5T4QL17YcRJmGN80u7oSBtutp7HEUEOco/nwMDXgyUheFGjAk4MWUmgKc+TBl4iFQQXGXywxkXWwq1zAt9bsQLaPi5GbcdNrrPY3m7GTSb2AKeGQu+P1SyM2tIsiNxptxjT78J0pB1xLZvcJctS6JniAiU3tNpI1Ibzruu5f925IfrGwUPntkGDZtFXRmdSc3N4R8bHOiqmec6EEpaf6+dYto9f9MNkD0oXb1DvLaw+xyv/KiTlzbuJ2Dj1qpavxoWPuTzWuqyFkcA/bVe/u2cPaNk6mUqMPBctBD6e18p1fsLRfLmL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeQdBI1UT7wLHjZcKXEgptupVsAgyyT3GQ9yaTby6Hs=;
 b=cqhF+VnQyuIgNxxYK8xj1rzkhXbR+e8Xb7bORhSTARfqL1eDr8Qogz/1wb/2AsC08ivsgI5G+028inIQSv5IDRfSj3tS94s9QlzgkspRurPkKBReA3xjj7bJ+M789gn5xDsiAd1Ruc2lSMzMpVo3Dv8J2rM/xhok8cn16H5nU46JfUXz+pcJOOZMiC+GsoKXnGGud0whDjw+2IWErHdgQ+yUnziXiX6Xx/c28af6I56QK3YGdITjIAm6y3oAZxI+1xP8N3oPVWq655PUNtmuM5i6GGOS89AVm3p4MWEWnhByATlmayIuH4uF1puobzhHqWehf2qplR6B2vlhUglT0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YQBPR0101MB6304.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 21:15:32 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 21:15:31 +0000
Message-ID: <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com>
Date: Wed, 14 May 2025 17:15:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com> <874ixnjltf.fsf@iotcl.com>
 <xmqqy0uz7zzh.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqy0uz7zzh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::20) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YQBPR0101MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: c44a00e2-dfae-47d8-d0cc-08dd932c7579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2hlSEh6Q2ZxcXJGTWpYU0Q0S1B2SG8vQm8rYjZ3V29FYmJGelpFOFNudHIz?=
 =?utf-8?B?MHlINkI2MnQ4K1RrdGNHUnc1Y1dvbkF5eVV6Z0xIaVgvZ280ZVhXNTZoY3dm?=
 =?utf-8?B?eGYwSDdUQ09PbGVQUUxOTnFIRFpzNWlxUTF2RkxmTDVDRndTbUY5MnNvWlli?=
 =?utf-8?B?UGZqeXpHYSt0Mk5pdnRkM0p6MkNNalpDM2FITGprcThnYkVRRTNZY1hGTm41?=
 =?utf-8?B?bGs3azJ2U2xkTDJZdFlaNTJoTDhTaTF4ZjB2M2dXdlNJeUFSTmpIKzF3b2Rr?=
 =?utf-8?B?akZuZ1MrMCtNQnRrbDZkODIycHRFUnkzUDgzTnkya0hHVzhCaTR4aFpHZVlo?=
 =?utf-8?B?ekE3U2ZFaGRHOHJmRERRQVVrVktEcm1seDJPaTE1N3JlMW01THV6Q0p1eCt2?=
 =?utf-8?B?c2U3b0ZPWm9ubjFnY3JjaElNN2pGMm9OSEVxaDI2Y0VXaGE3U20wcm45RFMr?=
 =?utf-8?B?WVJNWGFZbzhPUWRHNVFaWkxnOXZ3QjlybEFnNmpsRDhPUE1WTzF1ZHRjRUdP?=
 =?utf-8?B?M0pEQzMzR29FTUMyM3ZjODhkbVFUb1Nvb2cxdmp3bm1rZjQzZThTT1djeXhI?=
 =?utf-8?B?NkhES2xtZlhPVjhBTnNCMUlYQlBQVTZnTGo5UkJrRUZSYXZ3dXlvcmp6Z2RK?=
 =?utf-8?B?NndobTl2R3NCcitkTG8vWmtYN0lZMVJXN1g0YlE5L0FUcEw0bWhBUTRXMU5W?=
 =?utf-8?B?VG52emJaMUE4TWdpMEtPaSt3ZVpkRWRpWkdDWk44a2hQOHM4U2Z1ais2cFFL?=
 =?utf-8?B?MitTdC9Kdk1CMDQyTnRmdmphYzBzcmtiWk8vUlJvZVU4dWlYcWFGRFdRSWVk?=
 =?utf-8?B?RDk4bUp0V2JLNzlXbXRoREZ4WUErYktIVFpja3l4SVZYRUxvdlJROE9lQzJa?=
 =?utf-8?B?eW45czQvcVZHNVQvejBxNDZOUE1LcEtrT2RYQUNSbWEwVVNwVlpZaWhobTkz?=
 =?utf-8?B?MFpuRXl0Ukp3YzNtREREbVJyRW5QV1plblhrRFdRcXB1THVQMDdjeFVTZTh5?=
 =?utf-8?B?dkxHYmk4bXluSERUMTdiMzdZQU5mcldzMGZMOGR2aXhnK202bUozbkFwKytJ?=
 =?utf-8?B?aVhzeFlwQ2htVGZXV1Q4VDQ1UUIweUozUnJnK3R4MlY0c0FsYVB2TVl2dk1O?=
 =?utf-8?B?SmZ4YlFEOW50aG1pTFJjMHorbWFlbXJHV1FFZWJLVmJIdTlYWFlQQXVUaHFi?=
 =?utf-8?B?WnRzUWRWbGczakE3VEUyV1NrVi9TcFdNTms0Ny81eEVtenZvV09xMGY2dzVr?=
 =?utf-8?B?YkRrSFEwZEFaZmF2VFFQc2FJWi8yVUpZeFV5RzJJcURxLzZzSmZzWVpCcXdC?=
 =?utf-8?B?OG9GY281ckQvWGFzR0YzRFhKK0VUbkRpcXQreWNaUnVCeVR2UG5wOVErSWIw?=
 =?utf-8?B?UHFORUJKeUdVNTQyMmVCUzVJSUpMRFYxWHhmeGNoejhPbmVIT2tyUitXbjFI?=
 =?utf-8?B?M0czbkV0ZURoem9CN0hxOHVSK2hleFI1KzQyUXIxSW9oTmFhNXdUWHlIQUFz?=
 =?utf-8?B?RkppT2FJKy9hY08xamNMd1BPM24yajVrZWNhbGVKTVBuay9sNytacmZlcmFZ?=
 =?utf-8?B?VWtDN0Z1TkRXcVkzLzVETExlNTQxdzU2d2hXQjY0MjdFcU16V1pheHpEYWUv?=
 =?utf-8?B?V0h1SGwwTTZMdkd3SGpQLzliRnR2cFlYb1Z5OXB5Zm9xdjBZUVZOVmpBdTB3?=
 =?utf-8?B?MkhTS3l5UnFvYWxmaGZKUmJEV3dxbU5mRHp2YVZmQmhGa1BMV05oMEw0Zm9p?=
 =?utf-8?B?QjBXQ0xBcTA2cnFjSDMxUFI1Nk1qdWJpZ0tobVJyV3d6NmxWU0swYksxNFRY?=
 =?utf-8?B?RWxWVEMwa0hOMDBtL0R2RVFUeWhKOGVLS3BsS253R1JCTE9lQWRXdWd2SHVm?=
 =?utf-8?B?TndIQ3lDcmJEL045Ym1BUVNRZkdjODlvMUtnOHNEWE40VFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0hGblMySFRYTlc3UnJBeURYWStOMVFwMkUyajlMaityWWZvVGpDeC9sazBW?=
 =?utf-8?B?U1lQQ2hpam9lc2lhK0FTbHRaQU00TktmcUFEQnJXbU5JM2NhSkE0N0tVeGlt?=
 =?utf-8?B?d1VHUjlFa0VKUWJDVHdIS0xQL2lLNzU3eU5KZ1JiZTYvQlo3UzBQR01OWWgr?=
 =?utf-8?B?NzJOK04xSUZwU01MUTBRSk9QWnFuTVZ6S25sRVhVVUViV1BJSjNDbS9peDVJ?=
 =?utf-8?B?Q2hhVm1uYXpLdm1kT1FsSjR6clJrN0JJV0JBM0RsdHZ5bU0wSUdIMmtmOTZu?=
 =?utf-8?B?N0pBVzVPQ3lXd20zbTl3MzdIdDhBNW9xSkhTOU5xOVVGV3JGT0IrdnNxcS9h?=
 =?utf-8?B?dzFwbEFQSmMzOHBwbkFNRC84cVc1QTBVaUhCZ0g0MDd2QW4wazU3aGk3bHF4?=
 =?utf-8?B?VVFqYm56VzN6NHdxMEhMNitXV0NOTlJDNmg4eGI4WVRIajJ3Y1ZjR0tzcHkr?=
 =?utf-8?B?ZmFkSkFyR3NpelNIVGxBcTRJMS9YOVRjQ2hxcWdPd2dFMlFlRVVVLytrSGJl?=
 =?utf-8?B?MEJVa3hyRkVWbjRubXgydUlnQ2U2WCtoMlNyV1FBbVpFN0lVanhndEl3T3hH?=
 =?utf-8?B?TUp4K1paME5GRFBLSVpTNzlMeHp4b3NpREpaYlZ6dWo0ZWhNMHNLL1ovbUhw?=
 =?utf-8?B?aTlzejlVdTM5cFE1Z2wzSDh3OGVEcUNvZEdMQWJYYWw3Zkt3RVdGQWJLUThz?=
 =?utf-8?B?WHJJc0pnU3BBaVJBRUNMZjNhYjNFOFp6cFJqNkNmTHZZWTJueS9EOVJ3M1VR?=
 =?utf-8?B?Y3VBenlXQ21FMEk5RFQveXJCclE3UnRTRjI2cTRYaXhzN1llUjB0cGVCSmJK?=
 =?utf-8?B?ZC8xc05oaDF5Ly90QVpoN0QzbmIrZEsxY3dQd1VlZ01Nd2hFL1Z4Wk5DMDk3?=
 =?utf-8?B?ajlKUU9ud0Z3SjVJenBBZ3JNdFl2MVFIYkNsVDhQd1YzMDBpWC8reEozR09P?=
 =?utf-8?B?QkVzOUxkNmhyZEJNaDFLeXIrSG9yRXJOcnRzZ2NUdWVaQ2ZJSDBYUEpCRmZw?=
 =?utf-8?B?WkRVZHlPU2YyUUVuMHgwMmdIUkRGdG80anlpdVNGM290dmxSTjhRaHl0dGdK?=
 =?utf-8?B?cmVuVWo3SUk0RThpNkxqWnoyaWJxc1BBaURjcUN1Mm9ybGhVOHVhUHFlQjhQ?=
 =?utf-8?B?WGtrakRONm1UYTF4dWUwUkRRbFZSRVBIdW04bTRmaTJWY2RNQy9TZzU2Nmwr?=
 =?utf-8?B?YWVGcW00VzRCVWJBcS92TmZ4YmZ5TWFZRWVzOHk1Mit0T1ZXY1FnWk5CK2Yr?=
 =?utf-8?B?bVJ4Z2JmWm91c0MxRVMydGlwa3dEZlB1aGVrVEdSODk0T3RmSmt6RWsxUk44?=
 =?utf-8?B?L2pCLzg3NEhEdFUvN3ZDckRROEY5Q05sRmxKd2JpWFhFdFV0RkxSdXVBSEg0?=
 =?utf-8?B?Ni90akdLallJdHVQVWpNc2hxTXV0V1JGK3ozU1ZNY2VFZXpSd2RsNDhwVkRu?=
 =?utf-8?B?RTZXanVBRFRCWkF0TElaZGNtNEhETHd0Sjd1VlFoenNzMG56STZhRXQ2TFEy?=
 =?utf-8?B?dmlBczJ1dUc5blA3QVZPaDdabTJjQS9zSlBGM2Zwang0a2VHS1A1OWI4OW5C?=
 =?utf-8?B?dmFLWFBVK0phbVdaWjU5MFNNdzIyYjNPUC9IOVBRWjVlNGt4V3hOME5PNng5?=
 =?utf-8?B?czdJNkE1SmRDbnRDVzR6U3lBRjUxOFNZd0s4cEh2ZlR0OXNxWTFFdzBHcFl2?=
 =?utf-8?B?U3EvbzkxclVXVGVlaTRKV014d1JNbXpUWFZnaGNDUnVlcko4d3RNeitmWk43?=
 =?utf-8?B?NXdHS3hGbXRkdGU0d2lEdURrSzYwdDlGdVE4Wks3V3FiVmZkaGIxemhkQW8x?=
 =?utf-8?B?MUFGV0FsbU9mbi9QWW5EQXdwV1RPK2JrRGxOSG10WVQ5a0ZxM0Znd0RzWlNL?=
 =?utf-8?B?SDhJa2JzYm9MZUQyeEFQMndvaXkySzRIWC92SG5vdUU5V3JqcDB1eEt2dmh1?=
 =?utf-8?B?V3NTaVpuVHk2bHhrMHZTY0pQY2hxNEtySHFrOExMY1BtcjRMTzVoSm5Pai9i?=
 =?utf-8?B?VjJlSHA0SnArN3VMMm94aWxldTZ2LzZpaUllbFRScUYwd0pPa1dUbnpXNXRT?=
 =?utf-8?B?b3Nzc2JvN05GS1liZE5Sb2NjTzhsRWVmaTkyQT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44a00e2-dfae-47d8-d0cc-08dd932c7579
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 21:15:31.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJiK0hfjSgLgAzwroDe/96KTCcgNQsYYTcCAJRObA2hEn7sLAbiF1ZTtz2xmMP67o8Mh/XOuKTjaq2uMI+nK8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6304

On 2025-05-14 15:29, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
>>>> I thought you switch to blame-at-the-file-level only when you are
>>>> given a directory (or a tree)?  "git blame path/to/file" has ALWAYS
>>>> done "blame these lines that appear in this file", and cannot change.
>>
>> I don't know about that. What if you want to blame multiple files:
>>
>>    $ git blame-tree refs.c refs.h
> 
> I do not mind "multiple files mean blame-tree mode" as a yet another
> heuristics to tell which mode we are talking about, as "blame these
> lines" mode would take just one pathname to a blob and never a tree.
> 
> But the topic, IIRC, was about how "git blame" (with 'blame-tree'
> feature rolled into it) can tell which mode the request by the user
> is about.  So you should have said "git blame refs.c refs.h" above.
> 
>> or (letting your shell do the globbing):
>>
>>    $ $ git blame-tree *.h
> 
> This one (with command name corrected) is questionable, as there
> could be a case where there is a single .h file, in which case, the
> command line would become "git blame that-single-header-file.h".
> 
> Again, I do not mind "even though I may have only a single blob
> specified on the command line, I want the blame-tree mode" command
> line option.  So to recap
> 
>    $ git blame path-to-dir	 ;# blame-tree mode for paths in the directory
>    $ git blame path1 path2        ;# blame-tree mode
>    $ git blame path               ;# traditional blame-these-lines mode
>    $ git blame --tree path        ;# blame-tree mode
>    $ git blame --tree path1 path2 ;# blame-tree mode
> 
> would work fine.

I'd be happy with all of that.

> Having said that, I personally do not think of what "blame-tree"
> does as "blame" at all, and there should be a better name for that
> operation that does not use "blame" or "annotate".  So a separate
> command that does not even hint it has any relationship with "blame"
> (because it doesn't; in my mental model, it does not do any "blame"
> at all---it just does "git log -1 path" for many paths in parallel)
> would be even more preferrable.

I'd also be happy if instead this came in as a new command without 
"blame" in its name.

How about [[consults thesaurus ...]] "git ascribe-tree"?

Or maybe fold it into ls-tree, e.g. "git ls-tree --ascribe"?

		M.

