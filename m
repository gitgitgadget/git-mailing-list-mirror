From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: how to arrange source control?
Date: Tue, 28 Apr 2009 12:42:51 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3EEB1@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3EC2C@EXCHANGE.trad.tradestation.com> <20090428112423.GA28151@ralph>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Bob Dobbs" <bob@hindbrain.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 18:43:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyqPN-00066x-I9
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 18:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759469AbZD1Qne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 12:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759369AbZD1Qnd
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 12:43:33 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:42865 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759343AbZD1Qnc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 12:43:32 -0400
X-ASG-Debug-ID: 1240937011-19f500f00000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id F166A3AF2F3; Tue, 28 Apr 2009 12:43:31 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id KdeCsYdpGE8WmRdm; Tue, 28 Apr 2009 12:43:31 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 12:43:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: how to arrange source control?
In-Reply-To: <20090428112423.GA28151@ralph>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to arrange source control?
Thread-Index: AcnH8+JdohGlgUu0QZO2ELkUEMFi9wAK6/fA
X-OriginalArrivalTime: 28 Apr 2009 16:43:31.0279 (UTC) FILETIME=[76B40DF0:01C9C820]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240937011
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117798>

(back on the list so others can correct what I said)

> So, if you make libraries submodules within an app, does git make a
new
> copy of the library source
> and put it under the app, or does it just store a different kind of
> object representing the current
> state of the library source under the app?

It looks like copies of the source.  Obviously they are, if the versions
differ!  But git supposedly does some hard linking under the hood, so it
doesn't waste disk space.  I don't know if that applies to the working
directory files too, or just to the internal repository implementation
files.

> Is there a way to later automatically merge library changes done in
> different apps?

No, it's like any other change.  That library will have its own git repo
in that subdirectory.  You need to check out a branch, change it, then
push.  The other apps, even on the same machine, will not use the new
stuff until you tell it to.  That's a feature -- it will keep pinned to
what it was building against until you are ready to upgrade.

> > I've not taken it to its logical conclusion of libs that use other
> libs
> > which are also used directly by the app.
> 
> Yes, some of my libs use other libs, all of which are used by certain
> apps.
> 
> I've never used version control before. I always made a 'snapshot' of
> code a a milestone, but I'm hoping
> there is a better way.

Another way I thought about, that might be just the ticket for you, is
to make all the apps and libs in your current directory structure into
submodules of a single master suite repository, which doesn't have
anything in it other than those submodules.

--John
(mind the footer... here it comes!)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
