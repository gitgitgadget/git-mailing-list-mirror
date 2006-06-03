From: Paul Mackerras <paulus@samba.org>
Subject: Gitk feature - show nearby tags
Date: Sat, 3 Jun 2006 19:38:27 +1000
Message-ID: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 03 11:38:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmSad-0005sn-EN
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 11:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWFCJie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 05:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWFCJie
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 05:38:34 -0400
Received: from ozlabs.org ([203.10.76.45]:10411 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932587AbWFCJie (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 05:38:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E395E67A6D; Sat,  3 Jun 2006 19:38:32 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21190>

I just pushed out an update to the "new" branch of the gitk.git
repository, which adds a feature that I have often wished for: it will
now show the nearest preceding and following tags when you select a
commit.  This is very useful if you need to identify which release was
the first to incorporate a particular patch, or if you need to know
which release a patch might have been based on.

(Specifically, it shows the tags for all tagged descendents that are
not descendents of another tagged descendent of the selected commit,
and the tags for all tagged ancestors that are not ancestors of
another tagged ancestor of the selected commit.)

Since there is a one-off computation that gitk does to work this out,
which takes an appreciable time (about 1.5 seconds on my G5 on the
kernel repository), I have made gitk do the computation in the
background, and update the diff/file display window when it's done.
There is also a checkbox in the preferences window where you can turn
it off if you don't want gitk to do this computation.

Comments/suggestions welcome.

Paul.
