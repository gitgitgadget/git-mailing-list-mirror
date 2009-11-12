From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Re: Clarify documentation on the "ours" merge
 strategy.
Date: Thu, 12 Nov 2009 10:41:38 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0911121034580.8825@ds9.cixit.se>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de> <7vskckn5b4.fsf@alter.siamese.dyndns.org> <20091111213049.GJ27518@vidovic> <200911120037.11901.trast@student.ethz.ch> <7vvdhggote.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8WBk-0004Pt-Qy
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbZKLJlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbZKLJlt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:41:49 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:47854 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752612AbZKLJls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:41:48 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nAC9fd7O016827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 Nov 2009 10:41:39 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nAC9fcpQ016823;
	Thu, 12 Nov 2009 10:41:39 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vvdhggote.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 12 Nov 2009 10:41:39 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132756>

Junio C Hamano:

> Perhaps there is some different issue at the root of this one.  Why would 
> anybody be tempted to say "-s ours" while running a rebase?  What did the 
> user want to see it do (instead of being a no-op because "ours" by 
> definition ignores the tree the change is replayed from)?

The reason why I wanted it in my initial example was due to me misreading 
the documentation of "ours".

My scenario is like this:

I have my web site under Git control (used to be CVS). Some parts of the web 
site is updated in-place (blog comments being saved as HTML directly in the 
web tree), whereas all other edits are done in clones of the repsository. 
These changes are then added and committed to the checked out web tree and 
pushed to the central repo.

In some cases, I wish to edit the comments in one of my clones (to remove 
spam not stopped by my spam filters, for instance), but editing these risks 
creating a conflict if there has been other changes in the mean time.

The web tree checkout script uses rebase to avoid introducing merge commits 
every time the blog comment is updated, as it in 99 % of cases is unrelated 
to any other changes found in the central repo.

In the few cases where the blog comment update from the web tree conflicts 
with a change in the central repo, I want the "git pull --rebase" call to 
overwrite any changes in the central repo with my changes in the web tree 
(meaning that I would later have to manually re-delete the spam comments, 
but I can live with that).

> It is easy to dismiss it as a user misconception and it also is tempting 
> to think that it would be helped with updated description of "ours" to 
> dispel that misconception, but there may be some user wish that is totally 
> different from "ours merge" strategy but still can be validly labelled 
> using a word "ours" by somebody who does not know the way the word "ours" 
> is used in the git land, and satisfying that unknown user wish might be 
> the real solution to this issue.

Yes, I am apparently looking for something that is not available in the Git 
codebase yet. :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
