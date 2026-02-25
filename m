Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020116.outbound.protection.outlook.com [52.101.191.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0706E29BD95
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048809; cv=fail; b=ds7QBBiX9dKR9zt+vCyASDJB0dHfVViX/69M28b2MiFnNJCuhScFhAvPCIkcLbPQwwYpxCqJJ/tEnWNTl9oIUgTpE/0Tkw/FFBWEJKkGPiB27yW8dn/Zt6GKbDdLtBtAbXG2g70u6XBBhnwvNEBrH5HQqpJ6MK2MJMUK7+d3Kj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048809; c=relaxed/simple;
	bh=pbetHx5Vhb9/k9RBRozHnzR9J+Sz098e2eOdJI34AiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oAikGOBESsUplE9ljz1UkBEHsH6FZYwHL41b5jIi5/d9vT7f+NWy/ONkxqi8dWl/2ZmMm8zrt5izvtevibLQg/zjAzDD0fbI5t16o5jpOrxfbMERk8BaGVf5KIbkhwiAi9EfdC/r9Ms1puWIp9zbrFHBo/Slh5UURVwmgKk+Vuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=IEb8TzTK; arc=fail smtp.client-ip=52.101.191.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="IEb8TzTK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti8ne/3sr5vz8oKHcTLrlZ7FGcNUHDg8LY6MVTPm8I2XR4/bMp8RSp4VfK9iNFihc7OdoBl78vUa3sje8bkPZTXEvgs+aETo+Ot5hNyA5o7UfJ8f2c5S19JVARHYOG4Q7paLx47DTDSvqHcxcl6nPVyjFvZShQ9wElE90RHlhD/9femofZlGgN1WXZXHKuCVU2hykwI4AwZTWuS+46OeHEysguvfEb8tubMighBIWp3PESXuNZqr3O2N6UrjciGZVRw4g/KpoqiiCg9AC7YxJSTqUtjGZor+EguEfjbZ8UZ82gJn9Jsdv2wrv6K/xAqKjJlGGtFi544QrWfk81ArUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWRF1zfU2ez3k8SUJ6FG3WoSNYY1ppyo1/7+Os7rGD8=;
 b=jtHhHaLNvgvNvuXTWVPZ71MMuWa2kyCJ6xYFEoRd0mh9M8LWAvoJWw2oK4J+DMakvPFJ3OkTqk49rFGK1M+Lwz08vAQ2/fHg6GLzUM3icSdHBRqLoc698QttrDb45H7lWzCWuQx/YHmu+0npL4wH7PtLBAEOfbVGTPTB32Ztl7dKtbyJGCkm/1dyn1fe0bDSGJYH64NW752HHusWoWpDjmFJtseglTH0Hqd2TFqSLEIOq3YdNjcye04A1cW+Ef1p1GYDlPdtZHWWyGxdV2/G1rgXHqeBbA29cWlSS9gkLyD7s9v0Sa8XZugz8MASaMuc3ZceRbVUcD0tT3XWJiufrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWRF1zfU2ez3k8SUJ6FG3WoSNYY1ppyo1/7+Os7rGD8=;
 b=IEb8TzTKLaz3Td4/BqQHFzJrPb7C5GZaEJQC2lsJw18SRsMbNahQbWL4biIVU60xpElTfhczasJiQjcGyVto/FOhr6gM/jE8h39hRwJZa8o7/19j+sJLSUNiUjKOBMMdov3y8RnKJrPWQyipRFF8bK5ZDP4NMqjzmVqbmZxVz5HJN2kx7aKUb/V/eS+Kmg6IqFU6RFix+9QMnjZNvulyFq7LZ6vMzQy6oKUti2s5LXb8C23/y1PCIBYg+ZCN6GrTylKi0Rz5h6Fe/mnv4M3LOMmtHnrYuaEheJTptDN2hklsF6XLdsjv36Cn2ChwxlrmGa9nYLlp4c/ZoJfiBj8aPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9d::13)
 by YT3PR01MB9330.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 19:46:43 +0000
