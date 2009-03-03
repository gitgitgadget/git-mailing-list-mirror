From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 13:25:14 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F076D2@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <peter@softwolves.pp.se>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZM3-00062f-C9
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758486AbZCCS0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 13:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758469AbZCCS0Q
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:26:16 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:47758 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795AbZCCS0O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 13:26:14 -0500
X-ASG-Debug-ID: 1236104767-2f03022b0004-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 5B8731E309A; Tue,  3 Mar 2009 13:26:08 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id yeEGaG63645a0rXU; Tue, 03 Mar 2009 13:26:08 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 13:26:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Thread-Index: AcmcLWV0kSIxeFjKTce+ctR46iNR1g==
X-OriginalArrivalTime: 03 Mar 2009 18:26:07.0630 (UTC) FILETIME=[850AAAE0:01C99C2D]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236104768
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112142>

===Re:===
The other way would be to keep the char* APIs but convert to the Windows

locale encoding ("ANSI codepage"), but that will break horribly as not
all 
file names that can be used on a file system can be represented as such.
===end===

Actually, UTF-8 is a valid code page on Windows.  The code page ID is
65001.  So, if you set the process code page to that, =and= set the file
system API's code page to follow rather than using the OEM code page
(the default), it should work just fine.

Also, there is a national code page that =will= represent all file names
on the systems and is supported:  That is the Chinese GB18030, code page
54936.  That has every character that Unicode does, just encoded
differently to be forward compatible with GBK.  That is fully supported
by windows, as it is required by law to sell in Chinese markets.

Let me know if I can be of help.  I know character set stuff and Win32
fairly well.

--John



TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
