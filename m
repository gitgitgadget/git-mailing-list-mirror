From: Yann Dirson <ydirson@altern.org>
Subject: Re: Howto use StGit and git-svn at same time
Date: Tue, 9 Jan 2007 23:41:25 +0100
Message-ID: <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 23:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Pez-0006Tr-6q
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 23:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbXAIWle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 17:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbXAIWle
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 17:41:34 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:50841 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932474AbXAIWld (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 17:41:33 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id AB94E7D64;
	Tue,  9 Jan 2007 23:41:31 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 738CC1F0A3; Tue,  9 Jan 2007 23:41:25 +0100 (CET)
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Content-Disposition: inline
In-Reply-To: <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36417>

On Tue, Jan 09, 2007 at 10:41:20PM +0100, Guilhem Bonnefille wrote:
> Humh...
> I finished the conflicts solving game. I think the way I choosed is
> incorrect. Following gitk, it is now a big big bazaar in my commits
> history.

Right, you should not use git-rebase on a StGIT branch :)

What you should have done is moving your stack base from your old
origin branch to remotes/trunk - something that StGIT does not support
yet from command-line, but I've done this manually in the past
(migrating an StGIT stack after re-running a full git-cvsimport after
the original cvs branch got corrupted).

Something along the line of (untested, off the top of my head):

$ stg pop -a
$ echo <TARGET-SHA1>  >  .git/refs/heads/<BRANCH>
$ echo <TARGET-SHA1>  >  .git/refs/bases/<BRANCH>

And then use "stg push" and "stg resolved -i" to resolve the conflicts.

But always be sure of backing up your .git before doing such by-hand
experiments.

Best regards,
-- 
Yann.
