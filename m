From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: fetch and pull
Date: Fri, 6 Mar 2009 14:04:25 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 20:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LffMv-0001yx-CD
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 20:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbZCFTEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 14:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZCFTEb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 14:04:31 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:43305 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbZCFTEa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 14:04:30 -0500
X-ASG-Debug-ID: 1236366267-7f4c038f0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 17F3F1F3071
	for <git@vger.kernel.org>; Fri,  6 Mar 2009 14:04:27 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id EBWuijemSU0fgbxf for <git@vger.kernel.org>; Fri, 06 Mar 2009 14:04:27 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 14:04:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: fetch and pull
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fetch and pull
Thread-Index: Acmejl3c8KNl4KtvTwSRygQxM/u91A==
X-OriginalArrivalTime: 06 Mar 2009 19:04:26.0569 (UTC) FILETIME=[5E8E2B90:01C99E8E]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236366267
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112474>

I've gotten the hang of git well enough to pretty much bang on it until
I achieve what I wanted to happen, though maybe trying a few things and
recovering from mistakes or taking the long way around.

Now I'm putting together a cookbook for our team, to allow use of topic
branches rather than treating it simply as a faster SourceSafe.

I want to advocate running

	git fetch

as being a safe thing to do at any time, just to refresh your view of
the origin and not mess up any of your local labels.  That is, you can
see the difference between the local dev and the origin/dev.

So, after inspecting the changes, how do you fast-forward your local dev
to sync up with origin/dev?

I'm worried that

	git pull origin dev

will try to merge into the current head.  The documentation indicates
"The remote ref that matches <src> is fetched, and if <dst> is not empty
string, the local ref that matches it is fast forwarded using <src>."
which is what I want, but it does NOT say that the normal behavior of
merging origin/dev into the =current= HEAD, if it happens to not be the
local dev.

So, does it indeed suppress that behavior if you give it an explicit
destination?  Or will I have to checkout dev first before doing the
pull, to prevent strange things from happening?  Hmm, or perhaps I
should be using merge, not pull?  After all, pull is really just a
wrapper around fetch and then merge, right?  So is it OK to call merge
when I really want to fast-forward, and is there an option to give an
error if it isn't ff?

--John
(sorry about the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
