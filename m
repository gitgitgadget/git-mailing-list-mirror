Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011024.outbound.protection.outlook.com [52.103.67.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B0288DB
	for <git@vger.kernel.org>; Mon, 26 May 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274873; cv=fail; b=iVXfdeRbLpXPFldu3M/sX/imSJidi9GnPDOxXeQ8z5CqPidJXsmgj7EMWXlKNlSYy3OF/Kh+CFFvIIZEpBjxeMUHj6tzijysFtEGIVUtZaUPp/8Os5gWhcNt9OsrIzSrl6vceG9tUdXw2pEFCKm/2g5Q1oS04Jhk1QjuAQOfp/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274873; c=relaxed/simple;
	bh=VbJ18FihWJT9j5ksbz9KsF2KjPWD9uJGTJJjRnJDLFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rS1oYeROS1WR0LQVzxN1NvIhEbjx6dwsAgbTexBX/kQ63WtN7ZMrMyo9XbL9JUKYsunAblZeva6u8kME+f97EJyQnHDGDt0CCa+9W0MIo/KIGPN5SlAh7Z+u4brhU2EXRYYKIeCCfn3tFVtiORXJYFCul6EYOHEOFyyZ2DEgNh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Bw9ZAMe1; arc=fail smtp.client-ip=52.103.67.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Bw9ZAMe1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL2/R3V/ZD7ZGOJ9o6of0sRkFDK0nDCQwcbHiCnATXeHrb0/vrcwEuPb5w/dQia2VYbqHsuTkHrhn5mbUNDiM8n59QxtnGktwXBdVTd7hB+Nv+ITnST3Guyu/VeuUivCDRo4r2J/+SdYXrko+woqHMlui0U/7uMzwNmGm5C+85HHGiG8CzPuSv5oLeV9QQrLqMs4XCPWMIAZyDtkMXarxUIReNdQU6ipQ6lQ5RSsFcBJ7zE7FfBZSfxV1bjj2nnJdtDy6g/Dknb6TVe8uhEoFhstXYbb+FNUWg+mBOrGjk/MhlAz1tPYgRGzh6vv3YXsvcgLBCKUxLvkBzzhZtAglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lHBbiCwD7xkLbHQWhXkHC8w6uHXviiw4I6xyyjx7v8=;
 b=iA0PUOrEqUWqbF4j77IhczDMYA73dUZr9pP92TA52IAJ+b1WeoGeu/4/blcqjmFJ2xaajIiZ6Vf9imTTCxGZMwBqkezDvwiw6dJfd71abknnunrTG3mi8MgsBXYaUQY51uLBhjscnkbbFE3DTMKlFn/r4yDeklCxKb8DYMygjXAYXr5Eud+0GiLOZxBZ2f3/BxdHK5KjmMYN/Ln9owwIjlPeNj8lYHOGoSbXm5PviUc6uVjMWP2/9Xt+T2ywC8p20tzwUUsmCUQMS6Xk+0Xve4vNxvzIVtvab3QQGBJF/KSN2JvzlZvowhSoBKjiqhfs10ZledElsSS+7EvDYTZCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lHBbiCwD7xkLbHQWhXkHC8w6uHXviiw4I6xyyjx7v8=;
 b=Bw9ZAMe1HA+ffQEuADMdpyaEb7JD7ELbBRtmSNkp/NWkzA6qqmABgp4eJN4onGiJzK2OacLNhY53PWwC8YpCkv3dg3vna3VcbVapfZO5pfLukSXry1xz1fBhLsI75cEW5Ff4RIqYnLlhdl20w+bwKlLpb7A1C3Wr/IU2EsXDARoxG4BGzH8dbsIEjF2FglirNNVpy2vZXoW/WWiA8UpzVdFdVWOT/To6AZnNOPR2hsJODDDXjkGOVCOXj5spGsYv3yZrjtwED7t6f056olQe6GfCtaR/hwsFgc9dFXqHHuS18pJCR7ZnKLIicYiWiezVMWhFgb7c9/KJwkvLr7Cdig==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9249.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 15:54:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 15:54:24 +0000
Message-ID:
 <PN3PR01MB95973C8CEC731B43816AB38CB865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 26 May 2025 21:24:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] send-email: fix bug resulting in increased message
 number if a message is edited
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>,
 Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
 Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>
