From: jhapk <pradeep.kumar.jha@gmail.com>
Subject: Deleting remote branches
Date: Thu, 25 Mar 2010 21:46:55 -0800 (PST)
Message-ID: <1269582415273-4802262.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 06:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv2Ns-0001l9-Gw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 06:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab0CZFq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 01:46:58 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38805 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0CZFq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 01:46:57 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <pradeep.kumar.jha@gmail.com>)
	id 1Nv2Nj-0000wX-95
	for git@vger.kernel.org; Thu, 25 Mar 2010 22:46:55 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143208>


Hi,

I had a whole bunch of branches in my local and a remote repository. I
deleted all the redundant branches to be left with only three now. So the
result of $git branch on my local repository is
[pradeep@scaramanga cffc]$ git branch
  jeff
  master
* work
and on the remote directory which is called 'origin' it returns
[pradeep@scaramanga CFFC.git]$ git branch
  RANSmodel
* master
  work
But when I type the following command on my local branch, 
[pradeep@scaramanga cffc]$ git branch -a
  jeff
  master
* work
  origin/HEAD
  origin/RANSmodel
  origin/bluffbody
  origin/counterflow
  origin/flamelet
  origin/jeff
  origin/master
  origin/test
  origin/work
I still get all these branches which I deleted in my remote 'origin'.

My .git/config file looks like this
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = /nfs/carv/d1/people/pradeep/Repositories/CFFC.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[remote "jeff"]
        url = /nfs/kris/d1/people/jeff/cffc
        fetch = +refs/heads/pradeep:refs/remotes/jeff/pradeep
[branch "master"]
        remote = origin
        merge = refs/heads/master
[branch "work"]
        remote = origin
        merge = refs/heads/work
[push]
        default = matching
[branch "jeff"]
        remote = jeff
        merge = refs/heads/pradeep

Does anyone know why am I still getting branhces like origin/test when I do
$git branch -a
-- 
View this message in context: http://n2.nabble.com/Deleting-remote-branches-tp4802262p4802262.html
Sent from the git mailing list archive at Nabble.com.
