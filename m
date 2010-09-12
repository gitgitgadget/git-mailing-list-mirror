From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn: How dependent is the git-svn repository on the
 Subversion repository URL?
Date: Sun, 12 Sep 2010 08:57:12 +0200
Message-ID: <20100912065712.GA11407@m62s10.vlinux.de>
References: <loom.20100912T032208-79@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Trebbien <dtrebbien@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 08:57:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OugVA-0004ti-PZ
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 08:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab0ILG5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 02:57:19 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:33535 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751518Ab0ILG5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 02:57:18 -0400
Received: (qmail invoked by alias); 12 Sep 2010 06:57:16 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp043) with SMTP; 12 Sep 2010 08:57:16 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19kWEdLGxVkaJSZUqXUL1myAzrrhCWWvx1C50tghQ
	Ipd4lTM2zEtmee
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 7A612D400E; Sun, 12 Sep 2010 08:57:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20100912T032208-79@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156021>

On Sun, Sep 12, 2010 at 01:29:52AM +0000, Daniel Trebbien wrote:
> If I initialize the git-svn repository by passing in the location of a local
> mirror, as in:
> git svn init -s file:///path/to/mirror
> and proceed to fetch all revisions from the mirror, may I simply change the
> `url = ` line of `.git/config` to make it point to the real repository, or is
> the git repository that is created by git-svn dependent on the original URL that
> was specified in the initialization?
> 

Changing only the url in the config does won't work, because git-svn appends a line
to every commit message which includes the SVN URL. But If I remember correctly,
putting something like this into the config file *will* work

[svn-remote "svn"]
        rewriteRoot = svn://url/to/pubic/svn/server
        url = file:///path/to/mirror

After the initial import you could exchange the url with the rewriteRoot url
and remove the later entry completly.

So have a look at --rewrite-root in the git svn manpage.
