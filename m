Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011026.outbound.protection.outlook.com [52.103.33.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DD3F58D9
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794976; cv=fail; b=HBFWgoYa6NN7ncPfOGWZB5O2P0lqrAoteSkEGQA+c3EPs58MkZyqUTiADbuNhBLeqkrq+vg1OJr+Urfd86x5NCaH2yxCaiPjXlaw/VP4V4O4U2vhZk7JQLtr7a2eFXs34XLKkEJe4mA9fcx+Fk2dApR8CdxFx5n6ZwWGqo/aOOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794976; c=relaxed/simple;
	bh=NEMIAMXm0LhRJazG5YFfPlQhBaMTC3JOdwZhN5Vffo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ogvu6DbJbP3CUYnWzXcCBkV/QkJGxpQ74Q1iK8rWPTpJjQFePhalLLtNKQKm07tx6kJjF8iMLnQehBqzA3vc8AcwGDv+h76OZjTj5PdhdMdTiMC3fE2PateRmutlx+xIrlnsw9hZBRPSQKcJxzCCbtKWXdAyDaxgoWKQjf+FHc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cOJbQHNM; arc=fail smtp.client-ip=52.103.33.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cOJbQHNM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPUWmey8lifQxtJamakNJUXRNAlSovsSY4xHtgmNylJ4B2JS5H12ANrpa0Y/4qLOKp7YRReCI++UGGQBnb4OHACqNYBAClooy4te6Ke2xnnMRossQeZ8kqhMmNVB9u22KUbV8cjjNSPpjDKSOidVT33z9ZNgWAjBDCwkkFkqaATCfl9tOAGK6XWvwYfwWD5HEaBHHDA43vWqEosxGu+pJObznkRhqV1WLtCX/0J0JUGQYxZ1II0VbS8DWENyxjlziZmXhVZaCVe3HRtOVWzR/87rdVvbFZ3srfj1syzI2LWrDSpA0eAQnNFsJj7apKMO4slNGlEKwJoGX/herf8PxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFbM189UBun7q5C/qfkI+toY2ZhAi7HTdX6a9BZ+rzE=;
 b=KOpzZatc+sM9xpsOtOgu5yL6tdzOQIynNVC6oUL07TGh/LR8aK7qDzeqP9NjC5g6wBvQaMX9XI9/GcvbCnyFd3wJFL71q45WpKbU5Bu7wRc+pvH/RdWkJViBcXEA+pnZLukbNWaNm1evnEqizTpLhm0WYOq6FMBeQ8q/Y/4vz5ep8mKL/dFBcYzm/6wQgSFiGSiFb31TB9aNrJYNoFeVVd2C8dup1gCLWiwA1zLfcdcy/LVlDQwQajMxuQSGmNjJoQji4kKVGTrCsNcLUbFgg4RgpPK4edlrFRG8VwRKMf7jx2VU8GTIK1rkYmdHumF/F0AvWM11Hr6kW7yQtCwK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFbM189UBun7q5C/qfkI+toY2ZhAi7HTdX6a9BZ+rzE=;
 b=cOJbQHNMZoTnoSuEhUO5hg7sW2OnA2e0ytWFt/FDte0woBb08CM1CYmCO+Q/DH8E4sQbtaNW0v8K2mYGZWRSoOeA5AeRgbUDiGxYV+84Ha8dueYAOZZIXAcS5/uCfrxZtH7WbWzHOCwv/kh8MfLlYS+DwQ8LjN3WCcVvxlT8HrlIZ4f4H8UojHU09y0ie27Eyk83KUvlo2tWusA1dwe8Rpg/WRm9td3oINOBQzeSKBRt4YB/Lq9HbuIbQRxmPAX8fLQyQnKbAMoj0pkF3vJGXN2V3tHwlPzJ6HZvGz943OOrZWq+Wl6vtAE6VFd4/k4onw4U6ljHoBvdGjf/9OZpEA==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AM7PR03MB6356.eurprd03.prod.outlook.com
 (2603:10a6:20b:1bf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 15:02:52 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%2]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 15:02:52 +0000
Message-ID:
 <VI0PR03MB11634D905F0167747B1DB8096C0E32@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Thu, 18 Jun 2026 16:02:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: t5563-simple-http-auth failures with v2.55.0-rc0
To: Todd Zullinger <tmz@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <20260611210456.XYfhytSL@teonanacatl.net>
 <VI0PR03MB1163416D5C66FAB25AECAAE21C0182@VI0PR03MB11634.eurprd03.prod.outlook.com>
 <20260612180203.s2qSgDUs@teonanacatl.net>
 <20260618144953.l6Ng-dvv@teonanacatl.net>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <20260618144953.l6Ng-dvv@teonanacatl.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::17) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <13a38c69-78f3-4c35-ba87-32da1940a4b4@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AM7PR03MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1ffcee-cb82-4f0f-5744-08decd4aab68
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLSPhlJ95/U7v6W/AahuugGaU4SpPbI7V0qhCdLJBo5hs4po4DiGlrQ8H1mxhCHrIXp0R8P5MHMcD1S/lPUu2+Gmt71Z8VFxHEo9t7pSrRO6H+zKGGTmIx/rvjDiDwjbHZUkqbToJvhj+PUSLviPSBQdqY1ucvrLpuG9dX3q66fGnfNU5OBIPnDoUqW1pVPQvpnjHkt5sWnrVtb+fzk42jSY7jV0MflyTH3ENBA+PlVPh085o7wH0kEYCEcGEXVEVSC+wEVyroFQMs5yMYZY5u7PvlE3uvR9M9cxGxi/1sDHBb3AhLVqIL+rB/Dptw3aLUSpG6r8Dj7uoefZHimPJMlEG1qObFxpZvnYLKh0llecMjmi/AFNBggJyy+hVLJzuM2vSa4/0nSb2hmtp4DLsYOTgquEkH6uIG+JQa6ZGA1wAOUoEZNTwtD5JEZ/W6jtR+YyWh073HOczjvypgrMchbqykjIgMAb2R0oW7ntdKuhjaTwne0cC6b5Xt7UZ3KEaRNdr+20LhlnXQWPheXV7TX0OogwnlUHacnGxzGu4Bgl8Vj7f8rI6buT/BZon0gOoAbOyHBz/DjCw2r6z+3t8IdNubeL+XEImD11VFZjBK4M7zjvYLUxdvq1prD2vyVC6BfUtwMLjnNqF9bIDUZwAbo4qZ5EYHnAYTVH/CXd6oCAQjM34OXGS3i/7d15iMzIzFvcisVf3UNIXzJDHoHXM61ls+aaPmAtxOJtrK90cteZTFYjN4dBhsAd4vG1LIgIzuxPp2vqzBt/rJUIfBUeBJAj
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|15080799012|6090799003|51005399006|23021999003|19110799012|8060799015|37011999003|5072599009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akdPY3NEZG5mcnM4WkNSQlI5b1U4NG80bnA1MzZ6aUlpbHdkZFc1Um9WSjhr?=
 =?utf-8?B?VldaaStoR01tOGZEZ3AvYm43Y1NraUhlKzJSQUR1dFh2dnlDdGhNSGhjMVdv?=
 =?utf-8?B?aEFaNmtUUXpBQURxT3Y0SWRRQUxkZzFDNFJTQXpXZ0ZXWGVFZTRnRk1udzBC?=
 =?utf-8?B?aldjbjV3aFkyb0lzaVRhQWw3Sk5YbTZuVlFXZ1c2RXM0bjJkcTlUMGVNMFZR?=
 =?utf-8?B?UWQxUlBLSnp6Q1ZmajVTdzRtbHFUOFRqa2UzSTZEand6bmJ1OFpyYnRDc21R?=
 =?utf-8?B?TGVqc0VhdWJFOTV0NEl6bXlNMWYrakNoSVJ6QzZDQjE3VjhoSHQvTFhtTHhm?=
 =?utf-8?B?OWNEcUVvNmx3a1VTRzNYUTZrN2kzcEtnN3I2N2ZMeWpZTjJXcjNLMDJwT01M?=
 =?utf-8?B?Z2NFcVEyVk9SLytPN1pTUWdZWVZLUFhNcWN3Um1HcFUyY2hTWE1uQUtOM2dO?=
 =?utf-8?B?enN4VU1OSGVLQ3dIOXpwb3hQZDdCMk1VVWdxaTZvMXRvdHVXaVpNSlExZkxQ?=
 =?utf-8?B?YjRhZFFPUXdLMnkxNVAxYWtGUjJ2bVQ0V2tISmwyVVRPMitmRFg1Vm9wVS9N?=
 =?utf-8?B?N0tTSnpUOHpjeHFvaGVPOXpYZWl1REFXVi9KMGhLT0Zha01YV0JFcjNmYXlx?=
 =?utf-8?B?elZFUXhBbVdncjZnSE9ZYUhzbE1pWURMUGJFcnBGemRZemlhSXF4SllIb3Z0?=
 =?utf-8?B?NXFEb1pHR3RHb1NWbmpWdm1wV3RFbDB6UFovcEJpWS9PNkJ5SnU1NTRrTUtO?=
 =?utf-8?B?MHVVWVdXekk5RGdTOXd3Z3FQSExOYmkzVkVJYWhDWnRid0J2WWRjYjdZSHNx?=
 =?utf-8?B?bUovVytiYXg0K1gzTDNFT3BIOGsrR0p0Yk5oVXJrUmJkT255ZXhRTjc0L3JZ?=
 =?utf-8?B?TWFWWjZrc0hKSnlIYTNhTE1SSWxzZFQ4eCtBRFBFaWI4RkhSTFE2UlBUY0JZ?=
 =?utf-8?B?Q2RUekdrTGxhc2tDSjlDSDhtUHdpMjB6bTFqbGVCZUtPWTVBRjhRMlJtc1Rr?=
 =?utf-8?B?eXlRbTNRNjJ5YXlKMjEwWUM1WGhXbEs0bWZ3K1BRWW9UaHprZjRubmhxNnhP?=
 =?utf-8?B?ektmclluRHYrOWhJK09JNURPTHpGL2RhbTFZcUFtVEJHc1M0RmkxdHdSNjJQ?=
 =?utf-8?B?TUYwVXlQdTFEVytsTDA4Q2gyQllxdW5zT0Q1R3EvWVo4b2R6d2lmd2VtbEdR?=
 =?utf-8?B?RWZIeHVkWkt3VkxWMHd6Z05TWmNBK2FkYzhXbUZXVmxqbWVkQ3BDMWtzNGNS?=
 =?utf-8?B?akpTUDhSY1dxN0owd2dxODFqVWVhL3JJbnVacFdkd05QazZoWTI4VHdsaklW?=
 =?utf-8?Q?En+F6kncwaH2mc/CJhFNsf2zXgESchDS5Y?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVg0Y2NVZmxTVzM4ZmhCOGVYOUZRVHB2bVlqVjFKQWZMcWVFdWJmcjBPRU9h?=
 =?utf-8?B?dTc0bWVuN003NHNJekdCc0tIQjcxVHpBcFpPNUl0ZzUvRzlwTUdBU3RvSVNH?=
 =?utf-8?B?OWgzKzZWQXNlK2gwZmYvVUs1bEdCVHBZUWhLdG1MMXp5MW93NmpFOG5za2hH?=
 =?utf-8?B?RVMzeVNwRnBZVnpVbHV6SHZLeU0yVkFOQ2dpYzJXRTBUMG53Y2ViZzFTR2dS?=
 =?utf-8?B?VUI4amloNTFXN2d2QXllM0JtUXdQL3o0eEpFRGR1Rjg4eXo1YW5qQkVDOVBl?=
 =?utf-8?B?Tko2Z2ZQQ1pUWGZNMVlnSFFWSHZkcXRsVzlPZjlnUFAxSENYcjZYdStaQ1pZ?=
 =?utf-8?B?YUhmNWdha1BVY0J6STF5amhzdVMwZU1xVzl4YkpxR3BiNlFrUTRsWU1BWXZ4?=
 =?utf-8?B?cFpacTJ3MThWSkg3WWQ5dkczNHpBSzRGaHBrRXB6d3dRUmwrWTQ3YjZXTFdq?=
 =?utf-8?B?Qk9XWUZrekRYNDVMTmsrSHlZbUZ0MlpqNGdjRUIrZHY3S0lPTkpBZ1Z3YlZP?=
 =?utf-8?B?S2h3Q2hFdjR6dFVHODBtWXIvYUtMYmxGa3V0dnFoTmtRRHZMRXcrc2lnRjZ0?=
 =?utf-8?B?ZUoyOVJHQXF5d2l4cjVkY3R5WG9PQnpTbHlKY25qYlNhUzIxMEhKVlJPaURW?=
 =?utf-8?B?UURaK2lDb1huYVN3M0drMkJGemNraFROMWl3R21odG5OSlh0a2tFUGg0YUNB?=
 =?utf-8?B?ZDY3SFJPd0svSXpFS0tFZ0F0R3F2U2g5S3B6QSs3cFA1enZzQUdUbnNjRUhk?=
 =?utf-8?B?cHlyanRVeGliZjVMaCtJek5ZUDI0K0hXTVlqdWovVW82QWlBNm5wVzFBRWxl?=
 =?utf-8?B?NTBmTUtnWXNuUW8wU2tUQUI1dzNWNTdvYkI1TnplMUgrbnlpR2ZVZ1ErcXl2?=
 =?utf-8?B?OTBScWtHOER1eTJCLzZqU3dsMXRnUXhVUnNzL1U3Rm9uQ2dHN1pIRjBSR2sr?=
 =?utf-8?B?SHFkMlJGdFAxeWp2NTkydlhHaVIrOER4dStrc1l3dWYwRldCNDhhc3ZnNUxL?=
 =?utf-8?B?SEg1emh2emlWbkxna2dBS0ZkaXhkMVlCRWRibGRkcURxT3BrUlcxMHAyNlRE?=
 =?utf-8?B?aHZDVElQU0ZUZENmSzVrdHRFeE82ZVZ4dEQ1WEl1ZnVxVXh2QzZxd3BpOWhX?=
 =?utf-8?B?TGgwbG1RZjZKWi9nUy8zb0J2a3RnWHJLckJiRXNkVWpHVk1uK0d5VjVub05X?=
 =?utf-8?B?Uy91cmVUdmlWNGNGVkUrbHBGdXF6SHg0M2pBd0V2QVpRZWFpMFJ5VFNIemFr?=
 =?utf-8?B?QWsvU21oOHZzRHkzbytCU0trSmtnYlJkUFBja0NsYjlvUjFMRU1TS2JrM1o3?=
 =?utf-8?B?bGE0UHk2SUlibTBLK3hqQzc3RFhOOEFEeTBsMzQ1MXRUVWw5SXRVNVRBN0Q5?=
 =?utf-8?B?Y0pYSHpDV2VDakpWYXJmcis1bTE1SDB2RW95cHlIWjhTYlRVMTdiaEVkRzI0?=
 =?utf-8?B?SEl0czJiNkY3RElGNnpoNU1JaWVreWNQQXlBd2JjbHYzYUZ6MWRGckc3Rldo?=
 =?utf-8?B?UTNXRnFOWE9oMmwzRy9LWnR5eXJkbk1kQjIra0xMNHMreXpRU0x1L25iQkUz?=
 =?utf-8?B?YlNHeXQvRFBYWGVhTU41Nm0rWlVtNnR5NXJHVE9Hc0NvNysxRFEyMmVqblM1?=
 =?utf-8?B?UStnSnpEYkhvNGtIVkZUUnZRVlJRQWlldEN2aERralZnMWFzMkEzYklXUE1L?=
 =?utf-8?B?aW5rL3lRQzBGTllORG5SUUpXcXVreEl6MjhhMXBrcDU2QXVxSDJ0MnBPM0xZ?=
 =?utf-8?B?bDZXMlBhTGppNTJ4a0VXeFdMQVVRamZob25QQVBzbUJ6MDlpS3dPUEdBeTBW?=
 =?utf-8?B?MlpXUVAzWlZMeUFBckErcEtJRU8rZ1l1QitSMkxEd0svVUFqa1FGeVhvODhZ?=
 =?utf-8?Q?s8+sjlTGdBbm2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1ffcee-cb82-4f0f-5744-08decd4aab68
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 15:02:52.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6356

On 2026-06-18 15:49, Todd Zullinger wrote:

> I saw Fedora picked up curl-8.21.0-rc3 this morning and
> confirmed it resolves the git test failures.  Someone else
> has already commented on the upstream curl issue to note
> that.
Thanks for confirming rc3 fixes things!

The CURLOPT_USERPWD = ":" behaviour was never codified in curl's 
documentation, but given the fix they've put in place it's probably a 
good sign we can continue to rely on this.

I may propose a patch to curl documentation's patch to say that this
behaviour is expected and supported, if the they don't do it themselves 
soon already.

Thanks,
Matthew

