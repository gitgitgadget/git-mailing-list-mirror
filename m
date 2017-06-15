Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9408A1FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 11:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbdFOLdy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 07:33:54 -0400
Received: from mout.web.de ([212.227.15.3]:60356 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752490AbdFOLdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 07:33:50 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lo0YS-1e1OQ52Q9I-00g2Eh; Thu, 15
 Jun 2017 13:33:37 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
 <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
Date:   Thu, 15 Jun 2017 13:33:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:0BzM2BoQ7mtD61mPjLqZBDRkq1ak9bDpfx2JchV8kgTJqgGs0uK
 UrbuX1TH2fhYJkCJdAE9Ff+m0wdi3VKvNavqiotndfNHeIwYhCYP3DFIs6jaFHfiUjbkXH9
 RmMpslLt1So9E8WdZhuGSO/K77IrJVBH+tKCau6kEJGpbUz5nCaIU2MZwQtNIfnHc2Er0yU
 mCJbZRtfvskbonYUa+hqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MWpymKzigw8=:xP8hsvhCcEKZgLar7Rk27y
 4oMEi/fyvEccCJ1OntQF0YnwoEDw7seJ+W+v5tfG10kq1obUFD853NXROnVj2AAuuiLIz3xcl
 sgaTB+yvNsnyDGFdBNuyM07ZIL7ieyU/Eh8Uil1sDA7eAXh/gsmtTmaJxzmXNdYOOn+dL7wZK
 jyRl5klEgwYF0p0V2sl7/lS5ueMdbQsVLkJ9d9nzafckxhO5/tIEMGqnXJE8PZublyJvLECMh
 W7Q+hS8FflK8VZyudUzTv6NYN/lUZXbgIu6YRlM45PMH5pxZKm01APUk0XsSpYjpYlpfVRn5r
 +sJrKf2b8gPcDrlVdfwwnZQLNyG4ejSpjEuj4yDxuoji5/cE7uIP9PmnLwJcsQ4ThoRXr9rH8
 OdbuggsfnbktgI6+Awr4fcOvGvEb/QGg6GJQy/VleS+8n9V6eX+UjjnJJREDsyjhKWjeSG2sr
 HgzHeVJQYzRFT9OoaRy5/LmhhLXjt932TAUEj4rs0ty4Zt5tv9Stn8NNIvkrFymZKotFKv6r6
 g4fWbm5gi4RZcYIJLrsMpZJ8KycXwIQ6odV+581kqng4rCWF4R60emn6jlQCMteMqfO4ls6y6
 IGlBJIHTjLptvLeC0F3MycYYHdhvHl01gry2WnjBQGquzyTng6nep+tJ4EgvuC+FlEnhvsngo
 5dZ9Zqh/8TQl/jKg0HrmkzvThNg2NK9BvbwHeA7ZVdLeOC+kGQC7/uuVFHqgd9LJEBblRMAiO
 1cEtqH0Ou1gOFj4VxhekcQI2Kx4gfm40sjJQl7p3LAQV08KOs3NHdm9/rdlZBnp+9yaoePgsS
 8t/2BV8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 07:56 schrieb Jeff King:
> One interesting thing is that the cost of finding short hashes very much
> depends on your loose object setup. I timed:
> 
>    git log --format=%H >/dev/null
> 
> versus
> 
>    git log --format=%h >/dev/null
> 
> on git.git. It went from about 400ms to about 800ms. But then I noticed
> I had a lot of loose object directories, and ran "git gc --prune=now".
> Afterwards, my timings were more like 380ms and 460ms.
> 
> The difference is that in the "before" case, we actually opened each
> directory and ran getdents(). But after gc, the directories are gone
> totally and open() fails. We also have to do a linear walk through the
> objects in each directory, since the contents are sorted.

Do you mean "unsorted"?

> So I wonder if it is worth trying to optimize the short-sha1 computation
> in the first place. Double-%h aside, that would make _everything_
> faster, including --oneline.

Right.

> I'm not really sure how, though, short of caching the directory
> contents. That opens up questions of whether and when to invalidate the
> cache. If the cache were _just_ about short hashes, it might be OK to
> just assume that it remains valid through the length of the program (so
> worst case, a simultaneous write might mean that we generate a sha1
> which just became ambiguous, but that's generally going to be racy
> anyway).
> 
> The other downside of course is that we'd spend RAM on it. We could
> bound the size of the cache, I suppose.

You mean like an in-memory pack index for loose objects?  In order to
avoid the readdir call in sha1_name.c::find_short_object_filename()?
We'd only need to keep the hashes of found objects.  An oid_array
would be quite compact.

Non-racy writes inside a process should not be ignored (write, read
later) -- e.g. checkout does something like that.

Can we trust object directory time stamps for cache invalidation?

René
