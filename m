Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011038.outbound.protection.outlook.com [52.103.68.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7E223714
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728994; cv=fail; b=dVvYWNrkbHCRQxc2xw94lCoIaCcLvgW7PfJei9MECpHyxpjqvVuLs3TeGzBJZlEXwKfWqj5fCNMQ1etwxxWbG5DG0MkYoOrycC6GBQboBTpL5Uq4Azaf0ldBmyL/nKrmbVAW4xwd/eYuxpFH5DfzNcgL6WMXsjimO27w5EvrTwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728994; c=relaxed/simple;
	bh=tqeNz9uONvzTEJG+hyIpktrje0gNgi7GTIHq8Ou379E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bf3u0O3KphYsWhIaGC7d3qc2sepXVd0W5E3t7XrcTZyYAngXsprfXiGHWQ3xyL1KLl1ybOrnqyvQRgSzs9mpHGvacHUdIczBLCAjfiEv4yhZA9X24nlC1K+N6rqYZ4lZxSRpKXGKKvMrUE0Ill9bPN/j2OrtrqXHPFqdCXQe9Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=j6g25rgj; arc=fail smtp.client-ip=52.103.68.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="j6g25rgj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVczSIzjUcp9V2pGK4Bah3BsQzr8qbHnvDv4tkrh/KWLy1qT+xTKD9utbvt6KhFbIW9h0/Nox8BEznzUZG4DcpWOSmAzVbd7Vvomx/vm5LSLCFLks1Wz0Thbd6dvWmw/W7Ps/NfU3bjsAxTp9NvI6fxVsLrEP65UT9WuZcyW7M3WqVcOWSfOTqA+3RwpsF9VwHjgSLhn8//wl0a90M0xbuSPqMGJ4c1FOg46XXXAfkARAuwUHvvsfg20QcehjyPI3hbJzZCI3+Udeg46jrFjy2w8gittBcB+rfa8pdH0iQM/BoEH78iNGY+ux4yWLQJNhgImInd4IqtDV3QaROQQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mM1nh1MryJjI98wcv2GLmvwLz9OvEbVlezV16x5UoY=;
 b=Z7qe3dPlcBqS2F7u77D77n755KrlalRhWm5hgcv1zYUU5vROPpOJ5GhqT6IlJGoiRlBuGhgrdu2Wj6ERz+eK97bx4ts9qjyMFGEz07OMrUAfHPxUzgIRjXtpawNBJZmi21q7bxioe7lF3XYf/S6PvTgPE1LcrZXk9jRyO3oerPh4Dr/KAxdl5rFfv8ouIJ8kUQWTRtFWzb+lVLNyI/mBHnEFJ0LjMHLoHA3j/+p92XasCA7d3h8FXZ/OnULZbIDj4xGy2jUF/mJzN4cTOsKGVyh8E0gbAMwNNMtFvY2yVTBQmr62NM1D3ejbejF4il2c223EW21wvDx/wUM8xRYXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mM1nh1MryJjI98wcv2GLmvwLz9OvEbVlezV16x5UoY=;
 b=j6g25rgjEHLKE5wxD/QrMWrftfbT/ySKUsX2CKSox8s6pTmdtpRHoiP8Y0bzcn6VYAWgURLg0Wkzy2D2mruW2hPBj92wb2XncMKPjp+VIKa7Am5xM8MZKsTOwdd1Gzu9qZND9jnqeyTddRKnjdsnMfTWaWniFm44Zq2rFt7RkkAMs03ZUdD/u73NDbkrzkvCUIg5tqSJX9ExGOpW4dZLTLh2xMw2RBtYPAO3BrFUyToqIaHXGbeGQmEQbkWB+1BIkcxl1slj1UaMiGEBdiLq/nmDbe8qJtkfrUMr32uN0O8FA/DJRc3Mi8VWL37fZcTMfFMSwAnZJB60wakv54mYHA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 11:49:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 11:49:48 +0000
Message-ID:
 <PN3PR01MB959737A5CCD375854E0E9385B874A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 12 Jun 2025 17:19:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Question: is there a possibility of getting a warning before a
 git push -f
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <PN0PR01MB95880EAA98466C9AB049BA44B86BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <CALnO6CA-SvasocZ_tbN2_-DiGCO55W6gyXDjJZqRo5Y3D4JRmg@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CALnO6CA-SvasocZ_tbN2_-DiGCO55W6gyXDjJZqRo5Y3D4JRmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <56ecb2ca-866a-4d96-a00a-a61895b3048b@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10077:EE_
X-MS-Office365-Filtering-Correlation-Id: 679919f6-38dd-49e2-c34a-08dda9a739fa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799009|6090799003|6072599003|461199028|8022599003|19110799006|8060799009|7092599006|1602099012|3412199025|440099028|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjd5MVlrN01JTm9jbXdDbG1jQ3A1KzZ6UjF4amxtVmNoTkJIdkZ0c2dWaUZX?=
 =?utf-8?B?SFliNStSZGlualB4VG1kRTZZZEpDSlRnKys2bERYSHJzUnM0QW53R0VXOEdL?=
 =?utf-8?B?QU9WR0NtbVIxeFBIbGQrT1VRNloxTWVENzZoeUxRb2NPaUxhR0pKRXNwYVVY?=
 =?utf-8?B?ZUpWVndhT2lvYnhnbS9jdmRRcldlTSsxQ084M0FWUWdVQTZoaTNjRWZxTWxq?=
 =?utf-8?B?QXRacWJzOVRHMXJ2WGI5Zm5kWC9NQ0dlL0hUSUsrNnVId3NYTndSSXJ4VGlE?=
 =?utf-8?B?bjZDU29rT1MzMEFlM29UWkNTNDRMbjNRV0svUmRpZWE0bmp2d2UxVUpHVU9R?=
 =?utf-8?B?WUx6M3hqVmN0OGwzZ1A0ZFRRdTMrOTVsWWNkOUlNbVgrNVV2L1ZTWEJXL3A5?=
 =?utf-8?B?MXZpV2l3eXhSdUZYODR3S092RmJzSDdEeG1Pb2toNGRZbVNqSkd1dTlJeEI1?=
 =?utf-8?B?eGtJMDQzVmVjNVk2Zk1yQ0NVbWw5dGhZa1pmNElPSjM5M3Q5TXplU3dmSWpY?=
 =?utf-8?B?d0tqam9YcjZUYVRHODRHb3lQVk9ualFnd1E2dVIzdnRpZmdtMS9GMXZidmpx?=
 =?utf-8?B?SlRrOVRKMWFXeXBTZmlJN3RiTTdvb1BEMG9PTFVrNHRqOFQ1bjZnZ3J1Y2VT?=
 =?utf-8?B?WFd4WnhhbEdTcXVIR0xHTkN0VEQyL0RRb3pqcUMwQmpTcUlqZnBqT3BzbENJ?=
 =?utf-8?B?VGVuSlU3YlhYR2VLRjkzMG5hbU1hNVhtMnZOT2xXN2JSUElNa1pxR2FqSnRo?=
 =?utf-8?B?WktUaFQyZ0NrMUtjeWI3U3hHS2c3S1BuMmhmR0RJS25sVGd2V3pSQk91NnZw?=
 =?utf-8?B?RUFWRjJ2dmYvV3h0NFYyMEZRV2ZDMnlaT1JMczJvUThsRzBKbTlKYzI1MG9z?=
 =?utf-8?B?c2FBWGVvYWRiNnRDTG1qbHRNaDNxVzBuV05pNjNtZGs3ZjBSWTRRVU5yYk1h?=
 =?utf-8?B?UlFiQk5WeTkrS2t0amErZ1RPYnlobk9odlBwUlhJVmM2YTl3MWNXM0dvMkRJ?=
 =?utf-8?B?ZnM1b2xmWVBwTGkrOEFJYnJrOWNjRGJ3WXlKWk5Fb1RHN29sWHNZTnN2aUZE?=
 =?utf-8?B?NHJlbENobld2TTlCRlp4aFFhVzQrSFc1bWMyeitWZ0hGUlBTMnZCbSsvYU1v?=
 =?utf-8?B?NFdTU1ZGeExZa01OYmFDV2h6Mktya1k0WXZnVVI5dm1iQTh4NElSM0htam1D?=
 =?utf-8?B?Zng5ZjcyMW9PTGpkY0s4OVFBTU8wcWYvc25tWVlKNmVkWS9lWTBnUGh1N25l?=
 =?utf-8?B?Z01ISnIrOVVoZ29Sc3NNdHhBK3IvNXJLYVA5UVpvV28yYk1xdU93Y3JVcFk3?=
 =?utf-8?B?aktiWkVBNFVJemZ2UFkrR1p1cW5YNitOV0lxN1owR09GQXEwbmNJN1VuN0hk?=
 =?utf-8?B?QWRlMFlpNUgwcEJicDdDRkw1N245Ty85dmJmS1hBWWllczY1Zi9KNUcwNkls?=
 =?utf-8?B?MEk3MDBYTFphZ3liUXZGU0ZFY0t2bVUvMzEwcnhLRXJEYUhwNkR1dC9WYkFN?=
 =?utf-8?B?UnBXRWRDcFdOOUJVQ01HM1FSd2tscWFnaVdzbU16eEtaOFVUaHVpNW9GdkRW?=
 =?utf-8?B?S0hmTnN1blFabjBtNElVdC9VeDFQUUZqa2xudmV4eFdBc2Zxd2d5bjJvaDRt?=
 =?utf-8?B?dHA3Lzhab1VHb0E1MEMzN0g0bWF5VldPNXcwQzMxMi9KVzJIUE5paG9HU01X?=
 =?utf-8?B?SUpucFZEWG1GY2JSREFnUUNWVE5Ja3AvVThNRFdlY09aUlovTzhxSVRYUkhr?=
 =?utf-8?Q?/ZPukCUqNhlfEBdwXf0VfJZEAZb9h9FH7c5FKy0?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmFFRWJhdlNSb1pDeW1lRVBXeVUzMHJMNVcvUnJUUzFHMGNIT1k5TlMrS1VJ?=
 =?utf-8?B?QXBvQTB6T1lESzlXNDc3cGJIbGlBTUt6VzFvR3lNVHhXMmYwNDNzYlliVlVw?=
 =?utf-8?B?R1hvNHZrc2thTjhoYlRyaC9aZmdHUThZVUJEWmY2V0JHV3BIcnIrMG1hQ3hG?=
 =?utf-8?B?L3RpTm52L3pIb05WVjgzSnpvVjBhN1ZYK1Z1dTIxRVZDaXM5SjI3YUh0cmla?=
 =?utf-8?B?aDhkejdFVGc0ZVp4d2YvNUFpVTdiOEVtNXh5RTdETHo5eDZ0VFgxM2w0ckEr?=
 =?utf-8?B?emJJZXRvYURDWGV2ZkNxdWpEcDdoQ2FRWml4K3Rpakg0RjVIRnlsZnQwOUR2?=
 =?utf-8?B?TnZOV0JPeVhMZDVWeDJXWFBqZDEwdWRpRDgvNFJzYjNnSzd0KzVrbFUxZ01F?=
 =?utf-8?B?b2Rhc1Jaa3grdXhINzQzdUhYYmhNcXNOazh3MXRSK3VkTWpMMXZ5YnF4REVP?=
 =?utf-8?B?WDVUUEZ3QnNoaXgzVklGWlE5eklTcnlZbk40THBpMXVEbExzdzhsUS9yMGpD?=
 =?utf-8?B?ejc4OXAwbUhSVmh3dWJhSDRtUVhlcDdPNlhGQitiRmhnRDhwTk5oMlZwT1FU?=
 =?utf-8?B?L05mNFlWUXphQStoRlBMUk4zZ01TaGRTNWxpdmhMTWFJbVcrd2l0ZFFza25v?=
 =?utf-8?B?bmsra1ZPR1BEL08xaW9oQ004Qm1zZlJxU1h0Y2x6NmpIWHp0R3pGUE9iL1Fs?=
 =?utf-8?B?K012OVQ0ampudm1NUVhERmkyQTFRdDRGNWRKU01EVzErcXlPeVN0eXhYRnps?=
 =?utf-8?B?NjVLb2tCbnpuYU1scVgxYml1T0lMNng0YnNVeElBV29jMDh2dGg0ZTBKVHJE?=
 =?utf-8?B?Y0FzckpUY1d3YXZ5SmVtck16bDM5em83WVJDNWdSdXNRTzdUUGVXN29VRWs4?=
 =?utf-8?B?MmpnQUlxQ0RmdEE2enFTL1JNcEh1ZGUweDZCSE5yRjdrUDdGVzU0NldwK1BC?=
 =?utf-8?B?MHI1V1d6RTgzQk12eCt4Y1NQWWdwRmxiaHJMUmRQOXloNXdQV1U3VWU5RnZY?=
 =?utf-8?B?Ym9ueGdxb01PeW9WajJXVEZnbHZHSHdlZnhYazltZGRMM1FXRGNmU2lnVlVB?=
 =?utf-8?B?bkJzS3dtUUU0YVhMVnV5VnZySEN5Ni8wanB6WVhDTHg1bVNTNEh4YmRmalFh?=
 =?utf-8?B?L2tYREJnN29DSlFQdWVEYWVSc1dCZUVCQUZXZHd3eDdrYjRWWDlsMHpaanpL?=
 =?utf-8?B?eVVYemRyTncvRUxCMkxKYmxPTjh4anhOcjA5SE0zd3hvK3ovdFdGdFYvTnhG?=
 =?utf-8?B?djA5cVIrN00yMVM5S1ZXLzVJditDRDBUZEpUdG1sa0k3MlVraFJreG81ZWxM?=
 =?utf-8?B?bUxmTUlsbW9RQk5BYUQrWnlUdzdRNkVpdVd2WFZWeU9CamcxNkxpVDRyU1Zx?=
 =?utf-8?B?SmdIWkJyM2NPbmJ1WHBQL2UrL2FnYmlWTjE5U0hRbHBta1kwT3BQbm0xWlhS?=
 =?utf-8?B?ZGNPWFhmRGdhOGdNbXQzeHNwaTZ1YmZpNTdoOUlrYnVPRkNIbUFTbHFSUk1w?=
 =?utf-8?B?TGFlWlRLbE1ETVcxTGtZM0NRSWNxeXl4NjNRRkV1OTdmbHRvK0l4MCtOUmNI?=
 =?utf-8?B?SHMrR2J2WjRUYTlkdjQ3WkVuREFqaWVWb1JFSmJ6cGhCYVFzdVhvQTdJbXdz?=
 =?utf-8?B?RUJ1WmR5ZnVjZlhNQjFpd2FGZ0NGSkoydDhqeW9WbWRoWnkyZTZCdnBvS1k3?=
 =?utf-8?B?em1HdEQyZzM4NDBHSTZhUlFDd1hWRU1CTnRoQ082eFFwTU9NNXBZeU02R3Ft?=
 =?utf-8?Q?dVwSqD3JuR0fJ1nsguk9lTZhcl7MdJD0LyHECFt?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 679919f6-38dd-49e2-c34a-08dda9a739fa
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 11:49:48.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10077



On 12/06/25 4:48 am, D. Ben Knoble wrote:
>> Le 9 juin 2025 à 12:47, Aditya Garg <gargaditya08@live.com> a écrit :
>>
>> ﻿One thing I sometimes encounter is that I sometimes git push -f and moments later I realise I did it at the wrong time, result being a disaster.
> 
> 2 effective habits I like:
> - Check what I’m pushing first.
> - Only force when absolutely needed, and even then default to a
> “strict” version (force-with-lease *and* force-if-includes; I use an
> alias “pf” and some config to make it easy, since I do force-push
> regularly in a rebase-heavy workflow).
> 
> Expanding a bit:
> 
> I have a “git-div” script that will show me the graph in the way I
> like between HEAD and @{push}, or @{upstream} if those are the same
> revision [it accepts arbitrary revisions though]. It was mostly
> inspired by mjd’s git-vee, and uses lots of annotations (cherry-mark,
> left-right, boundary) to give a quick HUD.
> 
> https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-div

Ah nice, I was searching for something similar.
> 
> (“graph” is an alias for git-log with the graph and oneline options)
> 
> I also use(d to) use show-branch a lot, and I have aliases sbu =
> show-branch HEAD @{upstream} and sbup = sbu @{push} that I still use
> sometimes.
> 
> As I recently told some colleagues, I consider regularly reviewing
> where in the commit graph I am equally as important as checking
> git-status.
> 
> The second bullet is probably self-explanatory, but the basic idea is
> to give myself the most protection I can, and only weaken it as
> necessary. In fact, I almost never need to remove any of those
> “strict” flags to force-push except when I’m intentionally
> force-pushing from a detached HEAD
> (https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com/).
> 
> 
>> I was wondering if a little [y/N] warning could be possible before the risky command gets executed. I saw the code for push superficially and I don't think it's implemented. I think it would be a nice feature though.

