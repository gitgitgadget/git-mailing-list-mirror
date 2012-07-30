From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Mon, 30 Jul 2012 22:15:48 +0000
Message-ID: <20120730221548.GA388@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <5016F832.7030604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 00:15:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvyFn-0006V8-2n
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 00:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044Ab2G3WPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 18:15:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57734 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab2G3WPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 18:15:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2A21F449;
	Mon, 30 Jul 2012 22:15:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5016F832.7030604@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202622>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.30 1:38 PM, Eric Wong wrote:
> > Anyways, I don't like relying on operator overloading, it makes code
> > harder to read and review.
> 
> Right now, canonicalization is a bug generator.  Paths and URLs have to be in
> the same form when they're compared.  This requires meticulous care on the
> part of the coder and reviewer to check every comparison.  It scatters the
> logic for proper comparison all over the code.  Redundant logic scattered
> around the code is a Bad Thing.  It makes it more likely a coder will forget
> the logic, or get it wrong, and a human reviewer must be far more vigilant.

<snip>  I agree completely with canonicalization.

> The only downside is when chasing down a bug related to canonicalization one
> might have to realize that eq is overloaded.

Having to realize eq is overloaded is a huge downside to me.
