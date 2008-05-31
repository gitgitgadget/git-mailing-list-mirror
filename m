From: Teemu Likonen <tlikonen@iki.fi>
Subject: Mutt and Mail-Followup-To
Date: Sat, 31 May 2008 09:26:05 +0300
Message-ID: <20080531062605.GA3029@mithlond.arda.local>
References: <20080530140447.GB10514@leksak.fem-net> <7vy75rh25i.fsf@gitster.siamese.dyndns.org> <20080531024027.GB5907@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 31 08:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2KYs-0007ax-Pg
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 08:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbYEaG0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 02:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbYEaG0K
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 02:26:10 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:60123 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751098AbYEaG0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 02:26:09 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F1001750D0; Sat, 31 May 2008 09:26:20 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K2KXV-0000rL-UM; Sat, 31 May 2008 09:26:05 +0300
Content-Disposition: inline
In-Reply-To: <20080531024027.GB5907@leksak.fem-net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83365>

Stephan Beyer wrote (2008-05-31 04:40 +0200):

> Oh, it was not meant to be rude. In fact, I didn't even knew that my
> mutt generates it. ;) So I deactivated it and I hope it helps you to
> enjoy your Caipirinha.
> 
> Btw, I'm confused whether I should use "List reply" (which only
> replies to git@vger.kernel.org) or "Reply to all" (which I used now).
> While on some other mailinglists it is discouraged to "reply to all",
> it seems to be the common case here.

Mutt's logic is pretty complicated on this. If followup_to=yes, then
Mutt generates M-F-T field and puts all the addresses gathered from To
and CC fields there (minus user's own). In addition to that, if there's
a mailing list address which is in users's "subscribe" list Mutt will
not add users's own address to the M-F-T. If the list address is only in
"lists" list, Mutt will add users's own address. The intention is to
prevent duplicates when user is a subscriber, and to get private replies
if user is not a subscriber.

The logic is so complicated and not very well supported so it doesn't
work well anyway. I think the best thing to do is:

  set followup_to=no
  set honor_followup_to=ask-no

One just has to find out if the list in question favours "replies to
all" (the 'g' key in Mutt) or replies to the list only ('L' in Mutt).
