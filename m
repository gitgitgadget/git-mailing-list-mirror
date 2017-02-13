Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9429D1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 18:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbdBMS1S (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 13:27:18 -0500
Received: from mout.web.de ([212.227.17.12]:65513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbdBMS1R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 13:27:17 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcPWs-1bwpJL0ive-00jsJM; Mon, 13
 Feb 2017 19:27:09 +0100
Subject: Re: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc
 shell function in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
 <128b4de6-7b8e-27b9-414d-c6c6529cb491@web.de>
 <alpine.DEB.2.20.1702131722350.3496@virtualbox>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <74dfcffe-274c-7045-420a-95612394d66b@web.de>
Date:   Mon, 13 Feb 2017 19:27:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702131722350.3496@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:u6Eb41RL4k0FN+hED29pFs7jd2lIrWkw7v6MXFiorvDbCHGAaf3
 sfBAQx4ITaYt+BruHMGc9iUbcITF4+kzW6DbO57O/7w7zWgcP1kx3fKOVfbIWpDQprxi9nu
 ee5o6mx8cJGsicXTbIG4XLh52VmhNirqpbM3H9xvlRoqVfGhJyLO8WsWDzLlOgFASyQfMx/
 pCuBVLJQ0dSBXa02BfGOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wdOJMnmUl8k=:vEsDD3sid+7Le9kTLtE1ki
 oaAIaovMduzR14ldKBMVnF5iFR7myZdmWeZVD8siuw5hCjHzevLrbHkyhRl7CoqM6+3YS9RIf
 WtToA3osEnNrbIfkXMK4VedMIQkhuzhJzjfl8Rr++1ySCO6wI0dDIWp81X566pCAbBiD634l1
 bAbb65eGNzGRoXPD7P/Y8KqvdHasRaPEEVnSBUlWW7W71VStfuTrROSg6VIJBTIioUv2o5fp/
 DmKq4pFh38U/lMK7cvLtBxvgPQVV0VfQG+argmq+WzCmPE92G3PgVOhKvZa9PmM7VoGGMXH/j
 XAVkv1jnGQC2Gw3mlYjElB2n9RAcqo3UZZ0uCZ1ITznAfbGhqbGJupQI+QJGhtd9ktKtHA1+n
 1rOSD53gNBRpZjuBAe/0yWGXsCtXOtdxUDmfLG7IAvQmJKTkipdKMVbQsqa1Lk1SMxAkSPwMj
 W/obv71o1FcSt0k4nOgevQyWXox0H9KkY28UdmzM3A9Lxpox0HyVcZvH6wX693w38en+bxWEN
 6UuPUQzHNGoRHgjGzSW1IGzwytVIp/bFLowqRok0EpayZnU64X9MUIXVBPmOkU1JlK4dzV+AW
 7JmjWN9+IC4s1x9wA82VQcvR8PYx9iinrrSCyTVOJYdF5y//ayNDTV4ZjaZlGKoZ84otuybr5
 riOIoxxeopBLv19PeLxc6ZeVbu6s9Bxdf77YCjb+AwkLY0w5laFs1cQvVnIj6cis+o+Cmatzl
 9eqTZ7qEU7l8P8D10GnU5NcP96P4rvLTTD7KYST8QoTnoiTn9zDxlnG1gQkRaG7muijxQ32Zw
 +VdO7Mm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.02.2017 um 17:23 schrieb Johannes Schindelin:
> Hi René,
> 
> On Fri, 10 Feb 2017, René Scharfe wrote:
> 
>> Am 10.02.2017 um 15:20 schrieb Johannes Schindelin:
>>> It is curious that only MacOSX builds trigger an error about this, both
>>> GCC and Clang, but not Linux GCC nor Clang (see
>>> https://travis-ci.org/git/git/jobs/200182819#L1152 for details):
>>>
>>> builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used
>>>   uninitialized whenever 'if' condition is true
>>>   [-Werror,-Wsometimes-uninitialized]
>>>         if (missing_good && !missing_bad && current_term &&
>>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> builtin/bisect--helper.c:350:7: note: uninitialized use occurs here
>>>         if (!good_syn)
>>>              ^~~~~~~~
>>
>> The only way that good_syn could be used in the if block is by going to the
>> label finish, which does the following before returning:
>>
>> 	if (!bad_ref)
>> 		free(bad_ref);
>> 	if (!good_glob)
>> 		free(good_glob);
>> 	if (!bad_syn)
>> 		free(bad_syn);
>> 	if (!good_syn)
>> 		free(good_syn);
>>
>> On Linux that code is elided completely -- freeing NULL is a no-op.  I guess
>> free(3) has different attributes on OS X and compilers don't dare to optimize
>> it away there.
>>
>> So instead of calling free(3) only in the case when we did not allocate memory
>> (which makes no sense and leaks) we should either call it in the opposite
>> case, or (preferred) unconditionally, as it can handle the NULL case itself.
>> Once that's fixed initialization will be required even on Linux.
> 
> Exactly, free(NULL) is a no-op. The problem before this fixup was that
> good_syn was not initialized to NULL.

Strictly speaking: no.  The value doesn't matter -- the free(3) calls
above will be done with NULL regardless, due to the conditionals.
Setting bad_syn and good_syn to an invalid pointer would have calmed
the compiler just as well, and would have had no ill side effect (i.e.
no invalid free(3) call).

Initializing to NULL is still the correct thing to do, of course --
together with removing the conditionals (or at least the negations).

But back to the topic of why the compilers on OS X didn't optimize out
the free(3) calls with their conditionals.  AFAICS no attributes are
set for the function in stdlib.h of in glibc[1] or Darwin[2].  And I
can't see any relevant option in config.mak.uname (e.g. -no-builtin).
It's not terribly important, but does anyone know what prevents the
elision of "if (!p) free(p);" on OS X?

René


[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/stdlib.h;h=292c6a2f053a2a578cd09d75307c26ed191e1c00;hb=b987917e6aa7ffe2fd74f0b6a989438e6edd0727
[2] https://opensource.apple.com/source/Libc/Libc-1158.30.7/include/stdlib.h.auto.html