Received: from YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8883:cd78:f84e:9c6c]) by YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8883:cd78:f84e:9c6c%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 19:46:43 +0000
Message-ID: <8f6441ab-5c9a-4b42-ab2e-a670d462569d@xiplink.com>
Date: Wed, 25 Feb 2026 12:46:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: --no-decorate and %d in git-log(1)
To: Alejandro Colomar <alx@kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <aZ81X6ERyx5fcm6L@devuan> <xmqq4in4brt3.fsf@gitster.g>
 <aZ9AuD3dYzCKtI0s@devuan>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <aZ9AuD3dYzCKtI0s@devuan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:9d::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB8403:EE_|YT3PR01MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: b1189b06-7fd5-4d71-77be-08de74a69a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	Z5wcFGBmuF7oJf/wkYHW5kzRgAUHIB9s6RbrNrO7lDHttX+hqTA1kc6Au2qjbgmFMy+2yYrq0dkqFDvdLCSOozXIthClWZxhlaHHtxIYZyEQSVP1pFTNjJQTnCA3MkuWLe00Tg59VqSocOWXTCuRd0iNM3nm1XAlbqvL5IFYZwinYru4m+dppWcIeQzzYOdMZTwmrPcrh9Sn+OC4O9x9/rubb4mo+y4HDaeLyEAnpJsIG/UjrpGV2gLt7DA0TdzQru53+cu7RYWZEQg54VolTF9rvKPT5/yKb8vOt5M4kFwTESGK2gQS/6aoCCM0gUDG2aUxnvgVIdFnI4vYWbU5DSKTUEdvfeP6YuRbdVYZVAIMfhf/dgQNX/tPj9ESpCZt2tUNSTGjtw6ymY0ETpsGXjqZRb/mnWWCVyd+19ssPNeFUoEBLJJnKqwWkfvjBKWkrkdgsOdVIgYW+C5qY4ExT01m+tECfHmlzQi1nKsVb94xnzr9FO6VAHlak3wQE3WpoShaCRqhr9yYlcT6xcpYH5yQ7ngkiK4978/YMpf4PSipw9pAUqJewYDRVnq4zBZx9yfCfTJd+fFBNqRNAMbMkbJwEtdUloqUBx+kOMLJ0WPNXqSpNnwkGXp5wrfFbR6uXZBgajQCvrs5jUeVPcfaAwUCes2R3ql8eW9OuzQDSHyQ5hC/gDIlALJItDqD/dyCnOkkyK6/5BRC+zApM6fDISdeQ5NZTBtVKb/M1MngC2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTc1enJrYTEySlBRWEwzenZYNkZqQS9KR0NMSzBkUDNZR3M5c1VpN2FQUmJO?=
 =?utf-8?B?VVVFRmFlcXdiQmRWd09ZN0NsbS8yQ3h3dzdPcU9MSk45STZicEQ0VGRtUXNs?=
 =?utf-8?B?eEJFM3NKY3hoL3dZSTFlWVBLVXlQbGYzTDU5ZUJpejV0T2p2YmJkdW84ZWdL?=
 =?utf-8?B?eWxtNktXdTVHcnJvczBzanQxR1V1bFRFRmdieTZEVkRwRGZxVGsxdGRFUkNn?=
 =?utf-8?B?T0VDeXpjZFF0aHMweWQ2OVBWMUhmREtERUdGRzJLMDl2SWpJNkVFckpUZHZq?=
 =?utf-8?B?MnVlQ0p3RjVaMUQ0WmxIZlBwK1Z1T2pHelVRZVRWcC91dHdSWHB1YzhRRnlY?=
 =?utf-8?B?UkpjUW91T0JRZm1ZZWlWQ25IYk4rQlpQUVFMR0RzVksrU1FpWnpjV3FIaVZJ?=
 =?utf-8?B?V09mejhLL0tHZlBRaTNZbnk5ZXhxUHNITWlmYjZEb0N6UkdQaVVhWENBYjR4?=
 =?utf-8?B?aWIxZSt4Tlcyd2JXVU5vZDgyamR4Um96bUp0Si9pVU9jejhidUdvb3YzMDdh?=
 =?utf-8?B?YVNjeUlHeUw4NnNNekREdFhtM1lYUFF1UWRLOU8ydkZyWElUOVI3ektpVEhx?=
 =?utf-8?B?anBxQ2tmWGdNaGhGejdFSyticE41MHlNRzFFbGFFdWs1bnZkcmx2aVpqRFho?=
 =?utf-8?B?RnUvQ2wwbU9uUlNIZGdwRFJydnEyVU02c290RkVKZ01GS2xkci8xOThKdUF6?=
 =?utf-8?B?UU03YXVWSStqbVJqRDlhMmdhM3ZjK21mbXZsMS9STTlNY1dvUERETFlaVWpt?=
 =?utf-8?B?dEhzRnhpYk5vNGpZRVl0MFVKZEwvZEtnS0g1QzhReXg1RTIvR21mNjcrMVFR?=
 =?utf-8?B?OHN3a1E1eGFsUjFFZlBaMkNkYkJKNXNUUXRKcUZycytESWRYQUdXazYxZW5J?=
 =?utf-8?B?QzQrN2xnQTA0YmRCcnZoRFZDVFl1bEI4eWdCQ09kNTF1dG1tU3NmV3VFdFZp?=
 =?utf-8?B?WG9xT2h2ZzczSVJzeWtIenhxVElzcEVRU1M2TXBqUzNJR24xN29EbXBHbmc1?=
 =?utf-8?B?djcxdjdqWW9yYkhUOERiQTlvbGV0MmxocDNEOWlmTENFQ2NYSEhBY242MkF5?=
 =?utf-8?B?S2pBTTdiTkhrakk3TlIrb3FZVDNYN0FBQmpXaSt6a29ocmVKUWV2LzBqWW1t?=
 =?utf-8?B?ejVjVlZFdFVSejZmek9MMFdFSHhsd1N5SHF0TGVYMU8vakNqdFROaWJWUlVp?=
 =?utf-8?B?d1pLSStkREpmamt2K3JNK2c5SFAwNmxmTjlYU3JoVURyTVZmY2ladG0zUmUz?=
 =?utf-8?B?WkVkUUpjUkJ4WXoxTG1UVE9LZ2J4bERSZlBseVBaYnlCdDJ3K2U3cG14YTUw?=
 =?utf-8?B?bXUyalFld3BMdVZJcFRFTDN1MnNRSDNhcE5zd3Nscy9QK0x5UzFweWlGK085?=
 =?utf-8?B?OEJ2Sy9TWTRLamNrbzVMcjk3T2wyOFBEcjhLVlQ2ejNJTFAvbHRIQlNSb3Jq?=
 =?utf-8?B?YXFEN2tqNitCdVpHZml6WThYejBZMVhReFl2TTQ5WWlLN3pnRGJQWnkzemFU?=
 =?utf-8?B?Uk9TVnBQa1BPbjZZVkRqb3Qrb1RIVUlpVWVJUCs4M0JUSWVFRENHTlZKMXBa?=
 =?utf-8?B?WHRWVzgrRFJHVTRtVE5QcGRoWmpFbjRUNVJGVWFjVHBUQWdCeC9UdUZtR0Uy?=
 =?utf-8?B?VGlzblhxaDNIRlM4TFhjaXMzcGJ2V0x3c3Bid0g3b3oycDZpVHFqTE0yeFBT?=
 =?utf-8?B?RU92dENlRHcvc0FuNmJXM0FjcnN2L2ZhbXBPY3NCeFN5U1owOUs1MHVkT1pl?=
 =?utf-8?B?U0JLbWxhVnk0V1pQMHd1VExWaER1eUtwdDNmcURUdDVmanhGV0ExVklscjNw?=
 =?utf-8?B?K1VQczRwampZZEdTeDBPNE9Qa2RqUSt1c2N4akR2N3ZENnI2SlNsTXkvd2oz?=
 =?utf-8?B?cDlYdUNMcDNwUUlENGlHQ2VlTkl4cXd2VWR5ZEp1SEZFM3luUnZweGpocWR4?=
 =?utf-8?B?aGM4VjhOTFR1Y3QzdXh0VGR4VlFpcXY0QU1LMk1wM1BqRlR4NjNlSit1NndS?=
 =?utf-8?B?SFNtUjgxeDhOTXVoYjRnMkNyNTl3Nmxxc2V0RWtoV2J1ZEh1cGdVaVQzckdu?=
 =?utf-8?B?WENjSzBUT2J5OC9tZVZ1Qkt0ZGNWZXdCdjhGR1NlOUp3MDAvTjQ0bnJ2OWx2?=
 =?utf-8?B?RHorQVBVaVZOYmlmQ2RoUVM5anBGSFVXTit6UW1qV3NQWU5keGtvSElPUTl3?=
 =?utf-8?B?VzlaWVdBN0E5d3dXc1YwcGdjeEtVSmwya1paZ3FaUWN0VFFpbWpjRGNuWlNv?=
 =?utf-8?B?dlphSngwVFBmS0l3MlRyVEQxS0xnPT0=?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1189b06-7fd5-4d71-77be-08de74a69a25
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 19:46:43.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFk8QRXjdg6MF9NzG6f9GrbS3KKcTm5IIZ1PfocrAv36VNDMOLpLtfb10ktveI8Cc9aVPeDoYKChpUz1Wa0+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9330


