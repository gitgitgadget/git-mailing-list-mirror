Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022092.outbound.protection.outlook.com [52.101.101.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F135C180
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101866; cv=fail; b=JV4l4WsCYZiK60UXcLtCOiT0g4g/c8K3xwlsUPA7x6ekMygGiyp7EyfwFNmEU9q4qFKnG0OnPh5XwpI1w16yxne1857yz1xmeWtDRFZACEtfpV8/tdxYQa++u6/9U7LpDgnuJRbjAANmE6tU8aGYLriCSr4AQUBKqDOcu5dhv/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101866; c=relaxed/simple;
	bh=kaZ78m/vLhnI9K6ImlogpbDgHnR9XCYeiq0bZK+SkAI=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=c6yVYcpOa1gPcrdLrLN/F4c5p1IBHX2uFtOpqjIE61yitfJYfnC1uB9vON2R7xto0Yc+z3Gq2M4jYWOTLfmQvm9QV5MQ0C/iL47PHlSCyfZGxQcUC9ooNz9hHdV8t09MSWREiFkoLAk03zundaQUpUUC0LN5ntCEnt6CuDUVC3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diogocastro.com; spf=pass smtp.mailfrom=diogocastro.com; arc=fail smtp.client-ip=52.101.101.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diogocastro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diogocastro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCvSQJOlkxtA42ePNqI495LiS4cOSxWsNMNDDb5x4W13loi15aZRXguMzGC//gwFj+E7nEb1kTMKEMwtVvuJqjLb9Weo+dtipHwClmT3K3sPewYxEd1Sav9AqDXjJeWIPzOh8P+cWrkZ6bjbOXZVKIxTaIulrjtWS3zTCGQekUdRRyZl10QwATuM9uwvhVkhhSgEm7LLSJWzXmWoPXgLFOSTmukcpm90Ruecsdgm2bWSjkiey9i2BHHU7xK6pB87UPY8W+vQwOLvtKYnIFP9PGMr901sa4lQgcM0uRTdq2GNzp38HeChMbo1VoUSRya2dzUJhNE/khMG1Q7BQftkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsZRxFidQ/mZN2jnOTMsLs6rMFns8n9gpm3GzVis7mg=;
 b=FcOgtW9/JS0Qt7IjTZm0dk20NfHeM0NqAUKqp2XOW4BXmeAo0Inyh73E0MHuwVEmF5fJ5CXi0hy55iL7vbFPS255am16lDJWtt6T1QQ+r43hlNGHnh/8amlCrgaxAsJOe6ZR2g6S7DuUGLacokg9vyxUrZPIYq5Na46sLgPJ7BWZsOXiMBGIphY0PyMORjx1XwJplSa/8URRtw2cFmEgPL1hwauYBecHhytat82ZD9JW+IQdkHTS7npaI+o7rGBtGqQRPCkZocZptuKCXBzdjWdf5wv+cRCggWTIkI/ZBgDJUrPNkf1gnArRKnyrqKBfPhUCiV8V6L7mPyQ28JMOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diogocastro.com; dmarc=pass action=none
 header.from=diogocastro.com; dkim=pass header.d=diogocastro.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diogocastro.com;
Received: from CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a6::12)
 by LO4P265MB6477.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 14:57:42 +0000
Received: from CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
 ([fe80::89b0:b7f3:81c9:8447]) by CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
 ([fe80::89b0:b7f3:81c9:8447%7]) with mapi id 15.21.0339.012; Sun, 30 Aug 2026
 14:57:42 +0000
X-Forwarded-Encrypted: i=1; AKwUvBxfEHRWCw/dTqh0poM+VvhQ3IEO+fviRf20qOkHtEoDfvignH062JiMLnHyPwHYTywIW/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nN5l9MVu43aCfzAy9vPC/NgDbtSkhjirk4xWYFRCoj/ubrggY5
	eC9q7XrUTGoeYEy43xZy0jzZXPsbRWDHt4YuctptlcU8gEhAMwZQjOPnck1Cm5kvCvoz5KPHhol
	46qgyWfUG7ehL1Ql5giopLJxYOeRKlf8=
