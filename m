From: Ian Kumlien <pomac@vapor.com>
Subject: [FYI] very large text files and their problems.
Date: Wed, 22 Feb 2012 16:49:26 +0100
Message-ID: <20120222154926.GC11202@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 16:58:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0EYj-0004uJ-H0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 16:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab2BVP4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 10:56:43 -0500
Received: from mail.vapor.com ([83.220.149.2]:37293 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab2BVP4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 10:56:43 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Feb 2012 10:56:43 EST
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 4AAEC40CA4B
	for <git@vger.kernel.org>; Wed, 22 Feb 2012 16:49:28 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 1B4958E046C; Wed, 22 Feb 2012 16:49:26 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191262>

Hi, 

We just saw a interesting issue, git compressed a ~3.4 gb project to ~57
mb. But when we tried to clone it on a big machine we got:

fatal: Out of memory, malloc failed (tried to allocate
18446744072724798634 bytes)

This is already fixed in the 1.7.10 mainline - but it also seems like
git needs to have atleast the same ammount of memory as the largest
file free... Couldn't this be worked around?

On a (32 bit) machine with 4GB memory - results in:
fatal: Out of memory, malloc failed (tried to allocate 3310214313 bytes)

(and i see how this could be a problem, but couldn't it be mitigated? or
is it bydesign and intended behaviour?)

I'm not subscribed to please keep me in CC.

/Ian Kumlien
