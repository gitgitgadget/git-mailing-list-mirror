Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2117.outbound.protection.outlook.com [40.107.116.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B53BBE5
	for <git@vger.kernel.org>; Fri, 17 May 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949767; cv=fail; b=AGP/AslxWRT3/y1WbtdLJOOop5XLeYPDm8iMvOtOn2YPAn7Hthx38E7Eq6QrDa8N8Xg0DbYxYWeGd2GN/OK8G1djXKWDgJR/C/Npps482CPvOzPe53uJMWPTM90gRQ9tmLBCz5wwlj6FRtUiyEJTw+oDnxbuoGax7blIG115fao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949767; c=relaxed/simple;
	bh=kK/g5zxMzYbkQaYvPmuUmRZVqiDZpwDD5SAmrXoZshM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KXkJVM/BEdyG4MWy7GaaI5ANiEvZtNWTk3nZowWD5oW+uP8jnp0ShFujDLyCHDzk6i5dZbE08FRpw09I6cF3X0neyFglgKdBClaD9gc1TFKZg1MBEbazFRXJLasnww2wqc1OPy8uyqc/SR84h2Pht1qauo2RswQ8pqfU3TjbM9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (1024-bit key) header.d=xiplink.onmicrosoft.com header.i=@xiplink.onmicrosoft.com header.b=PZ0fgLeC; arc=fail smtp.client-ip=40.107.116.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiplink.onmicrosoft.com header.i=@xiplink.onmicrosoft.com header.b="PZ0fgLeC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hagT+a/eXVlHBwOpGbRyKg+q5GPPrP6enAjPAzDXH7Qpu1g+iU201A/30Ag9duz7NM3uE5AXYBnPlvTAEm0pqlZ+paDdkL9ZGa4YM51UtLpVjRNsIwh01wc2Svj1RSKTeJ3yMSNSXP4Hmd4MD3sIUs2OHHM1y0d9+G/Y2/q5rFCnNsYCCtGT5LVp0X5svJVlGZi3MSETY3KYtM5HdzNyjOQAEqfM25lxxolWX8XidwmGXPfVLOdl8XeiclCPIPL1eU3bNBrtK7BtZjCza6LDkBwQz5IkciQyjSHgIrhk1bYahXl2i9IVReM4brQ/OrSAc8O2HfgRG9VFY+iMVopq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/n/1UgBIu7DtWRkq+Bhr2HId2BzT+8GcRW/Qh+AhDo=;
 b=TX+bgiLy2UgLt9El36rHGOCepHkm64PyCE9l4saqlkI5CF591GSW2er3KzzW7AMSUq0QpPfyJQNeVF/AeS7SZrZZDKpppgN1/as5MtrbSD5JSgYciOIAXv6nYtfH45NLzRiPxHA6QrnQwOPZ+N61q12cKoVwn43whZB594suMBxur7VzJ8EzH48u9VdiFT81kY+nU44wUPV8ctkfwgAkPZ1hEu233WTW4M5ofhhAQNN8Jse30Av9xASA3k45T+VvttjCIY6crxzVsJD11E/aTVk/hfM8kXVygiqYwGeUTKo+ID9h3G2+GCExvGahhAwY7lZWsLYWgVyNNw0ogzER4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xiplink.onmicrosoft.com; s=selector1-xiplink-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/n/1UgBIu7DtWRkq+Bhr2HId2BzT+8GcRW/Qh+AhDo=;
 b=PZ0fgLeCUvgZtSJB6hluMFvLliP2pcmmkwbV3F5kTWNgiGnAsyvQa0PSSpwArF6jzD6a6pRR44WTateyv2bKc+ZQvAX/0n2fJb/buodveLSosjJ3q24BhN5jiyZ3W9/P4qguYfWynY7xHCyLwrCgeofw9Hnnn6Lo6gTVuXBa08w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT4PR01MB10598.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Fri, 17 May
 2024 12:42:42 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%7]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:42:42 +0000
