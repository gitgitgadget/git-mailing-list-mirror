Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D720C461
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395929; cv=fail; b=aGh9ksnuUZuM+A0KfwuA7Dskenq3D57f99YNNFbipqjo3yxkmEIhCe7bMBDTrZpY2RK9jv+Lrh6lqEIOEX0SajVRHOXyllgtM0rpRHxCGfRIzuu5+uiyWkDmnmB/V/egMJDsrUw8+lO6SjW9jd5FZAXI7u5tMsnEU4e3kve9ryQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395929; c=relaxed/simple;
	bh=M5/eguYq6eZ5o3d3luBO7cUl5QQe0cWZj595diwqKVY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=q43E/bFKR+LmaRBLVG7WRKjBtVapvXipsCXUOgLk1gq12Jo1RdsQcsmh02QjWw+oj4m4Us9pVHhdjKbfk30nkR7n6ttukcuMEzoCe+aYEybSfNgfryAgj35X8EyPX8qdudfJzoaH+vhbRsWkyVuEtWmfUScvZ037rsM2o/vDPog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VM5ZmbEr; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VM5ZmbEr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkNUzSPxkqSPiXfU56bC2hlEJf5JiQYIbL3Fj1ZV+ZtbfZAhwxUmX2JRPIfAet0F+ns6T46rmRha4dlS6J1Np+ODQ+XEa48RZjjTALQfL7qyanA3ebQUjqJKJrvCJ0rzZ1cWpBvg89rHlht8+PHUUbncnYo5d8l+05IRNBK7FTlavgr4O93C0eQnvSAuYwqVD/6Qwckk5kXmzh1wkQm6wfK+/NQQQC6DwkX9EsrtTrjhXqr9xS5cW/w7NRh/bcoc+h4sHhbAAYVdJsP+F7evo3byFXruKzGPhVdlpMzDR7pLRyPkvGC09rukKX5+7Yr8dPPG4GKtMXDIG6vfLabPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfG4Xgw3CbWCF8HDmJ56HeuTGHWfMn4mwDYb0fffLHk=;
 b=UJnm+Gzl8mdN7b7hkydmYG3g8r5/21XGMndadKrTh355b9IUg632J701/n8k4QyItHHpDPpTIkQG5G0x5BlXbVrAtcP0OzFgAyVVq1KTpQCNv4Z62duSENQ/QkCgnwB6dNe6rOgyYt/kXDL1C6aHl35K37StUWfyh/RpF+P5YCSLH0gssbT9RBZVAhaIiL/szdZ1Wn03kj4xT2xLJ5QAZXV70rbqTV3Lq6QnuurGATpptBq/O8Y0jPtTgJAhxhaZhgjh5nGgUyWgrPIhCtKj5qTsPlSDBKlfTFeQOS410ytYLGFXaAI3O9dPaYiXnuqO0R3kkhF2HUIwRs/TpJTBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfG4Xgw3CbWCF8HDmJ56HeuTGHWfMn4mwDYb0fffLHk=;
 b=VM5ZmbEryEUyJRbK/M2osYsdoKbAtsziB1Yy67ma8RKsMJCqUjKYyHG3jEbi0SVfPsVwhr3TZ9JCUaM7Ct0bRhwMm5QmpKCmJngFsBoII++YT4FqYpqtGMIOGbx7Cz9+MP6JQbQ0JwTELPT7ulX4D3X2akf1TpaZs2Ok2erw7XgNlqnfJWu18fTWomhJTYCAa4ptH5jLZ4Wl6QS0SW59/w8IZBLhi7bYflscW4rtJXYyWVPNW+hotcaRXYPz1gefMlRRo0uTIm4Oa0c7Zy4D9QxpWedmwKc7fE79xC55yJqZXeEWA/IJJJDh5r3tBi3mo+PfEE5v/V67etB/7qM4ZA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6554.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:75::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 05:05:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 05:05:24 +0000
Date: Fri, 20 Jun 2025 10:35:20 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
 =?ISO-8859-1?Q?J=F6rg_Thalheim?= <joerg@thalheim.io>
