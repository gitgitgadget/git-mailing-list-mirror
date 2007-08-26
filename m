From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 4/5] gitweb: Selecting diffs in JavaScript
Date: Sun, 26 Aug 2007 03:17:43 +0200
Message-ID: <20070826011742.GF1219@pasky.or.cz>
References: <11796926121641-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121315-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121911-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926122089-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Aug 26 03:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP6lc-0002hP-1w
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 03:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765028AbXHZBRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 21:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756916AbXHZBRp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 21:17:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59744 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbXHZBRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 21:17:44 -0400
Received: (qmail 17959 invoked by uid 2001); 26 Aug 2007 03:17:43 +0200
Content-Disposition: inline
In-Reply-To: <11796926122089-git-send-email-mkoegler@auto.tuwien.ac.at>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56665>

On Sun, May 20, 2007 at 10:23:31PM CEST, Martin Koegler wrote:
> The adds support for selecting arbitrary diffs, if the client browser supports
> JavaScript.
> 
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

JFYI, I've just enabled it on repo.or.cz experimentally. Please anyone
tell me what you think.

(Just click at almost any view in gitweb and marvel at the extra base
and diff links smiling everywhere.)

I'll dump my mind state here, horribly sleepy. Sorry for the
incomprehensible rant. :-)

One thing for certain is that I would get rid of GitAddLinks and instead
have href() add the extra links there, by default display: none and
javascript code making it show. Also, there are obvious UI bugs, like
commit and tree entries for commits having redundant base/diff links;
and Firefox doesn't expand table cells properly for the additional
links. None of these bugs is easily fixable I think.

But maybe it needs more general overhaul and the links added explicitly
in the views, because it really makes sense to have only a single
linkpair per entry and it would be good to have this always at the same
place, and perhaps in a different color. Hmm. And it seems that it's
getting in the way, overally.

Hmm.

What about having another item in the main action menu, 'diff'?
Base/diff links are by default display: none but show up when you click
at 'diff', in green. They will keep showing up until you click 'diff'
again. When you click 'base', both the selected base link and main
'diff' link changes color to red.


Oh the naivity that I've already lost about that someone might make a
patch while I'm sleeping... ;-)

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
