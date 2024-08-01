Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2103.outbound.protection.outlook.com [40.107.93.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054851D696
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483858; cv=fail; b=mj3nh/rbks96m68kZ/tPb6RlgKv+BNd9S7uqC1+Gg75MYY1sa0cucv1emixtKGovzmEhIDu2697s11GmruAsRvh4r+qq651j2Q1y9PQGhsYC8iELbcNSuHzjbc76Dj2Lj1vAUaXGxOkhtg60QQgwX5BBg4sDSn1UweJJBpeQmXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483858; c=relaxed/simple;
	bh=IwE/S7FCAlCpG8ELpa1h3GMF/xQqdTmNIJ4NLCKBTPE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TSqWyrXLLELtSW94AoXFCHMvM5vL/kIhYyKW2oWE/2hoRGGMd9WGp+Whjk2ICMnPbDAFia4FuV8MTauzDsrx/rsyARIMyi3mDboU1FXw2bV+Kuy8YfjjUc9njdn21TK2aw0ZUYiJypbDojgyzLfkYi/az0bUqQu9uX2at66jvF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=fZBlgQ9O; arc=fail smtp.client-ip=40.107.93.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="fZBlgQ9O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jot3hLm/fjlpW61264ILEWyJ88cE6ZxrzKkRzb1A4iRQdyRdcrMmCSduIJUXxHnIwSlNlRfzmfrEkGHhoOLaVbIXRjX3F8fZ4rpl7Tue2ucWECn3KMNITw5+hEDmaZstDzj7aBQU2mfdwb7aZAhYDC+hD27XS9zgBU8EcgHwSbOo/VWC1xezrhbPb8BfGyt8YEyXUFK4XxPuJl+nN1PSVPZXRIbE1H9jolAbpO3cnc+UklOxyK9a52QvJYdQ0I86F2S4DjUOpS0zhcTsGv4DlXyN3NlVBnJWNbAmiG0lMwtMUV670/HwUu+fFLv8YoS+ITQ8dhHq+Xy6g/Qey7eiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntd1xaamRfLbB3JP/dQRRZjyDTidtM16eTgpolA5b3M=;
 b=PUvoWHL98ffQiHEuLJXjM4CDbmPBQl6vSSKmjKO5HXbQhwsGoBXoCsxmYAwljj87hb0mcconUVoO2lFTbabV2hCDtOzjcjWVpQZ96UgI5F6JPqIbSujDRuaHtc+II2lQHNPgXSrOo4DBR2gCB0e3ckS/XRVi/rwBYmdpr+6p+vHz4xt2arFykC0LWwiINwh8d8twRyf8c9UTpTu+7w4zrRlPE8ACggIFGuMMTI5poaK1TNLToP+ktHaOX+ir8R4kMobu6f1DHX0ykyHwg5CjnmHk7Sklnyp9zQcPCjtK0CaCEFSu7NqLROMh/6LJ4NayqVWDqxMsjHK+tL84saA/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=peff.net smtp.mailfrom=alum.mit.edu; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=alum.mit.edu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntd1xaamRfLbB3JP/dQRRZjyDTidtM16eTgpolA5b3M=;
 b=fZBlgQ9OGeOzcmPVlppr12c+ssOy0jjLEmhx5SZaWH2xKy1EPfdmEgcX50Ut+QDexHkc0hHP1XrJcH4ZGrIpY9pibY1drHftAAfRU8r3Me6AwhAlGl1fVy5xoZLX5jH2dUKF4TfMOR/yynx6Npkm9iGOypXqxphJx3pHJNn2+Eg=
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Thu, 1 Aug 2024 03:44:12 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::2f) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Thu, 1 Aug 2024 03:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 03:44:11 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 4713i9Ia032601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 23:44:10 -0400
Date: Wed, 31 Jul 2024 23:44:08 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http: do not ignore proxy path
In-Reply-To: <xmqqle1hyzcu.fsf@gitster.g>
Message-ID: <9ffa9bf5-f799-400f-5e45-ccbc5316ee42@alum.mit.edu>
References: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com> <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com> <xmqqle1hyzcu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323584-1378583106-1722483850=:560477"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3e2dfa-04ba-47fe-63fe-08dcb1dc351c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|41320700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nY9mKbgCC0KjGUhJGnxthCitsKZt6S6crABbYGS0eE/l3pPdPhO1KLEGXWxr?=
 =?us-ascii?Q?cCyPyD46NZ9lu3aq2xdUPCb2Ewistdu+hImuX6DNywqLelUJeOZBj3FAvLIt?=
 =?us-ascii?Q?Q5nUD0nhY3pjF3XuxHnrpHWmU/RV08SEhWeRaJIhNwzg6UxFJKv+LGcenUQr?=
 =?us-ascii?Q?+xGIQrfTQaVcZQTbtRm5Cd1Tw9s2hRfFw8Kkpug5ek9sLooumKEBATn8CHV5?=
 =?us-ascii?Q?JsIomstHzOA82dHcDU0oE8URKJiHxIoOTCPfCZyqcz1A4PMBrRMEIeJCwh1K?=
 =?us-ascii?Q?X0T9ICnrn2wIcK5KfUPou43wYGHQfDyk2cdsc2D9gPoeoVbKtlonTWVLp391?=
 =?us-ascii?Q?JkvxNTQHJWuwSWWFJAvir041BJoRXSBG1LUI3NSTmihgZNflh3C4p1YXojQE?=
 =?us-ascii?Q?Nizetb1I6C26sacufVbPiLRdmZM64UCtpxOGPp58ODKmaa2nDol9idRi1QzF?=
 =?us-ascii?Q?7sTj9uMUunOUWGkiUTTZIuHw8qiovpsqCOrSXhW5qg+awG0stUHn4YS8aEe3?=
 =?us-ascii?Q?mNkvb4PvyfHEFymewAryryxXoVvqR/vOqAXIUwAhhfBv3ZjtdSoWr85TqM2j?=
 =?us-ascii?Q?NuAj0xPWgmu3ivbvru8Dx8rZRdBdlqr9mcCyuMT73E3HwG7LUVVX8Lp4mndl?=
 =?us-ascii?Q?Yhj50sgrpMga439QWTnLATcTh3EdlQ1/QstZJXacarqQXKaqgIu0qovqXk/X?=
 =?us-ascii?Q?bcDZ2b25qtp0k6LvBIcQw++vxIRceSbF4uAUq2pruUaYvmyZLRVSioY0mB99?=
 =?us-ascii?Q?P4YbxiheO72siOK4TJF5M1OR7elgkrGew617pSGVhnNbl1iNSpgpxxPeC1SX?=
 =?us-ascii?Q?md7u+9t4PAYEwEM+64ChjAJWnhHrKcJm/33DXP70um8+t39RB/uexi/+P2g5?=
 =?us-ascii?Q?Qx2AVKLAQ0zEmcY827A3QOiN2XPV5cld4ABjzOUkNhDVYZZEKQRuIYIKMMSK?=
 =?us-ascii?Q?4B/kbEf1ZOTY67UynepT8wlxCht7mJMbbAG1J/6o2G9q9WRZuc0Ic9cHOGyN?=
 =?us-ascii?Q?QVV2ZSDkIkBVX5QbK1lUsqqZL6ZTpY9YdpjMiYPM++x9GGu73iQizesn18+I?=
 =?us-ascii?Q?8PIBMPAi+HcWuK5WHiv5SNrrSJo1P8pAiQx8a1wDJY0qn3I2D4GzbUSZVetK?=
 =?us-ascii?Q?qxQ04aFdtXHHXkqx0WFphLRi0KDBetz9uGfO9oBRK4m/wu0DYavvn+yhuWgU?=
 =?us-ascii?Q?NDa1Vp6ARimd4zqftIZF96s7BV/OR2jSRwVm0dsmu9VDwZS59s9tHzCbR2sL?=
 =?us-ascii?Q?YOzZvmFbCLlcHjl8TQL9TkAtQ9Tb2VvpsX4mz80npKj8J5d++pZdUr7t+LaA?=
 =?us-ascii?Q?xROJidycmBnaubkrwlMXZnfP95uY51z3ujUk/fufnInWQqjEGheKhdb8bKe7?=
 =?us-ascii?Q?jLZ3nG0lgsnaVos1VtSTtleVOEu3t65BhDSUU6/aMPH28Sz+1he5Tdp0tRVv?=
 =?us-ascii?Q?orLBDrWbe+93mtxp+V0E6h+RFwmB763B?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(41320700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 03:44:11.8148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3e2dfa-04ba-47fe-63fe-08dcb1dc351c
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1378583106-1722483850=:560477
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

At 2024-07-31 15:24-0700, Junio C Hamano <gitster@pobox.com> sent:

> In a block with local variable decl, be more friendly to readers by
> having a blank line between the end of declarations and the first
> statement.

Will do.

> We insist that it must be "localhost", so let's not do strcasecmp()
> but just do strcmp().

I don't see the wisdom of being more restrictive than curl is in this 
respect. The documentation makes the claim that curl's syntax is what this 
option supports, and while that is not literally true due to how protocols 
are handled, I don't see a reason to intentionally deviate further.

I've tested that curl does the right thing with any casing of localhost, 
both on its own and via Git. Host names are generally case insensitive; 
the error message should be understood in that context. And if it is 
misunderstood, there's no negative impact on the user who writes 
"localhost" (while there is a negative impact on the user who quite 
reasonably expects "LOCALHOST" to work if we don't follow curl's lead).

> Making it a regular test_expect_success would mean GIT_SKIP_TEST
> mechansim can be used to skip it, which is probably not what you
> want.  Can't this be a more common test_lazy_prereq, perhaps like
>
> 	test_lazy_prereq SOCKS_PROXY '
> 		# useful comment about 30% here ...
> 		test_have_prereq PERL &&
> 		start_socks %30.sock
> 	'
>
> or something?

This existing test file is definitely not written with running individual 
tests in mind; the first test is a prerequisite for all that comes after, 
and the second test seems to be required for tests 3–5 as well.

But sure, I'll use that pattern if you like.

R
--8323584-1378583106-1722483850=:560477--