CC: git@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_imap-send=3A_improve_erro?=
 =?US-ASCII?Q?r_messages_for_missing_configuration?=
User-Agent: Thunderbird for Android
In-Reply-To: <PN3PR01MB95979FD989FB98E5F1F27145B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io> <xmqq7c178c07.fsf@gitster.g> <PN3PR01MB95979FD989FB98E5F1F27145B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Message-ID:
 <PN3PR01MB95975D22DBF75791CF1693C8B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN4PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <308F9DD4-33EC-4174-8283-51F9EC17EE0E@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b93b3b-ae27-4ea9-4d99-08ddafb81019
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|21061999006|19110799006|15080799009|7092599006|8060799009|5072599009|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVBjVDhhb25UcGR5MjFiNjYwekxBWXhhU2NiTzE2SG4ySzJ2WXhyR1p6RVdm?=
 =?utf-8?B?amUrNXhHVUZ6WWZmcFZYT1pKdkh5SXhvRjR4eE0yRDM2UE5lNnVadjB6WUhV?=
 =?utf-8?B?RjJkTWptRDA1QWJ1NnV0WXd6TDdRWTNFeDlmdmhtc3RqUkkvUTd3NTNtcnpS?=
 =?utf-8?B?TnJrbStpeTh1TldHMU92MVU4Si9YanRoUmlscHc1ZzlJUThUSU5Vc21SSUEz?=
 =?utf-8?B?L3VISzl5ZDJZUmNVblN2TEdlRko5ejFaU1dWY21icEZBcm9DRmhNbTMyaEFk?=
 =?utf-8?B?ckdJbXdRWjV0S292Z2lMUWp6bkU0QkkwQlJEa2IzZzNYdUtzbXhyTGV0azlt?=
 =?utf-8?B?MHBsS2lSYVB2bExaOFhRQXA1Uzl1ZlhOWlQrTDFaQzVhUzBsU1gwNmM3U0pE?=
 =?utf-8?B?V2x5Mmt0QWNHcDJtSkVsc1pPcnp2NG5kbkdZdlRuNzV0K3BUMDBBV2cvTHd5?=
 =?utf-8?B?QW9DRWdPN1U3M2Y0N3ZvV2oxS2RxR210Rk9xdU50RWdvSDV3endERlZQeVpV?=
 =?utf-8?B?OStjL0YrMkU0YnFBUUMwNlVsVXQrZ3NmSm9JQll5RlEydW4xZFJYQm4xSmVn?=
 =?utf-8?B?bmlBUU1JcUpSYVhiWFRuSk4xR0w1ZWtOK09LMmhlT3hDdjgyM2xtT20vNVhP?=
 =?utf-8?B?ZmFEamZaeFAxVyt6L05PL2JQQ0YrbFZRb0JncEpjaDBjTUUzdlE4UjQ4amgx?=
 =?utf-8?B?Vy9jb2N3ai81VzE5Rk4zVGRDOUEzNkVMQjVnYlFyRmFNb1FWM0czekRmb0t0?=
 =?utf-8?B?cGZlZmV0V3NmNTYyVlZ4WEJjLys2U0tKcytRcUduSXNNNUdRSTNuSnpoUUZG?=
 =?utf-8?B?Ly9EV1plRVY2a0hNTkNTQmQybUVicldGdmsxUEtBbjZsenBNdTRNK2tkUitN?=
 =?utf-8?B?Y3ZVRmoxOVFnZnlsTU9Vc3pFR2pHSkF4V3BpTkM5RS90RUdHcFI5R3ppcGNl?=
 =?utf-8?B?ckd0UmU3aHpvYk9TcE91NHRPNFd5WmJJRVg2QXdkUERWVFdzdUFHVTQwL2t3?=
 =?utf-8?B?dUUrTE9OS3hPbWdCVEFiNWY4enpJbWN0WVhhYkx3VWt3YnpPdjM1N2ZraXZn?=
 =?utf-8?B?cFRBVlc5RVVhdmprUTh4ZHVLMTRKVE5pWW9kL2VxVU5VWHlLMC81Z0xNQ3FI?=
 =?utf-8?B?aGpTamQzWmZmbS9WeWRsZmtIUGZhVFhlYjQwajJvdlp3c09QWG1XWTdLcEcz?=
 =?utf-8?B?cGJIa3pqem1nakpPTnNQUDJGeEtlUW9xcm9BMkorcXhjSWorSklYYitJMkpY?=
 =?utf-8?B?cU1aL3ZLZmhoNVhQdXQwNkVtUHFjM00zb2EvOXdzY21sbTJ4VlV0bW1rajNR?=
 =?utf-8?B?VWJhREh4ak82V1JtNWVpSWZRUUNZNDUrTkJ3em9HM2JpQldQZDRYQ3p0ek5X?=
 =?utf-8?B?NzhOLzZHMGxRdTM1U2U4Ukl2NngvanhqMGtuSnVGMUNPaXJtUnFzVzdpWVdJ?=
 =?utf-8?B?VkRyTjlESTRwRE5nRjJQdHhtZUE1MjdKREdlQkdKRmdXUHZJVnVlRVZBNldk?=
 =?utf-8?B?cWhWdUFtOWU2TjhLbTZUekd3WUJqVWllT2FjQVJMZW1ldVo0RzBDZHZZRHdq?=
 =?utf-8?B?K1lmUklJQmhkNkdWbmJPYmRPRXUwRXpwVHhmS0dZSndqTUdyWUNpcE5kdVVh?=
 =?utf-8?B?cU91UnBKams2MFkvVUJqQ2JPbEREMmc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1d6bUpndnpnbStLc2dZVUFlekhGbXJGTExoMi90VmhCOG9CT0VmckpQV3Zl?=
 =?utf-8?B?eWpNRG5yUi9MZXQvTUR3dDBYVWRkQllXMjJYa2NZMm9FQzBGcGFuOWxWNU1a?=
 =?utf-8?B?VzlIN1R5SERHanpvNEZaNVNqUCtOcUc4b0VERm1tRWVxdWdhQmpNN3kxakoz?=
 =?utf-8?B?OW1kc0MxZk1OaHBpK0hLWDlYVGZlWVpKVFcydlVMV3ZiVTRZZ3FBWGNobmdE?=
 =?utf-8?B?WS9IQnYwSWIraThNWWhqUG1LK0c3Zy9wdEI4cVpVaWJldjhJOWxpRXdHa3VU?=
 =?utf-8?B?b0hGcnVZYUdKN1E0eHVwSjY1S29tRHZlc3I0UXlMN0RCQktSeVJZVjczZnJB?=
 =?utf-8?B?WFhUQmM1MTdXM3M0Zmg1WjhJb3dFTzBBbkE2OTNVWVFLRVgvUTJFa0VxelFu?=
 =?utf-8?B?cHdQR2pSbE93aHM5VXgrdFF6NkVINk5UOTE1c1V4ampjcENCRFFBaTVSbHlO?=
 =?utf-8?B?eFY1TW9YSjk4OEVTV3NvaFl5UVZWS1RwMEpuTDE4dFgyNVBULzBiOVlmRzZX?=
 =?utf-8?B?Yy9vc2h5QXJiMHFkaVFWcUFBREZrMnBsSDVadk5QUVYwaVRDU1BoY0FiZkNF?=
 =?utf-8?B?OGROMll2c1JDbmpmTjJXeW1qRXExdDNlR0p2K3krWDF1OGZMalNCS3lkZUw0?=
 =?utf-8?B?aXpFeXFSK1VCZll6WlBOSHRHUDNydWNZcm9kNFBXU2tHbWRydjJ6VUN1MVdr?=
 =?utf-8?B?R050WjEwQ0xKWGh6c0kyRWJMQW9FTXBsWlgzQzk4YTl5cTg5cXRMYmE2QzZv?=
 =?utf-8?B?YmdYd0FxOFcrSG5RazFLWUhsdmtRM2VYRm9JSnlxNHZobTNmV2I3bURDMHA5?=
 =?utf-8?B?cVFBTFZINlM2bVFNWkxONjlxOHBxK3JzNDVzaVJHanNzdjQ5ZGRBeEFzdFpY?=
 =?utf-8?B?aWR0Nm5pa0RwS2JCaGJCeGlkb04rMlZtVWVKSE9HSUFQY2VXUEJYcHVmakxH?=
 =?utf-8?B?enFtaUhheGtsTlFlRHZKQXBDTEMxSmFxVkF2RDdkV2F1ek9iNXdUdWFVbm1F?=
 =?utf-8?B?TGN2clpGZTRiS2RBcTQ1WlRpS1JsbklLSnREZUJOeU5yL3MvYkxyQmpmbkU2?=
 =?utf-8?B?ZHJicHpBKzdNRVpCUCtXdkRIa1FMaG1GTE0rTm5yM29tS0V5NERPMEIvOGNZ?=
 =?utf-8?B?NmJ4VHBLTVBEUDdQdUFNVVJMYk5NNnloR0lxQlgvVGE3RDJXZHNjclEzOGVL?=
 =?utf-8?B?cUprdWY1TDI4aWFlZDljMC9WRXd6WGU1UUxUVmNtTHkrWG5GWEswYlZmUER4?=
 =?utf-8?B?bGZ2a25sYVBOdmpNek9VZkN4bzhDcUorWTl1T1pYSm81dUxSbTNJMzNKRFdt?=
 =?utf-8?B?eStpMTI0aFp2L1IrWkpNS3dBd0RDdnIycEEvVkJ4WFJlQkFJUVU0T1FoZ0RK?=
 =?utf-8?B?ZWtSbDFZUDUzVU9BZ3V6THdac1hDRXd1ZWlhWlRTRTJocGJydFowWjhLcUxj?=
 =?utf-8?B?K0lLTmtBRStzcWNQZFVxTjUrdzlWaHpDbWpyYm5SRC8wVURva2cvNHNRSlBB?=
 =?utf-8?B?U2pqRjJTb3BxN2t0cW5JTmRpMkgzSGlpWHp1emFpVFFhTEJFRWhoRHZKSFdL?=
 =?utf-8?B?MHBFUHpzRjN5THpVY2RUZVN0d053VTRmbmNtWW5ub21XYjdJMjdYemVBaGR0?=
 =?utf-8?B?SXdtS0tLVE85NU5GL25jdjhvLytpZ2dSaGxpbmRjcFFxZG5yZ1U4WkQvUEVu?=
 =?utf-8?B?U3ErcFNzS056OHJsY0UxZno4VFA5bjVGeE94RE5YTldSS1NWMVN0dWNidVlM?=
 =?utf-8?Q?vBs3vZRI8psEq/Mjt5cGb5o/fi29IdwWbuBz9RM?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b93b3b-ae27-4ea9-4d99-08ddafb81019
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 05:05:23.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6554



