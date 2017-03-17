Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC82820951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdCQXar (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:30:47 -0400
Received: from mout.web.de ([212.227.15.3]:55380 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdCQXaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:30:46 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hcE-1bvWeO2QpS-00umcI; Sat, 18
 Mar 2017 00:21:34 +0100
Subject: Re: [PATCH] receive-pack: simplify run_update_post_hook()
To:     Jeff King <peff@peff.net>
References: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
 <20170317222320.nsg3yk3nopjadr5t@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f61a1089-833b-2883-deab-f97cb77cef96@web.de>
Date:   Sat, 18 Mar 2017 00:21:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170317222320.nsg3yk3nopjadr5t@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Sjnq2qfjG40tugRctyat568t5glMK3sB9UPrF73Yjz6JgEAQ8jc
 hy8IyrCdvuPVlIlGHZNHmQZJrImi6bWG41zuxkxyrLTWFrqGBlYbMS6wPdGy6lcCgQntLRe
 jGREd3bF8Ch2dnA4cmy84TqN2FftRczHyrinJ7Sk3C3bwlwYwZ12DL7/js+Mc+96XO3rrC7
 PtkHs93z07pw61Pv7Icqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LceKNmwN46k=:I+xcC7FNQztqmQ2PMepDBB
 tWN1VDGJ1B7CZ3h70xcyO+oJxaVLasqZ9cubM14xdaJ5ocP39gO8qshd/E4gXuGxWPRRM4P5p
 I9RSWyznBiucceIUHOZu2yS3MRCQg7dzCRN06vQqz/n7Rmun5LY/UFar7ROCtpuK9mg5PmtZl
 Jo9881DBzxyWbjZWmA62tI3CshWZYOqmeH2pbvGo0RjZO4I7AUMsCjIjn0E1xuDIru/23KTSp
 OoQSO0mwejTBvac2uPhdVwIrbw/Rr9ajTqJ51OcTCtFjYqBfuyjJMSNZFtRSgsQCYgQABV0l4
 eDJ60gZ/sTIIhltcuSfJHSyYuIaW4R6/H6uyIyqQrpw82WtQXF6WfIoCgJEUjwZ3aM5xNf7fY
 NEbiSbp984ZP64Tgsw+AIthovWqQ2dm0DPNYA1N2Pc8D5JW0KdjMt6weRcgnTef+Mk+AgsDLI
 gXs+l7ZKh1m3SgfkZBls+mRT6KiWl8cQZAMpY84w++l6g433/4YDyOxqL1JLHTX1Lg7xCEosR
 9fYWA5+0Qmy9DePkKvHzA2Qtsl/FIbfKTy/lCIobbBQebJXcAKP7+YPv2dMEM59+Nmkuili2l
 VIpIUZr1ML5kXgfw0H22dEfCl9G8q1XkJDLw+lXX0uAYl+5QGPxd6pzDlsf/I8H0AdsGuUoOK
 Nnj7dgR2kWtUNWMGcubUIflgyS9sL6hgAvyi592KYlNBmD9KG7imjVFpHd0pVHL9mnXlePyL7
 TSXWm2cFzMHN0dUk/QW+g3Nrq49FCSU3zIUjCvlQn+UxtUU8ThkTACYstgpfp3IP3FJSQgklG
 0vtwdQ3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.03.2017 um 23:23 schrieb Jeff King:
> On Fri, Mar 17, 2017 at 11:02:13PM +0100, René Scharfe wrote:
>
>> Instead of counting the arguments to see if there are any and then
>> building the full command use a single loop and add the hook command
>> just before the first argument.  This reduces duplication and overall
>> code size.
>
> Yeah, I agree one loop is nicer.
>
>> -	argv_array_push(&proc.args, hook);
>>  	for (cmd = commands; cmd; cmd = cmd->next) {
>>  		if (cmd->error_string || cmd->did_not_exist)
>>  			continue;
>> +		if (!proc.args.argc)
>> +			argv_array_push(&proc.args, hook);
>>  		argv_array_push(&proc.args, cmd->ref_name);
>>  	}
>> +	if (!proc.args.argc)
>> +		return;
>
> It looks at first like the result leaks, because you have to realize
> that the push will modify proc.args.argc. I wonder if:
>
>   argv_array_push(&proc.args, hook);
>   for (cmd = commands; cmd; cmd = cmd->next) {
> 	if (!cmd->error_string && !cmd->did_not_exist)
> 		argv_array_push(&proc.args, cmd->ref_name);
>   }
>
>   if (proc.args.argc == 1) {
> 	argv_array_clear(&proc.args);
> 	return;
>   }
>
> would be more obvious (at the cost of a pointless malloc in the corner
> case. I can live with it either way.

Sure, that's even simpler.  I don't know how often the no-args branch 
would be taken and if the extra allocation would even matter -- that's 
why I tried to avoid it -- but probably the answers are not often and 
not much.  The only test case that hits it is for the deletion of a 
non-existent ref.

René
