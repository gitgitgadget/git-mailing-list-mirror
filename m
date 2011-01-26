From: Mike Kelly <mike@piratehaven.org>
Subject: Re: Confused about git filter-branch results
Date: Wed, 26 Jan 2011 03:18:35 -0800
Message-ID: <20110126111835.GA1765@skull.piratehaven.org>
References: <20110125114840.GB9367@skull.piratehaven.org> <201101251732.40811.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 26 12:18:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi3Od-0007RP-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 12:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab1AZLSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 06:18:38 -0500
Received: from dsl081-246-077.sfo1.dsl.speakeasy.net ([64.81.246.77]:52219
	"EHLO piratehaven.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751307Ab1AZLSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 06:18:37 -0500
Received: from skull.piratehaven.org (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by piratehaven.org (Postfix) with ESMTP id A4195508051;
	Wed, 26 Jan 2011 03:18:36 -0800 (PST)
Received: (from mike@localhost)
	by skull.piratehaven.org (8.13.8/8.13.8/Submit) id p0QBIZBH002270;
	Wed, 26 Jan 2011 03:18:35 -0800
Content-Disposition: inline
In-Reply-To: <201101251732.40811.trast@student.ethz.ch>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165517>

On Tue, Jan 25, 2011 at 05:32:40PM +0100, Thomas Rast wrote:
> Before you read the explanations below, I recommend that you open
> 'gitk --all' and use it to see whether I'm right.
> 
This was really useful for finding my problem.

> Most likely you filtered all commits on your branch, but not master,
> so master now points to an entirely disjoint set of commits.
> 
Almost exactly correct.  The tree branched off at a really early point in
development.

> Assuming my "disjoint history" theory is correct, you should either
> discard your rewrite along the lines of
> 
>   git branch -f foo refs/original/refs/heads/foo
> 
Done.  This cleaned up the mess.

> Confused yet? :-)
> 
Not at all, I found your explanation to be clear and straight forward.
Thank you.

At first I was grumbling to myself about git filter-branch rewriting every
commit, but then I remembered that there were a few messages on stderr
complaining that some commits were not in the correct encoding.  I guess
that the tool decided to rewrite these commits for me (without asking),
thus causing a fork.  Sorry for not mentioning these error messages before,
I forgot about them in the ensuing panic.

I just want to give a shout-out to all the git developers, I've used RCS,
CVS, and SVN in the past, and they all had different ways of making life
miserable.  Git is the first tool which I felt was working with me, not
against me.  Keep up the good work!

Anyway, I'm back in business and have by branch under control again.

Thanks again,

Mike
(:

-- 
--------Mike@PirateHaven.org-----------------------The_glass_is_too_big--------
