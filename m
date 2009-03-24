From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Project With Reusable Libraries
Date: Tue, 24 Mar 2009 12:40:06 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A5597A8@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm9hy-0008VC-BB
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 17:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763030AbZCXQlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 12:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762344AbZCXQk7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 12:40:59 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:40556 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762008AbZCXQkz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 12:40:55 -0400
X-ASG-Debug-ID: 1237912851-272101bb0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id BD09922FA67
	for <git@vger.kernel.org>; Tue, 24 Mar 2009 12:40:51 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id F5hw5nh2XF9aHYVa for <git@vger.kernel.org>; Tue, 24 Mar 2009 12:40:51 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Mar 2009 12:40:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Project With Reusable Libraries
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Project With Reusable Libraries
Thread-Index: AcmsnzBqmBk8I3MKQKeJAaX6ULPUCg==
X-OriginalArrivalTime: 24 Mar 2009 16:40:51.0271 (UTC) FILETIME=[4ADF8570:01C9AC9F]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237912851
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114473>

Consider a directory tree something like this:

	...
	foo\
	  bar\
	   project-root\
	     app1\
	         contents of app1
	     app2\
	         contents of app2
	     lib1\
	         contents of library 1
	     lib2\
	         contents of library 2


Each project, whether application or library, has its own git repository
already.  A program, say app1, is now dependant on the libraries.  The
libraries are meant to be used in multiple applications.

This is not like what is described under subprojects, since the libs are
not "under" the application, but are peers in the directory structure.
It would be wrong to put lib1 and lib2 as subdirectories of app1 because
they are also used by app2, right?

Then again... if app1 and app2 are not always built as part of the same
set, they might have different versions of the libs specified.  I
understand that the newer versions of msysgit do hard linking so having
multiple repositories for the same thing won't waste disk space, but
still requires fetching to keep them in sync?

Anyway, how would you do it?

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
