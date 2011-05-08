From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git alias fails if non-accessible directory is in PATH
Date: Sun, 08 May 2011 11:53:24 +0200
Message-ID: <iq5p6k$73f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ0gV-0001hc-9k
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 11:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1EHJxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 05:53:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:38652 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab1EHJxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 05:53:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QJ0gC-0001bF-Ej
	for git@vger.kernel.org; Sun, 08 May 2011 11:53:36 +0200
Received: from p5ddb0006.dip0.t-ipconnect.de ([93.219.0.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 May 2011 11:53:36 +0200
Received: from sschuberth by p5ddb0006.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 May 2011 11:53:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0006.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173086>

Hi,

I just came across the issue at [1] in my Gentoo installation. By default, it is

drwxr-x--- 2 root games 4096 Mar 12 02:22 /usr/games/bin

Moreover, by default users are not in the "games" group and /usr/games/bin is in PATH. For some reason, this makes git fail to run any alias like this

# git config alias.br branch
$ git br
fatal: cannot exec 'git-br': Permission denied

Is this by design, or a bug? I currently do not see a reason for git stop executing an alias just because it cannot access a directory in PATH. Strangely, I also haven't found any discussion about this on the mailing list yet.

The problem is also described at [2] for Mac OS. Reading those posts, this seems to be a regression when coming from 1.6.3 to 1.7.0.

[1] http://www.fractionsofapenny.com/from-the-trenches/gentoo-troubles-with-git-alias
[2] http://stackoverflow.com/questions/4019501/git-alias-problem

-- 
Sebastian Schuberth
