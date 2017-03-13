Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A50320373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbdCMVE0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:04:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:65256 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbdCMVEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:04:25 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ8fw-1cX6B6229c-00KyWE; Mon, 13
 Mar 2017 22:04:12 +0100
Date:   Mon, 13 Mar 2017 22:04:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     David Aguilar <davvid@gmail.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
In-Reply-To: <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703132200290.3767@virtualbox>
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox> <20170313175640.14106-1-davvid@gmail.com> <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XyKvpVSTZMaVNCxT74zd0pIHpIuYHzQaYLFYaJAQ4fqpBlYLQW5
 YWJBohL44S4Hov5e8RrsAWcmwKZbTQRfeZqxHuEmbPPf/cwn75014pGcr3hrwvw0KMo/pkd
 gB/y7Z8peF3cnjwWcqGaSyUVE8v3774az0i28q83QV40C8DpBq09sauqxg7Ibj3rvBf5x4Y
 S1l3FRZlap4bDTeCc1jEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YX+rR+sZaSQ=:hkQ9r0j7DmsZ5DJp/KOt9d
 Xvo4ELXep1yBJGs4PlkMZzPDjedURgzbDG6qwiC/L1SGasFDTbiZTBylALXC6YkGT8eEAkEmJ
 7pl4MiZGNvWNXkNypiOFVaXkWIyVXuifd1kqBpIJpYsEwSAdH2HgFnIcrQCUVwNT7Q5nmortl
 H4b/OD5kt5ttFhFlzl29RpsRYQHDuiN3EfhZh1fbNndumpUqF64Zno1A6fkfcZOJcfgKLgbhV
 Pdf1c1myjrqxOkUTP/KYTWs5TjGy8AEEL/L1gfQlOjWE7IMijZSTzwAQHuG1jPAdOb7YFgdxP
 QG8pWyHB5GqvOJ21224xwfDtW9ZlxWPDJY/Qd0fg/8WPmysKhldTvWyGJ0zosmWiVDS/vr47w
 3nULWASU7b6DRAUj9OtVmS1LP0Uwgf/7IK5uVdY4dGKhQzwnKm+vH36TedzpgOWFH77+jyoT0
 TdfEdbBt9+qTRG5N8qHr3F2jowTgOT+KDbodYtaNPW4mcHV2zNBfktI6tEhnqsJ6l/JxL1kiS
 SVE3WP80QsHhVEVThEKhdLL5SMbhXKaThE3UkyY1E2botYb31uyT4wQ2fElVquDCBLnZUUU9E
 UyJT91C31V/1YGgS/xkoD8ZegbR6E5G0HtF3KFdsSBu3WnjfEK90sUbfJJCwsN7GHcfkkZknw
 6nQdJHgNSWg9icQ5tgzQnTv4Dg7sUs7HB+Fukgk4kegYtunMxzjCq10RzPi/0RXX+CUdc7ae/
 xhyoAm9h+gVi30E+efBxRX8at/pO8Wsc7Lk2IJmAMmDGJo9n9eRvxUr8RQvnaPu9O11B/gHWK
 Fn/8Hj2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 13 Mar 2017, Junio C Hamano wrote:

> David Aguilar <davvid@gmail.com> writes:
> 
> > Detect the null object ID for symlinks in dir-diff so that difftool
> > can prepare temporary files that matches how git handles symlinks.
> >
> > Previously, a null object ID would crash difftool.  We now detect null
> > object IDs and write the symlink's content into the temporary symlink
> > stand-in file.
> >
> > Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> 
> I would have appreciated (and I suspect other reviewers would, too)
> a bit of back-story wrt how "Original-patch-by" resulted in this
> patch after the three-dashes line.  It is perfectly fine if you two
> coordinated privately; I mostly wanted to hear something like "Dscho
> has been working on this and I asked him if it is OK to take over
> his WIP to produce a quick-fix we can ship on the maint branch, here
> is the result of that collaboration."  IOW, the person who is named
> as the original author is fine to be named like so (I care only
> because I do not think we saw the "original" here on the list).

The story is more like: Johannes started working on this but got pulled
away by other tasks and sent out a link to the initial patch, along with a
note that he hopes to be able to get back to working on that patch before
long (but of course he did not get the chance):

http://public-inbox.org/git/alpine.DEB.2.20.1703072332370.3767@virtualbox/

There was no private exchange. I am happy that David picked up the
project.

Ciao,
Johannes
