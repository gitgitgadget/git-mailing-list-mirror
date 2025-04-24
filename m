Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5A1B4227
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509607; cv=fail; b=k8keGmSKUI8UYm4+vU4j929wwgOJoqr3xL7nwDxivl8oOnJKkqwsA6EB0sU88uz6s/tIeZEZydGjzEz93H+aRL+lwRVrPYBRWemwfaC+/ke8EkCGbXFQ4jwoIOBQLvVMBedSMdLYPVIo0XdNKlK6vqD3/e7yF7P0EFi1nhXRmxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509607; c=relaxed/simple;
	bh=cjH5n48hsOSXdigbljtU3Xd6SKClE0wjqR4Wm48gXPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zp1wonW+aEewLJlsxTXk7ip6oRmX6UsAH+8VSd9pkWOD+M4gXpyZd9WllcyQ7ztPmo3S52fff20neiP2A6eP44OUnisOvQ+OxtwRlJ4jD+BHJjy1CvRdkhYG9gHCTDGGUvVzetLeT/8pkVhVgre7MuRcK/IbA3tNZm6hDdi9kdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IpSRUIgV; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IpSRUIgV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QULohAoaZzMWa1XIPDZdplyo3OUX0E5Pme3FUmaCosAFA4iIb2mUTUZXyLgA28jeL/8vlAyPFrfnVN13H5twnJX/zjw0LCgc06aTHPO010Zi2cc7yaPEdRNUwGBYFgzorRJfitojwdb2Dro40dthqhgItnBeF6M7MyO6HrwBRKhZ5lqFFnkdesj7nif2ywHMJCPPcDE0tdDeGsD0jpFuay4XVWLWQ6N1Re4LbfXdTU+YKal7SVs6Xyte2RA+heL4qZKu6x1ewjl91jD765uO3u0JO7ZVEe7aYKjsC1bC8DLaSSYSo9Nr2CqRmUmzwdZxZNeF2SfSfghzHAnNThEhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0s+kL9dPoW6gHF2xr/SkPJNiDM6Crl/dXlis0sK/3g=;
 b=tyqtXN5KnO+ktyPyo+oIXyO6BynbhOQWnFGDPJAdWKQ8mI7hRwMwj8c+V1AoK1KdxeCQlsAiPd+qpTOtYqRAx3h4XJVFBaFZOj4q9nRGsSE78KZasfAS+IwkKefCG3UsNh2p5SdRT6vgxyu7ZNBomFJJyiA36egZqevF9ch41RZKATau/nRd/jZCc1EG28yHF6WZhJRSEwwilkMjHasWOgFpunkQdOK8nciWCjd2uIqMl+nynso+TftzU8yFWwd8Fcoe8LaaJ7Zr8qrUM80lK7gD7hutMMyZDgmGlktMjxaazrc2pjacfg+XTnav2+6Xdc5O38EwTMMuI6XwIGqSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0s+kL9dPoW6gHF2xr/SkPJNiDM6Crl/dXlis0sK/3g=;
 b=IpSRUIgVITSyMM2rNPYfeTwRFUAw9+nw7tQgmYUg+/Z8SCsWcsKJt6MqBkqKgICIWmj86DzYTSfsUM+4V7FDb4S19LkyLqVS4FYNToLqWAN3ABZc+JsupBMPjNogV09zDI1EsDWqKBfz7BnDQcd8bNkggVppFv5A8TSs225iOTgrfOrLpkOm+a2YuPo6Ba3OenR/W7ZRZ223vWIQrZ3pB6OyXUwnd4fwAWtA4zkVPqZODeJu7HJPIY3HZ9N528SQvj965oIGGXS9j5l4kkDzonMZIVK6kCEfRMXeORfZRIf8ZNoBJeiHXWwMdGtFtOuqmNjRMVC1dRu2AIzKE19buQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF4FC989315.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::592) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 15:46:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Thu, 24 Apr 2025
 15:46:40 +0000
