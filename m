Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4861EEB3
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220860; cv=fail; b=UJLjvBK/EqMDo9sYttu4zRzAkor1PN39WKTNyp5vCVZQE0jYaYlbFbt5TWc/E3NeshFCEe4kQ9FhpFG8QUaC228n/qonhaQUJpiXuJ0dRRJgO/y4djKd5TCjygT6NAonNGh6PzHg/uwskS3i44CSuqXEZtoYh+r09NXeMe6+dPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220860; c=relaxed/simple;
	bh=Lzwfu0Qi9KFvwbwa2iOU9VwIMH8b+2ImRMql8nhhw8E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uxYkNsOmhahlv0ZeHQp8HkWX6zHijXrHwvIM/3+K4Yv1pNuu3ZQq28xq+6EWQci8cL6bUIPfw+ATQ31JRcavv5Jw1i8et9OGkG+7euHFlfr9XLixPIKdU1bISpucVqswtOEkMXZqeMxY9ijE70TlR8leDKf5GsN0nk6QYBghptg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QZVdWJGY; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QZVdWJGY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOj8H9VJZPzScZovqKw5kk9LYfh5D5uDS8Hx1Ug1Z5ZnS7MsczFQG6RLHJWf1D3RoQE8Mp0dEGeORobydxCzYGaG9XdYBNMp8VNvW0aTr4AgygExd+8rGq35k3mSHe99NUyHb5w7gWIw7QBECOa1TcE45OmM/ppfod0CPnrfK/XGblMk1m8zAp0rXUc33jC3uVIAHGey+qA6qgazZoZwnGKl7o3ire5BAvWQQ/dXtgG7pslEnd+z062bWnq+kFeOxhzIZciTTvSsMFtjNx6e5lYZ9JowXmETC8Bz8FqfxjNc9Oj9uTNg3pJbop486/P0bkwv/H90Y/G3+2Q+osqRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHfuI/YK84Y7aAoyS/HVSQyjtpDkgTgIph+AfsqJ9JE=;
 b=NnZYjtaDEIz7FJQKQmqdKGHPTBvCwGNkX863YYmbGAIuc8ThY9uYVHgmuTGRTPygnJzl3GhdXM0GAnC4Sjh3eeKqtbGqGtKEQ9CPpSi5sH4PJ2+zhBKqTTHOWsN/um7JcWhJ7PDzECrLkeLYMEPFfcZaKzUsEtNE7+LWKLccuwDXmgenc7AXYB6Dh3sNvWeXyNxzh8/V1DkDNeokzfdqIsmx/Lg6dl4loFyYmAItpJykgmxaqhbL4++qiOjGp3XgORskM//tDFVHC7MR2XWgWZXhPIw+XIHUbqEb8Rku4vZpH/Fjze4zQbDfKeXQuvzgXdFPPKEcukUoU+IGqK1qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHfuI/YK84Y7aAoyS/HVSQyjtpDkgTgIph+AfsqJ9JE=;
 b=QZVdWJGYU6Z5+GXp4Op9it0kVfZ6u7xTcVV2tLL2l6UXoJjpyx0PPzdCtNtJJnefbxKlwL4SO1KC6PiOp9dKiaSUjGBz27ciw+zGFkgle86OyfV0+wAErqJ548S8lG/vTdi4USfaRJEbXgXkdMm9S6o7IsUKPaszT3nUuJmfEgrb6Z2gPjEDUFWmGszAzMNM9TwKijmD3swdZ2Uerj0cai8Hfhv+uCtHjr1Ln8Ef46Mln4DP60Su2hXQ0eNxYZuukb6o2APhcxNirDNSkmKQHzLavukElPPZgwOBZMt45nE1nXzpLjOdACg6/3aB7rRDHPcpam1Na3IeUam8yaWoUQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB11121.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 15:07:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:07:31 +0000
