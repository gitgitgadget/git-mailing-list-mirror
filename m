Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1771A5A8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="RWNchkbg"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2120.outbound.protection.outlook.com [40.107.116.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE96D6C
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9kFExiC+251gNstKbvzP6zVQJWE3u77SEfrB/7oKocKuUOLWkONNi2VnM8/2PFrgXPLRy4SFzNAaJXQueB3p8d0Tl2uq2/JUYLpVcHT+PRTZgD+7kS/5InR+2Bq6BVoycERBx+LsA08NuJ55G+H0oNLnalU043Ps0Q1gdvnMmdfHsN4FN39R/hhGLqPTlt1njrI2Yke7NLXc60GTpEJM0LSlgJQO3Sxmf+qxMqYgYlFoUs4wrPtu5sZFng0UGTmyADKQTlEAihxTY2Q2QK/UvZK3p90cbENcy7KPItxym4UkaT9sIlr1FuBG30MYlR75ZOYibuDP054WRBqmEofWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgC7CvvXF1QCnNxh9o/vKvgb87DteWrerQIzZhKTCvs=;
 b=HKyybUixrCrAHEoGFlQ9SnAXg2OLgb2Did9wLrbB99P0eF+9NNEPp4DEm2aeItQAZrPqaqqeFqI+LQ+95GecmYyCYVcVQPQjEGlM/XBUavDCfM+C/OTra5krwT3f9DvQ3h/JW9B7T1VKYq0XZ17mgD93KJ4Fo2/3ARg/wxDs08QkwZD7xgMVT1CLj+7U+jpQIaHM2GwZpA8D5ONudxPAJ6KoMSIf+S5WKIYXF88XSFnuGX1NJeiBb047nu+96pcj9S76jU8RhSEwuj8ord5iLO24lIjyotqViqkkKijqTZHW+eAKRv8ubINkF82Zr9dTb0kZfiTa/ePAiIxoKbjokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgC7CvvXF1QCnNxh9o/vKvgb87DteWrerQIzZhKTCvs=;
 b=RWNchkbg532IQyJ5O0Wctji3lqgyqrs4FF759vgf5tkW1vyluNLEndP/ihTRu5tkW5DUsV04Ncw5lXqCH058PNi6+hbgvEK4hF6wBAlzGhIAcRsWwS+R99HUoNleR5hanlAVzT0S3hY7pereoc0K7NwoJ7cCbpJ+zAvd623BggV3MCVMzZFwNcvweoIEZWqmgGzKfd+bBokQJhxFyRhZQvrRcC8LmxdqTj7DKCj2xE3SU2kWtGfTh3ig/nxE19/z9AuULxkTOM5NMT565V6xFefuILBksnWh5n66B8u5tyTCZo83QrOCH4MDM6cqRyGJW8tOPfPT52/HRSUDtXfhgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQBPR0101MB8446.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:40:03 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8c95:73b2:5c1:7dd8]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8c95:73b2:5c1:7dd8%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:40:03 +0000
