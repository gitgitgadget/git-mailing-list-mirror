From: David Mohs <dgma@mohsinc.com>
Subject: Re: Git performance results on a large repository
Date: Mon, 6 Feb 2012 07:10:13 +0000 (UTC)
Message-ID: <loom.20120206T054853-321@post.gmane.org>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>,<CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com> <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 08:15:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuInD-0000XD-3t
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 08:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab2BFHPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 02:15:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:59286 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2BFHPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 02:15:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RuIn1-0000Tl-MV
	for git@vger.kernel.org; Mon, 06 Feb 2012 08:15:03 +0100
Received: from c-50-137-76-249.hsd1.ma.comcast.net ([50.137.76.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 08:15:03 +0100
Received: from dgma by c-50-137-76-249.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 08:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 50.137.76.249 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.52.7 (KHTML, like Gecko) Version/5.1.2 Safari/534.52.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190036>

Joshua Redstone <joshua.redstone <at> fb.com> writes:

> To get a bit abstract for a moment, in an ideal world, it doesn't seem like
> performance constraints of a source-control-system should dictate how we
> choose to structure our code. Ideally, seems like we should be able to choose
> to structure our code in whatever way we feel maximizes developer
> productivity. If development and code/release management seem easier in a
> single repo, than why not make an SCM that can handle it? This is one reason
> I've been leaning towards figuring out an SCM approach that can work well with
> our current practices rather than changing them as a prerequisite for good SCM
> performance.

I certainly agree with this perspective---that our tools should support our
use cases and not the other way around. However, I'd like you to consider that
the size of this hypothetical repository might be giving you some useful
information on the health of the code it contains. You might consider creating
separate repositories simply to promote good modularization. It would involve
some up-front effort and certainly some pain, but this work itself might be
beneficial to your codebase without even considering the improved performance
of the version control system.

My concern here is that it may be extremely difficult to make a single piece
of software scale for a project that can grow arbitrarily large. You may add
some great performance improvements to git to then find that your bottleneck
is the filesystem. That would enlarge the scope of your work and would likely
make the project more difficult to manage.

If you are able to prove me wrong, the entire software community will benefit
from this work. However, before you embark upon a technical solution to your
problem, I would urge you to consider the possible benefits of a non-technical
solution, specifically restructuring your code and/or teams into more
independent modules. You might find benefits from this approach that extend
beyond source code control, which could make it the solution with the least
amount of overall risk.

Thanks for starting this valuable discussion.

-David