X-Received: by 2002:a17:903:4405:b0:2d9:efc:f208 with SMTP id
 d9443c01a7336-2d90efcf9a0mr62459285ad.4.1788101858279; Sun, 30 Aug 2026
 07:57:38 -0700 (PDT)
References: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com> <xmqqwlta2agt.fsf@gitster.g>
In-Reply-To: <xmqqwlta2agt.fsf@gitster.g>
From: Diogo Castro <dc@diogocastro.com>
Date: Sun, 30 Aug 2026 15:57:27 +0100
X-Gmail-Original-Message-ID: <CAJw8QBPbxangB90DceDXxaDmyz8fn5jbEUihhe2faJrZ3o7BeQ@mail.gmail.com>
X-Gm-Features: AcwNN1XIlV6paVVjH7FwUl3sFRFBWpLyrzJrDTS-j4tc0bDYl5clIWbA9fFgJHI
Message-ID: <CAJw8QBPbxangB90DceDXxaDmyz8fn5jbEUihhe2faJrZ3o7BeQ@mail.gmail.com>
Subject: Re: [PATCH] dir: fix negative pathspecs in 'git ls-files' and 'git add'
To: Junio C Hamano <gitster@pobox.com>
Cc: Diogo Castro via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Thomas Haller <thaller@redhat.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1a6::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP265MB5784:EE_|LO4P265MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 469bad57-975d-496f-e746-08df06a70b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|22082099003|18002099003|56012099006|4143699003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	EsJGu1PZNlMf6RppxCpyzfj8x0E/nNs9mRs43M9q1GZnkhti5NSevfjHWIDg1509KUHFlJGmi2Qp5ldK7H8/kNUFRUF+ldpv2mE8M0YXuVxQ8xI2fUlaYtfDAu7W9+axElPkoiu4cDw7VJsVWFrGNRXjbV6RvM+ypQ7llAL/dgGQecnyTIqylQsQZmaX3/DUdYgeGsE+VQO4ih+kNd3sdjROdTZ609zQayqXWTT0/VBOjrdRRop3QrG8/6nF4AYtGmqEEd5WbVtSMIgDoqQbrSPhDXuXW7mPVexOWn2rueEDLf8jPBDHiAcW6e7+abLznsRfjS7Di1H1tE7U9SzKp1rQWbMceiyWJy3CV3t9h6U/veyQrDQ8Z6XJ/JiOHOJ2bI97eKMWg178raOe7grS4hdSFHfeZQOtRgS8tr4sZD3EH9hmzdpb68spMcBgDdWPS6MQft12wjCroM4/nnuvAQ0YbfTCMz1soSD4+gIY2bIn11258mTxnZYo4IlgEk4kSAt13+pX+yePxido0SaJXSDTqBG7YdfnCkqXz/311HeafOuNb9+slIVQFjvvzVz/8P9JHhhxIqYE99Qp6AZ494kDufMNl7n0t89//fMb1ZyvTEurmva7mnEFQo6ttDNH3SjxJUto4sUY32vCN8Y+SMXqb3AibpdvX0ayh0qCWiAoeL/ZFnxQNhPHcXd7KYjq/nt05NUWs10qfUkqZYjbXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEtPcDU2ZmVzcWw0K0JUQkpxYUZVS25WV0Zpd21aVDlVZitZUGFYRy84WnFu?=
 =?utf-8?B?SVVWcUo2R2dINTFDOEgxZ3lnaGJ1NEdjVURIVVhPbFlneWVyRDRNdzZTMUhj?=
 =?utf-8?B?TFk5cmhJNGQ4RUg5UVgrRlpHTTRPb0V6alVaQlZFWnNERFlIY2l4dkxPUitp?=
 =?utf-8?B?cXFvNXBHZ2ZFMHNJNlIwaFQyelFHZUtuYkEyZzcwM2lhSHlEZm9hNW42Rklv?=
 =?utf-8?B?NXlsdkFJSjZkVkROKzJCV2llejRjYXYwQnh1S2g3NmdoMUUrNmd2czNEMW5w?=
 =?utf-8?B?dzc4ZGlud0NXMlJzVS81ZG0zbmp5YU1tRVpsZ0FveXpOSXd6Y3k5MFVLMEpa?=
 =?utf-8?B?V0FCUEFJSWlvZkN4ZVNXaFpUcW1MMzR2RUoxNTc0aFlnNjJhbUtWWGhNV01i?=
 =?utf-8?B?OU41RE55a1dleFBMckcvcmVMRk5Dbmo0c1pYVmpqcnFySkk5RmVMd0t6MXBU?=
 =?utf-8?B?djZnNnl0Z0FjbDhTRmxXTHV6eWNSbndUYXVxT3ZRSHJxU3l4WGpid013aFRM?=
 =?utf-8?B?TzRac3lnY0g2MVpzWlFDRG9HWFluNGg4NFVObDhITzF5SmZkLzg2VkNRWDk0?=
 =?utf-8?B?U1ZrTjZWUEphandWd0RyVWhUL0tFVytHYnAyYU5QUVdCbFBVeGpiWlJZQ1A4?=
 =?utf-8?B?OWVVN3BsR0lEaHU5NklmelB1anR0QkFPQW1pVWxEY3F6b1RoTVdPTVd5VnM4?=
 =?utf-8?B?NVh3VW0zWHAzKzhTRjdvNkxkMU11ekVwelRZVG5LN2NJb1hLM0lORVREaXNy?=
 =?utf-8?B?ejRycHBxMFhTRHc0NXFlaTIrN2E3NkVzOW5yQjRicEVINy9nYlk4NTV1TUVh?=
 =?utf-8?B?YmZuYWhlbEtSN2dldzI1MDZhOFZXVGpreU1zODV1K2hkWWtNNWYxVEpiT1cy?=
 =?utf-8?B?Tk1VZGx1NEkwNmhDdklYeXRUdHZWRlpRelBRaG13bnJTclpLb01QN1pvc3Jk?=
 =?utf-8?B?cE5LN2s2OFc1YS80dTNGVFhwVFg0NFlDY2U1RE9vWlJOYTJUcUFGdmNNNTM2?=
 =?utf-8?B?VHhYZFYvenlNZk5hbFlCb2diWTh1YkVxdllmRGRIVU1lajBaeVZ6SUUvUHdD?=
 =?utf-8?B?YnpDd2JTUGkzSTFNTzVybHRMWEJDSlppcjQ1MWxLVFdsODNiQ3JlVzNjNVJr?=
 =?utf-8?B?bVdHMHVrUkIyWHhqREdYczZrWjhVY1NYQXdzazdkanRac3IzSGZFeHFQUVVi?=
 =?utf-8?B?UDRPRmJZM2pBbWVUeWJxemc5c3hVbHpkelVvTDNiTy85bHRaRjJuakNBejBN?=
 =?utf-8?B?RHZRNEovVUFxQTR2ajBDcE1Yb2NxWUJiTmk0TUI5YmhxdE5KT1FWRUg3VTVW?=
 =?utf-8?B?Wmw4TnNScVlHT1RhNUhQMlZvNCtTdkNEQXRnWG9FdHRMbG5EZkNkMVVUOXFr?=
 =?utf-8?B?dzJkZVNqTkNtMWZ2WFNvMmRiYVJxVmZYSE13Qzk3cnFNcE90L0R4RjNwWWhM?=
 =?utf-8?B?SGhUOVFVcjZERFdNOG8wampac29IUFQwMWFEZkhFc2NxSnF5aUxJaUplc25B?=
 =?utf-8?B?YmdMcVZYUFo0eTFneXpSWEt4K25ZWFoxMjlKeG9TRDlIQXF3LzJOU21Bb1ds?=
 =?utf-8?B?NkdmQ09aQTBjL2pVZ01RSUpXcDhTVGlKVlNUbkZnM0h1cHBKRXJPOGV2QXdQ?=
 =?utf-8?B?eFhFNTFKQ0lPWGl4WndDK3BqSVRxRzhLa0dQcG9vNkRLMjNLajZJaFA0bmp3?=
 =?utf-8?B?YjFRNXJMa0VjY2d6bnpyQTk1TW5DZER0TTlWbkN2QmRhSlhqajNzalJRcklS?=
 =?utf-8?B?M2YxUWtrOEs4QzB5VVRFcWZUWEFPaS9aUS8zSjVKR1BTOFhWWlczQVh0U1Ez?=
 =?utf-8?B?TWwrTkVhSGRreUw0c2NLYkRjeDZ2TFQydjUzN2RrTXhNR3cvWXpqUHZFUUw2?=
 =?utf-8?B?cmg4eEZjQ1Z1THhkR2krZWUzYXZiU0tMdHhOQk9wMWpGaDlobjVTelpqL0Ix?=
 =?utf-8?B?dkV6NzlrUGIyaUNlQ0JtclRodk5qSTF5RE1jY01jOTZVVURNeHhhdzh4Rlhx?=
 =?utf-8?B?WjM0WkNDK3Z2WndNRWdQVmRnVWpmN29LVjNPL3hEZENQVktFSjZqVWpBZlVN?=
 =?utf-8?B?RVU0MnoxT2lnK2J2MEF5SmtFeDd5ZkZVMWNwVFVNTU8valRxaDYydjhXNjZ1?=
 =?utf-8?B?TnpNT05ZOE8vQmh3aytEcE1Ya3lBclVzWDEyc2FLZUFwNERYVVBFYUEza2Y4?=
 =?utf-8?B?UFVTNnZWZ2R2TXc2UWJZOFo3T3dnbkdwZ2FCMVpRSGVOek91Tmx0bXZKRmdt?=
 =?utf-8?B?cUc5YVExOVVvQ0JmUGdyb0E5NFBPQ2crUldocE56SkxyR3o4V3VjS3FIb1Nl?=
 =?utf-8?B?TUtHc1hlSWFrY1cxNEh1WERnVjlQNDlLT2dKOUI0ZGpqRWVETWprUT09?=
