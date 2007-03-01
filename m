From: Bill Lear <rael@zopyra.com>
Subject: Git checkout preserve timestamp?
Date: Thu, 1 Mar 2007 15:36:25 -0600
Message-ID: <17895.18265.710811.536526@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 22:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMsxg-0005DW-V4
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbXCAVga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbXCAVga
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:36:30 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60553 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030301AbXCAVga (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:36:30 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l21LaTU04075;
	Thu, 1 Mar 2007 15:36:29 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41128>

I often find myself in branch A, with everything checked in and
compiled, wanting to look at something on branch B.  I hop to branch
B, look, and come back to branch A.  Unfortunately, when I then do a
make, files that differed between A and B will be recompiled, as well as
any further dependencies.

I wonder if it would be possible or desirable to have a config flag
that told git to restore the timestamps across branch checkouts in
order to prevent this perturbation.

So, when git does a checkout of a branch, it would look to see which
files in the current branch are changed, tuck away the timestamps for
those, and switch to the new branch.  On return to the former, the
same would be done for the new branch, then after the changed files
were restored, the timestamps would be reset.

One thing this would enable is to be able to hold the compilation
products of multiple branches at the same time in the same working
tree, switch back and forth between branches, and only have to compile
code that you actually modify.  Currently, we store compilation
products in a directory that is composed of the architecture, compiler,
compiler options, and so forth, among which also could be the branch
name.

Anyway, just an idea I thought worth batting about.


Bill
