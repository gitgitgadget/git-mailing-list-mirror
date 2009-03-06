From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: fetch and pull
Date: Fri, 6 Mar 2009 17:11:27 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com> <m3iqmmidlf.fsf@localhost.localdomain> <7vd4cus7ez.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfiHy-0005aQ-Bm
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbZCFWLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZCFWLh
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:11:37 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:60151 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbZCFWLg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 17:11:36 -0500
X-ASG-Debug-ID: 1236377494-59e801bf0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 5F70E1E978D; Fri,  6 Mar 2009 17:11:34 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id 9H8XDLdRqZu4DVZn; Fri, 06 Mar 2009 17:11:34 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 17:11:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: fetch and pull
In-Reply-To: <7vd4cus7ez.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fetch and pull
Thread-Index: AcmenSEo4FavYh39T4mAnhfszG4FHwACo70g
X-OriginalArrivalTime: 06 Mar 2009 22:11:33.0584 (UTC) FILETIME=[8260B500:01C99EA8]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236377494
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112481>

===Re:===
> There was patch series adding support --ff=only, but I think it didn't
> made into git...  Hmmm...

I do not think it has much to do with the main point of what John wants
to
do which is to muck with local branch without checking it out, which is
only possible when it happens to fast forward to the new tip of the
corresponding branch obtained from the the remote.
===end===

It occurs to me that maybe my concept is off, if it is being so
difficult.

Here is what I'm "cooking":

======excerpt======

To keep apprised of other people's work, including updates to the main
dev branch, start the day with:

	git fetch

This will update your "remote tracking branches", letting you see what
everyone else is working on, and letting you see the central
repository's dev (as remotes/origin/dev) compared to your own local dev,
so you can see what has been added.

This does not change your local dev, or any other branches you are
using.  As for your own topic branches, you are the only one who changes
them.  This is a perfectly safe command and can be performed any time to
update your view of what's happening throughout the team.
You will, in particular, see your local dev where you last left it, and
the current remotes/origin/dev pointing ahead of it.  E.g.

	A <== dev
	 \
	  B--C--D <== remotes/origin/dev

In this example, you see plain "dev" still pointing to A, and
"remotes/origin/dev" pointing to D.  So, you can tell that B, C, D were
added.  Review the nodes B, C, and D, by reading the comments and seeing
which files were affected, and look deeper if it seems to affect what
you are doing.  Finally, issue the command

	??? 

And this will update your local dev to match the origin.

======

Basically, instead of mysterious "can't push" messages, the idea is that
people can feel good about 'fetch' as refreshing their view of the
central repo, so gitk can show them how the central dev (and other
branches) differs from their own.  

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
