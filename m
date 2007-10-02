From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 08:44:04 +0200
Message-ID: <49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <7v3awunjup.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 08:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcbSv-00008X-In
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 08:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXJBGmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 02:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXJBGmh
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 02:42:37 -0400
Received: from mailer.zib.de ([130.73.108.11]:45304 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbXJBGmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 02:42:36 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l926gU8l022287;
	Tue, 2 Oct 2007 08:42:30 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db19e01.pool.einsundeins.de [77.177.158.1])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l926gTMC028540
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 2 Oct 2007 08:42:30 +0200 (MEST)
In-Reply-To: <7v3awunjup.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59667>


On Oct 2, 2007, at 7:53 AM, Junio C Hamano wrote:

>
> * jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
>  + rebase: allow starting from a dirty tree.
>  + stash: implement "stash create"
>
> Instead of refusing to rebase, telling you that your work tree
> is dirty, this stashes your local changes, runs rebase and then
> unstashes automatically.  That _sounds_ nicer and easier to use,
> but I am not sure if it is a wise/sane thing to do.  We may want
> to revert the "autostash" from rebase.  Opinions?

What would happen if 'git stash' fails to work? Could this bring
the repo in a state that is hard to recover from? Especially if
'stash' commands were run automatically for you. Maybe if you had
a choice you would not choose to use stash but would commit your
changes, or would bring your work tree in a clean state by other means.

I'm a bit concerned because 'git stash' still doesn't work for me
when the work tree is dirty because of a changed subproject (in
msysgit with git 1.5.3). After I run 'git stash' the work tree stays
dirty. How would "autostash" behave?

BTW, I run 'git submodule update' to bring the tree into a clean
state and later manually check out the previous head in the submodule.
Quite annoying, but not directly related to the discussion above.

	Steffen
