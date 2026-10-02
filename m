Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022123.outbound.protection.outlook.com [52.101.101.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25E31D366
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978381; cv=fail; b=i4JhkBuZc/Bx2p3IA7E74cuuzj4rD5ohUphSdWO0cvo9IhLc4JvJaSq1O4Yl6rbqQ6Mgl7U9u0nb1cEbrZOV/7u2nzckMDQDLof/d+BW55bYYOItscLocElx39oEbvn6EmSSoVNT5JFb2QTAgF3nFxBhzQO8VwtILThlxU+nRLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978381; c=relaxed/simple;
	bh=uYfbYAc937h3+DMJYPAXQJs7z7eYObexhC0beCZYo+c=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=H33+V1nHz+gpb2/2Z0jPAY2ZeOENsQoaYNaVGT+oOg4kU8dbndlFzxWTwRznt5VFnAokpD5jmY3fXwNq+Z/uSkQ7lD4JSLBW6bsBHVk1CvQV8SpzDDVhoRawDzeVmzxSEC/YbQrEpok/7yLyc7cOxa6pvEDnrBxZv+a7sQxIMuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diogocastro.com; spf=pass smtp.mailfrom=diogocastro.com; arc=fail smtp.client-ip=52.101.101.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diogocastro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diogocastro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZmkHWmCoYlK9F/TVn6UbDP02vcHBht+WHJarYATjBPs431d5VwnkQLFz52DHqKqW0q9Z1nRUBtCHbHYhASWNR47ib+H+7TofL+6RgsdmAphJAAaId+Uk2jqRtPVLZ0duATrniisqK7bqCkYAserkzcFmQV2yWPnOBsdgBUjTuv916SdDhm4YMS8w8SrNYOM4rVgLIAOGa3+2PpK7cKXdQmpH3WGo8pZ1EUFxw7SprU8STZWyl56CTwXg3OqQ8BBGbczgWrlR+mq+wFtIbwtH0gfz7iU0VL2s05QRDGRw4bBnYOBdPtVHHLWutCYUm1nFjYemD3ezYoHfmncCtiz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBDTtLm7wecb6NJxmR3XbLNctw0LoWW2ziKRMmzF7fM=;
 b=scUZpuT+v/tbzJFc4r1/lpHJbSrFA4f10PGdhWq/uQkt2iQdyeDOh0+JO5EMBMhcYXKGGA+iEaKldvzwnGYvWZ7+/lC6r0Vuu705nk+eeTlLoZWHhu7o+1v2qNVG89l6Uu++hzC10SF1zxBw1NDSsxPaLG/xCQTppQDOP8H2QrmD8v+lZS+EFfP0IaKWvoMvWC8RfEBct7cZyMtZ3M90PgxCtN3dQFDSmbOrOnNk5R1oQhT8gIiGX6bgC9kCyHbTk5DU7V/hJbwzFM5173XW6LTODN4K9R0NL91fzCTQyC/ayUPP/5UDqdy4+Ma38XexqN3OkSuyWwJsJ/nxvX7DRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diogocastro.com; dmarc=pass action=none
 header.from=diogocastro.com; dkim=pass header.d=diogocastro.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diogocastro.com;
Received: from CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a6::12)
 by LO9P265MB7429.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 21:59:37 +0000
