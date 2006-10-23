From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 00:45:28 +0200
Organization: At home
Message-ID: <ehjgli$lft$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca> <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Tue Oct 24 00:45:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8Y4-0004RT-Az
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 00:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbWJWWpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWJWWpb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 18:45:31 -0400
Received: from main.gmane.org ([80.91.229.2]:14474 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752025AbWJWWpa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 18:45:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gc8Xs-0004Px-Jd
	for git@vger.kernel.org; Tue, 24 Oct 2006 00:45:24 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 00:45:24 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 00:45:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29896>

Matthew D. Fuller wrote:

> On Mon, Oct 23, 2006 at 10:29:53AM -0700 I heard the voice of
> Linus Torvalds, and lo! it spake thus:
>> 
>> I already briought this up once, and I suspect that the bzr people
>> simply DID NOT UNDERSTAND the question:
>> 
>>  - how do you do the git equivalent of "gitk --all"
> 
> I for one simply DO NOT UNDERSTAND the question, because I don't know
> what that is or what I'd be trying to accomplish by doing it.  The
> documentation helpfully tells me that it's something undocumented.

gitk(1)
=======

NAME
----
gitk - git repository browser

DESCRIPTION
-----------
Displays changes in a repository or a selected set of commits. This includes
visualizing the commit graph, showing information related to each commit, and
the files in the trees of each revision.

Historically, gitk was the first repository browser. It's written in tcl/tk
and started off in a separate repository but was later merged into the main
git repository.

OPTIONS
-------
To control which revisions to shown, the command takes options applicable to
the git-rev-list(1) command. This manual page describes only the most
frequently used options.

[...]
--all::

        Show all branches.


Which means that "gitk --all" means show whole DAG in graphical history viewer.

As in bzr there is no command (nor plugin) to clone whole repository,
I guess that the answer is that you can't do this. But perhaps 
I'm mistaken, and you can do this in bzr-gtk/bzrk...

>> For example, how long does it take to do an arbitrary "undo" (ie
>> forcing a branch to an earlier state) [...]
> 
> I don't understand the thrust of this, either.  As I understand the
> operation you're talking about, it doesn't have anything to do with a
> branch; you'd just be whipping the working tree around to different
> versions.  That should be O(diff) on any modern VCS.

For example if you decide to discard some changes completely, reverting
(this action in git is called 'rewind') branch to some previous revision.

And in git this operation is O(1), not O(diff).

BTW. The following question IIRC remained unanswered: can you easily
in bzr create branch off arbitrary revision (for example deciding that
stable branch should start two revisions back in history from development
branch)?

>> and yes, performance does matter.
> 
> I agree, and I currently find a number of places bzr doesn't hit the
> level of performance I think it should.  I'm not convinced, however,
> that any notable proportion of that has to do with the abstract model
> behind it.  And insofar as it has to do with the physical storage
> model, that can easily be (and I'm confident will be, considering it's
> a focus) ameliorated with later repository formats.

Some of physical storage models needs specific abstract model. I think
that git storage model is in this class.

>> The whole confusing between "bzr pull" and "bzr merge" is another
>> _technical_ sign of why branch-local revision numbers are a mistake. 
> 
> I consider it a _technical_ sign of a way of thinking about branches I
> prefer   8-}

Or _perhaps_ just the way of thinking about branches in the way you are
used to.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
