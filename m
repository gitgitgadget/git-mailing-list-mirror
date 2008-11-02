From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Sun, 2 Nov 2008 05:09:15 -0500
Message-ID: <20081102100915.GI8134@mit.edu>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu> <20081030144321.GF24098@artemis.corp> <20081030163056.GA8899@mit.edu> <7v1vxu4q49.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, Sam Vilain <samv@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 11:13:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZxD-0004S0-Mg
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 11:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbYKBKJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 05:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbYKBKJU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 05:09:20 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:42885 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753240AbYKBKJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 05:09:19 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KwZtU-0004z8-2z; Sun, 02 Nov 2008 05:09:16 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KwZtT-0008WB-Gj; Sun, 02 Nov 2008 05:09:15 -0500
Content-Disposition: inline
In-Reply-To: <7v1vxu4q49.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99838>

On Sat, Nov 01, 2008 at 11:08:06PM -0700, Junio C Hamano wrote:
> > (And I get annoyed when I want to run git format-patch on a single
> > patch not at the tip of the tree; but if it's just me, I can write a
> > "git format-single-patch" wrapper script to get around it.)
> 
> Huh?  I am so used to "git format-patch -1 HEAD" (or "332d2e78") that I am
> very surprised.

Well, the explanation is that "-<n>" isn't in the SYNPOSIS section of
'git format-patch', and so I never knew you could do it that way.  A
new user of git has to paw through approximately 50 options in the
OPTIONS section of the man page before finding "-<n>"; and somehow
I've always missed it.  I'd suggest adding an explicit mention of -<n>
to the DESCRIPTION section, perhaps in the paragraph:

   A single commit, when interpreted as a <revision range> expression,
   means "everything that leads to that commit", but if you write git
   format-patch <commit>, the previous rule applies to that command
   line and you do not get "everything since the beginning of the
   time". If you want to format everything since project inception to
   one commit, say "git format-patch --root <commit>" to make it clear
   that it is the latter case.

Adding the sentence:

   If you want to format a single commit, you can do this via 
   "git format-patch -1 <commit>" or the more esoteric and perl-ish,
   "git format-patch <commit>^!"

might be helpful.

						- Ted
