From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 11:18:01 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191115440.30505@racer.site>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>  <20080219063937.GB3819@glandium.org> <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 12:19:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRQUv-0004mI-En
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 12:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYBSLSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 06:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYBSLSR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 06:18:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:45264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752751AbYBSLSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 06:18:16 -0500
Received: (qmail invoked by alias); 19 Feb 2008 11:18:14 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp029) with SMTP; 19 Feb 2008 12:18:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190Wc57zf90yXG2pLBVv7ADbXRTFx0P6fhdPbJTG+
	Q+8DEXWqRiH+/p
X-X-Sender: gene099@racer.site
In-Reply-To: <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74394>

Hi,

On Mon, 18 Feb 2008, Anatoly Yakovenko wrote:

> > > *.*.*.*- foobar [18/Feb/2008:16:40:12 -0800] "PROPFIND /git/repo
> > > HTTP/1.1" 301 320
> >
> > Try adding a / at the end of the url you use for your repo.
> 
> ah cool, that was it.  The initial push seems to have worked,
> 
> $ git push -v upload master
> Pushing to http://aeyakovenko@myserver.com/git/repo/
> Getting pack list
> Fetching remote heads...
>   refs/
>   refs/tags/
>   refs/heads/
> 'refs/heads/master': up-to-date
> 
> 
> but i cant clone or just normally push and pull the repo.

That's not correct.  You can clone, push and pull the repo.

> $ git-pull
> fatal: 'origin': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly

Since you did not clone from anywhere, the remote "origin" is not set.  
You will have to do that yourself:

	git remote add -f origin http://aeyakovenko@myserver.com/git/repo/

> $ git-clone http://aeyakovenko@myserver.com/git/repo/ foobar
> Initialized empty Git repository in /home/aeyakovenko/projects/foobar/.git/
> cat: /home/aeyakovenko/projects/foobar/.git/refs/remotes/origin/master:
> No such file or directory
> /usr/bin/git-clone: line 450: cd:
> /home/aeyakovenko/projects/foobar/.git/refs/remotes/origin: No such
> file or directory
> fatal: : not a valid SHA1
> fatal: Not a valid object name HEAD

That smells like another "master"-less repository.  Why do people do that?  
Isn't it just _easier_ and more _hassle-free_ to just accept that the 
initial branch is called "master"?

Hth,
Dscho
