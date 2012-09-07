From: Stephen Bash <bash@genarts.com>
Subject: Binary file-friendly merge -Xours or -Xtheirs?
Date: Fri, 7 Sep 2012 10:48:48 -0400 (EDT)
Message-ID: <1265473388.275309.1347029328407.JavaMail.root@genarts.com>
References: <1799969825.275125.1347028392272.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 16:49:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9zrl-0005Tj-CF
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 16:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367Ab2IGOs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 10:48:56 -0400
Received: from hq.genarts.com ([173.9.65.1]:7253 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932109Ab2IGOsz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 10:48:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 5F124BE12C8
	for <git@vger.kernel.org>; Fri,  7 Sep 2012 10:48:54 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tbiyaD6gFEOV for <git@vger.kernel.org>;
	Fri,  7 Sep 2012 10:48:48 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 71CC3BE10EA
	for <git@vger.kernel.org>; Fri,  7 Sep 2012 10:48:48 -0400 (EDT)
In-Reply-To: <1799969825.275125.1347028392272.JavaMail.root@genarts.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204971>

Hi all-

Helping a coworker resolve merge conflicts today I found I wanted a -Xtheirs that completely replaces conflicted binary files with the copy from the incoming branch.  In other words rather than doing

  $ git merge maint
  ... conflicts occur ...
  $ git checkout --theirs -- path/to/binary-file
  $ git add path/to/binary-file
  $ git commit

I'd like to do

  $ git merge -Xbinary_theirs maint
  ... binary conflicts are resolved automatically ...

>From reading the docs it's obvious the current -Xours and -Xtheirs expect to work on hunks, so I (mostly) understand the current behavior, but as a user it feels like "I'm telling you how to resolve conflicts, please do the same thing for binary files".

I am missing a solution that already exists?  Or is this perhaps an improvement that could be made?

Thanks,
Stephen
