Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36FD4200B9
	for <e@80x24.org>; Sat,  5 May 2018 21:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeEEVzY (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 17:55:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:51163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEEVzX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 17:55:23 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfEsY-1ezDFL2yhG-00OsZP; Sat, 05
 May 2018 23:55:05 +0200
Date:   Sat, 5 May 2018 23:55:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/18] Add a function to solve least-cost assignment
 problems
In-Reply-To: <20180505182427.GB17700@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1805052351560.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de> <20180505182427.GB17700@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s/TH13HJO0aDhM18FMVECMRvCB0AIEy7JgonHiQaojYCNObgCFI
 fPNl+jtwdp6WaP/7Iwb2+++pmB3OgX8yT1emIy0RNvAmgF8pjai2hmz2NCaZlpk3omB/8yX
 w6hJUZ6Z9ctPWT3XYfOwiu3yZGvVDAbmfF46qesOPplwINGgwE/i8d/cSwVib+mZxtOxXuU
 +d6Uu4AmDMStq6SJcEJdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b5Yjn803hMU=:7XndwkGn8J3f2FUP/gzQPf
 aWlwgDcpMlMbXWlIkF3du7hEU+ut75v9pnXtriTdTTiiTblOk6rwlcy4PAcYsKuMxP+ALm2m0
 vmhTeX8oa2n5noPGE+q4FGgm3tZxqvzBvkOGiFyr26M9V7jOUSnmWGoOFhguiXYthBJWjlSTY
 baOv9ZZCtHtihgBWicNMzlw2tMgsGCoPGBPITUd06YENK6JK1/bHSvllgX5+3zXw2eEyL0OuZ
 o7FIV0IiHVyyHQiApbHK9OPqgwJOuR4ILBHcBm4tl3zs2uYoAQrSp8bZGgH3ycrP8JXhphPlL
 yCoremSd/G56AJ7y6NwEfSMcrll6MO8pZXFHUTHNl+oKMNFlYYnrrqvxjxv7NZX8vKx7Y3hP7
 Xz22kc4BgeQd4K7f5jVFxa48NpgkyzS3F5Fvn87tderalAt+DynSrDr1hdIyGDanFVl8kix5K
 waB5NHMKwWB96YKpfSbWXC8/tj+DG0C8+AnxWv9N7FIEa++YQVsRjX9Bj5MgT8tOoLZc6Z2qz
 YVykh2LqFlgSrQNvjHMbggFvJkuO/EDXNXwTdlRUqUkPdQKRQA1Ncuh7h7d5YOg6cnF0pGqgh
 JEwZ30voe6ny/hBVXeacIMY1caBpTgQy6BywymsW8aJLd3GOIP9ACyxQ/o/6TCcssQD8eqErB
 H0+Sjj/nJyN2WjrNNIMxfYa8nYMWBk8lt9q6W4xMF6e3HCc7rSgm1fU8YcM3bc2pqZ0o7Nhn+
 BdzkPJefGSV2SgqILrJQkwxIo7AQd4vmBVhd314aiSTbergJ1jyfshcn79loOe7wkCoBqMl/0
 FJb3xA9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 5 May 2018, Jeff King wrote:

> On Fri, May 04, 2018 at 05:34:29PM +0200, Johannes Schindelin wrote:
> 
> > The Jonker-Volgenant algorithm was implemented to answer questions such
> > as: given two different versions of a topic branch (or iterations of a
> > patch series), what is the best pairing of commits/patches between the
> > different versions?
> 
> I love git-tbdiff, so I'm excited to see it getting more exposure (and a
> speedup). Thanks for working on this!

:-)

> Two minor nits on this patch:
> 
> > +/*
> > + * The parameter `cost` is the cost matrix: the cost to assign column j to row
> > + * i is `cost[j + column_count * i].
> > + */
> > +int compute_assignment(int column_count, int row_count, double *cost,
> > +		       int *column2row, int *row2column)
> > +{
> > +	double *v = xmalloc(sizeof(double) * column_count), *d;
> 
> Please use st_mult, xcalloc, or ALLOC_ARRAY here to avoid unchecked
> multiplication in an allocation. This is probably hard to exploit in
> practice (since you'd need sizeof(size_t)/8 columns, which presumably
> requires allocating some heavier-weight struct per item). But it makes
> auditing easier if we avoid the pattern altogether.

Sure. I did mean to return errors in those case, but I guess it is not
worth the trouble (what would we do in case of out-of-memory?).

> > +/*
> > + * Compute an assignment of columns -> rows (and vice versa) such that every
> > + * column is assigned to at most one row (and vice versa) minimizing the
> > + * overall cost.
> > + *
> > + * The parameter `cost` is the cost matrix: the cost to assign column j to row
> > + * i is `cost[j + column_count * i].
> > + *
> > + * The arrays column2row and row2column will be populated with the respective
> > + * assignments (-1 for unassigned, which can happen only if column_count !=
> > + * row_count).
> > + */
> > +int compute_assignment(int column_count, int row_count, double *cost,
> > +		       int *column2row, int *row2column);
> 
> It looks like this always returns zero. Is there a ever a case where we
> would return an error if this? If not, should it just be void?

Fixed.

Ciao,
Dscho
