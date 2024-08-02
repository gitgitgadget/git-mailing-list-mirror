Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F87B67E
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722636860; cv=fail; b=EOtF9OZCUTlm65gwuzNrl7ijxgsdR6+u8NjhKEmTC9InzUncl+ofSU2rgWktQyO1qLyPr5P25tfVmviIKXnRXXSSsHvkCr9j4JeuVdETJ8JcC/2sivkkFcpI1B7VYeQP5KH6/5cWk0kOmcwQh3wBJZqjfTWdB1tm4im8p/37Vxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722636860; c=relaxed/simple;
	bh=fOvaMhAbddU1jZJsWjNi+zXWwiwYpvkm4f90BPq/Wuk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eRRnfIF8FUzqwqwFRbSys/KMtE/5f98rry1gsXXmg3TvkMZAH0KtmFn5pFFdl3v6wjaXwjjYp+pHV8b5F0W7LUvY10GQyU0fPvX6mxUXuKKcbw7RWehLspH/tzK+2uD9ihnyyLGC/xTirW++OlYQGu/WtWSLb5ICb3pXvMzrP58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=IYXiqSGQ; arc=fail smtp.client-ip=40.107.243.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="IYXiqSGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2al9evaI6Rdg9XlFOSm43GrSSUSwb1WOmwhwPvc4F6hjn5NlSK1PUgJiCOpdCAcUBUd+5mPs/0eGZmKVB35HPUVsvzpBc+86eUOn0kjiJyT9iRQklL3/dpNty+cHJZUUBiOTNBrxX3ojB9xBdLIAVTjXUCrwwT+yP8tg/6VXvG6ropDgL0XNULCCAHz33i1//2HUzrEGIqHmOpJFdVBqHzM4Qktr+FQoQU1yN0MW6LZTb/78UFwv7lePxc6JkhdkRo0levUDnjXyizREKzJoFG94D5JyD9lHPOaBzLeWZW0vcdJc5nlel4tr+EzRr00icGSSXwBjWRYiSR3hQzLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCobMvlEsa2NVows6nM+6CvLWSE0s+ZxmHBTDtIDCkY=;
 b=dG/Im70V6e09GLUPiMnYmBL9oJlkkiI+Ohvsi5eeq4OgF6V+XgPus7tqPC9Dt7jIuBOHK0oYW17dJTc5lSoKu1eh7QW5Zjynjxxj9NjuTgVBvl5kZDlZwoVAJP/udY7u6UkerCnFLL71+1EGUKlQH4cV1/9z92/jL98WPl7AMjrxBhbRE+EWKJy6GKJeLFRiSk8mrcetTuqRjvjkOKwS0+/qMFmk/B2YuuYpKj2BGNZdAyUmAHJdlOIgsaE3PdSNrxy+r3tp0Q22bRsWUs05HgRxNJ15iGyO6PC5gjyRBLHq+rD7YzSHlSwZAo0IuHVx5X+LGnF/gZTGA9RkbI5bEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=peff.net smtp.mailfrom=alum.mit.edu; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=alum.mit.edu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCobMvlEsa2NVows6nM+6CvLWSE0s+ZxmHBTDtIDCkY=;
 b=IYXiqSGQxWUXsirkuMeoZkMqo46Qz/hhnW8e2yY8iC4HfDs6FE0efs+NJIQXmgaXzE27mgl9qrEPkfFefCJQNpLZSzM0wMUSzyPaWDFMrrrw5F0vO2NLrABGQi8ZqxA22eMm0SGTkZY/IMr8TLHvfyQAhRtp4YjSB2eyz1H0mHY=
