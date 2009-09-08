From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 8 Sep 2009 14:10:46 -0700
Message-ID: <20090908211046.GV1033@spearce.org>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <200909080512.34634.johan@herland.net> <7vd462qdeg.fsf@alter.siamese.dyndns.org> <200909081054.02523.johan@herland.net> <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302> <7vocplxjov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7xl-00088C-Dj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbZIHVKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbZIHVKo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:10:44 -0400
Received: from george.spearce.org ([209.20.77.23]:59663 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZIHVKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:10:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DC5823815E; Tue,  8 Sep 2009 21:10:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vocplxjov.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128037>

Junio C Hamano <gitster@pobox.com> wrote:
> Also Gitney talked about annotating commits in the code-review thing.
> What's the expected notes density and distribution in that application?

Uh, try one note per commit in a project.  A few merges won't need
a note, but nearly every single non-merge commit would.

Consider a project with a velocity of about 200 non-merge
commits/day; the object count goes up fast.

One idea we are starting to kick around might double or quadruple
that number.  If we store metadata about every version of every
commit ever proposed to a project, we need a lot more notes than
commits.  Right now we have this sort of distribution from one of
our servers:

versions | commits 
---------+---------
       1 |    9262
       2 |    2626
       3 |    1053
       4 |     424
       5 |     224
       6 |     124
       7 |      57
       8 |      38
       9 |      28
      10 |      14
      11 |      12
      12 |      10
      13 |       5
      14 |       6
      15 |       2
      16 |       3
      17 |       2
      21 |       1
      32 |       1

So most commits (66%) would have only 1 version (and 1 note)
related to them in the note tree, but if I use the same note tree
for final commits as individual revisions considered, at least 18%
of the commits in the final history of the project would actually
have two notes, and 7.5% would have 3 notes.

-- 
Shawn.
