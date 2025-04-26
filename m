Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7325D91A
	for <git@vger.kernel.org>; Sat, 26 Apr 2025 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745689236; cv=fail; b=pZkPPmaZOQI2x1qjrxZvyj/yjHUkn8Dl6wF3st65uyI3DOySgGKn7jR1w6+4dKKQSE8lnYq4t1m/h9K/U0tIbIkbbxkbtAmHUTiA1/5ir848ZVQGe47N5arIxjnSQHmX/n3ZKLyP+ICEmZJBMXKE7E53KW130hW8uhmIQ9eVwF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745689236; c=relaxed/simple;
	bh=kTz2W0k17xqIjalgJBh9+oqyNG+QoX8uLJmO4PKYJ1w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOCh3ZoTMAmvPnJxv4zsFvSSSaJTvJGGBSlIhZaQP/yUepjAPtKM9c+cdmaXxixDxiUSMxCVN9Oa+4/klPSY7jxTDxDNupHnZlTDQ2oRV4yzfe5Je14hMFK+MTtmLMAY/SguHuTnHnUx8S9EMSMzjRY2CXHYBZ0wj6piKRNi5Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=nOYgKccI; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="nOYgKccI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIBhABy/YoH1oeFt6XxZ/l870tfEISozElhsGH8qRCD6YBuj0vCgp/9WBk0yEMNdiHTOa8ePPmjW0z18EKYPa6jI3f+9OPUVQ/xzqeKTr4gx3YB7nzJqG1Mf7DwA2PuV6LOSSZdYFfCAWkmz9kcixcbRUWdhkesU74MR73vUCxTAk0yfhgYRIR455cuONn4giTCtCNpWHiCJcBcoEJ/doFYnZ0VfGHeox0v54PdO1ueWp+e1gqFN9i4p5guas4EMzYWvWFReGULMOGPYnfQCKE2UmQn3FByxiM1tVeJc/Rb3e4jvOxr77JjJp/5qXVwCT+dm/iBNhDPnY4sp5jCIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CJpNUKtv8rN0pG4uMmutfbklwV943K/7WjJNdj21gE=;
 b=ahwy387rJ/aVlHnut08F8Vv2vwYgufG/yJHIFfhDIkptOnvuI6+m1rU7LX98e9VtZ0g6IkAmRLF3CRhxPD8b6hXhXOEyX6ZX/fcfl5v9Ll+lAm9uCO9ZOU8Iw8G5BClT1M5aT0IhjWSlrDK7I2nveIFwv5q/uKZolDFT24oMajzZPWmH+C4gTWOybOpnNdnNFrmG4nw1wpc3baQLHu3F3DwdDy9kLBbxBEQKgtP42xFvFwbuA0x4wLRxPeVqnyBnriJlrkyNaLNK6HnqIPGy4mbWQGlkrU1uHzukpu49CtM6nvqgU9c9Fi4veIXJ8TEAlyyBPd+RESP6jB48yJTnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CJpNUKtv8rN0pG4uMmutfbklwV943K/7WjJNdj21gE=;
 b=nOYgKccICKt+cn5QNEpdU8a5ZpvstXCkc6dftQ6QhhNkzv3LFrGX8W6yg2a9cDOTn6DGGkcD8cO6/dvfF98D4UySunck9i+phDfVx/9zHimI4DC2TE4D7PcRlejVimCuLdElPW4FsX7f3rjESbVv5AtMKQ1rKTKqGkpctYxKaGrE5KKi1u5+GeaaaJc7FaM1nOWpDE8gJ87M6AyH9KFDWvWyDiM+VcPv0qBDHvyJguhad7rNFgYaRTPuRnXpo0BI4R6sEZYf69cIA6yiBQ2i2he7Ts5WBXxYdv1xnTb09i44YegbvT4pBA2yXxgQDN4s7ELtX8mbrvFAb/fm89d6sA==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MAZPR01MB6354.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 17:40:28 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%6]) with mapi id 15.20.8678.028; Sat, 26 Apr 2025
 17:40:28 +0000
