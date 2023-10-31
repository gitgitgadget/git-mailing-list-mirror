Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2B2030F
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="OhEHBV+x"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2091.outbound.protection.outlook.com [40.107.115.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A118F
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKOOh7Xqr0UOfKiyjJfWC+bm2albtCy/yQvCdfx4OxLuoCZhkTVigcxsvkCG697PABdb16kUSaODt5MI1tT51BVvqeVrYMW9mK1MLW8A1BP/wqXPUaV6AcKLuSuM7zKjy2unHpXt+LOj/5jJzUIuLxjpjFo84XNaHKV3HjeCS482mdsyLsbECupMIOiPL6RZYk9HUNYslgz7gQR1uOYBbp2l5KQ1UoSzNmUuv2HFrP/Mcn8P400T8N2HbGb/NxiMZ9JMg4DY+tumCBb2SRxhN/eNURlZlmLwyJPj7dpGhd/HLaCGgDL7YgkNEGnNScEPPc4geBVUnPdI4B0on4nIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Pw8pJk6uTVQHzaoh3Z798qaMIDWcXPJS4FfiBA5zQo=;
 b=O2iM05p4ZNuXXuNTrDOy59OVXC5uNhtuBUU1T1eazcXVa63UIGsrSfITSrGY6gOWl2KqsKNNwYHFVavooZiBKajN9fEchR8/weImLN6B0rPY5+GJdjXwbS5hTNM8z+nyxChqdVk0JK9Jz03dcRY5uXu7bes3mriOsmhwAEbNxyI+bC21iXqX+R6pFd0gWS6/6oIJMInyez1oea4VZrLFZuDfnUH6T0lT0CSuDu6T+HszRNlJtm5kBKd7JznXcfDqY0W7eDa8AmhIlXJoQTlnu3kmyMKovEeDlqtMsGYFEcgCiks0lPxlJspeU3gXoE2otAGuHP9w//IsoCmC43s7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Pw8pJk6uTVQHzaoh3Z798qaMIDWcXPJS4FfiBA5zQo=;
 b=OhEHBV+xqr5AoGmOUuNetHVLf/oRDYKI9pEPMAG1/sXzZJKw+KNiF0xQ2Sp40RqcwVIwVblHmB7XIuXQCKKzS/y1hEvedDv+np95Q2f2gV6nj9YljnR9TDg6xrPv+70C+2TS2bVbPMcPPyd9u1ohElaWIPAGiqE4TYA5WzKWR5y6gVVoFMdU2mjmLojYFP/FEsTaA7KqFsZYiGWk515zphTW4QwdcBG6/dTqLhTf2TIzh8HzT8wBzcF3zAobi5HVQSVCtob7yDMZXtWN/zH/7t2Q2qesXdSTSuwTieo96MK0Ts+RADTrfqpLRU2x3sIFudIo7RLwrl2L0eX/dgo+/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR01MB6172.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 18:48:21 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea%4]) with mapi id 15.20.6954.019; Tue, 31 Oct 2023
 18:48:20 +0000
