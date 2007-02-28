From: Theodore Tso <tytso@mit.edu>
Subject: Re: Questions about git-rev-parse
Date: Wed, 28 Feb 2007 01:40:36 -0500
Message-ID: <20070228064036.GF2178@thunk.org>
References: <E1HMETh-0004BO-Lw@candygram.thunk.org> <7vvehn2eds.fsf@assigned-by-dhcp.cox.net> <20070228025258.GD2178@thunk.org> <Pine.LNX.4.64.0702271921110.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 07:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMIUf-0002T1-4Q
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 07:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXB1Gkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 01:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXB1Gkl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 01:40:41 -0500
Received: from thunk.org ([69.25.196.29]:35899 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbXB1Gkk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 01:40:40 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HMIZs-000560-T4; Wed, 28 Feb 2007 01:46:17 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HMIUO-0001w6-3I; Wed, 28 Feb 2007 01:40:36 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702271921110.12485@woody.linux-foundation.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40900>

On Tue, Feb 27, 2007 at 07:33:03PM -0800, Linus Torvalds wrote:
> No, it really is English. At least grammatically.
> 
> A "tree-ish" is "like a tree", exactly like "sheepish" is "like a sheep". 
> Nothing really git-specific about it, except for it certainly having 
> become common usage in a way that it may not be normally ;)

Well, in the randomhouse web page you quoted:

	Our -ish is a suffix that forms adjectives from nouns or other
	adjectives. Some of the senses existed in Old English (then
	spelled -isc but pronounced the same way), such as 'of, being,
	or pertaining to', used to form adjectives indicating a
	national, ethnic, or religious origin (British, Jewish).

it claims that the -ish suffix forms an _adjective_.   But in the sense of

	git describe <committish>

In the git world we are using "committish" (and in the documentation
sometimes we use committish and treeish, and other times we use
commit-ish and tree-ish) as a _noun_, and not an adjective.  So I'm
still going to take a bit of issue that it's grammatical English, and
I still think that "tree_specifier" and "commit_specifier" would have
been clearer.

In any case, I note that in the git(7) man page, there is a formal
definition of tree-ish, but not of commit-ish.  Would this patch to
Documentation/git.txt be correct?

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9a74747..ff693c3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -241,6 +241,12 @@ Identifier Terminology
 	operate on a <tree> object but automatically dereferences
 	<commit> and <tag> objects that point at a <tree>.
 
+<commit-ish>::
+	Indicates a commit or tag object name.  A
+	command that takes a <commit-ish> argument ultimately wants to
+	operate on a <commit> object but automatically dereferences
+	<tag> objects that point at a <commit>.
+
 <type>::
 	Indicates that an object type is required.
 	Currently one of: `blob`, `tree`, `commit`, or `tag`.

							- Ted
