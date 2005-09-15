From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: getting a list of changes I commited
Date: Thu, 15 Sep 2005 13:23:33 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04662802@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:24:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG0Gq-0004DW-OQ
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 22:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbVIOUXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 16:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbVIOUXq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 16:23:46 -0400
Received: from fmr14.intel.com ([192.55.52.68]:1216 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161009AbVIOUXp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 16:23:45 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j8FKNZJB015241;
	Thu, 15 Sep 2005 20:23:35 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j8FKNVEY015400;
	Thu, 15 Sep 2005 20:23:35 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005091513233426478
 ; Thu, 15 Sep 2005 13:23:34 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 13:23:34 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 13:23:34 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: getting a list of changes I commited
Thread-Index: AcW6L1++00FCbe9dSIuF/9jGeaauxAAAOMbg
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 15 Sep 2005 20:23:34.0165 (UTC) FILETIME=[588CD450:01C5BA33]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8639>

>No. "oldhead" has to be the point where you did the last email thing.
>
>So any time you merge from me, next time your email cron-job (or whatever)  
>hits, ^linus _will_ make a difference. Without it, you'd email out all the 
>stuff that came through my tree.

I'm planning on doing this as part of my "push" script.  So
the oldhead is what is already up on kernel.org (which is when
I will have done the previous e-mail).  My "newhead" will be
full of stuff I got from your tree ... but most of the things
I pull from you were commited by someone else, so the "grep -z"
will drop them on the floor.  So there are just a few that have
my commit line on them ... but these *must* have come from my tree
(unless someone else is putting my name on commits!). That leaves
me with just my new commits for the e-mail.

>	git-rev-list --header newhead ^oldhead |
>		grep -z "committer .*tony\.luck" |
>		tr '\0' '\n' |
>		git-shortlog

I figured out the "tr" part myself.  That's when I saw that git-shortlog
expected to find "^Author:" and was getting "^author".

-Tony
