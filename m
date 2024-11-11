Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020078.outbound.protection.outlook.com [52.101.191.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CC1EB36
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360153; cv=fail; b=pCRGmN3ICmVDIANGcAy2fuQPM2lwYA1bjHlqYfUpbJkB7muUfnVSmiCURNoq4ttrsLCCxzkhnbo4SIQq1TpuoTofK5IEy41aQzgN2YaS8Z6vQiwD1LEnTVSTBsXhOOfCW76AkQ/EHWVOQqCs9MUf4cqiqIKrZrKrmaPjWLRiCFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360153; c=relaxed/simple;
	bh=VEgHtBnlk0iC7shSK79R5587AQWbWRLCPPjUGYTTQGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mn/IiehaZ5FIYNTfAu2jNHYQG5qOdC1I7kYtmLmij3fd8s2VeHr+8mvkdpuO7UuxCeGylvG0ImRVDeWdOO29twv1ECqtzS1zFpDdsyLKQSDvgeoAWDqCzSzws6v1pHsSYb4lzd0CCM9GnqXtSG3zfx1Xy5+Daw7YziqfGGHPo24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=soHf903b; arc=fail smtp.client-ip=52.101.191.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="soHf903b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3EN44Od44jtxFX4ZQrvX5+pzpIz4uuB4cAbuudvQtWz6sWDwZsMgV5GDO/Lk0BhnMqJgvLEGVkTgPubwL8SqOizBvZObVkNJWS7u3tW66b+86LFCG7A2o5UWFA4NWIst/cwUco7YEw8Ki13GOlNR3V2DcyM/HpPOiW9CuxYNpkWFw/+YucGsITJiAG2Kn2ltKHfba1t7JMOwkZggHjwkiY74g8IUZgggPlkG8dVyJg3rFkW9g9KecT+xCat0yqLaWtslFNxOxuXcn5zQIPqVPMJ6rLpqgWod2AqoIkfyOyNe8zw+Fvy+1kI3GSfwTbwEMoofahdkMoQPxqRTvXk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/68LOC067WNZ0QPavSyRB0kdBwoiES2WJEuwI9HeO3k=;
 b=Ja15r1QXkS0LKolm/Zj9lfQ4JiDHyKI9/xnKmPqMQTQ5WZFruVxsOi5iZmGPH7n74Xrc1A8dOCJxsIRA8NXkUSYpx5JphwJU6D8vTfp1YUmibEpa2WMicPP09719BGPRHSU3aZ2Ylg0YMuwx4gmAlWN1HPet3VVKfnQXDT8i6F4XtGAEelM9NzvDZeEyHafyX/7vpYOy4JZj8Fulo6k+CkFBTIM0aymJyS/Vt3fkExBClAm0OlMWyZKSHYW8ovMs8AmjJ7BJ3bbcH/fSckI3MSUvyY+J0aNUG43EhphJefM61gmVcC4cCSSwVa3uc02uj5uN4ssAwm0REVlP+Qp7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/68LOC067WNZ0QPavSyRB0kdBwoiES2WJEuwI9HeO3k=;
 b=soHf903b9XjxqKNj8hXaNRs72ZkNjECNWW8veqUolAfdq6m5ojHdC5ajr76Mlk+1nqPbE//mtv73WycarF01Z9s++794u5vQlsoovbXWaPSO8z+VmPrNGdzuBVnhcXeB8YoMS3707PA29ayFcG4wgqA0x1U3lPh1Z2uFL2FxtVhdcdW7h9wRU/boAci5mUX6wqDCB0IIeXBMbNFljA9QDG/wfRZ9Eeh4lJaQ5Tf3CNguBcTDthEpTQ6ysoW5T7rdDRfmls9ly8gO9Zr9CTE7yygIQ3uLDwhKN9yAca8HGIHHlTQ12iwLthgDl9y2bFLIdbshCT230PMRuGMNCzcaqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PPF061CB2B82.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::406)
 by YT1PR01MB8844.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 21:22:27 +0000
Received: from YT2PPF061CB2B82.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aaf2:73d5:542d:b917]) by YT2PPF061CB2B82.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aaf2:73d5:542d:b917%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 21:22:27 +0000
Message-ID: <09bf8815-320b-494a-87c4-34bb0df08595@efficios.com>
Date: Mon, 11 Nov 2024 16:22:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/difftool: intialize some hashmap variables
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Taylor Blau <me@ttaylorr.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20241111162148.337375-1-simon.marchi@efficios.com>
 <20241111205453.GA5019@coredump.intra.peff.net>
