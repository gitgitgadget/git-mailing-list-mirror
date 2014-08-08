From: Ryan Gaffney <ryanmgaffney@gmail.com>
Subject: Merging semi-parallel universes into one coherent repository
Date: Thu, 7 Aug 2014 18:41:29 -0700
Message-ID: <CAJH7hnOXOuz0SxLU99iXo9ikfN==HgwmxKyXx1nukodVqYUtoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 03:42:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFZC1-0004vx-Re
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 03:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702AbaHHBmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 21:42:01 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:52707 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbaHHBmA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 21:42:00 -0400
Received: by mail-oi0-f42.google.com with SMTP id a3so3247731oib.29
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=16czzUfc7yeK86wP0n9w7T1wes8M8lv8gsxDRTsp5Qo=;
        b=LmSg9y9bV7uRUXdp2MvrptqtgNOz+jkp8mua0TkiVn9/Pc+oWViucQPCAZh3bNRp9R
         kfGUPDtkCwIzb7a0y5DCMkejy3eB54zc6CNCWcCFqOORDtUppgISsPxd59qBwCz4/Aue
         AP3fwhk/BcIdHBOwfAKGzs1/FtswfkeadlIvKX7k0k+/T9X/8hWX/4UCZK81Ywe+kYiv
         XKjHKB7agaloA6QdSXLFOaHzSGxNP3OqvkJwUhnPezBzXDIQoRod9TtQ7zFnVhSSl30D
         EG5/DO1egZxAM3SDCmfvc0FMOJzlrVaRcOFmvkX/Q0DNngbRdQ9dmB+6OX/EekNvGtsJ
         8QMA==
X-Received: by 10.60.103.195 with SMTP id fy3mr27602661oeb.35.1407462119925;
 Thu, 07 Aug 2014 18:41:59 -0700 (PDT)
Received: by 10.182.51.197 with HTTP; Thu, 7 Aug 2014 18:41:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255001>

Hello

I created a post on SO about this; pasting it here for convenience:

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
http://stackoverflow.com/questions/25193518/fixing-branches-disconnected-from-master

After "completing" a repository migration, we noticed that all of our
branches are all behind and ahead of master by hundreds to thousands
of commits.

Some context -- originally I used git-svn to migrate the repositories
from SVN to git. Later down the line I used this solution to merge
multiple (7) repositories into one.

However, I also improvised on that solution for the repositories'
branches. The result was disconnected branches -- branches that have
all of the commits and proper change history, but are not actually
associated with master in any way since the commits in the branches
have different SHA's from those in the new, shared master.

Additionally, the original "branching" in the separate repositories
happened at different revisions, for example project X might have
branched for release 1.0 at revision 30 whereas project Y might have
branched fro release 1.0 at revision 42... and all of them have
different times (and perhaps multiple times) where they merged back to
master.

Is there any clean way to fix this link to make it look like all of
these repositories branched together? And to fix the commits so they
actually properly map to commits in master?
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

I am sure there is a better way to word the above... but basically I
have seven used-to-be-separate repositories with the same branches
(say r1.0 as above).  After some magic with filter-branch, they are
all one repository -- all history in-tact.  Additionally, same-named
branches had their histories mashed together.  That's all peachy.

What's *not* peachy is that each of these branches shares commits with
master and doesn't know it.  Thus each branch looks "disconnected"
from master, e.g. there is no pretty branch graph when you look
through the history with "git log --pretty=format:"%h %s" --graph".

Does anybody know of a way to rectify this issue?

Let me know if any clarifications are needed.  Help is much appreciated...

-- Ryan
