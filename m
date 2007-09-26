From: Jeff King <peff@peff.net>
Subject: Re: Workflow question
Date: Wed, 26 Sep 2007 08:42:43 -0400
Message-ID: <20070926124243.GB13739@coredump.intra.peff.net>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se> <46F96493.8000607@gmail.com> <20070925201717.GB19549@segfault.peff.net> <46F97618.9010207@gmail.com> <20070926004734.GA22617@segfault.peff.net> <46F9CA2A.7000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 14:43:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaWEC-0005ut-06
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 14:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbXIZMmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 08:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbXIZMmq
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 08:42:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2568 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbXIZMmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 08:42:46 -0400
Received: (qmail 26677 invoked by uid 111); 26 Sep 2007 12:42:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Sep 2007 08:42:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2007 08:42:43 -0400
Content-Disposition: inline
In-Reply-To: <46F9CA2A.7000107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59227>

On Tue, Sep 25, 2007 at 09:55:38PM -0500, Russ Brown wrote:

> Yes, this is very helpful indeed: thank you for that. /me bookmarks. I
> hadn't actually realised that rebase creates new commits and replaces
> your old ones: I'd thought they just got 'moved' (dunno how I thought it
> worked though!)

It's a necessity, since the commits are named by hash, and the hash
encompasses _all_ of the history. So the same change at a different
location in history will be a different commit.

And that is why rebases can make merging harder. Git can very quickly
compare two commits by hash and say "these are the same commit", or look
at them and say "one side has these changes, the other side has these
other changes, and here is where they meet." Rebasing ruins that, since
the same changes occur in two places with different names.

> I'm just wondering at this point why git lets you checkout remote
> tracking branches if it's something you really shouldn't do. Unless it's
> something you want to be able to do in edge cases to fix screwups maybe?

Junio explained in much more detail, but I use it largely for read-only
access ("oh, let me speed-test my branch against the upstream 'master'";
git-checkout master; test test test; git-checkout mybranch).

> Thanks for this, it's very useful to read examples of workflows in
> actual use. In fact, I was thinking the other day that it would be good
> to have a site that acts as a directory of many different workflows,
> including descriptions of how they work, how you actually go about
> setting it up and using it day to day (i.e. lists of commands for each
> role/task) and the pros/cons that it provides. I reckon that would help
> newbies out quite a bit (if only for the examples). I've seen a few
> individual examples of workflow but nothing like a comprehensive set of
> them.

I agree. That sort of information is sprinkled throughout the mailing
list, but it might be nice on a wiki. I have thought of it as a sort of
"git cookbook" where you say "here is a recipe for accomplishing X". The
user manual comes close to this for smaller tasks.

-Peff
