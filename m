From: Theodore Tso <tytso@mit.edu>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 13:05:04 -0400
Message-ID: <20070827170504.GH4680@thunk.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com> <7v6431omn8.fsf@gitster.siamese.dyndns.org> <20070827014056.GB7422@mediacenter.austin.rr.com> <7vlkbxmp50.fsf@gitster.siamese.dyndns.org> <20070827075009.GA31438@glandium.org> <38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPi1o-0004I1-6J
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 19:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949AbXH0RFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 13:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbXH0RFY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 13:05:24 -0400
Received: from THUNK.ORG ([69.25.196.29]:51344 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbXH0RFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 13:05:23 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IPiAL-0000FA-Br; Mon, 27 Aug 2007 13:14:17 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IPi1Q-00079P-BG; Mon, 27 Aug 2007 13:05:04 -0400
Content-Disposition: inline
In-Reply-To: <38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56859>

On Mon, Aug 27, 2007 at 03:21:32PM +0200, Francis Moreau wrote:
> This "inconsistency" had already been raised before. Please refer to:
> http://www.gelato.unsw.edu.au/archives/git/0612/35354.html

That's not a major inconsistency problem IMHO because git diff does
not take a set of commits, but rather two end points --- conceptually,
there's no way to make sense out of trying to feed an arbitrary set of
commitments to git-diff.

The bigger inconsistency is with git-format-patch, which *does* take a
set of commits, and where "git-format-patch a" does operates on a very
different set of commits than what what "git-rev-list a" returns.  I
understand that for backwards compatibility "git-format-patch a" is
equivalent to "git-format-patch a..HEAD", but what it means is that
all other ways of specifying sets of commits work with
git-format-patch, *except* if you want to specify all commits from the
beginning of time to a particular head (i.e., "git-rev-list a") is
something that you simply can not possibly do using git-format-patch.
This was mentioned on a blog entry as one of those "really confusing
inconsistencies" in git.

						- Ted
