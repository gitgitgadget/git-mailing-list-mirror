Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5645E136331
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621795; cv=fail; b=JdycIQ2komH07MudRcloM4bzDjn2ySuewxDz1rXvI2AKSt3H4t/h7v3lSQdpL6z3bE5BnR3voaNVdaEeDiUV/5JayEN09UXpmaqBb1Vpn0BYaAxD6k+pyhsCT1kKZulFYRgNLv39fN2vkKej+++kxOzLqEPNsqkg+nlifBcwyO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621795; c=relaxed/simple;
	bh=pM2Q8XKF6GcbTZocvOdkgPhONXEPPPLC1YiiXisgrBw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D6EbpR1B/xio+660yqX3nMTgCDEtWw9LjOPbpdKhNFemG1N8y8ONwjZ3W+KVKfyRVW1HnvMNUxs70I7mTT8Fz87KPM1fPCl9uzC2Rj4nmnJ4LJYe35NfaEmup3KTDiN2qA023sRCmWnL2Kiz/UqjmsNlB4D/D/qkZ1oEG/06tmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=LiDp3SJw; arc=fail smtp.client-ip=40.107.93.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="LiDp3SJw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avsTdWebwPL7d0HkoiuZCJbE87n4BC24V85zpKW9TfLoeUCc4Pvva3suMSCtRqKeLw1amWoJfOisjHINsiKrGC0Y8kSmOBE5HhKP/uP6EI8GNWtp3EQvxZUPq0rIzg2NhR9ZONqanAreyYrQUHZ5Lk0JxDxu8w7DxRU3Ej76rrExBB+9rtq5S75na3b9/ac+m6tJ9iBPOUSqDS8mW0kbE79rgg7K7rQUC0yy4CyqpsYrZQVIvnKcadumO19rtyUAoTaRWjpLtPxoe0xKmZR10wfaJzFN4egryTFWesPmUha6ZGWT7GtSMnIAENcLXFL3YJbE0CudfyuNN4Q7QZIl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L2tEYBrChe9dQWoXoz37ytTw6zfHh387u2ZBYASxEA=;
 b=kLKTeXIdvc8Gv9+uYlRI8LP2Z/+9VqnfdVjYrI3emEPcHruXd4NAyY/sD+dkfuw3DmaF6ezyn4y04bBUhyFPO93/+RpfnpJlAkPjc5twh2aHxje5nkJTdIxWW8wL2WIQBLeRYwVlsZolCuWDVJmZC7gEYf10imeCRko3kC7VN9xYjjits8ioVk0Ta8fOLOsCKiZqYVTNr0pk/YAZxubNeps0N0NCG3SpN3slx3CibTATheZZx32H0jhmYs/wbYDkYk/K5s/LwUp9HEY4HokxMR1r4MmjqVNfxOIgTjTEXn3dWbrK2frlPpIxFbYONdFK4BGwHahcyNIPpOO2frY/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=peff.net smtp.mailfrom=alum.mit.edu; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=alum.mit.edu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L2tEYBrChe9dQWoXoz37ytTw6zfHh387u2ZBYASxEA=;
 b=LiDp3SJwBAg8JehTh4Js+X+ycIeGB97EMPZ9ygIAFE/ovtx7htPK7R6F9h88d7H5ea+FXoBIw7G7DjRA5eNDuKdczpGJ9rs0SsqpmVkQqDg3TAJrZ6npGwQSpJ9rvH0rlHyqvwhbuhI45Wy8l4V+pAnGw36ZfhJo7WnNnp4Rl5k=
