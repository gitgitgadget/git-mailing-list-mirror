From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch: Move note about effect
 of removing commits
Date: Tue, 18 Sep 2012 11:27:10 -0700
Message-ID: <7vwqzrmbk1.fsf@alter.siamese.dyndns.org>
References: <m2627biaw3.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 20:27:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE2W2-0002Kd-VG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 20:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab2IRS1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 14:27:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab2IRS1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 14:27:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 863358866;
	Tue, 18 Sep 2012 14:27:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=01SxB4sGDuYygAKb4lWMVbZAs1M=; b=OSvqNk
	6Rf/8suoG8PfSvlZ+j9Ad7RKgEU1j20p/uYO/iXje1zoJRBPDCYgZyQd8RwQ66E6
	kmY+uc3BUG8MbcoO9uWZaONulAc7T7IbhtaOxLzkTu9ZJwVjCd8etPzwNyNSFnUw
	dWuKR/hZIucFmYznosO9iFrzJV022iTomH8gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FNCuukdcI2/k0knsxuVK7EGo9h8y3TFr
	epSYoFj+EE3HZBppzS5ie6Uy4PnW+tJX6b0IveUN5E9YQDA27LE2o0ca3oZIH/wq
	q0/xjsx64mIxZhnceHZrkOUgSe9JwFXYzZDECCwY/N9JxRETGZVFiGprA/40yNC8
	Oj8cXflM51k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 742378865;
	Tue, 18 Sep 2012 14:27:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B179A8862; Tue, 18 Sep 2012
 14:27:11 -0400 (EDT)
In-Reply-To: <m2627biaw3.fsf@igel.home> (Andreas Schwab's message of "Tue, 18
 Sep 2012 17:55:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76752F1E-01BE-11E2-A840-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205846>

Andreas Schwab <schwab@linux-m68k.org> writes:

> The note that explains that changes introduced by removed commits are
> preserved should be placed directly after the paragraph that describes
> such commits removal.  Otherwise the reference to "the commits" appears
> out of context.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  Documentation/git-filter-branch.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 15e7ac8..6e2d9ea 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -304,6 +304,11 @@ committed a merge between P1 and P2, it will be propagated properly
>  and all children of the merge will become merge commits with P1,P2
>  as their parents instead of the merge commit.
>  
> +*NOTE* the changes introduced by the commits, and which are not reverted
> +by subsequent commits, will still be in the rewritten branch. If you want
> +to throw out _changes_ together with the commits, you should use the
> +interactive mode of 'git rebase'.
> +
>  You can rewrite the commit log messages using `--msg-filter`.  For
>  example, 'git svn-id' strings in a repository created by 'git svn' can
>  be removed this way:
> @@ -329,11 +334,6 @@ git filter-branch --msg-filter '
>  ' HEAD~10..HEAD
>  --------------------------------------------------------
>  
> -*NOTE* the changes introduced by the commits, and which are not reverted
> -by subsequent commits, will still be in the rewritten branch. If you want
> -to throw out _changes_ together with the commits, you should use the
> -interactive mode of 'git rebase'.
> -
>  
>  Consider this history:

Yeah, makes sense.  "Consider this history" that follows this
post-context is about "To restrict rewriting to only part of the
history, ..." so this section may need further line swapping,
though.  The the current text flows like this:

 * To remove commits, you can do this, and this even handles merges.

 * You can rewrite the log message with --msg-filter.

 * You can rewrite only part of the commit DAG with revision range.

 * You can add 'Acked-by' with --msg-filter.

 * Note that you may want to consider using "rebase -i" if you want
   to remove the changes.

 * Illustration of rewriting parts of commits.

but as you pointed out, "Note that" is better to be after "To remove
commits".  Also, "only part of the DAG with range" is better to be
immediately before the illustration.

So something like this instead?

 Documentation/git-filter-branch.txt | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git i/Documentation/git-filter-branch.txt w/Documentation/git-filter-branch.txt
index 15e7ac8..e2301f5 100644
--- i/Documentation/git-filter-branch.txt
+++ w/Documentation/git-filter-branch.txt
@@ -304,6 +304,11 @@ committed a merge between P1 and P2, it will be propagated properly
 and all children of the merge will become merge commits with P1,P2
 as their parents instead of the merge commit.
 
+*NOTE* the changes introduced by the commits, and which are not reverted
+by subsequent commits, will still be in the rewritten branch. If you want
+to throw out _changes_ together with the commits, you should use the
+interactive mode of 'git rebase'.
+
 You can rewrite the commit log messages using `--msg-filter`.  For
 example, 'git svn-id' strings in a repository created by 'git svn' can
 be removed this way:
@@ -314,11 +319,6 @@ git filter-branch --msg-filter '
 '
 -------------------------------------------------------
 
-To restrict rewriting to only part of the history, specify a revision
-range in addition to the new branch name.  The new branch name will
-point to the top-most revision that a 'git rev-list' of this range
-will print.
-
 If you need to add 'Acked-by' lines to, say, the last 10 commits (none
 of which is a merge), use this command:
 
@@ -329,11 +329,10 @@ git filter-branch --msg-filter '
 ' HEAD~10..HEAD
 --------------------------------------------------------
 
-*NOTE* the changes introduced by the commits, and which are not reverted
-by subsequent commits, will still be in the rewritten branch. If you want
-to throw out _changes_ together with the commits, you should use the
-interactive mode of 'git rebase'.
-
+To restrict rewriting to only part of the history, specify a revision
+range in addition to the new branch name.  The new branch name will
+point to the top-most revision that a 'git rev-list' of this range
+will print.
 
 Consider this history:
 
