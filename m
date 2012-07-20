From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 19:49:05 +0400
Message-ID: <20120720194905.9929a30ee42fd73cf62e7992@domain007.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:49:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFSD-0001Si-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab2GTPtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:49:11 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:55257 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab2GTPtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:49:10 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q6KFn5MF014694;
	Fri, 20 Jul 2012 19:49:06 +0400
In-Reply-To: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201780>

On Fri, 20 Jul 2012 12:26:09 -0300
Thiago Farina <tfransosi@gmail.com> wrote:

> How can I push a working branch to github inside it?
> 
> E.g:
> 
> # On master:
> $ git checkout -b feature-work
> 
> # On feature-work
> # vi, hack, commit, ready to push
> $ git push origin master # here I expected it would working pushing my
> commits to a feature-work branch in github. Or if I omit master it
> gives me a [rejected] error.
$ git push origin master
means "update the branch 'master' in the remote repository with the
contents of the branch 'master' in the local repository".
Read the "git push" manual.

> $ git checkout master
> $ git push origin feature-work # Now the branch is pushed.
Sure, but it has nothing to do with the previous checkout command: you
just told Git to push the contents of your local branch "feature-work"
to a remote branch "feature-work" which presumably does not exist and
gets created as a result of your push.

If you want to update the remote "master" branch with the contents of
your local "feature-work" branch, do
$ git push origin feature-work:master

As stated below, you should really read the git push manual and reading
through the appropriate sections of the http://git-scm.com/book is also
highly advised.

Also consider reading about the "push.default" configuration variable
in the git config manual--this might save you from scratching your head
when you try to do simple `git push origin` without specifying any
branches: here again your expectation might differ from the Git
defaults.