Message-ID:
 <PN0PR01MB9588AB9FF8A93F3DECAD496BB8872@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 26 Apr 2025 23:10:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP
 server
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikmstatc.fsf@gitster.g>
 <PN3PR01MB95973B932F4961FFFA9786CBB8872@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cQAbF7iOGtyoVe921sJARaR46sWqdROZQWdb9mOQy579w@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cQAbF7iOGtyoVe921sJARaR46sWqdROZQWdb9mOQy579w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::8) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <947fbf62-9180-47d2-8d38-72478b3d4ecd@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|MAZPR01MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 069a2f30-610a-4bc8-2730-08dd84e96f1f
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayFXX0mVJp9wZC4LLIW1QoQ+eBKmPVkEXbfTsjHqeGgOyeXU21uTZ5owTQM/PeIi8vHknHVgcihLI6VqvTEQpUeqVyETp7k7lSfFQ72Y5xB5Iq0WgYGA3q89PRvAvqOV3pDqF26AMokWYoDfQ0szTj0xlUsp0gVzcrYgcUsz0he+q3f9T/V6RgVM+C8TfZd5Y0AAxFwFQ+JzdkSoCOAYABdExYJWSWBGaxuE8a4V4wsfbDGMyCfWbGGpFIPblGBWAC36nIeVvuYFBbjp/SrRMRjqMDdq7xBBAh2QEZugP27E8Vpt8lEPCyOdTjc9BOAodOui6rZUb48qwIp1SCGHfpHt8o1kNzCOUNikzooKzTDpl9Cc78pXwwCFEDrl5kvq47wLpp/sluDPNqIrVj/jj9t/yFGU64nmPOifxY8bqdi5V6r+tmDYMWiwbxWP7/LINEF6KfE9xpraENKApyoKinYd6BEuyVKIL8Ym6BbMo04BAYIwFBBlmb2Hs8aeDjYbnQSHfpwADRzPomnmvn6AThsWgSDY2/X2SrUrOdzDPTxjs2/wmCFBNQeVaSKoxSN+T1R3XTYKKbUSvgrJz+pHNcscbzilpH+DdGs/2+Zhv7heSMeCMDGDGpLKp9+hWDNNokfXEtprkR3HbB/1O3aTQ27cuSH5OH7zVIgR6FqegsV1DR3S+5xNjYeScgPKDalyQQh5y+1ZJ9K8HqWd9tc5AxEjbZivaijOy9o=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|15080799006|7092599003|461199028|8060799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3BWSWdwdUdIbEEwOXpsTzd3Y2twRVdlTkZJSE4wWUs2Smlqc3FXdkt4V2V1?=
 =?utf-8?B?ckl2VXIzQnVjR1ZLalBIQWY4QzIrY0ZTQUtuWjBNVTVZMithSXUvSXBydnVT?=
 =?utf-8?B?bzQyNldDcTFpY0J5NXU4N2FGVUkvWnoxT3hMamU0NzhGTGR4K2VIWVpxZ0lO?=
 =?utf-8?B?emtmcVJOSU1xUzhNdlplUWVVOTJzaCt1VlI0NGMrbmtyd1k3UFo5WWp2ekRt?=
 =?utf-8?B?eEpJaWk2TE14cDM5TVE1MnVnYzZKdFhXd1ZoT3R2c28yTEFzME9PY3lLZEVF?=
 =?utf-8?B?UGtmdE9IOXUvaDZ5MGlWbmlzWlVYK0hpM3BVNXJaWStBTDRNRXRtd21KYnNy?=
 =?utf-8?B?d1ZiWENLanoxS2JwbFhyRVRmZk0yUnhTYnJmUk1LcjFRVXhQVEduQnZTbXdY?=
 =?utf-8?B?ODFYY2EzTXZXc0JLNk1FOWN6Y0lFSFUxRWJzSWlJS0JHd3BPRnNISWtHVlpE?=
 =?utf-8?B?NUpINzgyZERtN05nYVFaMzFFcjhFS0E1a0NET2prOGNKWWJ6NDdhejd5ZWpk?=
 =?utf-8?B?Sm9FUTFtRzltTFZpNWFZRVBTdE93UlZnRjBxVzgxMTcwdjJKZys4TENlSFgv?=
 =?utf-8?B?QXVQcUlQbGJJbWdISm1BTmtvTG9yOURIdGUyUkJLd2pWbnBXczc5Z0xuM3hI?=
 =?utf-8?B?ODh0MEpwN0gzc3dNOW94bFZKTGFJNG5uSW5oTjZxOW9iZ0ZIMDh5UXBWcXJO?=
 =?utf-8?B?c1hUcUV1Ri9XeHA2M3MzWkFJdHpVampoSnVMbE41UGpma2lncXJKWnU3UTFF?=
 =?utf-8?B?WkdHaWJONXgwaFl5ejJWdS9qY2FONTQwMmlkSVRyOE53eWk3RHdGNTBDdmg1?=
 =?utf-8?B?dmp5VEVHN3BoWHV6dTFwaVFuVUV2YVpBYkljK2pjS25xQTFleHQreVRCTjB2?=
 =?utf-8?B?VGZweXFCanJXd0Z1Qk0vY1AvTlhhYUFKcUw2K2E3dnRNV2syRlM0VTU2YTVD?=
 =?utf-8?B?YTRuTFB3TW5ueSsrTktaWm40Qys4MGNUNnRSQ2xYK1J3WFVFTjFhdkt3cnZW?=
 =?utf-8?B?eWlvR1h1WlJ0Y2kxMzdHRXNBZ214TEM4OHdCYmczRlBoOWt2d0dBZlh1K1lk?=
 =?utf-8?B?RFVuZ0swVGlDQVZIWTEzM2k1YTRadzZNY2xZSGI1M3dhU0ZHMTdLaW9Od3Nj?=
 =?utf-8?B?azhRRlFxTXFPQ2lORFpEb2xxcGhiZTFCNFNMZHRaYVlKUEZoUWhuS2tXWWRm?=
 =?utf-8?B?R0Q4Vkk4OXI2OTQ4U3pCOGhWVEl6bU1oSm5CSVBBdnlkUURyUlJQbXBjcVRU?=
 =?utf-8?B?dnVvd1dZUGcwQlloUEc0MEVqemtVUzltazBuazhwekFlOUxhdFhyYVRrNzlK?=
 =?utf-8?B?YTIwMFRQVmc4UG1NSWRtbFlqTDFMYkg3UmljU3VnajdydXBHeE9CVisvTFhN?=
 =?utf-8?B?M3NiRjMyL2ZTYm52ZWxsZFBsbXdubURuVjlCMGVGRkxKeFVPNlI5ZXl0bWkx?=
 =?utf-8?B?dzVnM1FpTHJ4a210VTY2angzVE1CWEQ4SDQzYWV3eWgzZ1JkeDJKWjA1TWNV?=
 =?utf-8?B?N1VPS2sraWh3WkhnSExPRmFicGwyTUNlWHZEYk9zR01HOEVuZzFxUEdXOGR1?=
 =?utf-8?B?d3lydz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTk0djNlWFZqcjVHYllRY1dEVkVILy8xTVhBa2RvalNVUUdoaG9mVWtSWW1X?=
 =?utf-8?B?VEx3NEphQkN6QXVnT1VmMDRtZWVpK0xTUGlpNm9Kc3dPVE4rVDF3VUdEOXBR?=
 =?utf-8?B?YldjS21mVFZRbmhtZmFJcS9hdHN5ZmUyTHJQTFNadnE3UlVvT1ZTTHM0Y3dZ?=
 =?utf-8?B?N0xFeGdlakNyOU1RaFBPaGVySkYwWlVyU1FLdVZPb3JkWVRDSmpqMEVrRW5z?=
 =?utf-8?B?VHpkNnF2MWhaRTdHZVdaZ2hNRmJlM2F5bVhIR3pqcDR3cWJkTlpLS28yTHN1?=
 =?utf-8?B?MzdBZXNUZHF1YkEvMUZ4RzhMNGEwYVdLd0JTazF5RjZ6dHhPNUYwaW9RVU5D?=
 =?utf-8?B?STlSdnpuU1VXc2hpbW5qbDdjRWRhUEovblgyai9wa24vZDRMLzd0a3FFeXBp?=
 =?utf-8?B?U0dFUUtiSnhLdWxhWjdaWU1MdDMrRUwrZldLTVkvNHpNVnliOVRkb21pL2xM?=
 =?utf-8?B?dVRGUHpUQUg2SUpaaXk0UUJpMTZyODR5clpnUnh2UE8wRXAwWGMzU2tpTXFI?=
 =?utf-8?B?QWpsOWx3VzBMQ2VZc0hyNzNZSUtJbzNrM2YvU1crZFFJdml0ZzY4TElvZUFs?=
 =?utf-8?B?UjJ4b1lHbjc4TmJXdkdndWowY0JMVUVvTFlnVVhaNFpDcE0yQVZ3SnV1R3pw?=
 =?utf-8?B?UXp1STYxVFRuaTZ6L3ZZc2lyTnZiUWU5RnpxdTl5c1YxaHc5Zy9zaDVvaTJt?=
 =?utf-8?B?U21YWTNWZTRUS0xvV2tVdEVFUEc3ZWRiNDRUSG94RnRYMFpXMG9VMGtEbnBq?=
 =?utf-8?B?SDNWbjlvcnowRTNVSmFpNGZ0TFJmR2lBQ25FOWdXdmNhR2RDdHQ4bkVvTjZU?=
 =?utf-8?B?K25kSytubC9Xa3B1SVVEZUY2RW05VllQaXkvSFI0aTJENWhrTDNSQ01tNHZZ?=
 =?utf-8?B?eUhkbnI2SjBVK004TmtnQjNXQVAzVmZHUUwyQWZObGVlSFZGb2JGOCt2SUlQ?=
 =?utf-8?B?Z21memxRZGRxKy9SSHF3VXJlYVF3V1phelQ3RDR5V1ZLTFU1RjJmNVlQRjJF?=
 =?utf-8?B?KzJCdDBXbHJOQUFva08vL1VTdkZTcW4zREJlblM3V2pDLzNrSHhaVlhXT01s?=
 =?utf-8?B?T2VjVENLMUdVZjFmaHRXamkva3Y5K1BlUk9NQk9XT3Axaytsb0MvRTIxN2tY?=
 =?utf-8?B?TW1nRXhDdUZjNWl1TEd2c1JaZmRtOTd6WjdHWEltUW9ORmVFVlBTT2JPekgw?=
 =?utf-8?B?R0RqbUQ1VUIrakxnL1M1MmVqeWw3MjFvVFJENWx5NGtTSk5GYWJ5UWdib0dL?=
 =?utf-8?B?RGtna0VZMFUwTWROSU04MVVyRUdUY2pBekxrSHg2UlRDWEZDUEY1RDdhL1Q3?=
 =?utf-8?B?MWhQRktuUmJOSE9PRWVSTEJ3eFlRWkQ1dGYrMm1yUnJlb1dYcEsvdFA3VnU2?=
 =?utf-8?B?dHV0bjU1cDJwY0YxdEtpekYybkFhNDNWM0dnK1BUQTY0d3JSVGxoUVBzaCtm?=
 =?utf-8?B?NTlIR0plRDdXUTRkMW90RldQMTBlVnMzZldFS2piYy9uUG1KU28vNTIySXBO?=
 =?utf-8?B?bHh1SEh2MXRmQUh1MEVUWmdOd2ZDZ2UrVUxBQmViOS9BYlFSOGsxd3o3ZFZV?=
 =?utf-8?B?UG1sMUtmTHA3NlM5cDA4d29obThzN2hrTUFGZHE3N2g2WjZ6eFJBUFR5TUtj?=
 =?utf-8?B?N3ltY0Urc1RFVXREb2hCWGNxRFhDQXBFUkpac095VTNtblBhL1N3MVB3MERq?=
 =?utf-8?B?aDZhRDRZUFlSWW1STDZPNG1VcTRhNTdSL0N2NEhzRTQrcGhNc1diSWhTYWNN?=
 =?utf-8?Q?nRONISsbe6wAs6wmaVBIM1UTe8fIMIdkfrlj67P?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 069a2f30-610a-4bc8-2730-08dd84e96f1f
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:40:28.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6354

