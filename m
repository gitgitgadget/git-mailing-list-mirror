From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
 Monotone)
Date: Thu, 31 Jul 2008 16:57:24 -0400
Message-ID: <BLU0-SMTP273E4683B41DB7E44122F0AE7C0@phx.gbl>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
	<alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
	<63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	<sverre@rabbelier.nl>, "Git Mailinglist" <git@vger.kernel.org>
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:00:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfFe-0001Dz-RJ
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYGaU6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbYGaU6v
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:58:51 -0400
Received: from blu0-omc3-s36.blu0.hotmail.com ([65.55.116.111]:22913 "EHLO
	blu0-omc3-s36.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753513AbYGaU6u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 16:58:50 -0400
Received: from BLU0-SMTP27 ([65.55.116.72]) by blu0-omc3-s36.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 31 Jul 2008 13:58:49 -0700
X-Originating-IP: [74.14.67.222]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.14.67.222]) by BLU0-SMTP27.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 31 Jul 2008 13:58:48 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1KOgA8-00079h-H2; Thu, 31 Jul 2008 17:58:20 -0400
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 31 Jul 2008 20:58:49.0024 (UTC) FILETIME=[3AD83400:01C8F350]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90989>

On Thu, 31 Jul 2008 14:48:21 -0500
"Craig L. Ching" <cching@mqsoftware.com> wrote:

> I have a question about this.  I asked this awhile back and didn't
> really get any satisfactory answers except to use git-new-workdir, which
> makes git behave a lot like monotone.  In our workflow, we do create
> branches for nearly everything, but we do find that we have a need to
> keep the build artifacts of those branches isolated from each other
> because rebuilding is expensive.  IOW, we have this sort of workflow:

Is there a problem using git-new-workdir?  It sounds like it does
exactly what you want.

> We find ourselves constantly having to shift gears and work on other
> things in the middle of whatever it is we're currently working on.  For
> instance, in the scenario above, A might be branch that contains a
> feature going into our next release.  B might be a bugfix and takes
> priority over A, so you have to leave A as-is and start work on B.  When
> I come back to work on A, I have to rebuild A to continue working, and
> that's just too expensive for us.  So we use the monotone-like
> new-workdir which allows us to save those build artifacts.
> 
> So, that said, I ask again, am I missing something?  Is there a better
> way to do this?  How do the kernel developers do this, surely they're
> switching branches back and forth having to build in-between?

A decent build system will only compile the source files that actually
changed when switching branches.  Couple that with a compiler cache
(such as ccache) and switching between branches in the kernel or git
project usually isn't prohibitively time consuming.

Sean
