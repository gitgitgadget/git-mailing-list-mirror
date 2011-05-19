From: Mark Jason Dominus <mjd@plover.com>
Subject: Bug report : git-status manual fibs about semantics of --porcelain
Date: Thu, 19 May 2011 14:01:12 -0400
Organization: P.D.Q. Bernoulli Institute of Lower Mathematics
Message-ID: <30543.1305828072@plover.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7XZ-0000DT-36
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933747Ab1ESSBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 14:01:35 -0400
Received: from vms173019pub.verizon.net ([206.46.173.19]:57131 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933691Ab1ESSBf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 14:01:35 -0400
Received: from plover.com ([unknown] [72.92.113.143])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLG000XQFE1CX50@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 19 May 2011 13:01:14 -0500 (CDT)
Received: (qmail 30545 invoked by uid 1000); Thu, 19 May 2011 18:01:12 +0000
Received: from localhost (HELO plover.com) (sendmail-bs@127.0.0.1)
 by localhost with SMTP; Thu, 19 May 2011 18:01:12 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173983>


The 1.7.5.1 manual says:

     --porcelain::
    	Give the output in a stable, easy-to-parse format for scripts.
    	Currently this is identical to --short output, but is guaranteed
    	not to change in the future, making it safe for scripts.

However, this is not actually true.  --porcelain differs from --short
in at least two ways, one of them significant.  

--short is colorized when color.status = auto, while --porcelain is
not.

More importantly, --short reports file paths relative to the
current directory, while --porcelain reports file paths relative to
the root of the repository.

All of this was the case in 1.7.0.4 also, and presumably the versions
in between.

Mark Jason Dominus 	  			                 mjd@plover.com