Message-ID:
 <PN3PR01MB95977780560CD8AE138ED644B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 21:16:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] send-email: add option to generate passswords like
 OAuth2 tokens
To: Junio C Hamano <gitster@pobox.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB958856EC9FB1E4F73A738746B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <D9EVAF38Q1KJ.24J34ET29VPTI@swagemakers.org>
 <PN3PR01MB9597932FB4B19DE2038AA26EB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqjz79vb6e.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqjz79vb6e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <a9474cc4-1b5d-4ce6-bc44-bc8a1bc0c858@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF4FC989315:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e4122c-f7c5-44c8-d0be-08dd8347344c
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFqEsjkffpKof8tREN/5Pxyr36DQBOcbVWwaM9Ka8oh3ShPjqIH8VoqsYjPjevJB4C/JE3p/gEqg0tPnw6J9My4Lj51+wqKGX78ihzrXSglo+dlnorYSD97ZuBPSp0yXTJpRy1VGHnvoT8g8J7Rnenpydv9HXK43you4SgxTlDCyECWxlikiPiZNUwf3aEkS0hNQkEyIU9dhSe7jqoGuXe8jeMEjCk9zlmuqz4LZlpSlzkTpyvC/P141pBVW9T8gxeKM7KJphlW9DZh4r7FNWSXodo8bxw/XTWkc9UhDljGXdXPL/UEtwJJUBQd/CihZ3kwZ04fwADfj8VR94m8jwIVVOoOt4lGfiwPKJs7OAV8frmGH58ZFPZTHqpbgnEi0CmwXEHZ6AqTYsxywEUIlpPwSjDc9WtEB3t/zwnSzYiLsGFAwuXhLf7IEN3pvphDKpFilJqG1ZTU3k/zXXF0ImgYmTWbdWh/NODoab4iYDukB/LVAtTB2NpbUrwu+xMNE2SX1TYFlGcsahcYpVikusw/EzZRsODopaghCx80/Kd9JTPEkkuCpyRq7PHoDHCdNT7AtTd8+gPGtiI15zRmMvhMsKUh8anTeEXz1fYmCY/ClEz1Na1IIi9XpDjAA8o8SOZ7ItKFZ+Bn9I0eagZlPdBVuZCrnzlCK/0tj673zl0MGuLL3B4OBQ5V3pu/BJT8eAmfz5nbFrDr66q2YWYOPMIM3FrU2PXho+fifLjD9ER+j8Ov32hvgNuYK
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|6090799003|7092599003|461199028|15080799006|19061999003|10035399004|440099028|3412199025|41001999003|19111999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0ZGRUdCdUxxQ3VDTlEyU2QzamliZ2JVM0pOUnI4OHV4WUh0QXB5Y2ZRY3Vw?=
 =?utf-8?B?VEpIcTU5dnF2Qks2Ryt6cUJ6a0JkdlpwOGlneUNENzFnMXBNeUVEZkRZMW5V?=
 =?utf-8?B?VVZmcjJJMDlSMUtUS2kyS3Ixemo3eGpodDViRlkxWHROc2FlbTBDWms5eklz?=
 =?utf-8?B?ZzNjWTdQRFB2OThiK2F0R0ZWS0RnVndxb3ZLZDArVThCUUYvZnMvQmEzSVhT?=
 =?utf-8?B?dGRHT2ZNZm1TbXFXN2VJTmJrZXRhcGFKaFpxdHMyQ3h5Z1lPVVZhTmlDcHMr?=
 =?utf-8?B?Yi9STVFSYTQrVUF3Q2xzMGlSbmQwODBjdmE0RGRvZVNEVmdTekZ1SEQ2QVVm?=
 =?utf-8?B?dFlRZTBEa3ZnYTJsaFRWbmVSRHBkS0lKZkl1aUpHOGNEbGQrc3I4bDMzMUkr?=
 =?utf-8?B?RmxFcitZVnJ5ZDVIV2c3clJ5emZodlBXQStnSXJIaEpyZjV3VnRXWDBPUjJr?=
 =?utf-8?B?aU93RWlRRzlldzEvbWNvODVYSzJ4ZGlHZThlclRtWkNkTmpaa1Z5ZVNIQTFJ?=
 =?utf-8?B?Ykl3dzZIVEJ4MVI0M2dxemd2WElwcCtaTThnV04wMUZRclo5S09DMnBHY2dw?=
 =?utf-8?B?NHR2bklUVHlQTVpQd2ExK1BtNzBjcjFDdW9PeVMxNGZkWlZMelIraUdqQXM1?=
 =?utf-8?B?NHdsNlZGU2o5SUlCM3NOS3lOUVJycUs4dDJBYnVvSnFXNGd0UmRkQk5xK1Zo?=
 =?utf-8?B?bVpJTzFBaVlrdnhTT3dXUHMrb05RMlBrRkpFUnlwWHlHSGJTeTB3aWN3a21F?=
 =?utf-8?B?NlZnZGtOTDNyNVJWaDVyYnBRUTVkTmlCMURCZEpKNHo4eG9tdERRb09wTW80?=
 =?utf-8?B?cDVFZ052akpiVXB3K0hrY2ZpL0Z4KzliTFgrbXpNUjF4bHhKQXpxby9zSDNa?=
 =?utf-8?B?OFVmOXNxcmtyYm5vb0c3dE5adjUxWndwaEJISDUvQ2FCNml1SVZucjdyL0dJ?=
 =?utf-8?B?emZ6Rk0wZDFPcjN3bEs5MSsrUXl4cVJON0o2UHoyUTh6VmQrNXVzbHFSa1JV?=
 =?utf-8?B?VUQvWnFwQ2xPbGJYWEZGekpjam96a0VXOC9NQTlpeCtFRHdEU2xWOHNlZmlK?=
 =?utf-8?B?SWdUYWZtUUJ3NktOb2ZLRGZnL2hZVFpvckxjZDZiV0VBdS9lZUVCVDJQTWI3?=
 =?utf-8?B?TDQrdzNZMUFSaVBqVisyRlJJWks2QmRmQTNndlcvY3ZLd1hzeStkVWFhNExQ?=
 =?utf-8?B?RmV1ZFdzM2Q0eG4yS3NxUGNrNXRiNW1RSXJnMHJkc3hWc2ZPeWNGajFwbXlr?=
 =?utf-8?B?bEZLRGFUUEZrWC8wc3dVcTk0ZStnWVYxNjF6eDJNWnJTWTlyMHlxajNPdnN4?=
 =?utf-8?B?aXZRVTc5Rnk2dDBFUjJUZ1ZYNnJQbmNVUVZJb2dVcWhCQmNYRkVMOWU2M1VC?=
 =?utf-8?B?dnlLNFlHcFRIN2VsUzU2Mm85UWZpUER1YnZVMUlUZlljbi9Bdlh5Q3FWNjRa?=
 =?utf-8?B?TmVsV1hpVHl0eUFiM05Dd3lXdDlxT2xQUmwyVVlaR3gwWHlTOHV1SkZqaGxv?=
 =?utf-8?B?YmhwNHErbmpodjNVbnQyL0RpalR3VW5SaEdXUzB1MkUxQ0hzUVM0Qlh2d1hN?=
 =?utf-8?B?QjJFVHpCb1htR01RNkVyRjVnSHRRUDdMT0FQTmp1by9FbTdaTzYyb3E1VlRS?=
 =?utf-8?B?NWhjVzJSV0ZrSGNBWWFNWHY3RnBhbGlOM1ZoUDJNWmNYSlBLLzNLTnpmUFdM?=
 =?utf-8?B?RGVaYW1TNVFLSy9TUTdjOHlSLy81V0xzb2o4cDAxY1NBaHZSQVJsVUtJVVd0?=
 =?utf-8?Q?CPdkFRj1lf9hdEZuN3+eXrrk0P3uaSGGhGxHrEq?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHZXL0ZRbmtLTWFONGc2K2I5VG5XTjhBN3E1OWhPNTFYWTBHZVdUNGpJa3c2?=
 =?utf-8?B?aXJFSytxUlVqUXVXQlQrTkpSbHhhRjRtaG93VjI3Wk9lM3BDajl6R2ZENS81?=
 =?utf-8?B?Z2hTQk9pLzRXMUhqQXBSN1JjeU9PdUdkY2VQMDNDSUE1anhxV0ZiT1pxcHFp?=
 =?utf-8?B?MEFLTVBrZjViMGQ5cHp6RWZXNy9BRjczQkJXNjh3aEI1aG9zOWpyZjZ1WTdt?=
 =?utf-8?B?RzZMSExrdm5TMklQd1pab3FYbTA1MlMxZG90QnAwVnRCQXR0dXhTSWFiTzhQ?=
 =?utf-8?B?bjhEdXZiODdyMnpFMnFnUVR1V2s3TTdiemdWTVZnb0gyZWVvMFhCYlBmTzdB?=
 =?utf-8?B?UjFlaFc0TkJGaWtFK040R25FdmpwYXpxd1lmSUdIYnBLRmVFUzZuTVFrMXli?=
 =?utf-8?B?ZmhjYlBkSGVGSGRGZHlaajhjMk5MdVNLdldkc0l1a0YvWTFsVXg3S1dvNk05?=
 =?utf-8?B?R1NXcW5qSXNaaUQ4M3BaSm8rTDJvaHY0eUVPK1UyREJpTFhvZGQ2ZUJLZzVV?=
 =?utf-8?B?aUFRNlU0bHNuUnJSR29Ka0FhVFJURTM2WFhEUTJDTkp5bWljSGowenNsY3M4?=
 =?utf-8?B?Q2J2Ty8xKzZWaXhKS3FJK1VleTdCRDJndXJ0MTUvSU9nVW5BSHBCYWhOdEE5?=
 =?utf-8?B?czNFZFdoeGlSS0FFc0p2R3BtWDN0bUszMEhhYXpodWo0cVp2cERYazBWM0Mx?=
 =?utf-8?B?R0dPRXJRZkVLZVIrOXdMQWxlSTJIRllMR25mQmxjckVOZUhzdU14cVQ1WnB2?=
 =?utf-8?B?eExPSmtaOW1UT05ETy93QTdGWUNFbTBQSTFBMnY5MUJMTWRlODBxclAzVGpG?=
 =?utf-8?B?Mm9jWFk4MENYV2ZHNWxoeGFFSUxCR05DbXl0dk16N3ZxZ1F5YkJnL3RQNG82?=
 =?utf-8?B?ZUNmVmYraXZMRTNvemJ5ZnpSZ0JYTG9iSVg1SllLa2w0bW4yTDl5NWpWTnhR?=
 =?utf-8?B?M2lITXBWM1lZUTJaS0NHbGd4blAyKzEvWjF2U2xKdHpleXA3bmdtSU1JSUZz?=
 =?utf-8?B?VkptbFZXTGNNWkdLbk9URlVreVBhWUNDY1ZXYVlNQTE1b0pjUHg0WU1nSkJs?=
 =?utf-8?B?b3FlSjdldUYyRzM1bUxqTGhxRm9YSTQ4b3JOR2Z6REtnaWdETVEwck5xOGdo?=
 =?utf-8?B?MjNuVnFmZ013d01YV3AxMWFNUWZiWHdwaitNRUlyRCtQdkIzeVRhR0RHMjZT?=
 =?utf-8?B?QVFMNVVnYmlURHJWeFl0WlBNajN2UENXdmRwcmhhVFY1N3VNZ2dJVTNZaXZM?=
 =?utf-8?B?U2cyRnBsZkhoOHNSUFd5MTFZT2ZId2U0b2dhZCtndEtUMEowaFF2V01mVzFy?=
 =?utf-8?B?VGlGV3RzZElpZXJhZUVPc211SUxIMTZhTzd3MDV1L2JxU3ZzTlp3TUhrbjNs?=
 =?utf-8?B?NGg4WmJsdGp2UUY2UGsyanBNRWlYeXhmcnRzSVlvcmQ5eWIrNHhuMzdkSkJI?=
 =?utf-8?B?Z2t2UHlySW1ubFJEbjhsMmhHNkowYjA5d2xFdW14VnlEbHhSYy9jZFRIV0Za?=
 =?utf-8?B?R2ZtWEdQbHdUT2IwYUM2K3h5bk0vdEVFSThNNHhvK2JOOFoxQnMzbVovWkVx?=
 =?utf-8?B?SEprUmVHb2VSaWo4dFNsT09XQ1BuY3ZJVS9yUW4yYmNxZmRYUDhrNGRsRkRJ?=
 =?utf-8?B?MFppZkdqWFo5UE43NmtIRHE3OTBpR3BDQW00YURxa1NiZ29heEZ6TTRTODha?=
 =?utf-8?B?d0R0bWxTRlBsbkVyOGVDTkYrREdYblZZL3FGWEJGR3hEMFVQaE5SUWRZT0dX?=
 =?utf-8?Q?NXEU7tTTfFrdx63qxeVMKtpLw4OhoKeyGREcprn?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e4122c-f7c5-44c8-d0be-08dd8347344c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:46:40.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF4FC989315