Message-ID: <cc71b825-8283-44d0-a059-f2c069caebe3@xiplink.com>
Date: Tue, 31 Oct 2023 14:48:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <20231025102932.1202299-1-oswald.buddenhagen@gmx.de>
 <56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com>
 <xmqqh6mbod1b.fsf@gitster.g>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqh6mbod1b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::18) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YQXPR01MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0b933c-1fba-4ff3-b926-08dbda41f401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qbsM1NiK8dVyootd37CmnWfaYYvD8/7EFK0kq9XE4ceIueR5atCkO7tizsZ7P2baHlOlMGn7TAji02CEQqz0mq2jjWzv0s2u6ADrEGjZ0kktc0usUTUwr4Tlp8O9AwbnvMdqUqEjwHy/jErSDxPI/8HFO4dGa0oNO5JVLEFnBl2peOj1VsikhN/P8iYqbHOJa4Qz9fpwwt/DuXzg8SSlBuIFpw4eiyrmNoaKDkPFFK2KITb0TUcsydnANPOZmmND4BrK9EE0jt5m1Y+kwwGfpGx/8kiM8jqtC6qzv2HSmmNkjBH6QeHO+Jc/5nDREmsX8zMUutnCp4bQk5i7lzsPBZhaH14PJ52i01GWdyhB6/Oz30d2QthwJltgx11KZoUUBO2nDy1KNXHuKKLE6LWtH7CQxrdGDdFuJIFJZHBnquNptyCgIJ8H+YP1cgEuw1VsF3TlCT/q3tKcmLrve2vJHU10EyRl5EDr5swcJC8Ajx/v8ryHAgjN3k/hGOnOZKRC2Eky23LGukYq/b+SLUazMPlWFePazDx32v9eUZZmNxnC1Ul/1r4bDcNWNEjps/mF2sBq1whsBQz543x8ah3wmWYfK3VAQMbziNDAQkYOH+OQUvcjlrjy9fQzpYsUKmnQQ84xk4XNlnnjJhq5JxE73w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39830400003)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6916009)(316002)(31696002)(86362001)(2616005)(66476007)(2906002)(54906003)(26005)(4001150100001)(66556008)(66946007)(6506007)(478600001)(53546011)(36756003)(41300700001)(6512007)(38100700002)(8936002)(8676002)(31686004)(4326008)(558084003)(6486002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0oxc0kybHFXVG1ZR2tWOGh5N0FUUkJzL21wRkdJWmxrR0F2ZG5ZRGd4NWZR?=
 =?utf-8?B?UFdZMTBOaGNaTy9IcDRLUXZQTEpzc2xjMk5TeTZLTktwWWcrQ2ZkcjlhZG1j?=
 =?utf-8?B?a2VKcmRwRkVaRml4TGtuNlBXSE12VUlZZ1VaazExQjBLU1FaMFVOQ0FqUnpo?=
 =?utf-8?B?Nks5cXQ5eDJrTDh3bDV0V1h0bHhud0RnNE92cThvYTJ1RUkxTU8vSHdXVWNt?=
 =?utf-8?B?MzMwMXBFcHByRHF3UHhuRFNMRGRscCt1MS9aQlo0Q2JHSmhIQ2I5MSs3YS9K?=
 =?utf-8?B?djlpZjhvaDJidzJEdHNxYmN6WDAzN25qMzA5ekd5QjVDcVJzNlE0UGxJcHZE?=
 =?utf-8?B?YzZXemJKeUptcDV6MjV1bU1PbjBlTUhwTDNRZzlySGNMcDY0ZmRkWHhKcnFi?=
 =?utf-8?B?VEQzVmFkUmpmL3M3cUc0SE05R0pOVVpkTVlGR08xeXNNYyt2RnJPTU5SOUdN?=
 =?utf-8?B?Uis0dXdxdXpmZXZoZGRZdk93MFlweXgyRDVaWkpJZkNOQnJRRW53bHpmZVJK?=
 =?utf-8?B?N2prWWtiM1dKY21kWHdhTUptR3dyeWg1ckdxSlkvVzhXSDNGaTdXa3p5QldR?=
 =?utf-8?B?V3RHNUxUbmp3OTN2UVR4MnpadnIySjZXa09oT3hwb1dUbklqSmpxUnlFY0xZ?=
 =?utf-8?B?Q2pLa2k0UGJ0RjFlT0d1T1Rrc1ZmOGQ0SEkxYXhyUCs4M0ZzVUhyb2UvQkVu?=
 =?utf-8?B?SHRNVDdIb2dpYlIwYWtwN1BDeVlJMmxmRTNyQ0VkWkpOTWpSNlk3Rld4Q3RD?=
 =?utf-8?B?ekFTWW1naHBQOHNPR0hkRUdEYUtBT1M3NW9RS3lIY3lSdEl2WENYNHVuSSs1?=
 =?utf-8?B?WUhpVGpXTUpsUnplRXFnKytjVnJuMS9zL2pnUTBRNzhoSVh1dXdQcWdpbWRy?=
 =?utf-8?B?SFZVR05RcDlUb2Z3TWM2UlhwNzFUb1U3bndzdHY4eUVoUGc2aDVQTWRKVkNt?=
 =?utf-8?B?dlFNNTViMWdxRXAxWVl4ZG9IdnhDT1d3OFVQSW5BMjVFc1JzbGptK0dvUkJ2?=
 =?utf-8?B?NEVzemw2L3JicGMycXc3NThiU1VIQzNjaGtLdksvYXVVcW00RlVLODk2MjZp?=
 =?utf-8?B?SUxZcHBTSkdRMjBsZi9LWnNqcENJRWxIRVh2NU52VWZKRmNxMC9aVUNmQllQ?=
 =?utf-8?B?SHpkZ2p0U0xINWcxNmY3UGhtaWFySW5hdklqMWtnN3NIMS9KbWlEWmlUcWNL?=
 =?utf-8?B?MDM2cjZyb2hMYjA1a2ZKNzlrTlV0YVJMUk9xcC9ocUFjTTlRRTFRUDFsU3c0?=
 =?utf-8?B?Q2tsNHpPUEZMVDZjbWtvYkZCc1lzTmR0dVQxV0lkK3Y0Nzc3WWtQV0Z5MzFW?=
 =?utf-8?B?N3c1TW1GSkNzcENKV2FIWUdvUTRNMmJtNTFpWS8zbmMzU1BFYjFIenIrbkFT?=
 =?utf-8?B?bzdIMVhlVmNGZkRIU0M1bGQxcVVUZkZZTFZCSnZLQUxkSjA3aE15NGZHT2VJ?=
 =?utf-8?B?T1RwYi81RG1tZVRSdjBtNWVVN0Rtd0NMYTBYV0hqRzVsdTAxbk1vQk5KMmRR?=
 =?utf-8?B?ZkRZN1JRZGJrZk1lSWJ3SzJKVzFMRkFYaExZRU1acVR4S0oyY2xnYWZzTWhs?=
 =?utf-8?B?YUdsbHpldVBSYSs5Q0Q4SFZVODV5STVHS2UwVnBRZ2tQTEZkelVYZENlQmY2?=
 =?utf-8?B?Mlp6djNXaVYraGNxNUIzNTE1Y1RMYms1RGtic29Ud1lXQkViWldwU2MxTTNt?=
 =?utf-8?B?WGcxR2VEbDd5c2M1MlhPckp2d1VXb21BbldFaExHK2N5dmRGM01MMlc1MHEv?=
 =?utf-8?B?YW5PeXF5Y2JPbVJnZ1ZJMnZoSGEzQXdDNHF5YjFKN2k0enpjU3F6aUFiVk9P?=
 =?utf-8?B?MjBmQzc4RENmZytjY2xQZUNzamRBY2pYSmFxVUh0VmZ1b3BnakNJak5na0Rr?=
 =?utf-8?B?bFY3ZEY0aUxBMHVJbDdxRTVOY0Fpc1N0cVhvQ2puSlNxOFhNVXYzU3IvcTM4?=
 =?utf-8?B?bWxnbC9MY21yZHhwYzU4ejl5ckhmWG1rQjNXMlhVQjBnODhFbXMrR2QxMVBP?=
 =?utf-8?B?R1laWGF6Q3ZkeHEvNklEWVJqUWVyQnorbll0SjJFT1JRa29GSVFRVUNLdzhq?=
 =?utf-8?B?b0tiWDlaV2x4WE1HL2x0eGZudkUyYUV4YzB1dz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0b933c-1fba-4ff3-b926-08dbda41f401
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 18:48:20.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YEojN8ZFFSnrZDTXyq7WfHZyai9V0ASgxex3t6u69OnBfPHh4cpHRAAx3BK/kn4wiJkI3cXCyofV1nsx5HX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6172


On 2023-10-27 19:34, Junio C Hamano wrote:
> 
> Thanks for a good review.  I guess the patch is very near the finish
> line?

Yes.  In my mind, all that's needed is to remove the part about "should 
not be relied upon".

		M.
