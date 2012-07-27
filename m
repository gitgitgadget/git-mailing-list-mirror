From: Aleksandr Priymak <tramsmm-mirror@yandex.ru>
Subject: Re: git stash data loss
Date: Fri, 27 Jul 2012 18:21:36 +0400
Message-ID: <6BE6FF9E-0952-45D8-AFA7-0843CE3CFC5A@yandex.ru>
References: <55831343358368@web1e.yandex.ru> <20120727132953.GA8263@sigill.intra.peff.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 27 16:27:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SulVz-0005SZ-OR
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 16:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab2G0O1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 10:27:34 -0400
Received: from forward19.mail.yandex.net ([95.108.253.144]:49181 "EHLO
	forward19.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2G0O1e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2012 10:27:34 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jul 2012 10:27:33 EDT
Received: from smtp18.mail.yandex.net (smtp18.mail.yandex.net [95.108.252.18])
	by forward19.mail.yandex.net (Yandex) with ESMTP id 8886A1120D72;
	Fri, 27 Jul 2012 18:21:35 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1343398895; bh=v9kxRgFl5Yy6W3Uc3HjoHy18Zh+o2L1HtpbxLMTqnI8=;
	h=References:In-Reply-To:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Message-Id:Cc:From:Subject:Date:To;
	b=XpNPLoB/Sv8zdC6GD54/cT5FN3izn5rTGm7AEJUB5eZ/fqfkCrAMgYSRYEBhZE/ks
	 5Z4KYnDVwx+wbeQ880RIaNP9R1PQQ8RATVHdgugiYLUxbUEfTQ0XqQSaroUQrCNXBQ
	 jOtrzFWAAVMatjxFzYOgBoKrIJy9KLCCPUXXMc8M=
Received: from smtp18.mail.yandex.net (localhost [127.0.0.1])
	by smtp18.mail.yandex.net (Yandex) with ESMTP id 66AFC18A019A;
	Fri, 27 Jul 2012 18:21:35 +0400 (MSK)
Received: from broadband-37-110-46-117.nationalcablenetworks.ru (broadband-37-110-46-117.nationalcablenetworks.ru [37.110.46.117])
	by smtp18.mail.yandex.net (nwsmtp/Yandex) with ESMTP id LYJ4ou8n-LZJefdqg;
	Fri, 27 Jul 2012 18:21:35 +0400
X-Yandex-Rcpt-Suid: git@vger.kernel.org
X-Yandex-Rcpt-Suid: peff@peff.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1343398895;
	bh=v9kxRgFl5Yy6W3Uc3HjoHy18Zh+o2L1HtpbxLMTqnI8=;
	h=References:In-Reply-To:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Message-Id:Cc:X-Mailer:From:Subject:Date:To;
	b=UKfFj9NI6hTmUJhG0zLEDqq/Pe7R5Vk77VAsfeKvMjVJM5/Eqgp8P/aja9lhCfI2U
	 4fGexbO0A08mFkg2SwFB+HMejGvtj0ozEKomrpeBKXxDdqHD84m3UOxgUPXBUWucsI
	 PqgWu/W/2n5vWyRAdQd/wm6XoJF2Z1ucybP72mvo=
In-Reply-To: <20120727132953.GA8263@sigill.intra.peff.net>
X-Mailer: iPad Mail (9B206)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202355>

Thanks Jeff for the comment. You are right. I oversimplified the use-case ( forget to fill the directory )

Sent from my iPad

On Jul 27, 2012, at 5:29 PM, Jeff King <peff@peff.net> wrote:

> On Fri, Jul 27, 2012 at 07:06:08AM +0400, Aleksandr Pryimak wrote:
> 
>> I also recreated it
>> 
>> aleksandr@beast:/tmp/test$ git init
>> Initialized empty Git repository in /tmp/test/.git/
>> aleksandr@beast:/tmp/test$ touch x
>> aleksandr@beast:/tmp/test$ git add x
>> aleksandr@beast:/tmp/test$ git commit -m "Initial"
>> [master (root-commit) d3569a0] Initial
>> 0 files changed, 0 insertions(+), 0 deletions(-)
>> create mode 100644 x
> 
> OK, so we have "x" as a tracked file.
> 
>> aleksandr@beast:/tmp/test$ rm x
>> aleksandr@beast:/tmp/test$ mkdir x/
>> aleksandr@beast:/tmp/test$ ls
>> x
> 
> And then we remove it in favor of a directory. Note that git does not
> track directories directly, only files inside them. So from git's
> perspective, the working tree has no content in it at all.
> 
>> aleksandr@beast:/tmp/test$ git stash
>> Saved working directory and index state WIP on master: d3569a0 Initial
>> HEAD is now at d3569a0 Initial
> 
> And now we stash it. That will stash the working tree removal of x. It
> will not stash anything about the new directory x, because it has no
> content inside it.
> 
>> aleksandr@beast:/tmp/test$ ls
>> x
>> aleksandr@beast:/tmp/test$ git stash pop
>> Removing x
>> # On branch master
>> # Changes not staged for commit:
>> #   (use "git add/rm <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>> #
>> #    deleted:    x
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>> Dropped refs/stash@{0} (c500443ae16cf0d846b195cb97eb388dec5f440e)
>> aleksandr@beast:/tmp/test$ ls
> 
> And your stash pop restores the deletion of "x". It does _not_ reinstate
> the directory "x", because as I stated above, that is not part of the
> stash.
> 
> So what is the data loss? That the "mkdir x" was lost? That has nothing
> to do with stash, but rather the fact that git does not track empty
> directories. You could see the same thing with:
> 
>  mkdir x && git commit -a
> 
> which will not record your mkdir at all. In other words, this is by
> design.
> 
> If we put actual files inside "x", which git does track, then they would
> be part of the stash, and should be properly retained. But they're not:
> 
>  $ rm x && mkdir x && echo foo >x/file
> 
> Now we have some precious contents in the form of "x/file". They are
> untracked by git, but git should be careful about removing them.
> 
>  $ git stash
>  Saved working directory and index state WIP on master: 2d32d3a initial
>  HEAD is now at 2d32d3a initial
>  $ ls -l x
>  -rw-r--r-- 1 peff peff 0 Jul 27 09:19 x
>  $ git stash show --raw
>  :100644 000000 e69de29... 0000000... D  x
> 
> Now this _is_ data loss. Stash blows away untracked files inside the
> directory, but does not record them in the resulting stash. And that
> should be fixed.
> 
> With "-u", I'd expect stash to include the untracked file x/foo in the
> stash. Without "-u", I'd expect stash to fail, since it would be
> deleting untracked files.
> 
> -Peff
