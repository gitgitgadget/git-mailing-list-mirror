From: Johannes Sixt <j.sixt@viscovery.net>
Subject: rev-list --reverse --full-history --parents with path limiter disconnects
 history
Date: Thu, 21 Aug 2008 18:27:50 +0200
Message-ID: <48AD9786.80707@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080901060203030705050502"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 18:29:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWD20-00026c-Nj
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYHUQ17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbYHUQ17
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:27:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32316 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbYHUQ16 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:27:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KWD0p-0005bP-5U; Thu, 21 Aug 2008 18:27:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BC5866B7; Thu, 21 Aug 2008 18:27:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93171>

This is a multi-part message in MIME format.
--------------080901060203030705050502
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Attached is a repository (to be imported via git fast-import) that has
such a history:

o--o--A--B--o
 \           \
  o--o--C-----M--o--X   <- master

where the A,B,C touch path P2 such that P2 is the same after B and C.
Commit X touches P2 as well.

This command does not give the expected result: It reports *two* initial
commits and one merge; in particular, commit X is reported as initial commit.

$ git rev-list --parents --reverse --full-history master -- P2

This command gives the expected result, i.e. there is one initial commit,
one merge, and some more regular commits:

$ git rev-list --parents --full-history master -- P2

And this works as well, i.e there is a linear history that omits the
branch via C:

$ git rev-list --parents --reverse master -- P2

Please help!

BTW, I've observed this behavior earlier when I debugged David Tweed's
repository, after which we removed --full-history from git-filter-branch.
But I could not easily find a simple history that exposes the problem. Now
I have such a history.

BTW2, using --simplify-merges instead of --full-history has the same
problem (but I don't think that comes as a surprise).

-- Hannes

--------------080901060203030705050502
Content-Type: application/octet-stream;
 name="example.git.gfi.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example.git.gfi.bz2"

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
fMRuo2EdoI+YI/ICDYBHiCP/i7kinChICHwK0oA=
--------------080901060203030705050502--
