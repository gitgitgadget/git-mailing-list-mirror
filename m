From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fetch workflow improvements
Date: Sat, 9 Feb 2008 14:00:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091357480.11591@racer.site>
References: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com> <alpine.LSU.1.00.0802091318080.11591@racer.site> <20080209132745.GA13997@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 15:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNqGT-0006F1-0T
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 15:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbYBIOAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 09:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756293AbYBIOAN
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 09:00:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:59278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758375AbYBIOAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 09:00:09 -0500
Received: (qmail invoked by alias); 09 Feb 2008 14:00:07 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp044) with SMTP; 09 Feb 2008 15:00:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DNTUNMpRDQdn5wc8hhoH8nZ/CYhdaq9y2Lv99az
	Q6EmPfQ0x/bdfP
X-X-Sender: gene099@racer.site
In-Reply-To: <20080209132745.GA13997@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73229>

Hi,

On Sat, 9 Feb 2008, Mike Hommey wrote:

> On Sat, Feb 09, 2008 at 01:20:29PM +0000, Johannes Schindelin wrote:
> 
> > $ git remote update
> 
> BTW, is the following normal?
> 
> $ git remote update origin
> Remote group origin does not exists.
> 
> (there *is* an origin remote)

Straight from the man page:

-- snip --
'update'::

Fetch updates for a named set of remotes in the repository as defined by
remotes.<group>.  If a named group is not specified on the command line,
the configuration parameter remotes.default will get used; if
remotes.default is not defined, all remotes which do not have the
configuration parameter remote.<name>.skipDefaultUpdate set to true will
be updated.  (See linkgit:git-config[1]).
-- snap --

To spare you the hassle from looking up the relevant section in 
git-config.1:

-- snip --
remotes.<group>::
        The list of remotes which are fetched by "git remote update
        <group>".  See linkgit:git-remote[1].
-- snap --

So if you add a group to your config file, like

	[remotes]
		origin = origin kernelorg repoorcz

your

	$ git remote update origin

will succeed.

Hth,
Dscho
