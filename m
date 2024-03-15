Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2108.outbound.protection.outlook.com [40.107.116.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521C14A98
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510582; cv=fail; b=aPhO1tRUfK081S5G1Wf0QTKWY3aB8f3ZUpghm3bNmvv5fsARyRGQO8ycNqNpdzgwYiiLcm+9c38F3F75+aICkLR0fUlqY6/gVfSDyJp/fud7RPtxJN8umMyciPQeKwZj5XpmFmw5TyOTcxK4io5/w/dQjIJmRIGl161rdG+04Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510582; c=relaxed/simple;
	bh=tj42glYV8k7rBhGP1H+2EXOa0Yqh16waDIUIMxHctRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i/JNxiHZFkYndW0dTk+e7LaA55+8iOwVPADufHw0BWCa7zBQ0md8X2LRYMcP9EBdw1GPCjVpWrz55A+PEl7hv00W2Ljl8AAlDtpaH1Nx42488MzATUVmcFDoS5YxgMpdNInYeSXKyRk0X7PhLVXENXgCM/+YTExplyBw8ZrbB8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=QvVO3tG7; arc=fail smtp.client-ip=40.107.116.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="QvVO3tG7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTne3VthwY4htDMufKTbZ0Q5rqKpiZLbgZo2RZqLNvwYqpQsoGBd4+ttydVPgkBYS64Ktk4f+uMYOgBwCkx4b8+xyLraWCQBtwmV40OOxZPIP2AMjA/RpPoHQGiNx2gbIkAs/jGTOPvvxh6zQTc0Wm/mpcy6uaH7USN0RH+h8BD9xCHsfBuzJrQFwFCX+WY3LGD+IpAIpH/HWx697gL8tB5UKC6f2YW6cfDcxZsxrlmlP/PEruvPouEp+9V3+bHEnXS2cdUqgVpa5XnPSa479MTfo99kEOPVaSXTc2uXl+83wEYJ43dLFQGWtbcxrVzGxVtAFIzvxhUuPCuh1jbqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ4lHQKOwaprzPFra2c4qagcots7BZ1YW13IZ0wSLUI=;
 b=eqnpV34I66zIDrCWQZy9T2Gt3mh8Ilu2VgtST/HF1zjsepKoP3c5dxhjVCqtDHV+BeHexJl6yXjbL7YBhxXtUmGRZOed0pq00pYGAk0qEUG+AZbz5Q7Ax8b6Y/a60UFpAiirtbOhDRtDA4H5LTnesypEev6jSe7Z+ytc7xLRu9ahnp28w8u8SK2mFK2UuJOyMOXdZFsfxP161IeChSkNcXb2hWu1Rcciv3dVfDpjIhlwcWR69+Wxrc8TmdBfjX/CxKqM4qujx1pObZmLZ+ZT/63kCrJ3pdspapW8wSwNG0YdZKsB/uMjUOl8JhoeZnEkSdF6XpOvsWDQtOk0rqHc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ4lHQKOwaprzPFra2c4qagcots7BZ1YW13IZ0wSLUI=;
 b=QvVO3tG7YvLjuQxFnz+TD06HVBPrFU0EwxBInqdRT8JwRASZaoqrTE0zrqxQRo4Lljnj+fUUIsNmcaUwb2WL9NPAvfHOul0DV7+uBHg4eskfsBmDAp8iK4TBLFVfhAxES4ZBlkj7YimwOsGBmZN4mOTMCRlJ3+7QYeV6HMkSXwsi+j/Q/OBiNKyndviq926id0cLgObCEgc2rPEpFGIfBiE/dal72C1lW1PzAs8uDHio+a10KDYHsar5AAukAk6j5vEGKIqwXnByvfzHNGEx/o/MVt9+FKdMmVCFHmF0vV4eopnxPUmRlilRFL7MGZyTYFGtHIMNaVVmJkKT48v5kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:107::20) by YT3PR01MB6132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:69::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 13:49:37 +0000
Received: from YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8c0b:5bc7:8d01:89a1]) by YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8c0b:5bc7:8d01:89a1%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 13:49:36 +0000
Message-ID: <4b8823f1-5029-4097-a3d5-ab4a6a02c482@xiplink.com>
Date: Fri, 15 Mar 2024 09:49:35 -0400
User-Agent: Mozilla Thunderbird
Subject: sshd support for Git protocol v2 (was: Re: Name for initial branch is
 ignored when repository is cloned with SSH)
