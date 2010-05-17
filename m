From: Eli Barzilay <eli@barzilay.org>
Subject: Checking out on a different+partial directory
Date: Mon, 17 May 2010 06:53:55 -0400
Message-ID: <19441.8259.634019.348195@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 12:54:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODxxS-0000Vj-32
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 12:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab0EQKx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 06:53:57 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:50959 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092Ab0EQKx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 06:53:56 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1ODxxL-0001SJ-Kq
	for git@vger.kernel.org; Mon, 17 May 2010 06:53:55 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147222>

Say that I have a repository at /some/dir, and a tree that contains
most of its files at /another/dir (the second is a build directory,
made with `git archive', so some files removed due to export-ignore
attributes and some built files are present).

Is there a convenient way to make /some/dir usable as a repository?
Two things that I tried are

  git --work-tree=/another/dir reset --hard master

which one time, but then failed with "fatal: unable to read tree...",
and another is

  cp -a /some/dir/.git /another/dir
  cd /another/dir
  git reset --hard master

which looks like it can suffer from the same problem.

(It would be especially nice if there's a way to have only different
files touched in /another/dir.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
