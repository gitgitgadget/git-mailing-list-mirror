From: Junio C Hamano <gitster@pobox.com>
Subject: [Announce] 'next' rewound and rebased
Date: Sun, 17 Feb 2008 12:28:09 -0800
Message-ID: <7v1w7bz5t2.fsf_-_@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 21:28:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQq88-0004Rl-Os
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 21:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523AbYBQU2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 15:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbYBQU2S
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 15:28:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbYBQU2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 15:28:17 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A19D6557;
	Sun, 17 Feb 2008 15:28:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 B22956555; Sun, 17 Feb 2008 15:28:12 -0500 (EST)
In-Reply-To: <7vejbc44hu.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 16 Feb 2008 19:59:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74178>

Junio C Hamano <gitster@pobox.com> writes:

> ...  As announced, I'll rewind
> and rebuild "next" with the surviving topics on top of "master",
> sometime tomorrow.

... which just happened.  The old history leading to "next" used
to be 1323 commits ahead of v1.5.4.2 but the rebased one now is
only 182 commits ahead, mostly due to old merge commits that
never went out of "next" to "master" and a handful reverts.

On k.org and repo.or.cz repo, I pushed out a branch "old-next"
whose ancestry is connected to the old "next" and whose tip-tree
matches that of the tip of "next", so if any of you have been
building on top of 'next', you may want a one-time conversion to
do:

	$ git fetch
        $ git rebase --onto origin/next origin/old-next my-branch-on-next

Recent "git pull --rebase" may be good enough by consulting
your remotes/origin/next@{1} to find the base without using the
old-next trick, though I haven't checked.
