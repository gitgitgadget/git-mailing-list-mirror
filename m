From: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
Subject: Ignoring whitespace for diff and rebase
Date: Fri, 15 Aug 2008 20:59:20 +0200
Message-ID: <20080815185920.GA3646@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 21:00:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU4XD-0006rQ-8k
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 21:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbYHOS7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 14:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757350AbYHOS7Y
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:59:24 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:59907 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317AbYHOS7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:59:23 -0400
Received: from [87.78.125.206] (helo=vertikal.home.noschinski.de)
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KU4W9-0003xh-JX
	for git@vger.kernel.org; Fri, 15 Aug 2008 20:59:21 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KU4W8-00019z-Lj
	for git@vger.kernel.org; Fri, 15 Aug 2008 20:59:20 +0200
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92509>

Hello!

Sometimes, I use

     git diff -b > ~/tmp/patch
     git reset --hard HEAD
     git apply ~/tmp/patch

to clean up all only-whitespace changes. But if there are files which
only differ on whitespace, git-diff produces an empty patch block
(what's the correct name for it?) like

     diff --git a/hello b/hello
     index f2aa86d..ce01362 100644

which git-apply refuses to apply. Is this behaviour of git-diff
intentional or should I try to cook up a patch?

Another combination which does not for for me is --interactive and
--whitespace for rebase:

     > git rebase -i --whitespace=strip HEAD^
     fatal: Needed a single revision
     Invalid base

Is this an implementation bug or lack of a note of incompatibility in
the docs?
