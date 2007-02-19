From: Bill Lear <rael@zopyra.com>
Subject: Where/how to create tracking branches?
Date: Mon, 19 Feb 2007 10:45:41 -0600
Message-ID: <17881.54325.475907.468492@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 17:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJBe9-0001sy-2m
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 17:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbXBSQpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 11:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbXBSQpq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 11:45:46 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60999 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932406AbXBSQpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 11:45:45 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1JGjiK22832;
	Mon, 19 Feb 2007 10:45:44 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40134>

What is the recommended way to create tracking branches in my private
repo if I first create the corresponding topic branch in my private
repo and want to publish it via a public repo?

Scenario:

[my private repo]
% git checkout -b topic
[work, work, work, commit]
% git push /public/repo/project topic:topic

[somebody else:]
% git clone /public/repo/project
% git checkout -b topic origin/topic
[work, work, work, commit]
% git push /public/repo/project topic:topic

[my private repo]
% git checkout topic
% git pull /public/repo/project topic
remote: Generating pack...
remote: Done counting 5 objects.
Result has 3 objects.
remote: Deltifying 3 objects.
remote: /3) done/3) done
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects
 100% (3/3) done
Updating 4751fcc..2d92737
Fast forward
 A |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
% git branch
  master
* topic
% git branch -r
  origin/HEAD
  origin/master

Now, I'm on my private repo, but I really want a tracking branch for
doing pulls from my public repo, or peers, for this topic branch.

Do I have to create the topic branch in my public repo first?  This
seems crazy, as our company repo is just another "global" public repo
and each developer would need to create branches there instead of on
their own machine.

I tried this:

% git pull /public/repo/project topic:origin/topic

But it created a topic branch named "origin/topic" instead of a tracking
branch.


Bill
