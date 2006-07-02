From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Mon, 3 Jul 2006 00:04:07 +0200
Message-ID: <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org>
	 <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
	 <e89eqj$npu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 00:04:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxA32-00055F-Hl
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 00:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWGBWEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 18:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWGBWEI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 18:04:08 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:32489 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750920AbWGBWEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 18:04:07 -0400
Received: by py-out-1112.google.com with SMTP id c39so1149765pyd
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 15:04:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UguGq+N3V+Am4pdbt0uL1tUqp7PvKlz0qHaCwaGwN30o8KmdY++z8Vp/KhRDlgFs5+L9sOlrjD49z4pMt00XuFj85tag6kyh6y9NAbQQx3iCx2nyI3xuuzWbSG6CSRsFKSeLusuhDsN4AFjawmIjceJq5hMB61eX1XppHUoD+Xo=
Received: by 10.35.90.20 with SMTP id s20mr422385pyl;
        Sun, 02 Jul 2006 15:04:07 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Sun, 2 Jul 2006 15:04:07 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e89eqj$npu$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23129>

On 7/2/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Marco Costalba wrote:
>
> > On 7/2/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> Currently in qgit one can git-format-patch a commit. It woul be nice
> >> if one would be able to git-cherry-pick and git-cherry-pick -n a commit
> >> (denoting the head, i.e. where cherry pick would be applied to). It would
> >> be very usefull in reordering patches (cleaning up history).
> >
> > Currently in qgit you can git-format-patch a commit series and git-am
> > a given patch file series.
> > This can be done transparently with a drag & drop mechanic:
> >
> > 1) Open the source repository
> > 2) Then open a new qgit instance (File->Open in a new window...)
> > 3) Open the destination repository in the new qgit window
> > 4) Drag & drop selected commits (multi selection in supported) from
> > source to destination.
>
> Does multi selection commits all selected commits as one merged commit?
>

No.  Currently it's just a shortcut for git-format-patch --> git-am

> > I normally use this instead of git-cherry-pick  that, I admit, I don't
> > know very well, so please I need some more hints on how to upgrade
> > this behaviour introducing git.cherry-pick support.
>
> I use git-cherry-pick -n to join few patches into one, or with editing the
> result to split one patch/commit into few smaller.
>
> git-cherry-pick [-n] <commit> picks up a commit and drops it on top of
> current branch. I'd like to see it in context menu for current commit,
> i.e. "cherry-pick to <head>", where <head> will be replaced by current
> branch name, or/and "cherry-pick -n to <head>".
>
>

>From the git-cherry-pick documentation I see -n option "applies the
change necessary to cherry-pick the named commit to your working tree,
but does not make the commit"

What do you think about this:

When dropping the selected commits, instead of creating new commits,
appears a message box with something like "Do you want to apply the
commits on top of your current branch or on your working directory?"

Sounds good for you? Or you still prefer the context menu?
In the latter case, if I have understood correctly, you are limited to
cherry-pick among branches and/or working directory of the _same_
repository.

    Marco
