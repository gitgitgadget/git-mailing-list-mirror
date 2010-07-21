From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: CRLF behavior
Date: Wed, 21 Jul 2010 17:18:07 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:17:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObgfV-0004Hb-L6
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab0GUVR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 17:17:28 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:52794 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab0GUVR2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 17:17:28 -0400
X-ASG-Debug-ID: 1279747043-34be902c0001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id 2o5HCC9rhiPXSeiF (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <git@vger.kernel.org>; Wed, 21 Jul 2010 1
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Wed, 21 Jul 2010
 17:17:23 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: CRLF behavior
Thread-Topic: CRLF behavior
Thread-Index: AcspF3KghSga/e2ISt6qw5DTBBu9fg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1279747043
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151419>

I'm running MSYSgit on Windows, and have no mention of any kind of crlf=
 conversion in the config files.=A0 Running git config --list shows not=
hing that would suggest any such setting.=A0 So, my autocrlf is "unspec=
ified" which according to the docs defaults to false, which means "don'=
t mess with it", right?=0D
=0D
A co-worker got a autocrlf=3Dtrue set when some git tool was updated, a=
nd made a mess before it was noticed.=0D
=0D
Now, looking at one commit for example, I see a file in it that reports=
 all lines have changed.=A0 Clearly it's checked in with LF's, and gitk=
 will make it go away if I check the "ignore whitespace" box.=A0 The "e=
xternal diff" (kdiff3) reports "text is the same but files are not bina=
ry identical".=A0 So far, so good.=0D
=0D
But if I check out his commit, I see files with CRLF endings.=A0 Why is=
 it doing that?=A0 I had to spy on the temp files used by the diff tool=
 in order to see the LF line endings.=A0 So it seems able to cough up a=
 proper exact copy, but normally changes it during a checkout operation=
=2E=0D
=0D
I get mysterious things like after checking out, it immediately says I =
have a bunch of files changed.=A0 Or, it didn't show any; and after sav=
ing one file (no actual change) and rescanning, I had 5 files "changed"=
=2E=A0 I'm guessing it is getting confused because sometimes it sees th=
e internal representation and sometimes it sees the translated represen=
tation.=0D
=0D
What's going on?=0D
=0D
--John=0D
=0D
=0D
=0D
(sorry about the footer)=0D
=0D

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ G=
S: TRAD) of three operating subsidiaries, TradeStation Securities, Inc.=
 (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a=
 trading software and subscription company, and TradeStation Europe Lim=
ited, a United Kingdom, FSA-authorized introducing brokerage firm. None=
 of these companies provides trading or investment advice, recommendati=
ons or endorsements of any kind. The information transmitted is intende=
d only for the person or entity to which it is addressed and may contai=
n confidential and/or privileged material. Any review, retransmission, =
dissemination or other use of, or taking of any action in reliance upon=
, this information by persons or entities other than the intended recip=
ient is prohibited. If you received this in error, please contact the s=
ender and delete the material from any computer.
