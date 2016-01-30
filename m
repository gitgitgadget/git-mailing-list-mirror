From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] transport: drop support for git-over-rsync
Date: Sat, 30 Jan 2016 08:04:52 +0000
Message-ID: <20160130080452.GA2851@dcvr.yhbt.net>
References: <20160130051133.GA21973@dcvr.yhbt.net>
 <20160130054141.GB1677@sigill.intra.peff.net>
 <20160130063036.GC1677@sigill.intra.peff.net>
 <20160130072126.GA14696@sigill.intra.peff.net>
 <20160130072813.GB14696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 09:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPQXR-0008Kw-NO
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 09:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbcA3IEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 03:04:54 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50174 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbcA3IEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 03:04:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DCF1F736;
	Sat, 30 Jan 2016 08:04:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160130072813.GB14696@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285105>

Jeff King <peff@peff.net> wrote:
> On Sat, Jan 30, 2016 at 02:21:26AM -0500, Jeff King wrote:
> > Even the commit porting rsync over to C from shell (cd547b4)
> > lists it as deprecated! So between the 10 years of informal
> > warnings, and the fact that it has been severely broken
> > since 2007, it's probably safe to simply remove it without
> > further deprecation warnings.

I suppose there's a chance some projects are so small they never
trigger ref packing; especially if some people are serving .git
out of a working directory... *shrug*

But yeah, plain rsync remains usable, of course.

> I cleaned up all of the documentation references I could find, except
> one: the git-svn manual notes that because SVN metadata is kept outside
> of refs, you should use rsync for cloning. I'm not sure what to
> recommend there. I don't eve nthink that "git clone rsync://" would copy
> that metadata. So perhaps it just meant "rsync the whole thing yourself"
> (in which case it is OK to leave it).

Yes, probably "rsync the whole thing yourself".  And I should
update that since "clone --mirror" supports remotes, nowadays.
git-svn metadata is rebuildable anyways (unless somebody made
the mistake of disabling it).
