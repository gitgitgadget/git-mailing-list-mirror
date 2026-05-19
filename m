Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011030.outbound.protection.outlook.com [52.103.32.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F238F244
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182013; cv=fail; b=BORqKpD7LLo6dSsciZLqGZHPcBzglZsjgHtStY3Lr5qQo9aI01HAOM5dQ44qgSygvHaL2dx4jyVaXHOWs7uSdjcYZVua3xWFLDtTVQtv3ed+Iak/i7a5jOf/eI9uIleXq6o2NxUCRk/ECoolEBGM0sLaZKNCcsCFFHa8IcgkNww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182013; c=relaxed/simple;
	bh=FpLs1TG/sPA2XghE4q1BMQpwXLoNTfhGC5rtwS3j+mk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UfW09Lk3FyWpedbEbeiAH5KMQdM3rMGkkGtdngDlRRpyjBThnt93mG+wpZHLSI2gqT9v0YbmQUJxKNEUOEKYahptYxyENI30YAhBzA/FefJLilP/6Kg6A+dkO5Fj8DuK8CQHIKPHWcWno3IlJvp1peEzItxtMmijoGMyr3Jyjl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OdRKPR0q; arc=fail smtp.client-ip=52.103.32.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OdRKPR0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHm+MaZ1d4jS2+gpRceGile4GR7CUMDuKkMKmkEC62LxzAB0oY2fCvG1t/GodI3PFLnKmpZ2jGi6zA5sVAF9LqLGYWJcMpnOgs8cEy6LkC+TxRi85NaNIVRtY+keDeVrZcbSLXsd/t1wth7UE98XJN8op+WX9K5t1jS0rYr/3x3+mBAyEH7PTbmhDSlJ820++vtMxPMgcHoLpcNs1oLrw/WsRZmWDoVmPIkkAU8ZhAK3+n4QliWzk4czg1m1osDi5v16Kt6d3mO8MYhc/F3Z2fOsjIPk2717Y+JDNuL14MNrYBcPlpVu7n/cF8M+jfMQyZVpTzoXaPyVALLvgRMBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVT5pgrK9+LGBhJtOlOtShwBkeA0Jrg/9Yb6/g80W8I=;
 b=wkKeWhcbK0fniq9KCVYdtfGuFL0p8WIgz4e02xkqz30HcKTrb6DXc9AgO0GDHFI4t3sS3dJ40+YKU1uYYayrny6hG8POy1jkuHNxKUZsS+Fq2qlc0R+UlHFvcaC0G9GwhHzfbqbaHA6aU/UtqUSqWxFzrPlVrx8ag71wimGL3otvjw3hYK4m7ibTfijq8qsRLMzLWIQEDeAvvqihaQ49YadjDgiEG+ZxUeH7i1S2LE1SfT4cE68OcfhOxdu/NyQHAzq9kyJckvS8VVJGaKM7HL++ncjNRlQrGVoeMxH0nX9d3d7YVOgNzTdrsQzpJIsINzoO/TC8nS2LBnpCTPiNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVT5pgrK9+LGBhJtOlOtShwBkeA0Jrg/9Yb6/g80W8I=;
 b=OdRKPR0qOI1GpOicbZgm1Iw+9E8hRxyM7myqgZrbdm9oAbLTQY3Utprs60T1KwKUxKjioDz5EZbWwTeXzjaj7xp+URKm5PxXbEEJHFMgfS3GN3z2H1/MKYKllWhYB5ctKT/wada3nLgLudtSc4YRZpKiSYA8ev10HoQ701bYzprn0WBM4JieIzjM+P93Z9+t9KkBcv0cvdZxwgaiVYF8YTVXn1/JHJ1GNdBkgwaSxMv+bF4suR3AgVQ6vW2el05Lq1qz/l4gcu/g7zsXcc01VCOu6JJkFvPfbhz8DqtQt1+aZcBpD6IBhbIPztTlfkweTO1JlqpDrMvonTZa1Rf25g==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by DBBPR03MB7020.eurprd03.prod.outlook.com
 (2603:10a6:10:20f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 09:13:29 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:13:29 +0000
Message-ID:
 <VI0PR03MB11634DBCD7ED97E3358AC9339C0002@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 19 May 2026 10:13:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] fetch: rework negotiation tip options
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::6) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <4957aa4b-7437-48da-a349-df84502c7cfa@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|DBBPR03MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: fb763fbc-c74f-4b3e-f22e-08deb586e3f3
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOxZ+gpMXNOmppem/sH2ctbzB9qX6bvVnFlR2OPaHRZQbM6z/dpBCQiHd7TuwiPkrYTOlHvWnlaWFImwV10TG7HuoYz1eOPQmkzIyTvBNLnhgnX0Pgr1pLv5VBHlfpTc8CF6KHqDn5X19+s2WVLA4NIFezuM3+t29C6/sGIkiN18ggcR0S+VSM58K8JMXd+bPQ11D3z5GGvPh0+2wab0psURTZ3Yij6IhoYa9PIdqTm0Tp8dLDytwLFaoe7QdG9z6/6qcDh7DBW9zW9g/EknVF/ivNBghe9MgXZYU/IAMhGGh+PTdseBfB3xgmI91VYxNUQ0rstDVgnqqwL5OMJXBCDTstBZPN52NbBVhaPmTxtSfT8vRqtkSS95aA6nLvxyJTlI4NZ0Gm62O00nr+Uc8XYzX2ZpRszQKjvgjXzQw9KNIhV8YImnGsr+Bfo4qEilDUK518uvPECmCgq3OkpN7A5CIpqyhmk3aeUL+ZBKe/xCAiC8JVZQ/E7rI9exNNadzc7RuVLgQdWed+ChFZGLWfdx3aH49RoKrZqLztOzhhmlhJK0vCjQhrXDOdWfxyCOogkqStYjZiA0FN2qdSDVoGvu2+iBQEuDlD2GGj8fZRC3nxRcpp/dYm/6jyG8cZniaCOrmVKSPPFKTKfS5k8GiFZza3RI5RCx5vnRoe1wluqhO5livv21eutau+1sculTvlytuKz+HqStqSfQoLy5G6rLGgY9Qw4tf0zyVFrBt0rlxjol9Y1jH7Yx9MclTQUw8k=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|23021999003|15080799012|5072599009|6090799003|37011999003|51005399006|24021099003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXdKTUt6cG1lOVdQUlUxK25sSUV5c2REMVRRbmo0Z2loQ2RjUXcvSkpsZWpx?=
 =?utf-8?B?UFdLWE52QjZ0RTZGWFBpZVFMVk1QQkVQV3ZodURyS2tueXFlTk9KQlk2SUd4?=
 =?utf-8?B?T2JaTkVKdms2YlBxTHNZV05MMHg0WVh4c1RqZ3VScDRKcGhsRW9PS0E1czlU?=
 =?utf-8?B?cTlGUUsxU3ZocjB0dmM3cC84MGV6VHhnQmR2bE9OUVA3R0plVWU2T0dnQklC?=
 =?utf-8?B?RkY4RFJiVHV4cFdCMmdtWHoreUNyNGF2L2JjdDZETVE4UEh3REl4bE5QZVYr?=
 =?utf-8?B?MWQ5OUdob3l1N3ErZ211REZSa0VEaUpsRGsrV292RGNReThuakhnb3RJaHNh?=
 =?utf-8?B?WHpTeUF5aVQ1Syt2cmN3TlU1VW5ob2hWY0JmNDNaa3NJeDlmOVZsMUx3azFD?=
 =?utf-8?B?TUxjQ0JXcFZCQUVVV09renN6czBsMkprdk90NWRzaWkwbkMyRHlDd2xaV3Iw?=
 =?utf-8?B?M3dmVlYzUDdjNlpkNG9Odm8zSWk1bjRCS2RhTkVsL0Y1Njc3dEo1UGlweHNC?=
 =?utf-8?B?TG0rSHZCVlc5ZFRGYk9pemJ5T3k5U3pGb2hlYjRrODNVY2VSek53TDdGZHlH?=
 =?utf-8?B?YTVNSCtSaHpWYVBrTi92SzRjUzJKVTVuVXpPYWZhV2dyZ1l3UGwrczNmMFlN?=
 =?utf-8?B?YlpKdWJFWTRMK3dEQVc5TFNaSnBESi9EK1F6Kzl2SVZEcHZ5S3dOcHl2bXJ0?=
 =?utf-8?B?dEg0RlNCa1hrcEtYUDNXZ1BNY3lCYlh6dE14cWxEYXdkdGxrTUhVd0lMa0dK?=
 =?utf-8?B?WDZGbW1Uem9KK3M1RThZd2U1cXZldkh0NFFZMzByQ3JoR3FhaVdZRUdjOSt1?=
 =?utf-8?B?Zi8vQy9QNmtMYlhXL0lsaHdublZvWmxFbWNveDFMeWkyeHlwbWJPMEVpQm9x?=
 =?utf-8?B?TENqVmtKcG5CNzEvTmg3dmZFUGpkTXdydVk2aGk1VEMzelBwYnNQRUtjdENq?=
 =?utf-8?B?R3gwSU00WjJGa0x4aC9zU3V1SlhkeGlsTlBLT2tGVW5wNlNST1FZYTdKeURO?=
 =?utf-8?B?L0I0NzB6Vkt0V2hJb0k4T2h6SlNGeU1OMkJvcmQ2VFFoTC9pK3dTcUg3dUtI?=
 =?utf-8?B?TGQ1NXZ3N1lZTUZmZkwxQmZvTzJUSUdiMzFrYmtBcFJzSWlzYksrRWZscExn?=
 =?utf-8?B?LzNXVXc1aks0QVAyaWlWa2FWRzZJUE5oRjg4NGg0M25JTFkxY3JQZGFmamxQ?=
 =?utf-8?B?L3BtcllobTRaaGlFM0JOVldWUXBucGZpWXlhUlV4b0R1L3J1dWhaakNIQVZN?=
 =?utf-8?B?ZzRWQThLajJ1R2wrTTdCMVBna3V1KzRiS0lPVFV0MS9Ca1ZubzZuT2U4R0RH?=
 =?utf-8?Q?dkjfpMdyj9R5/Bhe0ueedURYG6iU0Aptfi?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWpydm1vUElBNU8zWW9oVGZ0U3VxTS9SUDFXc2d5ZTVHQjRWMDI0TDQvbi9r?=
 =?utf-8?B?Si9CTkt1TExuZVNyejc1NkN0T1BxOXl4WXl1K0IyeDl6cmhaYXRqLzJoSXJJ?=
 =?utf-8?B?cGdKSTJ6dlBHeXc3SW0yMVNpZmpKMmZXOS9HK2EweXQrMVlJbG01MHlmMkNR?=
 =?utf-8?B?dkVMM2tUbWdFaXVFb2JiNU5LcGVaOUN1QzhEdjQyM0VmK2JpMXNYT3FPa3Ns?=
 =?utf-8?B?Z3NCVG9IVVJwTnlNa0R0UVp2ZjlmTjZ2T245c3hJdDlPSzRXN3N0aXJDRStB?=
 =?utf-8?B?SHFjbDk2NkpkeVlqcVNrL2YvMjc4eDlwcmZsdnFDdVVhVXpXZGN3RXEyWk5C?=
 =?utf-8?B?OG5WUmN2VTN3MStxSmRQRlBiNG83QkpUVjZlTXlMdVRQdklrbW5HOE1nL1VD?=
 =?utf-8?B?SU9oT0d6WmdCdkRabG1uSjd6Z0NPZEtOL1BPbUVZU252SlFZSWJNeTRBa21M?=
 =?utf-8?B?MnBWaTBuOGEvd2QvUGhjV3RZNFNsUzJWVE9MQmR0NHhISG1aNDdjeG9GVXpX?=
 =?utf-8?B?cG9oYjFJUHpsUmhUd0NvSTFyNFJ3UTNYbHVJUVBPWlpob2twU05HWnUrNERp?=
 =?utf-8?B?YkZmY1lWejlINzEzUTgrZ254SlRCN1g2bXo1aHZMTDYwTnVBOWdRM1BZWit2?=
 =?utf-8?B?am13S1lnazVkVFFDbldkSy9DSGRKSlZJVnY1Zi9hS3d2SWhydVRZQnR5OEhG?=
 =?utf-8?B?TC9HanNvWE16ZURiOU8rU3V1MjRPWG8zWndyeGdwUTRKWHlXZnUxTDIxNE5i?=
 =?utf-8?B?TGJPVGlhZjBXamMvSFphSVNMSVZHNTlya0cvb21ZVUpUTTNCZlA3bTR3UWYv?=
 =?utf-8?B?bGhyVmJIV1E4S29qYWVvOFAxMFVwcHhQeUJuZTlqT2JkMHZjc2ZzU1d6S1pY?=
 =?utf-8?B?VVBFWWdEM1pYdktwdnU3SFdkTk5DakRPSFZuQ3QvLytBVzZ5eDRuNU45bkV3?=
 =?utf-8?B?TSt3UEZvMnR2eUdUOUF0cmIrME80bHl5WmRtMXI5L3dEa2JMWW12ZjV1M2Rl?=
 =?utf-8?B?Y0hzY1hKemlCU2ovODNvbGEyRmlrS3BXWlNOMDF5UWpQeWNzc1c4bzNvMnpM?=
 =?utf-8?B?c0dxaFhMdlhmMzROV1lBdzBNa2N5ajdvUWtNbUhoblJBaGh2N1VDbHVOUHht?=
 =?utf-8?B?UytDYTg4SlE5WVFiZWNhNk5ybHlFSXhPMnBrN3VQbDNjUVhRcVVvSUludEo2?=
 =?utf-8?B?SVEyY25yT2xSZkhhUEZNVnRlNlhPSkg4R0lZakp3bUlIWU50MTErOVR3c1NF?=
 =?utf-8?B?Ykg4Rmxkak9tWCtIRk9MVHhMWjNITFU0ZG0yTHFjaUd5KzlnMmFkdXQ0amZM?=
 =?utf-8?B?WkpLLzgzMmZzMzNhWTlkLzVZS1AzWkp4N2QzWlpiZm1HSlViTmJySEI4SWRP?=
 =?utf-8?B?NmJWMDFOSWF1SG9SN1NFMEV0Z2VrY3VjVG52K1BERkVHOTdQVHNseWtLR2Nv?=
 =?utf-8?B?Z01SRkpyZEJ4eEQzY1RKd2hlS1M4bVptTmNBWk4zUVFLRGZPNGgvU2kwclI1?=
 =?utf-8?B?R1pENzMxbW5hMXd4VkNPT3RYRHg0dk8rbFJvMlU1QzJySCtINzJvWUtuak5Y?=
 =?utf-8?B?U0J5cHpEZ3FhdXVDTXE5N29KeTVFWk9iamNXYUw0U0ZYMU9pOGtlUVVKUjcw?=
 =?utf-8?B?MEdwQmlpNTNEMjR0Ymh6bEo3VG9LMnJMTUxvSjJ3OVZiK3AwLzFPRUNuME9u?=
 =?utf-8?B?T0ljSzBHNVNlOWJvM0VxQ3lVako0bXg0T2tBMmx2QmNYLzRaK2loVlY1dXhR?=
 =?utf-8?B?V29rdUNQY21sak45TjY3NHJYZ1llSlhmRjcycTdPNVpUVHI4S25WTWo0UlhM?=
 =?utf-8?B?M2xqWlNQRW53czV5RzAyVlBpTTZnOCtrK0hGV1hEK3dBYWN6RktLL21HWjhT?=
 =?utf-8?Q?bXTDL0KYoZreg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb763fbc-c74f-4b3e-f22e-08deb586e3f3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:13:29.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7020

