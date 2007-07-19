From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 12:14:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191155100.27353@woody.linux-foundation.org>
References: <20070719104351.GA17182@midwinter.com> 
 <20070719110224.GA4293@piper.oerlikon.madduck.net> 
 <Pine.LNX.4.64.0707191211010.14781@racer.site> 
 <Pine.LNX.4.64.0707191235490.32611@reaper.quantumfyre.co.uk> 
 <86ir8gbo0a.fsf@lola.quinscape.zz>  <alpine.LFD.0.999.0707191128040.27353@woody.linux-foundation.org>
 <dbfc82860707191151w3e9571fcu60d113cba6c2f6dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Nikolai Weibull <now@bitwi.se>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbSz-0002t9-GN
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764561AbXGSTPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765193AbXGSTPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:15:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41496 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764561AbXGSTPH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 15:15:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JJEams010640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 12:14:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JJEUFh017525;
	Thu, 19 Jul 2007 12:14:31 -0700
In-Reply-To: <dbfc82860707191151w3e9571fcu60d113cba6c2f6dd@mail.gmail.com>
X-Spam-Status: No, hits=-4.68 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53020>



On Thu, 19 Jul 2007, Nikolai Weibull wrote:
> 
> I don't want to start a holy war here, but what's wrong with screen?

I actually like screen as a way to keep connections around. But the whole 
multiplexing is wrong, wrong, wrong. It violates the "do one thing, and do 
it well" thing. It makes screen do two things, and do them really badly as 
a result.

So the "session" part makes sense. It's a worthy reason to use screen.

And the "window manager" part is kind of a funny hack, but let's face it, 
you can do better by using separate windows.

And the multiplexor could have been done (and historically _has_ been 
done) better, by not limiting it to terminal sessions.

But the *combination* of all three is just evil and stupid. And the choice 
of ctrl-A as the default command sequence (can you even override it? Don't 
know, don't care) is just insanity.

It's somewhat sad that screen has made some better projects not as 
successful.

 - multiplexing. I used better programs back in the 90's to multiplex 
   arbitrary sessions over a single terminal pipe (not just terminal 
   windows). I forget the name, because these days, everybody has real 
   networking, and you'd generally use ssh tunnelling for it and 
   ssh-agent. But screen was never very good at it.

 - "window manager". Quite frankly, I've never needed it. I doubt many 
   people do. graphical environments and virtual terminals are better. And 
   if you really want a virtual terminal on a single terminal, thinking 
   that it should be mixed up with all the other things screen does is 
   just nasty.

 - for session management and moving things around: I think this is the 
   main reason people still use screen. It's a worthy use, but I think 
   it's sad how it's mixed up with the bad features of screen. There was a 
   "detach" program (or something similar) at some point that did just 
   that part of screen. But screen is just widely enough spread that 
   people are used to it, and I don't think it went anywhere.

IOW, I think screen sucks because it tries to do totally independent 
things, and then mixes them up in nasty ways, and for historical reasons 
uses a bad break character too.

Oh, well.

			Linus
