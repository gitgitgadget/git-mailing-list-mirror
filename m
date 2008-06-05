From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: log --graph --first-parent weirdness
Date: Thu, 5 Jun 2008 12:50:33 +0300
Message-ID: <20080605095033.GC5946@mithlond.arda.local>
References: <20080604150042.GA3038@mithlond.arda.local> <7vmym1xgy4.fsf@gitster.siamese.dyndns.org> <20080604173820.GA3038@mithlond.arda.local> <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 12:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4CKg-0006GV-PJ
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962AbYFEKA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757030AbYFEKA2
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:00:28 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:53750 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758486AbYFEKA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:00:26 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F10057B96D; Thu, 5 Jun 2008 12:50:35 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4C77-0004dU-UD; Thu, 05 Jun 2008 12:50:33 +0300
Content-Disposition: inline
In-Reply-To: <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83893>

Junio C Hamano wrote (2008-06-04 11:05 -0700):

> Teemu Likonen <tlikonen@iki.fi> writes:
> 
> > To me it's perfectly fine to turn off --graph when used with
> > --first-parent, but yes, generally users might expect to see a line
> > of M's, *'s and |'s there. At least it would clearly show which
> > commits are merges and which are not.
> 
> I disagree.  If you are doing --first-parent, you do not _care_ what
> is merge and what is not.  Besides, you can easily see that from the
> log message if you cared enough.
> 
> And if the graph actually draws the real ancestry graph (i.e. without
> --first-parent), the lines visually show which is merge and which is
> not, so the "M" gets very distracting.
> 
> I'd really suggest changing the "M" and use "*" everywhere.

Well, I disagree :-) Merges are interesting points in history (they
introduce features etc.) and for a "--graph --first-parent" user
a certain already known merge is easier to find if there is a stable
identifier for them (like "M"). Commit messages are not stable in that
sense and it helps if user can just keep an eye on the graph when
searching for a certain merge (helps to skip other commits). Once the
correct merge is found, one would perhaps do "git log -p
<the-SHA1-of-that-merge>^2".

So I like having separate identifiers for merge commits. However, I do
realize that in the bigger picture those M's are not at all essential
for finding wanted information from project's history. So this question
is not something I'd go arguing too seriously.
