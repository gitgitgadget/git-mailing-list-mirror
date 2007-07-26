From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t9400-git-cvsserver-server (9, 11, 13)
Date: Thu, 26 Jul 2007 16:43:40 -0400
Message-ID: <166D8F2E-52B7-479F-B3E2-010691B87B9B@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:43:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEABW-0001jJ-2L
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 22:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbXGZUnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 16:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757143AbXGZUnm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 16:43:42 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38197 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbXGZUnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 16:43:41 -0400
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 5351F1FFC243
	for <git@vger.kernel.org>; Thu, 26 Jul 2007 20:43:41 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53868>

I'm still getting failures on t9400-git-cvsserver-server.  This  
appears to still be due to the fact that git-cvsserver is exiting  
with -1, which test_expect_failure doesn't like.  I have to assume  
this isn't happening on other people's machines.  If I can help  
someone with tracking down this error, I would be happy to.

~~ Brian Gernhardt

output of ./t9400-git-cvsserver-server.sh -v -d

*   ok 8: req_Root (strict paths)

* expecting failure: cat request-anonymous | git-cvsserver --strict- 
paths pserver $WORKDIR >log 2>&1
* FAIL 9: req_Root failure (strict-paths)
         cat request-anonymous | git-cvsserver --strict-paths pserver  
$WORKDIR >log 2>&1

* expecting success: cat request-anonymous | git-cvsserver pserver  
$WORKDIR/ >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"
*   ok 10: req_Root (w/o strict-paths)

* expecting failure: cat request-anonymous | git-cvsserver pserver  
$WORKDIR/gitcvs >log 2>&1
* FAIL 11: req_Root failure (w/o strict-paths)
         cat request-anonymous | git-cvsserver pserver $WORKDIR/ 
gitcvs >log 2>&1

* expecting success: cat request-base | git-cvsserver --strict-paths  
--base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"
*   ok 12: req_Root (base-path)

* expecting failure: cat request-anonymous | git-cvsserver --strict- 
paths --base-path $WORKDIR pserver $SERVERDIR >log 2>&1
* FAIL 13: req_Root failure (base-path)
         cat request-anonymous | git-cvsserver --strict-paths --base- 
path $WORKDIR pserver $SERVERDIR >log 2>&1

* expecting success: cat request-anonymous | git-cvsserver --export- 
all pserver $WORKDIR >log 2>&1 &&
    tail -n1 log | grep -q "^I LOVE YOU$"
*   ok 14: req_Root (export-all)
