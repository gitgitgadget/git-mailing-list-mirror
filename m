From: Tim Retout <tim@retout.co.uk>
Subject: Re: [PATCH] builtin-reset.c: Extend hard reset error message when
 using paths.
Date: Mon, 13 Apr 2009 22:19:55 +0100
Message-ID: <1239657595.4641.50.camel@arneb.retout.co.uk>
References: <1239646444-11653-1-git-send-email-tim@retout.co.uk>
	 <7vr5zwe3ie.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 23:21:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtTb4-0001Ff-7p
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 23:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbZDMVUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 17:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbZDMVUH
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 17:20:07 -0400
Received: from yoda.london.02.net ([82.132.130.151]:47843 "EHLO mail.o2.co.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751685AbZDMVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 17:20:06 -0400
Received: from arneb.retout.co.uk (87.194.215.58) by mail.o2.co.uk (8.0.013.3) (authenticated as timretout)
        id 49E06C87007AC163; Mon, 13 Apr 2009 22:19:57 +0100
Received: by arneb.retout.co.uk (Postfix, from userid 1000)
	id 38A9510000D; Mon, 13 Apr 2009 22:19:56 +0100 (BST)
In-Reply-To: <7vr5zwe3ie.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116488>

On Mon, 2009-04-13 at 12:51 -0700, Junio C Hamano wrote:
> Tim Retout <tim@retout.co.uk> writes:
> 
> > Users who invoke 'git reset --hard <paths>' are probably trying to
> > update paths in their working directory.  The error message should
> > point them in the direction of git-checkout(1).
> 
> That is one possibility.  Another is:
> 
>     git reset --hard mester
> 
> (and you have ./mester file in the work tree) and in that case the user
> definitely didn't want to do any checkout.

I would think that this sort of typo is sufficiently rare that it should
not cause confusion - at least, no more than 'Cannot do hard reset with
paths.', which would be the current message.

> I wonder if you can tell these cases apart, and also if this (not just
> telling these apart, but what your patch adds) is worth additional
> cluttering in the running program.

Well, in my opinion the cluttering is minimal, and a line similar to
this would be useful to help these users find the right documentation...

> I certainly wouldn't mind addition to
> git-reset manual page if new people are often confused between "checking
> out paths from the index or from the named commit" and "resetting the HEAD
> to a different commit while nuking the index and the work tree state",
> though.

...and a note in the man page would be helpful as well, similar to that
in git-revert(1).  I'm happy to come up with something.

I'm aiming to reduce the frequency with which I get asked for help with
reverting a file.  Perhaps adding a <paths> form to 'revert' is what I
really want to do.

-- 
Tim Retout <tim@retout.co.uk>
