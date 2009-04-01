From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: More help with "pull" please
Date: Wed, 1 Apr 2009 18:53:10 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A7D4E71@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com> <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Tomas Carnecky" <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 00:55:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp9Kp-0007Ln-3l
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 00:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbZDAWxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 18:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbZDAWxb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 18:53:31 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:59847 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbZDAWxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 18:53:30 -0400
X-ASG-Debug-ID: 1238626407-148700940004-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 7A54427E886; Wed,  1 Apr 2009 18:53:28 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id PPJ6cHrfDTvlMiFg; Wed, 01 Apr 2009 18:53:28 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.122]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Apr 2009 18:53:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: More help with "pull" please
In-Reply-To: <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More help with "pull" please
Thread-Index: AcmzBrOi3o6hpeVdSW+JfEeJNckFGwABNDNA
X-OriginalArrivalTime: 01 Apr 2009 22:53:27.0437 (UTC) FILETIME=[AB7DBBD0:01C9B31C]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1238626408
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115423>

> When you create a branch, you can tell git which remote branch it
> tracks, like this:
> 
> $ git branch --track mynext origin/next
> 
> So whenever you are on brach 'mynext' and do a git-pull, it will fetch
> and merge origin/next.
> 
> You can do the same with the git-checkout command:
> 
> $ git checkout --track origin/next
> 
> This will create a local branch 'next' which tracks 'origin/next'
> 

OK, that works by adding something to the config file, right?  The docs
don't say, but does mention "having Pull: <refspec> lines for a
<repository>".  Does tracking add Pull: lines, or is that another
feature?

> 
> $ git clone $url XXX
> $ cd XXX
> $ git checkout --track origin/ReleaseCandidate
> ...
> $ git pull # will automatically fetch and merge
origin/ReleaseCandidate

According to the manpage on pull, "While git-pull run without any
explicit <refspec> parameter takes default <refspec>s from Pull: lines,
it merges only the first <refspec> found into the current branch, after
fetching all the remote refs."

Also, "When no refspec was given on the command line ... If
branch.<name>.merge configuration for the current branch <name> exists,
that is the name of the branch at the remote site that is merged."  So
is that yet again different from having Pull: lines?  If so, I'm fine if
no "Pull:" lines exist, or it would merge the first refspec found there.

Also, "Normally the branch merged in is the HEAD of the remote
repository, but the choice is determined by the branch.<name>.remote and
branch.<name>.merge options; see git-config(1) for details."  That
agrees with the previous.  If branch.<name>.merge configuration exists,
I don't need to worry about the remote HEAD.


> $ git checkout --track origin/ReleaseCandidate

That command does not work.  It compains that --track can only be used
with -b, etc.

I think 
	git checkout -b origin/ReleaseCandidate

is the correct shortcut?  

	git checkout -b ReleaseCandidate origin/ReleaseCandidate

did work.  I know that --track is automatic if the second argument is
remote.

--John




TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
