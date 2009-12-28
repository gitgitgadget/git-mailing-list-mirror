From: Shantanu Pavgi <pavgi@uab.edu>
Subject: RE: Newbie to git
Date: Mon, 28 Dec 2009 17:51:50 -0600
Message-ID: <540FAB030B18B14B8E672DB4B500635B1769FFD879@UABEXMBS6.ad.uab.edu>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>
	 <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>
	 <26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>
	 <0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222>
	 <m27hs8t5b7.fsf@whitebox.home>
 <76c5b8580912280851k141bc6cev36df72b1993b8359@mail.gmail.com>,<4e972734347b7ad47786807a7abe1c0e@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "mysql.jorge@decimal.pt" <mysql.jorge@decimal.pt>
X-From: git-owner@vger.kernel.org Tue Dec 29 00:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPPSv-00028q-Vu
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 00:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbZL1X5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 18:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZL1X5L
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 18:57:11 -0500
Received: from uabexht2.ad.uab.edu ([138.26.5.102]:3316 "EHLO
	UABEXHT2.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZL1X5K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 18:57:10 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2009 18:57:10 EST
Received: from UABEXMBS6.ad.uab.edu ([138.26.5.43]) by UABEXHT2.ad.uab.edu
 ([138.26.5.102]) with mapi; Mon, 28 Dec 2009 17:51:50 -0600
Thread-Topic: Newbie to git
Thread-Index: AcqIDGAwnS9iU8DITJaa2+pUY3ABGgAC0Juu
In-Reply-To: <4e972734347b7ad47786807a7abe1c0e@192.168.1.222>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135774>

Jorge,

I remember having similar problem. I think it is with the user permissions. Check if the 'push-user' has read-write permissions on public repo. Check out  '--shared' option while initializing bare repo  (git-init --bare) or set appropriate permissions using chown/chmod. Hope this helps..

Thanks,
Shantanu Pavgi.



________________________________________
From: git-owner@vger.kernel.org [git-owner@vger.kernel.org] On Behalf Of Jorge Bastos [mysql.jorge@decimal.pt]
Sent: Monday, December 28, 2009 4:23 PM
To: Eugene Sajine
Cc: Junio C Hamano; git@vger.kernel.org
Subject: Re: Newbie to git

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
