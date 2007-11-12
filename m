From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Sun, 11 Nov 2007 18:21:44 -0800
Message-ID: <7vzlxk8apz.fsf@gitster.siamese.dyndns.org>
References: <20071111235819.GB7392@thunk.org>
	<1194829077-14320-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 12 03:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrOw9-0004Th-W0
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 03:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbXKLCVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 21:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbXKLCVu
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 21:21:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44219 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbXKLCVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 21:21:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6EF112F0;
	Sun, 11 Nov 2007 21:22:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EF9469497F;
	Sun, 11 Nov 2007 21:22:07 -0500 (EST)
In-Reply-To: <1194829077-14320-1-git-send-email-tytso@mit.edu> (Theodore
	Ts'o's message of "Sun, 11 Nov 2007 19:57:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64551>

Theodore Ts'o <tytso@mit.edu> writes:

> Remove apply, archive, cherry-pick, prune, revert, and show-branch, so
> "git help" is less intimidating.
>
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
>
> -apply
> -archive
> -prune
> -revert
> -show-branch

I am fine with this list, perhaps except apply.

On the other hand, if you are shooting *really* for the absolute
minimum set for the beginners, I would kill rm and possibly mv)
in addition to your list:

 - git-rm is always easier to do with "rm -fr file-or-dir",
   followed by "git commit -a".  Of course "git rm --cached" and
   partial commits that contain removal cannot be emulated
   easily this way, but this is an alternative suggestion to aim
   for *real* beginners who do not use the index.

 - git-mv is on my list for the same reason as "rm", but it is a
   bit more cumbersome if you want to move a directory, because
   "mv old new && git add new" would not work for people without
   a correctly set-up .gitignore (and if we are talking about
   beginners, we should expect user's .gitignore is borked).

I have a bit of reservation about revert, but I'd imagine we
could kill it, and also fetch, pull and push, if you are
shooting for *real* beginners who work alone.  I think the only
valid justification to drop "revert" from the list is to assume
that the audience do not interact with the outside world, and
dropping fetch/pull/push from the list is in line with that.
