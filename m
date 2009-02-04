From: Jesse van den Kieboom <jesse@icecrew.nl>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 04 Feb 2009 15:33:45 +0100
Message-ID: <1233758025.7594.23.camel@wren>
References: <1233432317.26364.5.camel@wren>
	 <4989A63B.4030103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUisW-0002uR-8D
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbZBDOf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbZBDOfz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:35:55 -0500
Received: from novowork.com ([87.230.85.62]:58149 "EHLO novowork.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbZBDOfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:35:54 -0500
Received: from [128.178.246.242] (ls-in-242.epfl.ch [128.178.246.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by novowork.com (Postfix) with ESMTPSA id 104B3367055E;
	Wed,  4 Feb 2009 15:33:48 +0100 (CET)
In-Reply-To: <4989A63B.4030103@drmicha.warpmail.net>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108367>

Op woensdag 04-02-2009 om 15:29 uur [tijdzone +0100], schreef Michael J
Gruber:
> Jesse van den Kieboom venit, vidit, dixit 31.01.2009 21:05:
> > Hi,
> > 
> > I have been developing a gui application for git for gtk+/GNOME based on
> > GitX (which in turn is based on gitk). I feel that it's reaching the
> > point where it might potentially be useful for other people to use. It
> > currently features:
> > 
> > - Loading large repositories very fast
> > - Show/browse repository history
> > - Show highlighted revision diff
> > - Browse file tree of a revision and export by drag and drop
> > - Search in the revision history on subject, author or hash
> > - Switch between history view of branches easily
> > - Commit view providing per hunk stage/unstage and commit
> > 
> > The project is currently hosted on github:
> > http://github.com/jessevdk/gitg
> > 
> > clone: git://github.com/jessevdk/gitg.git
> > 
> > Please let me know what you think,
> 
> OK, played with it, looks nice. Some feedback:
> 
> Bug:?
> After unstaged a staged file it does not reappear under "unstaged". It
> appears nowhere.

Hmm this _should_ happen, if it doesn't it's certainly a bug.

> 
> Build:
> gitg can't run from the build dir, it needs to be installed.
> Reconfiguring with different --prefix does not rebuild (one needs to
> make clean manually).

This is true, I got a patch to fix this, but I'm not sure it should go
in (e.g. read data files from current working directory). It's not
common to be able to run C/gtk+ apps from the build directory, you
should install them in a local prefix.

> Features:
> Displaying the subject after the parent shas etc would be nice.
> Maybe forward/back buttons for taking you forward/back in your *browsing
> history*? Say, you click on a parent, and then you want to get back.

Showing the parent subject should be fairly easy to fix, I'll see if I
can get that in. I have thought about a history-history, but I haven't
felt the need to use it yet (also I don't think GitX has this), but it
might be worth implementing.

> Can one stage hunks somehow?

Yes, you can click on the hunk header @@...@@ when viewing the diff in
the commit view. You can also rightclick on this header and revert a
hunk (or stage/unstage it from the context menu).

> Cheers,
> Michael
> 
-- 
Jesse van den Kieboom

Personal: http://www.icecrew.nl
Professional: http://www.novowork.com
