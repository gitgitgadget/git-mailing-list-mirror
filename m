Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013013.outbound.protection.outlook.com [52.103.33.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0663090F4
	for <git@vger.kernel.org>; Tue, 12 May 2026 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583049; cv=fail; b=Hxwt0cXWdrqjyT63eYj5VQCZhACwvo6j+VogzP9AwYjRkuFePcYKjVtbQCB2TIAgOmwiiLQZlhGqkzo+z6vgqELRtTco5snSLx3+ScBqIJ0xzDRCGaMYnFAz8wtzsC7OgOFqGJF53wlq7yp8YrF1eDXX5hEHoaSyUbfZV86iKyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583049; c=relaxed/simple;
	bh=5AxnkU+xln6oAZhCP846WkT1hhDozhist9we5wDhEMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QMhuyBaqVT0bZvpgudI0UMfOtXxO4YWXbkcqM9zpqbAO40SjIQzXXfYQqwUKxr2FNWxICyqc9Ya7p83sDDfzqmixiMyG5Rtl1mm8nI0ma/ZUA/CvmN4Qt/vVhPlXHtmW6VTHdxyrQdY9feM76E6NEIZrrvKCMtVT+oCFK+sqNHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I0U4oyIz; arc=fail smtp.client-ip=52.103.33.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I0U4oyIz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZsKHwlgi6kFmu7omebWXRaBkNq7Imbw6FYT8EuO1TFnCAbD4+VWUXscj7QTk5YFcsNW0mkhdE7gys9oU7eirSTvZUF5TTTmewysDQ4zZgZjzWzlKJmfVUEIewzI66VnT/IJVJRVEInLKyGP395AH3KCxErS8/RNRJewYrimqWlYwdYY6mYM8wlt9qWAB6GWAd08gxDb2kkqtj+gxtm3qoeEo+9bw90VbMGg6lOz167QZl7JF3b5hWWRAsB+96papWMPv1DfkKsoEN2511P0jqCTowl+IiW4utKEtGM6ur9n30tx3NuZRPE5GRUrfx3TdfbIlqLCfWqAq1Ad9XTGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HwYHQ19xFcPC7xgOV82OXwcP7SUD8CD330cXP+u6r8=;
 b=MBpRc4rkUKw5XwT5+POsdbHEcBW7QO6qe9aQHG4MxqrySq9rqvmXfNCwXxTfZhDC40ZOyyWr6RpmW/VGUJekGrcdVNFQAC9E3Z9v+x5QbdzIqHZYE+afA6tgWjoblN04lBe6cNleScwyUSgoBH9k7GmNBlpX/Tq8sn3+rw+Rv0jYCFTCHjOsrHxZtiDntNGQci5TIVj2KfOXWiYZb/O1Xni/wzdE/792QhojHwEx0++ZfYHd2H8ZBdN2eaR926aYs9KaRHsKm+ML9+8DcwVYSz+whMRL0e0fmtBwPNSIzzNoOaJZ2/0pszWAUt0CzZItd+bXzFT4gUImDK4noCtpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HwYHQ19xFcPC7xgOV82OXwcP7SUD8CD330cXP+u6r8=;
 b=I0U4oyIzovDIIVJnLcISgxIzepqreI9XvAidTYhOxpFQWPfttX3kMwgWfGZpxF+6yeiOD2lYLCtJnlPs95hgP831xhV7LiR4IBOITgXe6pDioNR3sG+5EXpe9apPBOUn/6FzobxAHwJ2FJbA7XjmrVWJl5ACpiI6zaV/Dq3od6P/Ov32LkuvguYWTvNm/h5I7A1G4FAEFQKmn/iIm4WN7JdDiMaBy2gKVqIulIn3ikyGVKCieU0+s7BgkFWeaVUbGYbuGzuQYHVYAXu35ShvPPM5wxh+CaGVZiO8DkMQnhufZNYmtE0FZNRmOPsQvehpTH0b/SrPPqW7ck+hGoVnbw==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by GVXPR03MB10708.eurprd03.prod.outlook.com
 (2603:10a6:150:21a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:50:42 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 10:50:42 +0000
Message-ID:
 <VI0PR03MB11634950671960EF7C54CE0ECC0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 12 May 2026 11:50:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] t5516: fix test order flakiness
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <466c56abe002ed2ac8cf0da2d6d1d8c288cd232b.1776871546.git.gitgitgadget@gmail.com>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <466c56abe002ed2ac8cf0da2d6d1d8c288cd232b.1776871546.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::19) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <02ad0c9e-122a-4bb6-ba17-e99e3c29a52b@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|GVXPR03MB10708:EE_
X-MS-Office365-Filtering-Correlation-Id: c7104e06-cf27-40d2-de35-08deb0145007
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|5072599009|6090799003|37011999003|23021999003|19110799012|15080799012|8060799015|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnNtTGRvamtvTlVRUFZ1aVBtSkQ5SDg4dGFrSXBxT0pPck1FOHhyd3R2QW16?=
 =?utf-8?B?T2s5THdva0k5S3ZzMGhSclhOL2xTQnBaUWh5TDQ1Z3Y4bFREMGNtNytPOGZm?=
 =?utf-8?B?WC9iZ2kxSlFBOFVXVlVLZ2R6b1R1OGtDZkFSaGNNaFh1Qm91TTJhK0N4MmZs?=
 =?utf-8?B?ZDhycExHY2RRRWpQNXozejdLcmZ2VEFGb3c0bGdRS2xtTUtTTHFpTjArY0tm?=
 =?utf-8?B?bEFJQ0RIcUV4U0V2VXZVeVBpM0RrU0crTmpMdmVkaVcxbWtoLzlIb0h1cGQ1?=
 =?utf-8?B?K3FibmZDbzR5WVk0TlJJR0NxMFZBVnZReERJMHFVNVBUTXFxRlVybHgvRjMv?=
 =?utf-8?B?Wnhna2RHT2NkTTlkQXQ2Z0RnUEdJdEJoOVBpOG1DL0Q5MkJ5aHkyT0tyUVhH?=
 =?utf-8?B?cng2QXRMUWZQajFNNldoWHhJVFJyYUt2QnFkcFIzTHEvQXR6dnl6eit0NWJP?=
 =?utf-8?B?UXZHK0lIc1FNYzdwRFBvc0MxbUh6VGFRZjJlcy9vTnFMMDhUV0tYY2pCQkxR?=
 =?utf-8?B?OGllZnpsM2xVZVJuSUtYdkIvOXMzT0JTMURVU1BZTkk1R0RyaEJDaVFNZUlv?=
 =?utf-8?B?aXZVcDVmSmMySkY4cEp4U2UxNll6NGppcHc4T0hZNmhDd3kvbnl5SGpDNXJ4?=
 =?utf-8?B?VEQ4ZjZmRHNaT0MzZjErYlI2UVBuNy9TbEVqM3IzTjJRemVHdzdOYnZjRVVW?=
 =?utf-8?B?alhHVDRDM2pNWnpGdTFSZDVJSTFvTVo0TG5jN2FOL2dtQW9OeGgrdDdRQUNq?=
 =?utf-8?B?ZjgzZ24xSTlhcUo5V2hFZ1lBQnRaWDN0eW9wa2ozWDBvNUtUYVdzZWNzVDhO?=
 =?utf-8?B?WkJZd3RkSG9SeU5TSktJMCtaaGc5MG16QVBKSm5YSzVOUHdUNzQ4WlpkcDAz?=
 =?utf-8?B?aSt6eVFINDB3RzMxZGRNV2JlRDdzWDJhOElqMThxVGF6Um52ZUVnVXE0MVBY?=
 =?utf-8?B?WTFQZHd2WThrSVQvM3FZRHBCK3BSOWpORWlyaGc4UnkrN05BdTFrQXlUcllx?=
 =?utf-8?B?eWtudHM0ZXdFazlBbThZZlErRnN1cEt6Y0QzcDZiaDBXUmVoZjgvcGc5aHl1?=
 =?utf-8?B?NWx4c0xiNkp3MGFOQzBySnA0ZVNKTkkrS3R2MXdjMUhqNC9XYkxxVHVXbUNi?=
 =?utf-8?B?eXdHL1Vub2R4Z0Q2dzZ5VWp4YWc5aTBuejd2eHQ0SysyaTZvWjJJL2JSV2J4?=
 =?utf-8?B?Y0xWbW1uWC9mTDdkMCtSdll3Tk0vZEtzYXVkcjhmVWRyRDR5VHJqdEZhMnU2?=
 =?utf-8?B?ZW5QVkI5NnUvV3VwT2U2UmdaK3hNenVCcjRBZUJabTJJRDlNM2wyZzhqNHlt?=
 =?utf-8?Q?yDZ3smTgIMyGF9CR3KrQl2c2ZS0rNp9VPY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkRiakdrRGIzMDJXOCtiamNVK0NkeVhoUHZJMUE3WFFYTllJVmxpMitWS2Nq?=
 =?utf-8?B?dkhkYlN6RXJkeThTdjNodk1jK1BjSEJxVkVmZmgvcXJ1Z0RHTGl5dFo5UXIx?=
 =?utf-8?B?WUxDRXRtMFpGeldjZXpGZ3h0NmJ5VVQyNWFWT01Yek94T1lGKzBSOEVhRmt2?=
 =?utf-8?B?V1Fjei9EeHNLUUZnOUdveHR2WUpraDd4SVNmZnZaMTJZaS9YaUN4QldwbDNT?=
 =?utf-8?B?ZHZzK3E3VkMySVBmbDdsbXpwNnIrSnk1OGhpZjZzU29SVWNKVmUvWDlHeXE4?=
 =?utf-8?B?MDluZDdRSm01QlYyVHEzc3duSUprVTN4K2dqSEcxNmtBQVZ2WFFNSExJVVQr?=
 =?utf-8?B?bENldU5MS3BMaGMvNVhscFRUNEwxZWxwMEE0U1BpdEF0SmhpUDVMWWt4TkVU?=
 =?utf-8?B?UlU2ZXN0Z1BKcTdHOXdBaGFVYkRuWmo5TXlRTHphNFNZYXBzMXF1LzM0cGpE?=
 =?utf-8?B?Y2tWTkw0eXFKYkxrNHRURGd3aEJ3SExrTlh4SlV2MXRPZXNFdHpUMTYxNnV1?=
 =?utf-8?B?T3I4U3lwWVdvdDlNYUdKMnZDcytOME45TWpyVjhRRWh4TDJobzhSWnZUaG9E?=
 =?utf-8?B?YzdOQWN1QkJmM2dpdkM5cUwzU3A3bytnTlJVQnZoVVptRW9GN2xIOUJSTTBG?=
 =?utf-8?B?a2xVbkFZRFJIVFJmbS85Q2dvWCtSWU1CbjNXc2l4bnBFdEpVVjE5amJDcTZx?=
 =?utf-8?B?QjdOMk1iMWV6dDAyZDJnRVRjQXhNbXRiM3JwL2FhZTh5dWYwZFUwK1plZUR0?=
 =?utf-8?B?YXF2QXc5R2R3OVdwNTJvZlFNM1A5SzIzSldjQTNoTElMT3B6QVd6Y0JPNkhq?=
 =?utf-8?B?ZzF4RzdQbWJHSVlnZHo1QlVjbEViOFZzMGxMQXJkWEhjb2Z6UGFEbkE5R0dT?=
 =?utf-8?B?MHBaVzNQSjVOMGZCc0JYaFFHblQyZnFqR0c4VURWZHRLREQweW8xV1RLM041?=
 =?utf-8?B?ZEVhSm14VDFvVS93ZW5vVVpFWTB2QmxQT2M3Z0NKTVVLMUZRQUxxdjhsYjVW?=
 =?utf-8?B?UkRRL2s4ZjN0bnh3ZE5RVXYwSkVIa2dzRThaRC9LQzNqR2xZU2IzMm5ZNXU5?=
 =?utf-8?B?MmUwbkMwYUk1S2tER29CZ0dPWVpHK2FDbzJlS041YW9vaURqclFoTDVXRmI4?=
 =?utf-8?B?SlpQMEc5L0w4TlVRMVlLVEF2RndWc0grNlVxeU56eU9wRGovLzZMQ1hYZFJj?=
 =?utf-8?B?bU1nbHZ0Sk5qTi9KdWZocS9WcWhhUlpjQ2xqQ3hHZWlkK050WGxieVZoRThK?=
 =?utf-8?B?ODRQMEorNmR1WElHdlRNZDEyaE9XYWVwZmZJQTgyNGRza1pTb0k0Q2x4bTV1?=
 =?utf-8?B?SzJTRjgzVVdBQWMvdXdZejF4S0RJd2xGcktLME5IOFpseU02WnRFZG5OKzlC?=
 =?utf-8?B?YjhYRkZiZHNlZTJtNHY5UHZETDJDMWJiRzlNR2ZqN0w0bmJJeStBNnkvNTZS?=
 =?utf-8?B?SzlxS0ExZ1RvbFNBQ1lqeXAwMkY5YUo3M01YeSsxSXFXVm5qbHdQaGo4ZWtt?=
 =?utf-8?B?ZGRMMzBEYXM4dVNXTlhkbEZmdXpsWlBtM3gxUElTeWZoMW9LRy9wQTlmMEsw?=
 =?utf-8?B?UUFETUVjcGYyajlDcjF1cDN5YzBpZGY5cHloUW5ZclFwOWlrcnpFRVZvOGRS?=
 =?utf-8?B?NHZvd1BKSnZiejFFMmJabzVtRHdpWithMFVBRFlCR0owanhCd2J1K3daY3Vs?=
 =?utf-8?B?M0VteHJGVCtNL3hyNkd1RGo0dFJVY09wT0RtUjJDR25TMkFlb1VaNkpmdEhw?=
 =?utf-8?B?YmFxSmtvWWhnZWlnTlJ1c0tMdjZiUXU2MUF0MG1FVTFaSGtoZTRYTGYzeXZT?=
 =?utf-8?B?VWxvNmxTdkpNaUZ5UkUveWtzU1dnN0EvRjl3NGNJSHRUeFcyaGZxcVR6cGtT?=
 =?utf-8?Q?qr2ZWGCSIgU1w?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7104e06-cf27-40d2-de35-08deb0145007
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:50:42.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10708

On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> The 'fetch follows tags by default' test sorts using 'sort -k 4', but
> for-each-ref output only has 3 columns. This relies on sort treating
> records with fewer fields as having an empty fourth field, which may
> produce unstable results depending on locale. Use 'sort -k 3' to match
> the actual number of columns in the output.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   t/t5516-fetch-push.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 29e2f17608..ac8447f21e 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
>   		git for-each-ref >tmp1 &&
>   		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
>   		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
> -		sort -k 4 >../expect
> +		sort -k 3 >../expect
>   	) &&
>   	test_when_finished "rm -rf dst" &&
>   	git init dst &&

Makes sense. Looks like 3f763ddf28 ("fetch: set remote/HEAD if it does
not exist") originally changed it from -k3 to -k4 by mistake.

Thanks,
Matthew

