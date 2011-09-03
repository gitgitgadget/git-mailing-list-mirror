From: Tobias Ulmer <tobiasu@tmux.org>
Subject: [BUG] git push --quiet fails with older versions
Date: Sat, 3 Sep 2011 12:57:23 +0200
Message-ID: <20110903105723.GA16304@tin.tmux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 13:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qzo5O-0000yv-N9
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 13:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab1ICLIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 07:08:22 -0400
Received: from tin.tmux.org ([64.85.165.147]:24111 "EHLO tin.tmux.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab1ICLIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 07:08:21 -0400
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Sep 2011 07:08:21 EDT
Received: by tin.tmux.org (Postfix, from userid 1000)
	id 965971FCBD; Sat,  3 Sep 2011 10:57:23 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180652>

Hi guys,

my distro updated git to 1.7.6.1. Now git push --quiet, used in various
scripts, blows up against 1.7.6. I don't know how backwards compatible
git tries to be, but in my opinion that seems like a regression for a
patchlevel release.

The problem seems to be that the remote git receive-pack does not
understand --quiet. Maybe it is possible to check for the remote version
before sending incompatible commandline parameters?

Quick demo:

lead:ssh$ git version
git version 1.7.6.1
lead:ssh$ git push
Everything up-to-date
lead:ssh$ git push -q
usage: git receive-pack <git-dir>
fatal: The remote end hung up unexpectedly

The remote uses:
radon:~$ git version
git version 1.7.6

Please keep me in CC, I'm not subscribed.

Tobias
