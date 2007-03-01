From: Bill Lear <rael@zopyra.com>
Subject: How to effectively undo a part of a commit
Date: Thu, 1 Mar 2007 10:33:12 -0600
Message-ID: <17895.72.525085.734138@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 17:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMoDY-0002Xw-6x
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 17:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbXCAQdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 11:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965341AbXCAQdQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 11:33:16 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60031 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965331AbXCAQdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 11:33:15 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l21GXEL08818;
	Thu, 1 Mar 2007 10:33:14 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41103>

A colleague made a change to a file and committed it.  Then, he
made another change to the file and somehow undid the previous work,
then he committed the file.  Now, he would like to get the first change
he made and reapply it.

So, the changes look like this:

F1 -> delta 1 -> F2
F2 -> delta 2 -> F3

So, starting with F, he applies delta 1 to get F2.
Then, he applies delta 2 to get F3.

He says that using cvs he would do something like this:

% cvs update -j F1 -j F2

To apply delta 1 to F3.

We tried using git to get the delta 1 as a patch --- that went fine.
Then we used git-apply to apply the patch, but it refused, and it was
obvious that the line numbers of the patch no longer corresponded to
the line numbers in the file in his working tree.

Is there a way in git to do this, or is this an inherently unworkable
problem, as for some reason, I suspect?


Bill