On 2026-05-18 21:19, Derrick Stolee via GitGitGadget wrote:

> Range-diff vs v4:
> 
>   1:  7409a479d6 ! 1:  538913a327 t5516: fix test order flakiness
>       @@ Commit message
>        
>            Use 'sort -k 3' to match the actual number of columns in the output.
>        
>       +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
>            Signed-off-by: Derrick Stolee <stolee@gmail.com>

mjcheetham@outlook.com, not mcheetham@outlook.com.

>   6:  b4cd458fe0 ! 6:  e86c9791e2 fetch: add --negotiation-include option for negotiation
>       @@ Commit message
>        
>            Also add --negotiation-include to 'git pull' passthrough options.
>        
>       +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
>            Signed-off-by: Derrick Stolee <stolee@gmail.com>
>        
>         ## Documentation/fetch-options.adoc ##
>       @@ builtin/fetch.c: static int add_oid(const struct reference *ref, void *cb_data)
>         
>        -static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
>        +static void add_negotiation_tips(struct string_list *input_list,
>       -+				 struct oid_array **output_list)
>       ++				 struct oid_array **output_list,
>       ++				 const char *argname)
>         {
>         	struct oid_array *oids = xcalloc(1, sizeof(*oids));
>         	int i;
>       @@ builtin/fetch.c: static int add_oid(const struct reference *ref, void *cb_data)
>         			continue;
>         		}
>        @@ builtin/fetch.c: static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
>       + 				      add_oid, oids, &opts);
>       + 		if (old_nr == oids->nr)
>         			warning(_("ignoring %s=%s because it does not match any refs"),
>       - 				"--negotiation-restrict", s);
>       +-				"--negotiation-restrict", s);
>       ++				argname, s);
>         	}
>        -	smart_options->negotiation_restrict_tips = oids;
>        +	*output_list = oids;
>       @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
>         		if (transport->smart_options)
>        -			add_negotiation_restrict_tips(transport->smart_options);
>        +			add_negotiation_tips(&negotiation_restrict,
>       -+					     &transport->smart_options->negotiation_restrict_tips);
>       ++					     &transport->smart_options->negotiation_restrict_tips,
>       ++					     "--negotiation-restrict");
>         		else
>         			warning(_("ignoring %s because the protocol does not support it"),
>         				"--negotiation-restrict");
>       @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
>         		if (transport->smart_options)
>        -			add_negotiation_restrict_tips(transport->smart_options);
>        +			add_negotiation_tips(&negotiation_restrict,
>       -+					     &transport->smart_options->negotiation_restrict_tips);
>       ++					     &transport->smart_options->negotiation_restrict_tips,
>       ++					     "--negotiation-restrict");
>         		else {
>         			struct strbuf config_name = STRBUF_INIT;
>         			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
>       @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
>        +	if (negotiation_include.nr) {
>        +		if (transport->smart_options)
>        +			add_negotiation_tips(&negotiation_include,
>       -+					     &transport->smart_options->negotiation_include_tips);
>       ++					     &transport->smart_options->negotiation_include_tips,
>       ++					     "--negotiation-include");
>        +		else
>        +			warning(_("ignoring %s because the protocol does not support it"),
>        +				"--negotiation-include");

Perfect!

>       @@ Documentation/config/remote.adoc: values are not used.
>        +This option is additive with the normal negotiation process: the
>        +negotiation algorithm still runs and advertises its own selected commits,
>        +but the refs matching `remote.<name>.negotiationInclude` are sent
>       -+unconditionally on top of those heuristically selected commits.  This
>       -+option is also used during push negotiation when `push.negotiate` is
>       -+enabled.
>       ++unconditionally on top of those heuristically selected commits.
>        ++
>        +Blank values signal to ignore all previous values, allowing a reset of
>        +the list from broader config scenarios.
>       @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
>        +	} else if (remote->negotiation_include.nr) {
>        +		if (transport->smart_options) {
>        +			add_negotiation_tips(&remote->negotiation_include,
>       -+					     &transport->smart_options->negotiation_include_tips);
>       ++					     &transport->smart_options->negotiation_include_tips,
>       ++					     "--negotiation-include");
>        +		} else {
>        +			struct strbuf config_name = STRBUF_INIT;
>        +			strbuf_addf(&config_name, "remote.%s.negotiationInclude", remote->name);

Great

>   8:  5b968245eb ! 8:  ed0be32e2c send-pack: pass negotiation config in push
>       @@ Commit message
>            are passed as --negotiation-include to ensure their tips are always
>            sent as 'have' lines during push negotiation.
>        
>       -    This change also updates the use of --negotiation-tip into
>       -    --negotiation-restrict now that the new synonym exists.
>       -
>       +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
>            Signed-off-by: Derrick Stolee <stolee@gmail.com>
>        
>         ## Documentation/config/remote.adoc ##
>       @@ Documentation/config/remote.adoc: command-line option.  If `--negotiation-restri
>         Blank values signal to ignore all previous values, allowing a reset of
>         the list from broader config scenarios.
>         
>       -@@ Documentation/config/remote.adoc: unconditionally on top of those heuristically selected commits.  This
>       - option is also used during push negotiation when `push.negotiate` is
>       - enabled.
>       +@@ Documentation/config/remote.adoc: negotiation algorithm still runs and advertises its own selected commits,
>       + but the refs matching `remote.<name>.negotiationInclude` are sent
>       + unconditionally on top of those heuristically selected commits.
>         +
>        +These values also influence negotiation during `git push` if
>        +`push.negotiate` is enabled.
> 

LGTM

Thanks,
Matthew

