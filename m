Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2117.outbound.protection.outlook.com [40.107.95.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F26A33F
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633999; cv=fail; b=J31OgNZtu/avtuqLJhKb6+mtLDLrFF+6D2a7cGx1j1TO/2F91CqCBFuGeC8fpXeflIQfaaqorgoBwilKO97RJST6wJNU2HBAp8aQ/w3akJF+ximRe5ZbVJwMnnL0jHujYY96TZWJPMDTj4p6R+fNCuSNUgNMvGdJ55yBXIN3BkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633999; c=relaxed/simple;
	bh=qjYzu6BNpvAOVdk4lb5M3x/MecIjbpXd0OC8oXGEToU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=clm6pUvSNNR9ZsFD8EF1jOPtXXNwpEEYBpj4YiiOYvdvo4wsam0TPDO1RTbQoJdo4q5Z9/HzD65MEE8Scfi3vt6AyJ2XFJhkqgZ6n8g4tN5Zn8HA1pZxZeXfqjrm7fDEqPB66mjsHAvkC1Y9qVK6hmvQkI5x8BqOwl06eqPsUR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=Aqb1ptYf; arc=fail smtp.client-ip=40.107.95.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="Aqb1ptYf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgaGSY0R4wqXGNvE/Gkd5pnFnbkGhI5pOBCpX5Ow2pt4VpRuC4AOxrCiNkvoKV6ZCyLk1levrS7iGOKk15N7Dph4cmYSwNFEkL/bWJLbH1ZLn1yvBgeeAZg98EOoscn4DQ0yrdDDYyrrKRv+L9a8BXVT2KcmYkslJCofKGyOf3bgQIHJ8ZznY7YoXF/YplxndlozHKGFBItlHndlw7ONAgkN+ljzWWo/ZPz4o4fucF7MJFNfUEekXXnfVn5C4LYvPN4dX5cRxk0ZIkE+TYsjh12Dw06btmtgBKRgJhc7XVhGwvGXjxSLHOOOYICpUXg0EFBCfSHGg/LsJtyEir0ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogBz5M5iRmy5lDiVXkWVuX9SlN76+doyWNR1P1ut008=;
 b=ou339CnxNsrMykvI/uIQR6EmLv1TY+RW4tt5RHmd65lWg+p5UYKqztrSIRdeIro3yRMayoK0QVsWNdKma5vKsqsC496jmVrVCH2Uw+pxxA+IhWOHrfRyuAmJgv7FOQcCkUjD3ExT+Kww3JVAElto9wxtEFCkS4DhQVrWcbDnsh9AINP8l90VU/LtiuKlxX/SAdkBov93z3aG0LFH7Ur5CUJNNvFjb3ByqoO//2d8XTApcqiXU7Urhd6p9AbL61Hvh8rqQNzblhyCQQLAMvUhWPbuc6/ULOsOwNX4UGu7/FG99+UyjxVIDpFw5S1IriWdAwtJ9kDSNhB/29TccJR4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=peff.net smtp.mailfrom=alum.mit.edu; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=alum.mit.edu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogBz5M5iRmy5lDiVXkWVuX9SlN76+doyWNR1P1ut008=;
 b=Aqb1ptYfwogiTGRjmQy4l5/Rjc/9NSM2J++euGeuHpEK5/XpLgVZb4eOwPMgZhJiYaA+V0sT2/MNfdV6fNWNSflXmOVuqfnxYtAdl9gE3zTORThzTaECTn0UQ4wJhQqacWEMPVZKUlv0jYe/q1iphGs2kIYBehCggavGK8WJgfo=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 2 Aug
 2024 21:26:35 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::2) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 21:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 21:26:34 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 472LQWOc010015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 17:26:33 -0400