Received: from CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
 ([fe80::89b0:b7f3:81c9:8447]) by CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
 ([fe80::89b0:b7f3:81c9:8447%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 21:59:37 +0000
X-Gm-Message-State: AFuF++m/udKZO296VLhDEziJFWKLpU0aB67Ll4gJQd4SYt2eLc4FpW5X
	S+llbTlGlgXNHQyjiPiBosgMqWcLUYMc1ZsxxRqEnnCi7rxUNnuB3gCwZ6Nq88ow7IgcQx//ZKV
	Av8nLy/eZzURU3I7bCGkpXrO6ESaBXSc=
X-Received: by 2002:a17:903:41c7:b0:2e1:2ce5:677a with SMTP id
 d9443c01a7336-2e510527943mr7562485ad.16.1790977984697; Fri, 02 Oct 2026
 14:53:04 -0700 (PDT)
References: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com>
 <xmqqwlta2agt.fsf@gitster.g> <CAJw8QBPbxangB90DceDXxaDmyz8fn5jbEUihhe2faJrZ3o7BeQ@mail.gmail.com>
 <a8955129fcb7478f9739c8586c6975e1@CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM>
 <CAJw8QBMmv=zLN6sd_W9uQMF3H6Baatyq=TogLyZSFXK2gN4V8w@mail.gmail.com> <xmqqv78qw3hc.fsf@gitster.g>
In-Reply-To: <xmqqv78qw3hc.fsf@gitster.g>
From: Diogo Castro <dc@diogocastro.com>
Date: Fri, 2 Oct 2026 22:52:53 +0100
X-Gmail-Original-Message-ID: <CAJw8QBOnpkXAG3i6BGL6nKeyPgssr9-qJ9vdgH_MhYJi9VhrMQ@mail.gmail.com>
X-Gm-Features: AclHuK-FMo17ZocRi2uc8Qv_tOFi8vr71LGE1icyGfJtIPzI1ygjnXjL0_QU74M
Message-ID: <CAJw8QBOnpkXAG3i6BGL6nKeyPgssr9-qJ9vdgH_MhYJi9VhrMQ@mail.gmail.com>
Subject: Re: [PATCH] dir: fix negative pathspecs in 'git ls-files' and 'git add'
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Thomas Haller <thaller@redhat.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::31) To CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1a6::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP265MB5784:EE_|LO9P265MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 1979cc32-ece1-4c8f-6cb9-08df20d0736c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|52116014|56012099006|10067099003|4143699003|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cJYQeOJHtmX6VKVyy2RkyeptC2ED9uPz9Jo+cEqhw5fuknwdc/D49ZEHXRAlEwKGUSjq06LRhkcKjEo14f0pgj8yLu6ruAEp7vcxGCja2SQmFt9cXrJI0+YuxYd4ffA8oIEpKOTSXJt0uObXHTCvQqoSVgJQpRLlE36wuY84tZ6d0lXrmpPqo0HqdlHlbwdi8EQN16mr5duFXhi7n8prwMfo5SwFYNpqr9w4pGxKRclhwgdUKJbUhrmgEVaV26AsORPgP898H+71FMqEcrLMz3rj+KKICNTm17MpqUl1y8CEsQ74R3ULAMUCox+x/0XJ6l9wJ6tm7WPEvmbVId5uUHvNC22Xw/UczxO6xUydG8sv9Edz01k9STRBBk8r9OQ1MP6CvpZXroMp/Y7sbLteSHqcvmn/BWrsEAK9MtLbHIDbA8NGWUQelO1AbG0VDorTzsI44eeOJ7wVNsMX7+3Qylj+Fokb333u1tfQGRvRkJnZo8Fo9WKR5wZF/X4cbQQPE12BUPf0YiQzz1Fbd1ItLRy6NBQj8P3En4CcII0ANGhw29jVWAIeOXUyiG+zYSymW1f/7IQndNIozFOi+pW1kDIlM5LiIzn6QV2SCheH/jOWkhej+6AEQC0CYX+fIENc6g85RiAWOvAw52F8lSd/UupA2wsttnNt/zUo8Yman1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(52116014)(56012099006)(10067099003)(4143699003)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHc1NkJjeGc2U0lESEpMejJVSFJ3bERKNVI4Z21qaHhTM1kyR0QrUjJ5RmZ6?=
 =?utf-8?B?a2RsSzhCcVhDZ3pXSkZnUDhmTTR6alRVb0IrLzNzRFJrNTg3Z3poSUtydU4z?=
 =?utf-8?B?SllFUmdQRGRUdVpJU1pmRVg5b3pFTk82TXhHc1FRczVJZE5RaE8ySENPQ3U3?=
 =?utf-8?B?TWxEVExUT1FDbzZPNmg1ZVVMSXdFaWlTbExITS9qZFhxSm9IT0pqRjVLeUdh?=
 =?utf-8?B?V2F2MFVvYjJvdWRXUm01QWlVVGtvcFVQT0JwNS84K3UyRXg0ZmttcU82Um9u?=
 =?utf-8?B?Zmo4ci9RYmdZaGZFOVcvMm1QcE9nam16bzdRMjFtaWJrVk9lSnB3MW9MaTk0?=
 =?utf-8?B?Tnk2NjJrMTJvaDUwZHpTd3ZWdENiTVNEY3dLOEY0djAxVExua2xJMEUxVW1L?=
 =?utf-8?B?Tzk0VjdwdS9tdHhEN1E3WUxTQVR2RUxBODBud0c2R1dlNnVkQlJJQUJSa2Rr?=
 =?utf-8?B?MmdPS2toeTVQOWwyVTgzMThzNElhZzRPUXI3Rzg0SnR0K28xUUlwNlptYzc2?=
 =?utf-8?B?dDN4VGZPa3A3Y0o4VUZZNEExSit3NzUwOWRKKzRTeTZ0c21WQ0xuUHNoMzZG?=
 =?utf-8?B?Y1E5VGdEaEhQQ2Q0c2Rsb2xzYlZMUndxVG9tVHBGMGFpUllhQldzWFNPSkEz?=
 =?utf-8?B?RVZxcG9zMThqZ0F3V001ejAzSW1TUzI2MXkzRGtmTlNOZm94c1pNSm9Qczlp?=
 =?utf-8?B?cEMxaTNNN0ZGVVRiQkh5aFJJcTNucDVxUHhpb2g5UGhUVmNSNFVDOTJVOEJF?=
 =?utf-8?B?SmRtWDNLSHJoT1pzUjc4STBqa3BvaEFXSGlDN0graUZMRHVBZkFnVmY4ZEx5?=
 =?utf-8?B?NjY0Sm9ETUtmMnhDUGxiR3NKLzk3N3FiU3JDaXEvamFZeTFOWi9KK3ZGZ0kr?=
 =?utf-8?B?b1FManNvSzgvSWpYZ2JZamFIdDVIbXR6MTZ3RXR5dng0dVlvUUk3dldwc2M1?=
 =?utf-8?B?T0FFQnRheEE1cnpzSmNGdm9RL0xGWlZaMjdxY1dJOENGdHcvaDZ0SmxSMFBi?=
 =?utf-8?B?SFY0bU03NEtPQnEyS1EycVh0TnI5U2F5ZTZXdzFBU21TeEU2aUg0STE2VVM4?=
 =?utf-8?B?YUtKZHppN05OeTROdlg0UkVEMVV2dmJZYjdMcE8vbXVyRzIrc1NKS1E2SDdV?=
 =?utf-8?B?MzM1cHZIYlVmTkNrSnZ3NlpBakVzcmt3VnBCQ1JMaWJJME5HanFIeEpnVi9i?=
 =?utf-8?B?bTVWTTN4WS9JZVNzNnJmOVFZaWU0SkNnaW9rbXFJNUNOdzlFOVkvbGtIUHlZ?=
 =?utf-8?B?WVhlQS82QWY0RkhoeHJ6ZENOVnZmcjNwRVhPM1M2Z0ZWYk9YZjBLRmR1dFZE?=
 =?utf-8?B?N0JtVCtHcjgvYVd5cjVLd1F5MnZUNGp2c0lQcERGUlFaN25vQ1RWcUlNNjZo?=
 =?utf-8?B?ZkNwcncyOHFQUVFCNXkzNGpGYU55d21qZktWd2M4ZGhubkl5U3czUEdwelNj?=
 =?utf-8?B?K2pWYnJIUU1pVGxWSUQ2aTdKdzR1Q0JGM1ZFUlp2Zjc4MWRjOTVTQklQWjNI?=
 =?utf-8?B?N1k0WFhVbFRzR0xOdFpNM05JS0hYa1lVaEZCTmlHbFdCaGVGTXJEM1FWdVVq?=
 =?utf-8?B?aHI4aER6Q3BrN1hNNm5ndmFrVGxjdytYZTNCaXVZcEx2eHVqOWNQcXJyUmw5?=
 =?utf-8?B?OEIxMU45N2xRcFVvSk1YK09odU9KWmZLN0JQUXZiSzhYalU4TWlNUzBrdGI4?=
 =?utf-8?B?M2p3SlQwN1lDZVhqNVVBNi9sa0lldzVuRnpjR3Z5OWpSUU5qMWUxdjd4dGRN?=
 =?utf-8?B?a09sT2dCVUI0YVJrR3ExR25uNWg5OC8rWGJRcUxGTWFZRVFyUmtIMlpkTElu?=
 =?utf-8?B?Y0lFeVlEcGsycnorSWIrYXRvV0VJd1A3U2RRdDBKZ0Y1dVE2NTFEODc1OUJs?=
 =?utf-8?B?TDBQR2Q1Qmw4YmE0a3NLK3VEQkx4TjlScjlTMHBKUXprcnJxRitlR0RPZW1z?=
 =?utf-8?B?UTdTVkdPeTNYRlBrM0VOdnVpUnQzbTVhVENyRldkNXFDeWtyZVJYeHk3USt2?=
 =?utf-8?B?dlYzM1hIWkJtdU1NZ1lRUUZvYmNkSzQrUFJ2S2FhVnAyN2ZFLy9hcUF5eU9s?=
 =?utf-8?B?cUsxQzJmcXF1RE82YmQzRlJXdFVoSCtNWWMzemIzZlJPNStKY0ZQUzRqV0FF?=
 =?utf-8?B?b2N6THNoRm53WkY2R2lYYm1qUm9IaFlkTmdTYWNtUW5hVkxNKzYrWEt2TGgv?=
 =?utf-8?B?NDFzWG1rY3NZU0VZMlg1TjFnYlhzODNDS1Fjd2JxWXVxck1JemtVUjFZUjl5?=
 =?utf-8?B?Tldvazc3MTkrUElwdzRoYndNNklHMGRFVG9YOFY4Q1p1SzN3Vnd3NzZlY1N0?=
 =?utf-8?B?K3NQbUhuS3JzeVZhNHBLei9IL1VsTldTcjdZcFgySnZmMnkxWlYyZz09?=
X-OriginatorOrg: diogocastro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1979cc32-ece1-4c8f-6cb9-08df20d0736c
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:59:37.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 68708ab7-2c25-4153-9869-a0a6b92bb578
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/sxUruVT/9ZQq5yDoCvw13s06n8X6vR05nIWYsxFoJFEI3yioOrYzs7f+JecTeUVdKgs/6xfYGHbSSQAEmH5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7429

I see this work has been incorporated into [1]

I'm closing the PR on git/git.

[1]: https://lore.kernel.org/git/81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de/T/#t

On Mon, 31 Aug 2026 at 19:26, Junio C Hamano <gitster@pobox.com> wrote:
>
> Diogo Castro <diogo.filipe.acastro@gmail.com> writes:
>
> > My point was that computing the common prefix across both positive
> > *and* negative pathspecs would not improve performance, and might
> > actually make it worse.
>
> OK.  Then that points at the right solution.  Ignore negative ones
> when finding what the common prefix is, strip it only from positive
> ones to reduce the width of the traversal to come up with the list
> of possible match candidates, and match them as full paths against
> the negative ones to cull "within the positive set but is excluded"
> paths, and the posted patch looks good.
>
> I still wonder if we need different implementation when we have many
> more negative patterns than the positive ones.  In such a case, the
> stage to filter paths that matched one positive pattern by finding
> matches with a negative pattern among many of them, which may
> benefit from having a similar common prefix (among negative
> patterns) optimization, but that is a separate topic.
>
> Thanks.
>
