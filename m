Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C3920C25
	for <e@80x24.org>; Sun, 15 Jan 2017 16:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdAOQ5y (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 11:57:54 -0500
Received: from mout.web.de ([212.227.17.11]:57224 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbdAOQ5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 11:57:53 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUS9-1c9tpT2he1-00LGL3; Sun, 15
 Jan 2017 17:57:42 +0100
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty
 lines in context
To:     Junio C Hamano <gitster@pobox.com>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
 <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
 <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
 <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
 <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
 <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
 <48bdfd94-2fd4-bd55-d78b-2877e195fb82@web.de>
 <xmqqy3ydcaia.fsf@gitster.mtv.corp.google.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57bba5fa-015d-5629-73c2-5052ffb39d2a@web.de>
Date:   Sun, 15 Jan 2017 17:57:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3ydcaia.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:FDsGTw+lcmvoEAJ+5O/4QjeMqUc7s/5sNfgnw8Ly8YKhbYSS8qk
 XVcutKFvCNkmg1zAHla4EdGax1UUcK+IluoPbRddhDyBc43mC+TK65jRyVrZlgYfc/uxCxS
 ovU2IaO0mq0JWF61E/ea21zs0ibB0+4l7hfcghpc2SpMKoPuCwFgJw05o6DeKUvH/OolE8H
 J/vFqYez8QVpYb5d4ZU7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tKg+70cgAHk=:E/V3PLmXBb/LaEGnIsR6fl
 gASYcQnRHttTa13pPO/trBA94YqT81uP8CRRcwyeeb9s1P9csLsTTeXfTCuUpx509dowfpN7J
 gGzWX47S1iksmxudbX20hJbk/qtZAAiQXBholibq4M6/ZiblpQTMQLdj6OOpbJlDHRBUYkM2I
 0PAMsXn1y5bLWTZQ9rwyaCJYQd1r/eakS1qR2iLyC82gQ+UX1ZbEf+8MsCmKdtaeT2qZlwE8g
 yosXuZvC64hS61+lWRt/KrIZUckZY7HtfAgb0K+eVfRNYTirBtyj8Vzga7wgnspSRtc+bPtGE
 HxOkQBIvNT0u9jCvxWIKKn0PFo3DW2RZfOoWWYHWwOn2QBo2OVcNOCkD+3FM/VMO6HF0VhJ9G
 9SV8wmd9jWnwpH1dOPEbD9NLg8KgjWi3vneMf+rzxn1vWYTLrfeaUfBcoAZjbLYzv6bqVIf3G
 SNWUW1S2ZN/4g9V1VeNgTDiKMgmG9YlCBTSvGIV6Ub/ybs/4isao/SLz2oLiMzCyurZdyobYk
 DQih/+A3pdOTxZDycIPi58jx10jwbPaI+s2lXa0V9oKaRz5dXdSKvk2MJSz8n70ws/WQss7am
 h/SgWMwRp0yPKk0GYbzzaa6/XesEUUN+3abr3G6Ve8fr7Ax7UodgCHm1SllKArh+IOjDAUxW6
 liB8fOm2/TXChWtUFDNJq97EisDAw2CuIzEAmDNId89MkizZ0VTkAf1XFHazipLNSqUJHXzn2
 pnLPdr5EXk3TsCnL01DrG884jGDnKIA29MVNn7yyW1gu3GeJuh7ItkUzCBdG+Mk3gIEZuq7pY
 c4RSYxL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.01.2017 um 03:39 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>>> I am also more focused on keeping the codebase maintainable in good
>>> health by making sure that we made an effort to find a solution that
>>> is general-enough before solving a single specific problem you have
>>> today.  We may end up deciding that a blank-line heuristics gives us
>>> good enough tradeoff, but I do not want us to make a decision before
>>> thinking.
>>
>> How about extending the context upward only up to and excluding a line
>> that is either empty *or* a function line?  That would limit the extra
>> context to a single function in the worst case.
>>
>> Reducing context at the bottom with the aim to remove comments for the
>> next section is more tricky as it could remove part of the function
>> that we'd like to show if we get the boundary wrong.  How bad would it
>> be to keep the southern border unchanged?
> 
> I personally do not think there is any robust heuristic other than
> Vegard's "a blank line may be a signal enough that lines before that
> are not part of the beginning of the function", and I think your
> "hence we look for a blank line but if there is a line that matches
> the function header, stop there as we know we came too far back"
> will be a good-enough safety measure.
> 
> I also agree with you that we probably do not want to futz with the
> southern border.

A replacement patch for 2/3 with these changes would look like this:

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 8c88dbde38..9ed54cd318 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -174,11 +174,11 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
 
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
+			char dummy[1];
 			long fs1, i1 = xch->i1;
 
 			/* Appended chunk? */
 			if (i1 >= xe->xdf1.nrec) {
-				char dummy[1];
 				long i2 = xch->i2;
 
 				/*
@@ -200,6 +200,10 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			}
 
 			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
+			while (fs1 > 0 && !is_empty_rec(&xe->xdf1, fs1 - 1) &&
+			       match_func_rec(&xe->xdf1, xecfg, fs1 - 1,
+					      dummy, sizeof(dummy)) < 0)
+				fs1--;
 			if (fs1 < 0)
 				fs1 = 0;
 			if (fs1 < s1) {

