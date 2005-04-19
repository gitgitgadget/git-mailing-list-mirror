From: Steven Cole <elenstev@mesatop.com>
Subject: [RFC] Another way to provide help details. (was Re: [PATCH] Add help details to git help command.)
Date: Mon, 18 Apr 2005 19:40:54 -0600
Message-ID: <200504181940.54453.elenstev@mesatop.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <4263E782.6040608@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 03:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhjT-0001E0-FE
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDSBo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDSBo5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:44:57 -0400
Received: from nacho.zianet.com ([216.234.192.105]:26376 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261260AbVDSBow
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 21:44:52 -0400
Received: (qmail 79523 invoked from network); 19 Apr 2005 01:44:50 -0000
Received: from 216-31-65-3.zianet.com (216.31.65.3)
  by 0 with SMTP; 19 Apr 2005 01:44:50 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
In-Reply-To: <4263E782.6040608@mesatop.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 18 April 2005 10:59 am, Steven Cole wrote:
> Petr Baudis wrote:
> > Dear diary, on Mon, Apr 18, 2005 at 06:42:26AM CEST, I got a letter
> > where Steven Cole <elenstev@mesatop.com> told me that...
> [snippage]
> > 
> >>This patch will provide the comment lines in the shell script associated
> >>with the command, cleaned up a bit for presentation.
> >>
> >>BUGS: This will also print any comments in the entire file, which may
> >>not be desired.  If a command name and shell script filename
> >>do not follow the usual convention, this won't work, e.g. ci for commit.
> > 
> > 
> > Hey, those BUGS are the only slightly non-trivial thing on the whole
> > thing! I could do this patch myself... ;-) Also, you don't want to print
> > the first newline and the Copyright notices.

Here is perhaps a better way to provide detailed help for each
git command.  A command.help file for each command can be
written in the style of a man page.

The modfication to the main git script will be trivial. 
Here are the two commands I've done so far.

What do folks think about this approach?

Steven

[steven@spc git-pasky]$ ./git help add
NAME
        add - Add new file or files to a GIT repository.

SYNOPSIS
        add FILE...

DESCRIPTION
        Takes a list of file names at the command line, and schedules them
        for addition to the GIT repository at the next commit.

AUTHOR
        Written by Petr Baudis.

REPORTING BUGS
        Report bugs to <git@vger.kernel.org>

COPYRIGHT
        Copyright (c) Petr Baudis, 2005

BUGS
        Those files are omitted from show-diff output!

SEE ALSO
        The source code for this command is gitadd.sh.

[steven@spc git-pasky]$ ./git help addremote
NAME
        addremote -  Add new "remote" to the GIT repository.

SYNOPSIS
        addremote RNAME RSYNC_URL

DESCRIPTION
        Takes the remote's name and rsync URL.

        After you add a remote, you can "git pull" it whenever you want
        and it will keep your dircache in sync with it. Its latest commit
        is accessible as .git/heads/remotename (or - more conveniently -
        as $(commit-id remotename)). For example, to make a diff between
        Linus (after you added him) and your current tree, do

        git pull linus
        git diff $(commit-id linus)

AUTHOR
        Written by Petr Baudis.

REPORTING BUGS
        Report bugs to <git@vger.kernel.org>

COPYRIGHT
        Copyright (c) Petr Baudis, 2005

TODO
        gitdiff.sh et al should accept remote names as ids.

SEE ALSO
        The source code for this command is gitaddremote.sh.
