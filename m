Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E42420F
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4/Zeg2F4"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B710D7
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeMPPSmzAuhYQkrE4BSd4VFpg0q7MQm2XLItBBmVnrIi482xQdeMucCNb8xCvbVC1GRTe6jp/SvMYLMewntIiamOH6G0y/152+7xKbpLm7M2wdt3XJRHeo6bPvLku2oLCTr17isj3rFQpj6b7J1umkHGJLiBhY+qAeRJgxuwxWp9hYIe46M8qr6kWrsDSDFqTibmpVvN1xrEsog4mMz0nsGIxmwve3EUCU10KNetMhSonEzGBv6VH2yUaIOGjpz1ZovatgUKo42CODr2hbGzqAyRhe1Jk2geh4DqoKR7CwVlGXQchESiqXMQI0DAisUm4O1Qp2S4Z+e0sKbMDvW31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh9XiqXRWf7Typ/hpgTaqlX++qh4gHVi20UWa4AJNw8=;
 b=CvxrXcWTd2svqKSrncGCqa4dZNsud0CMVihGUGG3HM/heFIQTwzEGhg/1E9cDGtXMdEkbrM1ppn7mIyNw7HIEvFuHSPmiJgsTPtyRoo7TikR3k+kS3M0lDwLhYqY2ZV5z0PnhRVah3flp8P+6xCc+TtW/DzdSoBdReKPbo9XH0f5R1Zhav5Hdn/UL/PGwK9Kc7KS5A1H4BDuDwHVBzbJkewsuikB+01gywlWhJT9uPbLLOSw3dhuxMvOzSGxCVuy9xf1J8r1LNpXohJ517xUvl2JbVMbWOx7hTO0E5IeKXeOHBWWdDRCrYaBqQ5yPf5Oyi8lXVU3qctFeSL6T/Lglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh9XiqXRWf7Typ/hpgTaqlX++qh4gHVi20UWa4AJNw8=;
 b=4/Zeg2F4iasJxVMV9ymh4OaA1HlChCKfkpLdoejniGklGpA92ogQDvjUnHive6YTSyRDq6kpLM6GLo4mjlfnqxEMduXdHmHhUdNe8twiF/AgHuFnJaO451TomP3LoX1IWcINzkSxggG9nrov5Lg3bq9qPpXpN/3otKBh3RFlE2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 24 Oct 2023 20:12:07 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b973:5b73:8e3a:e170]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b973:5b73:8e3a:e170%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 20:12:07 +0000
