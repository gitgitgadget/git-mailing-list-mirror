From: Adam Roben <aroben@apple.com>
Subject: "make test" fails if /path/to/git.git contains spaces
Date: Mon, 31 Mar 2008 17:51:23 -0400
Message-ID: <47F15CDB.60109@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 23:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgS2j-0001Vy-T5
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 23:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbYCaV7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756634AbYCaV7K
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 17:59:10 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:52592 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbYCaV7J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 17:59:09 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2008 17:59:09 EDT
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id A8C9527B296B
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 14:51:24 -0700 (PDT)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 92CE52807F
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 14:51:24 -0700 (PDT)
X-AuditID: 11807130-aa8d0bb0000008b8-a1-47f15cdbd6aa
Received: from [10.0.169.7] (unknown [17.151.126.45])
	by relay11.apple.com (Apple SCV relay) with ESMTP id EBB362807D
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 14:51:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78607>

I've noticed that "make test" fails if /path/to/git.git contains spaces, 
with the following error:

> $ make test
> make -C t/ all
> make[1]: Entering directory `/home/Adam Roben/dev/git/t'
> *** t0000-basic.sh ***
> * error: cannot run git init -- have you built things yet?
> make[1]: *** [t0000-basic.sh] Error 1
> make[1]: Leaving directory `/home/Adam Roben/dev/git/t'
> make: *** [test] Error 2

This is a very common configuration on Cygwin, but clearly not a common 
configuration for git developers, or else this error would have been 
corrected already.

Do we want to support having spaces in your path? It doesn't seem hard 
to fix, but it does seem like the kind of problem that will come up over 
and over again if only a very small set of people have this configuration.

-Adam
