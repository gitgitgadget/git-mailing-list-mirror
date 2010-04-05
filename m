From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: [PATCH] Add `%B' in format strings for raw commit body
 in `git  log' and friends
Date: Mon, 5 Apr 2010 02:06:03 -0400
Message-ID: <19385.32203.489776.418681@winooski.ccs.neu.edu>
References: <19370.53192.313137.191218@winooski.ccs.neu.edu>
	<m3eiiunbky.fsf@winooski.ccs.neu.edu>
	<7v6346zwu1.fsf@alter.siamese.dyndns.org>
	<19385.5077.27968.796350@winooski.ccs.neu.edu>
	<7vljd2y9c2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 08:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyfS6-0007QV-21
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 08:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab0DEGGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 02:06:07 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:47124 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab0DEGGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 02:06:05 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NyfRj-0003Oq-GE; Mon, 05 Apr 2010 02:06:03 -0400
In-Reply-To: <7vljd2y9c2.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143971>

On Apr  4, Junio C Hamano wrote:
> Eli Barzilay <eli@barzilay.org> writes:
> 
> > On Apr  4, Junio C Hamano wrote:
> >> Isn't this the same as "%s%n%+b"?
> >
> > The problem with that is that it wraps the first paragraph.  So it's
> > fine as long as it's always used as a subject line.
> >
> > (I'm migrating a project to git, and some people will never remember
> > to do that.)
> 
> Ok, but then "rev-list --pretty=format:%B" would not be as a good
> tool for migration to begin with (imagine a log message that begins
> with "commit"), compared to say "rev-list --pretty=raw".

Ah, sorry -- I phrased that poorely.  We're doing the actual migration
with git-svn, so that's not the problem.  The relation to migrating is
that people are not used to using the first paragraph as a subject
line, which means that there will be commit messages that look like:

  Fix foo, which means:
  1. Do this,
  2. Do that,
  3. Remove bar.

and such messages come out really ugly.  If a project is well behaved
in regards to commit messages always having a subject line, then
there's no big problem, of course.  (It can be a little worse if I
have scripts that look for lines with a specific format like commands
for a bug tracking system.)


> It also feels a bit funny to list %B that doesn't do the paragraph
> pretty-printing in pretty-formats.txt documentation ;-) but that is
> not an objection.

(Well, my understanding was that the pretty formats is about the
format strings in general.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
