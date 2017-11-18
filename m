Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BB8201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 20:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423350AbdKRUZq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 15:25:46 -0500
Received: from mout.web.de ([212.227.17.12]:49377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161613AbdKRUZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 15:25:44 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHkw-1fF9Vb0wTG-0181wd; Sat, 18
 Nov 2017 21:25:33 +0100
Subject: Re: [PATCH] config: avoid "write_in_full(fd, buf, len) != len"
 pattern
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20171115124043.17147-1-phillip.wood@talktalk.net>
 <20171117220633.6yoovfgpbr3rsykr@sigill.intra.peff.net>
 <f3038984-1cd8-e11f-61fd-10bf0cc33e2d@web.de>
 <20171118175246.puaepnyw3u4a33dy@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d93bd6b8-3f90-03da-97db-317524cace36@web.de>
Date:   Sat, 18 Nov 2017 21:25:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171118175246.puaepnyw3u4a33dy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5pcW6WrW+/xxEgSdwEj5+0wVg3T8OSE/G6xgkON9smt4PiEJchA
 V8FI9G451nR5yIOPsRtHI1Y0R9Wu+lL3ysFpQaW+XIps2CV9uNjIE5NlePO1LFUusFO/sK0
 iiRvMfB5l4ZISPjUKBxk5HVSKiduc0eZrqh+Nrh/1goqmCW8pefR1qCbSGVcnff36XXeVQv
 +4CPAglhbyRemZ1KecZ5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J0hSUqL+vHc=:vNLXJjQogriqtKXNZzQcPf
 PNwqQZSH9CFsBgvEmFSleJBY4R/qx1B0jxMe6xNyjwkP16m9FgR/QtSVdTaRlr0i37n2AWMQA
 YT+HXp2C5DGcigGwHAlKwy2WKepjCD3/gefQimwuEYVjfy76Lr2SHsrbZ9lzNuGyWb3u+TyYg
 gP8H+tXrTMXpLxzWyPtMAaMPwCH/OgQ+nIwzSvqjR9kUWDgvJz9u+3mS58QGRDw5gLsJbbMiy
 xQ5W86lGW7SJwi/C2Fv8DoKTyNpSIO/mTQkbkERvI8glWz2MLHFpPcwfl+iSasx6D3m6hfDQ6
 ItPWpEfWIAwbi+716ZmWE+Vw+vIfBxjfnk3CASEMicVlRkOx6ItX/ReOne+7vpsEjjilxFRuH
 TrtkBRUMoV+X7kR5PIztrKUj0Wx9v0IiY834t5gjYrYOI8DN2kw2Uz0L/gEU6P4SGKPpKU7p6
 x0uY8eRqD3lJJC73zJUTnzPTA0qX5SsYVJv8Q6aTxPKGfQVTV7B1tGdqhEwot0CMgNLCxdfZc
 wOfseq5v4APAqFWrXIzvzfYSjJH0a16mcy2NrZFja/B8A7eWPAxsJodl2BVPhhMy9U7XsEo3I
 vf8ebS458tQMbxcOFAOvi/aEFrrwAVOaHKJDggKQ7C0JN1iw3WNDrcMGk4opnigctFLRY9ZZp
 /H6AdJFEJUbv6lV7NsBG4xXgfqsVdk/lfJFFJpl8YmyRe4Eos93v1+u+supBwilcaRwHHZSfU
 6CKqkAUbzboQU1flUPhu+gib9Yi12dk9di9CA+eVha/UZbG+G413/nAJBrb3zx+p+Z6t3L/TH
 7xt2N67mZ3HJ0h84tWjwl7BFAK5+/oUYUJ97F1jYARnQAiqLbo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.11.2017 um 18:52 schrieb Jeff King:
> On Sat, Nov 18, 2017 at 11:20:04AM +0100, René Scharfe wrote:
>> Reported-by: Jeff King <peff@peff.net>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> 
> I'm not sure I deserve a reported-by if I say "it looks fine" but am
> totally wrong. ;)

Right, wrong -- mere details.  You pointed out that there was work
to do. :)

René
