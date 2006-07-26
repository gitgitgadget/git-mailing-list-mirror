From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 12:05:47 -0700
Message-ID: <7vac6wrxtg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<200607262039.25155.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 26 21:06:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5ohs-00056s-25
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 21:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWGZTFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWGZTFt
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 15:05:49 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34546 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161023AbWGZTFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 15:05:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726190548.TCPM27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 15:05:48 -0400
To: git@vger.kernel.org
In-Reply-To: <200607262039.25155.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Wed, 26 Jul 2006 20:39:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24238>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Wednesday 26 July 2006 19:41, Johannes Schindelin wrote:
>> 
>> If dir2 already exists, git-mv should move dir1 _into_dir2/.
>> Noticed by Jon Smirl.
>
> Thanks for adding this test.
> BTW, the original PERL script passes it quite fine.
>
> I just looked at Jon's problem. Doesn't seem to be related to
> git-mv or git at all, but more a cogito problem.
> I have some cogito-0.18pre installed, and cg-patch is patching
> the stuff all itself, not using git for this. Pasky?

"git apply" seems to grok this just fine.

> Doing the same with git, i.e. in a rep with existing dir/
>
>  mkdir new
>  git mv dir new
>  git diff --cached -M -C >patch
>  git reset --hard
>  git apply <patch
>
> However, "git status" shows the "new/" directory totally
> untracked afterwards. Is this expected?

Running "git apply --index <patch" I see the "renamed: " in
there and zzz (or your "new") is tracked.
