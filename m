Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D4C001DB
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjHCTFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjHCTEz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 15:04:55 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn0815.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::815])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3E3C3D
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 12:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS3x0rGAUcAmMF28pQeddAkRsJs7aFRHOKcCpH2FrGkSbI3nWJ+kH8jWxmjWuoA6KNxJqdjqlUSx0YuVWDmo7JEiayNpKP1A99oWQnI23kJG/nFiR14Q9iBjeeZfF4CSLuWnq34zSX3nGEQOuLE3QFUkj3KpTVEqYwZ8Ce3frCBA3Di3wwOMC86vXaaVFrM3n1FH00L9UN4Xec0eh23NU30bPxKOtYlq3lHtghmd3XXVyZzpJwzKoYm3KeoJdkEDawAh9eY6Rjke6IuVdamSu0K03EbswuYKyAPDUeB+MkGLHJ4DKpW3aoQB6u9TyvHW1SQh2r1hKoWM5gxVIH5HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYk1gSpmG+/dPnMoJwKLhKrRYEazeAlb0EMh8XVes3Y=;
 b=byXPNhuCeFGM2zeRNd7yDwrzqLnO8o/fLbCAULyrHMSc1n2yYQ/lNjdlGQITezadm2IIefWNJ7iscWPmSDoPGe/Ac9qDdzzHkUa0e0oGLXbzYPTNaMyiWQ1Dd0LyBxiKD4rEl6AQcsU2zh2KAiSCtO+FH8Kei3UPZ6dXRM9P6ZMW1PN6kJq86oCJ9gRK9YtyvcGUKYnEcXxNDIiGwOpiv+pKB76+dGWBDWoxFzJ/vstkTFcwderumP9j4CnDsxuvwnt809IWLGIEBD0tN74TyadnA+y4laaciBGtLt6PDsPA7QDiq6pbtqXnKkkWmDQ/u54RUv+nk3mBYzbZU5tOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AS8P250MB0040.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:35b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 19:03:37 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::e27c:83a6:825:4ef0]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::e27c:83a6:825:4ef0%5]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 19:03:38 +0000
