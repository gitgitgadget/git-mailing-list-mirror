X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 01:39:14 +0100
Organization: At home
Message-ID: <ekg0c5$b43$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca>	<20061021130111.GL75501@over-yonder.net>	<453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 00:38:16 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 92
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32471>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goqz8-0006Im-8o for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933879AbWK1AiB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 19:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933880AbWK1AiB
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 19:38:01 -0500
Received: from main.gmane.org ([80.91.229.2]:8358 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933879AbWK1AiA (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 19:38:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Goqym-0006Cr-18 for git@vger.kernel.org; Tue, 28 Nov 2006 01:37:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 01:37:44 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 01:37:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Joseph Wakeling wrote:

> Hello all,
> 
> Following the very interesting debate about the differences between bzr
> and git, I thought it was about time I tried to learn properly about git
> and how to use it.  I've been using bzr for a good while now, although
> since I'm not a serious developer I only use it for simple purposes,
> keeping track of code I write on my own for academic projects.
> 
> So, a few questions about differences I don't understand...
> 
> First off a really dumb one: how do I identify myself to git, i.e. give
> it a name and email address?  Currently it uses my system identity,
> My Name <username@computer.(none)>.  I haven't found any equivalent of
> the bzr whoami command.

git repo-config user.name "Joseph Wakeling"
git repo-config user.email joseph.wakeling@webdrake.net

You might add --global option if you want your identity to be saved
in ~/.gitconfig file, and not per repository (one might want to use
different identities for different repositories).

"git repo-config --list" or "git var -l" to list all config. There is no
direct equivalent of "bzr whoami" (the equivalent would be:

  echo "$(git repo-config --get user.name) <$(git repo-config --get user.email)>"
 
> Now to more serious business.  One of the main operational differences I
> see as a new user is that bzr defaults to setting up branches in
> different locations, whereas git by default creates a repository where
> branches are different versions of the directory contents and switching
> branches *changes* the directory contents.  bzr branch seems to be
> closer to git-clone than git-branch (N.B. I have never used bzr repos so
> might not be making a fair comparison).

The rough equivalent of bzr repos would be a set of git repos which share
object database, either via symlink, or via GIT_OBJECT_DIRECTORY, or via
alternates mechanism.

But it is a fact that in bzr working area is associated with branch, while
in git it is associated with repository.

> With this in mind, is there any significance to the "master" branch (is
> it intended e.g. to indicate a git repository's "stable" version
> according to the owner?), or is this just a convenient default name?
> Could I delete or rename it?  Using bzr I would normally give the
> central branch(*) the name of the project.

Of course you can rename 'master' branch. But please remember that names
of branches in git are local matter. Well, except the fact that you usually
preserve them in a fashion.

But equivalent of giving central branch the name of the project would
be naming the directory with working area and .git directory the name
of project, or in the case of bare repository giving $GIT_DIR for a project
name project.git.

> Any other useful comments that can be made to a bzr user about working
> with this difference, positive or negative aspects of it?

By the way, 'master' is by no means special. It is default in a few cases
(init-db, clone), but that's all.
 
> Next question ... one of the reasons I started seriously thinking about
> git was that in the VCS comparison discussion, it was noted that git is
> a lot more flexible than bzr in terms of how it can track data (e.g. the
> git pickaxe command, although I understand that's not in the released
> version [1.4.4.1] yet?).  A frustration with bzr is that pulling or
> merging patches from another branch or repo requires them to share the
> same HEAD.  Is this a requirement in git or can I say, "Hey, I like that
> particular function in project XXX, I'm going to pull that individual
> bit of code and its development history into project YYY"?

In git repository can have unrelated branches. So you can fetch unrelated
repository into your repository, and merge/cherry-pick from there
if needed.

In defence of Bazaar-NG, you can probably get the same or very similar with
bzr repos. 

> Last off (for now, I'm sure I'll think of more): is there any easy (or
> difficult) way to effectively import version history from a bzr
> repository, and vice versa?

Try git-archimport, or Tailor tool.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