Content-Language: fr
From: Simon Marchi <simon.marchi@efficios.com>
In-Reply-To: <20241111205453.GA5019@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::15)
 To YT2PPF061CB2B82.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::406)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PPF061CB2B82:EE_|YT1PR01MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: b0619ac1-6e90-48ab-2628-08dd0296f179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0pxTFB2TnFFUzFBVEUwRkNmL2d0cjJzQSs5T2QxVDBLdEFtNFlRRDhpREtm?=
 =?utf-8?B?eDFmaVVPMUcyb3NYVWZBUGVuU3R4MnNNeUZyU3U4ZnVpRDNGVG9WTEo4OU9H?=
 =?utf-8?B?SlNhK251Snc1K2g2R2l2VVlBT29IckFVcllyWkFVUUlEY2N1T0lXMDJjZ3VH?=
 =?utf-8?B?c0xTMEZDSldLMlRycXBoMDJiN2ZOZmxVRFlCL2dzTlcvQ0NpVDBnUXNXMnpl?=
 =?utf-8?B?dGxlZzZ2QTZGOVp4bGs4dC9tMXFHQW1yZzY0YXFNSHkxcHlwNjNrSmliSmhH?=
 =?utf-8?B?WS9CZ1RTVW1GU3hZTk05c2tyUFhWZjdnMStoSzl5QVRwNmlpbS9ZUXRHN1cr?=
 =?utf-8?B?R1Y3S2h6TGtPbWFpdlBuK1ZKUzlpMUFMQnY3OXllTDl5V0cyVG5Ra29qdVUy?=
 =?utf-8?B?ZFNzVEtLYi9yVmNmNmRKL2Y4eFFZRjN4dHBHVFdxN1ZTMk5WY3A1VTh3YmtI?=
 =?utf-8?B?VkJENEwxcEhlNXBVb0pEcWxJbW54MEVZRUlXWkl0OUo3Z2ZqVkpobTVTVjMw?=
 =?utf-8?B?d1EraFBoZTZRWGhEeGZTMlZ4Zyt4SkRvV1N3Z01ab3dNYjFOdlhhNUxiV05B?=
 =?utf-8?B?OGZGdjV2bWM2a21OM245VEg0bjUxWVhVUlhzcHEyOFlPWDNzaGRrQ2tUY0x5?=
 =?utf-8?B?UkZveXpTeEczRktZRlUreDJFUlFGZHNTdEhFRWtOdnJrUklEcXFXVXBQMTlS?=
 =?utf-8?B?cy84SUdsWHBGUmZLUnQ1cjhzc1dzZnNXQUw4Mnd6ZEs3elJ2RG14eTRwdVh0?=
 =?utf-8?B?S1lWRkhDTzVsSW9oOXBvTXQ3SDNTN2pmQVNaemlqcERWWkR0OVBuemwwc0lH?=
 =?utf-8?B?RVZFbkMxZzQyQzdob2pHQmNXTkh6WHFFcitHalJDT1pDS09LbUU5R2RCQVlN?=
 =?utf-8?B?aW9SdWR1ZkxKOUZYYnd5eFI1SmdheDJjS3Fia3hWTVJwcXVWT1ZOQ0dHdUhY?=
 =?utf-8?B?d29zZVdyRzlsZkVLbzBabkVoMW8yZnk4SXNCcHJzQldpRG4wblR3VVpBa1hx?=
 =?utf-8?B?dVFiYUFhM0UwMXRmSVFFblF5T3JUb3FENU1WNkMwUXVCL0JiVFhMUmRjUFFs?=
 =?utf-8?B?OG14d1QyZFJMMExibW1ZM2Y4NThSNUlQaEg4VmlSeW5tQ0FFbVFtUVZoeUd0?=
 =?utf-8?B?cmRIajBJRmMxUHdmUkJpTlJodklyaW1rUHF1ZkdrTjZWSWN6TjN5U0gxM0Q5?=
 =?utf-8?B?dHk1S2hkc21mNTNUeHpabWQra2hRVjQvZDZlc3dwSlVUMnZxT00xTWR6YUFI?=
 =?utf-8?B?UHdJTEdwcDQ4YTVIQThHc2Q2bm9LbUJRdWYyeXdzNXVNZmdmU2thaENhNjJp?=
 =?utf-8?B?SjNOS2dhV3hjMXdzaTlicmhCN1ZpVVNha25JMjdhZ3JTVGpqamFGRTVPMGlM?=
 =?utf-8?B?ZEliRlZqbEhKNHViK3g0L1dSUWtZY21aVi9DOHdTeHNmelRMUHdxK3JjeGtB?=
 =?utf-8?B?R2tKcDBmNjNkZmdocHNBREdJQ3BzSkVWZEp1S2txRUNmY3FWdjdjV1dwMUpG?=
 =?utf-8?B?Tk0yREowandWVTFITHB1VU5UVk5BdlBMZFR2SmlxbDRTbmFXenFncHdZY25j?=
 =?utf-8?B?ZS9ZUGhpT29UZFFyNFhZRi9paEtPZ2pCWTE2eWNyVnZRWFVXcktFeVJPaFlN?=
 =?utf-8?B?VUZyT2VaWlVleTVoWHJOSlZXZGFaNnk5V09RN3dpdnJWQjM5Sll1a01RbTV4?=
 =?utf-8?B?SkJGN1I4VUVhcXBjdUZBdDdlM1FkVG5JbnJ5dUw4VERmbGRaWC95UU55Uldt?=
 =?utf-8?Q?otHSDM9qWzmwHZVBD7pv7J1VATN7HOxaQkcKwvT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PPF061CB2B82.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFRzdzJYQ1lobzJmWlNQZUd6emQ3SFV2cGl4VzVhVkhRYXE4dVNxSUZRbTAx?=
 =?utf-8?B?Q2VXSVpHODYzZS9BUkpMQnRPeEkzbUZmbWIvVnQxZnU4WE9KYk9WTWgyejVI?=
 =?utf-8?B?Yk5DNDg0TGtqbHF1Z1VNNU92OGdQYWFjOGtpaDR4QjJBd2dTOFd4Qm1qdEh6?=
 =?utf-8?B?d3RWUGs5VWJybHREN3QrQ2c4d0hFdmNPZkd0WWtBNWNUWWNKUFM1UW1FQU9D?=
 =?utf-8?B?ZDFUemFVd3VoanlleTVraGZ4MjZBa09adjF4TmV1TnM5a2dTMklraUg4ZXBU?=
 =?utf-8?B?NmFxbmR5Nm5UeE1DUGZBc2FaUmN0aG1DT1FHWmVobEc1R3RHOG5ZSjFpd3Bo?=
 =?utf-8?B?SERVY3RMcGloMkdydEdtZzFoSm9Sd0xKaHNqOCtoejJISGRYazNMandDbUxi?=
 =?utf-8?B?RFJ4SHpIcWdBdEo4WHFNZVBYM0ZpV2NTdEN2cDkzK1BYdG1kRFlTRUV6dmQy?=
 =?utf-8?B?Sy9UMEY4LzRmc0dVZ29JMzJOL09vUVJuUW5MUTFHL2p0MjN0RStFcVdLMVQ2?=
 =?utf-8?B?M25pWWVUT3FhNi9Sbm91ckFlNHJKYTNFeFlaN1h5ZEg1ZU9GZjNyVGFsK1VO?=
 =?utf-8?B?THNmMC9zQlc4dFBLcDF1enJHaDNNRXc4VVZYZE4yMHRyTmt4VW5ZZWJhMXkw?=
 =?utf-8?B?U2lCOFNmSmRwQ0pjNmF6UGh5VnpnTzh0S2pOV0NQOVd0T2lyeVhvU3hCMFNY?=
 =?utf-8?B?dkkvQVhmdUtNa3NaTFhCODlzOS95QTlQUmorNW1BR0xiZ2dCT2srWE0rU1Ev?=
 =?utf-8?B?OTFnMXNwVWVodGtJOUIycHFqWWNhdUFZUnVWNHRwbStwQTEvbTJuTDFGbTE0?=
 =?utf-8?B?dWdDTVVaRGcyVWRVNDd4cm5tWTdwZFArSDd0UUNmV1FscFp1N0Rsd3F0YVlq?=
 =?utf-8?B?amFEWmVGYXViZUtESFN1RDFvNC9GeEFPQk9GcUdZazU5MS9iYXR5THVWNUly?=
 =?utf-8?B?S2V6OWRRZmdFakV4amRYUXM3RytNenFtT1dhbWdySlZEU1FRenRrUUx6NXlN?=
 =?utf-8?B?eEI0WEdJZm9XVlVPK290MFFZWVlDS0pjSDVEOFdmY2x5cXk1cEdHRTUrc2g0?=
 =?utf-8?B?MDkyajM3M2NGKzJhYzB1anJQNVJZZFJ3dnlwakdCdTFVdHJzWUxxVFRrZHpt?=
 =?utf-8?B?dCt5cDEzWTlSVnJ6WDloL2d2b1VDSCtSZXJoelBuSlprKzlxUDlaak5vdVFW?=
 =?utf-8?B?RmZkNTFIcnhxb1RIMVljVWpJd3hyMFVoMDlFbGhOUTRCOW9aZkRuYWNTc2h6?=
 =?utf-8?B?a2lMYmJ2NEJ1aUtIYUh4akdQcTVwdmt6Ukl4dXRvYWVQSUdCcGJYM2g4d2pL?=
 =?utf-8?B?SkRJQmFhQnd5M0RVUk5WaE95VWFqODZ3dVZ3VWlwRmg2SWt1eVhwQkgrMjR0?=
 =?utf-8?B?Qm45blJRQkdFYVRpd0llVHFBQ1dBdkpJb2U1akdhQXJ1U0wyTHJNeUplOE42?=
 =?utf-8?B?Smc4MEVwMW1HaDdRalhEWWNXVDZrRWpGMUE0Y3pTRUZ4cXJBWHczUjBWejc0?=
 =?utf-8?B?TVJaRmlidEVWQ1haeTUzVlZKaHQzNDlTem1tMVhSdFJvcFU5UGdKc1cwNU5w?=
 =?utf-8?B?T05iMmtHd1JWazBvK0EwN0ZGWEJSSkM1Z1c5MXc1WXNTc2tKRlNxeFVMSkNm?=
 =?utf-8?B?Ry93NjRKYTQrZ2hHQ1Y5eDQwdUtKZVhtQm1adW5OeEZkQkM0MCsrUEdpVHFo?=
 =?utf-8?B?WnJKNUh0a0VaWGtLR0sxd2xsYU5CMjVTR2RDVU9uZXRrWHVQbjRES2FSRCti?=
 =?utf-8?B?TlpwNTBkTzVVamlLcTFmU01YajFPeHhTOGRxVjllTmFhY3dvZTcwWkRlZU9C?=
 =?utf-8?B?bStwN2F6c0h1cHprNjlwaklXc1FSZWVJSGNpcHJWQm90ZHducUoyc01nalhp?=
 =?utf-8?B?elgxd3gxL2hQUGxuVlhzaWdHQ0RUN3k5WDYyZmNwWlAyZFdramRPRGEyaFor?=
 =?utf-8?B?L244YnhoQVkyWEJSN2dIK3B5bGI3Mzg0K1hOUGFWMURmYVQ0SXpoenh6cUFo?=
 =?utf-8?B?ZCs3bk9KbGR3ZEFRcmgyNHFLN3Z6d25xeHNmNVdoL0tJajZHd0xuVHNPcHd3?=
 =?utf-8?B?UXViRUNqV2J6TjlTLy8vYXJNdVBQNnVEcStjSk9Kb0xCRTIxeXcrUDNwR1Jj?=
 =?utf-8?Q?u7yvKQYZuNVnWwP6E2I76pxI1?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0619ac1-6e90-48ab-2628-08dd0296f179
