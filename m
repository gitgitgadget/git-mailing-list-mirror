From: =?ISO-8859-1?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
Subject: git-bugzilla
Date: Sun, 16 Nov 2008 22:00:26 +0100
Message-ID: <492089EA.60205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 22:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1oks-0004OD-Lv
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbYKPVAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYKPVAj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:00:39 -0500
Received: from www.multitel.be ([193.190.194.194]:49541 "EHLO smtp.multitel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbYKPVAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:00:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.multitel.be (Postfix) with ESMTP id 99D434E81C9
	for <git@vger.kernel.org>; Sun, 16 Nov 2008 22:00:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pop.multitel.be.multitel.be
Received: from smtp.multitel.be ([127.0.0.1])
	by localhost (pop.multitel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZe9iHjF6pEe for <git@vger.kernel.org>;
	Sun, 16 Nov 2008 22:00:35 +0100 (CET)
Received: from [192.168.1.138] (unknown [91.86.81.88])
	by smtp.multitel.be (Postfix) with ESMTP id 466724E80DF
	for <git@vger.kernel.org>; Sun, 16 Nov 2008 22:00:35 +0100 (CET)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101158>

Hi folks,

Here is a chunk of code I wrote a few time ago, to post patches to 
bugzilla, modelled mostly after git-format-patch/git-send-email.

You can find it there:
http://code.istique.net/?p=git-bugzilla.git

It is written in perl and requires WWW::Mechanize.

Hope you like it.


Here is an excerpt of the man page:

NAME
----
git-send-bugzilla - Attach patches to a bugzilla bug


SYNOPSIS
--------
'git-send-bugzilla' [OPTIONS] (--dry-run | <bugid>)
                     <since>[..<until>]

DESCRIPTION
-----------

Attach each commit between <since> and <until> to the bug <bugid>
on GNOME's bugzilla.
If ..<until> is not specified, the head of the current working
tree is implied.

If -n (or bugzilla.numbered in the repository configuration) is
specified, instead of "[PATCH] Subject", the first line is
formatted as "[n/m] Subject".

OPTIONS
-------
-b|--url <url>::
         The Bugzilla URL.

-u|--username <username>::
         Your Bugzilla user name.

-p|--password <password>::
         Your Bugzilla password.

-s|--squash::
         Send all the selected commits as a single patch.

-n|--numbered::
         Prefix attachment names with [n/m].

--start-number <n>::
         Start numbering the patches at <n> instead of 1.

--dry-run::
         Don't do anything for real. If you use this option you
         shouldn't specify a bug id.

EXAMPLES
--------
git-send-bugzilla -n 12345 master
         Extract all commits which are in the current branch but
         not in the 'master' branch. Each commit will be attached as
         a single patch to the bug #12345
