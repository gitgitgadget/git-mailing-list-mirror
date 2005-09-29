From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Really happy with cogito for inhouse teamwork, now that I've figured out cg-clone...
Date: Thu, 29 Sep 2005 17:58:56 +1200
Message-ID: <46a038f905092822587f5414d4@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 29 07:59:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKrRg-0000Yr-F4
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 07:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVI2F67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 01:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVI2F67
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 01:58:59 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:63940 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751188AbVI2F66 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 01:58:58 -0400
Received: by qproxy.gmail.com with SMTP id c12so455754qbc
        for <git@vger.kernel.org>; Wed, 28 Sep 2005 22:58:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cNGTPQ/vWVUER1/vL5vuJX5l8jaBWJOU9nCCF0D43gy+UKTnHLCrmgar55s63MuCyM6aEqmJlYi9O7wkoq/ZcZPImgcs/xjxOdujLjWhr6TUXFzYhDZy5F/yeLDPesRWFW1Z4JHdIOCGUAFzxNLiKm2GFXFeEBR2YPS0BnRsYsA=
Received: by 10.64.180.3 with SMTP id c3mr163929qbf;
        Wed, 28 Sep 2005 22:58:56 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 28 Sep 2005 22:58:56 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9465>

Just wanted to mention something that isn't in Cogito's readme, and
has been crucial in making our use of cogito straightforward.

We've made the transition a few weeks ago, and we've been _really_
happy with git/cogito (over cvs and tla, our "other" SCMs). Whoever,
there was something we all found ackward in how we did
clone/pull/push.

The _right_ way to do for a team with git-over-ssh is:

Doing the checkout the 'right' way:
 $ cg-clone git+ssh://locke.catalyst.net.nz/var/git/project.git#branchname
localdirname

Work cycle:
 # work work work
 $ cg-commit
 $ cg-update
 $ cg-push

The README doesn't talk about teams with "peer" access to a shared
repo. So I fumbled about and we were doing cg-clone using rsync (rsync
protocol or over ssh), or just straight http. This made pushing back
to the repo impossible with Cogito. So we were calling git-push
directly, with the risk of pushing to the wrong head (only really
risky for two very closely related heads, but still).

Now, I should put this into a patch to Cogito's README.... give me 5'...


martin
