From: linux@horizon.com
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: 21 Nov 2005 23:18:43 -0500
Message-ID: <20051122041843.9436.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0511211931350.13959@g5.osdl.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 05:19:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EePcG-0006xF-4g
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 05:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVKVESp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 23:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVKVESp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 23:18:45 -0500
Received: from science.horizon.com ([192.35.100.1]:19251 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932167AbVKVESo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 23:18:44 -0500
Received: (qmail 9437 invoked by uid 1000); 21 Nov 2005 23:18:43 -0500
To: linux@horizon.com, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0511211931350.13959@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12519>

> This is like Makefiles: if you have spaces in the wrong place, it may all 
> _look_ fine, but the Makefile just doesn't work. Really irritating.

Makefiles are more annoying because spaces instead of tabs can cause
them to work *differently*.  It's hard to write syntax that will
actually do that, but the parser ahs to go past the problem a bit to
really figure it out, so it can't print a nice error message.

With the strict prefix convention, the parser can produce excellent
error messages.

> And obviously using the file will show the problem (the parser will 
> complain with a nice line number and readable error, hopefully), but I 
> personally find that to just be too damn late. By then, you're already 
> irritated.
>
> So I like the notion of depending on indentation, but I just feel it falls 
> down in practice. 

So you're a crotchety old fart already, unable to learn new things?

It irritates you the first few times until you learn to do it right in 
first place, just like it irritates most beginning C programmers that the
compiler keeps complaining about missing semicolons.

Computers will be annoying about syntax until they learn to do what
I want them to do rather than what I tell them to do, at which point
they'll be smart enough to start being annoying by doing what they want
to to instead of what I want them to do.

> Of course, since I believe that tabs are always exactly 8 characters, I'd 
> also be perfectly happy to just declare that anybody who disagrees with me 
> is a moron and deserves to die (*).

I agree on the One True Tab Spacing, but I fear I heretically
disagree with you about the whole NO_IRQ thing, so I guess I'll just
have to take your advice and start stalking you with eugenic intent.

[Briefly: what hardware conventions are, and particularly how many
of those hardware devices exist in the world, is irrelevant.  We have
existence proofs of hardware that uses 0 for "no IRQ" and hardware that
accepts 0 as a valid IRQ.  dev->irq is a freaking *software convention*.
What matters is the development and maintenance burden of translating
that convention into all the different hardware out there.  And frankly
converting between "0 is valid" and "0 is invalid" affects a lot more
code paths than converting between "0 is invalid" and "-1 is invalid"
for a couple of specific hardware devices.  Particularly if you
want various kernel messages and /proc/interrupts to look right.

Hell, I could argue that having the most common hardware exercise the
longest code paths is a good thing, because that puts the code that
needs the most testing where it'll get it.]


Seriously, you could always have it print warning messages but try to
keep going by assuming 8 space tabs so that at least you can postpone
fixing the problem until your current train of thought has pulled into
the station.
