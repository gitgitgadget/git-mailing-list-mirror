From: "Don Zickus" <dzickus@gmail.com>
Subject: Re: committing empty diffs
Date: Mon, 12 Feb 2007 15:19:42 -0500
Message-ID: <68948ca0702121219v6056d2dau65c57b47bfc61a00@mail.gmail.com>
References: <68948ca0702121149p4d87ae07jd3aa532a0df79156@mail.gmail.com>
	 <20070212200324.GB30440@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGheR-0004Sn-Fu
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbXBLUTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbXBLUTs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:19:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:51884 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965365AbXBLUTr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:19:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so711578uga
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 12:19:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fIo+X5O7RktiUm2Q8tNkV5i3kTiBrYFL3d7qNXALVIn6xdxVQZ0naqj4zaKAXdMUZ4ht+vzq4LuvEVmiwvr4FQhIclpq+WfHFkGnWQcfzs/jsQw/9tXbbuQGFRJ1Mvupa/XfDJnkqa+GfO36sRSww4b5cczVTPX5VmX3owGjzS4=
Received: by 10.114.192.1 with SMTP id p1mr6657788waf.1171311582487;
        Mon, 12 Feb 2007 12:19:42 -0800 (PST)
Received: by 10.114.80.9 with HTTP; Mon, 12 Feb 2007 12:19:42 -0800 (PST)
In-Reply-To: <20070212200324.GB30440@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39433>

On 2/12/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Don Zickus <dzickus@gmail.com> wrote:
> > Considering git-commit doesn't allow this (probably for good reason),
> > is it technically safe to do the following sequence of events?
> >
> > tree=$(git-write-tree)  #basically the same tree HEAD points to
> > commit=$(echo $IDEAS | git-commit-tree $tree -p HEAD)
> > git-update-ref HEAD $commit HEAD
> >
> > I figured all a commit is doing is taking a snapshot of a particular
> > tree at a moment in time.  And taking multiple snapshots at that same
> > moment and stringing them together (pointed to by HEAD) wouldn't be a
> > big deal.
> >
> > Am I going to wind up shooting myself in the foot later or will this
> > work?  Light testing didn't show any issues.  Thought I would ask the
> > experts.  Thanks.
>
> No, it won't break anything.

Great.

>
> I do that empty commit myself for a different reason.  I wouldn't
> recommend that you do that with public history, and since the file
> didn't change in that commit you cannot do `git log -- foo.c` to
> see which notes you wrote about foo.c.  But `git log` will still
> show you the messages.

Hmm.  Good point.

Cheers,
Don
