From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git-ls-files in subdirectories ignore higher-up .gitignore
Date: Wed, 25 Jan 2006 07:11:40 +0100
Message-ID: <20060125061140.GA8408@mars.ravnborg.org>
References: <1138125570.24415.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 25 07:11:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1dsm-0003iG-OQ
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 07:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWAYGLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 01:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWAYGLq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 01:11:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30219 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751033AbWAYGLp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2006 01:11:45 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id CA1101EC312;
	Wed, 25 Jan 2006 07:11:42 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 2AF2843C82F; Wed, 25 Jan 2006 07:11:40 +0100 (CET)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1138125570.24415.11.camel@dv>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15118>

On Tue, Jan 24, 2006 at 12:59:30PM -0500, Pavel Roskin wrote:
> Hello!
> 
> git-ls-files appears to behave in a way that may be unexpected to the
> users.  When run in a subdirectory, git-ls-files never reads .gitignore
> or whatever is specified by --exclude-per-directory in the parent
> directories.
> 
> This can be demonstrated in git's own repository:
> 
> $ touch t/test.o
> $ git-ls-files --others --exclude-per-directory=.gitignore
> $ cd t
> $ git-ls-files --others --exclude-per-directory=.gitignore
> test.o
> $
> 
> Before I attempt to fix it, I'd like to make sure it's a bug, not a
> feature.

I for one consider it a bug.
I expect exactly same output if I do
git ls-files t/
or
cd t; git ls-files

Very usefull when I limit grep to some part of the kernel tree for
example.

	Sam
