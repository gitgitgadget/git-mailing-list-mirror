Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E26D1CD
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382149; cv=fail; b=SD+WcnPhnG4u/eFzTXlv/cFiACGWC9zM4eB1omvooPvGK7Y/dH0DeC898IaMgQ5j6i2PxBw6ltRG7u+LdCJbHHx/SwMkbBUnuKA5O9nJlBqL414xPvoTuFeU79eqYooIxI82Eb9+QF+vbAjBpDbCzPmLqJlvJWqlqvztEu2X21k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382149; c=relaxed/simple;
	bh=QwKp4UUWnxDOlybnPHTFuFEe342ABgPI6yGLTbI8lDw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lduuYsc/KrtlrcPD53hqx2kmGxJ+BQYccds1n/R5isHBrDVuli1tZHmIwxj9yzmLE8RoPbH20d/DDlz7bB31sMPaPiRaDrBl/zEGzaqXWMrTueXD6sFPqTp0XFzp6wdLBb6D9CzKvvpnGrz2psqhM29O30uURpNMnpv2iKeTSF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jfGzKAND; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OO4txyZm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfGzKAND";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OO4txyZm"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417Mb7FK024391;
	Thu, 8 Feb 2024 08:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GGu+nstEykFwlEp4IhvdSXQYjFg6tz7QEjEDlggZnBs=;
 b=jfGzKAND5CYcvgwp/w04FZF1XBLukNxZjLF74DVwIENeEaBH5eUAIKGr1Uhhya/u7pqW
 AB/EJcAjRqXQFgwWc2XXcGcLlULXMfb6l/A1eXOtwePGZLEqTH/Cz53eaBcVxeU4KuYR
 s/NRBJiqGMm0tCQKMvSj9A3GcpG+Baw+0+95AVhI3k5IGhNoHLnrF/9xsZhZ6PtQSuHF
 VEERWD7mbMQXAgKnQieCl0kIQHAH1tNC4vlsVEI8rr+C/EWyOs1F08KmdN+N8V/fRUrh
 VbSzQq5OEgXrpXH6lKl3kg4mJknomIhzcRNvKTqJmY64s0qr+HTQrmFRVKrkZOgcO80A lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdm4r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 08:48:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4187rZE4039462;
	Thu, 8 Feb 2024 08:48:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxa2f3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 08:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8MLBhv3gS9SoN0wwwyvwVlgExRfcN2V6QPjDxKO+eMsMGwI8H/g33uaNYOHxz0bOk5wU6TiZH+uuv7ERJ1BRvVkReXN4eETrepvT7A7hnXiAiwE98NP18Uz2UnzC4wqWEeQUDidiQZLXUT2yjBQG+67PZBv7rUDlyJbeJjcJFI8lLlizhEYzTAdUy3UqV64PqqYMrJOAqAmyt52laZwj0uuYbJ18m4XfizmA8ZUyxRdL9DIukqbeI0gyAVlO1S4HAL3lkeHG63kAwOoJQvuCybumvHxRJFJyaSC+3TgWgzpWp1CkVd8YIYs+F6SmPrz7Lc0xFz9zS0cFmcsFeEkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGu+nstEykFwlEp4IhvdSXQYjFg6tz7QEjEDlggZnBs=;
 b=DdC77ZC4Hmu8hFGHfWl9O0gb0rYBn7WlVpBuMxSdH+lOW8TcxSk4kWJZXofJJZNpAkHs8pVQdjTxypbh04nXmuUrcH/2JUnF2QA6d1KQgOgTl2mi4Kq3Ck4jLZRcg/TO3nz338VXcmkpMzkF/cU6h3noHK/MZ04iFO4d52CHbDRNSGeEF1jgNBfG1WBGoBsYQpctzQs6+YFhx6yEjU5lREI0/G2300HBg8ARyL/pvRQu0qQU3VeYrfVC+mWa/RiDteNXHPf8DyY/7H8pVcaCGYNgLmlhW1vEdeSe02kgBgzFJCtrGmuif5GOWRzmPSMVShWHMe819HgH7TMUigNhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGu+nstEykFwlEp4IhvdSXQYjFg6tz7QEjEDlggZnBs=;
 b=OO4txyZmnc0n4g9ytja7/3zN+6bDv+eUMxIyYbXWd/fYJ2ZGSzSD0IbxMI1fNlFnXk8jb7Qzx4Bq8/qE2MuqErOLBrMBjr7q2lRw0DPeZsM9rAK/1yG0Mc8cTsFRHTz8/Ot1UJYEOnztq3Y6xE9sQjTb8BgyHc62ljE9z+PyF+w=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 08:48:56 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33%4]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 08:48:56 +0000
