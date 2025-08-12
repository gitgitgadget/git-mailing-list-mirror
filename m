Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AC1A23A0
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975291; cv=fail; b=rl3nZxynkCBHkuGD3/sTS+jBI0drQbvzwc2YTkFNHLK64sggn+J+eujRx0KIVScybi1hC2yT4AyyLX1+YRXBayx884VP4Kt1BJcVKIy00KQgBCIBw7qJ9iMzMeQM/BQiG1A/UyEr7w4tvhcr/fvge8mchi/ca2S+dPfs8aq+3cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975291; c=relaxed/simple;
	bh=EPOhk9Hl+2AF3z+cG5kvf/ZFDMj4Q4xHWPvt0F3Fqtg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=ppG+rkcXq7c9ZW47udYbrbkA9F9KQBrtNteS6VwJ9rrj3SxuqJ5TqBGA3GkROVMhcvrygQGjSAmxaPliBJ6ZfCDYa7NbY415zNydzeNN6QvApNybupIX94Dkd6TbBZUgNqDpN+2Fn6mSCcE63BDg7lO2a4goZa6TMKrpyCiI7kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cbTuAOU3; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cbTuAOU3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swdFNn8VY4YQ0j2PsQKdJKJBkWU1hcU68WjVvy1oCPuebwZb7oLzG3Fzd0Fin9vLvis7Kk2Q1eoYjnKqtvY2uXBogztCfI5H5Xxb51Lgs9Wx5mVQFRS69HaMOYoiRNMjvIspMC9ysZv7q3H/IkUcEV+EI+l6DIKbJvPjebB/LzWb1WHZfA9dqXhnLSmB3nVx7DV43Yb1GCfyV22x6HdGh7sQv9QPo5Iyg74yoPIAluLSXy4hQCNUfskPMtYOVzwfRjmdtReBx/o7G6afHD43vnbzyWm3Rz3fLigT6DtO0jRk6YFmhNKZD1/M/ajLoEBZ4SPmQaEfxONFEYTLZgiWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5xOJ5ugKDDxMpiaDqu3IWQRqZPADWHaNiIFXMI3rFo=;
 b=zU1TPU+O7Hh/RjTLD5ceZLRhFuATtybjk1qh8yplMC1ilZclDCPdJhRqIxukWFhMaSEI7ZFV07mFPCQ8EOVPL6Nrkyo8DnHD+YKaOj7AOKjXvYWRiwJazNDXOfO+wZakS1tqt/CEiEzJUV876dOUDSVzFq9QP2HOLQZiwCkuV0cVf/C3SWs3oFO3bumISIhKXflePPXYkS/E5bh4O0trzbkH+WviQvGVYvi6VWlDOHS5cpPib3SJPFAvOlTXVCoRqkx9/TW1sjQxuZD1sbIHmdjgxL95ST5J35AZnscv+fPEilIANHuuhl29vZsGGHTSiFMvscO43+meZR3mC7XxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5xOJ5ugKDDxMpiaDqu3IWQRqZPADWHaNiIFXMI3rFo=;
 b=cbTuAOU3irF9uyTifzQuWDhZf86rO5VhB0aPAOi8ca6rrVr08xwxN9zBcRa4mdi+/Do0RqR/FHWfP02OwSln07TKk+6dW3h9hLN0srnGKmxZF4xlnJIOIvbikvuljCK3bVP7jzsSK0tiTnVoLXuhKsJwMgYOdXk4acMemjovrSMJ2jq+v1JjpjsoEqj/9aHc0DyrIQtn4DsKDbPXuHeVqaWnujl6zNxZVvSGExbF49Me90rshs4/TkxTZY9983kmhhBcBjLJ//Wj9XtmOg11jHzlEskMQW8OZsWi39XAnL+xXg4H0uueFYcagMh7Na7IfsmnhEQyi0MOgmbYqCmLNQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB10247.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 05:08:05 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 05:08:04 +0000
Date: Tue, 12 Aug 2025 10:38:01 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_2/2=5D_send-email=3A_enable_copying_em?=
 =?US-ASCII?Q?ails_to_IMAP_folder_without_actually_sending_them?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqv7mtzfuc.fsf@gitster.g>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com> <PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN3PR01MB95972CAE853F4079F0F62F0AB85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqqv7mtzfuc.fsf@gitster.g>
