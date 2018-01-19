Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEA51F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbeASRxt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:53:49 -0500
Received: from mout.web.de ([217.72.192.78]:58396 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbeASRxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:53:48 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLgE-1fBNe0061i-00ZtKD; Fri, 19
 Jan 2018 18:53:42 +0100
Subject: Re: [PATCH] describe: use strbuf_add_unique_abbrev() for adding short
 hashes
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180116171130.16568-1-szeder.dev@gmail.com>
 <7390fd9c-5969-61f1-86b8-6971eaf1432b@web.de>
 <CAM0VKj=eL5ZnnwKrxqtDYE+ijqJvcU-4bJNhjurvdn+Bpv7gUQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d81743e5-d5ba-a565-23f7-072007493499@web.de>
Date:   Fri, 19 Jan 2018 18:53:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAM0VKj=eL5ZnnwKrxqtDYE+ijqJvcU-4bJNhjurvdn+Bpv7gUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:QCtB5ydpm6syjzYoSNhGReXFtfOhyW1m0hNO+a7jTvR038XBoIm
 x3p41ekInfKmYLICyyJE2SBM3PoolClwtDzN4GhOcdqcRO3W9GHsmcnwlpV3qiT7ezajf2/
 uZZ4Dxa8e5lLFj2oC414Prs7nOVm0GrK/BlhhGTTr1BODgMv6gycMrwar4s9ZXfP2t37oKr
 c+EF6HZFlLWV6ysaaRI7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VDA2f7X4jy4=:Fvt/dBYwMczgODv9h/iMKI
 6vXwxVoOAFjzNgkLOdDwvx7lICw1t55mxG9U0p05+pW3Pxns5nIk9qKja4lICR0ut/WD//lKU
 keleaqhfb5AjkRaSGA4BOHTuEaHTdcIRGCZZOtrcWht+e7NOEMnjoGozAfGQ2OMjDXxKpJFgB
 tqJ265G4+a5sLULWGmgE6mOCkuU1FKxfc8S1rZUi5hQbfsDbTaUaYSXQ2/2z9fq0mhTJTErFu
 gbIx99C6ESGO5zpWyOGmE5/i6qvHNnbiz43d9YZCs1iHccJBJ6rxD8PvEX0NYg8nrLhG8LDGg
 4wHX77pDu0tbFb82zx3GdlDw/ZCoIh6oeBJSHyYqzA0GNE8UdZKg2jvFl9EaKUn2/1g+v0+7N
 HYLQVConKjXXiFnWqGdsqn/jKYgJOOzGVKNLTBoiFbrP5UFw0FxnUk1iePQ2rlupCI6X/Aj7D
 8g23I+FBatKtrR4HrD/f4kEv9cgVvoDM4DVpxEESeWLkiceNXjKF3pHvfgNRnQE3//Dn3d+yP
 ZyeSDsCtJylVFQW8cIwvVnTEIpGAxrJegS49OLtuAemx+hx3j1Rk8T3r6e7QeDE6GJ/fS6wkk
 08yF7Ams0DJs8etptSFdwkHapOXL3t5h++c0l7yP3do4mUV2BjIiZYXjI+QBa/leGpbug4tkO
 3MqYi1ldgzektczOh2MRGq3A53zrrqMl3piRnn10qFBdtbkHwr2WXtwshjZcDk+jrwJPmW9R1
 9r8QxBaZv7/YC0ViFa50NWCFLyeDa2Soi0tF6IlY9B+09RBGlGsuZb1PDdb2nZK4PIw6Wb5mI
 IPWjWaKCaqFgCpgQ7lA5TK4cKafnQfeSZvFqPnYOP2Dprxbs2Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.2018 um 23:40 schrieb SZEDER Gábor:
> On Thu, Jan 18, 2018 at 10:40 PM, René Scharfe <l.s.r@web.de> wrote:
>> Am 16.01.2018 um 18:11 schrieb SZEDER Gábor:
>>> Unfortunately, most of the changes coming from 'strbuf.cocci' don't
>>> make any sense, they appear to be the mis-application of the "use
>>> strbuf_addstr() instead of strbuf_addf() to add a single string" rule:
>>>
>>>     -             strbuf_addf(&sb_repo, "%d", counter);
>>>     +             strbuf_addstr(&sb_repo, counter);
>>>
>>> It seems that those rules need some refinement, but I have no idea
>>> about Coccinelle and this is not the time for me to dig deeper.
>>>
>>> What makes all this weird is that running 'make coccicheck' on my own
>>> machine doesn't produce any of these additional proposed changes, just
>>> like at René's.  Can it be related to differing Coccinelle versions?
>>> Travis CI installs 1.0.0~rc19.deb-3; I have 1.0.4.deb-2.
>>
>> The version difference may explain it, but I couldn't find a matching
>> bugfix in http://coccinelle.lip6.fr/distrib/changes.html when I just
>> skimmed it.  I wonder if the following patch could make a difference:
> 
> Yes, it does, now all those nonsense suggestions are gone on Travis CI.

I would have expected matching a literal "%s" to be easier than
dissecting that (admittedly simple) format string, but if it all works
out fine then I'm not complaining. :)  Sent the patch again properly.

>    https://travis-ci.org/szeder/git/jobs/330572425#L713
> 
> Those "memmove() -> MOVE_ARRAY" suggestions are still there, of course.

They look valid and nice to have in that report.  I wonder why we don't
get them locally, though.  Are you going to submit them as a patch?

(NB: The patches generated by coccicheck apply with "patch -p0", unlike
 those generated by git diff and friends.)

Thanks,
René
