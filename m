From: Eli Barzilay <eli@barzilay.org>
Subject: Distinguishing trivial and non-trivial merge commits
Date: Fri, 30 Apr 2010 12:35:05 -0400
Message-ID: <19419.1721.763210.679444@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 20:56:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7vOF-0006ME-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 20:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207Ab0D3Szi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 14:55:38 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:57632 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932696Ab0D3RIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 13:08:22 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O7tBB-0004ET-Ox
	for git@vger.kernel.org; Fri, 30 Apr 2010 12:35:05 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146044>

I'm trying to get a goot notification script, and got stuck with merge
commits.  My script shows a list of modifications for each commit
(based on the diffstat output) -- and if I show all commits, then
merges are misleading in that a quick glance through the email makes
it look like a lot more was touched.  Using `--no-merges' helps in
avoiding the confusing parts, but that's dangerous in omitting
non-trivial merges too -- and those are probably even more worth
noting than other changes (just because they'll highlights changes
that are "hotter" in the sense of more people working on that code).

The only way I've seen to distinguish the two is to use `git show' and
see if there is no diff output (eg, "git show --pretty=format: $rev").
But that doesn't help in getting the list of modified files.  So I add
`--stat' to that, and that goes back to showing all files again, the
same stuff that "git diff $rev^!" shows.

Is there *any* way to get `git diff --stat' to do the same thing that
`git show' does?  (Or a way to get `git show --stat' not show all
files again...)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
