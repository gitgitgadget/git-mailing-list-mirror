From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Fri, 7 Dec 2007 00:39:54 +0100
Message-ID: <200712070039.55249.robin.rosenberg.lists@dewire.com>
References: <4755B3B3.80704@gmail.com> <m34peyur8r.fsf@roke.D-201> <7vir3e428i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Salikh Zakirov <salikh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 00:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0QIL-0006DI-0g
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 00:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbXLFXh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 18:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbXLFXhz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 18:37:55 -0500
Received: from [83.140.172.130] ([83.140.172.130]:2271 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbXLFXhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 18:37:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E15418026FD;
	Fri,  7 Dec 2007 00:28:29 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03570-10; Fri,  7 Dec 2007 00:28:29 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7FB7B80265A;
	Fri,  7 Dec 2007 00:28:27 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vir3e428i.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67355>

tisdag 04 december 2007 skrev Junio C Hamano:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >> Currently, I can do:
> >> 
> >> # Oh, what did this look like two commits ago?
> >> $ git checkout HEAD^^
> >> # Ah, OK, let's go back to the tip
> >> $ git checkout branch-name
> >>                ^^^^^^^^^^^
> >> But I have to remember and re-type the branch name.
> >
> > No, you don't have. You can use
> >   $ git checkout ORIG_HEAD
> > or
> >   $ git checkout HEAD@{1}
> 
> But the point is he wants to go back to the branch he came from.  He
> does not want to detach HEAD at the original commit.
> 
> Having said that, I am not sympathetic to "I have to remember".

I abuse git bisect for this temporary switcing. It only gives me a one
level memory, but otoh the git prompt tells me I'm on a discourse.

[me@lathund GIT (rr/abspath|BISECTING)]$ git checkout master
Switched to branch "master"

[me@lathund GIT (master|BISECTING)]$ git checkout HEAD~2
Note: moving to "HEAD~2" which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at afcc4f7... Merge branch 'js/prune-expire'

[me@lathund GIT (afcc4f7...|BISECTING)]$ git bisect reset
Previous HEAD position was afcc4f7... Merge branch 'js/prune-expire'
Switched to branch "rr/abspath"
[me@lathund GIT (rr/abspath)]$

-- robin
