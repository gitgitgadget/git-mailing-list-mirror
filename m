Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C8EC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 14:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376367AbiAaOIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 09:08:06 -0500
Received: from mail-am6eur05on2139.outbound.protection.outlook.com ([40.107.22.139]:60480
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244552AbiAaOIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 09:08:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqMSPY2uaYGNFXWi3nPfNrqdjhbpxt6hZKU77cgLJKDjBapfc6cN4YYHnjNyASBIAS7KmW1IJecvKIuPt2SHPu3WVuE+ef10OYSeK51a9IpnBIhR5cyHjeNm3EZun16bDu4O841+n4GNUsadO32gwU9I31kWdGRkm0TGiW3TPz7oTAOGw3yMmLgKUtqEigIDrYFJPiO6puVHoNZ2BnxB2b5j6HtFne4mHGHKnqCzI+OZX+0W3yij71IHFuUnhvK2yP4o8iWSscCgtK30G86iDpSyrITFEFRAvNaaqNiGWA0EqaDTsOjiziXGMvGcjM7rpWUC958Ve/mcfp3jCAMg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojCu9k4zTguerLM28EoeA4nVqlA8SzKoVSHUnOW92dg=;
 b=CbfjMbS6pRQ3RAQmY/zoIANw1CNrOzu2KFtp10wpkdrEGsuRTdM1UAGk8GD9s0B/wWIpB0Y7NczeX4ybhDvPI+TqX1h3TO4nYv0mpXEGjBATlJgq3K45O7BFNqP4lNDdJMrlGHSIeCui6XpdksJ4yLsS3JIrg+raR6swEml00hK0KyllCMg3lI35aKB19l7/9FFt7WLUSbI4UtjOK5NngzdWYce7BtbqkoaZYlbxMnS5kUaNAVNSMve+npC2vRyc7dGzIsHKdeGSHEM8UAj2S2/vRQEZQeBckNql0IV5lQb33xjbJMCY4vXoSRZXrGci4D05kKwaQM1tKBYitDy0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojCu9k4zTguerLM28EoeA4nVqlA8SzKoVSHUnOW92dg=;
 b=C+r6zLyd+CbTrhFltkq7IfthtAUx4o5kioGC++wIK8J4hU0boi0LEKfSXZI6YH+mf3b6Rw39MsvOWHjqh02tKtGkxBc2LpIx3diWLchYlgcPda/v3TlZG1YxTofq+uI+dfBxCBj075NRpMKEnvCf7MruPZkNB6Xt2vTH7TOOD6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by DBAPR10MB4044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 14:08:04 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::608f:51b:ced9:9c8f]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::608f:51b:ced9:9c8f%7]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 14:08:03 +0000
