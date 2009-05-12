From: Andrew Schein <andrew@andrewschein.com>
Subject: Re: git default behavior seems odd from a Unix command line point of 
	view
Date: Tue, 12 May 2009 16:05:47 -0400
Message-ID: <4e963a650905121305s244309a5vef9eec671d1ee5e@mail.gmail.com>
References: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>
	 <7vd4ae8fls.fsf@alter.siamese.dyndns.org>
	 <4e963a650905120924j52d38c0dg577d93e913013e38@mail.gmail.com>
	 <alpine.LNX.2.00.0905121415000.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 22:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3yEk-0000TQ-0h
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 22:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbZELUFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbZELUFs
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 16:05:48 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:53799 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZELUFr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 16:05:47 -0400
Received: by bwz22 with SMTP id 22so200767bwz.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 13:05:47 -0700 (PDT)
Received: by 10.103.248.17 with SMTP id a17mr53314mus.83.1242158747201; Tue, 
	12 May 2009 13:05:47 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905121415000.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118950>

> What *is* your use case? What you're doing seems nuts to me (like, you're
> going to send out files with this script that someone is in the middle of
> editting), but I don't know what you're trying to do.

I am new to git... so my first instinct is to try to reproduce a work
flow that I know works with mercurial setup.  It is possible that the
concepts don't translate correctly.  Here goes...

I have a bunch of separate project-related repositories.  There are
very few users of the system.  Most of the time I am the only user.  I
want a system for syncing my local repositories to a single shared
repository.  For example some days I work on my laptop, and some days
from my desktop.  A third "shared/public" repository "on campus"
serves as an always available repository that anyone I collaborate
with can pull from.  Also it is backed up, and for this reason I
designate it the "shared" version.  So the purpose of the sync.sh
script is to synchronize the personal laptop/desktop repository to the
on-campus version.

Something I have learned from using mercurial in industry is that when
somebody messes up a "public repo" with conflicts they frequently
don't clean up the mess.  This can be a sign that they have not
learned the lessons of cleanliness rather than ill intent.  Otherwise
(and similarly) this messiness can be caused from not noticing that
they have left a mess.

The motivation of having a sync script that is run on each user's
local repository is to decrease the likelihood of a mess.  This is
achieved by first pulling from the common repository and resolving
conflicts _before_ "pushing" (note quotations) their changes to the
common repository.  There is a possibility of a race condition that
leaves a conflict on the shared repository, however the risk is
diminished.

Finally, I use "push" in quotes because actually the script uses only
uses the pull command.  This prevents proliferation of branches on the
shared repository.

Is there a better way to achieve this in git than the sync.sh script I
sent around?

Thanks,

Andy

-- 
Andrew I. Schein
www.andrewschein.com
