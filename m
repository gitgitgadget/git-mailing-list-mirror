X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and bzr
Date: Mon, 27 Nov 2006 19:40:49 -0500
Message-ID: <20061127194049.8ac68b1c.seanlkml__10154.9762803645$1164674480$gmane$org@sympatico.ca>
References: <45357CC3.4040507@utoronto.ca>
	<20061021130111.GL75501@over-yonder.net>
	<453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	<456B7C6A.80104@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 00:41:20 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127194049.8ac68b1c.seanlkml@sympatico.ca>
In-Reply-To: <456B7C6A.80104@webdrake.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Nov 2006 00:40:52.0317 (UTC) FILETIME=[DB5660D0:01C71285]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32473>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gor25-0006zh-Dj for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934962AbWK1Akx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 19:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934989AbWK1Akx
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 19:40:53 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:36573 "EHLO
 BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S934962AbWK1Akw (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006
 19:40:52 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 27 Nov 2006 16:40:51 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Goq5g-0007Zg-DK; Mon, 27 Nov 2006 18:40:48 -0500
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006 01:01:46 +0100
Joseph Wakeling <joseph.wakeling@webdrake.net> wrote:

> First off a really dumb one: how do I identify myself to git, i.e. give
> it a name and email address?  Currently it uses my system identity,
> My Name <username@computer.(none)>.  I haven't found any equivalent of
> the bzr whoami command.

Assuming you have a recent version of git, then:

$ git repo-config --global user.email "you@email.com"
$ git repo-config --global user.name "Your Name"

Will setup a ~/.gitconfig in your home directory; these settings
will apply in any repo you use.  Drop the "--global" to set them
per repo.

> With this in mind, is there any significance to the "master" branch (is
> it intended e.g. to indicate a git repository's "stable" version
> according to the owner?), or is this just a convenient default name?
> Could I delete or rename it?  Using bzr I would normally give the
> central branch(*) the name of the project.

It's just a common convention and carries no special significance;
rename away!

> Any other useful comments that can be made to a bzr user about working
> with this difference, positive or negative aspects of it?

Don't be afraid to git-clone your local repo, especially with the -l
and -s options.  That will get you a separate repo/working directory
while not taking up much extra disk space (objects from your first
repo will be shared with the second).

Once you get comfortable with multiple branches in a single repo/
working directory, it often is much better than the alternatives.
But the above gives you the option to work either way.

> Next question ... one of the reasons I started seriously thinking about
> git was that in the VCS comparison discussion, it was noted that git is
> a lot more flexible than bzr in terms of how it can track data (e.g. the
> git pickaxe command, although I understand that's not in the released
> version [1.4.4.1] yet?).  A frustration with bzr is that pulling or
> merging patches from another branch or repo requires them to share the
> same HEAD.  Is this a requirement in git or can I say, "Hey, I like that
> particular function in project XXX, I'm going to pull that individual
> bit of code and its development history into project YYY"?

The Git cherry-pick command lets you grab specific commits from
other branches in your repo.  But cherry-pick works at the commit
level, there is no easy way to grab a single function for instance
and merge just its history into another branch.

However, you can merge an entire separate project into yours even
though they don't share a base commit.  This has been done several
times in the history of Git itself. For instance you can see two
separate "initial" commits in the Git repo with a command like
"gitk README gitk" which gives a graphical history of the "gitk"
and "README" files and shows each started life in a separate
initial commit.  Use "git show 5569b" to see Linus bragging on
this first separate-project-merge and give some more details.
 
> Last off (for now, I'm sure I'll think of more): is there any easy (or
> difficult) way to effectively import version history from a bzr
> repository, and vice versa?

Don't think a direct bridge between the two has been written yet.

Cheers,
