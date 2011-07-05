From: Alex Vandiver <alex@chmrr.net>
Subject: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Tue, 05 Jul 2011 12:49:24 -0400
Message-ID: <1309884564.18513.12.camel@umgah>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 19:11:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe99e-0006Co-TA
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 19:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab1GERLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 13:11:17 -0400
Received: from chmrr.net ([209.67.253.66]:46435 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771Ab1GERLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 13:11:16 -0400
X-Greylist: delayed 1302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jul 2011 13:11:16 EDT
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.64])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1Qe8oU-0006Ld-G1
	for git@vger.kernel.org; Tue, 05 Jul 2011 12:49:33 -0400
X-Mailer: Evolution 2.32.2 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2011-07-05 12:49:33
X-Connected-IP: 75.147.59.54:33197
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176618>

An external git-whatever command which fails to run gets reported as not
having been found, and suggests ... exactly what you just ran.  If you
miss the first line of the output, this can be extremely confusing --
and "is not a git command" is somewhat misleading:

        umgah ~ $ cat bin/git-bogus
        #!/usr/bin/env nonexistant
        echo "yay"
        
        umgah ~ $ git bogus
        /usr/bin/env: nonexistant: No such file or directory
        git: 'bogus' is not a git command. See 'git --help'.
        
        Did you mean this?
        	bogus

I've no patch right now, but I thought I'd report the frustration, in
case someone else wanted to get to it first.
 - Alex
