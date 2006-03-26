From: Petr Baudis <pasky@ucw.cz>
Subject: Union diff
Date: Sun, 26 Mar 2006 12:21:00 +0200
Message-ID: <20060326102100.GF18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 26 12:21:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNSMm-0001e1-NG
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 12:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWCZKUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 05:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWCZKUw
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 05:20:52 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9382 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751240AbWCZKUv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 05:20:51 -0500
Received: (qmail 9026 invoked by uid 2001); 26 Mar 2006 12:21:00 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18033>

  Hello,

  sorry for possibly a silly question, but can I get a diff of a merge
commit with _union_ of changes against all the parents?

	$ git-diff-tree --abbrev -r -m --pretty=raw badfc383b

	diff-tree badfc38... (from 1ee6c84...)
	tree 29d81f18912328df4f4104e9b9cc355424ced04d
	parent 1ee6c84efda742eda8b4b200491341125d8d9639
	parent 453b160f03c8c6d450879482f617412c257e5889
	author Petr Baudis <pasky@suse.cz> 1143328578 +0100
	committer Petr Baudis <xpasky@machine.or.cz> 1143328578 +0100

	    Merge with v0.17

	:100755 100755 743c19f... b05900d... M	Documentation/make-cogito-asciidoc
	:100644 100644 5896df7... 6f06c35... M	cg-Xlib

	diff-tree badfc38... (from 453b160...)
	tree 29d81f18912328df4f4104e9b9cc355424ced04d
	parent 1ee6c84efda742eda8b4b200491341125d8d9639
	parent 453b160f03c8c6d450879482f617412c257e5889
	author Petr Baudis <pasky@suse.cz> 1143328578 +0100
	committer Petr Baudis <xpasky@machine.or.cz> 1143328578 +0100

	    Merge with v0.17

	:100644 100644 24ce0a4... d540853... M	TODO
	:100755 100755 6005083... f7efa9d... M	cg-log

  I would like something like:

	diff-tree badfc38... (from parents)
	tree 29d81f18912328df4f4104e9b9cc355424ced04d
	parent 1ee6c84efda742eda8b4b200491341125d8d9639
	parent 453b160f03c8c6d450879482f617412c257e5889
	author Petr Baudis <pasky@suse.cz> 1143328578 +0100
	committer Petr Baudis <xpasky@machine.or.cz> 1143328578 +0100

	    Merge with v0.17

	:100755 100755 743c19f... b05900d... M	Documentation/make-cogito-asciidoc
	:100644 100644 24ce0a4... d540853... M	TODO
	:100644 100644 5896df7... 6f06c35... M	cg-Xlib
	:100755 100755 6005083... f7efa9d... M	cg-log

  Now, the -c option documentation says:

	  It shows the differences from each of the parents to the merge
	result simultaneously, instead of showing pairwise diff between
	a parent and the result one at a time, which '-m' option output
	does.

  This sounds as exactly what I want. Well, the only problem is that the
same diff command as above with -c option added produces no diff at all,
just the header and commit messages. Did I misunderstand the -c
description and does it do something different?

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
