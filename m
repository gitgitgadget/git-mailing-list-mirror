Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA223747
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="guWcmv8v"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2090.outbound.protection.outlook.com [40.107.116.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86177CA
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjgu9Ln1gFkRIYEl4DKmGjx1jkewEtF+qsmQ5c4TKJ7d4d2Gl9DiOoSOrWUU7AHVMV0BItdKT37tL3KkGe7mDUD/cfXT/vy6zue0nyzjwYZPFP2I93T9sDLLxObfwYeSy3Vx6hlZGyM3N7wc1Cmm7q3UGiAcKgmCFUwz5sux6WBGcnXcf3xX+h0HQDNloeh/KXmXxHChdZbC1nHnb82b05/xWcntloFKgcCz9ALIYcfqrYxouyqgcxxVXFLyf13TmHKG2Eqo3Ktb1s9tgMHZhIRlXW9rtwEPn8POumRz4uRANTgH2WCBKnpp4IThYCLZMpao200bK+xE9Wkfv7iZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY0sdrF7CSst9XqhSx63nl/544oHGzFP2tmQnKIi+LI=;
 b=Ps48A3x34brBLLDrOj7PNvfdv+FLq5RJ9LnjvoN8PUK3xyfCUkyZcjKTzvAjGTIx9GfncuW9XlSKcIThOO7njV2nHy8RA1ric9ym+KDn33ZsGS1mBKdXR4KxF94ZNYxwqFwtbVxlkcd1CD0srMq+B6wFknb0+k2oYrQLCoiT18RWMg7Lms2CwTv5GY6aZLJV0lgq+zsLLG43oymDDtzZzCuYvYwXBP0lW9yzfcJdyy0TIn87HorHUi8pr5C5aeQDpw3dfKb0Y4389R6EQOtLjjxnuvjuxq0GsSXEQ1yJAbpwDGgw8VZOY9vDhq1AeXfCzw6YBzLDqu7MjkDiQR903g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY0sdrF7CSst9XqhSx63nl/544oHGzFP2tmQnKIi+LI=;
 b=guWcmv8vybjKWS57uSuYVgsip1rQUVig4dEpbIjz0iUCoPx6C6OV6DdYx0YiTXhCIr79iodsoCWmNfYfCOe9UZc/4sYM58sYbCaNQvkWSwZ7bWo/S/eZTWIlFKqFFHaZUvHXQe+SaI7yDf4uX4UaMhrWglNP2LlY8NtkE7OiXReooBccgxVfprnq6s8LybuT584cWdNTFGQZp6Z1wZM0yQRrs3za+6jztkmbH3/y0u6QMmsie8s+Tnfy/EpkWJ6iIbz3vgZkzx6AnfqrXF0heA25YwUwq/WSBu7/8Kvbenmw45/X0yPcgeYL6Tloq4y7IHNjqefRUGRHd2GtErOOxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT1PR01MB8955.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 13:46:07 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 13:46:07 +0000
Message-ID: <3aff8ce6-1cb0-465e-9b7a-db6473713786@xiplink.com>
Date: Fri, 27 Oct 2023 09:46:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: using oldest date when squashing commits
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com> <ZTeZ3KEQLIVU/sq2@ugly>
 <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com> <xmqqpm143p46.fsf@gitster.g>
 <59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
 <70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com> <ZTuw7ziOnTunMmML@ugly>
 <6d100655-ffd4-4282-87b5-cfdd101dba63@xiplink.com> <ZTu6cqUec3L2PpUC@ugly>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <ZTu6cqUec3L2PpUC@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0190.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::17) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YT1PR01MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 825b206d-6943-4086-23b0-08dbd6f3123b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4F1PBHU5UdNlZc59A5+U+vbBvWwIgv4MDE+llvhmEtkS2pU4m8O0NL/NKxaaL80WHB/kpnDFVp6M6jBngDus55PrpFRJdYqn6VwjjuSV5K8E1IEWyF+uUVLTMYi0FJMHJ6MpIwyTcwqrN9Q7ErYAwy23MmUODVvqMAEK9B7mn9HnGHi5NHzKrgloS67jQOJM6Sk0aqr8PbNz1yj/AnevviaVNvhNGeyZQcSa1fF+w87EBfM2xQb6MNODTpFd2SdidbQuAEHHgD0anwjQOFGVa1FGqYU0Ks6HQcpFuQ33HOb2Xr524kwINHhxQoYWN3qhp582Bkdf9Xc/+o1+RzELe8T5VNRQCB//Px1nBXuf2lgvILPKErb8dtFSqjuQ7EwTnxAA6uLZRHKwZ57rV4TFeAXx/8AnGDQPwCS0MsjTdLkDqz0bOPXsMGubHK+z7sJF1NPmu8gTxMDVl05QSy2pqEkb+X5XQ9MdlCxrNOuSOAiaiWKVb43bHh6KeHc+aoXdeEOJG6ifuDdkDo1rTnWFmTZxsIx0vTzCQo8Vn6KXDWVVG2D6Y+muIoWBaVaMSXKt+Ar0vBNBbB5Ev/D6sLx9uwkXH1hudTysdSnPqvXC3KliNAxrtfmYzGBeKD/v4yK5Edk9BqABDjBwTctRWA0s0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(31686004)(6512007)(53546011)(478600001)(6486002)(6506007)(31696002)(86362001)(38100700002)(36756003)(66476007)(54906003)(6916009)(5660300002)(26005)(4001150100001)(2906002)(2616005)(316002)(41300700001)(66946007)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXJQZVltVC8rNS9TdjJVR29Oc1JnSHI0TmRmZGpNM2NGV1BxRGMyQVNCL2lG?=
 =?utf-8?B?L3RVYmRENDM1Zk1IcVQzekZMNGsvL3JwSkU5amViWmVmVHZLQ010UWxjb2lm?=
 =?utf-8?B?dmNYWjFBY2trVzZQNlBabVM1MWp1NlllSnh1aUFtalFNOERhNVNCcGpvTVRh?=
 =?utf-8?B?RzZ4REtuWE9uVTMydUU4eXRjcHFuWmt4ZmpqelFtaFc1Ymk5TEhwek1qNGFr?=
 =?utf-8?B?aytVa3VWUVBXZUVUMW9HRjIrb3ZpbFVVS1dBTVNrUXF6QVA2dGE1ZjdMQXlT?=
 =?utf-8?B?YzFCNnMvMW5vNU9hS3ExZ25XcWlmY3V0ZUdyQ2VBc295UU1sVHJsQ0M2T0g1?=
 =?utf-8?B?ZWFHOE5VZlluRDVYcWdqV0tRUjNENmJQdE93K1ZiN3lGNEUreUFvNG42NDNh?=
 =?utf-8?B?YVBic3MrRWJROXhTODBTZGRibTdwZ0t3aWIvcHBVVHd1Mnhhd0VaMXluOThn?=
 =?utf-8?B?M2QrQVFLM1pxS05tS3ZsQTNuWE5Lclkvd3NlM0VXNkp5RVhJblh3d1NCOWtx?=
 =?utf-8?B?WWh6eEgvaTdkQkhlYXNRTmhzU3VrQTJZRTRDWkRQMEdBVkZuMnk5aGcyVnd0?=
 =?utf-8?B?akl1Z3RWUU1OMmhzTmZ0eXhJK05GdTQzNjl5T3B3b0E3bE9tU1dKK0dIRmpP?=
 =?utf-8?B?enRpQU0yVkREOENUdnAwOStDOUdTMW1XcVBibGFTNWZMeE80bmZSTGhDeVVv?=
 =?utf-8?B?MDFoSGdOYkd0dEhhcnk3RFZEMFhwOXF3eVUwNUx6eTRTOWxYVHhtOUEvRkJl?=
 =?utf-8?B?TC9EOCt1VmVNUkJoSkdDUUtvNkFVODUwUmwxRmcvMGlSc0h4cVZqUWJBVUt0?=
 =?utf-8?B?R2FXaXpHb2N0WTFZdnArTTZ2ZXZUbWEzbFFCTUlPRFg5bXg4RTdqMzhMcUpZ?=
 =?utf-8?B?SGd0Q0daY0pzaHduRkhxbk42cE1ERjBpT2xjdjFubm9ZMFROc0dFaElCMnNl?=
 =?utf-8?B?MU5WVm91SUVvR0ZDdUI4Nm1YWkMzRElabm4xT2NOdHFSejVURFpxQ1FLa0JV?=
 =?utf-8?B?UFBlZFIvcGwxWFlveUJIQzZXb0dSOFJreXNGa0plTnJpRHpvN0RVWkxxcjRl?=
 =?utf-8?B?NVFtTk1mNWpiUnQvNHlsdEtoNGJVanNBcEZuWGZ0eTlJdm9XdzV4QzBsczNN?=
 =?utf-8?B?TTRlb21vTEVLLzJobGRYb1hEZnIrK1U5V3hyaG5QZ0QwY0V4NThibjR0Qnpt?=
 =?utf-8?B?RDdtb2QxR2VjNzIwbUc3NjJQVFI3T3FxR3hFQUMvcTZpekJZMXlIVlRSQ1JV?=
 =?utf-8?B?WWdRWnNyZjJSYkE0T0VkRVhuWkovS2NJaHhoclZCSzRUWlM3Ym42WU8xSlZV?=
 =?utf-8?B?MXpDSmZtOU01V3Vtd0c1T1VhUkI5WC9Qd1pDWFVGYnQ2YjhvWTBROGhRMmhI?=
 =?utf-8?B?Mk1QcllKd2JGLzZDYmVuUGxPRmR3NlZ3YXNHRDBkNUswQkdlNzVRcEFlVkxC?=
 =?utf-8?B?WG1LQUxZa05NRzduME1tTDZ4RVRHalJQVm01ZlhzZGVQR2RMNml3ZjErUERS?=
 =?utf-8?B?Z2ZvT1hYYWM1V1Jtc2drdDVEUWtTTVRnNERmc1lZdmI5Q05SL3UvTDJteFUz?=
 =?utf-8?B?Vkptc0R3WHFFUlRJai9iWjlWMlJHN043dEtQam8zSGg0SjE3bmRjSTFCYTh4?=
 =?utf-8?B?bEFHandVSlUzZGM4UWNwUXZyV0M3VERHMFZVNFJ4R0xZMVZBV05jUFR4aXd4?=
 =?utf-8?B?Yk55dnUxK0Y4b2NSMUlxWWhWZTV5c1drdGsxTEZKZUNTV1J1MDNnMUN2cU1k?=
 =?utf-8?B?RnRxZ1N3blZYODhHMWlPOFNIVGdmSnpkVWswYXdjVFA1VldyUVJYb3hQM3dP?=
 =?utf-8?B?VFVIWkgvNUJRZmhGb0JnZ3JWL1EwQU9CMnFhbjJodVVVbTRHbG5HclhVSFo4?=
 =?utf-8?B?QU1MTGtpczlTb01lWWFVNWFPV2UyTTEzdlI3RTFjNmhSTWthSEZoNzJYR2kw?=
 =?utf-8?B?cUlrTUJnSnUzcmM3YWl3cE5SQ05LZWtDQ3c0ejJjVUExU2lUYTcxK1JUM25u?=
 =?utf-8?B?eVVzdTZFUFBrQk9PemZ1VGZJQlc0QU51NDc4dnJWY2tkL3UxUjhRUUkrdmZK?=
 =?utf-8?B?dFltbktvdUtsRlVCSkRyWEtSeXRnMGhzVDlOUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825b206d-6943-4086-23b0-08dbd6f3123b
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:46:07.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdKm34EX/u5bI3gR6dRZYp+TWsacY7GXKevMsYncy4qReL21AKfkXL8Dx7LCbAommTP/BN/0CeDAlXlEtxBeUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8955


On 2023-10-27 09:26, Oswald Buddenhagen wrote:
> On Fri, Oct 27, 2023 at 09:20:04AM -0400, Marc Branchaud wrote:
>>
>> On 2023-10-27 08:45, Oswald Buddenhagen wrote:
>>> On Fri, Oct 27, 2023 at 08:34:40AM -0400, Marc Branchaud wrote:
>>>> I never use "fixup -C" (or -c), but I do use squash/fixup a lot.  I 
>>>> find that I would prefer it if Git used the most recent Author date 
>>>> from the set of commits being combined, rather than preserving the 
>>>> picked commit's Author date.
>>>>
>>> that would be unreliable, as plain amends wouldn't be reflected. that 
>>> may be rare in your workflow, but still.
>>
>> I'm not talking about amends, plain or otherwise.
>>
> but why wouldn't you? your use case of marking the date of completion 
> naturally covers all ways of amending commits, whether directly or via 
> squashing.

Please do not presume what my use cases might be.  I'm quite happy with 
commit's behaviour, but not happy with rebase's fixup/squash behaviour 
because it's too much work to achieve the desired results.  (Results 
which, as I said, I don't care about enough to bother changing anyway).

		M.
