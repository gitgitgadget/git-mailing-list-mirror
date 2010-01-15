From: Rudolf Polzer <divVerent@alientrap.org>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 14:44:26 +0100
Message-ID: <20100115134425.GA30986@rm.endoftheinternet.org>
References: <op.u6g8jnixg402ra@nb-04> <20100114154154.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001141130210.4985@pacific.mpi-cbg.de> <20100115072741.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:44:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVmTc-0008Qu-H4
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 14:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab0AONoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 08:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437Ab0AONob
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 08:44:31 -0500
Received: from rm.endoftheinternet.org ([94.23.21.40]:47649 "EHLO
	r23604.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751702Ab0AONob (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 08:44:31 -0500
Received: from rpolzer by r23604.ovh.net with local (Exim 4.69)
	(envelope-from <divVerent@alientrap.org>)
	id 1NVmTS-00088b-Er; Fri, 15 Jan 2010 14:44:26 +0100
Content-Disposition: inline
In-Reply-To: <20100115072741.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137070>

On Fri, Jan 15, 2010 at 07:27:41AM +0900, Nanako Shiraishi wrote:
> 'git push --track' was suggested as a way to let users delay that decision.
> 
> 'git branch --configure' to update the same information for an existing
> branch was suggested as an alternative UI. An added benefit is that this
> approach will allow the same option to be used when creating a branch.
> 
> 'git pull --remember' that remembers the options used from the command line
> was suggested as a solution in addition to 'git branch --reconfigure'. Users
> can postpone the decision even more than 'git push --track', and it naturally
> supports setting branch.topic.rebase with 'git pull --rebase --remember'.  It
> also has two additional benefits. 'push --track' configures what happens when
> you 'pull' (counter-intuitive), but 'pull --remember' makes 'pull' to change
> the setting used by 'pull' (much more natural). Also it does not add the
> confusing word 'track' to the interface (for a more detailed discussion on
> 'track', see http://article.gmane.org/gmane.comp.version-control.git/136785).

Still requires you to specify the remote and the branch name twice.

So the workflow would be:

git push origin localbranch:remotebranch
...
git pull --remember origin remotebranch:localbranch

instead of

git push --track origin localbranch:remotebranch
...
git pull

The one thing I want to avoid, is specifying the "origin
localbranch:remotebranch" stuff twice.

Doesn't make git pull --remember a bad idea, it's good in many other cases. But
in my specific use case, git push --track is the most useful one.

Rudolf
