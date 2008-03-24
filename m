From: Yoann Padioleau <padator@wanadoo.fr>
Subject: Re: merging git repositories history for full history of linux
Date: Mon, 24 Mar 2008 16:10:38 -0500
Message-ID: <87ej9zomk1.fsf@wanadoo.fr>
References: <87iqzcne7b.fsf@wanadoo.fr>
	<7v63vbvr2b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yoann Padioleau <padator@wanadoo.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdu06-0001W1-89
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 22:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbYCXVN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 17:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYCXVN4
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 17:13:56 -0400
Received: from expredir6.cites.uiuc.edu ([128.174.5.97]:49637 "EHLO
	expredir6.cites.uiuc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbYCXVNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 17:13:55 -0400
Received: from axyr (aryx.cs.uiuc.edu [128.174.236.106])
	by expredir6.cites.uiuc.edu (8.14.2/8.14.2) with ESMTP id m2OLDVRS004301;
	Mon, 24 Mar 2008 16:13:31 -0500 (CDT)
In-Reply-To: <7v63vbvr2b.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon, 24 Mar 2008 12:51:24 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78099>

Junio C Hamano <gitster@pobox.com> writes:

> Yoann Padioleau <padator@wanadoo.fr> writes:
>
>> I would like to merge the 3 git repositories of the history
>> of linux, the one by Dave Jones from linux 0.01 to linux 2.4.0, 
>> the one by tglx from 2.4.0 to 2.6.12 and the one from 2.6.12
>> by torvalds until the last version of Linux.
>
> I think you can install two grafts (one that says the root in tglx history
> has one parent that is tip of Dave Jones history, another that says that
> the 2.6.12-rc2 commit which is the root in Linus history has one parent
> that is near the tip of tglx history), and if you want the result to use
> locally then you are done.  Otherwise you can run filter-branch on the
> result, but the future commits from Linus tree will all be different.

Thanks, I'll try that. 

Also the Dave jones commits have the wrong date. All the 1040 commits
are set to December 2007. I can get all the dates for the different
versions of Linux but is there an easy way then to change the date for
those 1040 commitid ? and also author ? The reasons for this is I want
to use 'git annotate' on the full history of Linux to do some statistics
about the evolution of Linux so I need the good date for each commit.

Also, why the diff produce by git log -p can not be applied as 
is on another git repositories ? I tried to do a script that just
duplicate a git repository by getting the patch for each commit
with 'git log -p' and applies them in turn to a fresh repo with
git applypatch but it fails, git returns some error such as 
"b/Makefile already exist".
