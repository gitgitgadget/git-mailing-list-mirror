X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <allen@ableton.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 19:58:43 +0100
Message-ID: <456C86E3.50902@ableton.com>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 18:59:48 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <ekhtnt$rkk$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32564>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp8AN-0006R4-LU for gcvg-git@gmane.org; Tue, 28 Nov
 2006 19:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936025AbWK1S6r (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 13:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936026AbWK1S6r
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 13:58:47 -0500
Received: from mail.ableton.net ([62.96.12.115]:7908 "EHLO mail.ableton.net")
 by vger.kernel.org with ESMTP id S936025AbWK1S6r (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 13:58:47 -0500
Received: from client0055.office.ableton.com ([10.1.15.66]) by
 mail.ableton.net with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.62)
 (envelope-from <allen@ableton.com>) id 1Gp8Ac-0005qj-5s; Tue, 28 Nov 2006
 19:59:06 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


> There are trouble with file-ids. Most common example is trouble with file
> which was created in two branches (two repositories) independently, then
> branches got merged. Most (all?) file-id based rename detection has trouble
> with repeated merging of those branches, even if there are no true
> conflicts.

Do you mean if the 2 files should be merged into 1 file? If they should 
be 2 files with different names there is no problem using file 
identifiers but if they should be merged into one file then I can see 
that this would cause problems. You would have to delete one of the 
files and copy its changes into the other which would create conflicts 
when that file is modified in the other branch. This is a problem if you 
*only* have file identifiers.

But if you tracked both file identifiers *and* content identifiers (as I 
was trying to say in my first post) this wouldn't be a problem would it? 
When content is changed you use the content identifiers but when files 
are changed by renaming or deleting you use file identifiers. To me at 
least it doesn't seem like it's a choice of one or the other or that one 
is stupid and the other isn't but that you need them both. bzr uses file 
ids and git uses content ids. It would be nice if there were an RCS 
that  used both - then you get the best of both worlds don't you?

So I don't think you want to use file identifiers to track changes to 
content (as bzr would do in this case) and you don't want to use content 
identifiers to track changes to files (as git does, to my understanding, 
when a file is renamed).

Nick
