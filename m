From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Mon, 20 Aug 2007 11:36:38 +0800
Message-ID: <46C90C46.1030000@midwinter.com>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>	<20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 05:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMy5B-0003gn-8t
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 05:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbXHTDhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 23:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755529AbXHTDhd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 23:37:33 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:38683 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754426AbXHTDhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 23:37:32 -0400
Received: (qmail 31117 invoked from network); 20 Aug 2007 03:37:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=j/IrwXhL9GZ6bAi82Feme90EObcnqbLrNwt/fodYWlYx22hEu/wfkyyBcAVs6Ftn  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 20 Aug 2007 03:37:30 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <7vps1paceh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56169>

Junio C Hamano wrote:
 > People should learn this command.  Really.
 >
 >       $ git cat-file -p :$n:path
 >
 > where $n == 2 is ours, $n == 1 is common ancestor, and $n == 3
 > is theirs.

The git-rev-parse manpage talks about the :$n:path notation (buried deep in
a list of other syntax) but it just says $n is a "stage number" -- someone
who is not familiar with the internals of git's merge implementation is
never going to be able to figure out that "1", "2", and "3" mean what Junio
said.
---

    Not sure if this is correct for octopus merges -- corrections welcome.

 Documentation/git-rev-parse.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt 
b/Documentation/git-rev-parse.txt
index 4b4d229..4758c33 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -215,7 +215,10 @@ blobs contained in a commit.
 * A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path; this names a blob object in the
   index at the given path.  Missing stage number (and the colon
-  that follows it) names an stage 0 entry.
+  that follows it) names an stage 0 entry. During a merge, stage
+  1 is the common ancestor, stage 2 is the target branch's version
+  (typically the current branch), and stage 3 is the version from
+  the branch being merged.
 
 Here is an illustration, by Jon Loeliger.  Both node B and C are
 a commit parents of commit node A.  Parent commits are ordered
-- 
1.5.3.rc2.4.g726f9
