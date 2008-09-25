From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/5] git-gui: Support for "Locators" - address
 templates
Date: Thu, 25 Sep 2008 17:26:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809251705260.19665@iabervon.org>
References: <20080924221249.037449176@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Sep 25 23:27:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiyMw-0005x6-Vj
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 23:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbYIYV0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 17:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbYIYV0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 17:26:16 -0400
Received: from iabervon.org ([66.92.72.58]:57449 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbYIYV0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 17:26:16 -0400
Received: (qmail 2791 invoked by uid 1000); 25 Sep 2008 21:26:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2008 21:26:15 -0000
In-Reply-To: <20080924221249.037449176@suse.cz>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96804>

On Thu, 25 Sep 2008, pasky@suse.cz wrote:

> This patch allows "locators" to be configured and used in the GUI,
> basically as URL templates the input string is subsituted into.
> The default operation of git-gui is not much affected (only some
> labels change to be less confusing).
> 
> This is aimed mainly at corporate Git deployments - the integrator
> might want to configure the central corporate repository store as
> the default locator so that people do not need to type the same
> URL over and over but can instead just type the repository name
> on the server. Or avid repo.or.cz users might set up a 'repo'
> locator pointing at 'git://repo.or.cz/%s'.

Can this be set up to use the "url.<base>.insteadOf" configuration? Part 
of my goal with that feature was to make it easy for me to reference 
projects on my work's central repository store. That is, put in your 
~/gitconfig:

[url "git://repo.or.cz/"]
	insteadOf = repo:

And "git clone repo:alt-git" works.

It'd be nice to share the config somehow so that the same settings can be 
used both in git-gui and on the command line. (I wrote the code so that a 
user can swap patterns of URLs work for other people but aren't good for 
that particular user, but it also applies to user-provided shorthand 
URLs.)

	-Daniel
*This .sig left intentionally blank*