Message-ID:
 <PN3PR01MB95977F0C73C909929400B3EEB82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN4P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <0639890B-4986-4B60-A554-F91B494DE304@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB10247:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b12323-f549-49c1-20e5-08ddd95e37d4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|5072599009|15080799012|461199028|6090799003|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUFFYzFtcGRqY25ja1d1TGIvY0IvdHBhZ0UwOFB5QmdsWjBFUkZUM2FnOHJs?=
 =?utf-8?B?c2tuRGNsNGNtZm90ME51ZFdqTkY1NFViZVdwOHNhbWRlM0hnVlNMNkl6MTJE?=
 =?utf-8?B?VmRxdG4wNi83NUJKUEN5Ty9Kc0tNUk85R2FRMGhtSGllSWhKYUQ1bnZLRVpV?=
 =?utf-8?B?T1ZMQWJUNkhFZVlmSXRzTXY2Nnd5ZGtWNUdMVDFuVlhGNy9DT2xqQkVSZTg2?=
 =?utf-8?B?NXFEMFNRY09SbUpkTDBZQncwbFdIRHd5Qk9qMTNUYlQ1VW1paTZkREt1bWF4?=
 =?utf-8?B?UXpoMU1pL2QyTzNMYUVoN1ZJQzY4NTdtMzdzL2FjWDFaNWJkVlNLUnRNU1Jq?=
 =?utf-8?B?QTJuTTViT3g0QnorT1RxVjdlU2s4d2pmNU9hR1hsMndEZktyREhHTXZOeTBm?=
 =?utf-8?B?NmF3bmR1QWRHWWxHK0x2c0dKSmlQWGtwQlp1aEtDa0sydzV6UGc1azhSaWF6?=
 =?utf-8?B?eExXc21qOEh5WjNzciswdVlzMDBGTFhjL0FsamthM0xkSHNYZHprWkdFREU3?=
 =?utf-8?B?V0FiSjJJMVBNNndHMVVHVEpoK3RSclY0RkpyVXdNQ2RFK2o1T2dvQjUwVjhn?=
 =?utf-8?B?MlNuT0pnT09RUU1QZXo4WW50bmlhdUh3SWF5ZXQxV2xQa2t4dDVqeGdiVE5Z?=
 =?utf-8?B?bzNjaUU2QlFmdHBzVTQzMEdUMWdWdzNrcTZHZGRNamcvS3phdjVoU0JENWhO?=
 =?utf-8?B?aVdpVVAzejdwZnp1VTdFSGJSaFNoYWI2Q0pTVXc4cFZVQnV2VkU5aWhBR2l6?=
 =?utf-8?B?Mi9nc0I3YW5iRFNJNk1LRG5WLzRtOEpjTm4yekR5ckExbk1qVTR0YmRONWM5?=
 =?utf-8?B?RUJ3OVJ1UEFaUzFmV2k3MTVwMjlTOUZRM0xxbzlHeWszbTNPWnY0NTBqNkpY?=
 =?utf-8?B?dGJJTEJweXdtSDUwYU1SQjl6SkQrbmE3S1NtOUl3NnhQYXNFK0YyeEdJVERm?=
 =?utf-8?B?MTlSeFRkTTBzZU1RWVBDUy9pZGV1RFl3VE1lUnQ5Q296Mjh2R2ozTllNWlMv?=
 =?utf-8?B?NjZsZWJBVVZaM000c3JkM0t5V3pkeUNaT1VDMDliSzVJeGNXTC9OVzJBeXpo?=
 =?utf-8?B?WE9VSTlVYzVobVZ3OWh0eExkbWpmSEczNmpBUXpiYlZHaDBsMW41cXRkNzNn?=
 =?utf-8?B?ZlNXcG5XcFB1b0NjNU5EUjQvY3RTRy9BVXlqRnJFdmVTNXFxMUpwMWhya2JJ?=
 =?utf-8?B?eFc0UE8yMTN2REZsSlFNK2UwVG1TSHQ5bzZ1UThXYjJYSFQzNnJ0RDJpN2Iv?=
 =?utf-8?B?K08vdnNRZExWN1NFSzY4Q0RZbVA0dS9DUjF4UnRRNHV3UlI0Sk9hNy95YUZO?=
 =?utf-8?B?NVRQbHpYRGhQOUtsSlZXRnoybkRMTTJhd2crMUlLTUNuVTNiaU15RTdFQXZP?=
 =?utf-8?B?SmZGRWZTaGhNL2JTZExMRVRCcVp4V2lDTy8rSlNqdGI4TURmQTg4bkRNSDZP?=
 =?utf-8?B?cHlHOUdtV01BSnA2ZysyK1IvKzRmN3RzYm1jQWxBTXR4SUR1ZEE3NGF1Yk9x?=
 =?utf-8?B?WE9SK2NIbFNnUWk4aDl1MkhRNWZSejZPaG04eWhSYW1LeExrVXhjUGFwbXNY?=
 =?utf-8?B?MkVOdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0NybzNXQXU1RGIzMk52RFpFREdXNGxWeExQOXIwdEEvQmNsTmxhVk93Mno1?=
 =?utf-8?B?dnJibzBVNGxIYUJzdENUK3hiZHBNbDZVMFBPUFdMZHNlNnZsNzdTQ280MDh6?=
 =?utf-8?B?OXloeldzcXBrdEc3T2ZROTlDNGFmZExibmRROVBQREhpL1JUemxiQU1hVjk4?=
 =?utf-8?B?Z3VkOXBGZkxLVXR0ODd2M2M2citpWHNqNzczVzBPa2FJTHZPWm9FWmVaVGFr?=
 =?utf-8?B?bGJpcmFzL09SVWR4Yk0rd3djQ2FxNjNNQUxYQ1BQd3VnQkFPVGpLcXc0Tm9U?=
 =?utf-8?B?cXlwQXQzZStZV0g0WDE5aGJLVkJSSTBmNWlMY2k0TUpZVUhDMVNxbEUzVnlX?=
 =?utf-8?B?OXM5R0JhQzVVZjRtVGhnYnpyR2dtVTZWbzl3V1A2bDFPNHNDTDRWMlVncUJm?=
 =?utf-8?B?clY0d2p2ZHZvZFRFM2VSa3NnYU5pU3Q2T2pPcWhMTVBoZ1grNGxudXhjQjRs?=
 =?utf-8?B?Z2w3QW10eWd6ZG1UazVoallrN0d0NGtYb0pyTEpUR3MrcUZ2WGhHOHZEOU9p?=
 =?utf-8?B?dVpLTHVwL3FYUTRwdUM3Rk1jT3RWQnUzMzQyaUUwN3k5dnI0TVU5TGlDRW5F?=
 =?utf-8?B?SkdqbUlKbWVocG1lZHpPVDNjUDJZS1JsZkU1Uk96UWRyUm9LTXdBUHNndXly?=
 =?utf-8?B?ZUcrVk1Wc2xYMDhEcXQ5Vlp3OHhJTnBrdVh2eDZBTUg1Qi9yZUJmeThIZWFB?=
 =?utf-8?B?N2hrSEdYeWdnNEpsKzFVYW10dXBBQzM1Q3pQRE9hWlVyZmZISm1jRzhFelBv?=
 =?utf-8?B?eG5EdHEvZWJxVTVvNE5aSFZnOTRmeFhFRkpmMmYxbmhncGU4eTNsSTdQZWFz?=
 =?utf-8?B?VWZ0bm1ZUmFHWGNVclU1V0RSQXN4aVR3em5Rb2Y1dnVUaWZJcHR4REU0bWwv?=
 =?utf-8?B?U0NqWDExemkyTDBmck5jeUJYL2x1djgyMUtmaGk3TDVyZFdaODAya3NWWkxN?=
 =?utf-8?B?ZjQzYUdnbnI3SlBxVVpSOVNyOGRPVkhGUkpZaW5ta25LRFBFQURQMnFhZTRo?=
 =?utf-8?B?em5melFRb25NeXJWSlRIUEFHVXNqMjRxWXJsVnpLQnBlVTZBdEFoQWE0cksy?=
 =?utf-8?B?Nmx4TWFKMklrcVhqUGZKWmwzVHRzV1loSjd5T1ZrQ0pOUWlNZjg0bC9rOWVz?=
 =?utf-8?B?dGlWSHgyU3pick1zUStqbE5sMGI5VEpIQ21QTmxYSHpwaENzV1hjeTI0S2hT?=
 =?utf-8?B?RzMxaTRCdDZIMHpFTGcrL1kzRnpKazNVNEFjRUdZT2xuWHdHUEQzYS9RMG5i?=
 =?utf-8?B?TUFuQW9BQXJOaTZtekxxN0NZek94c3dRVU44dFA2NmlaaUErRGlCcnZ0bGdM?=
 =?utf-8?B?M0kvODE1ZjJwNFBmRWt4TzFMMk1oNjRHS2F5OWZacHpMYXF1SUNmRTdvWEdI?=
 =?utf-8?B?K2V4TE1hYThzWVVmd3JrMDB5K3NBT2dnKzVGeXFYUDBvT1pCMWRYellWaFpq?=
 =?utf-8?B?WFUzaHFISXFNWElBczB5MEdLN2l5TVlmUDlYWk8rZnVxckk0YTcwblFjNUNF?=
 =?utf-8?B?djQ3WkFSVE9qU3dBd0ZOV3JWWHlhUjlzVlBSMUMrM0l1cCtLME5aanp6Snk4?=
 =?utf-8?B?aTVVZ2JnZVNBZ3I4aG5MdHA4eFFGenMyamNKTEk2Y3d2djFPTG5jK3ZBUzZP?=
 =?utf-8?B?YTAvMHR1cVAvdlBRR241ekpmMzhtVXV2Q2xzdUxITmxmMTM3TzhJS1pCcUxu?=
 =?utf-8?B?M1lnbjh2V1ZzQ1kxZkJrbjNzL0c4WVBTQ1kvWXJNUDh4UjdDMkdjRGpOazFq?=
 =?utf-8?Q?JzCQ4zNS9DlIFgVFYHImBUmuJMsmED6GvKNkmMg?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b12323-f549-49c1-20e5-08ddd95e37d4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 05:08:04.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB10247



On 12 August 2025 3:22:11=E2=80=AFam IST, Junio C Hamano <gitster@pobox.com=
> wrote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> +--[no-]use-imap-only::
>
>This is better written on two separate lines, i.e.
>
>	--use-imap-only::
>	--no-use-imap-only::
>

There are many instances in the docs where the command line option has been=
 written as --[no-]something. Do they also have to be changed?

>if we want to pass "make check-docs" when the topic is merged to
>'seen'.
>
>Thanks.
