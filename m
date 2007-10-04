From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: Re: making "git stash" safer to use
Date: Thu, 04 Oct 2007 10:40:08 +0200
Message-ID: <858x6jff2v.fsf@lupus.ig3.net>
References: <200709301421.52192.bruno@clisp.org> <200710021350.54625.bruno@clisp.org> <47023699.3080606@byu.net> <200710032331.41385.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 10:41:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdMGf-00078B-At
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 10:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbXJDIlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 04:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbXJDIlE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 04:41:04 -0400
Received: from main.gmane.org ([80.91.229.2]:59568 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbXJDIlD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 04:41:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IdMG5-0004ko-PI
	for git@vger.kernel.org; Thu, 04 Oct 2007 08:40:37 +0000
Received: from 22.80-203-45.nextgentel.com ([80.203.45.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 08:40:37 +0000
Received: from cjhaga by 22.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 08:40:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 22.80-203-45.nextgentel.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:g/fpKvZGqQcrAxnaL7X1nTg97J4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59932>

> Through a simple typo I lost modifications to 20 files:
>
>> >>>     $ git stash
>> >>>     $ git pull
>> >>>     $ git stash apply
>> >>>     $ git stash clean              # typo!
>> >>>     $ git stash clear              # fatal correction to typo!
>
> It is just too easy to lose your modifications by using "git stash".

What makes it most dangerous is that there is no differentiation
between a name and a command in the same position. I'd argue that 
either the command should be mandatory:

git stash save mywork
git stash apply mywork
git stash clear mywork
git stash mywork       # error

(we can still keep today's shortcuts "git stash" and "git stash apply", 
but only for the un-named case),

or that the command should be of the option type:

git stash mywork
git stash --apply mywork
git stash --clear mywork


-j.
