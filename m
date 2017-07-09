Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E37B202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 12:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdGIMUk (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 08:20:40 -0400
Received: from mout.web.de ([212.227.15.14]:59028 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbdGIMUj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 08:20:39 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lwq4m-1djnFe0LqC-016L61; Sun, 09
 Jul 2017 14:20:30 +0200
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in
 gitdiff_verify_name()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
 <d83d2395-e667-9e52-cc94-af5fbec6054c@ramsayjones.plus.com>
 <8bd7c4c6-c545-723b-ec4b-262abd8a7f5f@web.de>
 <xmqqo9sua7gz.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <147f287a-e66e-11b2-c76f-b7d54e076a6b@web.de>
Date:   Sun, 9 Jul 2017 14:20:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9sua7gz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ALPlBX6kzHcWZgUdiu4VdSOUHFV5dwUmCaCIrlnaYkMT74RDk9O
 mS66VIUT6f4WrvrS5TKdu5wefPk65Suc8Wzj9HFwaOZsrhVFQxvKDPXZkahtCCMRfBlOzQe
 dOuE5qXuI2YXfWMfc9qUOy3yMZ7eQWcKUVnhrmzXdpa/bZfs+ojyhY5Ea24xGucZHnH6CIs
 OlCbWC2++oou+zU5jRKBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G547dsNa06I=:21uOLTKTEXmW4g3qsAP5Yw
 yji6lf4UR3uYtXlgOUmEogp8fIE2oSuR5NjhkbrJZT81LNJ/w6Ijchodv+a7tYLNchWOQw79w
 yn/bGP4XgXN+RXRBpELlDR6IjemR0RcUUJJbkpAq6ksprjOCYTN/cudEy+Npi2bu9Fks+QuV8
 hY2P5QPmZHACwvQzEaUoCw/7hdLqrhcdKPAEbyENyEIqT7j9NEOc3Qsm5LQhKraM8ycg0ilbe
 lMpsii7BJaEUxA+lnIfkOVX+4KOlwL88fFVwEBepsQhinHve9GepygWHcferqxTymGt/enh/T
 fOouQLbOA8laUx5490NN3p7oLQJIvmdrQC+XvG9CiNGIioVwVaj9AfkQH6wW8oz+Oxh5Fck9+
 PE2IBLNX9AkQsqqRzZNJw3xgY1kfp7ZZYkpAefE0tNNbEweexCgnnYXcCq5XErD3F65zixZTO
 Nre22wjRz/PfZ4Y8SIqVbI4LsH2Ol7D/k6DrVC1ckEAqTN8+awUQlqXUO1iY6E8BRVyZDi89d
 34FgV0F51DJI5WJ5mBSYoKI2ENogca7owZC0L3bi2yRmhJvR6C/ODzSJqwX861gUO7GtkkAQg
 3uyItNR0yh7F4jGXZ/Le0qpjOnw/q+Q3l7n8kjZUzoOcHk0Z0jMykUSFjSY5izufDTt9zyit/
 pBpWD/PK34xx9AJjXLcwL8MZTVQwbnI+Q3Q0Df1zQkJ4EbyqNKZRcjHOxfFsEMD77cmcjpZnE
 t0Fnv3W4mQqMyBDtsXwRnCT5qoQ8l7RSOXakS5Bz1gbLgp4uclozPWHTzDiML03CJYBV327Fw
 tkHjcEU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.07.2017 um 00:29 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 08.07.2017 um 13:08 schrieb Ramsay Jones:
>>> On 08/07/17 09:58, René Scharfe wrote:
>>>> Avoid running over the end of another -- a C string whose length we
>>>> don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
>>>> with another C string.
>>>
>>> I had to read this twice, along with the patch text, before this
>>> made any sense. ;-) The missing information being that 'another'
>>> was the name of the string variable that we were potentially
>>> 'running over the end of'.
>>
>> Yeah, sorry, encasing that unusual variable name in quotes would
>> probably have helped.
> 
> What makes it even more confusing is that the variable with the
> problematic name is referred to as "it" in the last part of the
> description--- the second occurrence of 'another' is actually not
> referring to that variable but yet another string that is being
> compared with it ;-)

Perhaps like this instead?

We don't know the length of the C string "another".  It could be
shorter than "name", which we compare it to using memchr(3).  Call
strcmp(3) instead to avoid running over the end of the former, and
get rid of a strlen(3) call as a bonus.

René
