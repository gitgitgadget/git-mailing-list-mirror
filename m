Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF4520988
	for <e@80x24.org>; Sat, 15 Oct 2016 17:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbcJORFP (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 13:05:15 -0400
Received: from mout.web.de ([212.227.17.11]:64207 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752934AbcJORFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 13:05:07 -0400
Received: from birne10.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M8iH2-1c7XBU3w1U-00CD3t; Sat, 15 Oct 2016 19:03:53
 +0200
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
 <cover.1476120229.git.johannes.schindelin@gmx.de>
 <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
Date:   Sat, 15 Oct 2016 19:03:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hcnJxSii6hiyYJEDszlkf2jSI6nZExKICcRt2QbFpKXf0r9DdPN
 zwxvpHYhZFhjOUgoVpwH8KRzfsKucs0gk15Xyyk9dCYrABqHrECZhiwtWODOwzJmHbLfhgc
 dfCvCb66WtWcZIMZjnLaDeNySz2u54z9IpHaYbqzzRcx15huRQMRLB/zRP6R/H24u2u7AMe
 n0dcjCsaVgV+tDW+71mcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DFOCYTr6wio=:/hAYxnuOylyBdgPYHDKceq
 6D36hM/+CpOPha0sUdO5mMRC8uoo8mDtEq2T1yJ4oSwALu9V7Odw4elThV84l+7DEN0AEUQil
 9VT2zc3DfBLxpLZ+Mg0bDs6ckpPY4pT9HMkvaeaHeBA/HN0U4+g7BoLQJkDXX+YFWpLloy1vK
 8zI87lmZN0eyj89W9XLXWlZiJquDhJSQVSzf5mtRhMupcvBBNBnsPKfxkRKtTiro2uA2yLyux
 NPk4KuLRSNXUd4TH98VnL8bGVAqCIwZWfaHXoYgyH5wh4aUOTa2YG+dSWuAm2MMgHonSptC8f
 V/sHSP6ORl+BOiUsu3r5IIMCmdwaIlC+nDN7b5VTGbQLFUF60UpyYoUaH11u58ssW96hPX1uX
 a7tb4eoIL77bagFnH4ItiShEoQabJmHSiwbrC5BXTPSk/8Zi3dsOi9uzY0W9cN8RrHG//4wTx
 nk6sMxQ3aYdG+thOIzncxCbjQIx1KVy06/sXhJgHY9Vg46Pir06z3ZYQQIM3G/CaDDKMvN1Fz
 WxCfWonO/VfGkNZJ0z5k5mRANvOYh7djXl0f6446BmduLGEYtestD845Gb35aZ4aislNRp5Rr
 kf7SFGwHht3eNu1Pih4RTxZ/9wFg+0abcVpikQrfSNonZdrmO4f0ZvU2Tqa2ua0k+D8SCeQrq
 qlYpGHvTzvHdZJrI6tbDSGTVDCNyRLDsECFfzWrlQc/i29gZGk1QenFn48eB30G80NXfxuZBt
 BtlK48KDAXptgzw4uxF0ML04FLexuEhkZLPosAUM6Aw5ZMLzkJXP6GTsQqmy5bunaMGLEJ73B
 KUdQDXF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Not sure is this has been reported before:


sequencer.c:633:14: warning: comparison of constant 2 with expression of type 'const enum todo_command' is always true [-Wtautological-constant-out-of-range-compare]
        if (command < ARRAY_SIZE(todo_command_strings))
            ~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.


53f8024e (Johannes Schindelin   2016-10-10 19:25:07 +0200  633)         if (command < ARRAY_SIZE(todo_command_strings))

