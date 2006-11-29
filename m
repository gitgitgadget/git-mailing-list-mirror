X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 12:45:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611291235590.3513@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
 <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
 <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 20:46:01 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456DD76C.4010902@gmx.net>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32666>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpWJI-0000qU-Gl for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967645AbWK2Uph (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967665AbWK2Uph
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:45:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:26534 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S967645AbWK2Upg (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:45:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kATKjJix026551
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 29
 Nov 2006 12:45:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kATKjI3D009832; Wed, 29 Nov
 2006 12:45:19 -0800
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org



On Wed, 29 Nov 2006, Marko Macek wrote:
> 
> Actually, people (at least me) dislike the index because in the most common
> operations (status, diff, commit), they have to know that the command doesn't
> actually display all their work but just the 'indexed' part of it. 

I don't see your point, really.

Nothing forces you to change the index. None of the normal operations do 
that, for example, and you really have to _explicitly_ ask git to update 
the index for you.

So you can really think of it as a better list of names than what CVS and 
others maintain for you. It's exactly the same as the CVS "Entries" file, 
except it's got capabilities that CVS will never have - tracking not just 
the filename, but the merge status, the permissions, and the actual 
contents of an entry.

And by default, and in the absense of any failed merges, you will _never_ 
see any of those extra capabilities.

> For people used to cvs, svn and other systems it would be nicer if diff -a
> and commit -a (and possibly other commands) were the default.

Why? I mean really.. Why do people mind the index? If you've not done 
anything to explicitly update it, and you just write "git commit", it will 
tell you exactly which files are dirty, which files are untracked, and 
then say "nothing to commit".

Maybe we shouldn't even say "use git-update-index to mark for commit", we 
should just say "use 'git commit -a' to mark for commit", but the point 
is, there really is no downside. So you forget to mention which files to 
commit, what's the downside really? It tells you what is up, and you can 
just mention the files explicitly, or use "-a" to say "ok, commit 
everything that is dirty", and it doesn't really get any simpler than 
that.

And the ADVANTAGES of the index are legion. You may not appreciate them 
initially, but the disadvantages people talk about really don't exist in 
real life, and once you actually start doing merges with conflicts, and 
fix things up one file at a time (and perhaps take a break and do 
something else before you come back to the rest of the conflicts), the 
index saves your sorry ass, and is a _huge_ advantage.

Similarly, it _allows_ you to do things that just a list of files never 
allows you to. You don't _have_ to use it to mark individual files as 
being ready to be committed, but you _can_. It's nothing that you need to 
know or worry about if you're not aware of the index, but it's a 
capability that is there for when you're willing to go there.

So there really isn't any true disadvantage. Most of the people who are 
afraid of the index have probably never actually used it, and have never 
even had a _reason_ to use it. They're nervous just because they know it 
exists, and don't know what it does.  But you can just ignore it.

So get over your fears, and just ignore it, and things will be fine.

		Linus

