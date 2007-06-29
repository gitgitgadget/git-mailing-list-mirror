From: Kumar Gala <galak@kernel.crashing.org>
Subject: recursive alternates with git-http-fetch
Date: Thu, 28 Jun 2007 21:33:59 -0500
Message-ID: <C78730FE-CF62-4EFE-9EF5-26D3D0315F3B@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 04:34:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I46JQ-0005t9-LB
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 04:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764893AbXF2CeA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 22:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764886AbXF2CeA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 22:34:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:55967 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764806AbXF2Cd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 22:33:59 -0400
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l5T2XugV004026
	for <git@vger.kernel.org>; Thu, 28 Jun 2007 21:33:57 -0500
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51144>

Is there a reason that git-http-fetch doesn't handle recursive  
alternates?

We have the following setup

my powerpc.git has an alternate that looks like:

/pub/scm/linux/kernel/git/paulus/powerpc.git/objects

paulus's has an alternate that looks like:

/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects

However git-http-fetch does get the 'torvalds' alternate and ends up  
having issues.  You get something like the following:

error: Unable to find 060a71d41ad7ccc3214065a182e6f67568420071 under
http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git/
Cannot obtain needed blob 060a71d41ad7ccc3214065a182e6f67568420071
while processing commit 7b7a57c77dccddd84b6aa02a38deee7ad97c977a.

(Note, I've set my alternates to point to both paulus/powerpc.git and  
torvalds/linux-2.6.git to make things work for people).

- k
