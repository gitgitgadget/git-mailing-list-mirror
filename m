Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0971F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 11:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbcG2LEf (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 07:04:35 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59746 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcG2LEe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 07:04:34 -0400
Received: from mfilter14-d.gandi.net (mfilter14-d.gandi.net [217.70.178.142])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 7859841C07F;
	Fri, 29 Jul 2016 13:04:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter14-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter14-d.gandi.net (mfilter14-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Qozod8BCvTFn; Fri, 29 Jul 2016 13:04:30 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 858F341C096;
	Fri, 29 Jul 2016 13:04:28 +0200 (CEST)
Date:	Fri, 29 Jul 2016 04:04:26 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160729110426.GA2945@x>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729101011.GA3469@salo>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 11:10:11AM +0100, Richard Ipsum wrote:
> On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> [snip]
> > 
> > I'd welcome any feedback, whether on the interface and workflow, the
> > internals and collaboration, ideas on presenting diffs of patch series,
> > or anything else.
> > 
> 
> This looks awesome!
> 
> I've been working on some similar stuff for a while also.[1][2]
> 
> I'm particularly interested in trying to establish a standard for
> storing review data in git. I've got a prototype for doing that[3],
> and an example tool that uses it[4]. The tool is still incomplete/buggy though.

Looks promising, though!

> There seem to be a number of us trying to solve this in our different ways,
> it would be great to coordinate our efforts.

These definitely seem like a family of related problems.  I'd like to
use git-series as a format for storing iterations on things like GitHub
pull-requests or Gerrit patch versions (in the latter case, overcoming
Gerrit's limitations on only handling one patch at a time).  Integrating
reviews with that seems helpful.

> The prototype library I have is partly the result of some discussion and work
> with the Gerrit folks, since they were thinking about this problem
> before I even started writing git-candidate, and solved it with Notedb.[5]
> 
> Let me know if you'd like to work together on this,

I'd love to.

I'll be presenting git-series at LinuxCon North America; will you be
there by any chance?  If not, perhaps we could meet by IRC or some other
medium and talk about this family of problems.

I hope to use git notes with git-series in the future, by putting
another gitlink under the git-series for notes related to the series.
I'd intended that for more persistent notes; putting them in the series
solves some of the problems related to notes refs, pushing/pulling, and
collaboration.  Using notes for review comments makes sense as well,
whether in a series or in a separate ref.

> I've been considering taking the perl-notedb prototype and writing
> a C library for it with bindings for other languages (i.e. Rust).

A C library based on libgit2 seems like a good idea; ideally the
bindings could interoperate with git2-rs.  (Alternatively, Rust can
*export* a C interface, so you could write directly with git2-rs. :) )

One of the items on my long-term TODO list is a completely federated
GitHub; I've been looking at other aspects of that, but federated
reviews/comments/etc seem critical to that as well.

- Josh Triplett
