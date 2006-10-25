X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 18:53:06 -0500
Message-ID: <20061025235306.GD17019@over-yonder.net>
References: <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org> <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> <20061024163458.GH17019@over-yonder.net> <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz> <20061025002713.GN17019@over-yonder.net> <Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 23:53:29 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30127>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcsYo-0005yM-Oj for gcvg-git@gmane.org; Thu, 26 Oct
 2006 01:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964836AbWJYXxL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 19:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWJYXxL
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 19:53:11 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:28385 "EHLO
 optimus.centralmiss.com") by vger.kernel.org with ESMTP id S964836AbWJYXxI
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 19:53:08 -0400
Received: from draco.over-yonder.net
 (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213]) (using TLSv1
 with cipher ADH-AES256-SHA (256/256 bits)) (No client certificate requested)
 by optimus.centralmiss.com (Postfix) with ESMTP id D084D2842A; Wed, 25 Oct
 2006 18:53:06 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100) id 4D82E61C52;
 Wed, 25 Oct 2006 18:53:06 -0500 (CDT)
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

On Wed, Oct 25, 2006 at 03:40:00PM -0700 I heard the voice of
David Lang, and lo! it spake thus:
> 
> I think we are talking past each other here.
> 
> what I think was said was
> 
> G 'one feature of git is that you can view arbatrary slices
> trivially'
> 
> B 'bzr can do this too, you just use branches to define the slices'

Ah.  This is more like "bzr [mostly] only does this now in terms of a
single branch (or some point back along it)".  The slices that go
between branches are very limited ('missing' gives you one view;
'branch:' and 'ancestor:' revision specifications give you another).
bzrk/'visualize' gives an interface similar to gitk, but also only in
the context of a single branch/head looking backward through its
previous tree AFAIK.  Any random DAG-slicing of what you have in the
revision store can be done, somebody would just have to write the code
for it.  Nothing about 'the workflow preserves parents' would make
that any harder than writing the code for git was.

Much of this is probably a result of the 'branch'-centric (rather than
'repository'-centric) view of the world; similarly to the fact that
branches are referred to by location (local ../otherbranch, or remote
http/sftp/etc) rather than by a name.  This is one of the bits of bzr
I'm personally somewhat ambivalent about.


> they now have threeB options

Those certainly aren't the only choices, but to stay OT:

> 3. pull from each other frequently to keep in sync.
> 
> this changes the topology to
> 
>    Master
>    /   \
>  dev1--dev2
> 
> if they do this with bzr then the revno's break, they each get extra
> commits showing up (so they can never show the same history).

These two are either/or, not and; either they pull (in which case
their old mainline is no longer meaningful), or they merge (in which
case they get the 'extra' merge commits).


> in git this is a non-issue, they can pull back and forth and the
> only new history to show up will be changes.

In git, this is a non-issue because you don't get to CHOOSE which way
to work.  You always (if you can) pull and obliterate your local
mainline.  In bzr, it's only an 'issue' because you CAN choose, and
CAN maintain your local mainline.  You CAN choose, right now, to do a
git and pull back and forth and only new history show up as changed by
creating a 'bzr-pull' shell script that does a 'bzr pull || bzr merge'
(though you'd be a lot better off adding a '--fast-forward-if-you-can'
option to merge and aliasing that over).

More basically, though, I don't think that "histories become exactly
equivalent" is a necessary pass-word to enter the Hallowed City of
Truely Distributed Development.  And I certainly see no reason to
believe we'll agree on it this time any more than We (in broad) have
the last 6 times it came up in the thread.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
