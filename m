From: Joe Perches <joe@perches.com>
Subject: git and linux kernel source
Date: Thu, 09 Aug 2007 16:11:46 -0700
Message-ID: <1186701106.3073.71.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 01:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJHAX-0007Tb-La
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 01:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbXHIXLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 19:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbXHIXLt
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 19:11:49 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:3268 "EHLO Perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584AbXHIXLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 19:11:48 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by Perches.com (8.9.3/8.9.3) with ESMTP id QAA26570
	for <git@vger.kernel.org>; Thu, 9 Aug 2007 16:05:38 -0700
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55482>

A few linux kernel source and git questions:

What's the best procedure to handle a tree-wide source tranformation?
For instance:

  git branch foo2bar
  egrep -r -w --include=*.[ch] -l "foo" * | \
	xargs perl -pi -e 's/\bfoo\b/bar/msg'
  git commit -a -m "use bar not foo"

Is there a way to separate the resultant single patch into multiple
patches by subdirectory?  Perhaps some git-rev-parse option?

  git-format-patch -p --stat -o outputdir

Is there a way to automatically include the appropriate MAINTAINER and
mailing lists from the MAINTAINERS file for each subdirectory?

  git-send-mail --to $APPROPRIATE_MAINTAINER \
	-cc linux-kernel@vger.kernel.org

Any ideas or help?
