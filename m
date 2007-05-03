From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [tools-dev] Re: Git benchmarks at OpenOffice.org wiki
Date: Thu, 3 May 2007 13:51:40 +0200
Message-ID: <200705031351.40548.kendy@suse.cz>
References: <200705012346.14997.jnareb@gmail.com> <200705021624.25560.kendy@suse.cz> <200705030130.44018.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: dev@tools.openoffice.org
X-From: git-owner@vger.kernel.org Thu May 03 13:51:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjZqe-0003Ft-CM
	for gcvg-git@gmane.org; Thu, 03 May 2007 13:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161848AbXECLvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 07:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161851AbXECLvo
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 07:51:44 -0400
Received: from styx.suse.cz ([82.119.242.94]:56446 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161848AbXECLvn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 07:51:43 -0400
Received: from one.suse.cz (one.suse.cz [10.20.1.79])
	by mail.suse.cz (SUSE LINUX ESMTP Mailer) with ESMTP id 42EF36280BD;
	Thu,  3 May 2007 13:51:41 +0200 (CEST)
User-Agent: KMail/1.9.1
In-Reply-To: <200705030130.44018.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46081>

Hi Jakub,

On Thursday 03 May 2007 01:30, Jakub Narebski wrote:

> >> What might help here is splitting repository into current (e.g. from
> >> OOo 2.0) and historical part,
> >
> > No, I don't want this ;-)
>
> I forgot to add there is possible to graft historical repository to the
> current work repository, resulting in full history available. For example
> Linux kernel repository has backported from BK historical repository, and
> there is grafts file which connect those two repositories.

Yes, grafting sounds really very promising! - I did not know about it.

> >> and / or using shallow clone.
>
> git-clone(1):
>
> --depth <depth>::
>         Create a 'shallow' clone with a history truncated to the
>         specified number of revs.  A shallow repository has
>         number of limitations (you cannot clone or fetch from
>         it, nor push from nor into it), but is adequate if you
>         want to only look at near the tip of a large project
>         with a long history, and would want to send in a fixes
>         as patches.
>
> It is possible that those limitations will be lifted in the future
> (if possible), so there is alternate possibility to reduce needed
> disk space for git checkout. But certainly this is not for everybody.

It's probably too tight limitation for regular developers; for random hackers 
contributing a patch or two it could be a choice, right.

> > We should better split the OOo sources; it's a process that already
> > started [UNO runtime environment vs. OOo without URE], and I proposed
> > some more changes already.
>
> In my opinion each submodule should be able to compile and test by
> itself. You can go X.Org route with splitting sources into modules...

Indeed, this is the case of URE - it is supposed to run by separately & be 
used even by other projects than OOo.

> or you can make use of the new submodules support (currently plumbing
> level, i.e. low level commands), aka. gitlinks.

And this would be interesting for the translations, I guess...

> The submodules support makes it possible to split sources into
> independent modules (parts), which can be developed independently,
> and which you can download (clone, fetch) or not, while making it
> possible to bind it all together into one superproject.
>
> See (somewhat not up to date) http://git.or.cz/gitwiki/SubprojectSupport
> page on git wiki.

... but will have a better look; thanks for the pointer!

> Subversion doesn't have bisect, does it?

>From what I know, it does not.

Thank you and others for all the input!

Last question: what is the status of the Win32 support?  I got a full clone 
using the Cygwin git 1.5.0 [it took 6hrs 20min on a Xen virtual machine; I 
have to try it with real hardware], MinGW version did not work for me too 
well :-(  Are there any other options?  Is 
http://git.or.cz/gitwiki/WindowsInstall up-to-date?

Regards,
Jan
