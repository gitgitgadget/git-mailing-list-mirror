Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8F2A8C1
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395810; cv=fail; b=MPheMInxMeNBP2IKnI7JfMlOfLnE4hIsa2spnqRpnxkKEm7mIzOkmBkWn03FgI1N9/9mtnLfQ3/iSlljR1i1c7DBBoGYGHbqfRmWIstTtEh9uwriOt6C0eVntlvqaLdiAK09SEpZRzz7K+GxNosXu6oPDDotBoy0I8p7QCI4cng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395810; c=relaxed/simple;
	bh=02f/AvQOMb43Mge1SiB0nEJvFepXfc39i/L48NpEu+U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=rCWCVbLctS2W5m1p92XMd889DxoxWejOPB5mc4e/lQDfDe8p7uUXv+BhSyr3I8n+1XesHipe1DOqmosrnfoCam9+d55i4LvY0JeZJlXHYrNY9DjYyv6qoXmq23l2HWWb1x4BvJtU1N78FOyn3roR6j5aTUxXXcipEZsRHAYaoqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Umd2J5q1; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Umd2J5q1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iABSL7Y+lSPnybsvh/F0zlfdi3kLJKgPtfDdPOQQW2vBZ0d90vVXmE+w7Jb380pJ82+9C3aRbSI5WkbiuQLoMPMMr6+xZs6ZOkYWReajc2l/EfB1q+mW0480o/pNk0q2zcdyKWLi9/0p3GuFOcSkjfNYe75v9QGImDRbjUR6CpIW7nCLHwsFF5wr6OSuhrC5Trbi40x5mSovX5RGIkqZ0gMNzpG2Gl2+NXehoP35xceu6DHVwPiN9OKcd3HS5K88kVKBhbBdPoFRoqtAKjsGIQuzm3BOHC6MWe0kNY1xnRazKkmO9bxy/TW53NEy7qZZ4gAOKfafLzSPd/U7hbhcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZmog/r0HLRIB0vI7EE2VPg4b9mk3TeHp56P7+wNHWY=;
 b=Bx0fIfA+2iKQSyrSsenZbbH81+gZUR20YXbqlG99+4DGjrGRdloMgdGBfPnB/XLlFppfjCYpXyRioAuTAblAf8nT0BXXy+sLUb5F+s5L+25/cESjIzitnTqqFUAJkounmGhSFoZb6N2jzRqRxnumCxeAabtkhdXitYXRi2N75SvAcqoJzPk9CghE00alyjuFVXamHNeCiPWCJOuIkoHm44vW2Iiwbm3CXUuP7Pn7mCbe/Sul0VHENb6z5kJyL8Y4NvzhzJghyuSo8eH25bKBjSxH65ffcX1hW4n9WMdE7PU5iuRalc3H2hcpb1RPHmZHCXWFHj7K7Mhr8a4isPIrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZmog/r0HLRIB0vI7EE2VPg4b9mk3TeHp56P7+wNHWY=;
 b=Umd2J5q1LNX/gusEfRPo3O5AUqC4N5VRi0jMOyx5I+hlphLYB6KSIGr9TQeEJBQqDkHx2/BC7ivJcTVwD0VyY5/jvgL3lEMgN2labeB5diqbZTslwl2a87dq41dtbofxQcyGatEXBOQrc9RkGswMmVeoopuFXc/KW/TWV4r6gMVUXQkN3G/stmHfTzVoSVq1C31iN7K/zIR0hzh8TdpmMmPHMJ0A0mPApT0SE6mhM7J91M7MThpmcmCOk++1ndL6BLN0jAaLrXMzYTrx5CF/+xGuXqsG4w7UccVeOIlIqCDrykyKOjVXk2Yz2sXDz37Fdog+yPiat3YpxxKrw/O4JQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7230.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:45::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 05:03:23 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 05:03:23 +0000
Date: Fri, 20 Jun 2025 10:33:21 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
 =?ISO-8859-1?Q?J=F6rg_Thalheim?= <joerg@thalheim.io>
