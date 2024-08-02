Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19443136333
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616999; cv=fail; b=HeWLtM5L6sY0c2Yf7/fpDZYbK/TMr3YNO0slgOmvMNMQwqVFquN04MGtWXKIh5j9xv/aNFn3TRh0U8+FDzGQcuOTYJksf2tgdwKjE1P/upaXz9veSGlZtPkSdWAH7O8927wnCb5T+mx0WkL/KKbry9l3q56FPjQOebRO+Nl0hbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616999; c=relaxed/simple;
	bh=cb2mgS2C+hME7fHzaJs2qFY8EeaYUqHWhmwqFhAiqG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sbJwFfX9MqbiWIJFiPqalqbZAuH8FTArCpF4YzEIobsHD9NpR9p505SwbEW7W72fpEGgNmEUMA7XLNQ3fKA+MJxfixDRmghzJF4NhCUawAgD1fYJ+jDhJBCC3pJE4wTDu0ZzSVSPtveLsQZPtAXveVGXz2j5v+I/sO56Us9sRsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=gKBQZW9s; arc=fail smtp.client-ip=40.107.237.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="gKBQZW9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pze7tccFMWbzOApCne7Buysl4lqntiKwZYL/BjtkwwK5hAsFflcZTCRoO/+1hCcqDzdZnPGwmnnwkgSxAMVIzIjmNMepMfJKBRm09PmOS2HlKIw3+QgFd2CiNH7fEmsjpni31Kq+TVpZ4CYs5sAfl4w7EZU3yJXUcrB3Gfyg1zAoc4Rt3cl1UCO+MYnc/oDvAS3TBk7aGUyJAjQDK1/st342+Qdi92oVNoiw8WVjamFXIcfkmPTpvxRK/IQ2FECcXf9j7QnF18g03yKddW5cbDI2/k3i3si6TXukEzTY5yPg3GRBchekeHG809lVHUDK7g4Uk2OR6f5e/P5VDibwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms0xJjLsHKQ2bteXXIlBMsv6GHd8gfFOVkdvEzqeSC8=;
 b=Xyf96QUEyseht6o0wY0mG309gTYU5IzKKTwT/Hno1kMK9lFOpM3rlD9gUsB2B39alS3hhP1JfOT6GIBH8N7qXzAgXGZPGTCwY84hUGANB5SLzSp+ioaNCipPnKwCnJk1xXnDeIyuCS6pmP4X/cELOZAwDjaVmgKXZ8NlrKBTmYAXn1KTGFeC3ZqXRm11cbmiEWMX/yHHjOFhrFOmbLCyjzsLwN2yTvtlNB4k+ZWGJgYSM/pMTPqehD7shsTaqD57y3lPMqym0XLli+9hM/6eSR/TbHmqsIMW5uxz35Crq9fD97sPvEx5wiVBsqmmklOnGFKP92EbWIy9qIVaewR+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=peff.net smtp.mailfrom=alum.mit.edu; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=alum.mit.edu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms0xJjLsHKQ2bteXXIlBMsv6GHd8gfFOVkdvEzqeSC8=;
 b=gKBQZW9s1bNRzsYc1LIiOy9BpSLTgY07sUtAOHi2XkA3UO90Pm4TSlH0CNBrBI7QQNlDD+pAvdfEBOp2NOFwWSw88DRzBdedI7ssisAkHNkN+x/6nY6KJN9zElVmyyiH6K9Y/tNopHSn9VvfndH7TgVSmBWrqBYCSrKAWXeqqfQ=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.21; Fri, 2 Aug 2024 16:43:11 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::7f) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Fri, 2 Aug 2024 16:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 16:43:10 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 472Gh8Mb026085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 12:43:09 -0400
