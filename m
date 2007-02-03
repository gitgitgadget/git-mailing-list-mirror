From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: git-clone wrongly setting branch.*.merge ? (Was: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".)
Date: Sat, 3 Feb 2007 12:16:47 +0000
Message-ID: <b0943d9e0702030416t4088e7e1yaf2ac0a4c30def8d@mail.gmail.com>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
	 <20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
	 <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
	 <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070202235655.GG5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 13:16:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDJpA-0001vQ-Du
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 13:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbXBCMQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 07:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945963AbXBCMQu
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 07:16:50 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:53258 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945911AbXBCMQt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 07:16:49 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1138478nze
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 04:16:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bt3jmODF21n3oJzwp4BSB/qucfHtSMjG6vZ5rer6iE3S6EQmrZIDw7GCfU7jTjd8D06Esk+sJ5rq/c4GhIUzY/tmsY6e8MGk5z6ls4E4iUP9PdT9eeIzrA0jzVnzAc95Ize1AT1y9mOuBqBymqU52Mfmo3xwsSnwlBV72mCd71w=
Received: by 10.115.93.16 with SMTP id v16mr460132wal.1170505008161;
        Sat, 03 Feb 2007 04:16:48 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Sat, 3 Feb 2007 04:16:47 -0800 (PST)
In-Reply-To: <20070202235655.GG5362@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38563>

Yann,

On 02/02/07, Yann Dirson <ydirson@altern.org> wrote:
> On Fri, Feb 02, 2007 at 07:07:06PM +0100, Yann Dirson wrote:
> > On Fri, Feb 02, 2007 at 09:58:06AM +0000, Catalin Marinas wrote:
> > > On 01/02/07, Yann Dirson <ydirson@altern.org> wrote:
> > > >Previously we were just assuming that the remote from which we
> > > >just failed defined a local branch whose name was the same as the
> > > >remote def, and that this branch was the parent.  While this is true
> > > >for the most common case (branch "origin" from remote "origin"), it is
> > > >quite an unflexible assumption.
> > >
> > > The t1200-push-modified.sh test fails after applying this patch. It
> > > looks like the 3rd test fails to pull the changes from 'foo' into
> > > 'bar'.
>
> With current GIT HEAD, plain git-clone creates the following config
> (when cloning a repo with HEAD pointing to branch "downstream":

As I haven't followed the GIT latest developments in this area, I
can't comment. Regarding StGIT, I'd like it to work with earlier
stable versions of GIT and not just with the current HEAD. I (and
probably many others) already have repositories cloned some (long)
time ago and their gitconfig might not have the cloning information.

The (interim) solution I see is for StGIT pull command to default to
using git-pull and people can configure it to git-fetch and the
automatic rebase if they need it. I'd like to release 0.12 this
weekend but 'pull' doesn't currently work. Are you OK with my solution
(for backward compatibility with older repositories and GIT versions)?

Thanks.

-- 
Catalin
