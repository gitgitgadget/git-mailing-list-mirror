Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10517B3D1
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244951; cv=fail; b=d7oSHympt/zwu+rZwfVuc+rldH51R8SsEpiLLhSHGfGZLTEVU5cR/dlAHZLRg+e9LAIX3OgrgM4C4iyn0O1siaOgKvChay/YpoSbXWF7LQeUatpvqUKLmbXZDtMNDKpUN7fpX7QcfVmnIt4Mx6wqgVvQkN99aunsYybNNJmutsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244951; c=relaxed/simple;
	bh=aLOSFnSJQy6REWEEB41vuEKCgz9RGMnkVEtz5ifJ038=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMslI2qYs2UDLa/f4gms/hByJEi9KABT11VJFCIjnGttBYUUitg9kl8d/14nh93xITs+yyKi785sjPiQBrhTGK55L0iYE5j+Ll5PuhT+cCimj1uILmwcw0TEOFreqLKs21QiZXbRNu9KzoQWYNOVr3FZ8dixJVYaEiMeHfmgfTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=UHzLG32x; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=YPj5lGYM; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UHzLG32x";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="YPj5lGYM"
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C1Ja0J012926;
	Tue, 12 Mar 2024 05:02:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint20171006; bh=LifbiSQZAoaoUEa0vwJvubgxmp9lIclKBFYdU2OlJ
	ec=; b=UHzLG32xcaL8FeIP1UQArn/yZEgXYpK/h+Z7/XhNKaIEHJVmMhi+VBD2C
	ouoh/iHnZmJ8GIkhy/rSBnwxZVH3sSuFbBbpqrz8MpMJl0flsVjAyp9j0YB73uMg
	0EUy4CEYZLjlME5AL8UXZuNVCi+tFn/mr4CAw9AvD07Zi5OqWZswi88qGK4nVn1Y
	oSwZvEsBbgqhoYYl3mXUfRNuPqdHoJFDjvFifgVmhGjJZLHpq/NWfFpolnV1Tmjn
	tLvOOE6652IUCvzLlzNtWm9E5Y9MP2QFv2ioRKaJVn3S6y1/yeeqWISdXyJQZqau
	/LBBULReeSxymRw1T6HQ6Vortk1cA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17012019.outbound.protection.outlook.com [40.93.11.19])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63nqgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 05:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb+A1/SbV4Mb5IYJK2Di1Z+4NlGfNC2ZnEZP64QQEu4BDjuwniToKb28ap5KmN5NIcasStMtQfjqc33qd2IlI4gqVpS1IOIriQd41AHeX0ghe2cxzQXzDTq0CYKQYKZ1EiHrnBg1D2x0nt7KiqXdryQKLeSU0MLbHrxKMxRSTXqUH3xVjXJXrKRVYnnXVaC1b38Fg2QKCoK7Kodi04po8cRUM1FqRWnMmrgyq7/Fv42Y2dvIzCs8ih8HKJ4kN5Ps5hZ9RCBU2DkPmtUWbqjAaA+zymcFvN0PBX8N2bGTgiRA03lYRt1ogZtBt6YrgZ9lfrFSuwQ2Y663kkm5In/vtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LifbiSQZAoaoUEa0vwJvubgxmp9lIclKBFYdU2OlJec=;
 b=DaJCL7cJqxHRdUI3oZQjAAbsoi2CLIODvF/KUL4F+EFO7lCKSiUGbv4WPPSI/2nIkThV252M5qx/ojVobmVwHspinQhNRBvKBAUHqwUFd4pwO+asjsZrerYwhkecIk1BB8CEATfLdCdov/fmJ30VjuNsLJHrEOjt+/dHzxo4pwGVf6KazwTxyzshPjuWsq5SlU3BDARWBeGT/LmEj77aBombFwGfAfPF23U5sJS5zi1wEuEvTlyN6zgpAkT2N3s8aEQDyQ6LEMUOgiITInykJWeSYiq1Ws7hwLn3XsUAplBR7imaTGcfW8keM9f1ORF38WHxDLmkjN4q5hHrU6hHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LifbiSQZAoaoUEa0vwJvubgxmp9lIclKBFYdU2OlJec=;
 b=YPj5lGYMlFZOXXGvgFlv3n03BtuKqfgyE0J/euMVaCKwJpooxXkSa6vsLoKEYD0AqRLL7lhypZYmwidCxEii106letAqHnpXQsaIR/NJxSSaUMnnLizYNEU9rg0V4dSB/9ZBXQQ1qLNuR+tk+5jpNXS6+pAN5yZdfo4pR/kmxP6dLgnUPCIIfUusX7FGFylUBrePR2wwzSUfNwuRf9kr4AP3LWDdO+VFdx1e2hVRXJ28rSkX+DslU6rEWxJeKACNi7ZP3YB12vz0PnN1kdE73P2/RV6wV4EBAvatPsPXPr+Jzd7G7YUHBTPj3quAB8P1pkzHdzBq7nZu+auWiP83tg==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by BN0PR02MB7950.namprd02.prod.outlook.com (2603:10b6:408:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 12:02:19 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 12:02:18 +0000
Message-ID: <d9be2023-c5d7-4594-a06b-3303abb1a920@nutanix.com>
Date: Tue, 12 Mar 2024 12:02:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Mar 2024, #03; Mon, 11)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy1aol1lv.fsf@gitster.g>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <xmqqy1aol1lv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::28) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|BN0PR02MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a025a8-d9c8-4fb3-bafd-08dc428c4438
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oztJtrBLEGhixoQ3+lHGc9vRQhfKtt6wj5Ekupc7vk2anlT/1WQc9rwuMC47KtJ9J9qYlHHJABrpCCtop2VrfKgUKhXK8zA1YcxysK9lyPqO6thBWbfWx9Vm4IEWrO/q9YlkEPYrKogVTucBnu8xdLHeyBVDeyfBck/F7oIS5jip+K1NhIhf9aYO59x+lK8siWRpGLNp23qxN96V2tciwwfBbG6XAGHYD93LOVyJV4vy5QGYV4ON7MCwAZiqazcbNpkMrCmeAsl8B8zfui1M1XQTQO7ZjfEG5umh7+Euov1pRToTQWZx6jzjJczAoOWo/7L358+52/qF/1KBrnS2x+hr7MhGMQtCGmZ2FTbJqN2RuABRjlEbFbWKtdpeSqhTlCHWSCniGMhSfBP915HCByU/BUS22tz9MwL93O/J6D1JmZMsNpyPc+LmwTKvTC8f9+zKGhLvonGC0aKeOER2ZkInuiqBP1fkl7AWv2VMHjWXjmj4giRwYVrbKcxarF0RTm35oZrckzRScMvHw8W1k7Ku6MvYtbjRF7APtN90R81ontTuD7c28RFnFCJb6OjzH4Fqyrral+BPyCujuge0yyaJxDCkqey22povy/Kc3cJgOniKDfHM7bK3n+am7faxmnY2QihKw/U9kMKbOytcN+LKoC1tLVOT5TocbW/Az6Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDJCOUMwU2VELzVIdUg1cTdHc1dsSzhvYm9TT1lWM0xOeHFnM0trNkk5VWdu?=
 =?utf-8?B?OGVNRUVDY1FVcFBKMVJ3blJRY1c5VkRpQ3BCWE1NMUtkR05QVThKT0g0dXN1?=
 =?utf-8?B?UW5ZaGFGWlJTSGttOUtqWU04OHNUNjFWVkUvcTVhTXBJdmVtczNPRHkzK2Vi?=
 =?utf-8?B?WjRyUk1FZG9LcVd6bUVsWXMxMFpQRldMUm92UW9YcmFDcDVYUnNPQjFjUXVu?=
 =?utf-8?B?d2lWc2cydlQwTFVMOXBMOHVxVGdWekVrN2dmWE9oTGxTVzNSSHhjbW1QUzJG?=
 =?utf-8?B?UHVVNnUxSExFZi9OdDhmZzJYdHlxZ1BveFFpNjltRjVONWRtdEgyMGMrWDZZ?=
 =?utf-8?B?bHp3am9nOW9yYkk2ZTRMUzhXTGVUWVRkK2FLTnhjN2tVcW1FQ1NPa2lOMUFF?=
 =?utf-8?B?eUNyTTRPMTFHT2tiYVNzM0NlTzZtbllhTjM0cS9peEhXNS9yb2NIZVBFS1JU?=
 =?utf-8?B?K1VQcklVZWY2cHkySURneE9mNFZtM241Q2pVb1QrZjNlWlc3MkVOeVlYVUJX?=
 =?utf-8?B?cUorZkNLb2dQWHZ6bFlINFBBMXZlMWQ4Qzl6dndIUkNlT01ISGRrSEhGditt?=
 =?utf-8?B?S0F5a3VCT3E4OTFlbitZTUhKbGFqNUtrK2ZXNTI4WjIyMXo2L2RFVitJQmhw?=
 =?utf-8?B?NUZTVXdMUnVKYU1OYTVHTWc0NnpJc3V6dGxYQVg5WGdGZWdTem9jckpNbzUx?=
 =?utf-8?B?SFBBMDNrLy9tSUsrODVnMTRxcHprY25RZC9DMGkwdjlEUmM1NXVsRk5IV0gr?=
 =?utf-8?B?QnJ1ckIyRXVyQzM5aUdYR0FWTkR4ZSswTEJJTXRUSTkzYVA1bUxudlgxbWF2?=
 =?utf-8?B?cXZIMWQ0ZjZmYUJzYXVPYm0xRWZvWEtNa0dHK29zYnQ0RVUwdWNudEx3amRO?=
 =?utf-8?B?NmMxeFJuZE9oYUkyNStScVhaNE9DaENXUlN5RnVpTHZLdXJGdUkybDdjblJC?=
 =?utf-8?B?ZU90em84bWNSU3RRV0tzN0sxVFBKamx3TjczdkJjUDNBMHc3YkhwTXVqNEFl?=
 =?utf-8?B?Vzgra0tERXBSOWVUNFhKWlluSzVnc1U0TUY3RmRJVFd3bHdGdEltRjVHOXVB?=
 =?utf-8?B?U2ZzOTduTmRUTldVS045Vm1LVTF4T3NkdW5PUFBIVXRreUc5UDZoQndZQit0?=
 =?utf-8?B?QXVPRW9CNHZxcUNzdE9HWDZ2UjlDYm5BamhFbk1QYXI1SDd2NTNtTUI3ZWlL?=
 =?utf-8?B?Q0lKWjI4c2JWQnZJQUhDZDAyeUZHSTNMVHc0TVJ6eXN3T0VTVG01RlIwZ0do?=
 =?utf-8?B?ak1VTmJoWmdkdjdxb2hWc01mcVVabU5wSTZOSE5FU1Y3dVh6YjFsZWJzL3BV?=
 =?utf-8?B?K29lOHV1SVBPV3hGTlI1bUorbjQzQnpoYStkVms5OGw2V2EyNGtaRkNCbjJT?=
 =?utf-8?B?TkZVNStzZnM3dGwzRjUzenlXR2dNWlZpWUJ0a3hyVCtHVjdJRG5wR1RHSEpj?=
 =?utf-8?B?SzFVaG1KaEZuWWRUdXJuZ2VIbGt2Mm1mbWp4dXVMTEtGdWtZdXF1TVlxQ0VV?=
 =?utf-8?B?RjdrV1F5ci9pdGM4MSsxOWt2SVJhZ0hsNXh3RmdYYmNKV1hWbFVGRjQyRjBX?=
 =?utf-8?B?RHRyY2JGcVJLNi9CeDlrTTRLaHEvSjdpQUcwU0ZoVDI3NnVkRThhRmgxNHhX?=
 =?utf-8?B?QWh4TmJMekplS1U5NDZGUXUrWkFNellCYnlGTVV3cklmYlB2RWl3SzUyYUw4?=
 =?utf-8?B?L1oxTWkwMENvWktqUlNXZVRnMHRIclVTTDhSYW0vQWlpNUpvd21wSmdReUpi?=
 =?utf-8?B?dWJCR1V6UmhjZ09RU2NaYXEySTdibldYeTBkbncrcjJVdmx1bXpKTFlvb0hD?=
 =?utf-8?B?bGFjcEhJaDV3LzYzVU5EWGNLalBGMmpHbXp5RFVPdDZIQ0hNNjM3eWROM2l0?=
 =?utf-8?B?c1FzcUp1ZWRpdGJPd1R0dXVaOXZ4RTJ5NlJMU0JnQ2xLd0dUM1pNeUgzMmVS?=
 =?utf-8?B?cXVXeWdiMjBITnRnaDJBeEQyOFlKV2pET2k2Z3k2NEpISUhOYmt4dWNGNCtM?=
 =?utf-8?B?M2lOMkxPOE93MldvUkU3a0p2elEzbGJwVVE1bVJzRC9pR3hJSWgyWkJCa1Fr?=
 =?utf-8?B?dUthK0RtbWk2a3p6Qmg1V2xJalg0RDdtQXNnWk1BQncyN2Ewa3pPL3lSYjhM?=
 =?utf-8?B?M254cXFkQTlLSkdDcU5LSWdjSm1hSC9IM293SlRVSU9tTHNNSnpFVGZkc2Fh?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a025a8-d9c8-4fb3-bafd-08dc428c4438
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 12:02:18.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0u5414SdhiLIP+YanPp7TBMfYltsunIglHzy7c6ouYKUKTgu/eMDLaYuV6aFTmKMLDSsAkqQSl8+4pZtX0d7A2vrDyZ3mj+HBzlO0yuDdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7950
X-Proofpoint-GUID: 1kX8OSQ_vUpa3BR-CKocvY-V7Q7S8AM9
X-Proofpoint-ORIG-GUID: 1kX8OSQ_vUpa3BR-CKocvY-V7Q7S8AM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe

On 12/03/2024 00:45, Junio C Hamano wrote:
> * fs/find-end-of-log-message-fix (2024-03-07) 1 commit
>   - wt-status: don't find scissors line beyond buf len
> 
>   The code to find the effective end of log message can fall into an
>   endless loop, which has been corrected.
> 
>   Waiting for review response.
>   source: <20240307183743.219951-1-flosch@nutanix.com>

I responded on the original thread, but to confirm here: from my side, 
this patch is ready to go.

Cheers,
flosch
