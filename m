From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems with branches
Date: Sat, 27 Jan 2007 01:03:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701270059380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 01:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAb2W-0006s6-GQ
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 01:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbXA0ADZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbXA0ADZ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 19:03:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:60725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751797AbXA0ADY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 19:03:24 -0500
Received: (qmail invoked by alias); 27 Jan 2007 00:03:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 27 Jan 2007 01:03:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37905>

Hi,

On Fri, 26 Jan 2007, John Rigby wrote:

> I'm having trouble doing something so simple that it is in the
> tutorial but for some reason it does not work for me.
> The following script does basically the same thing that is
> outlined in the "Managing branches" section of the tutorial.
> 
> mkdir foodir
> cd foodir/
> git-init-db
> echo bar > bar
> git-add bar
> git-commit -m "Initial bar"
> git-branch mybranch
> git-branch
> git-checkout mybranch
> echo bar2 >> bar
> git-commit -a -m "Added line bar2 to bar in mybranch"
> git-checkout master
> cat bar
> echo bar3 >> bar
> git-commit -a -m "Added line bar3 to bar in master"
> git-commit -a
> git-diff master mybranch
> git-merge mybranch

What version do you run? I get this running your script:

$ mkdir foodir
$ cd foodir/
$ git-init-db
Initialized empty Git repository in .git/
$ echo bar > bar
$ git-add bar
$ git-commit -m "Initial bar"
Created initial commit bca2eed2306297ec17abb5a9a9fd916f18bdd7f8
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar
$ git-branch mybranch
$ git-branch
* master
  mybranch
$ git-checkout mybranch
$ echo bar2 >> bar
$ git-commit -a -m "Added line bar2 to bar in mybranch"
Created commit 48c9ce01b39faabc778bcc2ca52f44db54670809
 1 files changed, 1 insertions(+), 0 deletions(-)
$ git-checkout master
$ cat bar
bar
$ echo bar3 >> bar
$ git-commit -a -m "Added line bar3 to bar in master"
Created commit 496e810b70c3dba56d002ad9bec61028af7de821
 1 files changed, 1 insertions(+), 0 deletions(-)
$ git-commit -a
# On branch master
nothing to commit (working directory clean)
$ git-diff master mybranch
diff --git a/bar b/bar
index 77914eb..46ffc55 100644
--- a/bar
+++ b/bar
@@ -1,2 +1,2 @@
 bar
-bar3
+bar2
$ git-merge mybranch
Auto-merged bar
CONFLICT (content): Merge conflict in bar
Automatic merge failed; fix conflicts and then commit the result.