Message-ID: <841c3b59-9e7c-4492-9d66-8af42c3222ea@xiplink.com>
Date: Fri, 20 Oct 2023 17:40:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>
References: <20231020092707.917514-1-oswald.buddenhagen@gmx.de>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20231020092707.917514-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::19) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YQBPR0101MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: e78bd2f4-0d5d-403d-76d4-08dbd1b51e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2LYl9EvSwBAfjErZ29FOuyFSN4XP8cdtlnLuhrpUwbtysZFLjFPbGwm6TIhPx3vEYmahOG4ltUUS4ZAkPOb+haGFwnPEn3/NolI+6ES298AMrva4KPYz9w9uOv0d6nBNwe74MPP4yGBMyviL3FjoE8ViuJWPfSpKeEsEissJcQM0zxdb0T2U0bCYX6g14z/ZupO4rIb24GafwEQizlTJ2O/dcy2QSn9hOAwEhhN/2x+cFV71+2Xfb6KSjey2Lwf0omKbc0BfD2bgRGviRWU24Q5JibZhLmfongsW8IzlyF3DuxBfAaSsN2OeRQkuSgrcgOrf8hiXfLHIWANPWzKkVc6rsUypcUJT0sb2qHZQHgJL+TXrdNLuEYhT5sUAGcCCBtpQMtTSvbQuZ14wtKc5dNbba2Hn2SoMh2Y7RXO98BKK5zTdUYKjMbBz1Rg49s9pzanrOmAK75m2TDeu01aY8gNufaB5nfZOMBjWT8TStkjYKV2qDLuVbMokjwBq3ZACpuBKBC9Bpi+DJeUskajax0hHfGqQiKXZISTwdSMsveWRK79Pw6dku/Aph1pFljZPSnntL1xAeIfSgjtJoAPmzozoCx0Ws5sLVg3QRv268X5WfPTY/jaq9iB0hwM0ujoOX84GaQzG91if2LsqD+vng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(4001150100001)(2906002)(6486002)(478600001)(5660300002)(4326008)(41300700001)(8676002)(8936002)(316002)(66476007)(66556008)(54906003)(66946007)(83380400001)(31686004)(36756003)(31696002)(86362001)(38100700002)(53546011)(26005)(2616005)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXNwWWpGTkIyRXhKRzRDR3FmbE5pRkt2UVRzUmtzZzBSRERiM2ZzZ1NsOVpP?=
 =?utf-8?B?N3d4OXRxd3JJa3FvUEJ5UEVpMzdvTnQ5REdJWldsZ0pVb1RtWWZNUllVZnhv?=
 =?utf-8?B?Z2RBeHVyVmxoUjdqWXVLd0tJL1BxUFNQOHRkY21OMS9DMzdyQmZjRGJ5d2FZ?=
 =?utf-8?B?TlhManFNWmpsSUZXZGs0SFd1WklkYVZRS055QTAyaCtoejl4dTdobjRMVGwv?=
 =?utf-8?B?cXVRTzlTTVV1Y2ZNbnRIMmNhL2tGbTdybUt1dnZFVlVTL1Q5OWp0NWZGVWRD?=
 =?utf-8?B?WG5oNUJvOGFIZlNCNXZPSGdhb25wbmQxOFVQWkd5MUJSR1ArSk1IRHlxOGs2?=
 =?utf-8?B?ZjJpVWxhTWdTQ1NWc0VrbVNvVHZxSjZ1bXA4MjBBeHpnUDNvUi82QW1CK0xE?=
 =?utf-8?B?NXptM3pvdFR0ajB0Y0E3ditLNjB5a1dYbUlHb3dieC9pWDc0V2lXN0VnTFg0?=
 =?utf-8?B?Z2pkdHR5dzdHVXZwakQvU3dHdDNrWXA5eXowc2hFUnFQL0lEb3dOVXV5ZWF2?=
 =?utf-8?B?dmV3amk0SU4wNDJ3SklHK0xuRzlOYm9IdGUwcjk3RzIzQlJvNHNWYzVyMG5I?=
 =?utf-8?B?VmtWcTNYYnhaWGRyNWloZ0Y2cVM1dTE0S3pOeFY2LzNPazJJYm9Fb3pnTVpa?=
 =?utf-8?B?SEF4M2FxUWhISElMQmRSdHM5SHRlZnRqS1lDcU1mUEkyTFZqUFVKVDl5SHA2?=
 =?utf-8?B?UVZBK3JId1pFWkJQVi9kTG8zeDh0ekhkQ3kzOXlMSG11SXlPNVBVcDBpYjRv?=
 =?utf-8?B?QXdQVXl6Szc4SlpwYytFcEs1eG9YYTN3MWhWZ3lZY1l3Sm5va01aZUdFTTBa?=
 =?utf-8?B?WTdrUE9uNlJuRjI5SlN1S1F2V2pOV0U3SWg3VmFvalRaNVYrV3RvQTYxbXhY?=
 =?utf-8?B?dUwzUXFzZk5JOWRFR3E3UXViOVNCZzRjTmdYN0dZTjJTZ3d2SFpxZHFOdFQr?=
 =?utf-8?B?RFo4bUZyNjQ2Z01paTI3MWJyWFRrdi9ReHhGK1A2TWdlNDBSOHFpZW50MUtN?=
 =?utf-8?B?L3lsbjdWckdFcmNibG5YUHlHT0d4SFlobDhwVEV6N09oZ1F4T05QSzN1R1Zo?=
 =?utf-8?B?a2JmTVl3OCtMemNHcHY4OHpUTUpkODBENy8yNWNGTTVNa3VQaWhJN0ViZG1s?=
 =?utf-8?B?WHkyNjJjMUJRWFNRZWlPTTF4MlpaTGNlZW01STBLQ3I0bW5HN09GUG1zekEr?=
 =?utf-8?B?RW85bUpPUEFBcmQraUlIb05BRDFYaWdWNmpMbU1lMHp1YnY1bURRQkpxUmph?=
 =?utf-8?B?c2h0eHJpY2c2ZXltZzBoVlowa0ZsU1VWaGRiOXdNTk5aVkhybkVBbjl5dXRM?=
 =?utf-8?B?YjJiRGM1Y1lRZjNWdzNlSml3cDRLT293ejNtWTlKNUVKdlhJQ2hCeDd4bVV4?=
 =?utf-8?B?Y2tUQ0FVa3llVm9OYWhET05jQmRqNGpYMElDK3RqWnhjVGlzNmJyc2ZjRjRh?=
 =?utf-8?B?Y1JnbzBFVnQvRitVb1BMWStpS2YrUmNYT0FSbGxIWm9DNHVxQUl0ekozWC9C?=
 =?utf-8?B?d1VSbXVvOTZrNlAzTGRtNlQ2Qk9GMUdlQ1Awd0paZ2wyWUpESTREc3pYOWtn?=
 =?utf-8?B?aGFkYmNrWHFNTFI5ei9MR25QR3FxeXNUOEx2MEpoYk1QQ1hlMGlSMitkQmg2?=
 =?utf-8?B?cDVwR1BROTBqMlFHb0VMdTFZa0JSQ0NTZnBmU0NTWVpvR2JMRlVkdk9ZT0ZM?=
 =?utf-8?B?WlhTTWhPTXBIeDZlWEVOVk1LNWh6a3hFZlRpSk5KMXA5Q3dsTmdFbHhhd2Ez?=
 =?utf-8?B?WjI4SGh3dmN6bDI5aWljTndTa3I5RVlVZGNwNnY1MU9SdUswUkxKMHRORExB?=
 =?utf-8?B?bm41dmJFa0tTMWFGbHBqdzhKQXJnazRiQlFPaC9mRlVSNGZXWmVOMEt5L1Ra?=
 =?utf-8?B?d3VqWWRlSEhwY0FXOVNsSFdjWFBpb3YxTXl3MzlNMGQ5MHlQYmNzSkdqK0I1?=
 =?utf-8?B?R3k1dVF2ZEw2aWs4WTNISlhrSFRycUROZXM2N3dOTjdUZEVtMVk0K3RoZzly?=
 =?utf-8?B?eVlwcUdKU3QzR3N6alB5T3kycFFWbHRTTW1KZVkwZ2tYekNrNFVKSGRpZ1hY?=
 =?utf-8?B?OFRsWUZrZGlzTUZGaVMyYkZBUUc5OUZkRjJtdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78bd2f4-0d5d-403d-76d4-08dbd1b51e51
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:40:03.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEgM6vjFnOxk/Lq1tZEod4amEmJba5KroK4vtojKdipIxHFxJWjLD67fzX9rf9plHTw2xdujX/0PpNuhky7w8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8446


