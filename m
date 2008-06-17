From: Don Zickus <dzickus@redhat.com>
Subject: suggestions for generating diffs through the revision list
Date: Tue, 17 Jun 2008 17:41:42 -0400
Message-ID: <20080617214142.GM16941@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 23:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8iwr-0004pd-50
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbYFQVlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757530AbYFQVlp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:41:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757374AbYFQVlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 17:41:44 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5HLfhQX024111
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 17:41:43 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5HLfhju011034
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 17:41:43 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5HLfhos014267
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 17:41:43 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5HLfhTP005561
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 17:41:43 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5HLfgDt005560
	for git@vger.kernel.org; Tue, 17 Jun 2008 17:41:42 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85325>

I am try to walk the revision history for a given path and analyze the
diff (as compared to its parent).  What is the proper way of doing that?

I noticed a bunch of 'library' calls such as

init_revsion(&revs);
setup_revisions(argc, argv, &revs, "HEAD");
prepare_revision_walk(&revs, NULL);
commit = get_revision(&revs);

But what I can't find is the way to generate diffs.  I see lots and lots
of code to do it, but every builtin seems to do it differently.  Not
knowing the internals that well, I was hoping for some advice.

I stumbled upon calls like

run_diff_files
run_diff_index

but I haven't seen how to use them correctly.

Any help would be appreciated.  Thanks.

Cheers,
Don
