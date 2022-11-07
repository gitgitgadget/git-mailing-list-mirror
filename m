Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A23CC43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiKGLGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 06:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKGLGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 06:06:21 -0500
X-Greylist: delayed 260 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 03:06:19 PST
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367B14D36
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 03:06:18 -0800 (PST)
Received: from 104.47.11.173_.trendmicro.com (unknown [172.21.19.72])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 5408D100C2EAF
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:01:58 +0000 (UTC)
Received: from 104.47.11.173_.trendmicro.com (unknown [172.21.205.29])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 762D81000192E;
        Mon,  7 Nov 2022 11:01:56 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1667818905.204000
X-TM-MAIL-UUID: 05abf434-bddb-48d3-ad6e-60d904d6f238
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.173])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 31F15100003AD;
        Mon,  7 Nov 2022 11:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT11/OpFHDdEpUJuientBZrYeJWbvWXUE7NzIcfNX3e9BsEHEuT37YvRmNAKP64bKplnQ+dnCyMxODzgR7uJDI2dUQTbOySRZLSKo1SEK61AN9zPaRLzqpOZZSjy0+CiofNNt8+7sjHzKAFbNRg2OZFHUoslmpuMuYsheJ6Cu8lsHL4PcpUW2SAyUvZdpvf3XmGbQiPLBaXCZayvr7SMOy0WnyghDo0z+d/mPoiEWTBJQLXpQWygQ2QhhGDayXJOXzT4X37/UTwXuReF/C5pFWB95uRkE/Gs2bmCJQCFpJtGvB3wErlvOeQ6YGTAuEe7XmU1zJP57Af6pHsgCwa3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL6u2ka7yeR35PFYBffe5yOGBMLyXl8fBmm+HCwM580=;
 b=M84zi7vUG7yw+ni6mn8QuwIjj6g+dEW03buhx06I/EHcRyM+Sn3dpFproEygBle3ktbqRCwgrd/5rYriBP35//7EVT1BU1xIvzUzEUmz0HTM6zS1Wkq4qytZcr0BvkhwYM+xkRYMVwjzMdyD0Y4m3yS15jK+hps7QAQFAQLdYZH6sInpMhCdT1wsEj/7qY3jsJQL3JCcNnKLxkFyFrHh0QZfqTO9vM4EldY8EbXge6Ce+JV30UizOW83UYyaXhojX11MkFm1c6SEwA5N4M96JEbJwvOfLf+v/4LZQretijcjeGrGl5F+RuC5x05Q54rnTRrK+nFEKWstP+KMrPkzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <b5017077-720b-3085-39f0-54dc6b6fcaf6@opensynergy.com>
Date:   Mon, 7 Nov 2022 12:01:40 +0100
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
 <xmqqwn904sof.fsf@gitster.g>
