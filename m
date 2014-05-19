From: Karen Etheridge <ether@cpan.org>
Subject: bug: autostash is lost after aborted rebase
Date: Sun, 18 May 2014 17:57:20 -0700
Message-ID: <20140519005719.GB38299@tequila>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 03:36:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmCVP-00046s-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 03:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbaESBgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 21:36:40 -0400
Received: from ns2.lightspeed.ca ([206.12.82.4]:39333 "EHLO www.lightspeed.ca"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752346AbaESBgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 21:36:39 -0400
X-Greylist: delayed 2355 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 May 2014 21:36:39 EDT
Received: from 69-50-167-197.westerncable.ca ([69.50.167.197] helo=etheridge.ca)
	by www.lightspeed.ca with esmtp (Exim 4.80)
	(envelope-from <ether@cpan.org>)
	id 1WmBtI-0005es-JS
	for git@vger.kernel.org; Sun, 18 May 2014 17:57:20 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: 0.0
X-Spam-Score-Int: 0
X-Spam-Bar: /
X-Spam-Report: (no report template found)
X-ACL-Warn: !authenticated  = *
X-SA-Exim-Connect-IP: 69.50.167.197
X-SA-Exim-Mail-From: ether@cpan.org
X-SA-Exim-Scanned: No (on www.lightspeed.ca); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249558>


scenario: 
- edit some tracked files; do not add them to the index
- "git config rebase.autostash true"
- "git rebase -i HEAD~3" (an autostash will be created)
- delete the entire buffer and save/exit the editor - this will abort the
  rebase

poof, the autostash is gone (it is not reapplied) -- it must be explicitly
applied again via the SHA that was printed earlier.


(please cc me; I am not subscribed to the list.)
