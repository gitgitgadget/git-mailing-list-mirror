Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBCE1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 13:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbcHSNJa (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 09:09:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:59590 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754047AbcHSNJa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 09:09:30 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MgpmG-1bo1FB0tMW-00M4fk; Fri, 19 Aug 2016 15:09:21
 +0200
Date:   Fri, 19 Aug 2016 15:09:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch
 mode
In-Reply-To: <20160818220530.2dcsag4qeitia4ao@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608191500470.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de> <20160818220530.2dcsag4qeitia4ao@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9Tar8vGv3PGLi0OF8rfy9WtDpqr2St9gQM/bUyYmq35wJwZ1Iiq
 7yJ1rnJ+pqILiwObCcWT4hcApDKGRHBLBS2gd5bv0OMlEjEZ5ctblr8+TRn6qdALuQGA94E
 OesK2pjnuJZ2yo4V+uU9XONH15QidvN5xsRG4cvMt5i34nfx15sdQm3YgjKVr7fNSVJlbZ0
 mrbTUx18tY2pA9ZZE0k5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NStEh799Mns=:/ByFqSV5/0MRSkiVnulKc+
 PT8iokRvgNehAXLREgZFR7I5XCWkuscqnlPCZ5ZfynTyaz6Ckr5cNFNUgKRp7CThBe81YBiE/
 mdAypH6vItpcJhVO63nijrq3yvTWIZEwxkmERqY8WoPSEX5/Jlfw9C0A+tCXE7Lr+p0WfXVgF
 dhOHpPxrX91nqFExDPkoWPzBgoEJPVEcoRCymJz+DiIWGch4Y+tsF7zkA64D5GRk6/CEjrOHr
 ySZL56OZAWQ3BKzHohd51s4V+rgyG/ga8IFh/LKsLQi4GQ6nEjZkS5gagp29A0BTMQ0A0my6M
 W7V3u/t8HnFROy/LsPZzXx+MZm42h25CgYltBL2Dk3Az0zhVFBDOB1jd3mEbSFMfa3v6SLyqt
 KZ6RW3U4S8lR+fP0LrZtAkRtyk6RolbpBNAoEC0g6a4vtnx/O0kNb2csxr8RSejy/BsPiAdHR
 QZPZDco1CunaVj9NRxW7CouKZ1CWvzWrpTyrr96RG7KabfkiEeh0ZCUty/1jQ+8E6WTyfWNf/
 Rcse1HYjmiaNX+mh7PPUYJLgj+h+ozACayq79TX3zHNkmzzkKmd7d78VEG4IuLpsp+thyZN8e
 LmYQ6rDDQKHLkbXScRlx9/h8K62BTZDURK4LYvYfkbIqUPkg27rX38vIYbZqSyDdukkPYc9nO
 tg2j1vG61fHDAc/NbrmWi2L7Y0xzhNZshCNVVULVZJxYeQWWLItVefUZspzO5z6odAWxiwT5X
 x/ctPliuGW/7oPikhHx4SoZXLpnRoToDia7bsEgQSQUS17fSdPZkZRudpaMcXVZ339fqQD/7B
 nGx/Qnv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 18 Aug 2016, Jeff King wrote:

> On Thu, Aug 18, 2016 at 02:46:28PM +0200, Johannes Schindelin wrote:
> 
> > With this patch, --batch can be combined with --textconv or --filters.
> > For this to work, the input needs to have the form
> > 
> > 	<object name><single white space><path>
> > 
> > so that the filters can be chosen appropriately.
> 
> The object name can have spaces in it, too. E.g.:
> 
>   HEAD:path with spaces
> 
> or even:
> 
>   :/grep for this
> 
> (as was pointed out to me when I tried to turn on %(rest) handling by
> default, long ago). How do those work with your patch?

They don't ;-)

And quite frankly, the documentation should make it clear to users that
batch mode with --filters or --textconv won't work when the object name
contains white space: it says that the object name is split from the path
at the first white space character.

> It looks like the extra split isn't enabled unless one of those options
> is selected. Since --filters is new, that's OK for backwards
> compatibility. But --textconv isn't.

Except that it is okay, because --textconv *was not even supported in
batch mode*. So there is no backwards compatibility that could be broken.

> I wonder if we need an option specifically to say "the object name can
> be split". Right now it kicks in automatically if you use "%(rest)" in
> your format, but you might not care about passing along that output
> (e.g., a lot of times I am piping "rev-list" straight to cat-file, and I
> have to use a separate "cut" to throw away the pathnames).

As I said elsewhere in this thread: if anybody encounters that problem,
they are welcome to fix it themselves.

My patch series purpose is to introduce --filters and make it compatible
with the batch mode. As I imitated --textconv, it was both easy and
correct to make it compatible with the batch mode, too. But that is the
extent of this here patch series.

Fixing %(rest) for object names containing spaces is distinctly outside
the original intent, and certainly outside of my use case.

Ciao,
Dscho
