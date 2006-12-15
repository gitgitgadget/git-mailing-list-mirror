X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 23:07:03 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141343200.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 04:07:19 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34469>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv4Lr-0002lI-Ae for gcvg-git@gmane.org; Fri, 15 Dec
 2006 05:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932559AbWLOEHG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 23:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWLOEHG
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 23:07:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23537 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932648AbWLOEHF (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 23:07:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA00MLMRFR8UE0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 23:07:03 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > $ git commit
> > Revision XXXXXXXXXXXXXXXXXX successfully added.
> >
> > I'd actually argue that git-commit is a particular problem because it's too 
> > fast.  You quit editing your commit message and bang, you're back at the 
> > command line.  Then you run git-log to make sure it really was committed.
> 
> You keep repeating that you want to know the object name of the
> newly created commit.  I would very strongly agree with you that
> it would be a fatal UI bug of git-commit if that information
> were vital for the end user after making each commit.

I think this is not the point.

Of course the name of the newly created commit isn't _that_ important.

But so is the "Committing initial tree 5220388..." message.

And in the commit case, you are left with a blank screen and just a 
shell prompt after you quit the text editor for the log message, which 
is a bit worrisome.  My initial reflex is not to think "ah it just did 
what I asked it" but rather "hmmm has it just crashed on me?"

Having a single line of feedback when a commit has completed would not 
be overly verbose and remove that impression of committing into a 
void I'd think.

Note that, as I said in another thread, I'm really not advocating for 
git-add to do the same.  The git-add is a relatively simple and 
lightweight operation that has not the same impact as a commit has 
_conceptually_.  It doesn't clear the screen for one thing so just 
returning to the shell prompt (unless -v is used) is plenty sufficient.

I'm following up with a patch to implement what I think should be done.


