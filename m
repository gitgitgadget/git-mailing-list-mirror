From: Brian Hetro <whee@smaertness.net>
Subject: Re: [PATCH] When nothing to git-commit, honor the git-status color
	setting.
Date: Mon, 27 Aug 2007 05:45:43 -0400
Message-ID: <20070827094543.GA8014@ruiner>
References: <20070826183526.GA16359@ruiner> <20070827082550.GC17373@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbAQ-0002Ln-5g
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 11:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbXH0Jpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 05:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbXH0Jpu
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 05:45:50 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:8909 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbXH0Jpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 05:45:49 -0400
Received: by an-out-0708.google.com with SMTP id d31so193991and
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 02:45:49 -0700 (PDT)
Received: by 10.100.44.13 with SMTP id r13mr1366196anr.1188207948867;
        Mon, 27 Aug 2007 02:45:48 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id c1sm4557611ana.2007.08.27.02.45.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 02:45:46 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Mon, 27 Aug 2007 05:45:45 -0400 (EDT)
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070827082550.GC17373@coredump.intra.peff.net>
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56795>

On Mon, Aug 27, 2007 at 04:25:50 -0400, Jeff King wrote:
> On Sun, Aug 26, 2007 at 02:35:26PM -0400, Brian Hetro wrote:
> 
> > Instead of disabling color all of the time during a git-commit, allow
> > the user's config preference in the situation where there is nothing
> > to commit.  In this situation, the status is printed to the terminal
> > and not sent to COMMIT_EDITMSG, so honoring the status color setting
> > is expected.

> A minor nit on the implementation:
> 
> > +	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
> > +		color=
> > +	else
> > +		color=--nocolor
> > +	fi
> 
> This variable doesn't really say "use color"; it says "don't explicitly
> turn off color". So perhaps there is a better name (respect_color or
> similar)?

I was thinking more along the lines of "use color as if you had run
git-status" when I decided on $use_status_color.  Perhaps there is a
better name.

Brian
