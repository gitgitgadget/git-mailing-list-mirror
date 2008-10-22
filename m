From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUCNE] repo - The Multiple Git Repository Tool
Date: Wed, 22 Oct 2008 08:42:45 -0700
Message-ID: <20081022154245.GT14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 17:44:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfsO-00055k-Go
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYJVPmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYJVPmq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:42:46 -0400
Received: from george.spearce.org ([209.20.77.23]:46231 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbYJVPmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 11:42:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 209A23835F; Wed, 22 Oct 2008 15:42:45 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98880>

My "bundle related secret project" was released yesterday by Google
as part of the Android open source release event.  (I've mentioned
it before on-list in the context of a modified "git status" output.)

Google developed two tools, repo and Gerrit, and open sourced them
under the Apache License:

  http://android.git.kernel.org/?p=tools/repo.git
  http://android.git.kernel.org/?p=tools/gerrit.git

  git://android.git.kernel.org/tools/repo.git
  git://android.git.kernel.org/tools/gerrit.git

repo is a Python application to bind together Git repositories,
something like "git submodule", except it can track a project's
branch rather than a specific Git commit.  repo is also able to
natively import a tarball or zip file and use it to initialize a
repository from an upstream source, then apply git based changes
on top of that tarball.  In other words, repo is (more or less)
built to manage an OS distribution, in Git.

Gerrit is a web based code review system, forked off the open
sourced Rietveld code review system.  Gerrit runs on the highly
scaleable Google App Engine platform, but probably could be ported
to an open-source MySQL or PostgreSQL backend if people really
wanted to do that.


You can read some more of how Android has applied these tools to
its development process here:

  http://source.android.com/download
  http://source.android.com/submit-patches/workflow
  http://source.android.com/download/using-repo

Although the current tool documentation is only on the Android
site, both the repo and Gerrit tools are not specific to Android
and are designed to be applied to any project that wants to use a
similar process.


repo and Gerrit are actually developed with themselves.  You can
use repo to fetch repo:

  curl http://android.git.kernel.org/repo >~/bin/repo
  chomd a+x ~/bin/repo

  mkdir myrepo
  cd myrepo

  repo init -u git://android.git.kernel.org/tools/manifest.git
  repo sync


The "git status" output I was talking about before is the "repo
status" subcommand, e.g.:

  $ echo '# test' >>repo/repo   ; # modify a tracked file
  $ repo status
  project repo/                                   (*** NO BRANCH ***)
   -m     repo

-- 
Shawn.
