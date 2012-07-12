From: Felix Natter <fnatter@gmx.net>
Subject: Export from bzr / Import to git results in a deleted file re-appearing
Date: Thu, 12 Jul 2012 20:00:17 +0200
Message-ID: <87ehogrham.fsf@bitburger.home.felix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 20:05:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpNlJ-0001Lv-T5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 20:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934143Ab2GLSFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 14:05:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:59553 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934079Ab2GLSFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 14:05:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SpNlB-0001C1-Lq
	for git@vger.kernel.org; Thu, 12 Jul 2012 20:05:05 +0200
Received: from pd9e84f5e.dip.t-dialin.net ([217.232.79.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2012 20:05:05 +0200
Received: from fnatter by pd9e84f5e.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2012 20:05:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e84f5e.dip.t-dialin.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Cancel-Lock: sha1:elzUbBQr6X19Bj2YO0dC3sW3SA8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201372>

hi,

I am trying to move freeplane's repository (GPL-project) from bzr to
git, but when I do this:

$ mkdir freeplane-git1
$ cd freeplane-git1
$ git init .
$ bzr fast-export --export-marks=../marks.bzr ../trunk/ | git fast-import --export-marks=../marks.git
$ git checkout

then there are no errors, but the resulting working index is broken:
 freeplane-git1/freeplane_plugin_formula/src/org/freeplane/plugin/formula
 contains SpreadSheetUtils.java which belongs to package
 'org.freeplane.plugin.spreadsheet' and which is no longer in the bzr
 trunk that I imported!

The freeplane repo is publically available, so you should easily be able
to reproduce this:
  bzr branch bzr://freeplane.bzr.sourceforge.net/bzrroot/freeplane/freeplane_program/trunk

I reported this as a possible bzr-fastimport bug, but didn't get a
response so far:
  https://bugs.launchpad.net/bzr-fastimport/+bug/1014291

Is there maybe a better way to convert a repo from bzr to git?
This seems to be the standard solution on the web.

I am using Bazaar (bzr) 2.5.0dev6, bzr-fastimport 0.13.0 and git 1.7.10.4.

Thanks and Best Regards!
-- 
Felix Natter
