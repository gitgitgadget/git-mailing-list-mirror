From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: fetch and pull
Date: Mon, 9 Mar 2009 11:27:53 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A116178@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com> <m3iqmmidlf.fsf@localhost.localdomain> <7vd4cus7ez.fsf@gitster.siamese.dyndns.org> <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com> <3e8340490903070000t2780764cocfbf28d538037df5@mail.gmail.com> <7vfxhpnl7g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Bryan Donlan" <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LghQr-0007GN-Vs
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbZCIP2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 11:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZCIP2x
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:28:53 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:58792 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZCIP2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 11:28:52 -0400
X-ASG-Debug-ID: 1236612529-488403630000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id B992E1FE481; Mon,  9 Mar 2009 11:28:49 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id q5VKDp3VvUFlMDJ6; Mon, 09 Mar 2009 11:28:49 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Mar 2009 11:28:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: fetch and pull
In-Reply-To: <7vfxhpnl7g.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fetch and pull
Thread-Index: AcmfYYDMHn4thgSiR0io7qMx81HeUgBZ55Lg
X-OriginalArrivalTime: 09 Mar 2009 15:28:49.0398 (UTC) FILETIME=[BEA3C960:01C9A0CB]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236612529
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112704>

Thanks for your thoughts.  I'm still trying to figure out not just the
basic meaning of the tools but what can be done with them.

=== Re: ===
With git that is not ancient (i.e. v1.5.0 or newer), there is no reason
to
have local "dev" that purely track the remote anymore.  If you only want
to go-look-and-see, you can check out the remote tracking branch
directly
on a detached HEAD with "git checkout origin/dev".
=== end ===

Yes, I figured out that since gitk shows the remote, there is no reason
to have local copies of any master (upstream) refs that I don't plan on
modifying.  After setting it to track remotes, I deleted all my unneeded
copies.

=== Re: ===
Which means that the only cases we need to make it convenient for users
are to handle these local branches that "track" remote ones when you do
have local changes, or when you plan to have some.
=== end ===

I also realized recently that, with the use of topic branches, the user
doesn't need to see the "old" (local copy of) dev to understand what
changed since he last looked.  The visible branch point with the topic
will serve as that marker.

The only time the local dev is used is when the developer is going to
add a commit for the completed topic.  But, dealing with it (only) then
would be more steps when doing that.  And the local dev would still be
visible and out-dated from day-to-day, and when keeping the topic
up-to-date with dev changes he would need to use origin/dev not just dev
in his commands to rebase or merge.

=== Re: ===
I'd actually say we should give users a convenient way to remove the
local
branches that are marked to track remote tracking branches but do not
have
anything interesting on their own (iow when they can fast-forward to
their
corresponding remote tracking branches), if the true motive behind this
thread is "'git push' will notice 'dev' that is left behind and gives
clutter".
=== end ===

I found that using the GUI was easy enough, when "converting" my local
to track remote branches.  If you mean make a way to have a local
version of a tracking branch transiently, that is, only when it is
interesting, then I think I like that idea.

=== Re: ===
So how about "git branch --prune --remote=<upstream>" that iterates over
local branches, and if

 (1) it is not the current branch; and
 (2) it is marked to track some branch taken from the <upstream>; and
 (3) it does not have any commits on its own;

then remove that branch?  "git remote --prune-local-forks <upstream>" is
also fine; I do not care about which command implements the feature that
much.
=== end ===

Since fetch is the command that does the tracking of remotes, how about
having an option to fetch that does this before proceeding with the
fetch?  That is what people really want if they think they want locals
to auto-track the remotes.

=== Re: ===
But in that case, you shouldn't mark "dev" as tracking the remote's
"dev"
to begin with, so the hypothetical "branch --prune --remote=<upstream>"
would not touch such a "fork to address old issues", and we'd be safe.
=== end ===

Does git now "associate" local branch names with the remotes, other than
by simply having the same name?

--John
(please excuse the footer; it's not my choice)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