Date: Fri, 2 Aug 2024 17:26:32 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <xmqqfrrmbpbv.fsf@gitster.g>
Message-ID: <c7b3383b-ebbf-6ec4-00b8-41c9430a99f4@alum.mit.edu>
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com> <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com> <xmqq7ccygbx6.fsf@gitster.g> <2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu> <xmqqv80idf52.fsf@gitster.g>
 <a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu> <xmqqh6c2d8qt.fsf@gitster.g> <30733887-33d8-4049-7dc9-8bc9d0b106da@alum.mit.edu> <xmqqfrrmbpbv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323584-1661588291-1722633993=:560477"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac43290-f401-4cf5-e4bd-08dcb339c903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTRZL3VzN2N0ODJUdXdzRUMrOVFvdzFac2VRaGVtMFoxRkxzenk2cHJVY0NK?=
 =?utf-8?B?T1NsSExCUEhWbEdmYjkraGpoYTRmdzNuczVvRHhpNmJEdU9xbGtTUVRVLzdl?=
 =?utf-8?B?SS9pQm85TzZxbzJQOFlwaXV0NG85R1h0VCt5Y1dzNmx1Z1B0MXpiR3hmak1Q?=
 =?utf-8?B?cEN6SHB1dUMwU2JrTHNtYVdPZjRGajZjNk9GcStiWW04QVZEY082dURMc08w?=
 =?utf-8?B?RTI4K1ZncDR6MXFPd1FEelB2cWhPelFmRldIQWhQbGV6SFdaRlRNWE1SSFUw?=
 =?utf-8?B?b0trZFpUU0xrWHFaWnpDQWcxbnlJemZONExjUVZXdmVIcWpGMTdRU3VBSU5j?=
 =?utf-8?B?dUtMa1U4SEM0U0krMTdwR3dyOEwxaXVuZjIzNnluNDBxWTlIaXRxMUd2QnZk?=
 =?utf-8?B?aFFUZ1h5a2FZVVpyejk5dTdtZk1ud3JpbXEvR2lwbjYxMWlucTB3RGJMcVdM?=
 =?utf-8?B?Z1BkTW8yK0JiSEFQNmxEakJoK1JqTXA0ZUIyYVp5NmFkWTBWVUF1YmdJYVhj?=
 =?utf-8?B?QmNvbGMvck1jcXR4ODVURmZyaEZ4VFMvRUg5MzhiU3cvV2xjdVRISk9rMWdH?=
 =?utf-8?B?WGZMYzQ4OXd0UC9nTmZxWEVYK3lhVXZ2aWVmY2wySVBLMmVZSHRHa2VIeUZ6?=
 =?utf-8?B?MUpXeFdBcUpMU1BMeFcyMkM4SkRoUmJ3Z2pBdzNmNHorZVFxbjhsREhUQlJS?=
 =?utf-8?B?ZmJTbUhCOEZaNGVHd09wMGFJTzZWMUdFVzhkUXcyTjV6Q25zZzBmK0VRYTNV?=
 =?utf-8?B?Wmh6VkIrUndyU1VveDNNREFlcTJQMkJqa2NtNGZ6MnF1bDJ0U3h5Uk80SXdk?=
 =?utf-8?B?bEJxaU96WlhFS2kraWd6bzE4ekNGdUpxSjlEWWU0cTdxSmFiakUrWlptL1ZZ?=
 =?utf-8?B?Q29YNy9uV004Q3prbzJsaVNIdS9ZdVZ1WjhBTUtzUFI1WXM5cncwNU16UXh5?=
 =?utf-8?B?ekkzYjcwZTlmVkpadlVYRDdIdTArSmVYcXlFNldHNzZHVHgxVk5YeFMycWRy?=
 =?utf-8?B?bFhDT2Y5S3lDb3BYZ0xzQ1BsMlVzS0VNYjZuSXJMUTNvY1hQZlJBMFlVamFO?=
 =?utf-8?B?SzdaWTlCSnJPZTNuSHhadysyTmE4azVGWDBuWmFyMlRQTWxRZCs5cDZaQjRD?=
 =?utf-8?B?d0syWldSNzJjZnV5U0dVc3dCNG5XZ0lnM1B4TlZROC9VRVpGR082NVAzcGpN?=
 =?utf-8?B?aENNM0RoaS85NDlZVjd0MFdCQkpWU2pvSXl3U2oyOVdwVE1oRmFCdDVldFN2?=
 =?utf-8?B?ckJWSzQ4MTVxRjBwb3BOcFBIek5pWDhlME5STjlnZUI5TFh2MEdQb3B6MWdW?=
 =?utf-8?B?MTBjZHVPemJHcDZET3ZwZnJ1Z012MnB2ZFZpSDhnRGlPM0VWZE1nWFlsZHd3?=
 =?utf-8?B?L0JWbFF4T08wWWJDVHRQMUMzL3N0Um9vcGJ0NnBiZ3JQd29GTkFBY29tY2pn?=
 =?utf-8?B?bEo2K1N2aDMxKytyeVBJaGtNSXlkMmVKYnJSV1NZbUk2dE8ySnVMWUxwakJ0?=
 =?utf-8?B?ZUdOcnk2bHdlNUVuVWRqV1I0blFQdnBrc3JFZE5RdDdJZjR6R0lzL09tWG50?=
 =?utf-8?B?ejZvQmJwN210VW5RUllpeEtnTEZHM0JnSitJV1owZGZxNEU2Tnd4a3YxM01Q?=
 =?utf-8?B?WVR3YTVuQ3laRk55L3RnY2dtVy92Y1hta3lJVzJHSTdmRER1YTRXZkhpb3Zj?=
 =?utf-8?B?YjlPWmw0bCtXWlc3bUNJeEsxL3I3WUcxYjJSRkVlRyszZGFmT3BNdlhObktt?=
 =?utf-8?B?NU11b2M4b1VLS0x6elBBY3R2K0V4cTJ0NW5LMG12TDhsMXdTVHM1ODVGKzBG?=
 =?utf-8?B?YzFvRGd1UkpmZzlmZC9ocXh3WmY1QXRTdUk3TzFSbkJjdFFTVXErSGcrYnBk?=
 =?utf-8?B?TUVmMHVyN3ZVR1Y3RmNqL3M4bXRzNUtoOENNa2RMNVJDUitObUZQV01TUnVI?=
 =?utf-8?B?MXIxbmQrTTVtWXFLRmVyUS84cjNBb09NdkpQN0UvMUFvVXBpL1Y0QWV5R0FT?=
 =?utf-8?B?Y25xamFGY3pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(41320700013)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 21:26:34.5188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac43290-f401-4cf5-e4bd-08dcb339c903
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1661588291-1722633993=:560477
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

