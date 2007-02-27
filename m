From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 13:44:43 +0100
Message-ID: <slrneu89tr.24s.siprbaum@xp.machine.xx>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 13:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1eo-0003vg-Gc
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbXB0Mlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbXB0Mlz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:41:55 -0500
Received: from main.gmane.org ([80.91.229.2]:44118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030215AbXB0Mly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:41:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HM1eI-0002zE-GZ
	for git@vger.kernel.org; Tue, 27 Feb 2007 13:41:42 +0100
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.24.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 13:41:42 +0100
Received: from siprbaum by magnum.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 13:41:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: magnum.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40721>

Theodore Ts'o <tytso@mit.edu> schrieb:
>
> So given a particular tree-ish and a pathname, I'd like get the contents
> of that particular file as of a particular revision.  i.e., the
> equivalent of:
>
> 	cvs -r v1.37 -p e2fsck/pass1.c
> or
> 	bk cat -r 2345 e2fsck/pass1.c
>
> The closest I've been able to come is to use
>
> 	git archive --format=zip v1.37 e2fsck/pass1.c | gunzip
>
> But that seems kinda silly.  
>
> git-checkout will only write the output to the working tree.
> git-cat-file and git-show only work on a object identifier (they are
> low-level plumbing commands).  
>
> So if it is a matter of we don't have an easy way to do this (as opposed
> to me being stupid or the git documentation just failing to mention it
> in the right places), what's the best way to add it?
>
> One easy way would be to add --format=raw to git-archive, but that might
> seem counter-intuitive to an average git user; they just want to see the
> output of a file at a particular point in time, which doesn't have much
> to do with archiving.   
>
> Should we add a new command like "git-cat"?   Should we add a -p option
> to the "git-checkout <treeish> <path>" form of git-checkout?
>
> I'm currently leaning towards the last; it would be pretty simple to
> enhance git-checkout so that a -p option would run "git archive
> --format=zip ...", even though that would be a pretty nasty hack, and it
> wouldn't be much harder to add --format=raw support to git-archive, but
> I still think that's not a intuitive place to find that particular
> functionality.
>
> 						- Ted

You you could do this with

	git show v1.5.0:Makefile

to show you the Makefile in revision v1.5.0.

-Peter
