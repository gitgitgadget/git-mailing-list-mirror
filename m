From: "J. Bakshi" <joydeep@infoservices.in>
Subject: can I use multiple worktree in same git repo  ?
Date: Wed, 20 Jul 2011 18:24:38 +0530
Message-ID: <20110720182438.3c40cf1d@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 20 14:54:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjWIS-0004Uf-18
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 14:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab1GTMyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 08:54:35 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:41049
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750979Ab1GTMye (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 08:54:34 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 18A571808001
	for <git@vger.kernel.org>; Wed, 20 Jul 2011 14:54:31 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177534>

Hello list,

Please bear with me as I am from svn domain and gradually making myself aware of git.

I have a site under htdocs which is modified by svn with the help of post-commit hook. But the svn folder structure is little different than the actual structure at filesystem.
Under htdocs/demo, say I have dir1, dir2 etc... where in svn I have the structure as 

[svn]
mysite-repo
|
|----------dir1------|trunk----src (here actually I have the contents of dir1)
|----------|---------|tags
|----------|---------|branches
|
|----------dir2------|trunk----src (here actually I have the contents of dir2)
|----------|---------|tags
|----------|---------|branches

And in file-system dir1 is mapped with (checkout from) and then (svn switch --relocate)  mysite-repo/dir1/trunk/src ;
dir2 is checkout from and then (svn switch --relocate) mysite-repo/dir2/trunk/src
and so on .....

Now the post-commit hook is tricky.

```````
#!/bin/bash

set -e

# LANG=en_US.UTF-8 for special character support

LANG=en_US.UTF-8 /usr/bin/svn up  /var/www/demo/dir1

LANG=en_US.UTF-8 /usr/bin/svn up  /var/www/demo/dir2

LANG=en_US.UTF-8 /usr/bin/svn up  /var/www/demo/dir3
````````````````

As a result whenever there is a commit , it updates the related folder in filesystem.
Say a commit at svn->mysite-repo->dir1->trunk->src ==> modify ==> /var/www/demo/dir1

Can I do the same in git with multiple worktree ? possible ?

Thanks
