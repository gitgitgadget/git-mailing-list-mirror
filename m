Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8224B1F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 08:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJFPph (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 11:45:37 -0400
Received: from mout.web.de ([212.227.15.4]:34727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJFPph (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 11:45:37 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUBPu-1gHxbT0ADK-00R2v1; Sat, 06
 Oct 2018 10:43:01 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUBPu-1gHxbT0ADK-00R2v1; Sat, 06
 Oct 2018 10:43:01 +0200
Subject: Re: [PATCH v3] coccicheck: process every source file at once
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
 <20181005165901.GE11254@sigill.intra.peff.net>
 <20181005185050.GW23446@localhost>
 <20181005190045.GA17482@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8b51c4c0-df51-7639-07fe-74d6ca3b5944@web.de>
Date:   Sat, 6 Oct 2018 10:42:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181005190045.GA17482@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FJUsL7Svk4CppoPtf5nT9sZf0911rerAYadPnRSARySyIS+hqgk
 BrhxJtqnq5lvLLcmmCgnClWtJexRx4q9n8Po3bfsyJn63mz5h8k3GmZscxq6Y7p9jbNpGQD
 nfk0UNAM2NP8drSwgxkBQwHFXVHSs+D9dDbh+8PbEZZdQWEn/tJm2HRx352I++eid85Rk+H
 iWbBjPQRNC6wybXvP0exg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9C/ZA9USJ5w=:oOgxhH4M7FJjAav7Odz4q5
 +VrIHkr3YfmvVbtwxsZqAmw9RcEIL0Bi6QYsHHQTUkwQ+VF8bMaqCpeFQmEix+p12nXwWQjlH
 chkWjdOZpfkDDfEqxQL8fVGmDqQZj6j7iIfXrwq9+NQjvnlfII+/hzxhw00MvpqZaGl62ZxK5
 7zeLx7hEMf0HjkuflF+wDi6pEk4YhYV8b98RrLy/AflnznZ7uvwZPkjLiwH7rmrqnfTlwr92Y
 bLb5qZvzs8G/oMCnjFj12ki+sATPtHmqBQKfkR2C4dWwYBsCD6VcKryBY6Of+BpoiEh3Z7TVS
 CZuKcS8VZrujiQH472LsOpEgotBTJ2g1PeB1kn3tgRwR9n/rql3Loq1LJv6G0qpaMzKdO7O4e
 36x76QJhLA3ljEYesrgHFua3je4x9YSpHaTmBlQ7qrZQUYlcgzVZobNXiNKgJNMIyMMHZKshq
 tB45AZgWpR94IJ1NuUtKrvS6rcK+pa7w+K4yn3Ohb4w3xo576jX3hVh/9E/wZw5x1T4SuL37I
 vVP82M/DAwB5PPzb3/wLcmdUupovCFcHn2wmgJizfnyDazy4CbX9tM2zaTyOdyTyeHB/08d2M
 mfccTmEkne0v7g0ep8nEhzFlCX3L6A8KE++EAcarr38SJGN7Y6TfORs46Hwr9zqZqBPPIcEc2
 Si9y+lLh7i6SPrQI0sVK7fGAZI1MnM93rPBdrMFhu60Be/otsn1giaIdjENY3HdiDuATtmGuX
 Z1c01vYVMLWldkz4R79mSM4s7ZAkilp+degimpYwTPqENcG35OrCQmoVyN1UOZfwNPXJIY14t
 KPS4+eOM+ALCxIyhnQT7o0G13Ij2k2b7RPjCuuKDA6o+sDOWxY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2018 um 21:00 schrieb Jeff King:
> On Fri, Oct 05, 2018 at 08:50:50PM +0200, SZEDER Gábor wrote:
> 
>> On Fri, Oct 05, 2018 at 12:59:01PM -0400, Jeff King wrote:
>>> On Fri, Oct 05, 2018 at 04:53:35PM +0000, Keller, Jacob E wrote:
>>>
>>>>> Are we OK with saying 1.3-1.8GB is necessary to run coccicheck? That
>>>>> doesn't feel like an exorbitant request for a developer-only tool these
>>>>> days, but I have noticed some people on the list tend to have lousier
>>>>> machines than I do. ;)
>>>>>
>>>>> -Peff
>>>>
>>>> It's probably not worth trying to make this more complicated and scale
>>>> up how many files we do at once based on the amount of available
>>>> memory on the system...
>>>
>>> Yeah, that sounds too complicated. At most I'd give a Makefile knob to
>>> say "spatch in batches of $(N)". But I'd prefer to avoid even that
>>> complexity if we can.
>>
>> But perhaps one more if-else, e.g.:
>>
>>   if test -n "$(COCCICHECK_ALL_AT_ONCE)"; then \
>>       <all at once from Jacob>
>>   else
>>       <old for loop>
>>   fi
>>
>> would be an acceptable compromise?  Dunno.
> 
> That's OK, too, assuming people would actually want to use it. I'm also
> OK shipping this (with the "make -j" fix you suggested) and seeing if
> anybody actually complains. I assume there are only a handful of people
> running coccicheck in the first place.

FWIW, my development environment is a virtual machine with 1200MB RAM
and 900MB swap space.  coccicheck takes almost eight minutes
sequentially, and four and a half minutes with -j4.

Unsurprisingly, it fails after almost three minutes with the patch,
reporting that it ran out of memory.  With 2900MB it fails after almost
two minutes, with 3000MB it succeeds after a good two minutes.

time(1) says (for -j1):

433.30user 36.17system 7:49.84elapsed 99%CPU (0avgtext+0avgdata 108212maxresident)k
192inputs+1512outputs (0major+16409056minor)pagefaults 0swaps

129.74user 2.06system 2:13.27elapsed 98%CPU (0avgtext+0avgdata 1884568maxresident)k
236896inputs+1096outputs (795major+462129minor)pagefaults 0swaps

So with the patch it's more than three times faster, but needs more
than seventeen times more memory.  And I need a bigger VM. :-/

René
