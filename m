From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: cogito remote branch
Date: Sun, 11 Nov 2007 14:11:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711111409440.9401@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 14:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrCb6-0007A8-7t
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 14:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXKKNLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 08:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbXKKNLR
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 08:11:17 -0500
Received: from mailout01.sul.t-online.de ([194.25.134.80]:46302 "EHLO
	mailout01.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764AbXKKNLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 08:11:16 -0500
Received: from fwd27.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1IrCao-0002QG-07; Sun, 11 Nov 2007 14:11:14 +0100
Received: from [192.168.2.100] (bpIun-ZJwha+k8j1+JAJqXHyOI5ouyVRN+tf47GpSepeHWemXtfA8-MibQzaSjwZjx@[84.163.241.124]) by fwd27.t-online.de
	with esmtp id 1IrCan-11y4OG0; Sun, 11 Nov 2007 14:11:13 +0100
X-X-Sender: michael@castor.milkiway.cos
X-ID: bpIun-ZJwha+k8j1+JAJqXHyOI5ouyVRN+tf47GpSepeHWemXtfA8-MibQzaSjwZjx
X-TOI-MSGID: 3e9b4531-1216-432c-b9f0-1b757745c4ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64454>



>Michael Dressel wrote:
>Ok nice. Another thing is that git-push will push all the tracking 
>branches in refs/remotes/origin. 

I learned that I only have to edit the .git/config file to avoid that 
git-push pushes everything. 

I modified the remotes names and added push lines explicitly.

Is that the recommended way?

In my example (git-branch -a -v):
* exp                 aa854c6 shtest 4
  master              34924b9 mastertest 1
  origin/exp          aa854c6 shtest 4
  origin/master       b68e7a9 brt master 1

I used the following .git/config:
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin1"]
        url = /home/repo/src
        fetch = +refs/heads/master:refs/remotes/origin/master
        push = +refs/heads/master:refs/heads/master
[remote "origin2"]
        url = /home/repo/src
        fetch = +refs/heads/exp:refs/remotes/origin/exp
        push = +refs/heads/exp:refs/heads/exp
[branch "master"]
        remote = origin1
        merge = refs/heads/master
[branch "exp"]
        remote = origin2
        merge = refs/heads/exp

Cheers,
Michael
