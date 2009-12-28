From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: Re: Newbie to git
Date: Mon, 28 Dec 2009 22:23:52 +0000
Message-ID: <4e972734347b7ad47786807a7abe1c0e@192.168.1.222>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>	 <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>	 <26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>	 <0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222>	 <m27hs8t5b7.fsf@whitebox.home> <76c5b8580912280851k141bc6cev36df72b1993b8359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 23:23:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPNzs-0006UY-1Q
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 23:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbZL1WXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 17:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbZL1WXW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 17:23:22 -0500
Received: from mailrly07.isp.novis.pt ([195.23.133.217]:60411 "EHLO
	mailrly07.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbZL1WXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 17:23:22 -0500
Received: (qmail 24933 invoked from network); 28 Dec 2009 22:23:19 -0000
Received: from unknown (HELO mailfrt10.isp.novis.pt) ([195.23.133.202])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly07.isp.novis.pt with compressed SMTP; 28 Dec 2009 22:23:19 -0000
Received: (qmail 20644 invoked from network); 28 Dec 2009 22:23:19 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt10.isp.novis.pt with SMTP; 28 Dec 2009 22:23:19 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id 9A6F51878E0;
	Mon, 28 Dec 2009 22:23:52 +0000 (WET)
In-Reply-To: <76c5b8580912280851k141bc6cev36df72b1993b8359@mail.gmail.com>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135770>

> Your /home/apache/gitprojects is a folder where your git repositories
> are supposed to be placed.
> Your Git repository = your project.
> 
> By running a git daemon the way you do - you say that you are going to
> serve all repositories from /home/apache/gitprojects.
> 
> Bare repo = repo without working copy - the one which contains only
> history and git objects (imagine it to be only .git folder from normal
> repo) Therefore for bare repos there is a naming convention so they
> have .git extension, while normal repo doesn't. So, myProject.git is
> server based bare repo, while myProject is a local repo.
> 
> Finally you have /home/apache/gitprojects/myProject.git
> 
> The URL to clone from there will be - should be shown to you by CGIT
> if you have everything correctly set up
> git://192.168.1.206/myProject.git

Lets see if i understood:

my steps:

git init --bare /home/apache/gitbare
cd /home/apache/gitprojects
mkdir project
cd project
git init myproject.git

on gitweb, i see the project names in this format:
"myproject.git/.git"

for example, for the git repo on git.kernel.org, it is shown as:
"git/git.git"

shouldn't it appear in the same way here?

i have:
$projectroot = "/home/apache/gitprojects/project/";

for CGIT, i have:
repo.path=/home/apache/gitprojects/project/myproject.git

but it doesn't show nothing after i click it.


on the other hand, i cannot push changes via remote, after cloned the
repository with:


git clone git://192.168.1.206/project/myproject.git

add some files

git add .
git commit -m "aaaa"
git push --tags "origin" master:master


and get:

error: unpack failed: unpack-objects abnormal exit
To git://192.168.1.206/project/myproject.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to
'git://192.168.1.206/project/myproject.git'
Failed


i feel i'm almost there but something is missing here... sorry my
newbienest!