Date:   Thu, 3 Aug 2023 21:03:36 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?Matthias_A=DFhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
Subject: Re: [PATCH 0/3] git bisect visualize: find gitk on Windows again
In-Reply-To: <xmqqy1is3qqn.fsf@gitster.g>
Message-ID: <DB9P250MB0692B33DE1EBFC26865D78C9A508A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>        <xmqqo7jo5d5a.fsf@gitster.g> <xmqqy1is3qqn.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [AmBM2xuX6F5Ou6Hn8uJzpXfgH7QP7rss]
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID: <60ba1f07-500b-eca9-f94f-712090fd98d3@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AS8P250MB0040:EE_
X-MS-Office365-Filtering-Correlation-Id: 416b8adc-5a2b-4c2c-dfe8-08db945457f8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LXA0z2jcNhq0wT5gIlcAxB2QCBELTXQhFVAnTi0urrYuAwnuxtvSFwl+G5Px1e5MaKPe6T1/E7WXL0MWGl3YQEvaD4Cz/XKamz3gg8xxCeMi5GOd28oK8n0n0KCZoSIU/Sr0IGgL8sh1o7Jbo5vo292tM8fLUW4ks3KsLojrVU1kRp0M9dB6xhAJglUUAb2w0XpGrt8ez2PjQ+sEBENcPzqR9dtOQiEBM35KdRFgdMYmKmpDTXkydZKyDfAjYOvy30GZjE60CwILlkbF9EGhtlkJao4Fx0lA83Uhe4yhedr4N+VUNyKmdEQxi1moaAre7AdOSAL3AYhh5c9NklPLbKOeeP8NrG/q+ixk4PbKK88swd2BgNJbEoMmNKK7a/vrhPiK2ZQcXwwDyLQczopPSCd1V4Lqktd+txJmVboM40VBAhsr4gMpTgu4kqJLG0iAtSnV/6pMMB96eqsrjfpDEzYnvJj3asg3gwjOKZrA5gGmgq3tLLeeAxXKaJaEvnZh6MA/ThU08817esZzXLZJdr8TrIxE+R4VLjMO7o5jGYVLuxzaxO6PyXxqAXCEx2PsavJighyM7WBzGJr4ok1tgfhe2Fx3MBQiwrjtvCYgV5wgzKQqLNH+0zQ4LiK7I4c
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RituTDV5MzVub2xZcFdrNFluTVhwQU9tdWRuVFU2U1QwYmNXd2JCWERaVDhi?=
 =?utf-8?B?b05XeHRSQlVTRUxBd08wTHc4WTV5d3pmUDRLUnJKNkhwb2M2QXJhRDQyQTRG?=
 =?utf-8?B?K0RHV3NtZTc2eDNRV1JEOWhaem5xcFZTd3h1VHFoOFgranhwR2w0R1VTWVJT?=
 =?utf-8?B?b2ROMVREL2x4ZnlRa2dFamxJdXRvYXlYS0tVcVUwZkdpY1RBbFQwRzZ6UHly?=
 =?utf-8?B?MFAxdzJLUFFoUzYrbmJ6YURpK3h4WU05S3p4L1BPV0RvYkxkV1R3eDJoUzBO?=
 =?utf-8?B?eVlKWVg3N25Mb3hOVEZlS0NjWG5DTG9nSFprcHcxMVBNUVFMWVNmREVwdGJj?=
 =?utf-8?B?ajFrb2d0dTA5KzVvT3VobWNRRHBRbXdSb2huWU1kMlNnOWs4ZHA4MmRDZnVt?=
 =?utf-8?B?dkVNN241YWlydWNpTkJqUis2ODYxQXNCMFRLRzAvUGZwbDA1dGxjZFR4NjVP?=
 =?utf-8?B?R3BBd3lGTDJTWnh4MWtMOGw3WENzVU9ZUjB0akNxT2NremxuT1lKU2g4SEda?=
 =?utf-8?B?bncvVUVKTThWTTMvSFNydUZJVWNRcmFCUXgzT2Q0VnVhekZJZDB3UUVKTlBy?=
 =?utf-8?B?azZCQlk5N1h5NGN3RkdLVHNYVENSb0NmTTdGMkZ6WWptcXBOWVo1ZytQanRS?=
 =?utf-8?B?b0d5WXlzcW1CUjdVNlRxUDNucUlHdlRjM3Z0NkZGU2V0YnB1c0tWQzhnQ3pO?=
 =?utf-8?B?dmxIM3FMeVBON2h5aTgzclNGSDBqczcrcHBkQ3VvSEJQdHUxMmRxMVRCdGEw?=
 =?utf-8?B?NndWRlVPTWlXQVJzNmwyMTE1WVNsM0QzRWpDby9VQnFaY2RONXBUZjlVZmlM?=
 =?utf-8?B?WWd2TXF2NTNTMXlQblZDTkJYTUh5SlAvNVFEZjRWNlRhTGVtSHFwdmpkZ2RF?=
 =?utf-8?B?QVJ2RDZlMFM3Qmg0QnczK0Q2eGNKRmdrOVRseVFJNWRWSHlZbWloZHFhb0tU?=
 =?utf-8?B?bFBVb0VwYk1WS2VtdUJzUG5leVJRMVk1VE1XTHptcGV3aDBKaHJvSXJiQzVl?=
 =?utf-8?B?RHZ2K0s0U29vQXcrK0lhUGJ4OCtUejFLSG54dExTd1dsUGlmOHFkaUowNVdj?=
 =?utf-8?B?dytHMmFyV3ZWVis5MFc3Uk14UGZOWTlaMjRMNFg1RFlxWGN0b05XQXJteENY?=
 =?utf-8?B?OEtsRGQ4YmlYRDBVb2ZXWjJNN1FOS2diTittd3JGNU9qMkdZZmFsY1pZVWFk?=
 =?utf-8?B?ZzFMenQvT1Q1ckQ0V242Rm00T2F1dkFJQlc2THhlekJtOVBiNU52aUdBempH?=
 =?utf-8?B?WFBrcjUva0EwR2J1WmFVSFhwWlRZWXZrVll1RHc2SlB6d1dkVVpLZDExZDRa?=
 =?utf-8?B?bEMxeFUvSzltNlNKWk02U1hhUyttNGMwbDZWakdFZEFwM0NNWTdtYU9XRytD?=
 =?utf-8?B?MEFaY2M5blhWVFpzbXAybzJDRnp3L240OUllSXFDN0hmcVdvUk8yek5XdktF?=
 =?utf-8?B?RDJYU20waVZTcG1mZHlya0FhY2poaTkzZStOWjZ5OVo2eUUxbFRzMWlYQXRZ?=
 =?utf-8?B?ZkVYbW1kZCttVGZkOXpyQlQzL2RjUWIyS0FNRll5c2pCYWZVcCtVZzFWK2pa?=
 =?utf-8?B?enpiSGFvb3JiMUpSRFdlUjM5QnhsajNYeFJTeVIyL0NzOTQ2RlRkeWozTDRU?=
 =?utf-8?B?SWR4T24zbkFxa05ENEdpaHlucG5QT2c9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 416b8adc-5a2b-4c2c-dfe8-08db945457f8
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 19:03:38.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0040
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Thu, 3 Aug 2023, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Matthias Aßhauer via GitGitGadget"  <gitgitgadget@gmail.com>
>> writes:
>>
>>> Louis Strous reported a regression in git bisect visualize on Windows[1]
>>> that caused git bisect visualize to use git log instead of gitk unless
>>> explicitly called as git bisect visualize gitk.
>>>
>>> This patch series fixes that regression.
>>
>> Wonderful.  It would be nice to describe where in the release
>> sequence the "regression" happened, if we know it.  Perhaps you've
>> written about it in one of the patches?  We'll find out.
>>
>> Thanks again.
>
> And the answer was in [2/3], if I am reading the proposed log
> messages correctly.  When the "bisect visualize" was ported to C, we
> broke it.

Yes, that's correct.

>
> Thanks.  Will try to queue based on 'maint'.
>

Please wait a moment, I'm currently preparing a V2 based on your feedback.