Date: Fri, 2 Aug 2024 12:43:07 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <xmqq7ccygbx6.fsf@gitster.g>
Message-ID: <2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu>
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com> <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com> <xmqq7ccygbx6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 638a3c6a-f213-44f4-66b7-08dcb31231a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|41320700013|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nZsNxngNloadC06VBeCp1Fht+VFEXiM3xDMw/LqujNoJ4Y8FDoHQJ6JqeMX1?=
 =?us-ascii?Q?J0LBaRPPXxsxfLFxi0sGNaqQqu4lcEQt9hzryiNL0ZWzxaHvkYeyv8dhoMrP?=
 =?us-ascii?Q?VkPlDHgJXt6ZcoQTvGJzffbntLa+65fVQHBerr66TlocPylGM/lHoXqeCn9m?=
 =?us-ascii?Q?vqeAtzWZPUXVisTcOqngp+1PKmau32fD/CgrA56CuME/Gp9UVfG5ngtnXJlc?=
 =?us-ascii?Q?c3or3G66wNYg9ltuS8YBwUIlTs03d0ts8qH9yVWIqv28YE5pJi14T6mCWxbL?=
 =?us-ascii?Q?chBLy85o+/4K1rLsnPsok+f+yLCIA+u+hbKbz8Kj3D/f7Aay3OAY5Sh2kQdk?=
 =?us-ascii?Q?VGrssUWAI7SRz9xzeZSky04md8joNreId2kAXqFfAQtOp7aJdRsMekV7CCgp?=
 =?us-ascii?Q?ggQejICPrwPNSW3Aj/imzOtD12hrKbRW9WPqogmsTuE3314cqAwh4nYHlf4L?=
 =?us-ascii?Q?RZ1wzH1ZlaITJpYKsvhaQipvcpqHb4jCkvZlE05OAfatYUcg7GYS9EAwzNHV?=
 =?us-ascii?Q?94SSTaYwet//n6G8xvBv9RGEC7heMWSqahazLuYcVjMzKv6S850nbZP6S0A2?=
 =?us-ascii?Q?ZrSubgTY+07Ka5B5bAKTparhd2TtylzNI7Sq52WFJ1mEWSMX9KgHWLBdZikI?=
 =?us-ascii?Q?jrY1AJUe1Yww3l+OP0bhGCkw2JvpkbzRmV8YUKnml+JekQzK2eUqsgTncEBA?=
 =?us-ascii?Q?vu8YUbe7pQ8ZdUQYjt+CqDlQ7iSdPA7Ea9eqb5X9WC20TTy7X6ADmn/E+rrt?=
 =?us-ascii?Q?KRJfsf9XDmW+QsivNWLyUycAiT0u64UR4iiDXzCsHXg/9Qmpw5QuCtTL2xb8?=
 =?us-ascii?Q?NuUjfiPLubeeAL7b57MktoIQ6V01NGHBEi9bi+57a1+F564IE87pX8NtCFbo?=
 =?us-ascii?Q?xGollt2MDYuoTmTqwC+y4Os+aG0xFKUVLlVFsdGfJJ1AC6ItP49oToMIxgG2?=
 =?us-ascii?Q?5m3Aq+9u3le6Kb434Oh7s/M0wsX+eZi7CQb2eXGWSWGw/eSIQXl7B0vVdFW1?=
 =?us-ascii?Q?1VdzIAYK9Aw3mVXTu7LHLxzQCQByoegqnp2D7E1qjNY7/IZwCEo+5tSi2DxS?=
 =?us-ascii?Q?+kqHKefrrDc4KO6pQGKNNB2t0GEE/yldMgq6wpyCkBHXKtlQ4Z4hyikuvGQ7?=
 =?us-ascii?Q?EBq5bj06VQytbMswCcq/vOptCZIKxIerVYr6PvitVOa7TvHnYyZ+18Mxc74A?=
 =?us-ascii?Q?wIIdEI9xaxEc3eDsRHVqFHNMQ+e+xn+yVAD4IwqBBdMITqpaPaa8LpFvnICS?=
 =?us-ascii?Q?K4vIButWL5GZB5TbxnpkzDPnjaf9G3B1BjsfZ7lKvwdguK9CYgjhmzpzZqb8?=
 =?us-ascii?Q?sj9uSbN+n9/WCwYJramynwbimahE6Rc8smIhQWTOOJSe57+wNJKPB2O/OFW1?=
 =?us-ascii?Q?WSKg48WlyjZn01gGJ6bglYsy0gUCKaUQCSb0RbuEd3V1K6mnzbzaHK2JxQjT?=
 =?us-ascii?Q?/OIa4EVo9dd7cTPaz6hIGu5f0/K+wkFT7LtAT/HrE6+McgVZ5fw1aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(82310400026)(41320700013)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 16:43:10.1639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638a3c6a-f213-44f4-66b7-08dcb31231a8
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491

At 2024-08-02 08:52-0700, Junio C Hamano <gitster@pobox.com> sent:

> I'd swap the two lines (i.e., sign-offs) while queuing.

Okay.

> Our error messages that are prefixed with "fatal:" do not typically
> begin with a capital letter.
>
> But I'll let it pass, as this copies an existing message in this
> file.  #leftoverbits clean-up needs to correct the ones added by
> this patch and existing "Invalid proxy URL '%s'" by downcasing
> "Invalid", possibly enclose the message in _() for i18n, and also
> downcase "C" in two "Could not set SSL ..."  messages.
>
> [ . . . ]
>
> Or instead of leaving this for a later clean-up after the dust
> settles, we could have a separate "preliminary clean-up" patch to
> address existing ones first.  Either is fine, but taking "clean-up
> after the dust settles" and leaving it a problem for other people is
> probably easier.

Hmm. I'd be inclined to take the preliminary clean-up approach, but some 
of the existing strings (there are also two "Unsupported ..."/"Supported 
..." strings near the "Could not set..."s) are going through gettext, and 
I'm reluctant to interfere with the l10n process.

Would a partial clean-up that downcased only the "Invalid proxy URL" 
message be acceptable, or worse than leaving this as #leftoverbits?

> Let's line-wrap these overly long ones.

Okay.

> If I were writing this, I would shorten to look for a bit fuzzier
> pattern like
>
>    grep "^fatal: .* is required to support paths in proxy URLs" "$1"
>
> as that would allow us to fix the code later without needing to
> update the pattern, if we discover reasons, other than being older
> than libcURL 7.84, why paths in proxy URLs cannot be supported.

Is this blocking feedback? This strikes me as speculative 
over-engineering; it would not be difficult to generalize the message, and 
possibly then choose a new, more appropriate function name and update the 
explanatory comment, when and if such reasons arise.

R