To:     Git Mailing List <git@vger.kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: remotes group with one member
Message-ID: <b5d27968-fd45-a58e-3619-feadc6a4cc5e@prevas.dk>
Date:   Mon, 31 Jan 2022 15:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::13) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 424d68c7-ef84-481b-a86d-08d9e4c318cf
X-MS-TrafficTypeDiagnostic: DBAPR10MB4044:EE_
X-Microsoft-Antispam-PRVS: <DBAPR10MB4044CB7F90F26C82517FFA4B93259@DBAPR10MB4044.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4bnHoav9IOT887PPiyXJgEaFsBTEtZX1L4sFCzski6jOvVnB/S0Qh8xVkL+80i3daXYKwKe8GTSw+aySsORqGICPG3Ae6nqSbdlcytB9xvWgooae/SW31y1kfLUvAB8qRuQ5j6qfuyJV1rieuG9MumGNNrNaZRmHjx9V2r5Dr1Y1yQj+Vn+1rPxmqk8qfx/yJZLzfZvf9tpGQ3v7/B8lxfkU6oxV1fubkJsSdES3YI6BBdGTudynLS0zZ0UxSZ284SMitUZm3/B5jXFkD9P7Z+x7PD0dpWLB7HTwpV8BfqjCNNjQwBQTFr2eGr14z2hS2vjnyZ+WTJF8MJchUQV/ueVBAt8zNCDOzU2xAo2cYHtHZhchkYjcKYI+foQR/ujbHwpyQaWBSCSRC/qvTF5X9chmqJQyubEMEHQKTo11Qhi8c4hcqYkHRDr/0RuaywzfWr7NzbJ2fYx1EehZd9gnn0jBa9ixovMIdVXQrYqDJPng5Z57bGq54CvewvNmeCt9SzD52tNL6EvRUxBBLh3AkRe5HzmpR2HO/rB7gT3zQkwzRKJgk6UyyYT7AWJyWBPhJ6sIuIUAThjegqu5IijJqkINzsvwtSOzXOP6CtnQJU3nI1uU1nHRgPP16R8ggMeF47cQOwr4eKnIh3XnXwA5sIQduHrTqewrBS8/P+F37SH5WEJ1dv2Hot1wkiNUPJ42F5/uIKGhdCSvHQCFB/z2pUpDGjatxP1pN6xq2F1CHi2sLjnvduZ2hJ1ZNYA8mFKj5peiEiDtAbGWuEi5Th6Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(26005)(44832011)(52116002)(8976002)(5660300002)(2906002)(2616005)(6512007)(186003)(31696002)(83380400001)(86362001)(508600001)(6916009)(36756003)(8676002)(8936002)(66946007)(316002)(66556008)(66476007)(6486002)(38100700002)(38350700002)(31686004)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?Cu1yw4C17cLZ1BDYlqCntp2qL4eAiGiU1xffB4q6YUu3g9Vquqq1QnKG?=
 =?Windows-1252?Q?oqdSeYT5saTefOchm9g1FMTyTR4uq2V7XaK7T+DhjAU1gGAIi4aGn9W+?=
 =?Windows-1252?Q?bO+PcHPrgePqHuqGJcJfMmFcCbqua5GvficrjTH4sTEjX/2VMBLQd0Kp?=
 =?Windows-1252?Q?Tn65ph0KEXbbJh0kepo8IjlPEARWL/lEAXMtqlUxn4C/vU1i9wl49XcP?=
 =?Windows-1252?Q?apCn8y8SYNlmafB6n0u1q9nLqJ0yA8YtCHY1aSN+3g6OVCwUYjtOkuc2?=
 =?Windows-1252?Q?DbLiXzL9zu50hoUivVIFSt3ujjxSt11ub7uPfds546m66Z7XYy+d6LPH?=
 =?Windows-1252?Q?aGBSNHiuKutHX1y8l5XjI8fnQZGYHAMvND3fEbHLkOl+FwA0aDDpop6N?=
 =?Windows-1252?Q?DVpM0DUuARuhVAIKsDxNW8JnSjQAX8+So5+rzOKnsxJ9H6ZYJoDKM96j?=
 =?Windows-1252?Q?O8CIEYe8/roiseBWnA6BNoZyS+WEFDDn0ziuH+qcYOM+Z3kv7AJiPDci?=
 =?Windows-1252?Q?s5xGcg30FhIGhzqFsERdZ8VfZvrMQ6oCqpofJb8nB+775iZLYYv16dUb?=
 =?Windows-1252?Q?ZaGwOcHDqcSIxt+cgM2D4B7spOZn0YSObUh8gFsaUFHZltnTNA/FlWQG?=
 =?Windows-1252?Q?cqckBEw+OJwBoBUj291d6m/f90QGDQ9Jv3g0thgNN1ccBE90btzXgy7Q?=
 =?Windows-1252?Q?X1IEVaW4sPnxLaL+DrwCbftNzP/6oiRbdv0DhfxcTA3kYLl5vFLVJZYY?=
 =?Windows-1252?Q?CLFfCnvkvSKezXaMNLy9DePmknSIXprJyhTtINnHPcFlWGIXHrgiugdf?=
 =?Windows-1252?Q?7sqmQ/1jXV3JSP45l5yBVFcpwXWZ+Q+heY7b/5y68XVn+LLXuxayIkEQ?=
 =?Windows-1252?Q?+TKckeITATomdM+bpblIvj2U4Ry+QSRYUDv7x34GSKd1cggIxFMgvEdk?=
 =?Windows-1252?Q?6Wi4vSwtEhH5IvPVssn2P76xHqQ2jdPLOjeZB4azgS8Ubk0mClr3CThM?=
 =?Windows-1252?Q?uJJRiFwLgOIPgPh1WuZ5OAWlXu95qZ2MzADeGqBX9ts4e87LQ3j/aa8s?=
 =?Windows-1252?Q?WkT7CrYYAxv/I4sPAONOqcpEw19I4pNCGis3vShsJrNmbTvwED6/6NNp?=
 =?Windows-1252?Q?nvyXkLGolWF4BZ+EJEXgwuY3THaxwySBAi843R78Dmh4gAZZZ9re/wnZ?=
 =?Windows-1252?Q?0dL9EBi60CzLxFCSBD9rvtYifRhEYSjtfZTlhxgZFeITcRP3/R82Tg6a?=
 =?Windows-1252?Q?uxqNlLe4sV7MuMnbV1DBuwm54SDvz0ArJZWGa+V/Ro7xpaD4B6BjQ0GH?=
 =?Windows-1252?Q?0uEH9lD/22yLtuw557kFi5Sk4p+XxRWhnxJ+U4ECPmMfB7mrADomHQXx?=
 =?Windows-1252?Q?zXsIuHqNMEEzKClZJz4vNeTqDVqL4DO7Rcert8h0htctD0bBA5e+xqgX?=
 =?Windows-1252?Q?0xFiMTF0NNskeTZowkwYg1ksBijjd778oAjBXKaJ4mPkzcVZLbt7QY3L?=
 =?Windows-1252?Q?Dj8uqc+/4c5x0NF9IFDN8ENzHj0Xv6O4zdM3XVs4OA/vk4eVFjU97TTo?=
 =?Windows-1252?Q?mSX1Ue4PoGARlW1Ha4dL8uGFUzsUF0/fSGin6ZUZJJhwhZD3/wAb1Y4/?=
 =?Windows-1252?Q?mUviAOe+JoKDW8X+mb7H0yZ8dW6BmyhA5DtV3BpVoNUd0hDS2ISiLAfN?=
 =?Windows-1252?Q?0uQ/Aw7pKg/h0yJXE4ktaqFc5YScZZirVAAGNF+1iEIZybtoIhUYT3ay?=
 =?Windows-1252?Q?Wf2BYgoiDtwL7nxwcorw82jRJZERQcGDQfKZthJMwLdVACx29HbCK5Eq?=
 =?Windows-1252?Q?274uzA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 424d68c7-ef84-481b-a86d-08d9e4c318cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 14:08:03.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFurwKge/YUDnOWF2j920z9F+pvteJ/raduGLEg+bcdJ2+7r3hU51UdP/d2FfoicjQPF7RjL6o6a4PwN5ZN+SzS+s37S8Lkrqo/n4FJ3R9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4044
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was trying to make use of defining a remotes.upstreams group, along
with setting up suitable remote.<bla>.fetch variables for each, in order
to make sure our local clones of various repositories are kept in sync
with various upstream sources - e.g. for the linux kernel, we're pulling
from both Linus', -stable and the -rt trees. For other projects, we only
have one upstream, but I wanted to keep the logic in the cron job simple
so I could do 'git fetch upstreams' in each of them. When there are
actually several remotes in the 'upstreams' group, this works fine. But
when there's only one (say, origin), it fails with

