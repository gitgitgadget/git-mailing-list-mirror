Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BC36F8F5
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414187; cv=fail; b=dM1eMACV/hSYiAyHEDwP+9kxjYAE0bffOvxRLLAX4GjjKbSTGCTlmpTF0RUXt8kzpdD64TWrkRvDyLtGt3CjpHx9gBmSyK6WOfMx6ZjRs6yKjV3P1ZNDv+sB5jTyDSW6XV0/aCZdyV5B2BZTYxH63gHgpdPPAtuKCU4OSbXAgfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414187; c=relaxed/simple;
	bh=M8F6HxdPx1vbGn7gjtGnw2haS+HpZlYelS2EL93bdCk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b4eJM5pAziKpO3yyaku8XLE3BajdqwVvA22ODJMgiDRC73DJn/x5GdMwkyEJOXJjht+x9z6IcNOxvd2OH0PuJ4ceXW9CvvNsYca2EIgfo7j/a6HNJwjDpRGvWviN3jNYZkhHo6gXjzulI8W7qBArF6nXT7RI9FOK51fxkabXogI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=JQAhx3en; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="JQAhx3en"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSgaatFEG0wKJGH+BytczyIOiu6QsabRO5kDrduUef7EOQfQqVoc2Cgg0ZHrmEjTN8lLazvJfoKUwGnERkVK+Y+nEA7DQj5+NRV9fT4o2BNGjuF/QqbCZdE7dtivXj1y7cG475ww87R8RCW3UpSuTonHQuU1JH7SuEImDfEt9Lgv8vYhNudr++0ypxi9Ku8C+Q8XR8a4V8CIv28jXkPrJZ4+Ddq6YgUWRIL8xIJX6+PBO3Heuvzg1uFuVzs+zCWuv9IAgkF6Qc2LHm9ntTbqNjkUu1nvpRa0RKZmQiPF23cJENzWx/Zj723TC/lzJvfjaLaHcTZ0n67NYG9MHY+TaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5xPBcTTJdVHBNtOE/ksiYnPK/bGUb1KKqr+j7qZqQo=;
 b=oNlXN4nreiihSnoojqLC+5HUOii+DkEgY8uQNnU75zjqQGpM8QcgCWwjAoh9mnRFlFWtwlgVE7ORXvZYZy3tMqyDzdaTzEgIshxW5WTSIUTqfTBuj9EkMGfFdSRgaP4LA16H+5kXlB/4kQZkdMHNBHEAFgFxHwn/BVXLHNkRck8OVCcPKvUGRMc/0UZC0iq2+MlgSIyRMXRZQV8orA9/JMNPdusC7MxtNwotKWl2mekA7m7Qnx7m5tMEZba2VGo24DGgm/ocUWx0WYG1nAxP3FRpvDnZrlxwRUjkAQykVeh8V6z3wkGHLFrA6nUkd83UKckcizoPNvryXl+O/qgK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5xPBcTTJdVHBNtOE/ksiYnPK/bGUb1KKqr+j7qZqQo=;
 b=JQAhx3enznNcRgG1hqJpahsiqo4aQWA+DzhjCrBktLCrD5pF8CeSQA26rWp+KqBAJVB2FHJMTERA2QFdPBp+32WRzvjSMpeO7u4OQcLfsu6vfHsVRbK+mRRnb+UX3xoZwutoAnflh6Cw1iU7gH9lrqyYx4VVrClyamkbRoXFoDpOBM24R2UpdGacNQowxn6Iwg2OCH0r1y/kdxe7cbiG65iJegDKiZJhY8i/mCzs0FsqjC4oY0rlMOH5Ay3AQe0oE4LTxuVkKPiVlbuxAiejV2ZfTKll8VawlIKypGI+0UXrBo1fVCLTr2MI4ox92eiGeeCc3paimWAnNL8tqAHFHw==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MAUPR01MB11659.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:187::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 05:43:01 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 05:43:01 +0000
