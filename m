Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011027.outbound.protection.outlook.com [52.103.67.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4B1AA1C4
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607939; cv=fail; b=fZKt8QESlrvDg/BlCSkxuxfZpaogSkuxua5lcUJU+TZHwBJBbUxrmAPbrnvirCzD+IltNWJCTS8uqB4B+buF01PUnlRqLJybTOVvFZg1F/RakqWjkkIRwMny5Xz5edlGvFQPmIuSkyLIwiqmWkFvg8klz6MPYQ/UWGfQY/TX46U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607939; c=relaxed/simple;
	bh=UJth6x37bAt+ybz6nNZjhTiD1vIQDJ/N3GSVTYdQCek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JHMsH2NsvGuPp/Qn62T4x6w0fmy44f5Er5nvCKJAoEcYs+mJCbVRTj7vyEFHzd6OR2EN3MeV9XjPq+bw3xxbw6bSy42kT9iE8uqilqHQxAAPyOTTLp+V4YiZ2EX6Dll8gEHWrJFcL/hBeZNefNkJ2pNQByvODj63QIOHWlMQpJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YeEktOYz; arc=fail smtp.client-ip=52.103.67.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YeEktOYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvf81y0CChGI6fuBeOtgUp4LsfkaGA92ePVx4K+mNxVfSfZ3hjOFu6dAESRx6uQvNfs2pdr40PO+0of/Dcn7rkhWzk+LOdAS7/xXsVSEP8d1NNF2VKgDFQIF7tglgoLfNBVZuH+PPeaMMCd3rlRMQ4vpIrOsf9p7rr72tvG4GzutyPFW868xQ+18lsbqYMA1N/+xZqa+ZEVTtINUurf8KXjb5aCPxOj0OQNJ05F7mZFY2Wd9RnEyJTzccWq3D66xvus9tx3BvpqFX+HuQlJidH25+H+QTqjlomoMA4M/D99kD0yHEMBwYh7RWVwMCH61q8ZCeQB8ThwxBSVKOu7n+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3ok4X86GyX1UvKa7XerQdYA/nKLdyBpKTzU820MQes=;
 b=nKOda5mscPe37M8spbU2XDSQt1eF8+/q29QLFWxSKcWDLOcqTcRzCY+kfoA/waJmOnB+09Bu9+PSC59piMdie1MsgsG+2cCv0AcxRzhkJo0TqLR6ZUTH+6hp9/GfVGk676YJhJl+l2W3ZSUsjVlY/H5jJ+gGRwrzsKnqi+jtz6/ENLSpX6RKjfQsnIw/xvcwmCvzyntGOU3Wz6+A871/YWSK02U0vsgPpAsoHhcDssdqTdTvBfWHhMdQPLzNh54foJ783OqgXpHXvf3cjberz6ToQaQ7K43Nv6Ec+bAOrl1DcT9/bVwKOt1I6G4XecdTtUY76AGMLBlGs/cubU53dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3ok4X86GyX1UvKa7XerQdYA/nKLdyBpKTzU820MQes=;
 b=YeEktOYzsbj5EDLzbA6kRJ2Asg35FCJRQnTQT/DGuY2Nmb/PZdIIa37yodHdHAOOcLxjlXET0w4ErqP8aYqngWJAh+nGjWSkK8PoCffvh95wNOMEvtdvAXPtENBdtpg/nMtKXDorKW2PaZvViNJ8Xe0Awf1UaIjQR2Hdd9/HeDi/wHZGdOijH8+ge+rjeJPdPDmDIS3mJi3+HxOQioqst+BAj02qwE9DfcAGRPHvdP9/dgMPkDcNHbzDhIFg49xn5g9sJKfZwzJRfEu1W9kZv+X52hoh+ReAkZkbjndAiTz4yY4wA1L9oK8OUGGVrkVy67CTyCUSDvEKmO31G22mXQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8995.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 19:05:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 19:05:33 +0000
Message-ID:
 <PN3PR01MB959780C23B417F287B87E61DB8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 26 Apr 2025 00:35:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP
 server
To: Junio C Hamano <gitster@pobox.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikmstatc.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqikmstatc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <c2bc0b49-8e32-45db-80ce-edcb98e901cc@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a17dd75-eecb-459d-42ba-08dd842c2725
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayFXX0mVJp9wZC4LLIW1QoQ+eBKmPVkEXbfTsjHqeGgOyTY5kz4rOoS39LK+lwB/ttEyMLr49GPNFGr3wRHfpsRd+RLxaRFGoBJIVrWGMj8fiPT/+2ByjELFJMdmH/pJp9Hj9kzcPL/Pvx/8z5h4uiKs90z6DrCLK9dHUM083vFkxh0oLCzfcY41IPgUoMt/Gc0iZtXUmVtNGi63mv883/zooY++ZWTLSEZj18HwHR819KvktUT2FBZqCR36l0r/AJgWGwuHAQv2F2Nm7e5xyC+wdOcgyA6V5djXX3ac0kprj+y2tXvnqk9da3GwixErSlRlIdCeF2TuqRz1tl+YcBlwYuNgwZvevMubElegErFUAh8wwOqsqvitWswj7tZ9wvop/wJ57kEodAywGf35xePu0sI193wo0g+S5YNnrEfEPGa3kpjUDCmtu316T31JDnDNvnRmzwNVN1T7RpNXs2VdZrWWXOKXHU+jdbXeeoRdul/WSZKA2PQDenMMV8wuw9gSrkZudZaJpb1DgOMIT6blijO9+FdjyZGbSfk6DsGH2ro/v4QDpyruwiTxaUPuc4HpZ9jWYI6tY9YcLuFGlbQ0nvBucl6q2+FPBu6VZjobPoE+uy2rKHuinR+Q7zU6DT5+YKZgaIT2N/MEXqJfK0/A1uCYHhyQ6PkDJRpfHTkel0zOXgULozpUxIg/Ojf6YYdVVPL7L5FYto+dKtHFmEiAFXXt19r15tM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|15080799006|6090799003|5072599009|7092599003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajlYOG1IdU9kNElyT1MzN0hYWkdBZGUvdW13Tk1PRlFvQ25QVmNRMUxOTzR2?=
 =?utf-8?B?ZndqblRCNjI3WHk0S2NRMUt1QythMW4rMEJhdm9KWW1uVXVFZExxWHU0MHJm?=
 =?utf-8?B?Q3grSkZtbDBkMDdVaEtxVDhqdGI5WGcyTDFndWVLZzhVSGZSSDdkcmFwajcz?=
 =?utf-8?B?ekp5WDNzL0JmWTZmSk1BbEdadU5RSXgzQUpnblJXUWpmQmZBNXozNU4rQ2NH?=
 =?utf-8?B?N0l2V2VsM3FoMVBvcmx3NitUeTVMWGYyZTFuYUErTEVHc3ZwNUllMk4yMnE5?=
 =?utf-8?B?VTZENVhqNVlKcCtRWFZ3eVdpeEt4UzJiQXMwT0RJREo4VXc3U0pGUTdISTd0?=
 =?utf-8?B?L09XQWFMbTAzSC8wNGpjckJkWnVSUzI1a2EraG9FR2JsbERDNUE1UVZjam1z?=
 =?utf-8?B?VkI5UDhkbE5UdUlBcnJKajJCK3paMDUwY2IyTVo0OHpYS3RpS0RzY291d0Rv?=
 =?utf-8?B?Mi85aTRnM3l6Y1hiTkNHUWYwVUZOblI4WUx0TnJabEE5aUpjYktrTklXS1Bl?=
 =?utf-8?B?RXh1aXJ4Y2NCK1JsYXU3cUY0MGY0ZUViS0E1N05Wa2M4NHQ3dlZsQ3MwdDlM?=
 =?utf-8?B?SzhITmRsbjkrQ2poRzV6VC9EUWkvc1QzY1htV1JtQVFzK3EvN0dwNkdEbFoz?=
 =?utf-8?B?MDZqS0lBdkxIR0JrWGJCVUNIcDk4TW1UMG93UW9WTlhCTlpWekhOdU8zUmZa?=
 =?utf-8?B?T0ozS0FlZ1BiK1VXUDIyRmdoZFowd1BGNSt6OWxBVmhrZHE2SWsrdm5RdVRN?=
 =?utf-8?B?anY2RVVBbk05ODF4SnhWQWJEMnZCcnlmNVJFN0lEeFhqUGJMWmRaMmNDd2dE?=
 =?utf-8?B?VEtBc1UzZGxBNjlRazVITDFGTWxrdkttOEhXSmR4Q05oc0Fjdko0eGlweldu?=
 =?utf-8?B?M3VrbEM0NHE4a1A4Q3JQL0ZIdnYrYWxsZzVNSytRTkZsTkdlb1owamwwdmRs?=
 =?utf-8?B?RWE0bjY1ZXduVkNVOFlZeTFpeXNPYm1KR2ZWSGxPSWdmK01uRVMrUVEvY0J4?=
 =?utf-8?B?dVpydFVxV2dwS3gveXl2cGN5ajk2VXZrMlpYZ2VWNkdaaGlsK1I4aEVHc295?=
 =?utf-8?B?QWNqelFmQlNnWDF2UExwU0ViNXMvN0dwekcreis5SGM3MHJiVTZXNFNCTE95?=
 =?utf-8?B?SUFjVFQ5d2dlUHgxdmtLdEg3LytSN3BVdHJMbHVaTm04cy95MDZOWmIrOGsw?=
 =?utf-8?B?bW8zOS9OaFVlemhFd1dtdVc0YVlaS1N2Vjg0V2J4SkxVeklORXVacHdCRFht?=
 =?utf-8?B?dzJmQ0xZQzZkOXc2eG5WQUkyTjFhRzgyZ05NR0VEbFAxcFk2N3kvY0xCTUpW?=
 =?utf-8?B?UUxpZ1ZlRm5pVWZHUjkvQmZud21HME1jeWc1dUxtTDUyUStIRVBlVmZ3MWs2?=
 =?utf-8?B?Q21XRlNjV0kyMWxrYjc5bWhkV0dxU1NRWUJpdDR1TWpZZFBabFJNWVUwaW0x?=
 =?utf-8?B?RTIwQVhIS3hHWFpGcjdZSDJjTjlUTEdrbHVRVHJUYW9mRk1QQ1llSUl4Zkpt?=
 =?utf-8?B?YUJpNVlnS2tDeFc1MEp1N0srZ3FpRHdKMUtCQk9qaDVVOURsSGdpODhVRE5n?=
 =?utf-8?Q?LZ0mTWZ9Eybc+j8Q8J+gH6Ajk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTVwLzc4d0tCeHVqRnJFQXI0OVdsTDVtSjA1dU9wSG5ONk9nZTB5RXJNWnFk?=
 =?utf-8?B?V3oybkRObFYxcHZybm1XL1hETzdEUVpzUnoyK2RRRStZUVpsVlRteThQMTlX?=
 =?utf-8?B?Tm9zV2NiR1dDRys4UU5hVnBXTW1iejFjL1ZzYTRUNzlOY2d1cG5GcHJTT0pU?=
 =?utf-8?B?SEFqZjJOSHFmUDl6N2J6SCtSQ1hPSC9CWEhiZlByNW9kK1VPa1pPRytLeVZh?=
 =?utf-8?B?dEJ0dWsvOXlqdDJIU3pLcmtIZUlRc2UzNGt4OUJyczk5TDF5bS9uVjdtZ2Mz?=
 =?utf-8?B?NnlaQ1hUalhzOVNtL0ZRZndac0MrWHNaY3RMUER1UG5hY2ZOMGtTK0IyTE5p?=
 =?utf-8?B?dzBNOHFwS1c4T0Fmb0lUNW5VTWVibVZqR2lGbC84MUgxMkxwOXR3VmlSUTFC?=
 =?utf-8?B?QUJtcGRNWlNid0xjMWs1OWVWZmpBODVDTnZPWGNYK3BreE5uWUt2YmtuUjBh?=
 =?utf-8?B?V0d4SkkwcGdZU05QQi9iYitqaU5KNzVKMGV1clVnUXVtcit3SGlOZTc4cEFQ?=
 =?utf-8?B?d25iSmthSVNnL0k5OWJKRTNKSERFNklUSGRVNDhNRlgxMU9BZ0ZMV3hZMEdJ?=
 =?utf-8?B?MU1GV3BrT09ITTNoQ1dadk5tVnZEUzhORmZKWjgyZ2NKcE1qb1ZwaVpyN1ky?=
 =?utf-8?B?WWNLSytXWHdaZ25TcG90bFhqNXhZNklKQnFzR2crZEgvUDlrS0ZjL1B6ZWlR?=
 =?utf-8?B?L2NRQzJRWEx6Z3pFalhSTCtQSzZvdE9PblBZQTZhcEgwVTdoK3JWeHlsYi9j?=
 =?utf-8?B?Mm5KdExXT0JVYmd4ZDIwR0xVYzRvOVBWTktXbTdJbVJEU2ZLd2F2T2c0R1g4?=
 =?utf-8?B?cURleVJuQkpZRmdvQjRQT0dQbVdTd2RweXdyU1dTVE53S1FZSys0alI2TVNa?=
 =?utf-8?B?cktvci9vM084SjFvWmR4NVRNVGdYUHROaWxiMm15U2pvWHc2WWgrOE5aZDJq?=
 =?utf-8?B?UVRjSndYbzdPRC9PZGx4cXI1cEc0b1NPd25COTN1dUlheWFaQUd2RW1QSzdw?=
 =?utf-8?B?bjNkdkZqekttUFJlTTV4V3FGVmNXeXZ6SGZ4THlGNzBtVGFzdlg3bjVHR3RR?=
 =?utf-8?B?ZFhsVGF3aTZQck9TbzhRMDZ6VFF3NUtwNmtzNE1pYU1OcEp0eGRQRVZmOHUw?=
 =?utf-8?B?eTRjOUZpcHp3bnZkR1lZTG1KRHg4STMwczFRcWpUUFZNeEhueXVGVnhYVGw1?=
 =?utf-8?B?ZHF2WGdKRE00Z21NQ0lWcVdraFJpeDF6dU1JdEx5YW0ra1gwQ0grWTZwSDFF?=
 =?utf-8?B?cHdnYzR2OEMzb3B6N1B2azlMMEJxYWpObjVkTEljempRZlk1VS9HMFczbWRm?=
 =?utf-8?B?cGFPc0JlVFZPaE1OeDVrRExxWlF4dktSZXozYWFOU0hYYWUwbU03T05LQy9U?=
 =?utf-8?B?T2hHdVRRVXVPdTl6dE5vN3hnRmhYL3AzSHN4WEp2OTRWYXJCSWVGeDZFSDRm?=
 =?utf-8?B?elVsWU9IUUhXN0JDRFlKMFdydmtPZEdWRnEwZDJhQktwN3pxSEFqUi9na00v?=
 =?utf-8?B?TnRtQ1BFQ216dmlZbnhLd3FQQTY4Y2NCUHRoMmtBOGphWS82ZUxRdmd6RzZD?=
 =?utf-8?B?VEk0Qk5ydjhCOGVibDN0SnJadFBwYUs5d1dIUkQ5aE5td2h4OWpoUUppb053?=
 =?utf-8?B?Q09aZVkreFB4TDBWT3RRQ3VuZkhDMHV0bkhidlhDUFUwMjMrVFFnLzZFQkpI?=
 =?utf-8?B?bGNTTThNOU15QXpBYnN2NEFEUCt6NThLOXh0Q1hDVVZ2T2RKdVpON1lrTVhr?=
 =?utf-8?Q?DxeaA2vzYUACwrQvm8=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a17dd75-eecb-459d-42ba-08dd842c2725
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:05:32.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8995



On 25-04-2025 10:53 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> +sub is_outlook {
>> +	my ($host) = @_;
>> +	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
>> +}
> 
> There were a few messages that raised concerns with respect to
> on-prem installations of Outlook based servers, where the hostname
> cannot be used to tell if we need this message-id tweaking.
> 
> The following is a completely untested patch, but it should be
> sufficient to illustrate how simple it would be to support an
> option to do so, if we cared about the issue enough.
> 
> Will queue your patch _without_ this tweak, at least for now.

If you really want to make it configurable, then an auto mode should also be there.
In that mode, it uses my logic. I just prefer users from having more out of the
box experience. By the auto mode, we can both configure it, as well as have an
out of the box experience.