Content-Language: en-US
To: Jeff King <peff@peff.net>, Yasuhiro Kimura <yasu@utahime.org>
Cc: git@vger.kernel.org
References: <20240315.104939.1269594475664662053.yasu@utahime.org>
 <20240315054936.GA1741107@coredump.intra.peff.net>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20240315054936.GA1741107@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::30) To YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:107::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10530:EE_|YT3PR01MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 72936ec0-a465-45f1-8854-08dc44f6c0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/zyPKgyhPrw4htkVFRKMFYdJrIJoljQJZ+cKSkjzDLg772rNr3rninPnoO91hyk9qxTu2U3MKyRZOhBFNpfnwmtb7yI6YK5EesrVt3cyN5uPArfeIEKFTg9ZkfB76u11Y7fLj36Jsyi8IL9Ai0+T5Yu4RyiE90YKke89hSMdoydqRjXYRe/hFlhZjkiPA8+uTzXfuziPIB9UZUYUIi3iiai12se+1bobM8SOQdxh1hI81dhmsS2XYP0iKPer5WbXut9nN6GzN8fOBw05T65hRA89TgH+9mnmpL//L0h1VYbdDKwFu2eWQayJWJ8HQQn/3u38cnMaL8KbGXtmfWrJZL5k0dF4GHg0YtCPfIwmeqNKOLIZ5i7xHd52+j/NuhhHdneBNGFM94Mr6uQkbGwOM5WkUa8YaBn9cemF/Mcfxlt6ZFUg4Y5jDWXi/q+wS4fl45yN9BZcmIXNusW+ad7c0RWBQJvvlvu6BpXNntddaPZDopfErQ4uagbzSEKBmn7Phng5dnYyk6sJg8rnpn7Pu+pjoR842a8j/z2AN/AE8qGswUUiXuCieQstpb8qgdA2YbiUNHxira0wng/qthF6pPdkoQQrcxoNEsAa9c3q7bJjEXz/MjrwlahRGbHCFFKauQ73gUmCXSv7IAaYuhhiEAVyKTZRML0pmLQe7Uf8tE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNHNWZpZ2I2WlJMVkdRcy9EZGdaQzY3RHdaN3dyR2FPRGcxQ0tEWlFwZTZN?=
 =?utf-8?B?K0xSd3pKZkxQck43OWcxVFlvVzlOem9tUkFteWNkcFJuQWVKSkQ4MTlGQ1RQ?=
 =?utf-8?B?K3p2TEViMTdmbmJDeFlCTmwybUd2YWRyendheXNMN2JIMFlwSTErNmdoUjl6?=
 =?utf-8?B?cE1iUkRxcHFDZjM5R2lVQzRGZDFlRFhXemhMMUhOZExOd1M1c1VnZFp5REdN?=
 =?utf-8?B?aVVuYTNSbFpWVjB2azNsMzd3ZWFMOGlWbGwxWHhBTG9ydG5jblFkS3RUeVJr?=
 =?utf-8?B?bG16d2ZxUmk4LzE3c3JVelVIU3hmenZpbVNPRFk1TnI1SkU0RnR4eVJaUlQr?=
 =?utf-8?B?V1hwaDJTd05JeGcvWC9GZ1dsUG9EQUt6Y2xxTi9sT1g0QTErT0hwbDd2MXl2?=
 =?utf-8?B?NXpTT2FRcURsbmZ2a1ZHWE5YTTlxVzBhZUU3MlkvRHpJSUV4Vk51MWdjT1pY?=
 =?utf-8?B?V2JNQktFMXRBK0V3U25reTlGRUhpRjFaczRFOHM5S3F5a3dmck5wN1IwVSth?=
 =?utf-8?B?NjRxWC9nUGZpVGY4L2ZlNTB5cTJRN05JN2gwcy9qRENrOWhtUzdJUHlzQjJK?=
 =?utf-8?B?T2ZXRXd3WU4yejIyZGQ4eUJKRlVyNk1MWjJHRUdXOVM2RTNlVHowdjZWenlP?=
 =?utf-8?B?OEVOU0hmRE9mZEk3ZFB2MzU4Z09nQ25WOXhEQUx0STlsUnNjSW1aTnh3MG80?=
 =?utf-8?B?aDhMdVJRVlI0cEFSUWszeVRtZTR6NzBDRDZxZnpWeC9FeXlYYVBIcHg2eTZ2?=
 =?utf-8?B?Q2RrK1dobW10eTg2WEV2NXpDMjVvUnRYQWtoS2hOdWIxNkx5bi9rUWJhU0o5?=
 =?utf-8?B?aVdYbUEwU1cwV3Q1SWViL0J4a3kxcWRlckY1NFB5SDFaQVBPbFRVVE5Qd3l2?=
 =?utf-8?B?aXQ0RXF3VjJxUXQwdG1sWFR6akY5M0NicXJURW10Wnk0Vk5kM0lxS3A0R0dU?=
 =?utf-8?B?MTNuc3JUbCs4V2F5T2JsbWV6aG5zQy9Pd2hwM0Q0WW5ObGVzNkYyWnpXdDNF?=
 =?utf-8?B?TTZrbjJFeldtRUlDZy9tcGQ3dzhVUUR0dTcrUEtJOTVBemxXOVRUQjFNK0dr?=
 =?utf-8?B?aUEzZHMyb1loV2hKRllCY0pCSzlQWFlDSFFFTmdVMmRiQ3N5eWMxcmk0cFNO?=
 =?utf-8?B?eWthN0M4a0ZhMitoTGxpYnljQzg0OW5oWU91RDJIS09RTWxrTGQ1WVhXQm43?=
 =?utf-8?B?ekhvWE9LM1FpRldac0s3Q0FEU20rQkhnYUpVRGdTZWRlcFpPODV4cmt2UDB4?=
 =?utf-8?B?RmlnbDh1OFJXRFo1eXJZYjAvVGo0YnZrYkFuaU5MVU1TOTZGNXhIWmNBNEty?=
 =?utf-8?B?NFczNE9Xd21iSTdnU2E0bDJ3VGV4d2YyYzlOakpFdDI4bGtiQ29VczVZT2k1?=
 =?utf-8?B?cW8yQ2F4eEk2Q3RhOEV0TGtPdHVwUFp2V21JTENEZ0tiODFtalNZbFpMelpY?=
 =?utf-8?B?Vi9RVWZEcnlHSWd1SnJoeEwvUUtvaXBMS3RSd2FzNS92SWdpc2RGenllTC9H?=
 =?utf-8?B?aWdoNVVQVXpxM0xBQ2JVeDBRZEozR0REdmlWdVhpOUk1bVJ4dnNob2Z2dWpJ?=
 =?utf-8?B?c3JQUjgzMzNGejJKK1ppMkdOZUhWckZMSFpYakpZeGVSQ0xKQVFOUUZYdjdH?=
 =?utf-8?B?WXM2RUpvamR1NCt6NFFlRDRqa1djWXdIZEdhZzBBUjE3TGtBV3Q4aDd0NzEx?=
 =?utf-8?B?RURJMTBjenZrdU9KWEtOYjFOdU1LM2NZaGJEV1pTQ1ljd0lMc3lVR1BUU0N5?=
 =?utf-8?B?eXBheExTUjlhckVGQ2t0emo2b0xtQkVVYVBPcEVYV3o5bitBN0VlcW9rZGpZ?=
 =?utf-8?B?NTViaEdRTkZUM0s0WVM4ZmF3c0RmWG5LdHJYYVA0c1VEOWZBVTRycVQwTitO?=
 =?utf-8?B?b0ZEOWMxQklib2FLcWhGSTBDTGZRUnBWZjBZc1JtK3pXakJ0Q3dLOHFmNUJ3?=
 =?utf-8?B?L0trdnlpYVpyaTZxdjA1cGMvWG5RS1ljOGlURUVFMWxzWXd5QUprbm96MlIr?=
 =?utf-8?B?RW5hL2hTc3c1M1NMOG01MkZYd092czJvTFJSSlJIK2ljeGtDU1VnZjFPaGJH?=
 =?utf-8?B?KzRIQWEwQ3U1bllUYzJFcUJxUFJHdmJic1NUUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72936ec0-a465-45f1-8854-08dc44f6c0ad
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 13:49:36.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaocqkkwJd9AaXE0vWbnvlsg3BXB98d+dc9CPr7B0lF52q4Y48Tfbiu+7jIUKIxriR4n6NPYSnOht0DjHoxrSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6132


On 2024-03-15 01:49, Jeff King wrote:
> On Fri, Mar 15, 2024 at 10:49:39AM +0900, Yasuhiro Kimura wrote:
> 
>> I expect the change is committed to 'main' branch. But actually it is
>> committed to 'master' branch.
>>
>> Anything else you want to add:
>>
>> If I change step 2 as following,
>>
>> 2'. git clone /somewhere/test.git
>>
>> then I get expected behavior.
> 
> I suspect you are running afoul of two things:
> 
>    1. When cloning a totally empty repository, detecting the destination
>       of the unborn HEAD requires a protocol extension. This extension
>       was implemented only for Git's v2 protocol, not for v0.
> 
>    2. Git should automatically use v2 in most cases these days. But it
>       does so by probing the server in a backwards-compatible way to see
>       if it also supports v2. For ssh, that probe happens by passing a
>       special environment variable. However, the default config for many
>       ssh servers refuses unknown variables. For OpenSSH, you'd want to
>       add:
> 
>         AcceptEnv GIT_PROTOCOL
> 
>       to your sshd_config.

I've been the corporate Git Master here for over 15 years, and I was 
completely unaware of this until today.  Thanks for pointing it out! 
Our internal Git host now finally supports v2!

		M.
