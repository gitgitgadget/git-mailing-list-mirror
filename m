From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Gitk cannot start in the latest version when using --all
Date: Tue, 29 Sep 2015 16:59:03 +0300
Message-ID: <20150929165903.893d668b86583dcf2085884b@domain007.com>
References: <560A94E7.9090506@notk.org>
	<20150929164951.cd5dea4ab0e866e4a0b74d6f@domain007.com>
	<560A9772.80503@notk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
To: Christophe COEVOET <stof@notk.org>
X-From: git-owner@vger.kernel.org Tue Sep 29 15:59:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgvRJ-0000nK-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 15:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965487AbbI2N7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2015 09:59:21 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:59952 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965201AbbI2N7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 09:59:07 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t8TDx3Gu005891;
	Tue, 29 Sep 2015 16:59:04 +0300
In-Reply-To: <560A9772.80503@notk.org>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278823>

On Tue, 29 Sep 2015 15:51:46 +0200
Christophe COEVOET <stof@notk.org> wrote:

> >> I'm installing git and gitk from the Ubuntu PPA maintained by the
> >> Git team. I received the Git 2.6 update today.
> >> Since this update, I'm unable to launch gitk with --all. I'm
> >> receiving the following error message:
> >>
> >> Error in startup script: bad menu entry index "=C3=89diter la vue.=
=2E."
> >>       while executing
> >> ".bar.view entryconf [mca "Edit view..."] -state normal"
> >>       invoked from within
> >> "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd
> >> ne {}} {
> >>       # create a view for the files/dirs specified on the command
> >>       # line
> >>       se..."
> >>       (file "/usr/bin/gitk" line 12442)
[...]
> > Does it start if you run it via
> >
> > $ LANG=3DC gitk --all
> >
> > or
> >
> > $ LANG=3Den_US.UTF-8 gitk --all
> >
> > ?
> Yeah, both of these commands are working fine.

OK, so the problem is that some menu entry has the title "Edit view..."
which is for some reason not translated for your current locale,
and then some code tries to locate it using the original title
translated to French -- I fathom the command [mca] being called here
stands for "Message Catalog A-something" ;-)
