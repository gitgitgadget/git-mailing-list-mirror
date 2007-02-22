From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn + svn:externals
Date: Thu, 22 Feb 2007 13:48:54 -0800
Message-ID: <20070222214854.GA32195@localdomain>
References: <51167308-9E52-4E46-80A0-70A3C255C081@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 22:49:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKLoC-0000km-Bc
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 22:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXBVVs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 16:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbXBVVs5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 16:48:57 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34802 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbXBVVs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 16:48:56 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 019BF7DC091;
	Thu, 22 Feb 2007 13:48:54 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 22 Feb 2007 13:48:54 -0800
Content-Disposition: inline
In-Reply-To: <51167308-9E52-4E46-80A0-70A3C255C081@silverinsanity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40397>

Brian Gernhardt <benji@silverinsanity.com> wrote:
> Is there any plan or shell incantation to get git-svn working nicely  
> with SVN externals?  I'm working a Ruby on Rails application  
> (radiantcms.org), which uses the externals to track library  
> versions.  I don't mind reading from an SVN repository, but would  
> much much rather use git to track my local changes.
> 
> Also, is it possible for git-svn to at least warn when the repo  
> you're importing has externals?  It would be nicer than randomly  
> having hunks of the project missing.

The latest versions of git-svn should warn about externals (among some
other things that we currently don't support).  They are logged in
.git/svn/$refname/unhandled.log with newlines (and some other
characters) URI-encoded out.  I've been planning on having something
parse the unhandled.log but have not gotten around to it.

I'm still waiting on subproject support in git to seriously look at
svn:externals; but it's not a high priority for me.  You could probably
look at the code that does 'git svn show-ignore' which reads the
svn:ignore properties and expand it to support svn:externals.

-- 
Eric Wong
