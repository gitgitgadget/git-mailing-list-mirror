From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 0/8] gitweb: Bulk load commit objects
Date: Sun, 24 Dec 2006 14:30:41 +0000
Message-ID: <20061224143041.GF11474@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 24 15:30:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUNG-0005NB-SX
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWLXOao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWLXOao
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:30:44 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32799 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbWLXOan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:30:43 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUMs-0002qs-0w
	for git@vger.kernel.org; Sun, 24 Dec 2006 14:30:26 +0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=1, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00, RCVD_IN_NJABL_DUL 3.00)
X-blacknight-igraine-MailScanner-SpamScore: s
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35359>

The following is a set of patchs which should improve the preformance of
gitweb by bulk loading commit objects.

Note's:
* With a slight change in command line options and the parsing logic it
  was possible to bulk load the history action aswell.

* Even without the rev-list --skip option there should be some
  improvement as it is possible to bulk load the first page of commit
  object.


[PATCH 1/8] gitweb: Add parse_commits, used to bulk load commit objects.
[PATCH 2/8] gitweb: We do longer need the --parents flag in rev-list.

Base support for bulk loading commit objects.

[PATCH 3/8] gitweb: Change summary, shortlog actions to use parse_commits.
[PATCH 4/8] gitweb: Change log action to use parse_commits.
[PATCH 5/8] gitweb: Change header search action to use parse_commits.
[PATCH 6/8] gitweb: Change atom, rss actions to use parse_commits.
[PATCH 7/8] gitweb: Change history action to use parse_commits.

Convert all the commit listing actions (except pickaxe search) to use
parse_commits, also fixes up a few nav links.

[PATCH 8/8] gitweb: Use rev-list --skip option.

This change requires the rev-list --skip change from next to have
been merged.


Robert
