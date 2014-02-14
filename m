From: Josef Wolf <jw@raven.inka.de>
Subject: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 12:31:36 +0100
Message-ID: <20140214113136.GA17817@raven.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 13:00:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEHRT-0000C6-L9
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 13:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbaBNMAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 07:00:23 -0500
Received: from quechua.inka.de ([193.197.184.2]:53290 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbaBNMAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 07:00:22 -0500
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Feb 2014 07:00:22 EST
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1WEH7s-0004FE-0v; Fri, 14 Feb 2014 12:40:12 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 3992D7629A; Fri, 14 Feb 2014 12:31:36 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242096>

Hello folks,

after some commits to my master branch, I tried to push to the bare upstream
repository and got this error message:

  error: src refspec refs/heads/master matches more than one.

A quick check shows that there's indeed something wrong:

  jw@kiste:/git/scan$ git branch -a | grep master
  * master
    refs/heads/master
    remotes/origin/HEAD -> origin/master
    remotes/origin/master
  jw@kiste:/git/scan$ find .git -name master
  .git/refs/heads/master
  .git/logs/refs/remotes/origin/master
  .git/logs/refs/heads/master
  .git/logs/refs/heads/refs/heads/master
  jw@kiste:/git/scan$ find .git -name master
  .git/refs/heads
  .git/refs/heads/refs/heads
  .git/logs/refs/heads
  .git/logs/refs/heads/refs/heads
  jw@kiste:/git/scan$ find .git -name master

Notice the refs/heads _within_ refs/heads!

Now I wonder how I managed to get into this situation and what's the best way
to recover?

Any ideas?

PS: this is git-1.8.1.4.

-- 
Josef Wolf
jw@raven.inka.de
