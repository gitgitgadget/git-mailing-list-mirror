Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149221F424
	for <e@80x24.org>; Thu, 10 May 2018 05:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756519AbeEJF7G (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 01:59:06 -0400
Received: from mout.web.de ([212.227.15.14]:45459 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756192AbeEJF7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 01:59:05 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2ZtN-1eQTDr1go9-00sKkq; Thu, 10
 May 2018 07:58:50 +0200
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
 <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
 <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
 <20180509235251.GC68889@syl.local>
 <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4640b041-f66c-3c1f-1329-baa4580df5cc@web.de>
Date:   Thu, 10 May 2018 07:58:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:za8KeXc6RdcBKe1GzHqrrDtUDec7SbZc3dj1JB60qYDV/JMqS04
 Q9suJWpUz3fY1g54zLdrGzvN2+QV79ejRdiyS1grMZhvElMzsIwDwCABqSEkFqEu4PQi3vm
 ijuj2OTSXblIR+NkLPrgq/ZbgsXenO4ZbH/y96ekyL85aYon6sdmBLbQI69ieIKa61xU4Oi
 l+h76e4S9+hfvmu5LPUoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DHpqO3GVgVI=:S6ohC11prxVkRYdo+C+iAx
 PpRrq9Qdbu3ykZfhOV6buZZjjvpMNBs+u/6vJROAlzXOaLYO8SBAAXmSTvklBMmQV8NBeM5Eq
 u+HjQrLmiM9OUhfCRFj3emVbrOBCpxjwlvKOx/9BWrpp/ZRsVNioXnzxi3SwBvbLg00KhvFZb
 pmi4q+1X35fPVlXTWVrs0GmAA/hHZwxqrx53CS0WgQQMR9lr1hIV3U6DDCMb8K9QSjEMpQ7pE
 n3x0SQ88lS7i3GkwFYJsnUSgkvopccondVl2CeD3CjC8730pX8kiznZ7QKckmQjVVYVZN9zGF
 gsqygREFBqxR7QJ1WU6IwQtklp5LFU6V2CF0ia1be1J6poo/K27HltC+1BPXLRP4KyroQBy3D
 +JcULCIucngV+vK6hjKRLjoZQ7Q2Fy73g0EXYso4NqeURaWVghb3KyQ/hj8Bts94J0YR6z59W
 Bce5d7nilkRaDSSSxqO2JU7rP1CKBHO7gmXlCDxpTHXssYmgN4/P6V4J51OH+QIlWwDFeFLvl
 JdhY9Q4tNfBYMhwprlslyttRl9oY6E2QXZtYrMZlekNHYAQ8QZfmT9h5R2B4fG414+ohMKutb
 vBsp2bnxsX0nu84cGueYaQ3RBKd+ZFEf5XilRMdnVS1xH7MjEZ6Py4atAinspta30lOQNoVfd
 fOL0B4MwfFF2n/XGZFion61XoDoweIuhh6ugI+7rcT1Ui0HetKke9sD4RUZ1axKAP4eI6Tdyx
 ox06ulC32Ru+EvdZMH3CVUW4kuOUUT3YPFcL0HD4wzzIrVSk6YPehZuBFiSxb8ns1jvxRdwzk
 xslXkZV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.05.2018 um 02:04 schrieb Junio C Hamano:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> This check we should retain and change the wording to mention '--and',
>> '--or', and '--not' specifically.
> 
> Why are these problematic in the first place?  If I said
> 
>      $ git grep -e first --and -e these
>      $ git grep -e first --and --not -e those
>      $ git grep -e first --or -e those
> 
> I'd expect that the first line of this paragraph will hit, and the
> first hit for these three are "these", "first" and "first",
> respectively.  Most importantly, in the last one, "--or" can be
> omitted and the whole thing stops being "extended", so rejecting
> extended as a whole does not make much sense.
> 
>      $ git grep -v second
>      $ git grep --not -e second
> 
> may hit all lines in this message (except for the obvious two
> lines), but we cannot say which column we found a hit.  I am
> wondering if it is too grave a sin to report "the whole line is what
> satisfied the criteria given" and say the match lies at column #1.
> 
> By doing so, obviously we can sidestep the whole "this mode is
> sometimes incompatible" and "I need to compute a lot to see if the
> given expression is compatible or not" issues.

FWIW, Silver Searcher 2.1.0 does just that:

	$ echo a | ag --column -v b
	1:a

ripgrep 0.8.1 as well:

	$ echo a | rg --column -v b
	1:1:a

Side note: This example also shows that --column implies --line-number
for ripgrep because column numbers are mostly useless without line
numbers (https://github.com/BurntSushi/ripgrep/issues/243).  I'm not
sure I'm buying that reasoning.

ack-grep 2.22 seems to have problems with that combination:

	$ echo a | ack --column -v b
	a

	$ echo a | ack -H --column -v b
	-
	Use of uninitialized value $line_parts[1] in join or string at /usr/bin/ack line 653, <STDIN> line 1.
	1::a

René