X-MS-Exchange-CrossTenant-AuthSource: YT2PPF061CB2B82.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 21:22:27.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBHgGrdI5rAuoCLLa4WNrL45FBz26TYOLHuG0qUiGBfDsieASL+dNTXVzLgDCVUp1ZqIRr9Pa40gLELQrWF0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8844

On 11/11/24 3:54 PM, Jeff King wrote:
> On Mon, Nov 11, 2024 at 11:21:44AM -0500, Simon Marchi wrote:
> 
>> When running a dir-diff command that produces no diff, variables
>> `wt_modified` and `tmp_modified` are used while uninitialized, causing:
>>
>>     $ /home/smarchi/src/git/git-difftool --dir-diff master
>>     free(): invalid pointer
>>     [1]    334004 IOT instruction (core dumped)  /home/smarchi/src/git/git-difftool --dir-diff master
>>     $ valgrind --track-origins=yes /home/smarchi/src/git/git-difftool --dir-diff master
>>     ...
>>     Invalid free() / delete / delete[] / realloc()
>>        at 0x48478EF: free (vg_replace_malloc.c:989)
>>        by 0x422CAC: hashmap_clear_ (hashmap.c:208)
>>        by 0x283830: run_dir_diff (difftool.c:667)
>>        by 0x284103: cmd_difftool (difftool.c:801)
>>        by 0x238E0F: run_builtin (git.c:484)
>>        by 0x2392B9: handle_builtin (git.c:750)
>>        by 0x2399BC: cmd_main (git.c:921)
>>        by 0x356FEF: main (common-main.c:64)
>>      Address 0x1ffefff180 is on thread 1's stack
>>      in frame #2, created by run_dir_diff (difftool.c:358)
>>     ...
>>
>> If taking any `goto finish` path before these variables are initialized,
>> `hashmap_clear_and_free()` operates on uninitialized data, sometimes
>> causing a crash.
>>
>> Fix it by zero-initializing these variables, making
>> `hashmap_clear_and_free()` a no-op in that case.
> 
> The fix makes sense. I wondered if this had been broken for a long time,
> and if so, how we managed not to notice it. But it looks like it is a
> recent problem, via 7f795a1715 (builtin/difftool: plug several trivial
> memory leaks, 2024-09-26).

