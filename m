Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011035.outbound.protection.outlook.com [52.103.39.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8533B47E0
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546422; cv=fail; b=kKh+JaQeiXBfq0edH5RZbjQePRRyjRQP7bzYtD0S0oBqBZJz/4fDW0glTxBE/Gob2PNQKu3Mqv9/3TsNwT1DbXhlZVsmtculTqp1PIfvsuJFPWg3CaEEmT/wtIGOCxG2nhpS2CYX3ugZdgy4CgxbHKkCnY2F6i5qUWYMoKMFUy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546422; c=relaxed/simple;
	bh=ZN3g9uffRrUDCCPeoXfySYG+NgjkjMKuXrNaxVzSnNA=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QHNmvXa8t6f6iCtfHhhaEp7k6n+Yqtd0ri9bpSiHK30bA8X8xOFirKYhiIuLGZJFlj0hPIAOzFrOE3yHkqqaUSqGauzpwHlEf2fWbMIMBn1+xG2BXMyrFB4H5KE5WjHv9jCQI+I6lg2oNYx4zBA5EKHhfQ/3g+yn4pyUHIw99Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cwMIYpSh; arc=fail smtp.client-ip=52.103.39.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cwMIYpSh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANZmUPHSTg+Y8OqMhVmLS9aw9UvXUuALcbRh6yFSzaLbXTvIvyt8n/u9EfrkGbqN8yYtxx8We5r8JoOn60/OtODLM/NlcQEZs3ucQMC4iQNiz9WRIDCQr4kKkF4lLPzUoY1HUlKzDCJJWN1HeYOfTXCYn5p0swJS/SW7vniLMcDdJECtpruKlNleQTJr+g8PjSO65oorWPIe+1WiHyvyecyhFFji6zyeTi/5c1/a6A9ClXW0OMCoQbAMpqU858U3E0JCuVhuV8dPDicgsGRe4poGxkAAAx17VoVD++bvn7j3RbiemWrnqeGJ3lWIlcNkwMwlKQiJTvhTqje61kqeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBRNHdtyZyd3uCyRhoA2RV6utJZhJYvqzbrThlH9wEw=;
 b=DQiV8N9aNAKVyY0Q9skMaFno0o9YYCYjWXa5ZgvQEYdI8Zy+zsF687fTaTxXBCIhzBAnWuGOLD1R+PBYyLd7X++/yOOtIz2FPzzY8YENTRbsJo573EEJVRni6lm3Q8Xun1MCtEt4S+cMAmSviZ9nAIDUIGNEjaNL9tqAU5EWgL9wK7DCiFqX2saM5b7qsFjbJU5gWuAshQXsGcEmJaYFR3H05d2/CgzpUfyiyzfV5jfQ0NKVwnCCRYsfZ0K9X9NAcG38lS7BQjKa41vVy3OQ3WGj9BJ4T7CTds8AJa1GO0yhexw7MkIKcbZPDfwNjZ7f4uJobdtKiVZTAyICltdlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBRNHdtyZyd3uCyRhoA2RV6utJZhJYvqzbrThlH9wEw=;
 b=cwMIYpShMfufP2yBg1p9WTae/wzi5f3gIPiJXP/8jUC0znIWdUWBmfQUNk+Hq+4Z/Zcs1RxGGfyT6Y4YvAynLN4sL7TMVZ95n7/a6KAwCwW2hLlNVu9FIRAd9q+WENBpb2V4vxDCY93N9gUpeqPAjrQhNcQrpXQup4L8Mp9LDR4sUkOk1WL9YFA6pLPRORfiRmkOra/ZtypXYL7ZADZWgjZnv7mDbJKN6FObezAByq6KW4e05wGFfnySzZQfSfZFKC5gBtxTzz4B1xh+rM/2/I5Z8zzu3G3mDgYnA9BRYL126rJIood4klXdp1a9w69npOVp88Ll2eDpZKpSEOrPkA==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by GV2PR03MB9618.eurprd03.prod.outlook.com
 (2603:10a6:150:d6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 10:53:38 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:53:38 +0000
Message-ID:
 <VI0PR03MB1163459D06AB474AD97D29E43C0352@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Thu, 30 Apr 2026 11:53:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] http: attempt Negotiate auth in http.emptyAuth=auto
 mode
To: Junio C Hamano <gitster@pobox.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
 <f175294459c9370ed79c8338d6008b69c2028f99.1776331259.git.gitgitgadget@gmail.com>
 <xmqq7bq63lll.fsf@gitster.g>
 <VI0PR03MB11634FE845793CEA7D25FA2D0C0372@VI0PR03MB11634.eurprd03.prod.outlook.com>
 <xmqqse8dz4pi.fsf@gitster.g>
Content-Language: en-GB
Cc: Git Mailing List <git@vger.kernel.org>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <xmqqse8dz4pi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <dda0841a-8ae9-4a26-a197-12a0b335b55a@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|GV2PR03MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 71739559-15d1-4d8a-b7d0-08dea6a6bbe1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|461199028|24021099003|23021999003|5072599009|6090799003|37011999003|51005399006|15080799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkF5VDlZaUVYckkyV09CczJzeGpOeXRWT2pwVXUyYjBVUGZ2dC9lZGZLdW9T?=
 =?utf-8?B?aEMwenQzOTgvQWVGSTlTbnlmN0FMa1JUa2h0QTJSb3lHeVNyWmtkTzV2bzlB?=
 =?utf-8?B?eDdIVDlRSTFGMUp1dGRGWmlnNDFOdXV3N2YranZOKzVoN3gxeUtYc0w5TFBv?=
 =?utf-8?B?M2RwVmozeFdZYjlCSWRXWEtqQXJPSkRGYUxkSW9VdVowRW1Fc2FkWmZwcmZa?=
 =?utf-8?B?Zk5OcUloaE1GWXZCYnpaR3dZUGw3SHk5Uk5Ibktoa2VBeHlqWVFYZlV2TmlU?=
 =?utf-8?B?SlUrMmVlR2RmYU9HY3FXMHRFYzYyL25CZ1grYXBlbzRsd1pwVytoSXh4cFhP?=
 =?utf-8?B?bGlIQlV4YlEwc3FhdjRGMW44Y1VyQUNZRFRtQnNYZkwrQzhsVG9wbnYxQXJM?=
 =?utf-8?B?bWV5NnJxWUQycnNQY1RYQVNIRzNreC9rU3Vwc2IrN0ZkRTZOdWNVdmtCdkhz?=
 =?utf-8?B?UnMwUEEvV2xWeUc5TENyNEl5MzZhWVZvSjEvRlZNc3pMOTBsc21lWTJLdVFr?=
 =?utf-8?B?SFNlQTNDK0JjSGdlOVdRd3hRVkd3QmJOMFFpdnk1eGlZMlBvVkZpRHhOeGYr?=
 =?utf-8?B?dmFGQlhNc2NJb1FlSzAyaHhsYWhNaUhweW9DSkdTVjBaenpyM2FsenBsT2ZG?=
 =?utf-8?B?cVBxTkRWR05YakFyOE45OXltWUZlSGN2d2l3SWdjdS84RWJKazU3a215WWxM?=
 =?utf-8?B?UUdMeThxTjZPV0ZLbjVQOHh1dzEwTHpka0pubVZOeU5CU1p2U3VBM0gvU25v?=
 =?utf-8?B?SkMvcTRKZzNVSE1mUFE1K0grQUE1d0hTVGZkSGRZaU0xNmd5SjZ2R2RZS1gx?=
 =?utf-8?B?Mko3RWJpRGdXTE8xTXQ1K2ltRmNQN1ljTGhkcmRwamRabk5SdjdUbkZZL2Iz?=
 =?utf-8?B?cDJWV3BBR1JoeWZ5UEZxcEhnZVZYWGd5SjR1SUFuaVRHRlJBQk5GbjVaSUcv?=
 =?utf-8?B?aVpxZWQ0TVphRExDWnZURklVZ2xGV2tSMm92bVZ2RXhET1Y1V0t2VzBWL2dp?=
 =?utf-8?B?aFMzVXNVb1NlTXZwbTQzbTY4a0JTS25FeVpzT0wyYW1DQmVtZWtrNm9uOUdE?=
 =?utf-8?B?YklWTmxXUjc5emJXUFZrTXcrUnpLRUg1WTVpNm5nRFlVdisyblpFSUd0M3VJ?=
 =?utf-8?B?MWRrVjZTVVQvK0dweCtZcFNDdTVnK1d4aGlZUGRLMDVGTVdGWmh3QStESDNu?=
 =?utf-8?B?aUVTalgrdHc2WkZubUY5dk8vMTVKUUc5WFlZSHpjMnMwTGFSa3FEMWpzSjF0?=
 =?utf-8?B?bkZQRlBmR0hGMENIWjVYOFo3WnE2cGJzaEdEeml5TEVlMkpDUEEyOVdmYXg2?=
 =?utf-8?Q?TNU7yBLVKON47+0p1f6tCvIk4857D78kLp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEdGSmFDWjdNdnhiQXR5N2s0cG5laDJaR0VQT1JObHZidGQ5d3EyMldVTWVm?=
 =?utf-8?B?bGE5NU5CWjBYN3NRWk40ZHM2YVJLc0Q4ZHV0ZVBrUStXSXA3RjFWVU5Qc2I4?=
 =?utf-8?B?OEdwdVJCWDIxWXpQNlpmcnNrZzVCenhIbjQrWVcyUDR2VnQrR1QyR3pDZ3FE?=
 =?utf-8?B?d3V4MzY2THlEeThKQnQwME9sWEJ1L3JmSGRlTkpmaDVuZWRsUndPZUlhM1pw?=
 =?utf-8?B?M3hZZ1BoL2JEeEpQU1R3RDdMVWlVYVFsSTlhbjhEczRKTkVlWWRLS2UvMXZU?=
 =?utf-8?B?eW1hQXFpeW01Vk12WlpUcEVPUGFTUzdtTlBvYVpaTWUzOWJkdHI4SVNZZDU2?=
 =?utf-8?B?VkpZUmdmVk9SWHQyWGRnU2FNUkZtb05TS0dZbUorYk9oYmxRT2xnWVRWZ3c3?=
 =?utf-8?B?ai92cHhqYURFaFFyeU5xVSttY3NsVkJnaUsrSnI4NERpalJVR2s2UjZUYzQ4?=
 =?utf-8?B?bGt1WTY0eEdVajV0RGtBQXdia3REZWVLbEIrZ0d0TmZVclZCZWtDZnRGbWh4?=
 =?utf-8?B?aGVYSTZuVy9FQm5QdGRGbHVDaVk5WHp2VGNKRzdQU2ZvQnBWbEFqV1NMV2xW?=
 =?utf-8?B?L0FydUhOS2JDNlRGM2FsUWIxSDRiSE9ML3kwaDBTTkdIZWpjWGZXWlAvNHBv?=
 =?utf-8?B?OXhtTTBjZm1HRGtteGZvNytocFhHcDlZV2ZoenBheGZDM3VZMUFxVUtLZmpq?=
 =?utf-8?B?WVZWU0gvbVF2WGl6RFhXdzNMRWxyLzJzbTYvcFdUYzNNbVBKN3pwZ1NMMlZ3?=
 =?utf-8?B?S1BVMHJWbUxVR1lnR25BVm44SFRJeGZQZmd0ZlE1VldTSFE3ci9GWC8vVkIv?=
 =?utf-8?B?NHloalBVeC9yakRYaVN0NnBNa3R3ZUFHb0hraHBGYVZRUS9KMmlVZm1OamhS?=
 =?utf-8?B?dGN6MmhGaTVSeVVEY0VXTE5Vcm1Cd2JTaGx6S0Qza0x3SzhBc2VwK0FjSG9K?=
 =?utf-8?B?elgzK1ZnNWIyNFNDMTF6ekd4RXdUTHhlaHlFVEpCZ09Ha3ppeGdqVyt4d0hn?=
 =?utf-8?B?LzlGcXBWM2VQK2VLNmVlaGtxVUpKeFlOdVM5UVFlMS9TVEExMHI4Q21HRDBa?=
 =?utf-8?B?anBsdFcydnhYeEJpQUlxOC9XN2ViWWpweUh6bkRtZTlrNFJ5OXNkMmxtNW1p?=
 =?utf-8?B?TndrT3doTkdFOEY0YUxleVFvMTZBQzJKSUsyUW96T3ZUeXNBaVRadVNPRlBF?=
 =?utf-8?B?UWpUczVPN0UwMGIxS1ArWE40Tmo5SGYvZXhVdXJzQmNVaFQxWmhXSGpKRm9S?=
 =?utf-8?B?aFRSc1R5YUp6Zm1iQ0U0b1prN3V3OGhVNDA1cm4vRUFWSmsvU1ZOa0Z5Snpw?=
 =?utf-8?B?NXBtUDNFRnJ4R0tlUURjV0RIdUEwMk91NFc2dWJhK0lFeW1LTFpiMjRQR09O?=
 =?utf-8?B?NTBvMHdRSVREcGJnVVZTTW05YnNwRUNrd1U1Z0pnTEh5MTVhdGVrZ2RDUjR6?=
 =?utf-8?B?bHBrdHpsaHVUQkt2Nzlyc2RJczZLT0g1YVpMdGV3MStoTDZWblBscy9wN0F3?=
 =?utf-8?B?RUxTeFRxQVJFM3dmYXdwNittTkxnM2JKelcwcUdZcGtuUVhFWWF3OEVuSkVv?=
 =?utf-8?B?a2FVUE1TQmNBTE9MREcwN21GMU1UUjJMMDF4eWZzVXlCZ0VWWUs1a0srQnA4?=
 =?utf-8?B?MDMyQWRmL2pYTjVjc1FMR3lVVlFUbTRBMTdLV2d6TmlhVWswclRkWkFJVjNh?=
 =?utf-8?B?aW5WRVczY0U2NWFubmZlTGl0Z0VHSzZGRDFrcGVzQ29ySlVjWkxkZjRWRmFs?=
 =?utf-8?B?cEs0YjdqVVJkV2loWm94ZzcwT2ZTQ1RYUGx5c2hHL1ZYbThmR2dTLzZnWE00?=
 =?utf-8?B?VDlJMHBsclVad1NsdEdBS2Myb1M2bEtEL0xMdkF6bXYrbGRMM3VKODV4aTZG?=
 =?utf-8?Q?8NSJ81yOWTCww?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71739559-15d1-4d8a-b7d0-08dea6a6bbe1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:53:38.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9618

[re-cc:ing the accidentially dropped mailing list]

On 2026-04-30 01:12, Junio C Hamano wrote:

> Matthew John Cheetham <mjcheetham@outlook.com> writes:
> 
>> Agreed - the existing description is pretty opaque about what values it
>> actually takes. Should I add another patch to this series to spell out
>> the three values explicitly? How about something like this:
>>
>>        http.emptyAuth::
>>                Attempt authentication without seeking a username or
>>                password.  This can be used to attempt GSS-Negotiate
>>                authentication without specifying a username in the URL,
>>                as libcurl normally requires a username for
>>                authentication. Possible values are:
>>        +
>>        --
>>        * `auto` (default) - Send empty credentials only if the server's
>>          401 response advertises an authentication mechanism that
>>          requires them (such as GSS-Negotiate); otherwise fall back to
>>          prompting via the credential helper.
>>        * `true` - Always send empty credentials on the very first
>>          request, before receiving any 401 response from the server.
>>        * `false` - Never send empty credentials. Mechanisms that
>>          require empty credentials, such as GSS-Negotiate, will not
>>          work.
>>        --
>>
>>    Does that read better?
> 
> Surely.  Thanks.


Submitted as v2

Thanks,
Matthew

