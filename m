X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 18:08:55 +0100
Message-ID: <457061A7.2000102@b-i-t.de>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se> <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se> <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 17:09:40 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32947>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqBst-0008Na-SU for gcvg-git@gmane.org; Fri, 01 Dec
 2006 18:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936531AbWLARJH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 12:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936533AbWLARJG
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 12:09:06 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:35519 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S936531AbWLARJF
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 12:09:05 -0500
Received: (qmail 507 invoked by uid 1011); 1 Dec 2006 17:09:04 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.223627 secs); 01 Dec 2006 17:09:04 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 1 Dec 2006 17:09:03
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id 5E8ED23347; Fri,  1 Dec 2006 18:08:58
 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
...
 > Think of it this way: one common use for submodules is really to just
 > (occasionally) track somebody elses code. The submodule should be a
 > totally pristine copy from somebody else (ie it might be the "intel 
driver
 > for X.org" submodule, maintained within intel), and the supermodule just
 > refers to it indirectly (ie the supermodule might be the "Fedora Core X
 > group" which contains all the different drivers from different people).

Could you please be a little bit more specific about how you would store 
the "pristine copy". There seems to be some agreement to store the 
commit id of the submodule instead of a plain tree id in the 
supermodules tree object, and that all objects that are reachable from 
this commit are made part of the supermodule repository (either fetched 
or via alternates). Do you agree?

...
 > A supermodule can never "contain changes" to a submodule. A supermodule
 > would always just point to the submodule, and not have any changes
 > what-so-ever of its own. The submodule is self-sufficient, and always
 > contains all its _own_ changes.

That is one of the points Martin Waitz and I are discussing.

If I understand you correctly you cannot make any changes to the 
submodules code _in the supermodule's repository_, no bugfixes, no 
extensions, no adaptions, nothing. Do you mean that?

That would be a third alternative. In my opinion the usefulness of 
submodules would be unnecessarily restricted if it comes to the choice 
of either using the code from upstream as is or do not use submodules at 
all. What is the point of the restriction?

Regards

