From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: keeping /etc under git with etckeeper
Date: Sat, 09 Aug 2008 23:15:32 -0400
Message-ID: <489E5D54.7040708@thewritingpot.com>
References: <14b409fc0808091148k69f4019n6996261a710adfca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pj.bringer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 05:18:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS1Rh-00026N-VM
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 05:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbYHJDPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 23:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbYHJDPo
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 23:15:44 -0400
Received: from main.gmane.org ([80.91.229.2]:40125 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbYHJDPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 23:15:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KS1PB-0004UP-P1
	for git@vger.kernel.org; Sun, 10 Aug 2008 03:15:41 +0000
Received: from ool-44c0454d.dyn.optonline.net ([68.192.69.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 03:15:41 +0000
Received: from edwardzyang by ool-44c0454d.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 03:15:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-44c0454d.dyn.optonline.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <14b409fc0808091148k69f4019n6996261a710adfca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91801>

Pierre-Julien Bringer wrote:
> Do you think storing the etc directory in git with etckeeper is a good
> thing? I've heard it was not recommended to do so for the home
> directory, but also for /etc:

I've been using etckeeper for a while now, and it's working reasonably
well. The one thing I personally don't like, however, is the fact that
etckeeper automatically commits a dirty /etc state before the
auto-commits for any installed packages. I.e. auto-commit on apt-get
GOOD, auto-commit on other changes BAD. Fortunately, it's relatively
easy to change the commit hooks to do your bidding. :-)

With carefully issued Git commands, you can have Git refuse to touch any
files when there is a merge conflict, so you can resolve it in another
checkout. Of course, Git makes it extremely easy to back out a failed
merge, so as long as there isn't an essential process polling /etc every
few seconds, you should be savvy if you revert before a reboot.
