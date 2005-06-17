From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Fri, 17 Jun 2005 18:10:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506171750180.30848-100000@iabervon.org>
References: <tnxy899zzu7.fsf@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 00:06:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjOyt-0007FJ-Ac
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 00:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVFQWLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 18:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVFQWLs
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 18:11:48 -0400
Received: from iabervon.org ([66.92.72.58]:32260 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261224AbVFQWLq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 18:11:46 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DjP2e-0000Nr-00; Fri, 17 Jun 2005 18:10:24 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxy899zzu7.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Jun 2005, Catalin Marinas wrote:

> StGIT is a Python application providing similar functionality to quilt
> (i.e. pushing/poping patches to a stack) on top of git.

It might be worth making the system work for having multiple series in the
same tree. You could do this by saving the base commit for
.git/refs/heads/<name> as .git/refs/bases/<name>, and putting patches in
.git/patches/<name>/. Some people do a lot with
.git/refs/heads/something; I, at least, symlink .git/HEAD to whichever one
I'm using, so that might be the right way to tell what the user is doing.

I think it would worth exploring defining a git type for patches and
storing the patches inside git as well. Then a commit could identify the
patch it applies (when it is from applying a patch), and a rebased patch
could reference the patch it replaces, and then (with a certain amount of
handwaving of implementation) the system could notice when the patch
you're pushing got applied upstream. Or, at least, git could avoid 
throwing away the history information when it goes through patches. I keep
thinking that this would be an important feature, but I haven't got the
familiarity with quilt to know how it should work.

	-Daniel
*This .sig left intentionally blank*

