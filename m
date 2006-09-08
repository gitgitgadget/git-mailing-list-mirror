From: Jehreg <jehreg@gmail.com>
Subject: Very complex rebasing - Need help
Date: Fri, 8 Sep 2006 06:27:38 -0700 (PDT)
Message-ID: <6208897.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 08 15:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLgOu-0003NM-Pj
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 15:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWIHN1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 09:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWIHN1k
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 09:27:40 -0400
Received: from www.nabble.com ([72.21.53.35]:27352 "EHLO talk.nabble.com")
	by vger.kernel.org with ESMTP id S1751102AbWIHN1j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 09:27:39 -0400
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1GLgOQ-0003fL-If
	for git@vger.kernel.org; Fri, 08 Sep 2006 06:27:38 -0700
To: git@vger.kernel.org
X-Nabble-From: jehreg@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26697>


So, I grabbed a tarball of the Buildroot project a year ago and started a git
repo, and created a branch and did changes:

initial---master
              \
                --o--o--o--o--myproject

A few months later, I grabbed another Buildroot tarball and I diffed it from
my master and applied it to master.

initial--o--(new tarball)--master
          \
           --o--o--o--o--myproject

Which I then merged into myproject and did some additional development.

initial--o--(new tarball)--o--master
          \                      \
           --o--o--o--o--o----o--o--o--o--myproject

My problem is that I would like to bring in the svn-into-git repo of the
Buildroot project.

initial--ID1--(new tarball)--ID2--master
          \                          \
           --o--o--o--o--o-----o--o--o--o--myproject
other repo of the Buildroot project:
initial--o--o--ID3--o--o--ID4--o--master

So, I can actually match ID1=ID3 and ID2= ID4.

I can use rebase to do this:

In the Buildroot repo:
initial--o--o--ID3--o--o--ID4--o--master
                  \
                   --o--o--o--o--o--o--o--o--myproject

My problem is that I need to kinda-rebase the ID4 into the myproject branch
to make it finally look like this:

initial--o--o--ID3--o--o--ID4--o--master
                  \               \
                   --o--o--o--o--o--o--o--o--myproject


Any ideas ?

-- 
View this message in context: http://www.nabble.com/Very-complex-rebasing---Need-help-tf2239083.html#a6208897
Sent from the git forum at Nabble.com.