At 2024-08-02 14:13-0700, Junio C Hamano <gitster@pobox.com> sent:

>>>>>> Is this blocking feedback? This strikes me as speculative
>>>>>> over-engineering
>>>>>
>>>>> No, it is loosening a pattern that is overly tight and as a side
>>>>> effect shortening the line to more readable length ;-).
>>>>
>>>> Blocking or not?
>>>
>>> If we are updating anyway, that question is irrelevant, no?  This
>>> version may hit 'seen' but until the next version comes it will not
>>> advance to 'next'.
>>
>> I can't figure out what you mean by this so I am going to proceed as
>> if you had simply said ‘non-blocking’.
>
> It does not make much sense to ask if a suggestion is "blocking" or
> "non-blocking".  If you respond with a reasonable explanation why
> you do not want to take a suggestion, I may (or may not) say that
> your reasoning makes sense.  IOW, making me say "it is blocking"
> means you want to me to say that I won't listen to you no matter
> what you say.  That is rarely be the case.

I want you to do what Documentation/ReviewingGuidelines.txt says reviewers 
should do:

- When providing a recommendation, be as clear as possible about whether you
   consider it "blocking" (the code would be broken or otherwise made worse if an
   issue isn't fixed) or "non-blocking" (the patch could be made better by taking
   the recommendation, but acceptance of the series does not require it).
   Non-blocking recommendations can be particularly ambiguous when they are
   related to - but outside the scope of - a series ("nice-to-have"s), or when
   they represent only stylistic differences between the author and reviewer.

Because I would rather not have what is likely to be a highly subjective 
argument about this particular choice in a test script if we don't have 
to have one.

I would also rather not put time into figuring out how best to rename the 
function "old_curl_version" if it no longer checks for the particular 
error produced when the curl version is too old, nor would I want to think 
ahead about whether it is correct for these tests that use this function 
to continue to pass if different variations on this error are raised. 
There is one qualifying error currently, and that's what the test matches 
against. Matching against hypothetical future errors is speculative 
overengineering if it is not obvious how the errors will vary and what it 
may mean if they do.

R
--8323584-1661588291-1722633993=:560477--
