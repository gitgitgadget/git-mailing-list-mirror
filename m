From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: url.<base>.insteadOf with empty value
Date: Fri, 14 Oct 2011 13:03:53 +0400
Message-ID: <54556728-92C0-4992-9831-0D582C383235@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 11:04:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REdgQ-0007eG-Ka
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 11:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab1JNJD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 05:03:57 -0400
Received: from mail1.intellij.net ([46.137.178.215]:57330 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab1JNJD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 05:03:57 -0400
Received: (qmail 28388 invoked by uid 89); 14 Oct 2011 09:03:54 -0000
Received: by simscan 1.1.0 ppid: 28354, pid: 28379, t: 0.1091s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 14 Oct 2011 09:03:54 -0000
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183558>

If I don't specify any value for url.<base>.insteadOf or url.<base>.pushInsteadOf, Git substitutes all urls for remotes defined in .git/config

Probably that's because any url starts with empty string and thus has to be substituted. 
But it might be a bit confusing, because on the other hand if no value is given to the property insteadOf, user may expect this property to be ignored.

Please check if current Git behavior is correct. 

If it is not a bug, I'd suggest to add a note to man git-config about this.

# git version
git version 1.7.6

# cat .git/config
[remote "origin"]
  fetch = +refs/heads/*:refs/remotes/origin/*
  url = github.com/klikh/Test.git 
  pushUrl = jetbrains.com/klikh/Test.git 
[url "http://"]
  insteadOf=

# git remote -v
origin	http://github.com/klikh/Test.git (fetch)
origin	http://jetbrains.com/klikh/Test.git (push)




----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