Message-ID: <6620412e-a8ea-40fb-8823-13c4b33e9808@xiplink.com>
Date: Fri, 17 May 2024 08:42:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what should
 happen?
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy189o94c.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqy189o94c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::24) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT4PR01MB10598:EE_
X-MS-Office365-Filtering-Correlation-Id: f195f543-5ee2-4f01-58c6-08dc766ed83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVVyekVpTWtuVUl3eGRERUtIL3dwWEpzLzMrZm1nTHhtNnUxQktRclRZVEMw?=
 =?utf-8?B?UloxeWN3V1dKdnhud0x5MW8rL0RROXVCMmZLZElTRTFwend3TEMwUmJublJP?=
 =?utf-8?B?eTVFSzJWZy9YWlBxYjI2U2VZanE2VjZTYktCbTh0UktBRGE3RGRyTXJ6a3RY?=
 =?utf-8?B?bklVRzRkZEJXdlplcnhKK0Z5Mi9Pd2JucFAxV0lzOER5SVlsaFVBdlVNamw0?=
 =?utf-8?B?cHdkOFA4YlVPb01ja3ZOaTNOYVNQeGVEaTJWc1Q5TUwwTVMxMisveHZwZkhn?=
 =?utf-8?B?RVUvM3cxZ1VlWTNPUjRxSFFjYmJ4WVVxSmNKNDhGZStNNm1SZjZvOXRRTS9U?=
 =?utf-8?B?NC91a3dhbkZCbCtLL2FBWmUwTkF4RnIzQm1TcUtMTmhlTXhNczR4ZG84emZx?=
 =?utf-8?B?TSsxclVDRVAzMnpaaXhLUFFSbHBxMXBobDZoUFRUU2NhaGt1QW11YjcyeWZh?=
 =?utf-8?B?VTdSKzUyUG5vd05hdXlidXlOSVdxRUF0Nkd3dEZlQzlsTkQ1ZzEva3YvalQy?=
 =?utf-8?B?NzZGelc2TmxyTlhvWms2QmVxOTY2M1dxSnFteFhzdnpxL3ovdW5kMnNCbmtJ?=
 =?utf-8?B?clVVMWVBaXN2TE84N09Sdkg5Nkp2MHZTZUNYbzZXbzdvQWNxMk1wYVhBV0pM?=
 =?utf-8?B?OWdKVlIzejZxa2pyQTdpUnFFcy8zMktXeGZaTlVpTUFETWhWY1BBL285Z2du?=
 =?utf-8?B?Y3N5alhvekdvUjh5cFBMRVR4N0FBTUI4Wkkvb2M4MXlQUWhOY0doMVcrNjBt?=
 =?utf-8?B?Z29QYld3eDJTZ1FreS9Kay90cjVvckprdlUrbzgrSElPcmo2N21lTjFFdTJn?=
 =?utf-8?B?MThYTWhjaXFGWnpnaWovWkRUcmRBNVpaYWdxNmx6dFRtbjNQanVVcE4rdUo4?=
 =?utf-8?B?RGJTdFVjU0I1VVltS0E3RjJidUNqRU5pU1F1YXEybWUwSnBFNVU2YTJlQm9Q?=
 =?utf-8?B?K2JwSDJSUU13YU5VYzFLSmNrOFhHcDdKZ0N2UmNaellRbENPMW5DeXN0MWd4?=
 =?utf-8?B?cWhBRzRKdXpXaVVKbmxSUTNVcVM4dmZtcnRrMEtSTDRtNGQ4QnE0WkdmZFlM?=
 =?utf-8?B?SEtIWHpRbk1OVFRZMGk3cTNyQnN2N0J1SWkzQytFOTRuMnFmU0RyN3hIY1Q4?=
 =?utf-8?B?UlgzMDRGcVFjUGVYZmVGU1dKMlczRENVQUNWcGllM1ZkK01qRmdDelRuaVNy?=
 =?utf-8?B?OUpnbWRhMDJkZmQxV3lZT2hYSjVneUR3VGVFaUVBL1AwN2taSTErSTkrQ3FN?=
 =?utf-8?B?YXAyWnJ5dUt2TzNha0wvL3pjMXREN2t3NkpyaEZkZWFIN2JSVXRnVGx6V1pj?=
 =?utf-8?B?SVBLSmpwQkVycFB3OWxCMlVDUE00NWpzTk16SHlCWDVtMGFxTjNKcnVhNUVJ?=
 =?utf-8?B?dTdWRUl4bFBBM20rdkNDUmNab0pxMk5zVlNqd1hkQVNnUm1Vb0xKRzcwc0ps?=
 =?utf-8?B?M1U0MzdhazNvSjRHS0pzMWJOMkt4eEY5MElFR2E5YzRydXlQdWZOL2dCN1VK?=
 =?utf-8?B?WHRpL0FkZklTeDRldlpiKyswYVZPRU9FdlZZNnZScmltV2xmM1hBRmRvaUZV?=
 =?utf-8?B?WlZLUVhyRFZZOEN0MThRWVFIWUJOMlg0OFRUU2VyOFZ6ZjR2Uk02U2ZmUFJD?=
 =?utf-8?B?b29uZGxDWlA1bTYvMkhNdS9TTkZUdEhrTmVzQzQ1WHBObEU2VElMT3pma0xN?=
 =?utf-8?B?S0FrcXpUalJTeEVsZkUzeHBmc0Nma1UvTDBuS2I1Ukp3TWNRMkdkRDFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWV5RkNGaWYvZCtGMTVJTlBIWnJmYlRURUk3MENJbFBzcGZxenFpdUd6UUNM?=
 =?utf-8?B?Rng1eHBTeXpNakE5dFpvYit5NzdsWWlLbWZhcnJyZ3hJVTRpWTlVSjhZcjBU?=
 =?utf-8?B?dDh4eFhQNWRwMGVqcS93dG83TWFkTkNoNVg4UU1NOUFrMXE5ZGdVcjQ1cXZV?=
 =?utf-8?B?UU51U2RmTHYwd25EanJsLzNoeTdwWWYxR1lMT2FhQ0JTeWVDYVEzV1NpQkht?=
 =?utf-8?B?VTg1NG40ZUVHeGdZZ1c1QTU1RFN5OE9OeFlGd2ZIMW5qTUZxUnduQmJ4aTFn?=
 =?utf-8?B?K2ppS1VlUUptK3loMmlIKzJjMk9UT0ZQY0hFb3NxTFRMSEJNL1p4S0RLL2ov?=
 =?utf-8?B?TkgrU0lTeFlTd0djdzgwYnc0dHZzdlA5bGx3RWJ0U05UV3BrUHQ5ZXJhT3A3?=
 =?utf-8?B?aGtRaEM4YUJMNSs0RnJnNnZKdURzSzUxNjh5T2FVMm1FbzgyTC9Mb1U1aDJa?=
 =?utf-8?B?WVROUXlKR3FKYUh0OGUvcTdOYU5kR3NKWDczeXZna0djRFY0VTFudVdqZnhR?=
 =?utf-8?B?bXJNT1RGdWFoUlNUN0E1ZWdla1JZV1NrNUVxK3NucEs2eUkrM2FpUjJMeFlv?=
 =?utf-8?B?ZmdNcVpCMjV3ZEd6OGxKa3MzeFB4TjVuVVBkZWM0cXhxUENiL1NXQlJDcnho?=
 =?utf-8?B?c0FyOU5sOGx4S3lOSFhqaUZrMWlEdTUrQ1ZuOWtkOTN6ZUUxWjZqakN0U29L?=
 =?utf-8?B?Vm9Edm53bnJNVWoyZFNzdU5ZdDZlcUx4d2RKaWJGcVFscjBySFhjNDU2SVE5?=
 =?utf-8?B?RllBRDdJMDJDVXY2MlgyZU53ci90VHgyQmYvQWthU3hMUkxreUhjZ1c0OGNO?=
 =?utf-8?B?OUU2alE5cUVRem93V21saTJkM241dDE5Um8xVmNmN0xrK1RRTlZ5aGFCNWRo?=
 =?utf-8?B?TDNwM0p1NFdPQzdnbUdYQnpHUGVuOGdlSU9JUkVHeHkzcFBnSTR4UXBWTHpw?=
 =?utf-8?B?cmNLWW5NR1lmNVFwbi9rMjhVYmJBMFcxYjZrK2ZqNXROOHV5dERXZm44VklL?=
 =?utf-8?B?MHFDYTBYSkg5bjFVa1dOUHhoUHJmK0h6ZVJXTGZBRVI0NGl6K1lIRGI0TE5N?=
 =?utf-8?B?SWtqQXRXazVPdEhpOUkrTkZFMXBJa1VkWDJZZkhYRFdEYnNaZFZ3S2E1TkZI?=
 =?utf-8?B?bjRubUV0bERGOWsraEtlcTdiVW1IeTdvTTNwblVhc3FsSlh1YkxidGpxemRK?=
 =?utf-8?B?cGhBMEpiQ0g5czBTUWxpRDNnOWtMWWpPZDQ0R3pxemJaREpySG4welBNK3lP?=
 =?utf-8?B?dE03d1lMQVRaeUtaQUxCTGVNc1NnU2ZsT3FuOFpxTDFoUW9vSFNTTFdWOUNu?=
 =?utf-8?B?RFFBYnFkZ1V3TWlUckJkWmd5QnM1TEt5Wkd3b1Z1dHBDNnMvNkJzRWpzbDVZ?=
 =?utf-8?B?Qi95R3RMYXltYzJBRi9abVlma2tPZWhvY0dWSlIwZStXdU8yMnI2VGl2NFNp?=
 =?utf-8?B?OFpwUGxrVlFtcXhKaHlmUGlOekV0L0ppWC9tRVNFbWRxTjhXcHNOL051ZXdy?=
 =?utf-8?B?a1JlbHVxampKZTEvdTFkWXFYcHBmdGJBckdURXltSkFxT3kzQTAyU2RhMUhm?=
 =?utf-8?B?NTBFN2gwbHNoY1ZFaFBmNFJPZzE5cTdReWFZN0FZN1dXcDltT05DUFV2WWtN?=
 =?utf-8?B?U0YyWDA4amRuMUhjVEp2RW5vQjVLdFhKOXlIZEkxSGdFS3VzcHlObWlGcmdG?=
 =?utf-8?B?b0tKSjRvWUFCOGFIOURqNitxeFRlT0lmSmJZZXNoajNYd0IyRVJha21iT2NE?=
 =?utf-8?B?dDBzTXZkcXlwc2JZeFZyUlJsREZTWkptOUZ6SWkrc2hkWVJwZGk5SEg3amxL?=
 =?utf-8?B?UkxrNVp5OHR0MVhQQ1VpOHIrb1pWZTJUZlZlU3ExRHB5cDNsYlZMQms3a3p2?=
 =?utf-8?B?bFBoZGFEMnErbWc3T2N3N3ZTMktxd1hNYTZzelc3bGJ5UUVUMDA3MXEyNkl3?=
 =?utf-8?B?Y0FtbFQzMVgrQThINDgrMjhENWx2aHRoaUN0bUdjQWJPZkFwdVFyY3MwTS9P?=
 =?utf-8?B?aWJzOC9hcjZEOHAwU0lHRDk4RnU4bGxCSU5jaGFaNS9GeHF3NFgreXpWbDJi?=
 =?utf-8?B?NElmSjJXc3VIRkxobTZ3TWlTbjd6R0l0N2dIUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f195f543-5ee2-4f01-58c6-08dc766ed83c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:42:42.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWBTSa+QAZqaUsEfaJxop7Se1AFF8wJApd3wl8SH6ox5KqcwUQNC4if+qRzDqQ8HiXbfmoHaoVXOGomzS6w6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10598


