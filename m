From: Alex Vandiver <alex@chmrr.net>
Subject: Tags named '-'
Date: Mon, 09 May 2011 11:21:36 -0400
Message-ID: <1304954496.11377.11.camel@kohr-ah>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 17:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJSa7-0004LN-V5
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 17:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab1EIPlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 11:41:06 -0400
Received: from chmrr.net ([209.67.253.66]:51676 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab1EIPlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 11:41:05 -0400
X-Greylist: delayed 1160 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 May 2011 11:41:05 EDT
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.82])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <alex@chmrr.net>)
	id 1QJSHF-0007MJ-SZ
	for git@vger.kernel.org; Mon, 09 May 2011 11:21:45 -0400
X-Mailer: Evolution 2.30.3 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.72 (build at 10-Dec-2010 17:02:27)
X-Date: 2011-05-09 11:21:45
X-Connected-IP: 75.147.59.54:53319
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173239>

Heya,
  The functionality of `git checkout -` is very useful, and I am hopeful
that `git merge -` will eventually land, as it matches my workflow well
as well.  However, the porcelain is not entirely consistent about
forbidding '-' as a ref name:

        ~/tmp $ git init
        Initialized empty Git repository in /home/chmrr/tmp/.git/
        ~/tmp (master #) $ git commit --allow-empty -m 'First commit'
        [master (root-commit) b7402ef] First commit
        ~/tmp (master) $ git checkout -b other
        Switched to a new branch 'other'
        ~/tmp (other) $ git checkout -
        Switched to branch 'master'
        ~/tmp (master) $ git checkout -b -
        fatal: git checkout: we do not like '-' as a branch name.
        ~/tmp (master) $ git tag -
        ~/tmp (master) $ git tag -l
        -
        ~/tmp (master) $ git checkout -
        Switched to branch 'other'

The likely best fix is to disallow '-' as a tag name, as well, which
would be handy because the typo of leaving off the 'l' on '-l', for
example, which is not an uncommon mistake that I have seen.
 - Alex
