From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/4] ack recoding in commit log
Date: Mon, 19 May 2014 00:17:45 +0300
Message-ID: <1400447743-18513-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 23:19:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm8U1-00060j-4y
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 23:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbaERVSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 17:18:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62049 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbaERVSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 17:18:51 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4ILIpX6011785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:51 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s4ILInmD022800
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:50 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249512>

As a maintainer, I often get patches by mail, then
acked-by,reviewed-by etc responses are sent by separate
mail.

I like making acks commits,
this way they are easy to keep track of
as part of git history.


Since response mail happens to have appropriate
subject matching the patch, it's a natural fit to
then use git rebase mechanics if we want to smash
these acks into the original commit.

I have been using these patches without any problems
for a while now, and find the approach very convenient.

Included:
	rebase: new ack! action to handle ack commits
		this part seems ready for merge to me,
		please review and comment

	git-ack: new tool to record an ack
		this does not have proper documentation
		and tests yet, I definitely intend to
		do this but wanted to see whether people
		like the UI first.
		posting for early review and feedback


Note: yes, I think notes+git replace could be used for this too,
my workflow always includes a rebase with --autosquash
before publishing anyway, so dealing with ack as with any
other commit is nicer.


Michael S. Tsirkin (4):
  rebase -i: add ack action
  git-rebase: document ack
  rebase: test ack
  git-ack: record an ack

 Documentation/git-rebase.txt | 45 ++++++++++++++++++++++---
 contrib/git-ack              | 79 ++++++++++++++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh   | 34 +++++++++++++++----
 t/t3415-rebase-autosquash.sh | 15 +++++++++
 4 files changed, 161 insertions(+), 12 deletions(-)
 create mode 100755 contrib/git-ack

-- 
MST