Message-ID:
 <PN3PR01MB959704D84DCD379442A9D053B839A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 26 Aug 2025 20:37:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update sendmail docs to use more secure SMTP server
 for Gmail
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <PN3PR01MB95973B72C16F68D63BE2B410B83EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqcy8im8zd.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqcy8im8zd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0061.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <da9d06fe-f44b-46a5-86f8-16ac79ce6ace@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB11121:EE_
X-MS-Office365-Filtering-Correlation-Id: d2879c31-4fa6-48c0-33c0-08dde4b2473c
X-MS-Exchange-SLBlob-MailProps:
	9qw5+ftluCCdsMVM4anb8CIHN7zzhZvI8X0/ZR5YauOFYs7Hv8rtNnttwdlzjSX/lEudnLy2WyhiNWyXgtOFHKt1bpng1OSxE2Tu4PtEGMfyP40qTQZZc4TXtRxAlZaC5Et/6ryVA66lI3/XsWMT6znDmIE4h8fbPixA6YoN2aUbW62Yob5a9v2f1o/NyUaG08JoU0rqM0v4SJEkXl80Jqxk998sIoZZAHmi5Br1Im2sj09tIdyeaCBvmjYxlscvEE6x85+GxDK1Za6bXVBIsClhwJUg2RqoYAhOh2oqZyi4oJYGli1GdiVnb0WoDoMCY0VddlVP1KR/U+5mD1Yo8MxK/iBmejr1P2MR3//akfjwMN6N/R9YyN9K4AECRByjzIiRSz4hDcCFgnnDYOt6DCGRHnlUZ9ePkdzmlz3beIqfp9aRmMP5FTOJxjPhRAMHYprDvpBesqeV8zylAH+0AhScZj6RAy7YbR4iwMPY7cUXp9DtKYWXrlHe+cX5yIVa8ijoFMiX/uCcpiOkw2ms+344+3ObXyBY94bqycyZYF3d7lnRi1rUBquVSuTLBzkbWJuuWWek0RvVCNWg9OxWxvq038T64v64+GGuvP7FpAvKD7F1iH8iszRK5zQRK8DNdnD3ix6mDWganogovW+CuW7mQwNMv/f09ear2dU+R+0eTt0hcw9tEvk8y+6sDp/qfwtzEWPu0Lk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|5072599009|6090799003|23021999003|21061999006|15080799012|461199028|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmwzV2NEU09HNGhPRCtPV1pCOFJ3cm1jd2hKSVRwcjBZM21rTWs4djNyZkRs?=
 =?utf-8?B?ZllTWmVYUE9rY09YMm9FSG83Qzl2SHRZVWxkdGhaVnE1MFhLS1NsQTI0LzRk?=
 =?utf-8?B?OEdKWGZ3RDFoWEN2MldadDNpaUlDeTg5eGVUa0REdThjS1JjRGhWWC9Bd2JC?=
 =?utf-8?B?UWhHcS9tVzh1RVpsUHZEOWtQSXYxcEdDVUJ6MDg5OHFtMEZrd29OVWVNWjBx?=
 =?utf-8?B?WkNIenllbUM0QWtWNU5NOVY3Tk9GRzZudGNtVzhuRnhjVW43VTZKZUZDWGxl?=
 =?utf-8?B?TVloNzBSVHpEWTUzNHlCaFR6NCtSZWpCNHB1WDI4UHFma0NCdXM4QVhXb3lF?=
 =?utf-8?B?L3FDWnhpYmNUVUhJTFVPRmxRbGR2QlJOcFZiMUY1dFdJYTVpSFBPb3Z4V2xk?=
 =?utf-8?B?MHVDaVVockJGWWh6Vlkvdnp6dGtWRUxERGpqNTEvWUw1eXNsM3p2Z081dlQ1?=
 =?utf-8?B?VEExY1ZtazB4dVpyck1CWVdVaTE2NEkrcGcyc0VwUXhBcnZkY29JODMxWDNF?=
 =?utf-8?B?RFBhN3U0cWxhYVg1U05xdUxpdzFHYkR3VzcySmxYRElYQSt2ekkyWWswV3Ri?=
 =?utf-8?B?ajJLbkNTcFV5UDVxaTVKWktOMzlFRDF6NEY1Zzg4cDI5QWNTQmFIMlI1YUlR?=
 =?utf-8?B?S2J2N0ZwT3o3bVkzemwzcFN1MDNiQmFUZ3phaXVHQ3kzRWdxZDdYb3h4YXQ4?=
 =?utf-8?B?MmVSNEtNQjJuckFrUnRjd3Q4L1p2dGp1Ykp2eHhkdkRxWVZwYngyQW9UUk5u?=
 =?utf-8?B?STVLeWlZNHg4RysyTXpvbStnaDlRWFl1NDlzaUZJNEkxRXlXNjVZSFZVS2NY?=
 =?utf-8?B?MnN0eFpVa0FqZVdkUk5kYmdKOWlhR0ozL3JmVVQ1aEN1RGFodW5iTnhiLzZN?=
 =?utf-8?B?THk1Z2RsK1NmV3BTUGJaclhYWVY4N3RZMVpSb01nb0VHU3Q3YjNDOFczdjRK?=
 =?utf-8?B?OHFkUU8yRzUzM3hyVm5LR1dHNldKb0FWZ1ZheVJwcWZqbW1WWFlTdm4vNFVx?=
 =?utf-8?B?M3BmVElrZldhY0tSWTBhTk1OVEN4S2QzYzR6SElXK0k3VEZYMnlKSFE4OXNS?=
 =?utf-8?B?OXExN1EvSzNkTEUzTk1LNzJXNThGdVRGd0lROFRYQmNFSGRPWmRnbGw1aWZs?=
 =?utf-8?B?U0s3cTFyTmY0N1E4U3hkRnhHOVZTbk81YTgwR09LcFVBVTJienBzaDlSdW9o?=
 =?utf-8?B?aVcrV3MxdkN2b2VOSS9YcVM5VE0rbkU0bVR2NFZhUjEwaXNWUmpSZVNJVGZt?=
 =?utf-8?B?ZkpkMmU3aU9lMkx4c2J4YktqTUkyV0tsYlJ3cU9wZUUyQlZmOEljR0pPQzVw?=
 =?utf-8?B?THNOMkhTRDBDTkhyMWtxNnF3Yk54TU4wNjJPaXhjQkpPK0REOGRNSzcvblQ1?=
 =?utf-8?B?VHdJalpXeDVocnJtR2dkNFQwaG5FSWVoZDlDckdKVFIxekJZT3lKSThobXhO?=
 =?utf-8?B?Sjg2cENkSlY0bjgwa0ZFc29HQWdHRXNYRlBIMnE0amZhckpwdWR1LzBmeEVt?=
 =?utf-8?B?a2lDVW55bDJOMjcrMG1GL25OTFhMZGFyeUIvckVnSmF3K1dIRzNPb3pVb2dq?=
 =?utf-8?B?bFptNUNlYlF1Zk9RdVFodkxCVjNZNHNlcnErbHh3RFNKamdJeGxVaDdqQ1dj?=
 =?utf-8?B?bmpVbHJaK0JBdEJlUG1VUGIxN01PTVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm4yOG9KOExBMXovelVCNUErVUpIK0tyWEZZajVFa3JreDdLSEFPSk84aGhu?=
 =?utf-8?B?Q1ZkMzA1dWFEaW9zTmMwWnhhRWNuWEVPdGhtdm5IdEsySVU0eTdxSWVDOWJ0?=
 =?utf-8?B?UDZBbkJmK3JIbDBwd0llT2ZsV0Q2UXhZeXc3eXdmLzUxOXhvTGRiYlZMbUpY?=
 =?utf-8?B?NlZIQXhYenZSeVF0Z3lta1dEcU5mNTk0WHBMeTQ4ampDdWRyNUFhM3B6ZHhy?=
 =?utf-8?B?aUZEbFNwa1doUnJ4cllUTVRiZTQrTHhCZXh5cUpveGo2c3l2YkRRUXMzcWw1?=
 =?utf-8?B?UHYvYXBqV1JmV2J0UEcvejZtMnhDMTZmemMwM2JlRHNwWDhST2U1dkxRbUlU?=
 =?utf-8?B?NDZrK1NUNk9ncGh5RXVOSG1JYXZvN1FGQVlKNTVvZTk0Zk1TTEdSbGlzNld2?=
 =?utf-8?B?ZnA0S1llMGhrUFNiU2YzaVRnbisva1UrNjlhT2lMUEhpeDB1Z25ibmFrcVdP?=
 =?utf-8?B?bnI0aDNBVXllemRqMldqU1VHZ3ZUOUlNb1FEakJ4MjBWd2FldzEyUkt2TGRL?=
 =?utf-8?B?NHZ2eWEvdEhSL20xZm9XTHVhUGpJTm1WSmRJdUJaUEdGenNPLy9tajFqSVp6?=
 =?utf-8?B?cFZiOXZKU3c2VnNlNG8rbjdYcHBQbmRHQ05NcThWWTRacE5uTW95KzVqSkZq?=
 =?utf-8?B?TGNjQ1F1a2phRUZ1Z3p1K1hEVy9xTy9pMEZ0VTJOM25PZVhKNXFWU3puY2ZP?=
 =?utf-8?B?bEtZQkoyZmtyOS9OeHhZSlBYT09SM3dOcEV5azcvSEw2eWMzVnljMWRycERT?=
 =?utf-8?B?UGZsaldOb3FGeTROQmRxVTVKWFN0NDVCS1g4bDRqYUpBUDhLUkJVek9UZVBt?=
 =?utf-8?B?N2liempXWXltQiszWkJaczFCVU40YVg5Y3c2ZDVtWVUvYXpidjYzTkF4WHpz?=
 =?utf-8?B?R3FJR0hDNFptMUxsYWxKaUpSVkFsbmpCR3c2aUNDMHJrTWJiMHZhWGJUTVo5?=
 =?utf-8?B?REp6MWNTUjRwUmJ2LzE2MVRzTlBCUThZcFNXWERkS2Qwc0djamFCb1pGeE1Y?=
 =?utf-8?B?N3JyZVRobGFmWW0zZE5rSjJGaWQwTG4wYjZ0aFFlcnMrR0h6MHJHSjYyT1Z1?=
 =?utf-8?B?dlhYS1FuVXRaak1FbHpwZXZyTmdzVEtvUHZKNXB6NUhFUnpRV29rQ1VHQTY5?=
 =?utf-8?B?UzVGVlhjazVQanIyVlZKWUhpOHBRTnlmWnF0ZWhzbnRtY2J3ZnVpSUlpdGdr?=
 =?utf-8?B?ZHlBTVlDS3VCcndOdE5hNEtVb2RocnE5SlNZd2ExQ0YwbWNRMmdPNVYwQkp2?=
 =?utf-8?B?QnVHS2lZaUVxUVFyQ0QxQmtFRVR1TityNlA4NUxpMnYvakVIejBsckI3U1E0?=
 =?utf-8?B?L2JubVBPQlh0akR4bEcxWVRYcXhKTE1OazlFZFFFaWFjaWRyTi9lYVBGODA1?=
 =?utf-8?B?WEZwVTZhLzRmNWp6Y1NrUFEwbjVtUkJpclZYQ3AzeTRLU3g2eHgxWUFsbzZ4?=
 =?utf-8?B?TFRjdGxHdUFzSFJCcy8yUjdENnMzL0FWV0tHTkJjSnJ2RlhVcW5RbXg1N0Y0?=
 =?utf-8?B?MEJCeGROeUJLY1d3L01VS3pydXRkV0J3dS9MazZGVEZNYmhtRHV5Ui9aT2l5?=
 =?utf-8?B?VVhYVTZCQkZjMVYwdldXNWZkSklsUCswRng2eUppL0Fibmh1cDltV05WWldn?=
 =?utf-8?B?RnhVV1RNVW9IK2pER1poc2lMNHBnK1JXM3NMaTlIZXBvdmpQVnF4UWROekRT?=
 =?utf-8?B?OVNpWUZZTGxXblBIR0MwaW1zckxVU2kreEF4TXRXeDZBYk1LZnU2cExDSTR3?=
 =?utf-8?Q?EuHNqADSqf55Nb+fPw=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d2879c31-4fa6-48c0-33c0-08dde4b2473c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:07:30.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB11121



On 26/08/25 8:21 pm, Junio C Hamano wrote:
>     Earlier recommendation by IETF with RFC 2595 was to deprecate
>     implicit TLS in preference for upgrade an initially unencrypted
>     connection with STARTTLS command.  These days, however, IETF
>     recommends that connections be made using "Implicit TLS", in
>     preference to STARTTLS and the like, completely reversing their
>     earlier position, in RFC8314.
> 
>     Update the GMail example to use the implicit TLS to match the
>     current recommendation at port 465.

Fixed in v2

