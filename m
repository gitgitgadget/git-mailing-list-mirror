From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: git pull with submodule
Date: Sat, 23 Jun 2012 15:53:26 +0200
Message-ID: <1564611.U3XyAbWYKV@toshi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 15:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sin0G-0004FM-1W
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 15:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab2FXNhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 09:37:20 -0400
Received: from babbelbox.org ([83.133.105.186]:52216 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298Ab2FXNhT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 09:37:19 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jun 2012 09:37:19 EDT
Received: (qmail 11459 invoked from network); 24 Jun 2012 13:30:39 -0000
Received: from p54aeaa5c.dip.t-dialin.net (HELO toshi.localnet) (sascha@babbelbox.org@84.174.170.92)
  by babbelbox.org with ESMTPA; 24 Jun 2012 13:30:39 -0000
User-Agent: KMail/4.8.3 (Linux/3.3.1-gentoo; KDE/4.8.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200529>

I noticed the following behaviour when pulling a repository that has a 
submodule.

I have a standalone checkout of my subproject, which I regulary sync it with 
its upstream and push the result to github. Then I go to my project where the 
github repository is setup to be a subproject, 'cd' into the subproject and do 
'git pull' there. After that, I commit the subproject blob into the 
superproject.

Now i switch OS and/or workstation and do a 'git pull' ( in root directory of 
superproject ). Git then
	-> fetches new objects of superproject
	-> fetches new objects of subproject
	-> checks out the subproject to the SHA1 currently recorded in
      the subproject blob. (Am i right on this one?)
	-> merges superproject with it's upstream

After that, i have to cd into the subproject and 'git pull' there again, 
because it just fetched the objects but did no merge nor checkout.

Is this intentional behaviour or am i doing something wrong / have wrong 
expectations in that "after seeing it recurring into the subproject, i expect 
i don't need to do further steps in order to have it up to date"?

SaCu

PS I'm using a mix of git Versions 1.7.{6,8,10}