On 2024-05-16 15:21, Junio C Hamano wrote:
> What should happen when I turn "pick" to "edit" in a "rebase -i"
> session, check what got checked out in the working tree, find it
> satisfactory and decide not to make any change to the files, and say
> "rebase --continue"?
> 
> The current implementation seems to just move to the next step,
> without offering a chance to edit the log message.  I do not know
> offhand if this is something we changed recently, or if it has been
> that way forever.

It's been this way forever (or close enough; I've been using Git since 
~2010).

> I personally found this a bit unintuitive, because in my metal
> model, "reword" is a mere subset of "edit": the latter would give me
> chances to change both the contents and the log, while the former
> only would offer me a chance to change the log.
> 
> But the actual behaviour does not match that mental model.  "edit"
> is purely about editing the worktree files, and only if files (hence
> the tree recorded) are modified, a chance to edit the log is offered
> to adjust the message to what the new tree brings on top of the
> parent commit.

My mental model has always been that "edit" means "amend" -- when I tell 
"git rebase" I want to "edit" a commit it (usually) means I intend to 
"git commit --amend" it in some fashion, whether that's to update the 
tree the commit changes, or to tweak the message, or both.  (Or 
something else entirely -- since I'm at the shell prompt, I can do 
anything!  The power!)

I like that "edit" does not open the editor if I decide not to change 
any files, but does open it if I do change any files (and that "git 
rebase" does the amending for me if I just stage the changes and say 
"git rebase --continue").  Seeing the editor after I say "git rebase 
--continue" is also a good reminder to me that I've changed something in 
the tree being committed.  I've found this helpful if I've been 
distracted during a rebase session.

If I *know* that I only want to edit the message, then I say "reword".

> Of course, we can work it around with "git rebase --edit-todo"
> before saying "git rebase --continue".

Or, more directly, just "git commit --amend".

> But the current behaviour
> somehow feels optimized for a wrong case.  Admittedly, it is logical
> that it does not offer a chance to edit the log message if we did
> not make any change to the working tree.  After all, the reason why
> it may become necessary to edit the log is because the user made
> some changes to the tree in the first place.  And by not opening the
> editor, only to close it without making any change, the command is
> saving the user some keystrokes.

Yes, and I've always appreciated this behaviour.

		M.

> But given that saying "edit" and not making any changes is a rare
> case, it feels wrong thing to optimize for.
> 
> Anyway.
> 
