From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 00:27:02 -0400
Message-ID: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 06:33:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upt2U-0006Z8-JU
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 06:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965396Ab3FUEda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 00:33:30 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50888 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965258Ab3FUEda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 00:33:30 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2013 00:33:29 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 0D98C27362F7; Fri, 21 Jun 2013 04:27:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 440B227362E1;
	Fri, 21 Jun 2013 04:27:02 +0000 (UTC)
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228569>

I've bisected it to this commit:

> commit 0442743810c6f6c14386a5a9d6bf8e4d69adbc51
> Author: Jeff King <peff@peff.net>
> Date:   Sun Jun 9 04:07:59 2013 -0400
> 
>     t/lib-httpd/apache.conf: do not use LockFile in apache >= 2.4

OS X 10.8.4, apache 2.2.22

I'll also note that the tests fail the first time they attempt to access the server and the cleanup function notes that httpd is not running under the expected PID.  Looking at the httpd setup code, I would have expected to see errors (with -v) and have the setup fail but neither happens.

It's way too late for me, so I can't look at it again for at least several hours.  I figured I'd ping the list in case the problem/solution is obvious to someone else.

~~ Brian Gernhardt