References: <cover.1748192784.git.gargaditya08@live.com>
 <259e20261e35908d5c7f6c36352f1f03be6da6ff.1748192784.git.gargaditya08@live.com>
 <7f5b2891-262f-48e7-9c29-7f3265abd07a@app.fastmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <7f5b2891-262f-48e7-9c29-7f3265abd07a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <d0f4dec6-cc83-4724-8b36-0cfa2352ad5a@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 134f1d24-ae18-4eb5-865b-08dd9c6d95da
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReFQO+5d6ofa7WPjBVpSbrYujopFFZgGAf/VhG9NbvDExf3VocfNFK+GTCQXyCEfgnb68OOMSIZLolM4r31p0hVZ5lzsVyeZrqbt57ot2jLcCPjA9LIj1n3j+8NCVFTXPj4bFDspdU0FURAwq94vqQFPFRE5AAP5O5W6CnWEtpj1mWUmfgGUx/D+q5gUfx9XKN8oxN9cpbcsVdE3tfN75vjRqYRR3SPg4OSiWhA29Zd+6QJn0/5FkpsxNA+zD0L3q3GnbeKbVyFgWCnxH6bOIjB32kWL6vhfL3kK3MLz/SWmny2hr2T504KHtKX7PTTXQ6bjBorry/wH4rFiGEf3nLNvMed14FqqP2gT/oCYvcfxkptaGz/zkIxXoJ45Kg4tQU5fLwtuT7gXdVZCcIcdB5Rkk0CTrBoYapSjswX+ZVkiHWIsVJ8XhCxorms9WTdYcxMIY5QVnzd01eXo/k5KauS+mNp7W0vv8GHQll3KV2NhpZGmPF3gNPEwDVA7vULK/MvDp652PJBPMNpWPXRo19NFPXkIjk9chhEVNbOZpDL4I5uu0VdluXqWHlIgYldvq+z+hFaI9XJTaeBal6JrPg/gtDnb1OL6jjmGhqU/eIy1KXjA0hcj7L4P3DrjvS+ksXElmq5CvAvKg0LJDVwI1Kcm2/EsDHU6gyBpvNj2wefyJb2+EbLDN4uQVIm6u60Xzz0R5i2ZDHJbiQ/W47z/whnErLvyg1nFg0BCtmLl3eBIqPRmhaErA9GdQKdkjBNthCWxBVuGWJ1przfhrAxee0MyAE3NNkyZdSptiOtxBZVeQg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|15080799009|19110799006|8060799009|6090799003|5072599009|56899033|1602099012|4302099013|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGtEcnRwSW0rem1DTm1BVGU1RkYxZ1FJbzd4dXRad2libGZ1RlN4UTVCbW13?=
 =?utf-8?B?N2RHYjdkV2Q0TVlaQ0daSzJxUkJwRmtib0dtWmRMVkpITTcwSXM0eGpYUkxG?=
 =?utf-8?B?d1U4MldaaHc0SndESHpiM3lqVGpBU0VPK2l1N2Rwd3FHbkFkQTV2WXhsVFUr?=
 =?utf-8?B?SlI3RGZGWUNmdkVxSkZxbW54dkllYXcxK3FkS25WMUtFdWN4NDJEWE02QUZ5?=
 =?utf-8?B?UW5nT0FtOGtBZDhZTVdkMjJubjlwNVBUdjZLSmRObENUWk1Bendic3kzUDNz?=
 =?utf-8?B?c05nTldPcjRkSXdIdXRDclMrT1dSRGIwbXNDa3RRbkhROXhhdUUyUDBhdzRX?=
 =?utf-8?B?RVJVVXJzbEZ0TlIwdXhwQUF6UUgxUGlVSlA1blZhekF6bnlZNTNWdE4rVTVK?=
 =?utf-8?B?QXBmTGpKUWgvOXN6ZGtDSVN2YUx6S0YycVNmZ1NlVlFnaUtObUQzdkdLSHpT?=
 =?utf-8?B?K01pTHV6RzdtMlhyNjFzZXdSQXNmVG5RQmtKSFUzTTU0VmE5NnllN0daZDQ5?=
 =?utf-8?B?VjA4QXNCcWtLNEtLZGFEbnI2Ymhib2dMK0FHNnFERHFrRmZvQ3Zub1ErNDJu?=
 =?utf-8?B?WDhIdWRJanViUnNFZ1c4ZDJFK0U4QjBQcjd3aUhkRllpSGtsTlNiSVBaRG5Z?=
 =?utf-8?B?aFFwL1Z6SmJISEc5Zmc5bzg3NGRJRzJuZjlpUkJCNUtvd05GeVlmenJka1Vw?=
 =?utf-8?B?bmsvRWhZQjIzVFRVUmxPTXI1VFhkRU94cXFhTVAwNFNLQlpuYnhhNzZCSFNj?=
 =?utf-8?B?N2U5N3BXWFRRNDcxWmwvU1liRklYaHI5c1BsRWMweFdzdkFiUGRNcXFJVkVN?=
 =?utf-8?B?Sy9ldVNkOG85Y2FRaVN4UHM2NHpadGpYMDJBbmdkKzc2YlBkYzE3UFlXNCtG?=
 =?utf-8?B?OHlJa2R6ZHJaVVJvL1BNS2d2eHhlaEw3VXlpQi9FQm9wUGRsc0JuVkQyMkhV?=
 =?utf-8?B?MnRhMDlybWFUNkFFTndMdXFXZnhlZlV5U3BXcFZEd2lhV0llTXZDbmdBbWg0?=
 =?utf-8?B?eXpPUWVIbXgwem1iZUFCQ0NtTWhHb0hhQktFZ2l4T1RTTXVLWTZ4ajZuMk5C?=
 =?utf-8?B?TTlGMzl3M0xVNjJhZFAxNlNGcEhqZGpLSGNZaUlGdlVERlpPby96RlkxVFpq?=
 =?utf-8?B?Wjg3MnFRWUlLT00rNmtWZnY0akhaRU1lc1Z6ckZnTGowZm91Q01SZVFVaEJP?=
 =?utf-8?B?OHF0cmR6QTJZdjZDeGpSZjRidWh6Rm5XS21wKzVHNFdQOTJxNDhCTUppU2dn?=
 =?utf-8?B?anc4czUzQzhqV3psckU2cnptN29KNEVrUytBcTFkY1hPb3ZkKy9pcUVVUlZk?=
 =?utf-8?B?Q2hOMUZJdmJjU3lsK0VhL2h3Tlh6UW1tN3QwemJScVJpQThaTTczRElRZVpZ?=
 =?utf-8?B?M0FNd3MxdFNzQ1dON0h0QlZ2Zmxyb1FMSnZYV0I0Y2dMSmJlZFFtK1Q4UURK?=
 =?utf-8?B?MkN1R3RnbHNwVFM1eGpLMlh4amxpVTZNOHV3Y09FVy9SRXFVcTRRYWhOVjNY?=
 =?utf-8?B?ZVZOZGl4endzamNGRHF6QUF5UlNJTllaUmtxQlgrdm9ZdUtOOUVnYVNJQVZ3?=
 =?utf-8?B?Q0ZJYWtNaitjd09lSmNjTXA3eWpGOHFMMGZORzh0T01jaXhmOGdFRnh5VjM4?=
 =?utf-8?B?dkdLY0M3MEFqU2JwdExhMHRhZVJ4bFZVKzRMdGwxcU5VamdER0NOdTBSUXZP?=
 =?utf-8?Q?vUTF/giR1VrFkIE7y/FK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WStaTEZBUzV3VU1JdG9YK2VKQW41QVVEOVozM3NZVkVHcXlEalZDK2hlbm5t?=
 =?utf-8?B?UlNFUU55THJpZTB5NWJTR2k1cjlHWnJ5TTd4OFBOWm9FdUROaWQ2VVJQL01I?=
 =?utf-8?B?M0ZlOEhady9VUVNYaHhtZEI4UDlZRmZVa1dZbTRQbUxkNXB2emlCMnNYK3lq?=
 =?utf-8?B?YTNTdVF6RlBPVjNwdFZDUk9WSmtzNW5RTnB6b1ZYSjhsczJPQmxnS0lvOHBt?=
 =?utf-8?B?d0hEN20ydWIwajFLTThnRVV1L25La2V2QXAwV3BISUNpYnhpSFdtVTRnanpo?=
 =?utf-8?B?Qkc2VXNOcEtNWFhrUU9sTHRCVjZEWmx0RCtEakJQZEdPZVZDa0JQa2pJeU9m?=
 =?utf-8?B?all2dUlwRlV4QVVBUmRNQkxaM28rdFZCZnJCTnluNTRtM3dyTkx5RjNEaXBt?=
 =?utf-8?B?SVRzL2VocWt2SXBDVHloejA5dit1MDZCa3BIRlBUT2FvU0dSS2dRN2x2V3hz?=
 =?utf-8?B?MG42Y2pwKzZENi9BY3kxMEJRZGFwRjdyYmdMRVdNbk9pMk5wSnkwQlhQa0ZE?=
 =?utf-8?B?WU5rd0VxaTRkSG1SU0U3WGI5N1NXQmtJZ0FEZU1ON21aZWYzQTEzSTZVMTh2?=
 =?utf-8?B?Y0xoYm9CR3I3TWhQTUEzMUI0VlVGZUJVTmJNUGREam5ZcG1ndHovV1lJY3VS?=
 =?utf-8?B?RlJtRHNLQ1Rod2VZcnJrdGZpK2tUT0gyNW1Hd01PZmJ5d0t6enIyVEx0NFk3?=
 =?utf-8?B?d3NCSDljZmJRUnpzRWFGQ0M1Sk9FcEs0N3QxUk5SSmx5aFBZVmNPRlcyaGxt?=
 =?utf-8?B?enp1eTRDbVQ3QlB3MlRvSlhaVEdJSnAwMHJpZGVRWVFmMFRwdDRqcnNYbnoz?=
 =?utf-8?B?ZU4xZko3KzhSSUZoRCt3UWsvTVFtdFNqRkd2cll6OFRiWEgwR2w5dEo1QzBt?=
 =?utf-8?B?Y1VabGpCbTMxeVArUWN0ck9CNlc1RzhHTnNxa3ZmUkZGbDZxdUMwaUxLVEJV?=
 =?utf-8?B?Ui9nSnJ2RS8wQTUybnBVbkpHQyt3T3Axb3dReW1hRHE2UFJ4a0lzS3B5NER6?=
 =?utf-8?B?RmJJczJ6d2tLeU8xc1Q5LzIxbDZaVzVwNEtWY0pjRDVuV0RQcUVLWTk3T2ZR?=
 =?utf-8?B?OW9ZSGZHR1BVbmdRaWFmOWptcXo0bkVrWG0wSUhDbUd3MFJ4K0JvdWJOZkxQ?=
 =?utf-8?B?NlZsUmQ2SWtkSndXVWFUc0NRUWRrWkJpN3NkUDU5YWtFMzZnSjJmZkRoZzJQ?=
 =?utf-8?B?cC9STFREQTVrZ2pGQ01PWXFGaFc0RDNRd3k3N1JJT2tYdUs0REhPWXRTSzZs?=
 =?utf-8?B?WlNRc0NHVStIZUhza2dyb1VJcjZkRnplSWw1RE9TM2NZZXRJTmJxMHdHOEdw?=
 =?utf-8?B?Q2tlb3o2cUQ2MHRMcmNxanYvQll4UzkyQTAzQlM3b25QTlNjUHJmdTkrSW9N?=
 =?utf-8?B?bkQwVzgzcUoxRWdWWThIeHQraTRaQmJ2byt5Q2d4cklKTEtPMXprdmRzNlF5?=
 =?utf-8?B?L1BuR241TnRjZVI0WTJNSTBtZzJHMVVxNVA0YUc4VTVoV3pBZ1FGMW5IU2VD?=
 =?utf-8?B?eTZTSHU4S2tFcUI2dGdiTUFLbkpGbEZkNG84UkJvVkdvK3dLWG1yZk1ncDdZ?=
 =?utf-8?B?ZHVMSjZIMHhLeFdFNE9pUk1IbkJpZFZ0d0hEWVg3SWhJUlpoVHBPYVRtTUpw?=
 =?utf-8?B?UHdjUlRrN1dtR1NwNDR2bkJLZFk4UEJQT0k0aG0xOGpuSEg5SFNwWjB0dTM0?=
 =?utf-8?B?VnJvUkRxUVRRbnFoVkJiQ1JmeGt6RWtJdy83c3FHa3ZSV05VRUdNV1FuUDRq?=
 =?utf-8?Q?xAfZnU24r1P2+LE6AU=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 134f1d24-ae18-4eb5-865b-08dd9c6d95da
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 15:54:24.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9249



