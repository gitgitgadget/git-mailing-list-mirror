Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022112.outbound.protection.outlook.com [40.107.193.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D019EED3
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055978; cv=fail; b=TKT7ouxj83Xge/F7dOxaw4TLOX7tOpfswB9Iokbv/AuKBzP7HuuUc9ctceXJcQVej1qYnLQWxA8hqiouuJjrtGTy2ay9vyRkDSlUTaHTm7Rmn18LNS/mNZgCyf4MaykVscxgvIdicsWEJggON2g4qrexU+RWHWZqIJZQ3gLR2YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055978; c=relaxed/simple;
	bh=034akDWOy+p3Y1j4zj0RGZ20VFhQx3PNJas1zAax4hQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qOypMemOpZ2FNH7k9saszNHXiYtLc1/vQiUyU8kuphxT0bthMUMS6Ejkl5wA19R2m2TajOEbv5mKErza61SdqtRIsMbpIDSXkN1CfzemDY2m+KUASvEuccoIfS9l9OCm1Z79cC5fdLeCrQ9KcKILToJoK+rAddOMa1BfQ/Co6SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=m6nL2fIJ; arc=fail smtp.client-ip=40.107.193.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="m6nL2fIJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ryod6Ols3eBwI8K0ZQnrGQcoY7e1eUg1PW1rCWGF00X02mGwIdK1By04kwu9HtG2nTxu+adXWHj23wD6F2KshmzPx7663ia1iDTKQDvl/XaOJgsq8P4guGxdBpmF1O15lyO+rFk7F5gO7VBfrOJYRltcJmsv06AQzwrKNDMq8ugBUg2hJ8MjZl5wD16CykorKlXuLxCeu61XSTX8ZFHcn28u3xNN7slOBhEsKMHX9E1vgd32wAwrl2eERA4QECK8aTcYsOTQ/V4jE99GyjiD9OWTN9ROFbL8nMmLj8Wa1KXwYxl9MD60aWholnoc9rzt/71D1GuFa2H9t2tiYR/vQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfMZc5p3/3kYIfWXf2CbHyctoRXYRghGJjLQW4HtZmk=;
 b=g4iJWHpx61FuFsyADyDIQdlzDaaqN/fX3ogE5qbQoVI9PnqF3DKBxL8DBI9Rgd4nxz/usdhRa6Ep1lkU9wzx3hOMB/n8aLnyNPFItRXGace9adBG04d/+hyVBWKb3gJ0hSJGprfaHyCZOg3hbeuR2h7USk6r7TdVf9lAo0pw9itm++BJsNRHAOd5O2OnfDWd7ggT0SJW9POiHwbAXM/CywvZK/obdHj5ROQQiaQ1pAIItR7PBoup72EViu2Aw4j2EZrHWp1rWy+wOjwF73u/zcyJ8V+vLF9JLdpMVhw5ntsAbcPaAX2PatD3fwwTxWPpSgCEupYi6rKvi5fF5ez0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfMZc5p3/3kYIfWXf2CbHyctoRXYRghGJjLQW4HtZmk=;
 b=m6nL2fIJDOVPNLoK45htdmD75n6LZdFQ9+6SvvQdSonZmz44hBWewiZHF5wir6EBg0stUnPjljGsWnCzXG0KNHHmD4k3TwNiR7o4pC/VZlMY1b0GpKtEsmvbj7ejF2W5vdcTGKKrcTAqhTTi79QB7ZiOEtM6SU7vYlxmQ0z1AELeFUO45itylOfEbhBQw8IWbUME32w7PW3zcqsfoj5AOR/B40tN1hONPHPZPzCC5L+ooMLQuAP8CKMM8qMQ6nqeNPpwD/+n9InyD5RFHznSrzEHCwnx2njPeyfZcFGYLNUdJWz3gSm+qUMjPVR3yVlMByK07/C8rTKeIolXuj2p5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9d::13)
 by YQ1PR01MB11675.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 21:46:12 +0000
