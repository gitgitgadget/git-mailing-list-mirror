X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:45:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 21:46:40 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87velgs9hx.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31507>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSaH-00085X-S0 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161750AbWKOVqO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161751AbWKOVqO
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:46:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29844 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1161750AbWKOVqO (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:46:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFLjxoZ000530
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 13:46:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFLjwgi031168; Wed, 15 Nov
 2006 13:45:58 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Carl Worth wrote:
> 
> Well, one of the problems is that with current git I can teach, (and I
> have), that there's a conceptual:
> 
> 	pull = fetch + merge
> 
> But then shortly after I have to teach an interface notion:
> 
> 	merge = pull .

This is why I would suggest teaching the _concept_ of the "merge", and not 
the actual command.

I don't think you should basically ever use the "git merge" command 
itself, not in teaching, and not in real life. So after talking about 
branches and having taught people to use "git fetch", the next stage is 
not so much to teach people to use "git merge", but to explain to them the 
_concept_ of merging. 

I really think that's a fairly quick thing, partly exactly _because_ you 
shouldn't at that point need to worry about syntax or details or anything 
like that at all. You just tell them that there's a notion of "merging" 
two branches by joining them together and havign the result have the 
changes from both branches. So it's a _conceptual_ issue, and that's why I 
said I think you should just totally gloss over the whole issue of "git 
merge" syntax.

Once you've explained the _concept_ of merging, you then introduce the 
command to actually _execute_ the merge: it's "git pull".

See? No circular thinking at all. One is a _concept_ ("join two branches 
together by including both in the result") and the other is a command 
("pull will fetch the remote data if any, and merge it into the current 
branch").

If you explain it that way, then _obviously_ if you don't need to fetch 
any remote data, doing "git pull . xyzzy" will merge the local branch 
"xyzzy" into the current branch.

