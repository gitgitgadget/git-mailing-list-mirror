From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 12:30:16 +0100
Organization: At home
Message-ID: <figv47$926$1@ger.gmane.org>
References: <200711271127.41161.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 12:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwyeq-0000Kf-J8
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbXK0Lay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbXK0Lay
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:30:54 -0500
Received: from main.gmane.org ([80.91.229.2]:41532 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104AbXK0Lax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:30:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IwyeC-0002hx-K2
	for git@vger.kernel.org; Tue, 27 Nov 2007 11:30:36 +0000
Received: from abvx183.neoplus.adsl.tpnet.pl ([83.8.221.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 11:30:36 +0000
Received: from jnareb by abvx183.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 11:30:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx183.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66190>

gapon wrote:

> hi all,
> first of all i don't know if there's a bugzilla or something similar
> for git - i have found just this email (on http://git.or.cz/ webpage).

There isn't any bug tracker for git. Use git mailing list for bug
reports and feature requests.

> i have discovered "weird" behaviour of git in this scenario*:
> - user A is working in repo A
> - user B clones repo A
> - user B makes some changes, commits, pushes

Do not push into checked out branch!

> - user A makes some changes, git status (no info about new commit
>   in his repo from user B but it's probably ok i'd say - but some
>   of my files are marked as changed and already added to index
>   but i haven't changed them - that's confusing, isn't it?)
> - user A can commit his changes => shouldn't be there any
>   info/message/warning displayed? it would be helpful to have
>   here some info about "foreign commit" in the repo or something
>   like this 

Perhaps there should. There was some idea and even preliminary
implementation of BASE check, but IIRC it was deemed too complicated,
and encouraging wrong workflow.

Besides, even with the check, pushing into checked out branch can quite
easily lead either to loosing (or at least vanishing) some history,
or problems with pushing.

> * yes, i know that this scenario is "incorrect" but... it's possible and 
>   therefore i think it should be somehow handled - i tried a similar one
>   with hg and bzr and i like their behaviour more

IIRC we strongly discourage in documentation to push into checked out
branch. Either use bare repository for communication (it allows for
example for got for "ideal patch series" by rewriting history _before
publishing (pushing)_ and for communication with more than one
chosen developer), or push into _remotes_, not into heads.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
