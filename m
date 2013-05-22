From: Andreas Krey <a.krey@gmx.de>
Subject: first parent, commit graph layout, and pull merge direction
Date: Wed, 22 May 2013 13:50:42 +0200
Message-ID: <20130522115042.GA20649@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 22 13:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf7ZD-0004d4-5U
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 13:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab3EVLur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 07:50:47 -0400
Received: from continuum.iocl.org ([217.140.74.2]:37882 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab3EVLuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 07:50:46 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4MBogt21166;
	Wed, 22 May 2013 13:50:42 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225146>

Hi everyone,

I'm just looking into better displays of the commit graph (as
displayed with gitk, smartgit, fisheye) - they tend to quickly
dissolve into a heap of spaghetti.

We had the idea that treating the first parent specially would
have some advantage here - including graphically indicating which
one of the parents of a commit is the first parent. (For instance,
by letting that line leave the commit node at the top/bottom,
and the other(s) to the side.)

A short trial showed that representing first parent chains as
straight lines in the graph does actually improve understandability,
as feature branches clearly stand out as separate lines even when
they no longer carry a branch name.

Does any GUI already do that (treat first parent specially),
or does anybody think of doing such? I don't quite dare to
jump into the gitk code yet.

Also, there is an implication with 'git pull': You'd expect the
master branch to be a first parent line, but when I do a small
thing directly on master and need to pull before pushing back,
then origin/master is merged into my branch, and thus my side
branch becomes the first parent line.

So, feature discussion request: Invert the parent ordering
when doing git pull from upstream? Configurably so?

We actually thought about putting a restriction into our blessed
repo that it not only restricts to fast-forward pushed, but further
to only allow pushing new things that have the old branch head in
the first parent chain.

What do you think?

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
