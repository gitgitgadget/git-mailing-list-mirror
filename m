From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Detached HEAD and "git log --all"
Date: Fri, 23 Oct 2009 10:33:52 +0200
Message-ID: <4AE16A70.9050200@drmicha.warpmail.net>
References: <200910222237.04056.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 10:36:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Fb6-00032o-4N
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 10:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbZJWId4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 04:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbZJWId4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 04:33:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43986 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083AbZJWIdz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 04:33:55 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0CBA4B6103;
	Fri, 23 Oct 2009 04:34:00 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 23 Oct 2009 04:34:00 -0400
X-Sasl-enc: BaTijMtkHPcplxz7rx2ZahcPN30TPMD9BlnJw/GzH1fU 1256286839
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 539766F938;
	Fri, 23 Oct 2009 04:33:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091020 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <200910222237.04056.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131098>

Jakub Narebski venit, vidit, dixit 22.10.2009 22:37:
> When discussing differences between concept and implementation
> of branches in Git and in Mercurial on StackOverflow[1] (abusing
> SO comment system a bit), Steve Losh[2] wrote that he was surprised
> by the fact that "git log --all" doesn't include commits made
> on detached HEAD.
> 
> While documentation clearly states:
> 
>   --all  Pretend as if all the refs in `$GIT_DIR/refs/` are listed
>          on the command line as <commit>.
> 
> and HEAD is in `$GIT_DIR/HEAD`, which is outside `$GIT_DIR/refs/`,
> it is nevertheless a bit strange that "git log --all" doesn't list
> all (everything).
> 
> This is of course only an issue if we are on detached HEAD; I guess
> that semantics of `--all` option to git-log predates this feature.
> 
> [1] http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-and-contrast/1599930#1599930
> [2] http://stevelosh.com/blog/entry/2009/8/30/a-guide-to-branching-in-mercurial/
> 

Commit 77abcbd (Let --decorate show HEAD position, 2009-10-12) goes a
little bit in that direction, adding HEAD to the "labels" that
--decorate may use, but not to the list of refs specified by "--all". But:

Well, after playing around a bit: git rev-list --all does list my
detached HEAD, git log --all shows it (which is the same statement, of
course), whether I use --decorate or not. Are you seeing different
behaviour?

git describe --all HEAD does not describe the detached HEAD (other than
v1.6.5-87-g4584daf in my case), which may or may not be desirable
(because describe outputs at most one description, unlike --decorate).

Michael
