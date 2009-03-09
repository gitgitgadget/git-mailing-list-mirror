From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: fetch and pull
Date: Mon, 9 Mar 2009 11:08:11 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A11614B@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com> <m3iqmmidlf.fsf@localhost.localdomain> <7vd4cus7ez.fsf@gitster.siamese.dyndns.org> <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com> <3e8340490903070000t2780764cocfbf28d538037df5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>, <git@vger.kernel.org>
To: "Bryan Donlan" <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgh7a-00080W-Km
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbZCIPI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 11:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZCIPI6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:08:58 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:56841 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbZCIPI5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 11:08:57 -0400
X-ASG-Debug-ID: 1236611332-488403200002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 88CA31FE11F; Mon,  9 Mar 2009 11:08:54 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id NXwvHimafiL06Y5d; Mon, 09 Mar 2009 11:08:54 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Mar 2009 11:08:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: fetch and pull
In-Reply-To: <3e8340490903070000t2780764cocfbf28d538037df5@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fetch and pull
Thread-Index: Acme+toPVHpQskugQVKJlB31atkA3ABzNaAw
X-OriginalArrivalTime: 09 Mar 2009 15:08:51.0759 (UTC) FILETIME=[F4CA93F0:01C9A0C8]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236611334
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112702>

=== Re: ===
If the local "dev" is meant to just track the remote, [that is the case]
you really ought to avoid doing anything very involved in it (unless
you're 
planning on merging something into it and pushing the result, that is!).
If
there's no local changes, then you can just pull with impunity, and
let it fast-forward - or use git merge or git rebase if you've already
fetched and don't want to spend the few seconds it takes to ask the
server if there's anything new :)
=== end ===

I thought about that.  But wouldn't that require you to checkout dev
first?  It seems that pull wants to merge into the current branch,
period.  That makes it unsuitable for something that just refreshes the
remote view of things, and is an accident waiting to happen if you run
it while on your topic branch instead.

=== Re: ===
Finally, if you really, truly, definitely want to blow away the
current branch and replace it with another one, you can use git reset
--hard. This will throw away (irretrievably) local uncommitted
changes, and force the current branch to point to the specified one.
=== end ===

"reset" does not change the current branch.  It updates the contents of
the working directory and index to match the node specified, but does
not change what git considers to be the branch you are "on".  I got a
few floating heads and later merge confusion before I finally understood
that.  It appears that "checkout" is the only thing that changes the
"current branch".  In any case, reset does not reposition any refs at
all.

=== Re: ===
Remember, you can undo most things using the reflog if you mess up,
including unwanted merges, git reset --hard (committed changes only)
etc.
=== end ===

Yes, indeed.

--John
(please excuse the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
