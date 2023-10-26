Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE111C9F
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dl1wifU7"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F1198
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 06:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWy14Ztzq0dkrr5jMGaZ48/kJcs3YkgratjfHti6HTp64CDaDYDWwwGz6UPv58iEPQqJJPa7SHXiZsXugzTKvFXdQSaR9LH3D/7Q+OqfmJGl4NArH0zpP5eoKUxHraL+8o/SDy2mRdwrDmH7Ymiunr9E88+QVer5+1zgxdfgCLXG2EqciePstx9zyx2ORBIUye6C+NHgu8YcFLyiaKhaKHhA8uBpyGNJ8RFop7x0Okt2k6pUey2IJ9JRJPvSSgtpOwVMk67s/lZEKDc65C6vifSWHqkowBdeeQ/+BJ1ZIJ6xzxDcmluAUNhz9hinsAU50k1gZH9RWRC6GEShqhENjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJSHqvBIzfO5RBrrHVsE1UlCtmaQ95h7p6Ts0YIJBhs=;
 b=ZXs/wMOMw7FDrawGXTLIo+CnInSYSHTBsNBcvzZGp7F/ld6hZOFHTsaErhm9WbPSCa8aBq4iHBnakp1T+ev3kG47w2oUFquUh93G4maYS3y3ho/o/fBS6mXXMfrZ2BztveH0/GxUa86ejuSHNdrgrvTbGIMmSCWsSy7Wa8YPRmmVajU8THQbbGhFvH1Ju6aTrAClmvLloArRcmWoPj6A6rljYYSVIxmlY8lJ99SCp+tW9aQJfEjUeUUkKMOVXtY26Bhpz1pq2qUFlU0T2M2XkeIoU/MQlvG1FUbKXHeV5zYXIafwXiQcJ9pdsTq+wytu8CXSGyqIF3r0IpQz2qpNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJSHqvBIzfO5RBrrHVsE1UlCtmaQ95h7p6Ts0YIJBhs=;
 b=dl1wifU7cn0/CK9fwgXmM286iBLmgfmB3BZvQIBp6a8Yi8t4Lcd8qRJyg5JH9DrGTb4TKX7SNCE2eNANT4txRo1tnabl5p6vp3O5arzX9djRixaD2iX1e45cYucy+Sllr2u+kQvJsD3cNKDo2Qbivg6ehonw/VQKDcpvMNn7Xks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 13:08:02 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::a0be:f6a8:2c72:ae90]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::a0be:f6a8:2c72:ae90%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:08:01 +0000
