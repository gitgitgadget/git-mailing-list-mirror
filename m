From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: getting a list of changes I commited
Date: Thu, 15 Sep 2005 12:21:00 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04662735@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:21:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzIJ-0002q8-Jm
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVIOTVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVIOTVM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:21:12 -0400
Received: from fmr14.intel.com ([192.55.52.68]:52117 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S965028AbVIOTVK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 15:21:10 -0400
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j8FJL3JB009146;
	Thu, 15 Sep 2005 19:21:03 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j8FJL2ft028240;
	Thu, 15 Sep 2005 19:21:03 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005091512210328732
 ; Thu, 15 Sep 2005 12:21:03 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 12:21:02 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 12:21:01 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: getting a list of changes I commited
Thread-Index: AcW6JK9UM9s6gCuNR7e+AR0myx/x1gAAkvNA
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 15 Sep 2005 19:21:01.0623 (UTC) FILETIME=[9BDC5C70:01C5BA2A]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8627>

>Why not just _also_ limit it by what is already merged in my tree?

I can add the "^linus", but I think that with my workflow it
will never make a difference.  Any commits that got into your
tree with a committer line by me will already be in my "oldhead"
(how else did you get them?).  So "^oldhead ^linus" should always
be identical to "^oldhead".

>This is what "--header" (and it's zero termination) is 
>designed for:

Great ... I suspected that everything I needed was already there
(after all, all GIT problems are solvable with the right arguments to
git-rev-list!)

>	git-rev-list --header --no-merges newhead ^oldhead |
>		grep -z "committer .*tony\.luck"
>
>and it will give a nice NUL-terminated output list of just 
>your commits. 
>No complex script necessary.

But "git-shortlog" doesn't like the output from this, so I need
a script (or another tip on arguments to git commands).

>Also, the "grep the committer" approach fundamentally doesn't
>work if you ever plan on having sub-lieutenants that work with you and
>that you use git to merge with.

Oh happy day when I have sub-lieutenants :-)

-Tony
