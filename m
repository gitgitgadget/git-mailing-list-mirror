From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 03/15] Add IntList as a more efficient
	representation of List<Integer>
Date: Fri, 12 Dec 2008 07:15:33 -0800
Message-ID: <20081212151533.GM32487@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org> <1229049981-14152-2-git-send-email-spearce@spearce.org> <1229049981-14152-3-git-send-email-spearce@spearce.org> <1229049981-14152-4-git-send-email-spearce@spearce.org> <bd6139dc0812120243y2b1a3dddu4975162114280e17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Dec 12 16:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB9l5-00059e-Mp
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbYLLPPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 10:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756877AbYLLPPe
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:15:34 -0500
Received: from george.spearce.org ([209.20.77.23]:41782 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756868AbYLLPPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 10:15:34 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8406538210; Fri, 12 Dec 2008 15:15:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bd6139dc0812120243y2b1a3dddu4975162114280e17@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102902>

Sverre Rabbelier <alturin@gmail.com> wrote:
> On Fri, Dec 12, 2008 at 03:46, Shawn O. Pearce <spearce@spearce.org> wrote:
> > +       public String toString() {
> > +               final StringBuilder r = new StringBuilder();
> > +               r.append('[');
> > +               for (int i = 0; i < count; i++) {
> > +                       if (i > 0)
> > +                               r.append(", ");
> > +                       r.append(entries[i]);
> > +               }
> > +               r.append(']');
> > +               return r.toString();
> > +       }
> > +}
> 
> If you care about speed in your toString at all, pull the if statement
> out of there. A friend of mine did a small benchmark once, and it was
> _a lot_ slower to do the if in the for loop. I reckon you don't
> though, but just in case ;).

Hmm, yea, good point.  But I don't care too much about the toString()
in this case, its meant as a debugging aid and not something one
would rely upon.  Hence I didn't think it was worth testing for the
empty list, writing the first entry, then doing a loop for [1,count).

-- 
Shawn.
