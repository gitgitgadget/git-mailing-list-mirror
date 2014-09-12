From: Roman Neuhauser <neuhauser@sigpipe.cz>
Subject: git-diff-tree --root
Date: Fri, 12 Sep 2014 15:06:07 +0200
Message-ID: <20140912130607.GX4075@isis.sigpipe.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 15:14:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSQgC-00064y-6F
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 15:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbaILNOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 09:14:20 -0400
Received: from fw.sigpipe.cz ([213.192.55.98]:10414 "EHLO isis.sigpipe.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661AbaILNOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 09:14:20 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 09:14:19 EDT
Received: by isis.sigpipe.cz (Postfix, from userid 1001)
	id 5E50B435A80; Fri, 12 Sep 2014 15:06:07 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256920>

hello,

git-diff-tree without --root is absolutely silent for the root commit,
and i see no bad effects of --root on non-root commits.  are there any
hidden gotchas?  IOW, why is the --root behavior not the default?

cram[1] testcase::

  $ git init -q scratch
  $ cd scratch
  $ echo '.*.sw?' > .gitignore
  $ git add .gitignore
  $ git commit -q -m init .gitignore

  $ git diff-tree HEAD

  $ git diff-tree --root HEAD
  [0-9a-z]{40} (re)
  :000000 100644 0000000000000000000000000000000000000000 [0-9a-z]{40} A\\t.* (re)

[1] https://pypi.python.org/pypi/cram

-- 
roman
