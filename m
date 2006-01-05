From: Jon Nelson <jnelson-git@jamponi.net>
Subject: Re: use GIT_DIR instead of /var/tmp
Date: Thu, 5 Jan 2006 10:49:36 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0601051048490.667@gheavc.wnzcbav.cig>
References: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
 <Pine.LNX.4.64.0601050840010.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 17:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuYNZ-0006En-NN
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 17:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWAEQyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 11:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWAEQyS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 11:54:18 -0500
Received: from mtao03.charter.net ([209.225.8.188]:28062 "EHLO
	mtao03.charter.net") by vger.kernel.org with ESMTP id S1751819AbWAEQyQ
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 11:54:16 -0500
Received: from mxip21-10.charter.net ([10.20.202.71]) by mtao03.charter.net
          (InterMail vM.6.01.05.04 201-2131-123-105-20051025) with ESMTP
          id <20060105165040.EXZQ3657.mtao03.charter.net@mxip21-10.charter.net>
          for <git@vger.kernel.org>; Thu, 5 Jan 2006 11:50:40 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip21-10.charter.net with ESMTP; 05 Jan 2006 11:49:41 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 07267C0A8; Thu,  5 Jan 2006 10:49:36 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id E2AF3C0A7
	for <git@vger.kernel.org>; Thu,  5 Jan 2006 10:49:36 -0600 (CST)
In-Reply-To: <Pine.LNX.4.64.0601050840010.3169@g5.osdl.org>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14206>

On Thu, 5 Jan 2006, Linus Torvalds wrote:

> 
> 
> On Thu, 5 Jan 2006, Alex Riesen wrote:
> >
> > Not every system (will not one microsoft windows system) have /var/tmp,
> > whereas using GIT_DIR for random temporary files is more or less established.
> 
> Note that in this case it might be appropriate, but in general you should 
> be careful. You may want to access a git directory without actually having 
> write permissions to it. 
> 
> Of course, for "git reset" that's not an issue (since it needs write 
> permissions anyway), but just in general.. git programs mostly use pipes 
> to communicate, and temporary files are pretty rare, so we hopefully don't 
> have that issue much, but let's make sure that things that just look at a 
> repository can work even with a read-only repo.

Do you still need write access to $GIT_DIR if $GIT_INDEX_FILE is set to 
some place outside of $GIT_DIR?

--
Jon Nelson <jnelson-git@jamponi.net>
