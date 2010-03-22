From: "P Fudd" <fink@ch.pkts.ca>
Subject: Bug - crash on large commit
Date: Mon, 22 Mar 2010 16:36:25 -0700
Message-ID: <310ba29b220a70e5624819e6ef80bff0.squirrel@www.pkts.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 01:04:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntrb8-00082V-8z
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 01:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab0CWADs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 20:03:48 -0400
Received: from www.sbn.ubc.ca ([142.103.124.7]:56588 "EHLO foster.nce.ubc.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab0CWADr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 20:03:47 -0400
X-Greylist: delayed 1637 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2010 20:03:47 EDT
Received: from foster.nce.ubc.ca (localhost [127.0.0.1])
	by foster.nce.ubc.ca (8.14.3/8.14.3) with ESMTP id o2MNaQvC006227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 22 Mar 2010 16:36:26 -0700
Received: (from apache@localhost)
	by foster.nce.ubc.ca (8.14.3/8.14.3/Submit) id o2MNaPtH006223;
	Mon, 22 Mar 2010 16:36:25 -0700
Received: from 137.82.128.93
        (SquirrelMail authenticated user chowes)
        by www.pkts.ca with HTTP;
        Mon, 22 Mar 2010 16:36:25 -0700
User-Agent: SquirrelMail/1.4.19-2.fc11
X-Priority: 3 (Normal)
Importance: Normal
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (foster.nce.ubc.ca [127.0.0.1]); Mon, 22 Mar 2010 16:36:26 -0700 (PDT)
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.3.0
X-Spam-Checker-Version: SpamAssassin 3.3.0 (2010-01-18) on foster.nce.ubc.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142978>

Hi...

I'm a new user, and thinking that git is better than sliced bread.  So,
today I had to set up a new computer (MacOSX), and thought: "hey, I could
put the whole system into git!"

Well, ok, technically yes, you can do that.  Go into the root directory,
type 'git init', then 'git add .', then 'git commit -a'.

Bug 1: git complained about a symbolic link to nowhere and halted...
several hours into the 'add'.  If I want to store a broken link, let me;
maybe warn me.

Bug 2: git died with an out-of-memory error on the commit:
------
# git commit -a
[master (root-commit) 62b52e2] The initial checkin of the whole hard disk.
 Committer: System Administrator <root@Mac-Pro.local>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

If the identity used for this commit is wrong, you can fix it with:

    git commit --amend --author='Your Name <you@example.com>'

git(4667) malloc: *** mmap(size=1964838912) failed (error code=12)
*** error: can't allocate region
*** set a breakpoint in malloc_error_break to debug
git(4667) malloc: *** mmap(size=1964838912) failed (error code=12)
*** error: can't allocate region
*** set a breakpoint in malloc_error_break to debug
fatal: Out of memory, malloc failed
[Mac-Pro:/] shadministrator# git version
git version 1.7.0.2
-----

Anyhoo, it's not really the right tool for the job, but Apple hasn't got a
package management system to speak of (yes, I know about bom files --
don't speak of it), and their filesystem loses bits now and then, so I
wanted the crypto checksums and the ability to spot and roll back changes.
 I suppose TimeMachine will have to do.

Thanks for a great program!