Message-ID: <393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
Date: Tue, 24 Oct 2023 16:12:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] some send-email --compose fixes
Content-Language: en-US
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
 <20231020100343.GA2194322@coredump.intra.peff.net>
 <xmqqil71otsa.fsf@gitster.g>
 <20231023185152.GC1537181@coredump.intra.peff.net>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <20231023185152.GC1537181@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:408:f9::29) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a0f74a-73c7-426c-34c4-08dbd4cd7f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OyPCHsko9M/piqKtor+RY/SyykS2bXA9o0Swxibtvh6SWBVA2TbfhKpr0Q5kNKEWZ67n80Sl9EhH+11g53YGpfAdyrLcJXCfWs25OX+Ca1Jl3sgV8SjQkfnwtTJ9DUDyDDQzcReGiNlWWOEQKTz7/5rw5O0McrCkrvsXoxiUysQPkzjTEiZWoJ+6grqbLoCdNgg6ZYnuf8trd5aF6xJduz/VYSMqrZlft8p+RzuVXOpA37OVMVD5aToysHgGpiRlq2PTr04O2gTKgQoWsys1Nl3dxmDSp9mDPNxcoTLnEFBJJfxmzC1G3RRi1kpxRL/RskO890+ysQ7gu+bF3j1Gv5ABtjADAoep4ltpaxFdjTgBqythil7MUbaz8+ZtmCqhtapiXzYUHuRg3LXnzEAGdZva5yw9cJr5jne19Z2SEvMlOQQmNhmSOGiu6XzR3VYchkrgGwNeoRwLnW3ehpcJuvxYuYD1Kx0Tu14gR2oqTTwy3Oox0sPDGhwBDxZJUpq1ZPr1BLZhnanO4QSWBXk8PtFCnT5VdAI8uew1BGdWBNQPSygvIe+aD2XGbMk194B7XAXOu2BR/TGek5V8pwXp7725wuKnQjEHNbWl8ObP7xI37cogMTKQD4w+UHsy4S4kgxWjcW4oyttyU7QvwcBNBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(86362001)(2906002)(31696002)(38100700002)(44832011)(110136005)(41300700001)(66946007)(54906003)(66556008)(66476007)(316002)(6506007)(6666004)(478600001)(2616005)(6512007)(6486002)(53546011)(83380400001)(36756003)(5660300002)(4326008)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEJGVW9IazRYekZlRGVUKzg2c0lvbnJYYUNncE5jREl6QVFOM3pudS96VHY0?=
 =?utf-8?B?RjRFWFlobk85SmhKdHJ3OVlXV1NYVFFENmlYdDlSZGRDcEFoY3dlbmpHMGJn?=
 =?utf-8?B?QzhFajNNVTNpUTdGUXdKUnVyenQ4SUpXbkNqV1BRbmZCbUtMK0V1ejAwOTg4?=
 =?utf-8?B?NlNNTzk0bkJrVnVnaUlXejhWMTBlS1RtRkJROUJwZi8yVWZHeWNSYkVSRlVE?=
 =?utf-8?B?R3YrZkNJMUJqa0phUU90RjMzN1NMZmo1YkpESGxCRjZTMlN4TmZHbmpXdlFq?=
 =?utf-8?B?NjQzMTE5UUpad3hyYXAzNnM3Y0JJaTVHTjdmTWVvV0pnRkx1UmtZNVpVMGJz?=
 =?utf-8?B?RE5xbFhWc0U5Ukx3UFdUT0xEQ09LZmQ1VlFQcm4wZnQ0ODY4TlplNEpxUjl5?=
 =?utf-8?B?TkowWUNaWHJZZ0xVdWwrWHVnMUI5bllnWnp1eVdZVkFDZlliZElIN2dYb0Rl?=
 =?utf-8?B?ck1XUXVEdWswL21SbFJlcFNhRWVUaWpYa090VUJuL0pCOWViSGg1OGwwZVFL?=
 =?utf-8?B?S2ZDekpsY01DTVQ1blc5RHdvK09jdVplSTFVNzM4MGpOREdIb2J1THhGdWZy?=
 =?utf-8?B?Y2RmUnhVanMyMGVPVFlkUTBRZUFDZUFxdnNYUHJuSFUzNEtSamtmOWVGbGRR?=
 =?utf-8?B?UjJUdm1NNXZvaW5SYmdtR29pczdKZVZVenhnZDNXOVk5SWIrdzl5SFRTalJL?=
 =?utf-8?B?dWRTWmxPWWI0VHU3dWMwNnNvZDlibnZNNk1JdmwwR0V2UFlkRGdWbHgzOGtH?=
 =?utf-8?B?WkgyN3c5QThaWFR1NkRhaGlSTjhyWXVpSW5oaXlUQ0pnRzZhSldDVnhRMUhn?=
 =?utf-8?B?ajRQWjBlL0toUTRZWkFtSng5OEhxajg4QmRJVkNpektFVWkzTHoyVkFreVlD?=
 =?utf-8?B?V1J0TjdmaTc3NXR4WS9ab2oyWk1iOXh1alRJbUF6eWkwcjRlbXBSSU9ub3k3?=
 =?utf-8?B?QjVzWW45SDZ1OUl3d05TK2Flam9xNUV2WTd4TTlLUGtTTUczWVF2TXloWGNL?=
 =?utf-8?B?VjhmZE9YNDJkWlRlZUZ3czNYbExFK3FKbU9tanJ4a0ppRTN0Y3ZRUHo2em5I?=
 =?utf-8?B?ZkFoK1JnK2Y0akVqTFdTYkRNT1VyS1liK1RUd2dXVG9FNTQ3cndTVUkwdVo2?=
 =?utf-8?B?ejRMZGZKclFNcVVJTU5iRW1JS1VHZ2g4N2luMk55eE1oNkpYVlY2MUJEOFUz?=
 =?utf-8?B?MkZyRkRBOVdidWc0dElzWlhuVlp3N0xsNDQ1V09ScEVwT2l3TlAwU0Z4amIv?=
 =?utf-8?B?MzdUODdWWHBlTFlic1RqQnNJWU9TeXNRT0NxTXJCRWdZY3BKN1kyS3BLcElS?=
 =?utf-8?B?cFFkbXJLdy92OXludDlYUytaS1RKUHFoQmNpYVZtOXRkT2dLenpLK0NSQ0RC?=
 =?utf-8?B?SW1Gd0xuRmxMazllb0NHZktCbjk1WXA5LzVKUkwwam9wNHh2MXFaeERTSmZQ?=
 =?utf-8?B?YjBYaXY4NnJNMjZuTHQ3cTBPYjN5VXBmKy9VNEVXVFVqVlJLSlloVjlTdXhF?=
 =?utf-8?B?YzdiUFFsU0w2ZXoxV1NoUkdRTERMaVJJSXpQT1A4TkZOcUJZeEh3VEoxbDFM?=
 =?utf-8?B?RWNpMVNGUDdYV2dwNHBBZ0l4NEpBYzk0RXZ1OCtwaGtBTTdpUWpYcCtCUGZV?=
 =?utf-8?B?cEZtSVcwb1Y1RUo5bDFaVGp1TkNsMzF3RDR1aFNtSm1ZZURkTEwyZFV3Z3JY?=
 =?utf-8?B?ZFlNQTN0NFhZL1praVVJUEFabmVPaWI1NXNsOUU5U1I5SVJTOVVhM1JYRHho?=
 =?utf-8?B?bjQ5OXcwNCs2aWFSUk90ZkNQR0dsS1BpcjJoL1ZHek15cjk3NHA5MFNYY3pp?=
 =?utf-8?B?VDRVS1RPdFp3U1BOYU9VYTI4WjZKOHRiYUY1THRMLzRBUnhDTWxxeSttYWJN?=
 =?utf-8?B?MHVJd0hieituWU80UDc4ZllVOUxNVzdKZG1TeHVCQWVCRHIyUmxUcSt2bHVV?=
 =?utf-8?B?YnRKMGpjRVQzdXZLM0k1RUJPRUhlYUFSVkUrWENXbXM0MnM4eFpibUF0bzVn?=
 =?utf-8?B?WHBRQVlhc29rMTJKRTBXYUVSWE1kbEpzWXFtcm5sZ2crTUI2cE01cXFVK2xj?=
 =?utf-8?B?QzRBNElQMEU5SGhmTi8reUlFUHBCd3d1ZExmdGtvak92T2FkdG1QbkNDcmYx?=
 =?utf-8?Q?+InVI34pOH1iABRy6YoS+pIU6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a0f74a-73c7-426c-34c4-08dbd4cd7f0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 20:12:07.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw23EDkaBwilNFShgjL/94h1OQ1a7tWvTMiLesz34wLkeI8uPrBAt+fgnhO5nwt6bqLX1bk52JfYnDF1yTQ30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712