Are there tests for this specific scenario (no diff between the two
versions)?

> 
>> diff --git a/builtin/difftool.c b/builtin/difftool.c
>> index ca1b0890659b..b902f5d2ae17 100644
>> --- a/builtin/difftool.c
>> +++ b/builtin/difftool.c
>> @@ -376,7 +376,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>>  	struct checkout lstate, rstate;
>>  	int err = 0;
>>  	struct child_process cmd = CHILD_PROCESS_INIT;
>> -	struct hashmap wt_modified, tmp_modified;
>> +	struct hashmap wt_modified = {0};
>> +	struct hashmap tmp_modified = {0};
>>  	int indices_loaded = 0;
> 
> That commit likewise frees some other local variables, but they are all
> properly initialized. So touching these two are sufficient.

Indeed, I checked the other variables, they look fine.

> I'm not sure if zero-initialization is being a little too familiar with
> the hashmap internals, though.

Up to you.  In other C projects I worked on, it was typical that
zero-ing an object would get it in a valid initial empty state, properly
handled by the destruction functions.  This way, a big struct containing
other objects could be initialized simply by zero-ing it, without having
to initialize each component explicitly.

> The other variables use HASHMAP_INIT().
> Should we do the same here, like this:
> 
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 1a68ab6699..86995390c7 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -374,7 +374,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  	struct checkout lstate, rstate;
>  	int err = 0;
>  	struct child_process cmd = CHILD_PROCESS_INIT;
> -	struct hashmap wt_modified, tmp_modified;
> +	struct hashmap wt_modified = HASHMAP_INIT(path_entry_cmp, NULL);
> +	struct hashmap tmp_modified = HASHMAP_INIT(path_entry_cmp, NULL);
>  	int indices_loaded = 0;
>  
>  	workdir = get_git_work_tree();
> @@ -594,14 +595,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  	 * should be copied back to the working tree.
>  	 * Do not copy back files when symlinks are used and the
>  	 * external tool did not replace the original link with a file.
> -	 *
> -	 * These hashes are loaded lazily since they aren't needed
> -	 * in the common case of --symlinks and the difftool updating
> -	 * files through the symlink.
>  	 */
> -	hashmap_init(&wt_modified, path_entry_cmp, NULL, wtindex.cache_nr);
> -	hashmap_init(&tmp_modified, path_entry_cmp, NULL, wtindex.cache_nr);
> -
>  	for (i = 0; i < wtindex.cache_nr; i++) {
>  		struct hashmap_entry dummy;
>  		const char *name = wtindex.cache[i]->name;
> 
> That loses the initial table growth that the original had, but I think
> letting it grow in the usual way is fine here.

I thought about it, but was indeed afraid to be told that this removes
an optimization.  If you think it's fine, I'm happy with it too.

Please let me know if you want a v2 or if you are just going to merge an
updated version of this patch.

Thanks,

Simon
