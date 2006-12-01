X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 18:44:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301827540.3451@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
 <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301520370.3513@woody.osdl.org>
 <873b80tqvv.wl%cworth@cworth.org> <Pine.LNX.4.64.0611301618490.3513@woody.osdl.org>
 <871wnkh142.wl%cworth@cworth.org> <Pine.LNX.4.64.0611301720240.3513@woody.osdl.org>
 <87y7psfjvk.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 02:45:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87y7psfjvk.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32845>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpyPA-0004YL-Hz for gcvg-git@gmane.org; Fri, 01 Dec
 2006 03:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758129AbWLACpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 21:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758141AbWLACpZ
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 21:45:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:8928 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758129AbWLACpY (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 21:45:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB12igjQ028796
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 18:44:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB12ifRY029733; Thu, 30 Nov
 2006 18:44:41 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Carl Worth wrote:
> 
> What I'm trying to say is that the _defaults_ are not well geared
> toward helping new users do what they want to with git.

I really think we're better off just telling people how things work (with 
practical examples, and _not_ by trying to explain things at too high a 
conceptual level).

I don't think people generally are all that stupid, and I think it's 
actually counter-productive to try to basically lie about how things work. 
It will just make it harder for people later.

> One thing you never really answered was my conversation with a new
> user that left the user with the impression of "git is bizarre". How
> can I fix that conversation?

I really _think_ that a lot of that is in the documentation being overly 
technically oriented and talking often about the technical side of how 
things work in the index, rather than the purely user side of what that 
_results_ in.

I really believe that people can understand the concept of "git add" 
squirrelling away the whole state of the file at add-time, and suddenly 
it's not all that complicated. Also, it's not even something that people 
really need to worry about, and I think we should make that more clear.

In other words, the documentation could _literally_ give the example of

	git add file.c
	.. change file.c ..
	git commit
	git diff file.c

and talk about this issue up-front, but then just say outright to people 
that "if you don't want to know about these details, you can always just 
use 'git commit -a', and you'll never really even notice".

There really isn't all that much to "hide". I think we've sometimes done a 
horrible job on _presentation_, but I also think that it's better to give 
examples of thigns like this, and then tell people not to worry, because 
they'll never need to care unless they actually start doing something 
fancy.

So all your examples of "badness" aren't really all that bad. Newbies 
should be told:

 - use "git commit -a" normally (with pointers on fancier usage)

 - and yes, we obviously should change the message to say "git commit -a"
   instead of "git update-index"

 - do NOT use the "-m" flag, and look at what git tells you in the
   commit message!

   This is actually important, because even for non-newbie users, the git 
   commit message for a conflicting  merge contains useful information, 
   and people should read it. It lists the conflicting filenames for a 
   reason, namely so that you can talk about what the conflicts in 
   question _were_.

[ Btw, I can't stress that last point enough. Using the "-m" flag should 
  really really REALLY be discouraged. It is almost always a horrible 
  mistake, not just because it means that you miss what git will tell you 
  about which files are getting checked in, but because it invariably 
  leads to bad single-line commit messages.

  In my personal opinion, the "-m" flag is really only good for scripts 
  and sending example git sequences to each other, ie it's there for 
  automated "do this" kind of scripting, and using it for real work should 
  be a castration offence, so that you don't perpetuate your genes.

  (I've seen _way_ too many projects where there's a lot of "update 
  version" one-liner commit messages. Damn, I can understand that in CVS, 
  where the logs are useless _anyway_, but in git it shouldn't be 
  allowed!). ]

Ok, with that rant out of the way, my _point_ is that we're actually much 
better off educating users about _why_ git is different, than trying to 
lie to them and say "it's just like CVS by default, but when you're a real 
man, we'll show you how you can rock your world".

