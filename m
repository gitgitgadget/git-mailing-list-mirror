From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: (unknown)
Date: Sun, 11 Nov 2007 14:08:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711111359590.9401@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 14:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrCZ0-0006eb-9H
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 14:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbXKKNJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 08:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXKKNJF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 08:09:05 -0500
Received: from mailout08.sul.t-online.de ([194.25.134.20]:58178 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751306AbXKKNJE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 08:09:04 -0500
Received: from fwd27.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1IrCYe-0008Mf-02; Sun, 11 Nov 2007 14:09:00 +0100
Received: from [192.168.2.100] (XNKKq8Z68hZ9J6pGhIJqMvJ8yx0ebD9WpMrzNvB-FV84rfckLGCAqKIHXBjuezpwHe@[84.163.241.124]) by fwd27.t-online.de
	with esmtp id 1IrCYV-1QHFS40; Sun, 11 Nov 2007 14:08:51 +0100
X-X-Sender: michael@castor.milkiway.cos
X-ID: XNKKq8Z68hZ9J6pGhIJqMvJ8yx0ebD9WpMrzNvB-FV84rfckLGCAqKIHXBjuezpwHe
X-TOI-MSGID: 422b9ed7-f46c-4b65-9213-bbf6bb1eb93c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64453>


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
