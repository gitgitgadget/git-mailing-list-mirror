From: seanh <snhmnd@gmail.com>
Subject: Re: Files that cannot be added to the index
Date: Fri, 26 Aug 2011 22:59:19 +0200
Message-ID: <20110826205919.GB8107@sooty-2.local>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 22:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx3V0-0006hL-D9
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 22:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab1HZU7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 16:59:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35590 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590Ab1HZU73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 16:59:29 -0400
Received: by fxh19 with SMTP id 19so2858012fxh.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Spa8mdiNd7ojjrpsw/RZgQupEIGElalmLAJUSGCrLhc=;
        b=hL9ZGLaryosSKSN26Nvj8EMfH2raZXhdenSyaBpgakh6aYGn4EmCExHX3Bzxes2ivA
         Kfo/fzvEjIjO8D505/cn/JewpXJyrlCrzo1MNR1bZWczHFzFkYOJj0T13GXNA69+raB1
         aqOcXUHbVHsD4Y3VHTtqn0vELWCYfUkTUGqag=
Received: by 10.223.30.142 with SMTP id u14mr2298614fac.25.1314392368155;
        Fri, 26 Aug 2011 13:59:28 -0700 (PDT)
Received: from sooty-2.local (brln-4dbabee1.pool.mediaWays.net [77.186.190.225])
        by mx.google.com with ESMTPS id c18sm1622497fah.39.2011.08.26.13.59.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 13:59:26 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4E57A93A.6090405@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180198>

Unfortunately I can't share the repos, but I've pasted actual output
showing the problem below. I'm using git version 1.7.4.4 on OSX Lion,
from macports. (I was having the problem on Snow Leopard too.) I am
using `git clone` to make the clone, but it's possible that at some
point the repo was moved or copied with things like mv, cp, rsync, maybe
moving across different filesystems.

seanh@sooty-2:~ % cd /tmp 
seanh@sooty-2:/tmp % git clone ~/Dotfiles/home 
Cloning into home...
done.
seanh@sooty-2:/tmp % cd home 
seanh@sooty-2:/tmp/home % git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
# modified:   Text/LOG.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
seanh@sooty-2:/tmp/home % git diff
diff --git a/Text/LOG.txt b/Text/LOG.txt
index 317c80b..13edf26 100644
--- a/Text/LOG.txt
+++ b/Text/LOG.txt
@@ -1,2 +1,21 @@
CONTENTS OF DIFF SNIPPED
seanh@sooty-2:/tmp/home % git add Text/LOG.txt 
seanh@sooty-2:/tmp/home % git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
# modified:   Text/LOG.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
seanh@sooty-2:/tmp/home % git add .; git commit
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
# modified:   Text/LOG.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
seanh@sooty-2:/tmp/home % (1) :(

On Fri, Aug 26, 2011 at 04:10:02PM +0200, Michael J Gruber wrote:
> seanh venit, vidit, dixit 26.08.2011 14:26:
> > Can anyone guess what's going on when I have a modified file that
> > shows up in `git status`, but the file cannot be added to the index
> > (or committed)? `git add FILE` does nothing, the file still shows as
> > modified but not added in `git status`.
> > 
> > I have two different repos that have each developed this problem with
> > two different files. I don't know how it happened. The problem occurs
> > wherever the repos are cloned. Even if I delete the local copy (where
> > I'm seeing the problem) and clone the repo again from elsewhere,
> > problem persists.
> 
> A log of your commands (or access to the repo) would help diagnose that,
> along with information about the system and the git version.
> 
> Do you "clone" by making a copy, by any chance?
> 
> Michael
