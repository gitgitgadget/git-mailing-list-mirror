From: Miles Bader <miles@gnu.org>
Subject: Re: are hashes calculated from data
Date: Fri, 02 Apr 2010 13:22:31 +0900
Message-ID: <buozl1mbi0o.fsf@dhlpc061.dev.necel.com>
References: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com>
	<o2q32541b131004011950u6023ef29ocac1d80f2847ef6f@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raymond Auge <raymond.auge@liferay.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 06:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxYPK-0003Vn-N1
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 06:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab0DBEWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 00:22:42 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:51171 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab0DBEWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 00:22:40 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o324MXIX014537;
	Fri, 2 Apr 2010 13:22:33 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Fri, 2 Apr 2010 13:22:32 +0900
Received: from dhlpc061 ([10.114.114.29] [10.114.114.29]) by relay11.aps.necel.com with ESMTP; Fri, 2 Apr 2010 13:22:32 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 725CC52E26A; Fri,  2 Apr 2010 13:22:32 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <o2q32541b131004011950u6023ef29ocac1d80f2847ef6f@mail.gmail.com>
	(Avery Pennarun's message of "Thu, 1 Apr 2010 22:50:06 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143775>

Avery Pennarun <apenwarr@gmail.com> writes:
> You can minimize the impact of this problem, however.  The easiest way is:
>
> - have only a single person use git-svn
>
> - when committing stuff to git-svn, first checkout the *existing*
> git-svn branch, then use "git merge --no-ff mybranch", then "git svn
> dcommit".  The --no-ff is very important; this makes sure that a *new*
> commit is created (a merge commit) for the svn dcommit.  svn dcommit
> then creates only a single svn commit that includes all the patches
> from the whole branch.
>
> - then do 'git checkout mybranch; git merge git-svn' to get the svn commit back.
>
> At work, we have a cronjob that basically does most of these steps for
> us.  Then there's a central git repo that corresponds to the svn repo;
> people who want to use git can use that repo and not worry about
> git-svn.

Do you happen to have the cron script available for perusal anywhere?

I imagine many of the details would need to be changed for other
installations, but just looking at a working concrete example could be
very helpful...

Thanks,

-Miles

-- 
=====
(^o^;
(()))
*This is the cute octopus virus, please copy it into your sig so it can spread.
