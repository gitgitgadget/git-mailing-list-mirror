From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 16:56:44 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F07826@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F077AC@EXCHANGE.trad.tradestation.com> <37fcd2780903031302m5f98fe71u8bdb23f90a8df82a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:59:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lecdm-0006mZ-VR
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 22:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbZCCV5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 16:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZCCV5R
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 16:57:17 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:41970 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbZCCV5Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 16:57:16 -0500
X-ASG-Debug-ID: 1236117432-670a03360000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 27A3C1DFD49; Tue,  3 Mar 2009 16:57:12 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id CX6pnnwxB9642Ji4; Tue, 03 Mar 2009 16:57:12 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 16:57:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
In-Reply-To: <37fcd2780903031302m5f98fe71u8bdb23f90a8df82a@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Thread-Index: AcmcQ2cE+dS/JB/NQ8mWhM7oJNuWYAAAEjQQ
X-OriginalArrivalTime: 03 Mar 2009 21:57:12.0622 (UTC) FILETIME=[01F714E0:01C99C4B]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236117433
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112170>

===Re:===
If Microsoft fixed the problem with UTF-8 support in C runtime, it is
a really good
news, because setlocale did not work not so long time ago:
===end===

They totally replaced it with one written by P.J.Plauger.  I'm not sure
when, but I would guess around VC++7.1, which was a "sea change" and
felt more like a different brand than a simple update.  That's when
templates started following the standard.

Re:
http://blogs.msdn.com/michkap/archive/2006/03/13/550191.aspx

Interesting.  So it sort-of worked, as per my overlong muse as I looked
at the source code, but they started explicitly preventing it because it
doesn't always work for everything.

    //  verify codepage validity
    if (!iCodePage || iCodePage == CP_UTF7 || iCodePage == CP_UTF8 ||
        !IsValidCodePage((WORD)iCodePage))
        return FALSE;


===Re:===
As to Win32 API, it has always worked correctly with UTF-8... In fact,
the
documentation of GetOEMCP function goes as far as recommending
to use UTF-8 or UTF-16: "For the most consistent results, applications
should
use Unicode, such as UTF-8 or UTF-16, instead of a specific code page.
===end===

I remember a time when it did not.  I don't recall if it was NT (as
opposed to consumer windows) or some version of NT beyond 3.5 (starting
in 4?) that it became available.  But I had to supply code with the
program because it could not count on it.

===Re:===
So it would be great if Git supported UTF-8 on Windows (as an option),
but it
is not my itch right now....
===end===

someone else mentioned "most people use ASCII file names", and I would
take that to be true only if "most people" == "developers".  If you look
at my wife's "explorer" view, it's all Chinese.  Files are downloaded
with Asian file names.  Most people =in= China are used to seemless
support within Windows.  It's only with Chinese MUI on English Windows
that the "ANSI" stuff doesn't match and programs that use 8-bit API
calls suddenly croak as they see "?????" for input.

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
