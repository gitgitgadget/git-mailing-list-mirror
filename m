From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Mon, 3 Jul 2006 07:45:17 +0200
Message-ID: <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org>
	 <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
	 <e89eqj$npu$1@sea.gmane.org>
	 <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	 <e89iql$42a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 07:45:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxHFL-0004ur-DW
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 07:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWGCFpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 01:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWGCFpT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 01:45:19 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:52429 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751349AbWGCFpR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 01:45:17 -0400
Received: by py-out-1112.google.com with SMTP id n25so1245114pyg
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 22:45:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ILxN0ytye1uemz2xxgAWwMSc1nj/X8bsyMCUewAvJulRgmk15wLvPnuu2i2zqTCMz2z7crRrQoYxyEBV24zyg0+xL82BwSCUYq159DnnAuLpBE3mueqKCTpYHVwm73xzdTsn51eU9k3dyM6uNlks1dewsZRmMp4siHkLI5djFDc=
Received: by 10.35.70.17 with SMTP id x17mr2520005pyk;
        Sun, 02 Jul 2006 22:45:17 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Sun, 2 Jul 2006 22:45:17 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e89iql$42a$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23156>

On 7/3/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Marco Costalba wrote:
>
> > What do you think about this:
> >
> > When dropping the selected commits, instead of creating new commits,
> > appears a message box with something like "Do you want to apply the
> > commits on top of your current branch or on your working directory?"
> >
> > Sounds good for you? Or you still prefer the context menu?
> > In the latter case, if I have understood correctly, you are limited to
> > cherry-pick among branches and/or working directory of the _same_
> > repository.
>
> Yes, git-cherry-pick works only between commits in the same repository,
> as it use merge (first "simple", i.e. git-read-tree -m -u --aggresive, if
> fails tries "automatic" i.e. git-merge-index -o git-merge-one-file -a, then
> git-write-tree), as opposed to git-format-patch and git-am or git-apply,
> which can work across repositories.
>
> What I really want is "no-commit" of drag'n'dropped, or exported and applied
> commits/patches (although interface to cherry-pick would be nice, even if
> cherry-pick is limited), so I'd like message box with "Do you want to
> commit selected patches?" when dropping commits, or something like that.
> Unfortunately git-am doesn't have --no-commit flag, but one could emulate it
> with git-reset after git-am a patch, I think.
>

When I need to modify the patch/revision before to import I usaually
drag&drop and then I call git-reset --soft, then I edit working
directory and commit again.

Perhaps I can automate this in case the user answers "No, apply to
working dir only" to the message box.

Is it the correct way to go or is better to wait for a --no-commit
flag in git-am?
Junio?

   Thanks
   Marco