CC: git@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_imap-send=3A_improve_erro?=
 =?US-ASCII?Q?r_messages_for_missing_configuration?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqq7c178c07.fsf@gitster.g>
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io> <xmqq7c178c07.fsf@gitster.g>
Message-ID:
 <PN3PR01MB95979FD989FB98E5F1F27145B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <D48EB9AE-46DE-453B-B13D-63575EBABC4D@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 1759e6e7-7148-4ea3-266b-08ddafb7c833
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|21061999006|15080799009|19110799006|5072599009|461199028|6090799003|440099028|3412199025|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEdmMlJFNTkwNGp6cTN4clo0QUszN1ZaeWxUMXRwQW9VaU5OTUg1c1J0Yysv?=
 =?utf-8?B?aEhYWkRwQm8yZFJaNkNwMVcxMnZjSnRSWEdtOEliQ1VmcFl4T1VRcXF5M04w?=
 =?utf-8?B?TEFZVyt5UFcyOXg0dndQMkhOcmVkVlRxYzVzRk1yMkx1TEN2a1ZYOUJLc1pP?=
 =?utf-8?B?RjdEN1Nhc1VyL010d3RoTW1pTWM0L0pvbmV1L1VRMU1lcnQrajlZQUZZcGR0?=
 =?utf-8?B?VXoxS2xFK1N5RnM0akk5SEJnNXV0SEp3aHh1Z2lhN3AzTHBSWG1RdzBNTDk5?=
 =?utf-8?B?N2dZRm5ncU8zcUtlSjVvKzk5R21OMG1haFFYQUNaVWF0ekdWU1NyS3ZBT1BI?=
 =?utf-8?B?NGN3ZEtuTytNd1RTTnhDb1RVaTh6eVZZdU0yRTluZUdmR3pyeXM1cUNzN0hm?=
 =?utf-8?B?dXluMm5hODIwNEtCeXVHRHdWKzdjNFZUU1dZZG5EMTlkTTAwSTJTVEJ0Q21I?=
 =?utf-8?B?cXUrbUtiTE9UMmlHLys0cXV4SEltU3ZuNFI2N0trQWZKS1hqbXhURzdBYXBJ?=
 =?utf-8?B?aHBHNFFVYXlHWFZ6RDlmQTVvVFIrczRIRUdGWHpWZzlUNGVYbG1KakwzLzVQ?=
 =?utf-8?B?RERNc0RhL1pDUDRzTk1pK28reU03cEo0TlN1ZEZiWUlqUnpCZTVkOHk4c2hE?=
 =?utf-8?B?MU9jNFhqTkJzMzFjUU9LcXV4cUZFelowbUxXQkROVmRiZU93emxabHNBYWtz?=
 =?utf-8?B?N1J5dVNZT2JOUy9wajczQS8wWVRPVzRYWVh4SjdPdUhSMUQxVk5ZUThZdk1X?=
 =?utf-8?B?M2FpZCtvNGhHTVlBODZTOWxsQ05PZUFmWkwxMXR0blp0cFRLRDRQRjFKSk5B?=
 =?utf-8?B?T3ZlQVl0ZkMzYzhFZXduVE9OUWNKYkV3VmFRVjVCT2Z1OFN1UVNpeE5tdG9M?=
 =?utf-8?B?L1VQL3NQM2V4UmtKSHVUbGoxSDRIZWRhcytwblJNcURENWZ3UHZ0MDZjcXpU?=
 =?utf-8?B?My94UHNFOU85RjhKOFRiN2ZJWjdrRE1DN2RjemR3Lys0dmU1UFpuVzlodDFZ?=
 =?utf-8?B?Y05kN1Fnam9JUG55OUV6clg1OUF6NU1nM2FBMXk4dkR6NFMwRlhFbUxjWE94?=
 =?utf-8?B?WjBuTFZuRUoySm83Z090dmRubEFZcVA1cldBbXJ0NXFoRm9iWWRTUy8rSTJM?=
 =?utf-8?B?ZDlYWHdpVUJ5WEM5c3Z4YjN3bkM0V3BGdzd0UEtmNnRYNFFVZUg5N2U0S0hv?=
 =?utf-8?B?ZzIyT3ZVM0xHdFhoT0trZ0IxVXBOU1NFWXZLekh3R2QzY3pnOGVkbkhsQ09O?=
 =?utf-8?B?ejZmQ3F4dWtYRDhUR3pKd3pHMUJTY1NQa0RsZkcweFBhUjJFZVNpUU1lNHZP?=
 =?utf-8?B?Y204WjFMVHJYNW85ZDZaWmVKTFdmZ2VYbTg0MFpjTUZPeTM0YlQ1cG12WW9k?=
 =?utf-8?B?Ykg1V01zNFZIbytzb1ZBdGd6UURYbmorTDFMNUVGbDJPWVZJSzVGcUtuVVVr?=
 =?utf-8?B?Z1ZkV2Q3TUJWekVlWEltK2g5L2V6MTRsRDFBMGVnSzE0eWw0a2RBVjFncG5w?=
 =?utf-8?B?RUxtL0RHNWM4cVRlT1p5eis2bllKZHB1SHdCc3crbHVwOUFCcWlnUGdRajg0?=
 =?utf-8?B?SWZRVldJOHo4cnhSRTJ1c2h5SmxHbTk2WUt1L29ycEFZaFpjTUFxN0F0aGdk?=
 =?utf-8?Q?7xM+S74Bdk1KsQbaxr3yicmzqJzWo6qKK6auQDoxJLx4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVR6WGE3SjcvVitpcUp2cW5taWJCTHZUZ2gzbk94b2t3Ny9xR2tiZHZZa0o5?=
 =?utf-8?B?alZwVHROOHVsL05TcWxpUnpQbXJCdVB5eFB4eHFiQWNQUUtVK0xXa3hQelFD?=
 =?utf-8?B?cFUycUUrd1BNWGt0OGpCMU5lS3RMVkRCa3RKTTV5TUsrRXlkdm81STBTVE9F?=
 =?utf-8?B?NTU0Y0lnRG1oejBkRHNwVGFsTGtlOUVOdVAyQWpaOGd0ZDZtN1d1Y1VodnJL?=
 =?utf-8?B?Zm5sUHpGSmVjZVhDRUpDQ3FBaEZNSG1uMytlOGtNQld0UGlVYzV5UXhYWi9U?=
 =?utf-8?B?VzRZZXFjZ2crcVBTZFpkaG1rYmp5bCthOVZlUnVzTklCY3BMZzB5RTJMRmFM?=
 =?utf-8?B?UWJVYlo5S05jR0FmcWNvbVVmeXkyTFQ0MFlQRzdKa283QVUyWDJYTnJWb1VM?=
 =?utf-8?B?RDdPNG5QaGpuMDVpU2o3TDB3Y2p6NGY1VW51ckV1QTNIOS9SY3JVcHZ0MVBL?=
 =?utf-8?B?SDBnTzJXUW1Od216Tkd5TXFnRXpQWWlOTkJEOE54bFZoclJpUFA2TklmYWxN?=
 =?utf-8?B?R1J5NTdtSDFBc1ZlRUdnbnBHNmQwUFZLZ0tSVEF4dWlzdEZUeWdWT3NxNVNt?=
 =?utf-8?B?cmIrRzNsTFp1dDh5NWFZeTQ2VU4xY2NrVzBURnc4WEFyK2tkcnBnR0RkazFt?=
 =?utf-8?B?T0p1Wm1weGNvbnBlUjQzd2l5bW5DWGE3MzRyeDB3Y1ZDem5GWW1PVU9xSjZv?=
 =?utf-8?B?aGZMeWNjclE3ak9NYTNRQkxsNzF1LzJOSFBUMXNINWg4UXRGYWFqaVdVWjRR?=
 =?utf-8?B?cFptdjZEWWMrdkpZT1U3dDZWZ1hLd2xlVG1hSGF4Yjk5Y01OdnJ3ellIeGZn?=
 =?utf-8?B?MWdMR2ZyLzE5M1hvK0NhYVI3QWZLekgwbitEZHpKa1JOQWtEUmVBckJrQyt3?=
 =?utf-8?B?S0NkLzFCR21RMlc1Ylk4U25IMEpFWGdhT2VuNEN0a3FuV3lVL2kxY3hkcmp0?=
 =?utf-8?B?YkNlalc3UHdjRW03U2IwM1dFRlY4OENpcEEvaXh1Z3EzaHR0VXVVMGd1TDhS?=
 =?utf-8?B?dW9mSzI5ZmJqZE9KNXIxNUdTZnQyeTd6c0lNYlJmbFhYQ0NCUGdpOVFnK2Vi?=
 =?utf-8?B?ZGgyQkdyZlV2eWUxNWRtSUhxYThlUDlZVDRWNThrZFFvMjFnek5xckpLT0h1?=
 =?utf-8?B?c1pSdmdpSklOTTV2c25XQjk3SWxxb2NQWHVjRjU2OU9RNHVveVJaRERBanpw?=
 =?utf-8?B?bzZ0aWE0d3pTRWxDSFVuT1hvMkdUcCtDT0MwYnFqcm51QUxpcHFoMm1NSzQ0?=
 =?utf-8?B?MjBiYVdHd0o5ejVuTllqL1NTRUxEZmtwRER1cXd5b1JjOTI2UEs0ODBWRER1?=
 =?utf-8?B?WVdpRmh0bzZTQnhDaG43eDhneWNGamQvcE5JaHdid2FyclNadHNyZTBmWlcr?=
 =?utf-8?B?Tk5vWENIL2I1ckU0djdEMlhTRmpZeW9oa2FrYXVJc1h0cmV0RjRRVGZ0SWNt?=
 =?utf-8?B?UHdFZGJLUjJxa2ZtVnhLb3BqZ0NqekFSdUI4bG4xd3ByZ1pQbzA2UDRnaVBr?=
 =?utf-8?B?NklrTlRaVHQ2MFhMQ2N1OWhsZ3hObHZNcytvek9rYUJrR3hralJNaXdpeGdh?=
 =?utf-8?B?RGpzb1dlUUhZdHB1RHJBOFBxMU1iWU1kaThtRlkyRExYcmhFUzdVVGdOTnZK?=
 =?utf-8?B?azl3Ry9KRGhZWVhVSW12KzhleFZEcUYxK01VRVVHenZlKytLcjhjTEoxWWUx?=
 =?utf-8?B?Z2tqeS96Y1BieHZleVQvQWh6QXVIMmJzOERtK2k2ZTZ3MWFnMlROYk5reFhv?=
 =?utf-8?Q?Httwji4SxpzPSo4GjqgvExBz7wv3CnITyCPGgz3?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1759e6e7-7148-4ea3-266b-08ddafb7c833
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 05:03:23.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7230



On 20 June 2025 6:28:32=E2=80=AFam IST, Junio C Hamano <gitster@pobox.com> =
wrote:
>"J=C3=B6rg Thalheim" <joerg@thalheim.io> writes:
>
>> The error message 'no imap store specified' was confusing because
>> it referred to 'store' when the actual missing configuration was
>> 'imap.folder'. Similarly, the host error message provided no
>> guidance on how to fix the issue.
>>
>> Improve both error messages to:
>> - Clearly state what configuration is missing
>> - Provide hints showing the exact git config commands needed
>> - Include examples of typical values
>>
>> This helps users quickly understand and resolve configuration issues
>> when using git imap-send.
>>
>> Signed-off-by: J=C3=B6rg Thalheim <joerg@thalheim.io>
>> ---
>>  imap-send.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
>It is curious that you are sending usability improvement patches to
>imap-send, which I was recently told to be completely broken wrt the
>use of imap.folder.  Is the claim I heard that it is totally broken
>not true after all, I wonder?

I assume either the person has used the seen branch, or has not tested the =
program itself.
