From: Andreas Krey <a.krey@gmx.de>
Subject: Like commit -a, but...
Date: Mon, 5 Nov 2012 21:29:48 +0100
Message-ID: <20121105202948.GA17505@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 22:03:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVTpl-0007SF-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 22:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118Ab2KEVDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 16:03:36 -0500
Received: from continuum.iocl.org ([217.140.74.2]:35961 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073Ab2KEVDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 16:03:35 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id qA5KTm317749;
	Mon, 5 Nov 2012 21:29:48 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209083>

Hi all,

I have a workflow for which I can't quite find the git tooling.

Essentially what I want is like 'git commit -a', except that I
want the resulting commit on a branch I name instead of the current
one, and I want my current index not being modified. At the moment
I emulate that via

  git commit -a -m TEMP": `date` $*" && \
  git push -f nsd master:temp && \
  git reset HEAD^ && \

but that a) changes the index (ok, not that bad), and it
will change my current commit in the case that there are
no unmodified files (no commit -> head doesn't point
where I want). Ok, that can be prevented by --allow-empty.

But still I'd like to know if there is a cleaner solution,
esp. with respect to the index.

(Ah, the point of all this is to take the exact current worktree and
push it to a compile&deploy server; I don't want to chop my work into
commits before I even could compile it.)

Andreas



-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
