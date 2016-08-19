Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6734C2018E
	for <e@80x24.org>; Fri, 19 Aug 2016 13:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbcHSNGY (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 09:06:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:61580 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753576AbcHSNGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 09:06:23 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MKKaI-1bZ5EW0Tpu-001fcY; Fri, 19 Aug 2016 14:59:34
 +0200
Date:   Fri, 19 Aug 2016 14:59:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch
 mode
In-Reply-To: <xmqqbn0q6m4v.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608191450500.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de> <xmqqbn0q6m4v.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:92YZSDhjGDWfHBO5uw+jut17rTAsGq53Lhj4HVvqSywlwDSkZVa
 DDrS2Pfd456W9qfrm9x8f7o/CjWtuR34mfE0OM3yXEdepkI9fJG7T2u0m9moUx87PhqdKTK
 KD/MyustLXIzzdcWkYAWzq6UCwqf+eh/XWa74jpf33wj6tinwLJmyV0dT2ahZLjBn00JiCA
 VSdjLV/76onX7M8NqQyOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:syjbihqVuJo=:8NHrNBP9v7CltgLmLaoohN
 BmE4KqHVBJ7v3MwHzHMr/6HekccN4Nz2aT9k/xKJyPXhJ3pAES+BcCm+Dy4YAtLZLLmkHOMdo
 rOjb3GeOkvZL7MVM5arnw0ejoEQNAU6nk9KmS2Ad5tJr7KsVdGCnOQ5ciHMzGc/axeVSUHamd
 OkMTMvR0PbEKadwFOU5QOeJSyWRHFgDVSGh8Azj0/mcqfOxpGxcDr2bh6Qs3ymzTDTUGOKVKY
 AVnzx2kTrcsokcJF7ejqU+3HhXTCkbp90GFbt16WViLcTy0PnNwr7Zqncwurqo3GzISbGFANo
 bMTuQ0MIzfKAnKpbsGCFaahkhG0Y0a4KLg3NZpqKazJ2qQ4PJP6L7JL6WC6pNTtveJRK22AcS
 UWXfWOyqBKvqyxq1zG4jSkOFC2q6aLWhdwg4O0JwFdHVzD/zkppXwvhmhWAyNgn0ApxGDmlSp
 dbEaC2Iv1l61RmW1bYpL2YsMZARIcNEmY5j3RlKxIFOqQBi3MNJL26gDw9qwj9cRa/UikQpIE
 2Y53+HM2F9vtAWp+8ivQ2QG1mX4x8CpF7xR7O3pAwMa6o48BKp1IdurdjLciP+t/lzPT3iNdn
 uHzSmD/wYWzGOvPO+0qUxILhHgOj70L0YfkVLAuIbBoU7yAs+R0ivbUpZWiOpo9rTjHjUHdw9
 DJ6fxOa95T+lcge1MUllmYfkxZHuI7VXrB8D08d5Wfp1JfAWEWpm1LYI0bZnbzjuYGRyqIciW
 AcOF0bhCcnvfJpX6E7WtO9Umxhg01Di+QY62d8Sx5s3QrIEs0Me7DANpRO6di5b5vRdPtxtyV
 vawwH43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > With this patch, --batch can be combined with --textconv or --filters.
> > For this to work, the input needs to have the form
> >
> > 	<object name><single white space><path>
> >
> > so that the filters can be chosen appropriately.
> >  --batch::
> >  --batch=<format>::
> >  	Print object information and contents for each object provided
> > -	on stdin.  May not be combined with any other options or arguments.
> > -	See the section `BATCH OUTPUT` below for details.
> > +	on stdin.  May not be combined with any other options or arguments
> > +	except `--textconv` or `--filters`, in which case the input lines
> > +	also need to specify the path, separated by white space.  See the
> > +	section `BATCH OUTPUT` below for details.
> 
> Makes sense.  This format still allows
> 
> 	HEAD:<path2> <path1>
> 
> i.e. the object name is taken from path2 but we forget it and
> pretend that the blob sits at path2, which is a good feature.

Correct.

> If I am not mistaken, your cover letter alluded that it might be
> ideal to take "HEAD:<path>" (nothing else) as input, grab "<path>"
> and feed that to the filtering machinery, but you decided to stop
> short of doing that.  I actually think that it is the right thing to
> do for this feature to ignore the trailing :<path> in the object
> name, iow, I agree with the result from the feature design POV.

I actually decided against it only because it would uglify the code. From
a user point of view, I am a bit annoyed having to say

	:README README
	:Makefile Makefile
	:main.c main.c
	[...]

> The only thing that somewhat is worrysome is what would happen to
> %(rest).

What would happen is that it would print out the path, as it is exactly
that "rest" field that is used in the implementation, piggybacking on that
very nice feature.

Of course, this means that you simply cannot send "SHA-1 path rest" to
cat-file --batch and expect that to work. Should anybody need that in the
future, they can give it a try themselves to patch cat-file.

Ciao,
Dscho
