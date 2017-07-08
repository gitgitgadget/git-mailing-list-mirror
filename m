Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589B42035A
	for <e@80x24.org>; Sat,  8 Jul 2017 11:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdGHLwX (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 07:52:23 -0400
Received: from mout.web.de ([212.227.15.3]:64328 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbdGHLwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 07:52:23 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LcPhu-1dvkV71AMo-00jtQT; Sat, 08
 Jul 2017 13:52:15 +0200
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in
 gitdiff_verify_name()
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
 <d83d2395-e667-9e52-cc94-af5fbec6054c@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8bd7c4c6-c545-723b-ec4b-262abd8a7f5f@web.de>
Date:   Sat, 8 Jul 2017 13:52:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d83d2395-e667-9e52-cc94-af5fbec6054c@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rCXW4EMefrc2xlXhccbxDq0BbyJNfEiZ81kftb10mizQveiyvzG
 C8v0FckY2fi4oJ0byUSpdv0LZlgxtR+4+JaSQoJyUFoXwM1HWkhvfi3qO9Mo8BEOPtYbv/R
 GTp6fNB9LZGtfeJwzxE+bAel6IRyua+awa7ac+vGdaSQH3kvubfwUPuSM7dA8qIjw4RE+Yi
 LoD6PT6sBMkUK9PiktXRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mbRVdYOkibs=:+sC4tubTiz7KXVuqZ1hXnh
 9hx5wRlt1l+u3H6Ak+mXR71+pogGjqXVSiumPD2KlVQ98sffgckGBhYeMoWB97YWYWSOGvU+i
 v5wpv6cONRfiP+1kkM51NOIrJM16Xc+018JuBWX32RlgHr1P4/9eWxDVQ3GYIXR2T3oxOaE5l
 7zsk5WDSTPEQyGAKU1rct0Z/ACAzmf7RJIZ/70lypVGi0FH1PQ0eowQKMQPz8iSMLGQn7+Gq3
 Saqj75bG0fldt4BC6qGatgY3UR5DNavsUcUO7YQaTCKpEjQhG1aVBV2Go/TVyA0yT8lcVY+LE
 hgjX/EWGUBSA5dr+bQHdK+Au7qfLZKHRlBbeK4nfl5xvYLdssBh/uEIvNyYl0RtvuPRU5UqR/
 geHnUjNUoxW+Xh3S+eRY8NqY9aYyIqhXO0p6eFTrGE86cBLbci7PSC+NSYS+wvTyCkc7QXz6D
 8DbDCu/9rGQx5wQpoL1h0uYsiflZKW+Qx7NSQqYCW7oh51lQ29I8f/uAcZDxQoqi1FK6H0UA5
 Q0glhxcPOwrSJGRCKsXJ1gHRtlZPYKPHO3/ZbgLuLNzCN6shBkBUNScAGQhIVQw6aSfCKqg8Y
 jbssm4WFSIdpEXAF6kuwyWyMC30ACLnGiUvP8sYgXcmJtHJKqVJw/HQRD3CjBqhHGwfgA0nCK
 OhSgU8akWtC5AzNByHirF477yYujlNVrbsQWfAt0aBQKwkVvWh+rSAr26MRXd7f9pzf5mj2Jr
 VQlCrimU3duVg7eDjiQSNEwFv+Vc2g0HfzD7DlPCQmZfP4ApuXTpZQgOdXM+cqRGg4QpbuN7a
 NzU1gPx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.2017 um 13:08 schrieb Ramsay Jones:
> On 08/07/17 09:58, René Scharfe wrote:
>> Avoid running over the end of another -- a C string whose length we
>> don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
>> with another C string.
> 
> I had to read this twice, along with the patch text, before this
> made any sense. ;-) The missing information being that 'another'
> was the name of the string variable that we were potentially
> 'running over the end of'.

Yeah, sorry, encasing that unusual variable name in quotes would
probably have helped.

René
