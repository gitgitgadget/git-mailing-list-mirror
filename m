From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 01:59:03 -0800
Message-ID: <20070215095903.GA6292@localdomain>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx> <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy98o78i.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net> <7v4ppnhkps.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 10:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdP6-0001VB-Mg
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 10:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965438AbXBOJ7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 04:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965446AbXBOJ7L
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 04:59:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58618 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965438AbXBOJ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 04:59:09 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 84AB97DC091;
	Thu, 15 Feb 2007 01:59:03 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 15 Feb 2007 01:59:03 -0800
Content-Disposition: inline
In-Reply-To: <7v4ppnhkps.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39805>

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > I am not quite sure how $GIT_CONFIG and $GIT_CONFIG_LOCAL were
> > meant to be used.  Are there any *real* users?  With lack of
> 
> Addendum.
> 
> Judging from the way builtin-config.c::get_value() uses it, I
> think whoever invented $GIT_CONFIG_LOCAL as a parallel to
> $GIT_INDEX_FILE and $GIT_OBJECT_DIRECTORY, in other words, what
> usually appear under $GIT_DIR can be placed somewhere completely
> different.  So I think the above "hack" I described still honors
> its intended use.
> 
> I am still not sure what good GIT_CONFIG would be to completely
> override everything else, though.

I just started using GIT_CONFIG in the experimental version of
git-svn[1] which allows me to use .git/svn/config for tracking some
metadata bits.

I didn't want to pollute the users' .git/config with automatically read
and state data in .git/config; so I started using .git/svn/config to
avoid littering .git/svn/ with any tiny pieces of data I might need.

-- 
Eric Wong
[1] - git://bogomips.org/git-svn