Message-ID:
 <MAUPR01MB1154649CE9D154B98459B09CEB8B62@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 3 Sep 2026 11:12:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imap-send: add --draft to set IMAP \Draft flag
To: Wolfgang Faust <contrib-git@wolfgangfaust.com>, git@vger.kernel.org
References: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <fbdafe6c-b217-4a28-830d-0c7f1cfed264@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MAUPR01MB11659:EE_
X-MS-Office365-Filtering-Correlation-Id: 49db9ad7-40a5-4988-ce6d-08df097e3734
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|25031999004|23021999003|24021099003|55001999006|41001999006|15080799012|8022599003|25010399006|6090799003|5072599009|1602099012|10035399007|2607281247196008|3071699003|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjlLUHF0SGRyZHhoYXhqN01kcEhyVEVRQytVbm9XRytkR2NVUFlROW9Cb3FK?=
 =?utf-8?B?YjBCcE5pd0ZNVVBFRlpLWWh2ZmxiYXJraUwwNC9pZnpleFZZODlpSEREdlA0?=
 =?utf-8?B?QUpCZzFPQUt4SU5CREZoeG9vaXN5Mjl3bHpiMEx3SHNuSlN3blVyYk9yeWVl?=
 =?utf-8?B?eFR5MnNrOElDU2tESmVLQWV2UUhtU1Nxd251a3BJcnlFWHNtSi9FZ3FhdFV2?=
 =?utf-8?B?TUQvT0FWNjBJZjVrRmdYdjQxWko1Wmhsc2hYNEJvektqczlsMHJ4c1pOdmEw?=
 =?utf-8?B?bWNYbzBYSEJSWFZReUlFZU1xRUd3K0lTbTBuajR2WXZqd2pnRng0NitzakRU?=
 =?utf-8?B?aHh3VDFLZ0pqbXpscXhjcVpRZElqZnR0ektKRERjc0V4eE4reW52QmVwVUh0?=
 =?utf-8?B?RzRLME12OUc5SjVmL20zdDg0QWU1SXl2QXJXNDZ2amt1Y1FlMlR6K0lTZ3RE?=
 =?utf-8?B?WGlEZVVES3Z6cDdwS2RYZWllU0tyMTZKMnVTS3dUYjBGd29NSXVrUTNCYkRK?=
 =?utf-8?B?RGEzM1dJM3VvNlB6dHVvL2htaG1leWlXWlZSeFEwdXpGbHVNaEtUMFlqN2V0?=
 =?utf-8?B?V0hFU1lURVphSStFUlM5ZzdhajFaSUpHUDgyMGtINlNRR0FZVkp3UDdIV0VJ?=
 =?utf-8?B?RXVwMFEwdkJudlErakhwWDM0M1dDUndhdFhUNm84Rk1TVmhjbSt5b3g1TVNl?=
 =?utf-8?B?YjIyR200MUFKQkZDWjEzK1hZbjd0bjkrTng0b2lodTU4dHpMMG1GRzlFZEdJ?=
 =?utf-8?B?RXd1ZUo0ZUtjQ1RxTS95Yzk1OFpTRERQWHhjTkFKbHRjTTFMbXFLTG1DczVo?=
 =?utf-8?B?UTd0MThYVGI4V1ZZR1VkNUJBdTJmZXJBOU1KOFdobW5DZ2ROREZYYkZScUNa?=
 =?utf-8?B?VkRaSXptT1BwVnNKeCtGbDhSTHNITWhPQTVsV3J2M3J4a0Z5SkNWZWFGWUZm?=
 =?utf-8?B?U2NhdVRvSnlHL1o5eVRveWZDaDUya1gzTWFvWGpKYjZsTzgraU5nOU9yRm5v?=
 =?utf-8?B?Q1NkMEpKVkRCSnMzSTdHVzBsclplcmJmMStOdzVzU0ZDK1VzendMdzZVYm1S?=
 =?utf-8?B?U1JjYy9odjNKWnlWN2pGc3lZbnh1c1ZrVDZRay9wYnlZdUxjWWZWT3E1U3BD?=
 =?utf-8?B?dmYwSlJWL0tCNlZaYkF0d0kwU1VicUI3MGxrclM5Qmx1Q0lwMGMzV2FUWHVu?=
 =?utf-8?B?MzUyR2VHRHdRd1FYbDFBSUtxYWNiWnRjSzB6RFVLM1V3TVY5TmExSFM3SmFr?=
 =?utf-8?B?YlFlRTExR1R1TkhrLzNlekRMNWlSL2dreHJXWUVTbTNmMVVHcVNhVFh3Vmdi?=
 =?utf-8?B?dm82cE5MNS9ycjUrbHAwbzdhUG85RjFJbysxR0NYbFpnODViZ3hzTU1Bc0JZ?=
 =?utf-8?B?eDI4TjhKcWFpQnBmemZjWjJOQUJ3OXNqc2JTYXJXTzUvN3hjak9wRWlZYURk?=
 =?utf-8?B?SHpteXM2cWRNL2crc2RJZzZFRytFcHh6dmczTlF6RWZxQkNyUnMzOXJ0RjJi?=
 =?utf-8?B?WkdwbElINW5YTHV6c3JaWVZJdGNLSC9IV1RvU2pORDNsYXBBelpnNWFWckFF?=
 =?utf-8?B?dks1Zz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnh6T3ZpSHFOYjVKc293eFM1NWlXdnYzK2NqcjJ0WmFic0kxa0JFaVVUN0dY?=
 =?utf-8?B?VzVNQnlhM2w0aFd1RDI3bVJTelhMVm5Sc2xQS29CbmUwRjlZVTNmY251RGFB?=
 =?utf-8?B?N000a1FNdWhmbVpDZkRqZE05RDVudklOOUJwNmczNkE0QnlNZkp3a0I2eDRJ?=
 =?utf-8?B?Mmt4M1pBKzlYMHIrYzRGblZxQ0N0c2N5R0hjVmNhKzdyTitJTVZyZVlUNUNv?=
 =?utf-8?B?K3lEYTlLNlNNQmlCNGZxSC90MDNlS0s0TXNYZlRSbVdERVYvS1ZEa3ExUmdF?=
 =?utf-8?B?Q1EzMmVTOUpTYzJDRzUwbkpSWkUxMG53M1U4N3pIdVhpWC82OHl2QTYwbmps?=
 =?utf-8?B?anB6NTJvZkw4VUV6QUo0aVhqZHJGQVI5dWJ5eEQ1eGIzaFpwelBMdlY1QVRp?=
 =?utf-8?B?RU0vNlBBcnVSL3ZBU1FmTG5ScmR4Qlp4UjdNeVpzb0oyN0RWTmxwcHdETUx0?=
 =?utf-8?B?UmZwOVlKbmFwSzZRLytQNkNQU21UQUY3VStxQnVyeEVFOUZMOENlM2l5aUR6?=
 =?utf-8?B?SmREZDFUVVVjbXAvWU11MDFnQkoxZ1hOOWRkL3JzN2FpRUFrYW9hamFyR2Nu?=
 =?utf-8?B?M3BYeDlHb3JoUlhldzFWUmtxRFVJNWhDTXFDZmhWR29NOURhY3k3bFRuZjRa?=
 =?utf-8?B?OXJFbVovWFh1bzlXaG9mcGhTVDZpYXNiYVZkN2M4bnRmN25iMUIraWt3OWdW?=
 =?utf-8?B?SXJNeWJEenNuL0RBMFNrSjhndENXWGIreGhCbHYra1pxZURVNUlkdVd1ODhh?=
 =?utf-8?B?K3V2S3gxZlBGcklSZUQvb2NGcmxYaFRPWEpTeGprTDlSdmhpY21uWHBaSFRq?=
 =?utf-8?B?TWF3OGYyUkRnWDhXM3BmK3gxbWZMVEpqWHc1RUZqc1VCWE51ZEtsZC9wendO?=
 =?utf-8?B?NVNHRGV5bkRpYXpweUF5WVUxMHFERy81WGZZN0puSXVLS1pXMEsvT2dkOUxJ?=
 =?utf-8?B?Vmw4aVR3MkRMblg2Zy85aHA2cmpXRHVlRnBpNW55aDgvYUZSZURDTlRqUWVi?=
 =?utf-8?B?KzMyd0s5SHp2Tk1IdWxWVGJMY0lQeGVvWUpmNE5PcmQ0bERnUFJ4enI1WExt?=
 =?utf-8?B?UWZQSWEzaVpwQmQ1ZDJkdm9hRmYrSmQvaHV4ZXNnYXVGNTNmY3QwVklhNjQ1?=
 =?utf-8?B?U1pmQUY4R1NxUDhPK1RDK3E2QmhzYk1od3NLQkJzWG5vdzRKN0FtOERJM2Yr?=
 =?utf-8?B?NHRzelBhaUl6NTdXNVROd1RjVlBJZEZrNHRBWWhQRXBSQkpoMkprMG5uOE9z?=
 =?utf-8?B?Y2daTVRJY3JoeEZncE93Z2orQ2xrbmJJYjN2NkduR3hyUEQybzlGN1VqL2JJ?=
 =?utf-8?B?SmE2MVA1ZzNzUnN1R1VCOGhiaVZuM0RjemlVYVpTTFloQ05ndjVQbHlLdDEv?=
 =?utf-8?B?RHdpSEpkWVpYakgzYjg1b2hvS3NBd1JUcVhodGVYbW5iNXZFNkp5a3daNm9N?=
 =?utf-8?B?cHBzaW5CMHFHZkpmVkdnYkZ6OFhUL0EraFA3T2IvenlmZVhEYkU3bENvMjVO?=
 =?utf-8?B?cVlKdlhaZWF0WkpyQzhINjY1MDQ5TFJ1UmIxc2VGdUJ4Q3BhbUc5ZWl1U0l0?=
 =?utf-8?B?TzFjSEdXWXJoRHdleFBVdHNIa2dpbmdwNlQwS2F5ZmpxNmhEcDJtc0xRVlFP?=
 =?utf-8?B?YTFZWW1EVWFaNTR0dEl0QWR6YVY3MHlYaE9NZWMzZVl4NWU4QkcvNTc4U0Y1?=
 =?utf-8?B?RjErQjd3a1kvWi9JTlBpZzMyVTMwZ2ZybUlzUVJuWUFmL2tsVUlIekdKeU1m?=
 =?utf-8?B?WUczYWRydUtIS3lLSnFsUkZxVjI0aTUvc0dqOWozL25JQTFYbTUzT2tRaDl6?=
 =?utf-8?B?ckFRSnZmck9wYXdXWisxSUswWTllaUJiMEZrZDNmLzVPbnFEUnpiUXlwZWFI?=
 =?utf-8?B?M29PcE9Ed2V6ZllNbitRcWU5RWRpTUoxaElGNUNUaW9oV1JPV2J6WkRCTFBT?=
 =?utf-8?Q?VWAC54qsaPmWACV31yxGbFy6tbmaW1j1?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 49db9ad7-40a5-4988-ce6d-08df097e3734
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 05:43:01.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB11659