Received: from YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8883:cd78:f84e:9c6c]) by YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8883:cd78:f84e:9c6c%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:46:12 +0000
Message-ID: <cf3d274e-7363-4557-809a-a649b1d304ad@xiplink.com>
Date: Wed, 25 Feb 2026 14:46:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: --no-decorate and %d in git-log(1)
To: Junio C Hamano <gitster@pobox.com>
Cc: Alejandro Colomar <alx@kernel.org>, git@vger.kernel.org
References: <aZ81X6ERyx5fcm6L@devuan> <xmqq4in4brt3.fsf@gitster.g>
 <aZ9AuD3dYzCKtI0s@devuan> <8f6441ab-5c9a-4b42-ab2e-a670d462569d@xiplink.com>
 <xmqqcy1sa8mx.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqcy1sa8mx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:9d::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB8403:EE_|YQ1PR01MB11675:EE_
X-MS-Office365-Filtering-Correlation-Id: 644d690e-1fa1-4fb4-0059-08de74b74b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	+QrF/sX1fyRlsR0E291mufEOGZqqwAB/tZ9Qq83/8FJrXWQ5ekcAbJL4cjD1w9Yrs8huzJghEAMmZ0ZaBVjI30g+oWRsFLiHrGs1hli9aE9AkblnL8afTzLNj67d/2uDRd45XIg9bb5dERLE5l3CglK2APVYNNxQOZmPt7aM3/usJ0l3XlfydCxVyP/CuvTmcogO4v/HMsvZO7f1+LSwZICQr6KQG83tQ4ARH+A0JQvQpD4khiVqISfuqyH67bbiHEEc3px2JeSJ8aI8j4ALLDL0Y+nTjZaeUYPI4QkW9XZ9deD8wL1R3eYTxIAwTM8+HRg3ILxV1latXbwJvLN67ZKjd8D2yrauwPphA4ShC0Lsdelr+2TvXx7YSCwWxkVwXr52Ki2w4PACaYyqyqARq4ljp21WVkz+7y5wRPQMOc+sncUHR1YOzf+wR37JK5xFsfaBAozZngOHk76pYMQilhP22EzcserF5oy0+OB6a7fZ2VdyY6lrvuOevq9A6prZegz4jHQlZFUUlNkYITHEJiJuSCdpsHdUHZGFHU6Q0m9my7RrcYgeqUKF3Q7AbsUq4N0eCsYE2+tSB8B2vGzBA5RFOKx6+1dUSa1tCiORNkkE3dUMtx4pRTbj7jH4HnrODV8wlBhuiMjsI3cpDInJRcYUMQ1moliqnHRvgT0Q4iOpJVvkcvZVGxhe+LKuC7v05rjXBYJ2ipGUhGZnV5Vwzha2II0iGG5tyyZY8lNrAus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y09Bc29RVXJ5dDRDOTFTSmxxYmZmOUJrQVZqVW8zMmhWeWp0d2xtUnppdVYv?=
 =?utf-8?B?M0dKcmRNdk51dUViSWtlM3BsM0J0ZFdyVW0xdTBDbU82bElWSzVGVVRQeThL?=
 =?utf-8?B?bWtENVFwa1ovYTVRTXZ1Qkprc1hzM0lnV3NZVnBYd1FocDArcE9tckFSWWc0?=
 =?utf-8?B?TTdMWHkxRml2cmVQSE8xVjU0VmNLLzJqQVhDQmdTWU54SUxlbmkyS00xbjZa?=
 =?utf-8?B?US9rUnlaVWJpTXVLTTFKUnBDamtVVDcwaHk2bEg4TEFPN1A2K3VZaktJaDc2?=
 =?utf-8?B?djl2b2JkRW9acFR6ZG01K2FUTUxJdG52L0QyWXlxL005TkRwVFd2a2hsSWlT?=
 =?utf-8?B?akhTcTBmSXVobFcvODV3SjdjdmsweUVtYXRCYllFdm55Yk5uUE40S25kdVZ5?=
 =?utf-8?B?UXZISXhBRkcrQnFKWkFMd000eFh3Y1hWQk1FYUVqQStvZWx5bTJSV0J2ZVN2?=
 =?utf-8?B?K2hhbk9GZ1hVenkzc2p4U2dZTUxyZnNRS1hzZy9YZERvVEtQWHdSbnNwNFFQ?=
 =?utf-8?B?dUkycGlmbWlnT3RmZWduUjljUnZFdzFaOW9XV0Rpc2M0MGVIYXlzdkZHdjYr?=
 =?utf-8?B?c2FyTUlkaE9PMjNjZCtMbCtxYnN3Z1NBNzgxUzJJWFgwOUFmQkZJcTcwVk5L?=
 =?utf-8?B?OHhmd1dScUtVaVcyYlJJbGc5ZVZtR095cXAvVE1EN2dMdlU3M2FBemRlaFNk?=
 =?utf-8?B?ZkdkeFVSY2NDTzNEMEdGYlZab1ViSXQzMFI4TFg3MHUxNlMvOGJZSlBlUlhx?=
 =?utf-8?B?ZTV0eGZpTUpOQUpSYy9NbWdrNlczM0FSd1Q1eHpVME1FRUQxV3BZendpRUxP?=
 =?utf-8?B?NThLV1NnL3FWbDV2MGkyUEQ4VloyN1hxNkR3Snh6OXcraFd5aXdSRG5zWHNp?=
 =?utf-8?B?bDBDd0g1eU53S1JxVTNjOEM4RnF4ZUNvc1lpbVN0WUZaQi9yREVaVmcyOFJl?=
 =?utf-8?B?aFhnU3BDVmM4TGZjUWxRWVpORnhVcTJKQnVYL3lORE9tbzBjbGhZT3V5Wjd5?=
 =?utf-8?B?bkU1cEQ1eTRCUE5hdFRkWDg0di9WVGJZaGlCRHIvNjB0RVFxdHhteTUwNzZZ?=
 =?utf-8?B?SkR1VlNvbk5sLyt3cmhkR1ZCaGpzMmtWdzJna0ZSaDVHaE5oU1g2MWNzWXE4?=
 =?utf-8?B?ZTlIWjJuUEM2R2VjSjEvME5td2d0bDV5OGQ1ek9RMW1jUzRPRU1kTWVuSjdv?=
 =?utf-8?B?eEdLUVQwcXlwbkdnZ0RhdVJPUUxaRnJVbDhmK3ZhSXhhR2dqaFN5WDYrNlNZ?=
 =?utf-8?B?WXlkd1dYeTEzcGU1S0k0UjBqblNQanRreW95aVVUM2xoQnE2NWwxd2JHNU1J?=
 =?utf-8?B?azVPNzhQblBwbmdJVkZaVkQ0K3J1amltSVNqRDA0OE95YTB1R0ZwZWJkdU8y?=
 =?utf-8?B?Ni9jNmVFWFUycmdTc0RvV3pNRFE0Y25PQXVuN2tEL2lwMjN2Q1hMUDJKVW9a?=
 =?utf-8?B?Vk9zRHg5NWlyUGQxa3VaQ3hEZGpTOFlzTG9xOWQycHR3S1lPQzZXYXczZEt6?=
 =?utf-8?B?akQwYUVTQW9ZaEFTMVZtZ3JJRXVJeFRvMmo3b2VleEVZSnVHR01CQmVmZ0Ez?=
 =?utf-8?B?NkNCRVlqbWZKa3I2VjNra3o3OHRwb2llQ2JKUzNUYmpaZzVtM0QzRmFVS1FI?=
 =?utf-8?B?OHBYcUNXdWdnK1NBRk1hTFI2SEJ3a2VWUGErOXAvQXQzaTlSNXg4Y2NyZm5z?=
 =?utf-8?B?WGVRRWQ5WTdvaWVBdkxVdTJjOUg5UHJNTUQvOU9WcHk5L3hIcDJnUE1CN1Ni?=
 =?utf-8?B?dDh3S1BSM2wyU2ZCc3p6Y1p4WndWMGNPb245V3RrMTVScnZSL3pwdFFtT1hV?=
 =?utf-8?B?alc5cjlYb2dTOHNEZElDY3liSEJZR2hKNjc0WFp5QUdHV3NPYStKUEgyKytD?=
 =?utf-8?B?eXpvVDAyWTduVU9lNWNaNUJYcTlQVW1EcEY2NFZEd2k1eGNOQ1ZiTldyNDNR?=
 =?utf-8?B?VnpFQi95MlFSR2hYT1VHc3ZzQWw0RzNsN3FSRTkvMXdxeXVEaC80SHIyUEZz?=
 =?utf-8?B?NFJjaFpGNlVtN1lycFFNSEZOa1Z0N1gzL0dGVG9raUprOXBqSDZUaGZGTkNh?=
 =?utf-8?B?U1pvcHlmbWFjb2VxWlFmTldoSXZ4eldQM3lJSE43NU9ieFh0bm00WUNLMllY?=
 =?utf-8?B?U0VnQlZFMk54a3ppaVF6ZmlnemVKQVdJTkRuVzB1dGNlTG80WU1CQzRqSTQy?=
 =?utf-8?B?aG0yY2w3RmhDQlhwZTdUTkkrVnBSRklJa3g5bVZoR1JWaGhiRlBBU0x2VTBw?=
 =?utf-8?B?M3RIams0RU9uQm55R01RSWd1UXhnPT0=?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644d690e-1fa1-4fb4-0059-08de74b74b1f
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:46:12.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYUWhF5p6Q36ARdhbtpv0XdjHtlguK+vNyZBRZ1gEocrT2yjYhkcwTBzdaMcWvtMfaLksiLt791ozL9z/4hlsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11675


