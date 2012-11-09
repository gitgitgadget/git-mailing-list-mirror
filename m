From: Unknown <unknown@unknown.invalid>
Subject: Help requested - trying to build a tool doing whole-tree commits
Date: Fri,  9 Nov 2012 13:20:24 -0500 (EST)
Message-ID: <20121109182024.81074BC66D4@golux>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 21:47:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWvUV-0005gg-E3
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 21:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab2KIUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 15:47:38 -0500
Received: from adsl-76-243-231-121.dsl.chcgil.sbcglobal.net ([76.243.231.121]:1727
	"EHLO golux" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751514Ab2KIUrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 15:47:37 -0500
X-Greylist: delayed 8830 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2012 15:47:37 EST
Received: by golux (Postfix, from userid 1000)
	id 81074BC66D4; Fri,  9 Nov 2012 13:20:24 -0500 (EST)
From: esr@golux (Eric S. Raymond)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209248>

(Apologies if this arrives twice. I'm on the road, with somewhat flaky email.)

Because of my work on reposurgeon, I am sometimes asked to produce git
repositories for very old projects that not only are still using CVS
but have ancient releases not in the CVS repository, preserved only
as tarballs.  I have such a request currently pending from the
robotfindskitten project.

To automate this process, I am trying to write a tool that will take a
sequence of file trees and synthetic change comments in one end and
emit a git repository composing them into a DAG out the other. The
working name for this tool is 'gitpacker'.

I've already written the unpacking operation (git repo to tree
sequence plus log). This morning I discovered that git-commit
won't do quite what I need for the packing operation.
I'm requesting help.

I need a command or command sequence that will commit an entire file
tree to a repository...

(a) Allowing me to specify committer and author metadata, and

(b) deleting paths not present in the previous commit on the current
branch, and

(c) allowing me to specify merge links from other previous commits.

git commit -a passes (a) and (b) but not (c).

Advice on how to accomplish this is requested

Advice on a better name for the tool is also requested, as I'm
not happy with the way my use of 'pack' collides with existing
git use of the same verb.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

.. a government and its agents are under no general duty to 
provide public services, such as police protection, to any 
particular individual citizen...
        -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
