From: sf <sf@b-i-t.de>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Wed, 14 Jun 2006 11:37:40 +0200
Message-ID: <448FD8E4.9040208@b-i-t.de>
References: <87irn5ovn6.fsf@rho.meyering.net>	 <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>	 <1150224411.20536.79.camel@neko.keithp.com> <46a038f90606131555m7b1fa744g9770140c87598b7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 14 11:38:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqRpC-0004TE-I1
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 11:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWFNJiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 05:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWFNJiH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 05:38:07 -0400
Received: from main.gmane.org ([80.91.229.2]:50598 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932212AbWFNJiF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 05:38:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FqRoz-0004QB-Kc
	for git@vger.kernel.org; Wed, 14 Jun 2006 11:37:57 +0200
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 11:37:57 +0200
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 11:37:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <46a038f90606131555m7b1fa744g9770140c87598b7b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21837>

Martin Langhoff wrote:
...
> Yes, cvsps is relying on the wrong things. I am looking at parsecvs
> and the cvs2svn tool and wondering where to from here.
...
> I am starting to look at what I can do with cvs2svn to get the import
> into git. It seems to get very good patchsets, and it yields an easily
> readable DB. I'll either learn Python, or read the DB from Perl
> (probably from git-cvsimport).

SVN has a portable format called "dumpfile" (see
http://svn.collab.net/repos/svn/trunk/notes/fs_dumprestore.txt) which is
produced by "svnadmin dump ..." and "cvs2svn --dump-only ...".

Why not use it as input for importing into git?

Pros:
- "svnadmin dump" should be fast
- svn repositories can be tracked with "svnadmin dump" (just remember
the last imported revision and restart from there)
- cvs2svn seems to be very good at its job
- only one tool needed

Cons:
- Both svnadmin and cvs2svn only work on local repositories
- cvs2svn cannot be used for tracking

Regards
	Stephan
