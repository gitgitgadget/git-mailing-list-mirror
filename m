From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: I can never finish a push
Date: Fri, 23 Dec 2011 15:18:38 +0100
Message-ID: <87liq3l6bl.fsf@thomas.inf.ethz.ch>
References: <4EF47DF3.9080809@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 15:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re5xX-0006t2-BV
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 15:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab1LWOSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 09:18:48 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:25610 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab1LWOSq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 09:18:46 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Dec
 2011 15:18:42 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Dec
 2011 15:18:43 +0100
In-Reply-To: <4EF47DF3.9080809@bbn.com> (Martin L. Resnick's message of "Fri,
	23 Dec 2011 08:11:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187628>

Martin L Resnick <mresnick@bbn.com> writes:

> I'm working remotely over a VERY slow line.
>
> When I do a push it starts out fine
> but after the 15 seconds it takes to push
> it fails with non-fast-forward merge.
>
> So I pull (no merge needed, its fast-forward)
> and try push again. Fails again.
>
> I can keep this up for hours on end;
> pushing, pulling, pushing, pulling.
> Apparently there is fast and furious development
> on the branch I'm on that during my 15 seconds
> of pushing someone else on-site pushes and adds
> new commits before mine can finish.
>
> Is there anyway to lock the repository while
> my push is going on ?

Git doesn't have any locking features.

Your best bet is probably to have someone with faster access merge your
branch, e.g., by pushing your work elsewhere (to another repo or just
a different branch) and then sending them an email asking for your work
to be merged.

If you have this issue a lot, the admins of your repo server could
probably arrange for a feature where you push to a special "please merge
this" branch namespace (such as incoming/martin-resnick), and the server
then does the merge for you using locking (and of course refusing if
there was any conflict).


However, it somewhat eludes me how you can generate churn on the order
of 2000 commits (8*3600/15) per workday *to the same repository*.
Perhaps the repository should be split into subprojects?  Or at the very
least, the subprojects should be handled in different repositories, from
which an integrator pulls together the daily latest-and-greatest across
all subprojects?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
