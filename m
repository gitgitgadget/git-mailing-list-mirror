Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61AE920986
	for <e@80x24.org>; Tue, 27 Sep 2016 13:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbcI0NSH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 09:18:07 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61245 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750851AbcI0NSH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 09:18:07 -0400
X-AuditID: 12074412-1c3ff70000000931-4b-57ea718d7d2a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 06.4E.02353.D817AE75; Tue, 27 Sep 2016 09:18:05 -0400 (EDT)
Received: from [192.168.69.190] (p5790747A.dip0.t-ipconnect.de [87.144.116.122])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u8RDI3Ir013234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 27 Sep 2016 09:18:04 -0400
Subject: Re: [PATCH] xdiff: rename "struct group" to "struct xdlgroup"
To:     Jeff King <peff@peff.net>
References: <20160927043733.u3emlanbipu2cn5h@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9fb14a41-00b3-f8d1-d8d2-8aa41261492e@alum.mit.edu>
Date:   Tue, 27 Sep 2016 15:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160927043733.u3emlanbipu2cn5h@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqNtb+CrcYHOfuUXXlW4mix8tPcwO
        TB7PevcwenzeJBfAFMVlk5Kak1mWWqRvl8CVcWxjP3vBKa6KfV+PMTcwHuHoYuTkkBAwkTi5
        6idLFyMXh5DAVkaJq8unsUE4F5gkJjRNZQWpEhZwk5jfvJMFxBYRkJX4fngjI4gtJOAssWjt
        P7A4s4C4xLq559lBbDYBXYlFPc1MIDavgL3E749/2EBsFgFViRcTvzGD2KICIRLty9ZD1QhK
        nJz5BGwOp4CLxO6FV9khZqpL/Jl3iRnClpfY/nYO8wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc
        3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJCAFNrBuP6k3CFGAQ5GJR7eCZUvw4VYE8uK
        K3MPMUpyMCmJ8hbEvQoX4kvKT6nMSCzOiC8qzUktPsQowcGsJMJrnAeU401JrKxKLcqHSUlz
        sCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4N1eANQoWJSanlqRlplTgpBm4uAEGc4DNPwR
        SA1vcUFibnFmOkT+FKOilDivFEhCACSRUZoH1wtLGK8YxYFeEeZ9CFLFA0w2cN2vgAYzAQ1e
        euIFyOCSRISUVANjymLbDa0BJS0dSx9N9I76ZPP2ZZxms8AFv6SfOVYpe92CnK7O5o8751b6
        ckOnKWuQzPfSf8nTUgWnOoutFnbZwTKjweLFjmVsqjNexC6dzlkhdu5IRscxpc+acz8bNziV
        Z8z446LkoHDd/GZ5UIX7RaFV716vmHRuoY/PlnzTnkdPHtgul5qixFKckWioxVxUnAgAM1Zc
        OfMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27/2016 06:37 AM, Jeff King wrote:
> Commit e8adf23 (xdl_change_compact(): introduce the concept
> of a change group, 2016-08-22) added a "struct group" type
> to xdiff/xdiffi.c. But the POSIX system header "grp.h"
> already defines "struct group" (it is part of the getgrnam
> interface). This happens to work because the new type is
> local to xdiffi.c, and the xdiff code includes a relatively
> small set of system headers. But it will break compilation
> if xdiff ever switches to using git-compat-util.h.  It can
> also probably cause confusion with tools that look at the
> whole code base, like coccinelle or ctags.
> 
> Let's resolve by giving the xdiff variant a scoped name,
> which is closer to other xdiff types anyway (e.g.,
> xdlfile_t, though note that xdiff is fond if typedefs when
> Git usually is not).

Makes sense to me. I didn't try to adhere to xdiff conventions too
tightly because I don't think that project is alive anymore, so I don't
expect we'll be upstreaming anything [1]. But this change definitely
makes sense.

Thanks,
Michael

[1] Though I've since learned that libgit2 also bases their diff code on
xdiff, so if we avoid changing things gratuitously there is more chance
that our two projects can benefit from each other's improvements
whenever they are also licensed compatibly.

