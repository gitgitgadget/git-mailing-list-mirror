From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: updating github.com forks, developing in remote branches and svn:eol-style equiv?
Date: Sun, 28 Mar 2010 10:25:23 +0300
Message-ID: <158811269761123@webmail102.yandex.ru>
References: <15b345f1003272332u2f4d38ear5c8aeef9b35f5037@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Anderson <zelnaga@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 28 09:25:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvmsF-0004Ju-Po
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 09:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab0C1HZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 03:25:26 -0400
Received: from forward14.mail.yandex.net ([95.108.130.92]:47182 "EHLO
	forward14.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab0C1HZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 03:25:25 -0400
Received: from webmail102.yandex.ru (webmail102.yandex.ru [95.108.130.6])
	by forward14.mail.yandex.net (Yandex) with ESMTP id 1205F26800AA;
	Sun, 28 Mar 2010 11:25:24 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1269761124; bh=/rZYQdOdgbEedv2XpWf+BC/1wF4HFZHikFwWFx7ptBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Message-Id:
	 Date:Content-Transfer-Encoding:Content-Type;
	b=kutSdI99vFaHueyGErrbQ5j2W4yACdqwCSlIFRZy2bSdEBpVLA0mLIlsS7PhgLeg3
	 c5VEGff+NDWPg2pehCi/6PWl2zaaFr2PYQ7NMR5ErpRxhEVrgcYBSGjX77OmkRDwvU
	 qnrq6drh1k9u1pP7I4OUHdC7QC2/rFv9ecdjRcX0=
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail102.yandex.ru (Yandex) with ESMTP id E035DA1401B;
	Sun, 28 Mar 2010 11:25:23 +0400 (MSD)
X-Yandex-Spam: 1
X-Yandex-Front: webmail102 
X-Yandex-TimeMark: 1269761123 
Received: from host-94-251-110-62.bbcustomer.zsttk.net (host-94-251-110-62.bbcustomer.zsttk.net [94.251.110.62]) by mail.yandex.ru with HTTP;
	Sun, 28 Mar 2010 10:25:23 +0300
In-Reply-To: <15b345f1003272332u2f4d38ear5c8aeef9b35f5037@mail.gmail.com>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143381>

Hello!

> Say on github.com I fork a repository.  Two weeks later, updates have
>  been made to the original repository and now I want to update my fork.
>   How do I do this?
>  
>  One possibility that occurs to me: I can create a new remote
>  repository - let's say "upstream" - with the URL of the original
>  repository and I can pull from that instead of the forked "origin"
>  repository.  I can then push the updates to the forked repository.
>  
>  Is that the best way to do it, though?  It seems to me that I ought to
>  be able to have my github.com fork pull updates itself without my
>  having to pull and push with my own local repo.

  You should do it the way you described - via local repository, because you
  might need to resolve conflicts along the way.
  There is the "Fork Queue" feature on GitHub, you may give it a try.

>  Also, I'm unclear how to develop in remote branches.  If I go to the
>  "Switch/Checkout..." dialog I can switch to, say,
>  "remotes/origin/random-branch".  I do that, make some changes to one
>  of the new files and I then try to push those changes back.  In the
>  local drop down menu I only see two local branches, however - "(no
>  branch)" and the default branch.  Why is that?  If I just switched the
>  branch to, say, "remotes/origin/random-branch", shouldn't I now be
>  seeing that branch locally?

  To have a local branch you should create it:
  git checkout -b branchName remotes/origin/branchName
  Remote branches are there only to track the state of the remote repo,
  you should only commit to local branches and then push your work to
  remotes.

>  Finally, is there any Git equivalent to SVN's svn:eol-style and if so
>  how do I take advantage of it?

  git help config
  Look for "autocrlf", "safecrlf", etc.
  You can set these options globally or per repository.

---=====---
 Alexander
