From: Ted Ts'o <tytso@mit.edu>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 1 Jun 2012 16:38:36 -0400
Message-ID: <20120601203836.GB19987@thunk.org>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com>
 <20120601174336.GA15778@thunk.org>
 <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
 <7v8vg63lri.fsf@alter.siamese.dyndns.org>
 <7v4nqu3lhy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaYcP-0006jF-4h
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 22:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2FAUik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 16:38:40 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:47097 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab2FAUij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 16:38:39 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SaYcH-0007yh-7R; Fri, 01 Jun 2012 20:38:37 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SaYcG-0005E8-Af; Fri, 01 Jun 2012 16:38:36 -0400
Content-Disposition: inline
In-Reply-To: <7v4nqu3lhy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199020>

One other thought.  One of the reasons why I used "dev" and not
"ext4_for_linus" in my git request-pull command line was because that
several months ago I had created a branch called ext4_for_linus, and I
hadn't gotten around to deleting it, so I figured I'd just use "dev"
instead, since it was non-ambiguous.

If there is a case where there is both tag and a branch with the same
name, it might be a good idea for request-pull not just to issue a
warning, since the user might not notice the warning, but to just
abort --- and make the user explicitly type refs/tags/ext4_for_linus
or refs/heads/ext4_for_linus.

Most of the time if the user ignores the warning about the ambiguity,
it's not such a big deal, but in the case of a pull-request, he or she
is going to be possibly embarassing themself publically, so it might
be better to explicitly list the reason why a non-qualified refname is
ambiguous and force the user to pick the right one.

It's a minor point, and usually I double check the commit id in the
pull request just to be sure, so it might be considered too much of
coddling the user, but it might be a good safety check to add.

						- Ted
