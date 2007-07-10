From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn and renames
Date: Tue, 10 Jul 2007 15:20:06 +0200
Message-ID: <86fy3wpf95.fsf@lola.quinscape.zz>
References: <46938594.2010607@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 15:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8FeP-0004rF-NY
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbXGJNUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXGJNUW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:20:22 -0400
Received: from main.gmane.org ([80.91.229.2]:38196 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbXGJNUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:20:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8FdV-0005wx-Tj
	for git@vger.kernel.org; Tue, 10 Jul 2007 15:20:14 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 15:20:13 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 15:20:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:tttS2rAY1x7Ir7ovoo0PD5O9SdQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52063>

Rogan Dawes <lists@dawes.za.net> writes:

> However, when I try to push this change to the Google repo, git-svn
> dies with the following error:
>
> $ git svn dcommit
> RA layer request failed: PROPFIND request failed on '/svn/trunk/
> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
> PROPFIND of '/svn/trunk/
> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
> 400 Bad Request (https://webgoat.googlecode.com) at
> /home/rdawes/bin/git-svn line 400
>
> [Yes, those paths have a space in them, however this does not seem to
> have prevented me from committing the previous 20 or so changes.]
>
> I noted the following in the git-svn documentation, with regards to
> handling renames. However, I am not renaming a directory, only a
> couple of files.

> ---- quote ----

[...]
>
> Renamed and copied directories are not detected by git and hence not
> tracked when committing to SVN.  I do not plan on adding support for
> this as it's quite difficult and time-consuming to get working for all
> the possible corner cases (git doesn't do it, either).  Committing
> renamed and copied files are fully supported if they're similar enough
> for git to detect them.

> Any ideas?

  dcommit          Commit several diffs to merge with upstream
                     --quiet, -q 
                     --fetch-all, --all 
                     --no-auth-cache 
                     --no-rebase 
                     --no-checkout 
                     --rmdir 
                     --dry-run, -n 
                     --find-copies-harder 
                     --follow-parent, --follow! 
                     --authors-file, -A <arg>
                     --copy-similarity, -C <num>
                     --username <arg>
                     --repack-flags, --repack-args, --repack-opts <arg>
                     --repack <num>
                     --verbose, -v 
                     --edit, -e 
                     --log-window-size <num>
                     --config-dir <arg>
                     -l <num>
                     --merge, -m, -M 
                     --strategy, -s <arg>


Try playing with the --copy-similarity and --find-copies-harder flags.

-- 
David Kastrup
