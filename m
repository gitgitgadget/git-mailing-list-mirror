From: "David Neu" <david@davidneu.com>
Subject: Re: Converting from svn to git
Date: Sun, 10 Aug 2008 10:54:59 -0400
Message-ID: <e0b44a890808100754l536bc4f3kfd953b52044f6e59@mail.gmail.com>
References: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>
	 <20080810132409.GE18960@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 16:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCL3-00069Y-EQ
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 16:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbYHJOzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 10:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbYHJOzE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 10:55:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:49363 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbYHJOzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 10:55:00 -0400
Received: by wx-out-0506.google.com with SMTP id h29so991178wxd.4
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 07:54:59 -0700 (PDT)
Received: by 10.70.12.10 with SMTP id 10mr9387697wxl.32.1218380099442;
        Sun, 10 Aug 2008 07:54:59 -0700 (PDT)
Received: by 10.70.53.6 with HTTP; Sun, 10 Aug 2008 07:54:59 -0700 (PDT)
In-Reply-To: <20080810132409.GE18960@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91842>

Thanks for the reply - this looks like what I'd need, but
I can't see how to keep the contents of the base dir and
lose the subdirs, e.g.

$ git-filter-branch --subdirectory-filter . HEAD

removes all subdirs and the contents of the base dir.

So, I figure I'd remove each subdir, using

$ git-filter-branch --tree-filter 'rm -rf subdir1/' HEAD

but this complains if subdir1 contains subdirectories, it
says: Namespace refs/original/ not empty

Many thanks!

Cheers,
David


On Sun, Aug 10, 2008 at 9:24 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
>
> On Sun, Aug 10, 2008 at 09:11:43AM -0400, David Neu <david@davidneu.com> wrote:
> > Is there a git-svn strategy similar to git-svnimport -P that would do the trick?
> > My git version 1.5.6.4 doesn't include git-svnimport, and I'm getting
> > the impression
> > it's be deprecated.
>
> Sure, it is. Though if you _really_ need it, it's still under
> /contrib/examples.
>
> Anyway, if you do a single conversion, then probably speed does not
> matter a lot; I would do a full import then use the subdirectory-filter
> of git filter-branch do drop everything outside the subdirectory.
