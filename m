Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8711F406
	for <e@80x24.org>; Thu, 18 Jan 2018 06:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeARGSQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 01:18:16 -0500
Received: from ikke.info ([178.21.113.177]:60410 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbeARGSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 01:18:16 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 9DF29440297; Thu, 18 Jan 2018 07:18:14 +0100 (CET)
Date:   Thu, 18 Jan 2018 07:18:14 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Michael Giuffrida <michaelpg@chromium.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Michael Schubert <mschub@elegosoft.com>
Subject: Re: [BUG] git remote prune removes local tags, depending on fetch
 config
Message-ID: <20180118061814.GC5618@alpha.vpn.ikke.info>
References: <CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com>
 <87tvvmiqn7.fsf@evledraar.gmail.com>
 <CACi5S_33F7VVRYiBOQsxgg_ZPOg9ZvhLZ26bStYWiq7n96aeug@mail.gmail.com>
 <874lnmkorz.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lnmkorz.fsf@linux-m68k.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 12:48:32PM +0100, Andreas Schwab wrote:
> On Jan 15 2018, Michael Giuffrida <michaelpg@chromium.org> wrote:
> 
> > It doesn't seem like a useful feature -- you wouldn't expect `git
> > fetch --prune` to remove your local branches that you were developing
> > on, right?
> 
> Don't mix local and remote refs.  There is a reason why remote tracking
> branches are put in a separate name space.  If you fetch the remote tags
> into a separate name space (eg. refs/remote/tags/*:refs/tags/*) then
> there is no conflict.
> 
> Andreas.

But then they are no longer considered tags, but remote tracking
branches. Tools like git tag and git describe won't consider them, and
git branch -r would show them as remote tracking branches.

> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
