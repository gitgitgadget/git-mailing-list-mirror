From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Thu, 21 Jul 2011 11:37:02 +0530
Message-ID: <20110721113702.329f73b5@shiva.selfip.org>
References: <20110720182438.3c40cf1d@shiva.selfip.org>
	<CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
	<201107201611.p6KGBvna012304@dcnode-02.unlimitedmail.net>
	<CACsJy8DswCJS8YfaG=e73g1ZDVRV1H3Z0St7zaAEuuwYxgxgBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 08:09:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjmRw-0007LN-TX
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 08:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab1GUGG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 02:06:58 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:56119
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852Ab1GUGG5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 02:06:57 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 326741808001;
	Thu, 21 Jul 2011 08:06:53 +0200 (CEST)
In-Reply-To: <CACsJy8DswCJS8YfaG=e73g1ZDVRV1H3Z0St7zaAEuuwYxgxgBQ@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Jul 2011 10:20:13 +0700
Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> On Wed, Jul 20, 2011 at 11:12 PM, J. Bakshi <j.bakshi@unlimitedmail.org> wrote:
> > Thanks for your response. I am afraid that I can't understand the approach clearly but I must say that I am hopeful to see a direction.
> > Obviously there will be a central git repo which will have its worktree under htdocs at the same server.
> 
> No, the central repository does not need worktree attached (in other
> words "bare repository"). You modify in a clone from it and push
> to/pull from it.
> 
> > That's why the post-receive
> > hook will update the website after each push. But the issue is mapping the structure at git which is different than the structure at
> > filesystem. And a push should reflect to its correct folder only.
> >
> > [git]->[mysite]->dir1/trunk/src => physically map => htdocs/demo/dir1
> > [git]->[mysite]->dir2/trunk/src => physically map => htdocs/demo/dir2
> >
> >
> > Please tell me with little more clarification, how can I do this ?
> 
> OK, let's create a central repository
> 
> GIT_DIR=/somewhere/safe/repo.git git init --bare
> 
> Then clone it where development happens
> 
> git clone /somewhere/safe/repo.git ~/dev
> cd ~/dev
> 
> Now we create "dir1" and "dir2" branches, correponding to what you
> have in the original tree
> 
> git checkout -b dir1
> # put contents of dir1/trunk/src here, commit
> git checkout -b dir2 master
> # put contents of dir2/trunk/src here, commit
> 

Just here, just here... The git should have dir1/trunk/src  which should update  /var/www/demo/dir1
and  dir2/trunk/src which should update /var/www/demo/dir2

Thanks for your detailed clarification, very nice....
