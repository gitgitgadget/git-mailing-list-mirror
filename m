From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 18:40:50 +0200
Message-ID: <200705281840.50814.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705281254.23297.johan@herland.net>
 <alpine.LFD.0.98.0705280924410.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 28 18:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsiHK-00004v-9M
	for gcvg-git@gmane.org; Mon, 28 May 2007 18:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXE1Qk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 12:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbXE1Qk7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 12:40:59 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52476 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbXE1Qk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 12:40:58 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIR00203FO4RD00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 18:40:52 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR00EMMFO3E420@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 18:40:51 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR00DZJFO3KB50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 18:40:51 +0200 (CEST)
In-reply-to: <alpine.LFD.0.98.0705280924410.26602@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48624>

On Monday 28 May 2007, Linus Torvalds wrote:
> > I can't see why the current implementation would scale any worse than an
> > equivalent number of (annotated/signed) tags. But then again, the tag
> > system might not have been designed with tens of thousands of tag objects
> > in mind. :)
> 
> Right. I was more thinking that this "notes" thing could potentially be a 
> very useful thing for some random workflow - using notes to indicate that 
> some commit has been vetted by somebody, for example (ie adding things 
> like "Acked-by:" after-the-fact, which happens for the kernel).
> 
> And once you start using notes for something like that, I think you're 
> going to end up with a set of notes that grows with history, and 
> potentially grows quite quickly.
> 
> So I can see people having thousands of tags, but usually you only tag 
> releases. In contrast, I can see notes being used not as a "per release" 
> thing, but closer to a "per commit" thing. And that kind of worries me, I 
> can see workflows where you end up having tons and tons of notes.
> 
> But hey, maybe I just worry unnecessarily.

I still don't see what makes note objects inherently more expensive than
commit objects. Except for the refs, of course, but we're getting rid
of those (at least replacing them with a more efficient reverse mapping).

And even if we _do_ end up with 10 notes per commit, we could always
design some kind of "supernote" that lets "git-gc" pack all the notes
related to a commit into _one_ object.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
