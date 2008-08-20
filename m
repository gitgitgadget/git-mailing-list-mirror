From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [BUG] pull faulty 'not uptodate'
Date: Wed, 20 Aug 2008 23:00:42 +0200
Message-ID: <1508D1DF-EDE7-4A64-B354-E2F26578E24D@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:02:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuoV-00024V-2R
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbYHTVAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbYHTVAv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:00:51 -0400
Received: from frim.nl ([87.230.85.232]:52690 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932AbYHTVAu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 17:00:50 -0400
Received: from 113.25-64-87.adsl-dyn.isp.belgacom.be ([87.64.25.113] helo=[192.168.1.15])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KVunQ-0005Ia-Jv
	for git@vger.kernel.org; Wed, 20 Aug 2008 23:00:48 +0200
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93043>

Hi,

I think git pull does not refresh the index before trying to merge:

Tirana:gitbot pieter$ git reset --hard 5ff4dff
HEAD is now at 5ff4dff Add a Git FAQ plugin
Tirana:gitbot pieter$ touch test/gitfaq.rb
Tirana:gitbot pieter$ git pull
Updating 5ff4dff..931a247
error: Entry 'test/gitfaq.rb' not uptodate. Cannot merge.
Tirana:gitbot pieter$ git st
# On branch master
# Your branch is behind 'origin/master' by 2 commits, and can be fast- 
forwarded.
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	GitLink.py
#	faq.yaml
#	test.py
nothing added to commit but untracked files present (use "git add" to  
track)
Tirana:gitbot pieter$ git pull
Updating 5ff4dff..931a247
Fast forward
  plugins/gitfaq.rb  |   46 ++++++++++++++++++++++--------------------
  plugins/irc.rb     |   56 +++++++++++++++++++++++++ 
+-------------------------
  test/faq-test.html |   10 +++++++++
  test/gitfaq.rb     |   42 +++++++++++++++++++-------------------
  4 files changed, 84 insertions(+), 70 deletions(-)
  create mode 100644 test/faq-test.html
