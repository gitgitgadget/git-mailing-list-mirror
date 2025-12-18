Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010002.outbound.protection.outlook.com [52.103.33.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412467404E
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065316; cv=fail; b=AcLobguWPb3RE9nZxakfLx9ULvwU54WFYZdtYHzIwxTy4S2OHNGviMj2QSRY26onicPFiy7XA6dDVahHKxMrltLP9az1oEHBAJSzB/ttvuojqVnzOj1I6Rj/+5UY3ux54vs2+T8b9ILNUNpVeXAQ1DHovaMEOQVE+ZDBHx7Mp+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065316; c=relaxed/simple;
	bh=PYWsHieAzldO4sI2kTJ3M842ejRwWFC7GsBkLhC4e5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ukJMxuN28qjuog6XGpGfzS7IFjwcLVmkkt1tfRNn3qUTUa36IYEjud1HwfRNeUQ/F2sbSa9FB/3jpdpjP96FDHX/LR+WBZ2SmQTnzKQwmnPFLWLjCS89wbwPg5z1zBGn6ArX4KoKK9t/t9Pfp7PzyrrC4HzWTYB9u6uxCbt9rzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Muap97eV; arc=fail smtp.client-ip=52.103.33.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Muap97eV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIp7+dOhXJyN/qO4bThpiKNvmTTXrDdqguGRyB0+j+qvDexVpfofoK1aXCCOYhPe12NxY8tzSytyXdyAfeU5Q5BULJa6ITQSS4IGioNJiN3cSRK1lGv+SDKKkxPDEcYHnUlvPw2xjhjhvOj5V4yMfjhS7LVJ8ZFatrR/818fSjkR+twlw5IWsN+oZRuIvi3t2bs4Lu20vvUcVUz5KoFNR49i/hsdmupSajGtR6EN5EvBoMjECM6+dAf3BZNYCP5OpncRnYKXNdW1DYLbAdDR5/ZdWewDrjtiOWJakQx+LDp8ezpg92WqVFChocxz2eyv3allUiqJAKRkkJ0sWgAvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+t6/Q4NnBXbEiinEf11071kKVFaU//ucwUFGtUebO4=;
 b=enzAuIGDNouB9RRODTjeOShC0S3QoY31qshvVwyBYzSQOwODyD6+Nda0dWKD+Lmh64eRSBa/ixcg1r8VSao9iqvQluaQ5ISN8JARRhHFDKYPUShWvmbzVZ6hJtIzfIWZkdkysYGlqF+Xts1NB6emzh8wioNgFehu15+39dzRNruZ/6vD6rZwG/f0FNvvBL8g3ARSFeIyFyqX+jdlgKqcHbrqvUlsDmfdm6MpZkYJ0JsMZ+vtZwwbiqg5Mfed/aEl0yj8eO7HRNLWspCwrwlxGXBto+mR5FDjRJcPzUHl0h7wQOvsBzz2cRzRaCuL6WPMyYBaGyoTaqcxyzPS29t1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+t6/Q4NnBXbEiinEf11071kKVFaU//ucwUFGtUebO4=;
 b=Muap97eVdQ/xcAE7IWHYjQ5132JiJ1yWgTH32sXYh5WmN9ng4TaRkVrMjqN1WAGG2cGy67clQG4z9BDW/3czUSfOXKQpwwJL3B36pzJGby8FKL4pAbdzVd6d3WKiRBagz36Pn5VgrmjptH7E1le5eJjym5gDp6IUolmXZPmIOHPHsaVOC5VWxoVP9BBtb6CDLXmYZOH/0sWxNax2vmzHt4UXhfM+z1xxe6CH2sG1uzv33F9ZIn+YveuBs3LE1jMgdEMtUvm3cZ1Gn+M3B1ywTpKEcDQieuXr8PT43Oqm5dpVM4BCy6oFQ8+UA11b1d6eUMz3XR3+GJTbEgJ+No8jmw==
Received: from FRWPR03MB11065.eurprd03.prod.outlook.com (2603:10a6:d10:1a3::9)
 by DU4PR03MB10791.eurprd03.prod.outlook.com (2603:10a6:10:58f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 13:41:51 +0000
Received: from FRWPR03MB11065.eurprd03.prod.outlook.com
 ([fe80::d94f:c0a:f839:e920]) by FRWPR03MB11065.eurprd03.prod.outlook.com
 ([fe80::d94f:c0a:f839:e920%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 13:41:51 +0000
Message-ID:
 <FRWPR03MB110658677899817CC49A50DE7C0A8A@FRWPR03MB11065.eurprd03.prod.outlook.com>
Date: Thu, 18 Dec 2025 13:41:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t5563: add missing end-of-line in HTTP header
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
 <20251218121819.GB3758205@coredump.intra.peff.net>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <20251218121819.GB3758205@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To FRWPR03MB11065.eurprd03.prod.outlook.com
 (2603:10a6:d10:1a3::9)
X-Microsoft-Original-Message-ID:
 <f48c2763-d8d7-491f-bf85-97a1be275a5d@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWPR03MB11065:EE_|DU4PR03MB10791:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b58899-063e-430c-765a-08de3e3b32cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|6090799003|8060799015|15080799012|21061999006|23021999003|19110799012|440099028|3412199025|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFhranVvaVlWT3Rqa3pnLzYwa0U3Y0lWcUxkMmNtTkpVbFBkcTJtdTZocmMz?=
 =?utf-8?B?T0JBb0tTU3RXUHlySzV2eVR3dURtZFc1ekFac1ZTOE14RUNSN2N3Z3FMN3BX?=
 =?utf-8?B?S0pHRlNOOG8zWEFTMitreWJRdUN6cFZ0ejRJaVNSNkdIM0k0RVRveFZLTjhP?=
 =?utf-8?B?cmw3T3lhZkxhMnBiWWZLbVp3RTlDNkk4TzhnUmdNQmg5OVR1V3RkY3FGNzdp?=
 =?utf-8?B?S2kyYmQ1aHZ3cGtwenEzeTlwYkZvUW1TUEd0RTFadTc0Ym4xYitjNlVDMUQy?=
 =?utf-8?B?ckJDcGp5a09pUmZObllza2ZWREcwR3V4a0NwcDg2V25DSC9MYnp0cHYzd3No?=
 =?utf-8?B?U3hNUHhRYk52bHNjQlRJN3hXRXZXMkZDQ2tYQVNON2tYT0hINUwxSW54RU84?=
 =?utf-8?B?SThoRWRsSDA3a1VGZmNNNm5UT0hLbnVjUWRKOGJZdm9DcDluRmt6aXdOUThz?=
 =?utf-8?B?QTN3TnVLbWhGS0F2QW1NNk9YQUZzZkJSc21Qc2IzUHhnRjlJdmNQRXpZY0ZQ?=
 =?utf-8?B?ZXk3VGRLZ25iUlo0Y0ZZS0g0elRxbDIyOUdQeGNLL1o1SFQrcFJxcVpjcHRx?=
 =?utf-8?B?R2VTMUtPVmJlMHhYcHpCQVp3UVJRZ3BmZUlMUnRUbmo3Z2thSU4rWkhLdVN0?=
 =?utf-8?B?eTR0azQwQ2J5YUtBSEExT3d3TGRiN0hlWHNvRnBtVUxzZjdJelVnWnFTdnAz?=
 =?utf-8?B?ZU5jb0dlbFluUEZwSlJ0cG9tcHlCdjJrdHRQTGF1OExSa2JVa3djUlE1RERa?=
 =?utf-8?B?VTJCekE0VkFqUlRydzIyQUZwcytVVWw1MC8xRG0wNHdaVkNtVTRpRHZacTJt?=
 =?utf-8?B?UWpmejIvdzBhRzVhTUF0YlpnRE9RY0xyMjVpeS9zMXRWM1pmeEtwVjdHUnlj?=
 =?utf-8?B?cjdDYkZFRUpxcXQ1Um1vZ2dFZko0UzEwM1QxMzlKaUNzRHFmWkhJMnBrTVE3?=
 =?utf-8?B?RHUxd1lzeWxWdGRUcGxaODE0Q09TamJFM1JhSGVadWZwSDZDeGFPczY4RTUv?=
 =?utf-8?B?QlNwNnBUMEYzb2pCMnRzS3BIb2xhcktnMXlIZjdHMkpTQ1ZGbGNmMDZ5UStw?=
 =?utf-8?B?cEd6SVhZbDZVK3k4NTFDTWVHNmIvRlJXWHp6WkdWd1U1YUJVb1VybElCa2Zk?=
 =?utf-8?B?L3J4QjFDMWlXb2d0TkhuSXR6RXBIdGd2aVJjV2RQWlNTYk0zR2JzYjVLTjBS?=
 =?utf-8?B?aWdvdTYzQkQyeHpweUQzRjc4aHYzRGpqOFE0eTcxbHZVdUg5THA4RmRhdnFl?=
 =?utf-8?B?dGFoTmxNZThYMTJCWGtwUCtFRk41NklPM3BZQ213Mm1PMzVrZ3ROMzJKejd6?=
 =?utf-8?B?VVdZMFdoZzdxcUJ3dXQvVE9PS3Q3RWpKN2pMV2VsS1ZSNEx5KzNGM05sOHRI?=
 =?utf-8?B?L29KK1BqWHJsWGRZbkVBWWdXU2o0RnYxZGdDNFRjT1lNdk1ia0lGZm9zc0Jo?=
 =?utf-8?B?ak8wYnRVQ2lYR2pMWDJhbVhENlVKaGtxTy9rMUcrY2hwUVpYODBkVDZJQ2hm?=
 =?utf-8?B?Mmp3QTdZeC9lRkJqeGdMQWI2UWF6NDFhN2graTZXaTd0cUVpWUZ3bTBXaHBt?=
 =?utf-8?B?RXhZb21jRFBQc0hOVk5kSFZoWlZoVjhoeU5BdFNzQzFxZVFSclcrYzhxaDJS?=
 =?utf-8?Q?c6FA25oeaKPTRDpAEsh16QQ1YvZRV770IGaxg7A4r4uI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2pYbWYzNWhSMFZNdDQyM1IrQW1USGo4OGFGSVNGQWVxd3MvZllRdU43QTZG?=
 =?utf-8?B?TEhXSWU2L3VsY2o3eEc3VkJCcisrUlRobUpUMmd0S0lod0hGSlhzWll0d3kr?=
 =?utf-8?B?aUsxdXp6ZjdRMnptUllEa2ZnVld2NzMzcUJqeWZsczVlRENFNXhqSGMxTEcx?=
 =?utf-8?B?TW5XSjkwT0VLQmFRMzVFWXJsWjNLbHB0enRnNWs3c1RLVk1LM3lkdTNrOE5J?=
 =?utf-8?B?dnRtdEo2UG1wWmxaMzRidkhxNjZCV0EyRlhDb1Boa1hldGpLSCtqUXZZNU9s?=
 =?utf-8?B?eFNZWWR2VHk5TG1KbEJ5aHd1Um9xeFJzUkRPMldWMUNucDR5U04yT09nRS9v?=
 =?utf-8?B?MmFsNUExSUpjckx0MW5HMTQzdVNPbGMzSkdqUE1lVk1INXlrY1laMTAzclFz?=
 =?utf-8?B?NW5razUwYk1hUjZCRVgrVmhEOGRZa2FhLzJOWHZLRGhGaW9qbHVpYWFpTUxy?=
 =?utf-8?B?eWxzRGFySUV1andsT3dpTmY2OGNlbW45R3U1MHBCSk5XWm5mRGlyc3Q4QWdw?=
 =?utf-8?B?TkUwMDh1TlVsL0plcCs1YzAvWll2cTByemllaG96bzA3RUdXbmlNRHBhN2Jl?=
 =?utf-8?B?cGZRMXdLeHdlaFVJUGpraHJ1TzMyY2wydk0zU3VpeUZ1Z3R0RkRHU21zOWY4?=
 =?utf-8?B?cTlKWEpkNVRYTjdYbDMrRXJBWmtLK3JRcllaU3lzMUpITG1lWWpxUGxkMTRZ?=
 =?utf-8?B?VHRmYkdscGI2R09yOUlvaWNHamdNYlRNR3lzRjhKdEdXODFHUm4wazBPTzEy?=
 =?utf-8?B?emRzRExjRldydThkMFkwRk9SM3htZnRTNnp3ei9yZmdTSmc2WFdFM0NLMWVj?=
 =?utf-8?B?bHlsa0xWQ2FDcTBjTitWUVVEOUozcFdBT3BvbzR0ZFdrOUVNaHdZeUYvVXBX?=
 =?utf-8?B?emFDV0ZPd0ZlcTlmaTdRY0lRYmZRenNQcWFsa2ZPTkpLczFId2orbVhwcEcw?=
 =?utf-8?B?dDlBS1dic2toZ3VIUHQ5Yk10cjBWbytqY3lQTjZpVVQ4c29sYlNxd3ZTMW1B?=
 =?utf-8?B?UnQrUGhJN1FrWldWaTlRSGY5Q0JPVXNXcm5NMDVnK0V1S044Q3JHSzFNOWZ6?=
 =?utf-8?B?ZFk2azZJN001L1FnemV5akdyVkdCRklnTVB2NnRjV0VvU0U5T0JxakNpMjV2?=
 =?utf-8?B?TGNVVFlnS2VVL0piZEpNaFlINDh1M0J1Wkl2dnFqTERtYTZXQU9iUnhablR3?=
 =?utf-8?B?Q0ZxVmthYldCZmxEd1c2YzhkcjlHNWFMRkZwL3gwWHExTkpyQlFzN3BZMCtH?=
 =?utf-8?B?bDVvYThsQzhjVWtFWFA4VjVxaXVZdStnNE1Od1hyaDVQOGJSZnZONmY0amRt?=
 =?utf-8?B?ZFQwdnVGWEJWbXFRTERzdnQ5VTZuaXcrMTVvUVlIcTlIY2tYbktOeFlPVy9R?=
 =?utf-8?B?QTR0YTlEcThENzVTSlZXQmlXYjJxVjg3UFJieG1aTXZFTXRCc2s1WFVwK016?=
 =?utf-8?B?Uzh2N00xSFI3YUJHdFZmTmZsSDRNYTRCYkVITWtlNkYzVHVXVWR6Wjgza1JB?=
 =?utf-8?B?dlN4bGZYUDBmekIxa1lDcElic0JFV0lKeGRNd1kyL1B4ZVhKdDVPdGs4Tk1y?=
 =?utf-8?B?QW9hMkt1ak1qVzJsdXVvdUNlbEVlNkg3RHRidHRwM3dxM1ZiNTBTbGZsaDFv?=
 =?utf-8?B?TFZjbjd1OGQwNDJCaVZzeGxjZndsTjlsMm9OcTRVWkd2UWpKV3hMa2ZGb250?=
 =?utf-8?B?SWIxZWdxWE50UzhPZC8vSEszS3RmQXlVdnJlZi9jSDlzeVJxd1hnWWtld3Bi?=
 =?utf-8?Q?/5cuKxdStpXJgpZ/8Z++2/Vr3ggXm4XKzZR4FGN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b58899-063e-430c-765a-08de3e3b32cc
X-MS-Exchange-CrossTenant-AuthSource: FRWPR03MB11065.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 13:41:51.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10791

On 2025-12-18 12:18, Jeff King wrote:

 > In t5563, we test how various oddly-formatted WWW-Authenticate headers
 > are passed through curl to git's credential subsystem (and ultimately
 > out to credential helpers). One test, "access using basic auth with
 > wwwauth header mixed line-endings" does something odd. It does not mix
 > line endings at all (which must be CRLF according to the RFC anyway),
 > but omits the line ending entirely for the final header!

Aha! Yes, the test should be using *all CRLF line endings*, and is
poorly named. I believe the intent here is to test mixed *continuation
line* characters.

E.g, when a continuation line starts with a space, or a tab character,
for the same logical header:

WWW-Authenticate: FooBar param1="value1"\r\n
  \r\n
\tparam2="value2"\r\n


 > This means that the server produces an incomplete response. We send our
 > final header, and then the newline which is meant to mark the end of
 > headers (and the start of the body) becomes the line ending for that
 > header. And there is no header/body separator in the output at all.
 >
 > Looking at strace, this is what the client reads:
 >
 >    recvfrom(9, "WWW-Authenticate: FooBar param1=\"value1\"\r\n 
\r\n\tparam2=\"value2\"\r\nWWW-Authenticate: Basic 
realm=\"example.com\"", 16384, 0, NULL, NULL) = 106
 >    recvfrom(9, "\n", 16384, 0, NULL, NULL) = 1
 >    recvfrom(9, "", 16384, 0, NULL, NULL) = 0
 >
 > The headers themselves are produced from the custom-auth.challenge file
 > we write in the test (which is missing the final CRLF), and then the
 > header/body separator comes from our lib-httpd/nph-custom-auth.sh CGI.
 > (Ignore for a moment that it is producing a bare newline, which I think
 > is a bug; it should be a CRLF but curl is happy with either).
 >
 > Older versions of curl seemed to be OK with the truncated output, but
 > the upcoming 8.18.0 release seems to get confused. Specifically, since
 > 67ae101666 (http: unfold response headers earlier, 2025-12-12) our
 > request to the server fails with insufficient credentials. I traced far
 > enough to see that curl does relay the header back to us, which we then
 > pass to a credential helper, which gives us the correct
 > username/password combination. But on our followup request, curl refuses
 > to send the Authorization header (and so gets an HTTP 401 again).
 >
 > The change in curl's behavior is a bit unexpected, but since we are
 > sending it garbage, it is hard to complain too much. Let's add the
 > missing CRLF to the header. I _think_ this was just an oversight and not
 > the intent of the test. And that the "mixed line-endings" really meant
 > "mixed continuations", since we differ from the previous test in
 > continuing with both space and tab. So I've likewise updated the test
 > title to match that assumption.
 >
 > Signed-off-by: Jeff King <peff@peff.net>
 > ---
 > I do find it puzzling that we hand curl the credential, but it doesn't
 > get used in the follow-up request. So I may have mis-analyzed something,
 > but I really think that's what is happening. I can share the
 > hacky instrumentation I added if anybody wants to dig further. But since
 > the original was garbage AFAICT, I didn't think it was worth spending
 > a lot of time on it.
 >
 >   t/t5563-simple-http-auth.sh | 4 ++--
 >   1 file changed, 2 insertions(+), 2 deletions(-)
 >
 > diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
 > index 317f33af5a..c1febbae9d 100755
 > --- a/t/t5563-simple-http-auth.sh
 > +++ b/t/t5563-simple-http-auth.sh
 > @@ -469,7 +469,7 @@ test_expect_success 'access using basic auth with 
wwwauth header empty continuat
 >   	EOF
 >   '
 >
 > -test_expect_success 'access using basic auth with wwwauth header 
mixed line-endings' '
 > +test_expect_success 'access using basic auth with wwwauth header 
mixed continuations' '

Perfect! Thanks for fixing my poor naming :)

 >   	test_when_finished "per_test_cleanup" &&
 >
 >   	set_credential_reply get <<-EOF &&
 > @@ -490,7 +490,7 @@ test_expect_success 'access using basic auth with 
wwwauth header mixed line-endi
 >   	printf "id=default response=WWW-Authenticate: FooBar 
param1=\"value1\"\r\n" >>"$CHALLENGE" &&
 >   	printf "id=default response= \r\n" >>"$CHALLENGE" &&
 >   	printf "id=default response=\tparam2=\"value2\"\r\n" >>"$CHALLENGE" &&
 > -	printf "id=default response=WWW-Authenticate: Basic 
realm=\"example.com\"" >>"$CHALLENGE" &&
 > +	printf "id=default response=WWW-Authenticate: Basic 
realm=\"example.com\"\r\n" >>"$CHALLENGE" &&
 >
 >   	test_config_global credential.helper test-helper &&
 >   	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&

Thanks,
Matthew

