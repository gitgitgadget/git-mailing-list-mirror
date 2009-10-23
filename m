From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Detached HEAD and "git log --all"
Date: Fri, 23 Oct 2009 10:36:44 +0200
Message-ID: <4AE16B1C.9050205@drmicha.warpmail.net>
References: <200910222237.04056.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 10:37:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Fe4-0005Sp-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 10:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbZJWIgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 04:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbZJWIgp
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 04:36:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33202 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329AbZJWIgp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 04:36:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 26818B5A69;
	Fri, 23 Oct 2009 04:36:50 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 23 Oct 2009 04:36:47 -0400
X-Sasl-enc: Ne+OTPUiU7n35vmZ0A2C9NkbGHf7nZquZisyREWg/sX9 1256287009
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 939B66F975;
	Fri, 23 Oct 2009 04:36:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091020 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <200910222237.04056.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131099>

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

...OK, finally found it: Dscho did just that in f0298cf (revision
walker: include a detached HEAD in --all, 2009-01-16) which is in
v1.6.1.3 and later.

Cheers,
Michael