I'm not sure if its acceptable to use newer versions of curl.

This patch was rejected because of this reason: https://lore.kernel.org/git/7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com/

On 02/09/26 5:43 am, Wolfgang Faust wrote:
> The documented purpose of imap-send is to upload draft emails for sending
> later, but it did not have any way to mark the messages as \Draft, so some
> email clients presented the result as an un-editable, un-sendable email
> even if it happened to be in a "Drafts" folder.
> 
> Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
> ---
>  Documentation/git-imap-send.adoc |  9 ++++++++-
>  git-curl-compat.h                |  8 ++++++++
>  imap-send.c                      | 15 +++++++++++++--
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
> index 1814d94491..cf415df45a 100644
> --- a/Documentation/git-imap-send.adoc
> +++ b/Documentation/git-imap-send.adoc
> @@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
>  SYNOPSIS
>  --------
>  [synopsis]
> -git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
> +git imap-send [-v] [-q] [--[no-]curl] [--[no-]draft] [(--folder|-f) <folder>]
>  git imap-send --list
>  
>  
> @@ -55,6 +55,13 @@ OPTIONS
>  	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
>  	set.
>  
> +`--draft`::
> +`--no-draft`::
> +	Mark uploaded messages with the IMAP `\Draft` flag. The default is `--no-draft`.
> ++
> +With libcurl, `--draft` requires version 8.13.0 or later.
> +Older libcurl still uploads the message but cannot set the flag.
> +
>  `--list`::
>  	Run the IMAP LIST command to output a list of all the folders present.
>  
> diff --git a/git-curl-compat.h b/git-curl-compat.h
> index dccdd4d6e5..032aaf7126 100644
> --- a/git-curl-compat.h
> +++ b/git-curl-compat.h
> @@ -67,4 +67,12 @@
>  #define GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
>  #endif
>  
> +/**
> + * CURLOPT_UPLOAD_FLAGS and CURLULFLAG_* were added in 8.13.0,
> + * released in April 2025.
> + */
> +#if LIBCURL_VERSION_NUM >= 0x080D00
> +#define GIT_CURL_HAVE_CURLOPT_UPLOAD_FLAGS
> +#endif
> +
>  #endif
> diff --git a/imap-send.c b/imap-send.c
> index 0d16d02029..bf1d2cf74d 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -35,6 +35,7 @@
>  #include "setup.h"
>  #include "strbuf.h"
>  #ifdef USE_CURL_FOR_IMAP_SEND
> +#include "git-curl-compat.h"
>  #include "http.h"
>  #endif
>  
> @@ -49,10 +50,11 @@
>  static int verbosity;
>  static int list_folders;
>  static int use_curl = USE_CURL_DEFAULT;
> +static int opt_draft;
>  static char *opt_folder;
>  
>  static char const * const imap_send_usage[] = {
> -	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>"),
> +	N_("git imap-send [-v] [-q] [--[no-]curl] [--[no-]draft] [(--folder|-f) <folder>] < <mbox>"),
>  	"git imap-send --list",
>  	NULL
>  };
> @@ -60,6 +62,7 @@ static char const * const imap_send_usage[] = {
>  static struct option imap_send_options[] = {
>  	OPT__VERBOSITY(&verbosity),
>  	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
> +	OPT_BOOL(0, "draft", &opt_draft, "mark uploaded messages with the IMAP \\Draft flag"),
>  	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
>  	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server"),
>  	OPT_END()
> @@ -1416,7 +1419,8 @@ static int imap_store_msg(struct imap_store *ctx, struct strbuf *msg)
>  
>  	box = ctx->name;
>  	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
> -	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
> +	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box,
> +			  opt_draft ? "(\\Draft) " : "");
>  	imap->caps = imap->rcaps;
>  	if (ret != DRV_OK)
>  		return ret;
> @@ -1718,6 +1722,13 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>  
>  	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
>  
> +	if (opt_draft) {
> +#ifdef GIT_CURL_HAVE_CURLOPT_UPLOAD_FLAGS
> +		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, CURLULFLAG_DRAFT);
> +#else
> +		warning("--draft requires libcurl 8.13.0 or later");
> +#endif
> +	}
>  	fprintf(stderr, "Sending %d message%s to %s folder...\n",
>  		total, (total != 1) ? "s" : "", server->folder);
>  	while (1) {

