From: Eddy =?utf-8?b?UGV0cmnImW9y?= <eddy.petrisor@gmail.com>
Subject: Re: [BUG] (minor) "git status ." reports added files as untracked
Date: Wed, 26 Mar 2008 23:07:57 +0000 (UTC)
Message-ID: <loom.20080326T225201-965@post.gmane.org>
References: <vpqtzko8ws2.fsf@bauges.imag.fr> <7v7ihkjtvg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 00:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jeeqa-0007H9-JK
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 00:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYCZXPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 19:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbYCZXPO
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 19:15:14 -0400
Received: from main.gmane.org ([80.91.229.2]:54996 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbYCZXPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 19:15:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Jeepj-0005NJ-5x
	for git@vger.kernel.org; Wed, 26 Mar 2008 23:15:03 +0000
Received: from 89.137.228.34 ([89.137.228.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 23:15:03 +0000
Received: from eddy.petrisor by 89.137.228.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 23:15:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.137.228.34 (Mozilla/5.0 (X11; U; Linux x86_64; ro-RO; rv:1.8.1.12) Gecko/20080129 Iceweasel/2.0.0.12 (Debian-2.0.0.12-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78318>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:
> 
> > Indeed, I've always considered the fact that "git status ." reports
> > untracked files outside the current directory as a bug, but I'm not
> > sure whether this is intended or not.
> 
> It is intended.
> 
> "git status $args" was designed as "show me what happens if I
> ran 'git commit $args' now", and because a commit is a whole
> tree operation, 

I am reopening/continuing this thread since, I also have an issue with this
behaviour of git status.

As I said in my report in the Debian BTS
(http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=471313) I do see the point
(from a user PoV) of such a behavior of "git status ." .

Of course, "git status" is another matter and is really OK to behave like is
does, but "git status ." is only a duplicate of the former with no special
meaning, while (I feel) most people would see it really pointless, undesired and
unexpected to behave like it does now.

I really think "git status ." should limit the search below the current dir,
while "git status" should keep its current meaning.

> It is a different matter if the intention matches the
> expectation you picked up from somewhere on how "scm status"
> should work (it most likely doesn't).  It also is a different
> matter if it is justifiable to have such a mismatch.

I think it is justifiable, and I think is an improvement from a user (interface)
PoV.

TIA.

[1] btw, git status --blabla shows what seems to be git-commit's help