$ git fetch upstreams
fatal: 'upstreams' does not appear to be a git repository
fatal: Could not read from remote repository.

If I put the silly value "origin origin" in remotes.upstreams, it works
as expected.

Digging into fetch.c, I can see where this behaviour comes from

	} else if (multiple) {
		/* All arguments are assumed to be remotes or groups */
		for (i = 0; i < argc; i++)
			if (!add_remote_or_group(argv[i], &list))
				die(_("no such remote or remote group: %s"),
				    argv[i]);
	} else {
		/* Single remote or group */
		(void) add_remote_or_group(argv[0], &list);
		if (list.nr > 1) {
			/* More than one remote */
			if (argc > 1)
				die(_("fetching a group and specifying refspecs does not make sense"));
		} else {
			/* Zero or one remotes */
			remote = remote_get(argv[0]);
			prune_tags_ok = (argc == 1);
			argc--;
			argv++;
		}
	}

That is, when add_remote_or_group() has resolved the group to just one
element in list, we redo the lookup with a remote_get(), essentially
forgetting the translation from the group name "upstreams" to the
singleton "origin".

This feels like a bug to me, at least a UX one. Looking at this code, I
also saw that I could probably work around it if I say "git fetch
--multiple upstreams" (and that does work as expected), but it's
somewhat counterintuitive to have to specify --multiple to get a
singleton group to work.

Rasmus
