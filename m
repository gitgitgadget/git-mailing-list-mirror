From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: how to arrange source control?
Date: Mon, 27 Apr 2009 18:08:02 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3EC2C@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <bob@hindbrain.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 00:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZ0J-0007dB-RV
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827AbZD0WIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755795AbZD0WIa
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:08:30 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:59398 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbZD0WIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 18:08:30 -0400
X-ASG-Debug-ID: 1240870083-6d8b01040000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id 6FC803A3C13; Mon, 27 Apr 2009 18:08:03 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id ZnHrTPh2auOpWesQ; Mon, 27 Apr 2009 18:08:03 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Apr 2009 18:08:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: how to arrange source control?
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: how to arrange source control?
Thread-Index: AcnHhKG/LXUY1Ce+RP+yj5mZTZZnWQ==
X-OriginalArrivalTime: 27 Apr 2009 22:08:03.0082 (UTC) FILETIME=[A263A6A0:01C9C784]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240870083
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117719>

>> what is the best way to use git? Should I run "git add ." in
'rootdir' or run it in each 
>> application and library?
>> These libraries are used by all of the applications.

I had a similar issue I discussed on this mailing list a few weeks ago.

If the apps really are separate apps, from a development perspective,
you will want each in a separate repository.  That way you are not
always being bothered by totally irrelevant changes by others.

But, git doesn't like the libraries arranged that way.  If you make each
library a git submodule, they will all be in a subdirectory under each
app, not a peer with them.  This does have the advantage that each app
could be using a different version of the libs.  If they are meant to be
released as a suite, you will still find that handy during development,
while waiting for the ripple effect to catch up to the top level after
something changes in a lib.

I've not taken it to its logical conclusion of libs that use other libs
which are also used directly by the app.

If you keep your existing directory structure, you can certainly make
each lib its own repository, and not rely on git to track specific
library versions for you.  But I think that will bite you when you need
to check out something old, such as to make a patch for an existing
version or compare behavior against an older version.

--John
(please forgive the footer; it's not my idea or my choice)


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
