From: tony.luck@intel.com
Subject: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 16:14:01 -0700
Message-ID: <200504292314.j3TNE1P23342@unix-os.sc.intel.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:08:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DReau-0006aq-KR
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 01:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVD2XOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 19:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVD2XOF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 19:14:05 -0400
Received: from fmr21.intel.com ([143.183.121.13]:58312 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S263054AbVD2XOC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 19:14:02 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3TNE1DE028064
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 23:14:01 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3TN935F021481
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 23:09:03 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3TNE1P23342;
	Fri, 29 Apr 2005 16:14:01 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm using cogito-0.8 (036bb73c6dd1871101ca19557298684ab9832f81) and trying
to set AUTHOR_DATE based on the "Date:" from the patch e-mail.  But, it
appears that commit-tree is munging this based on my timezone.

Here's what I set in the environment before invoking cg-commit:

  AUTHOR_DATE="29 Apr 2005 02:02:00 -0700"

and here's what cg-log reports on the "author" line:

  Fri, 29 Apr 2005 10:02:00 -0700

My /etc/localtime is set for "US/Pacific" ... which is where the 8 hours
comes from (I think).  If I set "TZ=GMT0BST" as well in the environment of
cg-commit to override /etc/localtime, then the author time comes out ok,
but then the "committer" time gets messed up.

-Tony
