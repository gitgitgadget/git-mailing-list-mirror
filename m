From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 21:50:38 +0200
Message-ID: <20070719195038.GP3396@cip.informatik.uni-erlangen.de>
References: <20070719104351.GA17182@midwinter.com> <20070719110224.GA4293@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707191211010.14781@racer.site> <Pine.LNX.4.64.0707191235490.32611@reaper.quantumfyre.co.uk> <86ir8gbo0a.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0707191128040.27353@woody.linux-foundation.org> <dbfc82860707191151w3e9571fcu60d113cba6c2f6dd@mail.gmail.com> <alpine.LFD.0.999.0707191155100.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolai Weibull <now@bitwi.se>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBc1M-0006tG-94
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938227AbXGSTul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938218AbXGSTul
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:50:41 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:54174 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936218AbXGSTuk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 15:50:40 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 02B233F40E; Thu, 19 Jul 2007 21:50:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707191155100.27353@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53031>

Hello Linus,

I personally use screen a lot. I have a few screen sessions running:

	- a main screen carring 70 windows. Where I do my daily work and
	  read my mail on. I recompiled screen to support more than 40
	  winodws. This screen session runs on a well connected machine.
	  And consumes 175M resistent memory and 450M virtual memory.
	  That's mainly because I have 5000 lines of scrollback buffer
	  in each window and I had to recompile screen with all it's
	  buffers 2x to fight a symtom that it always crashed for me
	  when I resized it to fullscreen on a monitor with resolution
	  of 1600x1200. Yes I did fight symptoms some times even if I
	  don't like it. But had you ever a look at the screen source
	  code. It does make you puke.

	- a local screen. If I do something on a local machine I don't
	  open a single terminal I open a screen session with 5 windows.
	  Even if I only need a single shell.  The local screen only
	  stays open as long as I am logged in. I switch machines often.
	  I have a workstation at home, one at university, a laptop and
	  one at work.

	- a console screen (I do a lot of system administration) so the
	  serial consoles of the main servers at university are
	  connected to a screen session. Often are up to 5 people are
	  connected to that session. When you have to do some sort of
	  maintance work we often do a telephone conference while
	  everyone sees what is going on.

	- a so called development screen. As you can imagine having 70
	  windows open you do a lot of context switches and as you
	  stated before "do one thing and do it well" does not work that
	  way when there is you mailreader in the way on window 6, so
	  when I do something I have to focus on I use the development
	  screen. For short projects I use the development screen.

	- one screen for work related stuff.

> I actually like screen as a way to keep connections around. But the
> whole multiplexing is wrong, wrong, wrong. It violates the "do one
> thing, and do it well" thing. It makes screen do two things, and do
> them really badly as a result.

so true, as I stated above. When I notice that I go sideways I use one
screen per topic.

> And the "window manager" part is kind of a funny hack, but let's face
> it, you can do better by using separate windows.

Why I started to use screen is because I often switch workstations. And
I want to be able to go on where I left of. So I have the same
environment on every machine I have access to and synchronize this
environment. I use fvwm as window manager and have something configured
I call SmartStart. This is a fvwm function which focus an application if
it is already running and start it if it is not running.

	Ctrl Shift s => Main Screen
	Ctrl Shift l => Local Screen
	Ctrl Shift o => Opera
	...
	(thinkpad) [~] grep SmartStart .fvwm2rc | wc -l
	32


> And the multiplexor could have been done (and historically _has_ been
> done) better, by not limiting it to terminal sessions.

I actually have a macro for university that allows me to start X
application out of my screen session but most of the time I use local X
applications or use ssh forwarding if I have to get it from a remote
machine.

> But the *combination* of all three is just evil and stupid. And the
> choice of ctrl-A as the default command sequence (can you even
> override it? Don't know, don't care) is just insanity.

yes you can, but you get used to it.

>    networking, and you'd generally use ssh tunnelling for it and 
>    ssh-agent. But screen was never very good at it.

My main screen is running in its own ssh-agent session. So does my work
screen. My local has automatically the ssh-agent session from my
desktop session.

> IOW, I think screen sucks because it tries to do totally independent
> things, and then mixes them up in nasty ways, and for historical
> reasons uses a bad break character too.

Well, I have to aggreee with you. Sometimes I come back to a windows
where I stopped in the middle of doing something. And that is bad.
However screen makes me work faster and makes it possible to switch
locations often and pick up where you left of. It's biggest strength
it's it biggest weakness, too.

My screen configuration have dozens of people copied. I have this
fancy sticky status bar on the bottom.

http://wwwcip.informatik.uni-erlangen.de/~sithglan/shot.png

	Thomas
