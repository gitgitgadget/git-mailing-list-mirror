From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Wed, 10 Sep 2008 03:09:58 -0700
Message-ID: <20080910100958.GE13085@hand.yhbt.net>
References: <1220889063-20387-1-git-send-email-marcus@griep.us> <1220892781-24343-1-git-send-email-marcus@griep.us> <20080909015338.GA15974@yp-box.dyndns.org> <7vwshkzmfv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 12:14:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdMfG-0002OC-Sf
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 12:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYIJKKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 06:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbYIJKKA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 06:10:00 -0400
Received: from hand.yhbt.net ([66.150.188.102]:47577 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbYIJKJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 06:09:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1FC1F2DC01B;
	Wed, 10 Sep 2008 03:09:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwshkzmfv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95509>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Marcus Griep <marcus@griep.us> wrote:
> >> Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
> >> interface introduced in 0.14, as pointed out by Tom G. Christensen.
> >> 
> >> This modifies Git.pm to use the more established tempfile() interface
> >> and updates 'git svn' to match.
> >> 
> >> Signed-off-by: Marcus Griep <marcus@griep.us>
> >> ---
> >> 
> >>  This patch v2 cleans up a few code items, corrects a misspelling,
> >>  and ensures that the temp file gets unlinked when we exit, now
> >>  that we are requesting the filename.  Otherwise, the previous
> >>  comments stand:
> >>  
> >>  Per the earlier patch versions by Abhijit Menon-Sen and Tom G. Christensen.
> >>  Both of you may want to run a test and add your 'Tested-by' to the thread
> >>  if everything works out before Eric Wong adds his 'Acked-by'.
> >
> > Thanks Marcus, this works for me.
> > (Perl 5.10.0, so no compatibility issues).
> >
> > <bikeshed>
> > Can we rename temp_fname() to temp_path(), though?  "fname"
> > just doesn't look right in the API to me...
> > </bikeshed>
> 
> Ok, so will you take the patch with bikeshed fixes and feed the result to
> me with a pull-request, or shall I do that myself?  I do not mind doing
> this either way --- just trying to avoid duplicated work.

Please do it for me, thanks.  I've been preoccuppied offline and need
sleep.

> This is a 'maint' material, right?

Yes, definitely.

-- 
Eric Wong