On 26/05/25 12:19 am, Kristoffer Haugsbakk wrote:
> Hi
> 
>> send-email: fix bug resulting in increased message number if a message is edited
> 
> I don’t understand what the bug is from the title.  “Message number”
> sounds harmless.  It breaks the threading?  The summary/subject could
> say that instead.  Fix threading bug.
> 
> On Sun, May 25, 2025, at 19:12, Aditya Garg wrote:
>> In case a message is edited before it is sent, its message number gets
>> increased by 1, and so does its order in the message id.
> 
> It feels like this part about increasing by one and if-editing gets
> repeated at least two times in this paragraph.
> 
>> The cause of this bug was that when a person attempts to edit the
>> message, the whole sub process_file gets terminated, and the user is
>> asked to edit the message.
> 
> Here’s the repetition.
> 
> Also I am not familiar with the code.  Just testing it I get this `6` here:
> 
>     Message-ID: <20250525181003.40129-6-kristofferhaugsbakk@fastmail.com>
> 
> Which was incremented every time I did an edit with:
> 
>     send-email --suppress-cc=all --to=<me> \
>         --confirm=always one two
> 

I have re-written the whole message again, but forgot to --in-reply-to this
thread :(

https://lore.kernel.org/git/cover.1748274404.git.gargaditya08@live.com/T/#t
should have the v4.