On 10/23/23 14:51, Jeff King wrote:
> On Fri, Oct 20, 2023 at 02:42:13PM -0700, Junio C Hamano wrote:
> 
>>> So here's the fix in a cleaned up form, guided by my own comments from
>>> earlier. ;) I think this is actually all orthogonal to the patch you are
>>> working on, so yours could either go on top or just be applied
>>> separately.
>>>
>>>   [1/3]: doc/send-email: mention handling of "reply-to" with --compose
>>>   [2/3]: Revert "send-email: extract email-parsing code into a subroutine"
>>>   [3/3]: send-email: handle to/cc/bcc from --compose message
>>
>> Nice.
>>
>> With the approach suggested to move the validation down to where the
>> necessary addresses are already all defined, Michael observed "whoa,
>> why am I getting stringified array ref?".  If that is the only issue
>> in the approach, queuing these three patches first and then have
>> Michael's fix on top of them sounds like the cleanest thing to do.

Patch coming soon.
> 
> I don't think it is even an issue in Michael's approach. I'd have to see
> his patch and how he tested it to be sure, but I suspect he was simply
> being extra careful to test nearby behavior and stumbled upon the
> ARRAY() bug. But the bug was there long before either of his patches.
> 
Thank you for your patches Peff!  I think it fixes the issue I was seeing.
I was trying to be extra careful with my testing.  I had missed testing
--compose and also the multiple --to/cc/bcc examples before.

>> Will queue on top of v2.42.0 to help those who may want to backport
>> these to the maintenance track.
> 
> So I think you could take my series on top of master (or 2.42.0), and
> eventually target 'master'. The bug it fixes is from 2017, so not
> urgent. The reading of "to" headers is a new feature.
> 
> But the fix to move the validation around should probably go directly
> onto a8022c5f7b (send-email: expose header information to
> git-send-email's sendemail-validate hook, 2023-04-19) for use on maint.
> I guess maybe it is not that urgent anymore, as that regression is in
> v2.41, and we would not release anything along that maint track anymore,
> though.
> 
> -Peff