On 2026-02-25 11:36, Alejandro Colomar wrote:
> Hi Junio,
> 
> On 2026-02-25T10:29:12-0800, Junio C Hamano wrote:
>> Alejandro Colomar <alx@kernel.org> writes:
>>
>>> Would you mind changing %d to be affected by --decorate=?
>>
>> I would imagine everybody would strongly mind as the scripts they
>> have already written and have been using for years will be broken by
>> such a change.  So changing how %d works is a non-starter.
> 
> Makes sense.
> 
>>
>> But that does not mean we cannot add a different placeholder that
>> behaves that way.  I wonder if it is the cleanest to extend the
>> %(decoreate:<option>,...) notation, perhaps like
>>
>>      $ git log --format="%(decorate:optional=yes)"
>>
>> with and without --decorate/--no-decorate may be a way forward?
> 
> That could work for me.
> 
> Alternatively, we could add another level to --decorate=.  Currently,
> there are --decorate[=(short|full|auto|no)].  We could add 'never' to
> also exclude %d.

Having both "no" and "never" is a bit confusing...

I disagree that having --decorate=no disable %d placeholders is an evil 
change.  %d is, after all, "ref names, like the --decorate option" so 
controlling it with --decorate seems reasonable.

Indeed, some quick experiments with "git log --format=%h:%d" show that, 
as documented, using --decorate=short or --decorate=long changes whether 
or not the %d refs are prefixed.  (The same holds for %D, too.)  Also, 
--decorate=no has the same effect as --decorate=short, so if you look at 
it a certain way, one could argue that it's a bug that --decorate=no 
doesn't disable %d/%D placeholders.

BTW, --decorate=auto is documented as "if the output is going to a 
terminal, the ref names are shown as if `short` were given, otherwise no 
ref names are shown."  But in my experiments %d still shows refs even 
when the output is piped to a file.  Seems like another symptom of the 
same bug?

(Do people who use `--format` (with or without %d) *also* use 
`--decorate`?  It seems like the two are naturally exclusive, even if 
the code allows them both.)

But if people really want %d/%D to be unaffected by --decorate=no, then 
instead of Junio's suggested %(decorate:optional=yes), maybe just make 
--decorate=no turn off all %(decorate) placeholders?  That seems natural 
to me, since the word "decorate" hints at a connection.

		M.

ps. "--decorate=no" doesn't seem to be explicitly documented like the 
other possible --decorate values.

