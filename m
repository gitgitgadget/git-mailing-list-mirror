X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Linus Torvalds <torvalds@osdl.org>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: git and bzr
Date: Mon, 27 Nov 2006 18:57:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca>
	<20061021130111.GL75501@over-yonder.net>
	<453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	<456B7C6A.80104@webdrake.net>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Trace: sea.gmane.org 1164682674 4264 80.91.229.2 (28 Nov 2006 02:57:54 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Tue, 28 Nov 2006 02:57:54 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Tue Nov 28 03:57:52 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GotAE-0001WO-Rv
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 28 Nov 2006 03:57:43 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GotA5-0006Hs-2L; Tue, 28 Nov 2006 02:57:33 +0000
Received: from smtp.osdl.org ([65.172.181.25])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1Got9z-0006Hh-TQ
	for bazaar-ng@lists.canonical.com; Tue, 28 Nov 2006 02:57:28 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAS2v4ix002648
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Nov 2006 18:57:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAS2v3cf024571;
	Mon, 27 Nov 2006 18:57:04 -0800
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
In-Reply-To: <456B7C6A.80104@webdrake.net>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:19745 gmane.comp.version-control.git:32482
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32482>
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Nov 2006, Joseph Wakeling wrote:
>
> First off a really dumb one: how do I identify myself to git, i.e. give
> it a name and email address?  Currently it uses my system identity,
> My Name <username@computer.(none)>.  I haven't found any equivalent of
> the bzr whoami command.

Depending on whether you like editing config files by hand or not, you 
would either just edit your ~/.gitconfig file and add a section like:

	[user]
		name = My Name Goes Here
		email = myemail@work.com

or you would use "git repo-config" to do it for you. Personally, I find it 
easier to just edit the .gitconfig file directly, since the config file 
syntax is actually rather pleasant, but if you want to do it with a git 
command, you'd do

	git repo-config --global user.name "Joseph Wakeling"
	git repo-config --global user.email joseph.wakeling@webdrake.net

(where the "--global" just tells repo-config to use the user-global 
~/.gitconfig file - you can also do this on a per-repository basis in the 
repository .git/config file if you want to have different identities for 
different repositories).

> Now to more serious business.  One of the main operational differences I
> see as a new user is that bzr defaults to setting up branches in
> different locations, whereas git by default creates a repository where
> branches are different versions of the directory contents and switching
> branches *changes* the directory contents.  bzr branch seems to be
> closer to git-clone than git-branch (N.B. I have never used bzr repos so
> might not be making a fair comparison).

You can do either, it's almost purely a matter of taste.

Using a local branch and switching between them in place has some 
advantages once you get used to it: most notably you can trivially use git 
commands that work on data from different branches at the same time. So 
with that kind of setup it's very natural to do things like "show me 
everything that is in branch 'x', but _not_ in branch 'y'", and once you 
get used to that, you really appreaciate it.

But at the same time, if you want to actually keep several branches 
checked out at the same time, and prefer to work on them that way, just 
use "git clone" to create the other branch instead. It really is just a 
matter of taste.

I suspect that most people tend to end up using the "multiple branches in 
the same directory and switching between them" approach after a time, but 
that's really just an unsubstantiated feeling, and it certainly isn't 
something that git forces on you. 

> With this in mind, is there any significance to the "master" branch (is
> it intended e.g. to indicate a git repository's "stable" version
> according to the owner?), or is this just a convenient default name?
> Could I delete or rename it?  Using bzr I would normally give the
> central branch(*) the name of the project.

It's just a convenient default name, and it has no real meaning otherwise. 
Feel free to rename it any way you want (just make sure to edit HEAD to 
point to the new name is you rename it by hand).

> Any other useful comments that can be made to a bzr user about working
> with this difference, positive or negative aspects of it?

There should be no difference, although since everybody seems to use 
"master" by default, the documentation is probably geared towards it, and 
who knows, maybe you'll hit a bug that nobody else noticed just because 
everybody else had a "master" branch, and some silly script had it 
hardcoded.

> Next question ... one of the reasons I started seriously thinking about
> git was that in the VCS comparison discussion, it was noted that git is
> a lot more flexible than bzr in terms of how it can track data (e.g. the
> git pickaxe command, although I understand that's not in the released
> version [1.4.4.1] yet?).

pickaxe wasn't in the released version back when the discussions were 
raging, but it's there now. Except it's really called "git blame" these 
days (and "git annotate") since it's taken over both of those duties.

However...

> A frustration with bzr is that pulling or
> merging patches from another branch or repo requires them to share the
> same HEAD.  Is this a requirement in git or can I say, "Hey, I like that
> particular function in project XXX, I'm going to pull that individual
> bit of code and its development history into project YYY"?

... it's not _quite_ that smart. It will only look for sources to new 
functions from existing sources in the tree that preceded the commit that 
added the function, so it will _not_ see it coming from another branch or 
another project entirely.

So when you ask for code annotations (use the "-C" flag to see code moved 
across from other files), it will still limit itself to just a particular 
input set, and not go gallivating over all possible branches and projects 
you might have in your repository.

It wouldn't be theoretically impossible to do, but it would be 
prohibitively expensive (where do you draw the line for what to look at). 

So git won't do quite what you ask for.

> Last off (for now, I'm sure I'll think of more): is there any easy (or
> difficult) way to effectively import version history from a bzr
> repository, and vice versa?

There's a "archimport", but I assume bzr has long since broken 
compatibility with arch (and/or just extended things so much as to not be 
importable with that any more), regardless of any origin. But it might be 
a good starting point, at least.

			Linus



