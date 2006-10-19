From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 11:01:03 -0500
Message-ID: <20061019160103.GZ75501@over-yonder.net>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org> <20061019091045.GV75501@over-yonder.net> <20061019112759.GA31066@diana.vm.bytemark.co.uk> <20061019114639.GD20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 18:03:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaaKY-0001Pf-DR
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 18:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946139AbWJSQBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 12:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946142AbWJSQBJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 12:01:09 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:40145 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1946139AbWJSQBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 12:01:08 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id D92F02842A;
	Thu, 19 Oct 2006 11:01:04 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id AC31C61C52; Thu, 19 Oct 2006 11:01:03 -0500 (CDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20061019114639.GD20017@pasky.or.cz>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29363>

On Thu, Oct 19, 2006 at 01:46:39PM +0200 I heard the voice of
Petr Baudis, and lo! it spake thus:
> 
> Does Bazaar support those?  (I can't really say it's a defect if it
> doesn't...)

By default, merge will refuse to do its thing if there are uncommitted
changes in the working tree, whether those changes are something
you've done, or the pending results of a previous merge.  A '--force'
arg to merge will make it go forward though, so yes, you can merge
multiple other branches in one merge if you want to.

Actually, I can kill 2 birds here.  Quick little bictopus merge:

% bzr log --show-ids
------------------------------------------------------------
revno: 2
revision-id: fullermd@over-yonder.net-20061019151856-c3b406b8bcdfb537
parent: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
parent: fullermd@over-yonder.net-20061019151800-2fe41e4949f5e237
parent: fullermd@over-yonder.net-20061019151807-3d7047e387edcad9
committer: Matthew Fuller <fullermd@over-yonder.net>
branch nick: a
timestamp: Thu 2006-10-19 10:18:56 -0500
message:
  merge
    ------------------------------------------------------------
    revno: 1.2.1
    merged: fullermd@over-yonder.net-20061019151800-2fe41e4949f5e237
    parent: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
    committer: Matthew Fuller <fullermd@over-yonder.net>
    branch nick: b
    timestamp: Thu 2006-10-19 10:18:00 -0500
    message:
      bar
    ------------------------------------------------------------
    revno: 1.1.1
    merged: fullermd@over-yonder.net-20061019151807-3d7047e387edcad9
    parent: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
    committer: Matthew Fuller <fullermd@over-yonder.net>
    committer: Matthew Fuller <fullermd@over-yonder.net>
    branch nick: c
    timestamp: Thu 2006-10-19 10:18:07 -0500
    message:
      baz
------------------------------------------------------------
revno: 1
revision-id: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
committer: Matthew Fuller <fullermd@over-yonder.net>
branch nick: a
timestamp: Thu 2006-10-19 10:14:37 -0500
message:
  Foo


(I'll refer to revids by the last segment)

Note that this also shows the "left-most" parent distinction.  The
"left-most" parent of revno 2 (c3b406b8bcdfb537) is revno 1
(5b99dff6ed1d76cd), because that's the last thing I did in THIS
branch.  That's my 'mainline'; the commits from branch b
(2fe41e4949f5e237) and c (3d7047e387edcad9) are then additional
parents of the merge at revno 2.

The graph for branch a now looks something like (calling the 3
original commits 'a', 'b', and 'c' and the merge rev 'D'):

  a-.
  |\ \
  | b c
  |/ /
  D-'


The 2fe41e4949f5e237 rev is on branch b's mainline forever, and it has
a single-digit revno (2 in this case) on branch b, but it's not on
mine in a.  Now, let's pretend we're branch b, and we want to pick up
from a.  Because a is a superset of b, we could pull ('fast-forward')
a.  If we do that, the graph in b will be identical to a (and so 'log'
will be too).  That, AIUI, is what you'd do in git.

In the bzr methodology we've been discussing, where you want to
maintain your branch's identity, you'd instead merge from a into b.
You've got two new revisions to pick up in doing so; the
3d7047e387edcad9 from branch c, and the merge rev c3b406b8bcdfb537;
you already have 2fe41e4949f5e237 on your mainline.  So, post-merge,
the log for b will look like (somewhat trimmed for space):


------------------------------------------------------------
revno: 3
revision-id: fullermd@over-yonder.net-20061019153827-78d6209cd0f5f2f7
parent: fullermd@over-yonder.net-20061019151800-2fe41e4949f5e237
parent: fullermd@over-yonder.net-20061019151856-c3b406b8bcdfb537
branch nick: b
    ------------------------------------------------------------
    revno: 1.1.1
    merged: fullermd@over-yonder.net-20061019151856-c3b406b8bcdfb537
    parent: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
    parent: fullermd@over-yonder.net-20061019151800-2fe41e4949f5e237
    parent: fullermd@over-yonder.net-20061019151807-3d7047e387edcad9
    branch nick: a
    ------------------------------------------------------------
    revno: 1.2.1
    merged: fullermd@over-yonder.net-20061019151807-3d7047e387edcad9
    parent: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
    branch nick: c
------------------------------------------------------------
revno: 2
revision-id: fullermd@over-yonder.net-20061019151800-2fe41e4949f5e237
parent: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
branch nick: b
------------------------------------------------------------
revno: 1
revision-id: fullermd@over-yonder.net-20061019151437-5b99dff6ed1d76cd
branch nick: a


The 2fe41e4949f5e237 which was originally on b's mainline is still on
the mainline at revno 2.  The graph in b now looks like (adding the
new 'E' merge commit)[0]:

  a-.
  |\ \
  b c |
  |\|/
  | D
  |/ 
  E


Now, the question of "is that merge commit E really necessary, when
you could just attach D to the end of the graph and create something
like:

  a-.
  |\ \
  b c |
  |/ /
  D-'

is perhaps a useful question (and one that there's obviously
disagreement on).  And it may be a fruitful one to discuss, if we're
not way off in the weeds already.  But, it's also not QUITE the same
question as "Is the left-vs-other path distinction meaningful and to
be preserved?"



[0] For reference at this point:
    a: 5b99dff6ed1d76cd
    b: 2fe41e4949f5e237
    c: 3d7047e387edcad9
    D: c3b406b8bcdfb537
    E: 78d6209cd0f5f2f7


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
