From: chris <jugg@hotmail.com>
Subject: checkout new branch tracks wrong remote (bug?)
Date: Wed, 30 Mar 2011 02:27:31 +0000 (UTC)
Message-ID: <loom.20110330T040437-823@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 04:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4lFd-0001Y0-AE
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 04:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1C3CfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 22:35:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:50501 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab1C3CfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 22:35:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q4lFQ-0001Vn-F0
	for git@vger.kernel.org; Wed, 30 Mar 2011 04:35:05 +0200
Received: from 114-38-66-34.dynamic.hinet.net ([114.38.66.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 04:35:04 +0200
Received: from jugg by 114-38-66-34.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 04:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 114.38.66.34 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.16) Gecko/20110323 Ubuntu/10.04 (lucid) Firefox/3.6.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170348>

I have two remotes configured.

One is "origin" which has a local tracking branch "master" for "origin/master".

The other is "mirror" which has option mirror = true

While on the local branch master, I issue the command:

$ git checkout -b wip

The branch "wip" is created and oddly configured to track the "mirror" remote.

Here is the .git/config after the "wip" branch was created:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = ssh://myserver.com/srv/git/myproject.git
[branch "master"]
        remote = origin
        merge = refs/heads/master
[remote "mirror"]
        url = ssh://chris@myserver.com/srv/git/mirrors/chris/myproject.git
        fetch = +refs/*:refs/*
        mirror = true
[branch "wip"]
        remote = mirror
        merge = refs/heads/master

$ git --version
git version 1.7.4.1
$ git config branch.autosetupmerge
$

I do not expect this "wip" branch to be tracking the "mirror" remote, but rather
"origin", according to the documentation.

chris
