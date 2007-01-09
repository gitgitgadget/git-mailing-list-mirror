From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add contrib/stg-gitk: helper script to run gitk
Date: Tue, 9 Jan 2007 23:03:32 +0100
Message-ID: <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth> <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 23:03:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4P4J-0004Mu-Tp
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 23:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbXAIWDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 17:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbXAIWDl
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 17:03:41 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:45015 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbXAIWDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 17:03:40 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id ED3C127A02;
	Tue,  9 Jan 2007 23:03:38 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id BEECF1F0A3; Tue,  9 Jan 2007 23:03:32 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36413>

On Tue, Jan 09, 2007 at 10:02:06AM +0000, Catalin Marinas wrote:
> There is 'stg series --graphical' that invokes gitk.

For some reason I did not look for this functionality in that place :)

But it is a bit different, in that unapplied patches appear detached
from the whole history.  Possibly out of personal taste, I do not find
this very useful, and prefer to see them as "gitk --all" shows them.

> Maybe the 'show' command could have a similar option.

Hm, not sure.  "show" is about a patch, not a stack.


(let's go off-topic)

That makes me think that such command names like "show" are a bit too
general: stgit uses "show" for patches, but nothing says it is for a
patch and not a series.

Also, when presenting GIT/StGIT to co-workers, I found them to be
confused by eg. "stg push" and "stg commit" having different semantics
than "git push" and "git commit".

Finally, we have some "stgit commands" (eg. branch), which are not
only real commands, but also give access to sub-commands.


Maybe some restucturing of commands is called for.  One possibility
would be to go with prefixes (eg. ppush, pshow), but that does not
address the sub-commands issue, which would have to be dealt with
another way, possibly by multiplying commands (branch -> blist,
bcreate, etc), which I'm not very fond of.

Another would be to generalize command groups, and acknowledge
subcommands as such.  Eg:

stg branch --create		-> stg branch create
stg show			-> stg patch show
stg push			-> stg patch push


The latter obviously suggests that some would want to keep "stg push"
as an alias (here comes again the idea of programable aliases like we
already have for GIT.


> I'm a bit reluctant to these patches. I really don't like mixing
> different languages (python and shell script) in the StGIT command
> implementations.

I concur.  This is why I submitted them as contrib/ stuff.

> Some of the patches you posted can be implemented in Python as either
> new commands or extensions to the current ones (I'll follow up to your
> other e-mails).

Right - indeed they can be seen as prototypes for future clean
features.  I'm simply not used enough to python, and it was quicker
for me to get those prototypes in shape this way.

Best regards,
-- 
Yann.
