From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: only look at the root path for svn:mergeinfo
Date: Tue, 22 Apr 2014 18:54:59 +0000
Message-ID: <20140422185459.GA17248@dcvr.yhbt.net>
References: <1397717646-54248-1-git-send-email-stoklund@2pi.dk>
 <1397717646-54248-2-git-send-email-stoklund@2pi.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>
To: Jakob Stoklund Olesen <stoklund@2pi.dk>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:55:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcfr8-0001CK-SI
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbaDVSzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:55:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47149 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264AbaDVSzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:55:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0647120F72;
	Tue, 22 Apr 2014 18:55:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1397717646-54248-2-git-send-email-stoklund@2pi.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246768>

Jakob Stoklund Olesen <stoklund@2pi.dk> wrote:
> Subversion can put mergeinfo on any sub-directory to track cherry-picks.
> Since cherry-picks are not represented explicitly in git, git-svn should
> just ignore it.

Hi, was git-svn trying to track cherry-picks as merge before?

This changes behavior a bit, so two independent users of git-svn
may not have identical histories as a result, correct?

Can you add a test to ensure this behavior is preserved?
Thanks.

Sorry, I've never looked at mergeinfo myself, mainly relying on
Sam + tests for this.

[1] - Historically, git-svn (using defaults) has always tried to
      preserve identical histories for independent users across
      different git-svn versions.  However, mergeinfo may be
      enough of a corner-case where we can make an exception.
