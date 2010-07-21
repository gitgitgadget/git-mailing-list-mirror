From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: RE: CRLF behavior
Date: Wed, 21 Jul 2010 18:25:54 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EB93992A@FL01EXMB01.trad.tradestation.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
 	<AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com>
 	<1A9EA7E081C3FE46A0F446FFB66D10EB9398FF@FL01EXMB01.trad.tradestation.com>
 	<AANLkTinyTlrkALbfVqdqzr_O4ClN-JGS9zsYwH1Upe1v@mail.gmail.com>
 <AANLkTiktnUV8WWSFcsj461QiG6WNv_kKxNFdJ5MBtdoy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 00:25:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObhjJ-0007JQ-By
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 00:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab0GUWZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 18:25:19 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:53454 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab0GUWZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 18:25:19 -0400
X-ASG-Debug-ID: 1279751111-34bf9bed0001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id rETvVcxDw1JOyJPh (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Wed, 21 Jul 2010 18:25:11 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Wed, 21 Jul 2010
 18:25:10 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: RE: CRLF behavior
Thread-Topic: CRLF behavior
Thread-Index: AcspHxXyObIxf2S2SE+AcFusc4Wy6wAAYN9Q
In-Reply-To: <AANLkTiktnUV8WWSFcsj461QiG6WNv_kKxNFdJ5MBtdoy@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1279751111
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151430>

> It take it back: it does do this.  But if $HOME isn't set, apparently

> it silently fails to read $HOME/.gitconfig and uses a different set of

> options.  Just confirmed this myself, and it's true.  This probably

> should be considered a serious bug.

> 

> Avery



The "git bash here" launches a copy of CMD.exe (the brain-dead Windows shell that's descendant from COMMAND.COM) with a command line that tells it to run sh.exe --login -i.

I see that neither the CMD process nor the sh.exe process contains a HOME environment variable.  So, the $HOME reported within bash is something that bash itself came up with based on Windows settings, and was not set before running it.



The wish.exe running git-gui _does_ contain a HOME environment variable, set to a natural Windows path.  It also contains others, such as GIT_DIR that contains the current repository it was started for, as a Windows drive-letter-path but with Unix-style slashes, and GIT_ASK_YESNO.  Presumably these were set as part of the machinery that launched the program from the context menu in explorer.  I don't see how it's being launched -- it does not show up in Autoruns (from Sysinternals).






TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
