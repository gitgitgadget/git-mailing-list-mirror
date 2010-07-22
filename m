From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: Running git on Windows command line
Date: Thu, 22 Jul 2010 12:31:06 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 22 18:46:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obyus-0001UY-4c
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 18:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756913Ab0GVQqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 12:46:32 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:35741 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0GVQqa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 12:46:30 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jul 2010 12:46:30 EDT
X-ASG-Debug-ID: 1279816267-34bf66be0001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id tSkpJnz1msXDqlk5 (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <git@vger.kernel.org>; Thu, 22 Jul 2010 1
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Thu, 22 Jul 2010
 12:31:07 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: Running git on Windows command line
Thread-Topic: Running git on Windows command line
Thread-Index: Acspu0i7m1G9I5UJTK63xgRb0Et3TA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1279816267
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151461>

In the "CRLF behavior" thread, I found that my command line was not seeing the global settings.  This gave different results than the git-gui and naturally is a serious problem.



This note is to record my findings and will hopefully be valuable to others using Windows.



In Windows, users may be using the built-in CMD.exe, the Powershell, some other unix-like shell besides the one that comes up under "git bash here", or others.



I found that it worked correctly on a plain CMD shell with no personal preferences loaded or anything, even though the HOME environment variable does not exist.  It did not work right on my normal shell (happens to be TCC-le) which was set up about two years ago, until I added the HOME variable to my initialization script.



The plain command line adds "C:\Program Files (x86)\Git\cmd" to the PATH, and the git command resolves to git.cmd in that directory.  The latest msysgit installer set up that path globally.  Perhaps an earlier version arranged things differently?  Anyway, the TCC command line had an alias set up so git resolved to "C:\Program Files (x86)\Git\bin\git.exe", without searching.  If the situation changed with updates, it did not affect my set up there.



One of the things the git.cmd batch file does is set the HOME variable.  It also sets the code page and sets the PATH to include a couple things along the git tree.  Two years ago, I found that no such PATH was necessary once git.exe itself was launched; it apparently knows where everything else is.  One of the things it adds to PATH, %git_install_root%\mingw\bin, does not even exist!  So this script may be dated.



I'd be interested in finding out what the real story here is, if anyone knows more about it.



--John







(sorry about the footer; it is not my idea nor my choice)


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
