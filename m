From: Jesse van den Kieboom <jesse@icecrew.nl>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 04 Feb 2009 15:46:08 +0100
Message-ID: <1233758768.7594.27.camel@wren>
References: <1233432317.26364.5.camel@wren>
	 <4989A63B.4030103@drmicha.warpmail.net> <1233758025.7594.23.camel@wren>
	 <4989A8E7.6080109@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUj2r-00076w-Op
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZBDOqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZBDOqj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:46:39 -0500
Received: from novowork.com ([87.230.85.62]:59032 "EHLO novowork.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbZBDOqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:46:39 -0500
Received: from [128.178.246.242] (ls-in-242.epfl.ch [128.178.246.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by novowork.com (Postfix) with ESMTPSA id 9FC853670068;
	Wed,  4 Feb 2009 15:46:09 +0100 (CET)
In-Reply-To: <4989A8E7.6080109@drmicha.warpmail.net>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108370>

Op woensdag 04-02-2009 om 15:40 uur [tijdzone +0100], schreef Michael J
Gruber:
> Jesse van den Kieboom venit, vidit, dixit 04.02.2009 15:33:
> > Op woensdag 04-02-2009 om 15:29 uur [tijdzone +0100], schreef Michael J
> > Gruber:
> >> Jesse van den Kieboom venit, vidit, dixit 31.01.2009 21:05:
> >>> Hi,
> >>>
> >>> I have been developing a gui application for git for gtk+/GNOME based on
> >>> GitX (which in turn is based on gitk). I feel that it's reaching the
> >>> point where it might potentially be useful for other people to use. It
> >>> currently features:
> >>>
> >>> - Loading large repositories very fast
> >>> - Show/browse repository history
> >>> - Show highlighted revision diff
> >>> - Browse file tree of a revision and export by drag and drop
> >>> - Search in the revision history on subject, author or hash
> >>> - Switch between history view of branches easily
> >>> - Commit view providing per hunk stage/unstage and commit
> >>>
> >>> The project is currently hosted on github:
> >>> http://github.com/jessevdk/gitg
> >>>
> >>> clone: git://github.com/jessevdk/gitg.git
> >>>
> >>> Please let me know what you think,
> >> OK, played with it, looks nice. Some feedback:
> >>
> >> Bug:?
> >> After unstaged a staged file it does not reappear under "unstaged". It
> >> appears nowhere.
> > 
> > Hmm this _should_ happen, if it doesn't it's certainly a bug.
> 
> I just compared with staging/reverting the single hunk I had in there,
> that works perfectly. The bug occurs only when unstaging from the list
> of staged files.
> 
> >> Build:
> >> gitg can't run from the build dir, it needs to be installed.
> >> Reconfiguring with different --prefix does not rebuild (one needs to
> >> make clean manually).
> > 
> > This is true, I got a patch to fix this, but I'm not sure it should go
> > in (e.g. read data files from current working directory). It's not
> > common to be able to run C/gtk+ apps from the build directory, you
> > should install them in a local prefix.
> 
> Sure, but just to try it out? Imagine me poor soul, going through all
> these GUIs and cloning, running
> autogen.sh/qmake-qt4/configure/make/setup.py depending on the tk, and
> finding I have to install in order to try it out (not to mention
> dependencies)? ;)

Yeah I know, it's a hassle. But fixing this would involve quite some
hacks in the code (it's not just the ui xml files, also icons and other
installed data) to find this data. Unfortunately, autotools is not
really friendly in this way. It might be possible to build binaries
which have local resources (like OS X bundles) so it can be tried out
without installing, but I'm not sure it's worth the effort.

> >> Can one stage hunks somehow?
> > 
> > Yes, you can click on the hunk header @@...@@ when viewing the diff in
> > the commit view. You can also rightclick on this header and revert a
> > hunk (or stage/unstage it from the context menu).
> 
> Uh, thanks, works like a charm. I had tried selecting and right-clicking
> the hunk itself...
> 
> Cheers,
> Michael
> 
-- 
Jesse van den Kieboom

Personal: http://www.icecrew.nl
Professional: http://www.novowork.com
