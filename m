From: Jon Nelson <jnelson-git@jamponi.net>
Subject: git-ls-files handling of 'missing' files
Date: Mon, 13 Feb 2006 21:46:44 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0602132126210.6352@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 14 04:46:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8r9P-0007cS-Uu
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 04:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWBNDqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 22:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWBNDqt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 22:46:49 -0500
Received: from mxsf33.cluster1.charter.net ([209.225.28.158]:2981 "EHLO
	mxsf33.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1030305AbWBNDqs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 22:46:48 -0500
Received: from mxip15a.cluster1.charter.net (mxip15a.cluster1.charter.net [209.225.28.145])
	by mxsf33.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id k1E3kjvR004783
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 22:46:45 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip15a.cluster1.charter.net with ESMTP; 13 Feb 2006 22:46:45 -0500
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id BA825690CA; Mon, 13 Feb 2006 21:46:44 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id ACBC2690C9
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 21:46:44 -0600 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16108>


git-ls-files appears to treat missing files as both removed /and/ 
modified, neither of which really seems right. Perhaps a new state, 
'missing', is worthwhile?

Also, the documentation for git-ls-files is a bit confusing to me:

(aside: I assume that the '?' is a mis-typed '/')

The documentation confuses me when it says that files marked with a 'K' 
are "to be killed / other" - it don't understand why 'killed' and 
'other' are lumped together.

The docs for git-ls-files indicate that a file marked as 'killed' (wrong 
tense?) is a file that needs to be removed for git-checkout-index to 
succeed. The manpage doesn't say why git-checkout-index needs to succeed 
or under what conditions git-checkout-index would be invoked. (ie, "why" 
should I manually remove this file).

Would it also be worthwhile to change the terminology used? 
Specifically, it seems that 'unchanged' is more readily understandable 
than 'cached', and the past tense of 'killed' throws me. I can offer no 
improvement there, however.

It seems to me that files can also exist in the state 'new' or 'added' 
(is this the same as unmerged?) Is there a state for 'conflict'?

Sorry for all of the questions, I've really been enjoying using git but 
every now and again something thows me - tonight it was git-ls-files. 
;-)

--
Jon Nelson <jnelson-git@jamponi.net>