Message-ID: <a71f2f1f-b5f0-4628-a4f3-6fd1319062a3@amd.com>
Date: Thu, 26 Oct 2023 09:07:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: git send-email fails with "Use of uninitialized value
 $address" + "unable to extract a valid address"
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Luben Tuikov <luben.tuikov@amd.com>, git@vger.kernel.org,
 entwicklung@pengutronix.de
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
 <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
 <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
 <20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
 <20231025072104.GA2145145@coredump.intra.peff.net>
 <xmqqsf5xr1xk.fsf@gitster.g>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <xmqqsf5xr1xk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0657.namprd03.prod.outlook.com
 (2603:10b6:408:13b::32) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: c07ac3e4-e501-445a-e419-08dbd62494bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VTgkcATuNNsE4o6+aByx6IP6ChvF2psYLhX7tW6P1tQubw4K7ML1BapDgLLH/MH/2rZ9TvfeXgrXmgGoDGdEOt2fn0t+RmAD5oqFXzw27W8Ndik9YmTX9Y6BVdQJD2gWbQYsm+UJr0nmWR9Aup6mjr8eAcY8Bm78sLGKRofnk8x/5MLzIjNzsPbGZlx4XeM4A/Q3oqJOryhhwv5AdeOse3P4iD119gNNsz5LVImq+J0k97uI5fT08c09ZfWicmELC2f+70zxGtiTLf2JB6SpLvFVLspb1SZa7pe2VVwCvwBcLzZ5YHHb+/AFqPFeHjC/dD8LbZrk8o0qAxJCNfCWROzZNctHzHTlpsrOrko7PtTAtv2gkxZa9eGoCb99HCe0MN1Qhr/FsmytF7nzTJUiSsTyRxNpj/k0mqILc7bWRT7vCDdkvH1De72XU4EDKyfh6IdnB94Q49AvbyU4ZvxLTNDaO8uTPFXM2/+xm+gfdYMRCiKbm4LKG2XA9AEINBBun/BsZx0a8i1Ne6/iOefqH29PNLCDR+OmyR8nM/NQLizNY2ZlZrU/exR4k+yn3hVMdv+5TzGnXQqE27s0fnpRm7g4w+Ncz1s7S6Qkt6RZNHmP+mYaKQTA51JsvFIiGXpK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(83380400001)(5660300002)(44832011)(6506007)(2616005)(41300700001)(8676002)(2906002)(53546011)(8936002)(26005)(38100700002)(6512007)(6666004)(4326008)(86362001)(36756003)(110136005)(31696002)(54906003)(66946007)(316002)(6486002)(966005)(66476007)(66556008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk44VGQ5Q254VXBhcVhxc05tWGllRk83MDQvNGxiSG5CTE84bUtQMzZTdFVt?=
 =?utf-8?B?RTZwYVdoV2JHeGxESEZQcjF3OVIxdnRSUk5vV3k0T2JHdmEzQ3N1SFgwTXZ4?=
 =?utf-8?B?bDlEOVA1RTFnZytkMU9mMkVucmh1ZW0wamNoRzM5bUljMU8zVkN6SWE0d2RV?=
 =?utf-8?B?TTAzTTFNV3pJblBvWFBuYzRpb3ZldUhQREtSYVdJbmdjZnVIOXNuNDBaUGZM?=
 =?utf-8?B?bUVKcUtQTy9xc0tHZS9kYm5DMi9JSWFCUitmellSaGtTb2ZheWpkZW9zZG51?=
 =?utf-8?B?WFlld3NrRGJkNjJJT25XT2VzZExFZGVSQjJlVFNMVG5qcFk3cmtOazM5amla?=
 =?utf-8?B?SEU5QWFZeWxoNFBobVQ0cVBRa1ppWUNZV292Q3VyVklXNzFLVUxWUkIwaDlG?=
 =?utf-8?B?N000Z0lIZnlMRGdxQ0VSTGlNa3J3VHlna09WbmhXdU4wa05SSWdCb0lGc1VE?=
 =?utf-8?B?TWorT1owVDZGSkErYXhCVC9WY050RUQzaGorU1hzaTVYWmJzM0kyS2tlZ0Jx?=
 =?utf-8?B?YktRRWpHU1BCbFpBZm1iV2pRYjF4WXg0Njd5Ylg0UXFKTGRBcXIyUkxZMHhH?=
 =?utf-8?B?cG8wRkhQZDFGVm1ZY0FyVVRQZVRZL1BTQlNIZzVkTHNMYytDVEg4N0pXdWZn?=
 =?utf-8?B?ajFZUkd5NjhaRm9VYWVHckRqWnRKY2J1RmZhZUgwQlNGbzl2Tlc3U29rTFhz?=
 =?utf-8?B?SE10QzU1d3Mwbnhlb2NKak9QdHlTRytiQjdDbXoramhXeDk0RjBzbWlYZkY5?=
 =?utf-8?B?R0pSdHlFcjhrR2FhTFo5MjlSYmVSN2xubmEwVVJhN25YS1Fxb3ZseVJhQjlB?=
 =?utf-8?B?M3hlWW9pUHdOVTNsVmlTb05XQ0Rpem81RmN1L0lGaC9OZHA1Z0pFWFIwTjZL?=
 =?utf-8?B?eE1rZW4vTEQ2QVUxcFZYMEdTdDc5QlBEWFZidUNOU1c3YjdqQzRrZmVOajVt?=
 =?utf-8?B?OXpRU0s2SjdzWXhCN0ZKU1NGYVVPcFRTNUNTTWRzam9NdU1NQzFVaEZ2NUpN?=
 =?utf-8?B?d3NYZG9Yc08xSUdyKzI3Q2lQc29Dd1lsbWd4cHlxenFJT2xaVkhRRUNrOFlm?=
 =?utf-8?B?U1pMa3lIY1VJSkFxZW9DNVRNenRoNVU3Vk10WjkwY3h3QnpyMThOQ0JHZGc0?=
 =?utf-8?B?RzNNLzN1YlBCRnpXNlRYMFptZ2dUeWlGaWxHYThjZ0ptQTZta2s1WmxEdE05?=
 =?utf-8?B?TVl3bFdwaEJhUSt4U25RSVJrMU5LZkx4YjNyZ080MG5jaElMUHVWOEVOQlU3?=
 =?utf-8?B?NjhIdkxhZjArYUE4UmlZaUN1d0wycnJ2Y0pSYXNpVm93VkpOZEEwbkl0MS9N?=
 =?utf-8?B?VkpGR0Q1WDFqOWt4QXk3b0RzcFB3b3lNQU1GdEJCb2d3RHowdlRDVzFUa2Rk?=
 =?utf-8?B?RlNRZERrSXFXOWhUUkZ5Wk1TYUNSOVdQMFpQSVFReWhsRmhtdGxPQ0tYS3Ja?=
 =?utf-8?B?cWZLa3lNQmNtQVlUMFE2UHZWS1RtaVNaRXdxY2VJVGR3Tll0cHExY280YWho?=
 =?utf-8?B?MjE4MnBmMy9BN25tSjFFcHkyZFkyVFpQMnFmS1VMWHlYcGJLWlM1MnRDWEtz?=
 =?utf-8?B?OFhrdXJLd2NhMnVmMWtod3lYTXlkbi9wTFpYMUFESmNySCthWFlsOFBvVTlq?=
 =?utf-8?B?VGhOYkFiSW82bnM0Z3VhUHo1dGtjU1FRd29KcVgwMnZUY2hOeGFyQTZYTmlU?=
 =?utf-8?B?QTBWc2NmOEpCV0dDVjZUL2o1NDBwVnRsWW0wZ3ozSWNxYnRZSmZvbGJBWTIx?=
 =?utf-8?B?MDU1NTlWazM0d09XOG9NNHZTb0VvUUJDYmgzWUdaYklvaDI5VVpTSW05U1pS?=
 =?utf-8?B?Vm91TzdVRC9yWnFZSm9MYXdzQ2NsS2JJbThIOFVkczBXclpmWDdVa1diZUQy?=
 =?utf-8?B?SDBteXBtbTBSWVZwODFmalZsNm01RHd3K1JNQmlua0xHQkhmZStCSlhQYUJo?=
 =?utf-8?B?bEI2MnQwRndHWkNhcG5zcU91Z1VCZmxiaGFkTjg5ZjlPenVLUTc2L2l2UXRu?=
 =?utf-8?B?U1grMk1TOFUxczdrU0FBSnRWNkxZZ3owTDJlVXdJOHlMME9ablZQbVpaWjUv?=
 =?utf-8?B?V282WWY3QXlaZE9ZS1pwWnFJd3NMZXFiMUsyRmFyNEExdTAvV2tVUkZXSmcx?=
 =?utf-8?Q?ziVBKykqxK8MuMsTy0ovMqY4/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07ac3e4-e501-445a-e419-08dbd62494bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:08:01.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t96kL6OIrw141yHqTErG4x46hDWl+4OiUAd4/eekX/pTa0BPq/lQV7j1DFMRluvijy0IjNquH0y+YNuI/9+LXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137



On 10/26/23 08:41, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Note that the bug will only trigger if Email::Valid is installed.
> 
> I recall we chased a different bug that depends on the use/non-use
> of this package a few years ago.  Is the difference significant
> enough that we may want to install on one but not in another CI
> environment, like we have a separate CI jobs with exotic settings, I
> wonder.

That would make sense to me.  We have had 3 regressions threads
recently for git send email where Email::Valid was important.

- [REGRESSION] uninitialized value $address in git send-email when given multiple recipients separated by commas - (this thread)
- [REGRESSION] uninitialized value $address in git send-email - https://public-inbox.org/git/20230918212004.GC2163162@coredump.intra.peff.net/T/#m9e0211a8ad387adbbadf31dcfcd7982d4046633d
- Regression: git send-email fails with "Use of uninitialized value $address" + "unable to extract a valid address" - https://public-inbox.org/git/68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com/T/#m1411c155e11ad9c5d913d22d1d11180ed56eabc7