On 2026-02-25 13:08, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> BTW, --decorate=auto is documented as "if the output is going to a
>> terminal, the ref names are shown as if `short` were given, otherwise no
>> ref names are shown."  But in my experiments %d still shows refs even
>> when the output is piped to a file.  Seems like another symptom of the
>> same bug?
> 
> Isn't that documentation merely referring to "git log" without
> "--format=... %d ..." and not about the case where you explicitly
> ask for "%d"?  That is, the description is there to explain the
> differences between
> 
> 	git log --oneline --decorate=auto -1
> 	git log --oneline --decorate=auto -1 | cat
> 
> isn't it?

I'm sure that's how the code works, but I don't see any indication in 
the documentation that this is for when --format isn't used or when the 
format doesn't contain %d.  The descriptions of --decorate and --format 
mostly just ignore each other.

We do have this at the end of the --format section:

	The %d and %D placeholders will use the "short"
	decoration format if --decorate was not already
	provided on the command line.

Given this documented connection between %d/%D and --decorate, it seems 
reasonable for a reader to assume that --decorate=auto would do the same 
thing regardless of whether or not a --format=...%d... was present.

> I think --decorate=auto is the default so the above
> without --decorate=auto would behave similarly.
> 
>> (Do people who use `--format` (with or without %d) *also* use
>> `--decorate`?  It seems like the two are naturally exclusive, even if
>> the code allows them both.)
> 
> That is an interesting question, but I am not sure if it affects how
> we decide to resolve this discussion.

Yeah, it's more philosophical, though if we did know the answer was "the 
two are almost never used together" we'd be more comfortable changing 
how --decorate=no and --format=%d interact.

I note that currently --decorate has no effect at all if the --format 
doesn't contain %d or %D.  To me this bolsters the argument for making 
--decorate=no suppress %d/%D.


To expand on my earlier point: --decorate=no currently has the same 
effect on %d/%D as --decorate=short, so it seems to me that we can 
change what --decorate=no does because if anyone needs to preserve the 
existing behavior for their favorite --format they can just use 
--decorate=short.  (I'd be surprised if anyone is using --decorate=no to 
ensure that they get the short ref names).

		M.