Message-ID: <ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
Date: Thu, 8 Feb 2024 09:48:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
 <20240205141335.762947-1-vegard.nossum@oracle.com>
 <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
 <xmqqy1bymru0.fsf@gitster.g>
 <b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
 <xmqqcytal01i.fsf@gitster.g> <4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
 <xmqq8r3wcjq2.fsf@gitster.g>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <xmqq8r3wcjq2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0218.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH2PR10MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d158d4b-98a8-48e0-52f8-08dc2882c918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HV9KjojDxmCkC+9hJXMoR8eJ4sukum2Ce7kN+cL9nBca3H+O23oEjIbUeRwKlpN0gVQzdsC//pXHx8O0Mz/9rv1akJc2usZqzef5h9JLz6RcA4CyAflUYcI9njhXGo0rhcp68oB5SJM3SiANcaa6N+tRhfjf+JLLMlc/uTGgAi7nhJ6QOch7VCWiA8BLKApjUu+q4dmH3fzSCQCHuZeIxu07lSXsioAUPNOM3v29hCDCVQVOBEXQEDU1GyiFBR5PeYgNcJ2ai3myi6ZuVchQMpH1xXs74KDDYw0NhsNYe2+IvnKySqBoRAGxZqYeZfIWLIaZQQh/ZSeIATP2jfAdURJXlTehgGSz2EXe32oDIKCRuZfwaaN/23QJzyFx+8NDqZHMy23ZpavOpCI3yOdVKcA5WjfTipbwpZURNHE8LnCT3fCQ3jw4RCdWZkw4v4gzit/XuhFroN3VZWnqZRGQXV+PhyiFIjnnNa9plpNJDQEZU4lo55IkC12zPQOfGekoCxC6DAY0OJUEvanQpSpsdALKA1R5DnVAnjuFOrWhuzSCEtCx1KZMZuM49nVjqPrK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(38100700002)(2906002)(44832011)(5660300002)(6666004)(53546011)(478600001)(6506007)(26005)(2616005)(6486002)(6512007)(4326008)(316002)(8936002)(8676002)(66476007)(54906003)(110136005)(66556008)(66946007)(31696002)(86362001)(36756003)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDgzS1dRZE1WTU50UjA4UHY4U0FlSnVPNFV0R1BSdHRpZ2IvZndaWGZvamxJ?=
 =?utf-8?B?RFlBWE1MK1lnOEVqcVlmeWVyR2pOVHNZQlNSdjRqY3pSM3BWUms4NkdQSDV2?=
 =?utf-8?B?ZXBsYWJtQzJJaHJJamVqVUJ5SW9DclpxUWVybGh4QWRWWHFwTXVQdnpRbW9m?=
 =?utf-8?B?TTM3RW00YnFmSjhNaWxoNDBSVkl5Wi9LTG8xTWtibW4wSExIc0ZSanM4TFBN?=
 =?utf-8?B?SThoKzJ2TFl2TE9NWWc0S1NwcEdsaGJPREM2RGM1b1JqTnpja005WC9vTlFo?=
 =?utf-8?B?Tlpjd2x3M3FNd1MramF5ZXd0cVVydlhZMzZldHd0ZngvTitza3poK095N1BJ?=
 =?utf-8?B?MTRhV1hyWUNLcEM0ZTl0cFVSYktqZlZaa0NXcEo1L0ExQlUyaUpxYnpEVVo3?=
 =?utf-8?B?ejBIUDBGWmQ3OTVnblpoTFFJcFhhK0NtTUcxUG9VZ1NEZ2VsWmNBUzYwNVds?=
 =?utf-8?B?NFZ5RFk1ZTBqN1JGSmtxTEJ1M3A0T0V5Mk9FcUlENkJJbGxTbGlUdkJjckpC?=
 =?utf-8?B?YmdyaGVmcldPalYyY0ZpR2IxVGxFY1BhOVJ6WWdoazlLRGJlVjU1eVlXMWlV?=
 =?utf-8?B?S09UQkpyOFlPSzBIWUw0VzA1S2U1Z3BDb2dXTWFqNndZUXNIWlEra0txM1FZ?=
 =?utf-8?B?N05LaG9xM0ZTamZoQVlMVXU3ZW1vYVR5S291VmxyYVpxQVpPRmdTdG8zTHpi?=
 =?utf-8?B?Vy9tdFVSVVR3Z2I0WmdwNVpMY1Myb1BTWXIyc1pNMUI1OWE1cG1PSTdpbW54?=
 =?utf-8?B?cXYwbGU2dTBzeTVYbXRuMnUrWFR0Q3FIbXU5YmY5aGh2RjNtWUtybFNqTDEz?=
 =?utf-8?B?MGRwVXRJclpwRHF3cTl6RkMvUmR5VG1aWTgrcWlwLzYzT0s4dW9OQjNCalVv?=
 =?utf-8?B?VEpCZHJLQS8xTC9Pb0pzenR2Z2dkQXZ0cytGdUhXZ3EzRDVpMWJkbGhTVmxa?=
 =?utf-8?B?b1U5Q0tQUjVTOUlkZ3ZjK0tISGg4SFNFT1V2VXJ1ZC9zVmdOTEJrOWlycERP?=
 =?utf-8?B?UGQzaHFXYU1FMTVqYnBNbkZMZVd1TUtDQTN0KytIaUx0TmYwbysxWUYraHpp?=
 =?utf-8?B?dUJsaHVlaHlUbEYyeVBPdXB6d3NoVTVpcTQzeENlM3JBakVwSENEVFJwTUxq?=
 =?utf-8?B?S0N1TVRsdGNXT0sxTm5IYTFsSUsvVEt1WGpzb1VtNCttYVE2c29HYm42YTk0?=
 =?utf-8?B?NUM4WkJTSTJQc0UrYWp6Y0NoNkd0U3F1OU5obWMvUXRmOTkrTElka3ZMNklt?=
 =?utf-8?B?SE43NmdYcytXUEtPT0Zha1BZRmNOdFVTT1Y0ZTdJd04wczBvODBBam9PYzQ1?=
 =?utf-8?B?SysyWWZTVWd4S1pkd2ZiWG1HUkJSTzJRRnE4T2JUODFuMjZwaFdaOWlhdGZZ?=
 =?utf-8?B?MGVBWXQ2ckRlejh0KzREbGlQWHFVOTB6aXFmcHBDRFFSTEtYR1M0T1ZRcEJ0?=
 =?utf-8?B?bDN6Rm5PMzV1cWpwejBaV3NDUjQrR2VHcWhyN09jNHJsWTV0Wis5ZDkxckN3?=
 =?utf-8?B?VW9wWW04eXdrYVQycUhVSDFrQk5WYzNnalhQUmJqZHNydEUxTi82MTRHNlRk?=
 =?utf-8?B?M0ZpZEpOYjJsa0FyQW5mOXVNeU5NN253ZXFtanBiZ0VHOTlnL2dYalFITi9N?=
 =?utf-8?B?aTMwUzZMRHJ4dnRvdWNMamdSSW1ZRkZ2TTdBN051YVErZDZzSitOTE5IeXND?=
 =?utf-8?B?WktZYW8yK0tsMEZqOWFCTExIOFY5YjU3bEVmWXNBRHpHUktVekVGMDNURXAy?=
 =?utf-8?B?QjdUVzhadnJheFJGVEN1aEVjamFqNE9mY1JEUmdZQndwekU1Z3pNWmthYWly?=
 =?utf-8?B?Ny9BeHRtMm5RWFRNcENuK3hmNHk0TFJUQm9pSXNQeThWaGt2YkVpTzRyZkZN?=
 =?utf-8?B?NEtPVEFuNDZ1QytmaWNZTGMyRXd0eUcrQ1hZMlBuc1BTOWdQbHNMYnRQMUZZ?=
 =?utf-8?B?SWl6cWl5cnpzbGl6ZkRTdUV2QUpRdTdxUzd1N2lxdlJpMWpVSHNjdzNodkxj?=
 =?utf-8?B?OE5hV3lMWFdwZVJFTVRFYmdmV1V0VGFXVWFkZ3FrRVIzWjFUdE5laVR3Qzlr?=
 =?utf-8?B?N3N1TEJCS3l6MlIwOGZobk9VYUM1RmUrdTdzc1R3cFE0Y3Frblg1SXVOcFdD?=
 =?utf-8?B?Y0oyT0UyQlpuOGd5SXcwY1JOSU50L0RzZ3M2OFFzLzBtNEl0M0FpbWJzaS8x?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pv/LYtFatC3QrPWxwngtiAQG7epMoNnYvE7Am+7QhtsQU/jLcsDvt411IOKYu3tmuIvBhdxSJ+s4wG8wKDfc9A3TGD2dqkMuCZQvNZebnSGsISUAeUzoibA9RTz4PTmIdS3X+ZFmGDk/enY4FbOEwtta8bAHEaM1a0bwLspEEoSUMu7jGwDUSkULg7Oh6hVkTlzEOCiU/SoQ70X+rDTeNflzhU3k+wAaoXjGusX9DwVbmm9hNYColrlagNzjc8PdOObAfAqABTfQzI3h9FBhLIYbrU8T8E3fGVn8dahSFTP8JJojcGTNSKTaMSUGnxCSs0HAIaBbTEwZ/tfG1EzYAauPNY9L4+dp3uvy6UGhGoyXWvIx2KEu0a2Sds/k0x6rfuLAkeS9bEt3o3irzLVahwRImchYk+TaPMO6uECKloipPsiyku3dog2l+TsNrF5MZfGv89uxDj1oreBhqu05eei4PQGxY0K/9SNqHIbpqnFc9Jpb8IcfFn3R17aLzey1voiPZwn/sEN3wHYYUn6qjBGiETvB5dcVU2YOGIh+Whq57b7AnJlnHrS4zoRjNTgUby6RV4aw3x+79VmuURFy2hUvrpmurb0DxWPYXchINmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d158d4b-98a8-48e0-52f8-08dc2882c918
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:48:56.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lz5/urm1YmodEqywGfSRZe24FGS77wYNyg+Loj6PUxkpt2Cri5GGR8zFmEzkK/IDUtcM9zUWhy3B1o1T7kzZZ1e9o0HUjSrbZNM2XnOjGNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080046
X-Proofpoint-GUID: zX7q_2s0ACklo4kapDBcuC5C2JBYdPZ_
X-Proofpoint-ORIG-GUID: zX7q_2s0ACklo4kapDBcuC5C2JBYdPZ_


On 07/02/2024 17:39, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 06/02/2024 03:54, Junio C Hamano wrote:
>>> Vegard Nossum <vegard.nossum@oracle.com> writes:
>>>
>>>> On 06/02/2024 00:09, Junio C Hamano wrote:
>>> Perhaps it is a good idea to squash them together as a single bugfix
>>> patch?
>>
>> I think so, I'm not sure we want to add a new test file just for this
>> either. Having the test in a separate file was handy for debugging but
>> I think something like the diff below would suffice though I wouldn't
>> object to checking the author of the cherry-picked commit
> 
> Very true (I didn't even notice that the original "bug report
> disguised as a test addition" was inventing a totally new file).

I'm sorry, but I'm confused about what I'm supposed to do now.

There is now another test case and it sounds like you would prefer that
one over mine, but I didn't write it and there is no SOB, so I cannot
submit that with the fix if I were to "squash them together".

I am not a regular contributor so I don't have a good grasp on things
like why you don't want a new test file for this, or why you (as the
maintainer) can't just squash the patches yourself if that's what you
prefer.

Thanks,


Vegard
