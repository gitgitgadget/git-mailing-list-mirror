Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0CBA20986
	for <e@80x24.org>; Tue, 27 Sep 2016 22:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbcI0WWE (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 18:22:04 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:46623 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbcI0WWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 18:22:02 -0400
Received: from PhilipOakley ([92.22.61.72])
        by smtp.talktalk.net with SMTP
        id p0lDbuw5UxR4bp0lDb3v7T; Tue, 27 Sep 2016 23:22:00 +0100
X-Originating-IP: [92.22.61.72]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=7aZpnnQXZO14GhbF6d5nLQ==:117
 a=7aZpnnQXZO14GhbF6d5nLQ==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=pIiNZIo2QrxxUPUvUv0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <5006033DE52444EAB624BEA7E5A16746@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Pranit Bauva" <pranit.bauva@gmail.com>, <git@vger.kernel.org>
References: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>        <010201576d63f422-abe45938-0da1-4fc0-b0e7-3e552b59d10a-000000@eu-west-1.amazonses.com>        <A9427F4400044104B47378E024C7C2A4@PhilipOakley> <xmqqoa39kn57.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v2] rev-list-options: clarify the usage of --reverse
Date:   Tue, 27 Sep 2016 23:21:21 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAZWNS0KHq8J/8bLv6Q6K6KTZCXqAHYMCqEHf2KvWKxBOuyYD9g4RxmDKE+JKXvkvyGEN4i80AnvmfJsAt7Ea6aoIEu6339w0NrhNLclbHMRpLvG5DiZ
 lDuh9IlhygnOwVfHthfk3X56YuxeS5+DnQYA6QP/uM7aQRTHOQaDGXPB7oe0QD7nodHShNGPyX+QUN8vr3Q9bHKalmcTewJlZ3yLnKU204GIMo6zkg+U0GJk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> micro-nit: 'first' and 'last' can be tricky to distinguish for lists...
>
> Let's do this then.

Looks good to me. Thanks. -- Philip

>
> -- >8 --
> From: Pranit Bauva <pranit.bauva@gmail.com>
> Date: Tue, 27 Sep 2016 20:44:09 +0000
> Subject: [PATCH] rev-list-options: clarify the usage of --reverse
>
> Users often wonder if the oldest or the newest n commits are shown
> by `log -n --reverse`.  Clarify that --reverse kicks in only after
> deciding which commits are to be shown to unconfuse them.
>
> Reported-by: Ruediger Meier <sweet_f_a@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/rev-list-options.txt | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt 
> b/Documentation/rev-list-options.txt
> index 4f009d4..f8946d4 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -638,8 +638,9 @@ avoid showing the commits from two parallel 
> development track mixed
> together.
>
> --reverse::
> - Output the commits in reverse order.
> - Cannot be combined with `--walk-reflogs`.
> + Output the commits chosen to be shown (see Commit Limiting
> + section above) in reverse order. Cannot be combined with
> + `--walk-reflogs`.
>
> Object Traversal
> ~~~~~~~~~~~~~~~~
> -- 
> 2.10.0-561-g98a6b79
>
> 

