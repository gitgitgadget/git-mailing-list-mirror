From: Mike Kelly <mike@piratehaven.org>
Subject: Confused about git filter-branch results
Date: Tue, 25 Jan 2011 03:48:40 -0800
Message-ID: <20110125114840.GB9367@skull.piratehaven.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 25 13:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phhoy-0000y0-6U
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 13:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab1AYMQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 07:16:10 -0500
Received: from dsl081-246-077.sfo1.dsl.speakeasy.net ([64.81.246.77]:46739
	"EHLO piratehaven.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753489Ab1AYMQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 07:16:08 -0500
X-Greylist: delayed 1645 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2011 07:16:08 EST
Received: from skull.piratehaven.org (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by piratehaven.org (Postfix) with ESMTP id B3558508051
	for <git@vger.kernel.org>; Tue, 25 Jan 2011 03:48:42 -0800 (PST)
Received: (from mike@localhost)
	by skull.piratehaven.org (8.13.8/8.13.8/Submit) id p0PBmeDM012296
	for git@vger.kernel.org; Tue, 25 Jan 2011 03:48:40 -0800
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165479>

Hi Everyone,

I was fooling around with 'git filter-branch --env-filter ...' trying to
update the timestamps on my commits (which worked), but now when I run
'git whatchanged -p master..' shows all changes to the entire project, not
the differences between my branch and the master branch.

Being a novice git user, I'm not sure how much to trust that I didn't hose
git in some really weird way, leaving it in a state where it doesn't quite
work the way it did before.

The contents of .git/refs/original/refs/heads/ shows a file with my branch
name which contains only one entry (presumably the one I updated the
timestamp on) so I feel pretty sure that only the commit I wanted to change
actually changed.  However, the fact that 'git whatchanged -p' now behaves
differently makes me worry.

Nothing went wrong during my update, however, I forgot to give a range
label so it searched the entire project.  In theory nothing should have
changed, but...

Ultimately, my worry is that I polluted the history which I cloned, and
pushing that would make people unhappy.

I can still get to my patches, so I can still do a fresh pull and reapply
all my changes again, as a last resort, but I'd rather not if I don't
have to.

So my questions are:
 1) Is this a problem with an easy fix?
 2) If not, can I back out my change?
 3) Is git push --dry-run the best way to find out what I changed?  Is there
    a better way to see what will be pushed?
 4) Is there a better way to update the timestamps of my commits so that my
    patches will appear as a solid block of commits in the history (as that
    is how they will be committed), not interleaved with other changes in
    the past (giving the false impression that they were applied to the
    master tree when they were not)?

Thanks in advance,

Mike
(:

-- 
--------Mike@PirateHaven.org-----------------------The_glass_is_too_big--------