Hi Eric> On Sat, Apr 26, 2025 at 4:37 AM Aditya Garg <gargaditya08@live.com> wrote:
>> Add an option to allow users to specifically enable or disable
>> retrieving the Message-ID from the Outlook SMTP server. This can be
>> for other hosts mimicking the behaviour of Outlook, or for users who set
>> a custom domain to be a CNAME for the Outlook SMTP server.
>>
>> Co-authored-by: Aditya Garg <gargaditya08@live.com>
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
>> @@ -421,6 +421,21 @@ recipient's MUA.
>> +--[no-]smtp-outlook-id-tweak::
>> +       Outlook servers discard the Message-ID sent via email and assign a
>> +       new random Message-ID, thus breaking threads.
>> ++
>> +--
>> +- '--smtp-outlook-id-tweak' will attempt to retrieve the ID from the server
>> +  irrespective of the SMTP server being used. Use only if Microsoft is your
>> +  email provider.
>> +- '--no-smtp-outlook-id-tweak' will disable this tweak irrespective of the
>> +  SMTP server being used.
>> +--
>> ++
>> +If not sepcified, the default behaviour will be to enable the tweak only if the
>> +SMTP server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.
> 
> s/sepcified/specified/
> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> @@ -60,6 +60,8 @@ sub usage {
>>      --smtp-encryption       <str>  * tls or ssl; anything else disables.
>> +    --smtp-outlook-id-tweak <0|1>  * This server munges Message-ID. Retrive it from
>> +                                     the server and assign to \$message_id.
> 
> s/Retrive/Retrieve/
> 
> As this is a user-facing help message, it seems unusual and unhelpful
> for it to be talking about a variable ($message_id) which is internal
> to the script. I realize that there is a slight precedent in which the
> help for the --foo-cmd options talk about $patch_path, but those cases
> are semantically different. Thus, it probably would be better to drop
> mention of $message_id and just present a short and sweet explanation,
> such as:
> 
>     Retrieve Message-ID from the server.

Thanks for the review, I would wait for a go ahead so that I can submit it
officially as well, with your suggestions incorporated :)

