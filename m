From: =?utf-8?q?Constantin_Wei=C3=9Fer?= <i7c@posteo.de>
Subject: Paths handled differently by diff and checkout
Date: Thu, 07 Apr 2016 22:55:16 +0200
Message-ID: <146006251650.27005.6715475336032533932@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 22:55:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGxa-0003fE-4l
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570AbcDGUzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:55:21 -0400
Received: from mout01.posteo.de ([185.67.36.65]:51370 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757219AbcDGUzV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2016 16:55:21 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 6242020B4B
	for <git@vger.kernel.org>; Thu,  7 Apr 2016 22:55:17 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3qgvxJ73pnz5vN2
	for <git@vger.kernel.org>; Thu,  7 Apr 2016 22:55:16 +0200 (CEST)
User-Agent: alot/0.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290987>

Hi,

say I got a file called "asdf" somewhere in a subdirectory. I can do:

git diff other_branch -- \*asdf

and it will show me the diff *only* of that file (which is the only one
that matches), so it works as expected. But if I do on the other hand:

git checkout other_branch -- \*asdf

I get: error: pathspec '*asdf' did not match any file(s) known to git.

which is not what I'm expecting. I figure this is due to the fact that
diff does not use parse_pathspec() but handles paths diffently (not
sure though)? I'd kind of find it useful to be able to 'git checkout
some_branch -- \*.txt' to get all differing text files from another
branch for example.

Cheers
Constantin