On 20 June 2025 10:33:21=E2=80=AFam IST, Aditya Garg <gargaditya08@live.com=
> wrote:
>
>
>On 20 June 2025 6:28:32=E2=80=AFam IST, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>"J=C3=B6rg Thalheim" <joerg@thalheim.io> writes:
>>
>>> The error message 'no imap store specified' was confusing because
>>> it referred to 'store' when the actual missing configuration was
>>> 'imap.folder'. Similarly, the host error message provided no
>>> guidance on how to fix the issue.
>>>
>>> Improve both error messages to:
>>> - Clearly state what configuration is missing
>>> - Provide hints showing the exact git config commands needed
>>> - Include examples of typical values
>>>
>>> This helps users quickly understand and resolve configuration issues
>>> when using git imap-send.
>>>
>>> Signed-off-by: J=C3=B6rg Thalheim <joerg@thalheim.io>
>>> ---
>>>  imap-send.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>>It is curious that you are sending usability improvement patches to
>>imap-send, which I was recently told to be completely broken wrt the
>>use of imap.folder.  Is the claim I heard that it is totally broken
>>not true after all, I wonder?
>
>I assume either the person has used the seen branch, or has not tested the=
 program itself.

Actually you get the error:

no imap store specified

In the broken imap send irrespective of what you do IIRC. Maybe that's what=
 is being addressed here.
