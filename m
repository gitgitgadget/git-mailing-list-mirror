From: Bill Lear <rael@zopyra.com>
Subject: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 11:58:27 -0600
Message-ID: <17892.28995.328911.23188@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 18:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM6ay-0006YN-Mk
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 18:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXB0R6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 12:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbXB0R6d
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 12:58:33 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60808 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbXB0R6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 12:58:32 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1RHwVo27555;
	Tue, 27 Feb 2007 11:58:31 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40766>

In my company we generate test data that we want coupled with test
code, and despite the size, we have historically kept our test data
with our code base.

This is becoming a problem.

95% of the size of our 500 meg "code" base is actually test data, and
the size of the test data is likely to increase, perhaps radically.
We are contemplating files on the order of 500 megabytes a piece.

Many of our developers have multiple copies of our code base checked
out, duplicating the test data, so we would like to come up with a
solution to this that minimizes the amount of data we have to check
out.

Personally, I dislike having separate test data and code repos.
Keeping the two synchronized seems like a real pain.  I like to be
able to do things like:

cd component_x
[muck muck muck on part "y"]
mkdir testsuite/component_x.part_y
cd testsuite/component_x.part_y
[muck muck muck]
git commit -a -m "Finished mucking with part y of component x"

Where the directory structure is, essentially:

      component_x/
          testsuite/component_x.part_y

If we separate out the test data, for the above I would have to do
two commits in two repos, switching directories, etc.  And then, there
is the issue of ensuring that checkouts of code also get the associated
data needed.  I can see this being a potential nightmare.

Have others on the list grappled with this and come up with good
solutions with git?

I know there was some talk of sub-modules, but not sure if that is
working or even a viable option here.


Bill
