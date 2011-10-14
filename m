From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Bug? url.insteadOf overwrites remote.pushUrl
Date: Fri, 14 Oct 2011 17:55:40 +0400
Message-ID: <CAB6D58F-A3C9-4532-A9CC-10E43CD34E4E@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 15:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REiEt-0002Kl-7K
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 15:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980Ab1JNNzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 09:55:44 -0400
Received: from mail1.intellij.net ([46.137.178.215]:34888 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977Ab1JNNzn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 09:55:43 -0400
Received: (qmail 12517 invoked by uid 89); 14 Oct 2011 13:55:41 -0000
Received: by simscan 1.1.0 ppid: 12483, pid: 12508, t: 0.0924s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 14 Oct 2011 13:55:41 -0000
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183575>


I've found that defining url.<base>.insteadOf overrides explicit remote.<name>.pushUrl.
On the other hand, pushInsteadOf doesn't override explicit pushUrl.
Is it a bug?

# cat .git/config
[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = github.com/klikh/Test.git 
	pushUrl = jetbrains.com/klikh/Test.git 
[url "http://"]
  insteadOf=jet

# git remote -v
origin	github.com/klikh/Test.git (fetch)
origin	http://brains.com/klikh/Test.git (push)


See also http://kerneltrap.org/mailarchive/git/2009/9/7/11264/thread - patch introducing pushInsteadOf & discussion 

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