X-OriginatorOrg: diogocastro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469bad57-975d-496f-e746-08df06a70b02
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 14:57:42.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 68708ab7-2c25-4153-9869-a0a6b92bb578
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EanbbYaaWr3WW43FlxT51FM5xChK0yntQkGr/dGZ2KPLPcv9+CbgsBbzpIjre5rOZZkdiwM60VuBt7AZvt3LYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6477

I don't think so.

As far as I can tell, the "strip the common prefix" feature is a
performance optimization aimed at avoiding walking the working
directory needlessly.
So for `git add -- a/b/c a/b/d`, there's no need to look anywhere
other than in `a/b/`.

But extending the "strip the common prefix" to negative pathspecs
could end up negating the benefits we get from this perf optimization.
E.g. in `git add -- a/b/c a/b/d ':!*.md'`, there is no prefix common
to *all* pathspecs, so we'd revert to walking the entire working
directory, even though `a/b/` would still suffice.


On Sun, 30 Aug 2026 at 15:25, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Diogo Castro via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Diogo Castro <dc@diogocastro.com>
> >
> > `git ls-files` calls `common_prefix()` / `get_common_prefix_len()` which
> > calculate the length of the common prefix of all *positive* pathspecs,
> > `max_prefix_len`.
> > ...
> > Solution: in `do_match_pathspec()`, only strip the prefix when handling
> > positive pathspecs, not when handling negative pathspecs.
>
> Hmph, if the command line were
>
>         git ls-files -- a/b/c a/b/d !a/b/
>
> shouldn't we strip a/b/ from all three?  Would it make sense to
> leave the negative one relative to the full tree?  I am wondering
> if the solution is to compute common prefix across both positive and
> negative ones instead.
>
