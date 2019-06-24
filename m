Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE061F461
	for <e@80x24.org>; Mon, 24 Jun 2019 20:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfFXU3M (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 16:29:12 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45060 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFXU3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 16:29:12 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hfVaO-0004a4-DU; Tue, 25 Jun 2019 05:29:08 +0900
Date:   Tue, 25 Jun 2019 05:29:08 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, ungureanupaulsebastian@gmail.com
Subject: Re: [PATCH] stash: fix show referencing stash index
Message-ID: <20190624202908.atlphbwai7miwl3u@glandium.org>
References: <20190614074207.mxidz3h573mtd43x@glandium.org>
 <20190615112618.GC11340@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615112618.GC11340@hank.intra.tgummerer.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 15, 2019 at 12:26:18PM +0100, Thomas Gummerer wrote:
> On 06/14, Mike Hommey wrote:
> > Hi,
> > 
> > `git stash <command> <n>` where n is a number used to work until 2.21.*.
> > It doesn't work in 2.22.0.
> > 
> > Bisection points to:
> > 
> > dc7bd382b1063303f4f45d243bff371899285acb is the first bad commit
> > commit dc7bd382b1063303f4f45d243bff371899285acb
> > Author: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> > Date:   Mon Feb 25 23:16:20 2019 +0000
> > 
> >     stash: convert show to builtin
> > 
> > which I guess makes sense :)
> 
> Yup, this is definitely a bug.  I think it only affected 'git stash
> show' however, and not other stash subcommands.  If not, could you
> point me to where else you saw this bug?

I confirmed pop, apply, branch, and drop are not affected.

Mike