On 24-04-2025 08:50 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>>> Something like:
>>>
>>>     [credential "smtp://smtp.office365.com:587"]
>>>         username = someone@outlook.com
>>>         helper = "!f() { test \"$1\" = get && echo \"password=$(cd /workspaces/codespaces-blank/M365-IMAP && python3 ./refresh_token.py)\"; }; f"
>>
>> Interesting, and this works too!. I wasn't aware of this.
>>
>> Junio, I can drop the third patch if you want.
> 
> What I want does not matter in this case, no? ;-)
> 
> It does look like an additional mechanism only for this use case is
> unneeded, but it would be nice to address a related but different
> problem, which is
> 
>     What made you write the extra mechanism in the first place?
> 
> In other words, was the current documentation insufficient for you
> to realize that credential helper is an existing good solution for
> your problem and there was no need to add a new mechanism?  If so,
> there will be numerous next "you" who will also want to use OAuth2
> token from a program output and get frustrated because they cannot
> find how to do so in our documentation, no?  Would a new paragraph
> with an example like Julian gave above be something we want to add,
> or do we already have enough information there and the only thing
> users need to do is to look a bit more carefully?

That's actually a good question. In my case, I already was frustrated
with no good option available for Outlook users to send patches reliably
to the Linux kernel. I had been banging my head and Googling a lot to
get a way. I finally reached msmtp, but then the threading broke, giving
rise to another issue. After chatting with the msmtp dev, I came to know
that its the server side issue with outlook. At this point, I was not left
with any more power to read more docs, and decided to modify the script myself.

The first hurdle was OAuth2, which I searched the mailing list with hopes, and
got the first patch, which worked beautifully. Now the only issues left were
threads and a reliable way to get OAuth2 tokens. I already had a helper script
to get the token, but I gave https://github.com/git-ecosystem/git-credential-manager
a shot. Unfortunately, it didn't work with free outlook accounts, so I was left
with my helper script. With this failure with git credential manager, I was in
an impression that its not possible to use [credential]. My bad here for not
checking the docs for this.

So I decided to take things in my own hands and patch the script. Logged a bit
and fixed the threads. Then I was inspired by the passwordeval function I used
in msmtp, and just implemented it in the third patch.



TL;DR: I should have looked at the docs of credentials as well. I kept stuck
on docs on send-mail.



My suggestion: Maybe add a small link to relevant docs in other docs as well.
Eg, in the description of SmtpPass, you can add a suggestion to use [credentials]
if you want to generate a token or something and link its doc.

