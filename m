From: "J. Bakshi" <joydeep@infoservices.in>
Subject: git with detached worktrees , push has no effect
Date: Thu, 14 Jul 2011 18:10:19 +0530
Message-ID: <20110714181019.2453e3a8@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 14:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhLDN-00057W-0v
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 14:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab1GNMkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 08:40:18 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:41573
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478Ab1GNMkR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 08:40:17 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id AE6792004001
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 14:40:14 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177126>

Hello list,


I have set the git bare repo with detached worktree to update website with post-receive hook. In short what I have done

[1] create the bare git with hook
-------------------------------------

git init --bare /home/git/web.git

cat > home/git/web.git/hooks/post-receive
#!/bin/sh
GIT_WORK_TREE=/opt/web git checkout -f

chmod +x /home/git/web.git/hooks/post-receive

chown -rvf wwwrun:www /home/git/web.git


[2] create the directory and set permission
--------------------------------------------

mkdir /opt/web
chown -Rvf wwwrun:www /opt/web


[3] cloning at my clinet and push
-----------------------------------

 git clone http://192.168.1.1/git/web.git

Cloning into web...
Username:
Password:
warning: You appear to have cloned an empty repository.

 touch A
 git add A

 git commit -m "add A"

[master (root-commit) 7662edd] add A
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 A

 git push
 Username:
 Password:
 Everything up-to-date


Why reports  [Everything up-to-date] rather than modify the remote git ?

Confused :-( 
