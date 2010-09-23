From: Louis Strous <louis.strous@gmail.com>
Subject: Re: [PATCH/RFC v4 0/2] Add -e/--exclude to git clean.
Date: Thu, 23 Sep 2010 09:05:05 +0000 (UTC)
Message-ID: <loom.20100923T103502-148@post.gmane.org>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com> <cover.1279643093.git.jaredhance@gmail.com> <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com> <7vaapmm3ow.fsf@alter.siamese.dyndns.org> <7v630am2qt.fsf@alter.siamese.dyndns.org> <20100720191131.GA2688@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 11:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyhon-0006ZB-6Z
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 11:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab0IWJKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 05:10:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:58704 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab0IWJKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 05:10:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oyhob-0006SX-Hl
	for git@vger.kernel.org; Thu, 23 Sep 2010 11:10:05 +0200
Received: from ipleiden.intellimagic.net ([188.203.61.169])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 11:10:05 +0200
Received: from louis.strous by ipleiden.intellimagic.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 11:10:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.203.61.169 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156861>

The git clean -e option is more useful than just for stuff that you plan to
bring under git control later.  It also allows to retain per-user configurations
of external tools when using git clean to remove all build results and
intermediate files.  This leads to the enhancement request described below.

Most IDEs (integrated development environments) allow the user to configure
various display and debugger options, and store those options in some
configuration file.  Such user option files should not be under git control in a
multi-user environment, because then all users are forced to use the same
options.  Yet these user option files should not be deleted when the rest of the
untracked files are deleted (through git clean), otherwise the user options are
lost.

git clean -x -d -f -e "pattern" removes all untracked files except those
matching the pattern.  However, it is cumbersome to specify these patterns every
time.  It would be more convenient if git clean would read such patterns from a
file similar to .gitignore (maybe .gitignoreclean?).  Then that file itself
could be put under git control and shared with the other developers.

I request implementation of this feature.

Best regards,

Louis Strous
