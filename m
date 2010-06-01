From: roylee17 <roylee17@gmail.com>
Subject: How to add daily tags for a central repo?
Date: Mon, 31 May 2010 22:21:51 -0700 (PDT)
Message-ID: <1275369711233-5124575.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 07:22:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJJvL-0007Yr-8v
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 07:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab0FAFVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 01:21:53 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56880 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab0FAFVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 01:21:52 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <roylee17@gmail.com>)
	id 1OJJvD-0004lQ-7s
	for git@vger.kernel.org; Mon, 31 May 2010 22:21:51 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148078>


Hi,

We currently host our projects on a central server.
For the daily build purpose, I currently using a script to do the following
steps:

  1. clone the project from the central server

  2. find the target commit for a specified date
      commit=`git log origin/master -n1 --format=%H --until="${timespec}
00:00:00"`

  3. tag the commit
      git tag -f daily/${timespec} ${commit}

  4. push the tag up to the central server

This usually works fine and allows us to tag earlier commit with past dates

However, it depends on the "COMMIT DATE", which is a local time to the
developer who
committed the changes.
And if some developer didn't have the time or date configured correctly on
his machine,
the changes committed by him may not be included in a tag, even it is pushed
to the 
on a date earlier than the target date to tag.

Alternatively, we can queue the job to do the following steps "on a target
date":

1. clone the project from the central server
2. tag the "latest commit"
3. push the tag to the server

But I'd like to know better ways to do the daily tag things?

Roy
-- 
View this message in context: http://git.661346.n2.nabble.com/How-to-add-daily-tags-for-a-central-repo-tp5124575p5124575.html
Sent from the git mailing list archive at Nabble.com.