From:   =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
In-Reply-To: <xmqqwn904sof.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:208:1::38) To BEZP281MB3350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:25::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3350:EE_|FR0P281MB2987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b19fb66-b8fe-4ca5-e950-08dac0af747e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/KsYe43hc7ZLFHhwMWd6Z4+Bux8HoOYqyuLz5dPeDUkGceZv4WjuZx4bHFFHEX+VVGpejsyf4ZGPRZABqn6A3M0BjSPeJ8w64ccM2nEb8czKV25qKRENMOniG+ObHR2UZhvQtfNQtJ13rNGJLG3LMrWwKxW/vQQXNFW6UIeyXLGZzOCIQAWQouTOMJnjVbMn6YErZrcqQTeZoq8p8d9cLSa7wHYuCpS/aUaoTGfQ8ohTtoNBPlCl6Km6V+s0kPGbBO+CvwkUhL990NOSIFmo6VCoKp3csGNrI/jhMc3LOVbC7XXCfJd3V78QtGN4nss16Yslv4WMerIe1RVsB3RkBqFwl6XVza3MLpMW7phCuZi4Q3ChaBlTUHhhpIMJZuAZN16hYh6Pik6pgWsoS1ugnwyaFMycq2Ze8VsckNCwc5hWuZLiYZeedru+sz5bqQubOaIxq9nnD7y6Of2olMUEnakG8rbix4U0s6cEfPvRk4752G6sljhT2AhV/lfc3hY0rCZytqVs64TdMI0m07B2R8+O23bp7vaCSEhvXQmg/2e+mH5cQC2rS/TfJyBoHhLDOX8OOd0iQvwjrpdLeixpU74m+nE2Im5msyW+hQn0xqo1e+Hbhymh7SU3MTArLWQ1mncA3opZ95kClrFpJ/hkT8GgmIMOVvG6AlIGiBBolhHPQhSWhdbc0AK8EnnvgmyU0k+tYlk6bEs4Bl9330LSgiiGd+Cs/mYxFtzPVCFOs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3350.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(136003)(346002)(396003)(366004)(376002)(451199015)(966005)(478600001)(86362001)(31696002)(4326008)(8676002)(110136005)(54906003)(66476007)(66556008)(42186006)(66946007)(316002)(53546011)(41300700001)(38100700002)(83380400001)(26005)(186003)(2906002)(31686004)(36756003)(5660300002)(8936002)(4744005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlF3UStFL3pJeG1IQnoxKzVxTXJPWG93MXh2elBya2d2R09HWnFsYkZmMWwr?=
 =?utf-8?B?V2oybkZ1OVViWjhRNGJJVno0ZjlTTEIwVjlEZVJPMEJRd2MranhIV0NPbEVK?=
 =?utf-8?B?QWU0cGhYTFI0NWhHZkFnaC9hVnVWQTJ3SVNFTFBGdUFUWXVhZjlEa09oK2w1?=
 =?utf-8?B?SUUyWVhJMG9DWmJ4VHpzN1cybG81SThmZ1E0dlBzM2VINWd5UUw5Q2FnbXdH?=
 =?utf-8?B?cnZFUWUveDduZFFrSCtZUlA4T3cxMGJlLzhvZ2VjTEUvNWc1UEJ3SFZqOGZt?=
 =?utf-8?B?QkRJUHl3aUlpTEZZbTZySGd6V2NVSVFYTXZwbXJsL0tYMHhGTUphNUc4bENx?=
 =?utf-8?B?UHFGK0pra0NKaFlIOWZWQUtjV2RpT2ZmWTJBOG1QdlVkdmlua2R6ZW0rNTR4?=
 =?utf-8?B?MVZ2cFBHWEdYWXJEVThSaFFlQXlXc0N5L3drZzg5eHduZVJhUlpjZTNkdFJr?=
 =?utf-8?B?clovZlF1aWhsYm1XRnFRTlBXK21aM3JOOExUQUNwcUZDSWt2c0JlUlBBeG9X?=
 =?utf-8?B?aGhua09FU0RGbGhjaVNydC91N2pUanRLbkR1V1Q3NFN2dG02U2FNdzA5Q2tL?=
 =?utf-8?B?TTlIUzJBM2FLNFVmdysrMHAvWGZVZXZ1NS9mK3BuazdBNHFnL1FENHByTzZD?=
 =?utf-8?B?MmxWQWlQYzJiaVJNemtRVFFXSDlGYVNYOGhpaHMybTdZOW9ra1YvMmFKY0JK?=
 =?utf-8?B?L3F0N3VFbjFuR0xHeUdvMVpDQ1RiRGZRTUhyQ2RHZXdRTDdDQmE1NmxOa2l1?=
 =?utf-8?B?UDdzRG5rVVJmcTFrU0VkaTA0VXA0MmNqQVNXNGUwTUJ3UnY4OEU3eGhBeUZN?=
 =?utf-8?B?bG5kYVo4Q1BxNmcxNmV1VHo1YTVwcU5MakVRLy9sNTl5Z2NsQ25qRTRNRzNn?=
 =?utf-8?B?MUVEMVhvZmxoRXB6b3VCdkdPaC80YWZScjg5UnVvQk1JTnhWYjJCMEFKaEVm?=
 =?utf-8?B?QXF6bVROWHVrUFExblpQMzlZQWlDNDVibndKY1lnN0NZaTc5K1hDdFdwYlJJ?=
 =?utf-8?B?bGZUWDFYU0trc05qeDY3TDh1Z3hEL1BHYnBZb0lzblRSUUtvd3JabDUrTHh4?=
 =?utf-8?B?bi9nV003bjJrN2JwZjZGakpDT280Q1VqUlhQc3NqTzR2QTBtc1FxSlFmSFBn?=
 =?utf-8?B?TWNXN2hhVTEvZERFenRINmczRGg1c0tld0Fka294K0wvUHpjWVJMWkVUcCsv?=
 =?utf-8?B?VnptU0VRTWRFUjJ2MndCQXdVK3h0T2d5ampmenhxc29lL0tHMkVtaFVsZ0Q5?=
 =?utf-8?B?VThRUks5WjY1d0VWWG1FR3NWYzVzRFo5RWMwcVNsUHVlUVpLMXd1cml3amJ2?=
 =?utf-8?B?YkEvOHVjM1lLSUVCWUZidjkvWjBqV1RVdllNU1QwRnVCTTlvTU94L25McWJh?=
 =?utf-8?B?RXlkekdrMTBieE1OWUNXVTdMOG1hWkhhSW5kWWVLd242dTJ4aGEvMFZidFh5?=
 =?utf-8?B?TUxzOENtYjJ0cWQ5TmlmQmdQaFJhbCt1WDhFSkxVYlRNZWwxYnVUQ2s1dVVo?=
 =?utf-8?B?MGp3Y2RkV2VmTGJXdHczZm43T3pvSGVNVi94YnZwdVN1bWIzZ2FGME9id3hG?=
 =?utf-8?B?ZFNFd2J6dW5rcmZJV2NHY1Q5UUpLSlQ0QW9qbER6b2RpYWpQY1dudkxqOFBH?=
 =?utf-8?B?TWI5ZzRLSTRCS2lIYXltQWtMeXlPTGR1Tm1IS09nVWJ0TERSejBUOUFvSWRn?=
 =?utf-8?B?cENuVVBiZ0NmMG5UVitMM2dXZ2pxRnNQRGZHa25mMUJ4M0M2bnI1NWVLL0Nn?=
 =?utf-8?B?UWx1dGhrbFpZdmg1NVpCeGh5VnhuK01xUTh5ellaRSs2MEtHeU5WazNoMTBl?=
 =?utf-8?B?SW5kdjR3Vm9wOTMvTzRaZks2cmR0RTFRM1ltNUZVbUF3VW1HUVY3cHFvKzRW?=
 =?utf-8?B?b1ZxL21CUzhlNzloZk9qL2owZWlBQWtoMzZlUjd2OTZSUUg1Ym5qMi9rUGk0?=
 =?utf-8?B?S09VTUdOb0tXcTFJVUhmMzhQWXBBanF4eENMOGZtdUpEalN2VmZDRm5VcVNO?=
 =?utf-8?B?cTRRYWxxV3hGUmdqa3l2NjFESVVWK2VDbUNBeSsrdzVYQTAraUNoOEoyNTlw?=
 =?utf-8?B?UWZlNUl0YjlpMmE1dnJ4SFY2b1QrRjFlNTArTndqVmlmRGt5Z2VFSHh2Sjdq?=
 =?utf-8?Q?gH5zx7EQESixdPricyhtOPDrs?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b19fb66-b8fe-4ca5-e950-08dac0af747e
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3350.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 11:01:43.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY7aawdSsxXmhnIzXYbwjVgNcaPvtQuvUELHh8R1ey2LQ+Avm2X9HhgBBHmmYG9w9snWLbiYqaTK03qbpoNE8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2987
X-TM-AS-ERS: 104.47.11.173-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27248.007
X-TMASE-Result: 10--7.363100-4.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4guB7zdAMUjAVju/dIa6lcVWjSWvFszxq8Wl
        hj9iHeVphI7uvji8nit1R5IGcWMBgG02TQpj95Hq3nHtGkYl/VplH44U2Ru12siCh8yBqE+tAbK
        wr38FiA439y4w0nxd9k5zTAAnSzrBLSnF/wW/fHri3aa5wOREETYvC/PFFfSAe3NcvuU/AP+iX4
        D5r3f1zu+Z1hFVFncDTec8r7aHYCE+MZxonH7QAQ2bPyoJqnZLVeAZ5VSHdZ2E+5SGNggxR5w7L
        KDc6eD04vM1YF6AJbZFi+KwZZttL2YhUL5GYRbtavP8b9lJtWr6C0ePs7A07Q9dk+6tnSFL5oyW
        YrZdBfHuCYILV1bIC0D9Uju7IwaNXePanwDqcFg=
X-TMASE-XGENCLOUD: f2d51f9a-9c61-4981-9beb-701a774f443d-0-0-200-0
X-TM-Deliver-Signature: CF2F8A75F0AB14E82227370F859B7BF5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1667818916;
        bh=+vATmth3/wMPlO1K9z1gzKLz7jrPPBAPxxGyAEXgXQI=; l=916;
        h=Date:To:From;
        b=h2kRy31d7uQBk/wonkOmRBv+lrQD/sSSqfjKOMkobdR4/kd62QfsgOYiG5i/cgSTm
         teTB4X4u+c8huVJb+aHjAH12ukzDVXrSveVCxI42zHsyXxY607btOxzXgfjN/MnEBT
         k0V6cMRobxfmOjRIBFANysN52dclVmLkQpTYNAqsc58O37BMHigW2r6z5+XjkKPaZJ
         qXNoZsWjs0IeJtlYQkKhRm7kExYsYLUYp/KuyVUyylKzz/AyLCVlhyUYnURwY8vxLa
         Qz5BLcC8YNdGJa1zdxgAGqB1RL9mlM/9KguE1oZvGone+O0BJrKfMb1IPvVQWy6EAZ
         TqdtEDBExjMFg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.10.22 00:40, Junio C Hamano wrote:
> 
> If one likes the output from "submodule--helper list" so much, I
> think your "ls-files" above should be the closest.  There seems to
> have existed some logic to squash unmerged entries down to a single
> one, too (git-submodule.sh in Git 2.0.0 era has a module_list shell
> function that shows what "helper list" should be doing), though.

I do actually like that submodule is hoisted out of the scripts but as a 
matter of fact it seems that the openembedded folks relied on the 
"submodule--helper list" call and with later git versions that doesn't 
work anymore.

https://github.com/openembedded/openembedded-core/commit/6d9364e5f3535954f65cbbc694ee7933ac1d664f

At the end of the day it's kinda their fault to depend on the 
submodule--helper but it does hinder adoption of new git versions for 
people using openembedded.

Cheers,

		Matti