Received: from SA9PR10CA0018.namprd10.prod.outlook.com (2603:10b6:806:a7::23)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 18:03:11 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::bd) by SA9PR10CA0018.outlook.office365.com
 (2603:10b6:806:a7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 18:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 18:03:10 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 472I382n030626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 14:03:09 -0400
Date: Fri, 2 Aug 2024 14:03:08 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <xmqqv80idf52.fsf@gitster.g>
Message-ID: <a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu>
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com> <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com> <xmqq7ccygbx6.fsf@gitster.g> <2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu> <xmqqv80idf52.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f480a7e-0a41-4d9e-079b-08dcb31d5efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|41320700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kCUCf7JSUHizdNUGrBOCCuyaXWCtZDeUabpZmcmAqSJkMyRnyKZg92xP4tcB?=
 =?us-ascii?Q?4saEoCTd/qUDZUmjOkhknkrV38b1xo8JNmvXCvgV7rUyj9oueLtxb6t+UB6V?=
 =?us-ascii?Q?emARYhtjTNy0DK6OYHqF63TED8m0g5ArEThOcO2j22QGyOQK4QuLyWvBL6xO?=
 =?us-ascii?Q?twZdscA+HE8dDKtB6fwGNFV0HNp9+YYE4VjxMAV0jPtclD6mVgCRTihnA/R7?=
 =?us-ascii?Q?Tmj3xohAI95TAPf067eAWJ7uJ7Te6vb2BLZK0CvPultx9Jzjt5zFM4a4pvmE?=
 =?us-ascii?Q?OeQEGtL7MinjysVC1HmKbBGS9FWJXvyatGcgTuziUNUGQLRJbO4kvy9kemuw?=
 =?us-ascii?Q?koyz5IdWxQLpkORqhF58ehMZIIJXNciGqLlp8bTbkfBtOs21JQtCXQtIBJys?=
 =?us-ascii?Q?yjqWcsWoopNZ/RcA4GYaIr1/k+equYnEtP6Q8ryuzNPbGpJjWZ/JK9fKPMql?=
 =?us-ascii?Q?Q2y7mV33gDdWsttz5yTmGpHntfj/kDvwAmS6vqSfKfm/G4uSoTel+vPXQsCo?=
 =?us-ascii?Q?iTN2XsASu2NFftsqL4gNeGKEmEZZkd50neDzQb8eTiKpfd4ihTRKxdNcIdNq?=
 =?us-ascii?Q?JGidDxOrsepTYNL9iIakBYbxAfD1CTEyBfT7zl5xQKyz0lHxMSuz9JMYHI+c?=
 =?us-ascii?Q?aj5GVlgooFol+RwY7i+0GwITPvNF1q0lP23EVAOAU4fmZk5d/MhQvas+ARLq?=
 =?us-ascii?Q?gijEAKLaIzvFjtSdDsEAEUytzvPpRCU5gW2F0ck3KTCY4u/E0x081J9FsKBQ?=
 =?us-ascii?Q?ARBhRvBn6sOK5G9MHGd50f3AbyeYscDutJNDTwOrRtY5eLl4cLuzpHidGEPG?=
 =?us-ascii?Q?Xv8g9xqM3B0t3eDnLUW3FZjiBnfznvxklY4lrQz+NkuOo84XIiiO5bbMgkVQ?=
 =?us-ascii?Q?HI8xA8fNU67TicbPik6GRKWllrK8boPB9eYIms9oJrmDwDUWongPHNekGUac?=
 =?us-ascii?Q?KpHYoLY8r9Kh6WHF8JUE7W4d9itDPsNezYKowqiChH8nV8w2oSGWTvmJX6j7?=
 =?us-ascii?Q?LV6sMR/HOgTodwn44hpwgffWU+AJ4WmdQmhuxUY0aehxkDK9qV8aA5n2/Dct?=
 =?us-ascii?Q?M94vrmEU4Cv2rPjxUFt1DLhijhgeNPOotdgB/KOdnlONTVqaXbqjWXSXixrk?=
 =?us-ascii?Q?aySjb+3/DjqzKZPGacFJheiJRGyI+OkMTJc9BoA3UMrblhQ4uBou7ShxVzqK?=
 =?us-ascii?Q?2MRiEyj8fmW/kpZ9mSJ6KyiBk6KND7vlMlsF3n5ecTU6rubeCGfzv130Yrh9?=
 =?us-ascii?Q?dRwazaazpjwJOUg62QQXw1PLmNp37caE6KdNWDilQ5a2mDsG1F+GsGvcNfAe?=
 =?us-ascii?Q?+aHT5LjuiKlHYerZhke8UqkNC9VDonwp28KXeTPMo6g0lo8+DcolxMT7Gfpg?=
 =?us-ascii?Q?vfZzgdnKY8SuIfoteqhZCzJ8ReCc65okrOiARWCnroPbmS9cjNIc21U3qmR5?=
 =?us-ascii?Q?PENgZH63mKkW6/UDSttVlNIhJtBNRG0Me7kjWsF7I64s4+lr9Susmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(41320700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 18:03:10.5263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f480a7e-0a41-4d9e-079b-08dcb31d5efb
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

At 2024-08-02 10:10-0700, Junio C Hamano <gitster@pobox.com> sent:

> Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:
>
>> Hmm. I'd be inclined to take the preliminary clean-up approach, but
>> some of the existing strings (there are also two "Unsupported
>> ..."/"Supported ..." strings near the "Could not set..."s) are going
>> through gettext, and I'm reluctant to interfere with the l10n process.
>
> I do not see what you mean by interfering with the localization.
>
> If we are updating text to be translated anyway, giving translators
> the strings that need to be translated _earlier_ rather than later
> would be more helpful to them, no?

Probably true, but as a new contributor I don't know whether changing 
msgids means more people need to review the patch, more files need to be 
changed, a translation team needs to be notified, the change needs to be 
pushed a different branch... whatever your process is. Localized strings 
are generally more of a headache for drive-by contributors, in my 
experience across different projects.

>> Is this blocking feedback? This strikes me as speculative
>> over-engineering
>
> No, it is loosening a pattern that is overly tight and as a side
> effect shortening the line to more readable length ;-).

Blocking or not?

R