On 2023-10-20 05:27, Oswald Buddenhagen wrote:
> Create a clear top-down structure which makes it hopefully unambiguous
> what happens when.
> 
> Also mention the timestamp along with the author - this is primarily
> meant to include the keywords somebody might be searching for, like I
> did a year ago.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

I think this is a definite improvement to the text.  Thanks for working 
on this!  I do have a few suggestions, below.

> ---
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> Cc: Christian Couder <christian.couder@gmail.com>
> Cc: Charvi Mendiratta <charvi077@gmail.com>
> Cc: Marc Branchaud <marcnarc@xiplink.com>
> ---
>   Documentation/git-rebase.txt | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7b39ad244..857e025361 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -890,20 +890,21 @@ command "pick" with the command "reword".
>   To drop a commit, replace the command "pick" with "drop", or just
>   delete the matching line.
>   
> -If you want to fold two or more commits into one, replace the command
> -"pick" for the second and subsequent commits with "squash" or "fixup".
> -If the commits had different authors, the folded commit will be
> -attributed to the author of the first commit.  The suggested commit
> -message for the folded commit is the concatenation of the first
> -commit's message with those identified by "squash" commands, omitting the
> -messages of commits identified by "fixup" commands, unless "fixup -c"
> -is used.  In that case the suggested commit message is only the message
> -of the "fixup -c" commit, and an editor is opened allowing you to edit
> -the message.  The contents (patch) of the "fixup -c" commit are still
> -incorporated into the folded commit. If there is more than one "fixup -c"
> -commit, the message from the final one is used.  You can also use
> -"fixup -C" to get the same behavior as "fixup -c" except without opening
> -an editor.
> +If you want to fold two or more commits into one (that is, to combine
> +their contents/patches), replace the command "pick" for the second and
> +subsequent commits with "squash" or "fixup".
> +The commit message for the folded commit is the concatenation of the
> +first commit's message with those identified by "squash" commands,

I think the original text's "those identified by" is a bit vague: Does 
"those" mean "messages" or "commits"?  The sentence reads like "those" 
stands for "messages", but then of course you don't identify *messages* 
with "squash" commands.

Maybe
	those from commits identified by
?

> +omitting the messages of commits identified by "fixup" commands, unless
> +"fixup -c" is used.  In the latter case, the message is obtained only
> +from the "fixup -c" commit

I think it's worth emphasizing that "fixup -c" also drops the message 
from the initial "pick" commit as well as all the "squash" commits (I 
presume that's the case, I haven't tried it [1]).

Maybe emphasize the word "only" in the sentence (i.e. spell it as 
'only').  To really drive the point home it could say something like
	obtained 'only' from the "fixup -c" commit, dropping the
	messages of all the other involved commits

> (having more than one "fixup -c" commit
> +makes no sense, and only the message from the last one is used).

"Makes no sense" seems a bit opinionated (although I agree with the 
sentiment).  Also, you can legitimately have more than one "fixup -c" in 
the overall instruction set, as long as there's at least one "pick" 
command in between, e.g.
	pick 1111beef
	fixup 2222f00d
	fixup -c 3333ab1e
	pick 4444d00d
	fixup 5555feed
	fixup -c 6666dead

How about
	(if more than one "fixup -c" command appears in a sequence
	of "fixup" and "squash" commands, only the message from
	the last "fixup -c" commit is used)

Thanks,

		M.

[1] Makes me wonder if rebase should also support "squash -c"...
