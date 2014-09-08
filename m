From: Sergey Organov <sorganov@gmail.com>
Subject: Re: git rebase: yet another newbie quest.
Date: Mon, 08 Sep 2014 17:52:44 +0400
Message-ID: <87sik28bir.fsf@osv.gnss.ru>
References: <87a96ecqe9.fsf@osv.gnss.ru> <20140905154159.GB1510@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 08 15:53:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQzNN-0007WH-1W
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 15:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbaIHNwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 09:52:55 -0400
Received: from mail.javad.com ([54.86.164.124]:57185 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874AbaIHNwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 09:52:54 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id A03CD615BB;
	Mon,  8 Sep 2014 13:52:53 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XQzN6-0000t0-Nd; Mon, 08 Sep 2014 17:52:44 +0400
In-Reply-To: <20140905154159.GB1510@thunk.org> (Theodore Ts'o's message of
	"Fri, 5 Sep 2014 11:41:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256647>

Theodore Ts'o <tytso@mit.edu> writes:
> I'm not going to say what you *should* have done, since it's not clear
> whether anything close to what you were doing is a supported workflow.
> But I can tell you what I *do* myself.  Personally, I vastly distrust
> git pull --rebase.

Thank you for sharing your experience!

In the particular case at hand though, "git rebase" is the actual cause
of the problem, not "git pull --rebase".

> So in general, my pulls are all the equivalent of "git pull
> --ff-only", and if I want to rebase the topic branch (which in
> general, is a bad idea to do regularly; I will generally not do it at
> all until I'm almost done).  So I'll branch the topic branch off of
> origin (which tracks origin/master, typically):
>
> git checkout -b topic1 origin
> <hack hack hack>
> git commit
>
>   ...
> <make>
>
> In general, I will only rebase a topic branch when it's needed to fix
> a serious conflcit caused by significant changes upstream.  And in
> that case, I might do something like this:
>
> git checkout topic1
> git rebase origin/master
> <make>
> <make check>

Yeah, it's a good way to do things, but for most of quick fixes I'm lazy
to create topic branch, and in this case it lead to a nasty unexpected
trouble.

I didn't intend to make topic branch from the very beginning, and
already made a commit or two on the remote tracking branch bofore I
realized I'd better use topic branch. It'd create no problem as far as I
can see, provided vanilla "git rebase" has "sane" defaults. That said,
I've already been once pointed to by Junio that my definition of "sane"
doesn't take into account workflows of others, so now I try to be
carefull calling vanilla "git rebase" names.

Please also notice that I didn't pull immediately after I've re-arranged
my branches, and this fact only made it more difficult to find and
isolate the problem.

[...]

> P.S.  There is a separate, and completely valid discussion which is
> how to prevent a newbie from falling into a same trap you did.  I'll
> defer that discussion to others...

Yeah, it'd be fine if at least documentation is fixed.

-- 
Sergey.
