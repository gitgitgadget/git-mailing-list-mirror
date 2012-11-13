From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: checkout from neighbour branch  undeletes a path?
Date: Tue, 13 Nov 2012 22:34:00 +0400
Organization: '
Message-ID: <20121113183400.GE6561@external.screwed.box>
References: <20121113152341.GC6561@external.screwed.box>
 <7v8va5fo7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Peter Vereshagin <peter@vereshagin.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:34:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYLJk-0002X7-52
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab2KMSeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 13:34:22 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:61455 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005Ab2KMSeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:34:21 -0500
Received: from localhost (SIPB-TOR.MIT.EDU [18.187.1.68])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 8D0C25B07;
	Tue, 13 Nov 2012 22:34:17 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <7v8va5fo7g.fsf@alter.siamese.dyndns.org>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209654>

Hello.

2012/11/13 08:43:31 -0800 Junio C Hamano <gitster@pobox.com> => To Peter Vereshagin :
JCH> Peter Vereshagin <peter@vereshagin.org> writes:
JCH> 
JCH> > Am wondering if 'checkout branch path' undeletes the files?
JCH> 
JCH> "git checkout branch path" (by the way, "branch" does not have to be
JCH> a branch name; any commit object name would do, like "git checkout
JCH> HEAD^^ hello.c") is a way to check out named path(s) out of the
JCH> named commit.
JCH> 
JCH> If the commit "branch" has "path" in it, its contents are checked
JCH> out to "path" in your current working tree (and the entry in the
JCH> index updated to match it).
JCH> 
JCH> If you happen to have removed "path" in your current working tree
JCH> before running that command, it might look as if there is some
JCH> undelete going on, but that is a wrong way to look at things.  The
JCH> version of "path" in the "branch" may or may not be similar to what
JCH> you have removed earlier.
JCH> 


Hello.

I solved my problem by mean of 'git rm' instead of 'rm'.

I knew what you said here. Shortly, the difference for my case was:

 - I check out the pathdir from the commit in which the pathdir/file00 was
   already removed.

 - The current branch 'branch01' has no idea the file00 was removed. But I
   removed file00 and this is what 'branch01' assumes when I commit n ext time.

But git assumes I need 'file00' although it doesn't exist in the commit I
checkout path from. It doesn't exist by itself before I checkout that path
neither.

How can I know which one of the 'file00' versions is being checked out: the one
that did exist in the 'branch00' (the where I checkout path from) before I
removed it or the one existing in HEAD but not in the work-tree? And why this
and not that?

If it is the one that exists in a current branch but was deleted from trhe
work-tree [d4f7c70] than why it is being checked out not from the commit
supplied as an argument to git?

If it is the one that existed [c3e78ff] before the commit I checkout path from
than why it is being checked out while it doesn't exist in that commit already?

Thank you.

--
Peter Vereshagin <peter@vereshagin.org> (http://vereshagin.org) pgp: A0E26627 
