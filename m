From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 18:39:15 -0700
Message-ID: <20070918013915.GC13571@hand.yhbt.net>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com> <11900461843997-git-send-email-hjemli@gmail.com> <20070918005013.GA6368@muzzle> <7vk5qoye2t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 03:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXS3h-0004m1-HM
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 03:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbXIRBjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbXIRBjS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 21:39:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50387 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381AbXIRBjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 21:39:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7E85E7DC029;
	Mon, 17 Sep 2007 18:39:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk5qoye2t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58522>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Would automatically enabling --no-ff when it detects merging of two (or
> > more) SVN branches be a good thing?  We can add scripting support to
> > git-svn for detecting if any given commit is really from SVN or not.
> > Then we could do something like this in git-merge
> >
> > ---------------------------- 8< --------------------------------
> > if git-svn test-svn-commits "$@"
> > then
> > 	no_ff=t
> > 	no_fast_forward_strategies=$all_strategies
> > fi
> > ---------------------------- 8< --------------------------------
> 
> Yuck, do I understand you correctly?  Are you talking about
> adding dependency on git-svn to git-merge?

It could be another simple independent script, then.  git-svn isn't
installed on most distros when git is, so it won't always work...

-- 
Eric Wong