Received: from CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::28)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 22:14:16 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::e8) by CH0P220CA0030.outlook.office365.com
 (2603:10b6:610:ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Fri, 2 Aug 2024 22:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 22:14:15 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 472MED6B012761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 18:14:14 -0400
Date: Fri, 2 Aug 2024 18:14:13 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <xmqqikwia97c.fsf@gitster.g>
Message-ID: <7bb4bc3b-2280-3bda-c104-1dcb9e12db11@alum.mit.edu>
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com> <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com> <xmqq7ccygbx6.fsf@gitster.g> <2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu> <xmqqv80idf52.fsf@gitster.g>
 <a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu> <xmqqh6c2d8qt.fsf@gitster.g> <30733887-33d8-4049-7dc9-8bc9d0b106da@alum.mit.edu> <xmqqfrrmbpbv.fsf@gitster.g> <c7b3383b-ebbf-6ec4-00b8-41c9430a99f4@alum.mit.edu> <xmqqikwia97c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cc3a2f-a503-4c1c-63be-08dcb3407271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3iumzLJx4M6vwmNDJ1VLJIm1QVFmeJHCwOC6Q5lxWFC+5fL0buultLaJObd?=
 =?us-ascii?Q?NAjoGpXwZzSTrl5/njU8O4kWEv+tsX2iuvvyoYUKVFuR5zi2SyxTFYYa26jl?=
 =?us-ascii?Q?dH8PLbiapq4Akpvr12YVYzSTb2eiq5oQ8UxhU335ca6nC9s7hs3MtrCC1VtM?=
 =?us-ascii?Q?xmgyDKkeDoY9WYrXMqKD2OCdfKXwxK/PNoDeGiSvqrPn9EkfXGCrAXbLxIlT?=
 =?us-ascii?Q?nE+N8lC/ZBqlMIzBmJ9faCHB4ekQqcRUHsixCHbYrcVFGFRTPTs+lBxHNGgJ?=
 =?us-ascii?Q?BPnT7wvbFjQPdUGsHCUtSyouud6WxB4QRyz/PjHxG/JqvCCkj+TPopbTdc+e?=
 =?us-ascii?Q?02Nz++dLW/U2bgz7o7Y61rg9ejrf+nNiNMKN9CqGtxI0JxSsxwY0THPz+0Av?=
 =?us-ascii?Q?TRzgVQHdwvO+0wtGLJFEj5iTj5wTXznV1dSNDLpX1m7n71z5ari3zXM5y855?=
 =?us-ascii?Q?dA2d+MzatDGENhQnf9OmvtDazD1SN4KOu4ta0J0RA8hCfydHDftHXbUHZoMo?=
 =?us-ascii?Q?KVZ1+IRfhUVRZMQ8sQJ3Jul3OD57QDJefDNh7KCa1UNr/KgJxf27I0MGzS2r?=
 =?us-ascii?Q?Jfzu2VD116qkkgN5vhJMXOUp3d9i4PhUd6NtUtvkV9Al9nw1XwbNloK6dYfV?=
 =?us-ascii?Q?1qDPRdRuaSgrTbPpnkdZc7b2OLf2TFJwskLD8LtY4L2KjnqUOGjfkbo6Nhkq?=
 =?us-ascii?Q?OYmE1EX5iVvxMFONa/ThCKjXz0V1+X+bh93ZYpuH9R/E8xQw524jbEkST2dJ?=
 =?us-ascii?Q?4ExRcZvGaWvY6r9KkW79matGTzPMWAx0KdyA1zPj8R9BuxmQVWFihCSxXAEU?=
 =?us-ascii?Q?P+1p3hJUst8fNEK6cISZDlK9QcYq7PDvRwM9u29ka18nrfD7vd5OHQh3kth1?=
 =?us-ascii?Q?isIiMAPP14d3nSmVG9lNnt5F/S+IRGuGDsYd0zdIS1IvdMUV4SYU9kZVhALY?=
 =?us-ascii?Q?abVZNgnKrI7hDqdUrwsKRSK1SCshaKuk7A1mTIjbsB1OcfwM5nPbSXRNhrWs?=
 =?us-ascii?Q?hmbhN0Au73JdbRUtEok248Hhipucwm55JmPOTzZs9zdSV+lKt2gZrvHvabko?=
 =?us-ascii?Q?RxQzWxuHOXNX/T1aWdV40piDCa+5bdhHK3yCH2+YgRg1DDTMFU1is6Vzt4cH?=
 =?us-ascii?Q?P+qIQT8bAeajeiBUEVyVK3dcdPL0rhezL+95Bv9CpJSR1HY/2z0z1Qw8fzOx?=
 =?us-ascii?Q?FQev6+ep6uth3fHvwSgcv2lLE/fCLeAT9enRwiIbJjsAdGP2xrMBsiEE2ZHa?=
 =?us-ascii?Q?F7AQciDp5RXuBFAS0FcbdQQR+NM/v4NcJhE+jpDUbUcOIIKwIzqmpwdSYlbP?=
 =?us-ascii?Q?uRbc7LMc4uH/+Lg/BtSELF2kRrS9XgawfyExE6nZ8VHPMAaMO2i52kfmxwtW?=
 =?us-ascii?Q?jOTdLpVsd5rbbv7v2SgYYOcgvHALJWF/efQXH/i8O3xqdsaRBLAa56aFQLu4?=
 =?us-ascii?Q?uXsZFIh/gi4HA6s6nme9CroxA7IdUek7/NMXv3X+vvB2tqPWLE3qQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(41320700013)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 22:14:15.6892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cc3a2f-a503-4c1c-63be-08dcb3407271
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

At 2024-08-02 14:47-0700, Junio C Hamano <gitster@pobox.com> sent:

> Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:
>
>> what the test matches against. Matching against hypothetical future
>> errors is speculative overengineering if it is not obvious how the
>> errors will vary and what it may mean if they do.
>
> The easiest you can imagine is that it turns out the cut-off version
> of cURL for the feature turned out to be not 7.84, or versions of
> cURL shipped by some distros have backports of the feature to an
> older version that explicitly naming 7.84 causes more confusion than
> naming the exact feature we rely on, and we end up rephrasing the
> error message.  We have done such changes in the past, so it is not
> really speculating "hypothetical future errors", but applying common
> sense gained over years working on this project.

Okay, so is it a problem to also change the message in the test if that 
happens? My concern is that if I pick some fragment of the message to 
elide in the test, the message could still get reworded in a way that 
requires the test to be changed anyway. Even if not, the comment above it 
would likely need revision too; and if the test doesn't fail, whoever 
amends the message is unlikely to notice this.

The way the test is written in the current version of the patch, there is 
no ambiguity about what is being tested and what would need to change if 
the message changes. Future contributors can grep the code for references 
to that error message and find this test regardless of which part and how 
much of the message they choose to grep for. Shaving a dozen or so 
characters out of line is not more important than those considerations, is 
it?

R
