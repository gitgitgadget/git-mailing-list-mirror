From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Initial push to remote repository
Date: Wed, 19 Sep 2007 14:25:58 +0200
Message-ID: <20070919122558.GA4777@xp.machine.xx>
References: <20070919113557.GA24674@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 14:26:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXyd9-0000Tl-9n
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 14:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbXISM0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 08:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXISM0D
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 08:26:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:46828 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751414AbXISM0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 08:26:01 -0400
Received: (qmail invoked by alias); 19 Sep 2007 12:25:59 -0000
Received: from p54AABFCD.dip0.t-ipconnect.de (EHLO localhost) [84.170.191.205]
  by mail.gmx.net (mp028) with SMTP; 19 Sep 2007 14:25:59 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+figoXYiKfxjw3G9Sr1qWpdtzYCZx4MumDCzjN7/
	SubA5Lg3zdHCDu
Content-Disposition: inline
In-Reply-To: <20070919113557.GA24674@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58705>

On Wed, Sep 19, 2007 at 01:35:57PM +0200, Thomas Glanzmann wrote:
> Hello,
> I used to publish my local work on a machine with all my git
> repositories using the following commands:
> 
> # Publish a local created repository to a remote repository.
> ssh 131.188.30.102 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/astro.git init-db
> git remote add origin 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/astro.git
> git push origin master:master
> echo >> .git/config <<EOF
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
> EOF
> git pull
> 
> But since my last update of git it doesn't seem to work that way anymore. Is
> there another way to do what I like to using the git way?
> 
>         (ad027088pc) [~] mkdir test_initial_push
>         (ad027088pc) [~] cd !$
>         (ad027088pc) [~/test_initial_push] touch a
>         (ad027088pc) [~/test_initial_push] git init
>         Initialized empty Git repository in .git/
>         (ad027088pc) [~/test_initial_push] git add a
>         (ad027088pc) [~/test_initial_push] git commit -m "whatever" a
>         Created initial commit 0d408ed: whatever
>         0 files changed, 0 insertions(+), 0 deletions(-)
>         create mode 100644 a
>         (reverse-i-search)`':
>         (ad027088pc) [~/test_initial_push] ssh 131.188.30.102 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/test_initial_push.git init-db
>         Initialized empty Git repository in /home/cip/adm/sithglan/work/repositories/private/test_initial_push.git/
>         (ad027088pc) [~/test_initial_push] git remote add origin 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/test_initial_push.git/
>         You have new mail in /home/adglth0/Maildir
>         (ad027088pc) [~/test_initial_push] git push origin master:master
>         error: dst refspec master does not match any existing ref on the remote and does not start with refs/.
>         fatal: The remote end hung up unexpectedly
>         error: failed to push to '131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/test_initial_push.git/'

Try to give it the full ref name and it should work, e.g.

	git push origin refs/heads/master:refs/heads/master

-siprbaum
