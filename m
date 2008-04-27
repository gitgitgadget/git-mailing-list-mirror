From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git show documentation: no longer refer to git-diff-tree
	options
Date: Sun, 27 Apr 2008 13:45:04 +0200
Message-ID: <20080427114504.GT4012@genesis.frugalware.org>
References: <1209262661-14370-1-git-send-email-vmiklos@frugalware.org> <7vod7wkuue.fsf@gitster.siamese.dyndns.org> <200804270730.m3R7UTTp011092@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@bluebottle.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 13:45:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq5KL-0001mX-RI
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 13:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbYD0LpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 07:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754469AbYD0LpH
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 07:45:07 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47684 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbYD0LpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 07:45:06 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E76D01B251D;
	Sun, 27 Apr 2008 13:45:04 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 37BFE44659;
	Sun, 27 Apr 2008 13:41:26 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CFA6611904D3; Sun, 27 Apr 2008 13:45:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200804270730.m3R7UTTp011092@mi1.bluebottle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80442>

The only git-diff-tree option that makes sense with git-show is '-s',
but (from a user's point of view) it has sightly different meaning,
since you don't have a --stdin option when using git-show.

This patch removes the reference to git-diff-tree options and adds
documentation for '-s', in the context of git-show.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Apr 27, 2008 at 04:29:55PM +0900, nanako3@bluebottle.com wrote:
> I do not know if the updated patch is correct either.
>
> Did you try "git show" with the options you have in the new
> "tree-options" file, for example "git show --root HEAD", and checked
> to make sure they make sense?

The initial problem I tried to solve with this patch is to avoid the
situation, when you try to figure out what 'git show --foo' does and you
can't find that option in man git-show, which is a usability problem, I
think.

> I think "git show -s" makes sense as it is easier to type than "git
> log -1" but I do not think any other options you listed makes sense
> with "git show".

I just checked each option one by one and right, I haven't found any
other option that could be useful for git-show either. Given that the
wording of -s for git-show is quite different, I think it would be
easier to just document -s in git-show as well. Like this?

Thanks.

 Documentation/git-show.txt |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index dccf0e2..299b611 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -25,12 +25,6 @@ with \--name-only).
 
 For plain blobs, it shows the plain contents.
 
-The command takes options applicable to the linkgit:git-diff-tree[1] command to
-control how the changes the commit introduces are shown.
-
-This manual page describes only the most frequently used options.
-
-
 OPTIONS
 -------
 <object>::
@@ -38,6 +32,9 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
 
+-s::
+	Don't show a textural diff for commits.
+
 include::pretty-options.txt[]
 
 
-- 
1.5.5.1.91.g499fc.dirty
