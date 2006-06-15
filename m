From: Yann Dirson <ydirson@altern.org>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 23:14:54 +0200
Message-ID: <20060615211454.GK7766@nowhere.earth>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth> <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 23:14:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqzAn-0002Qt-Q8
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 23:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031392AbWFOVOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031394AbWFOVOj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 17:14:39 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:7356 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1031392AbWFOVOi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 17:14:38 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8988E9AA2F;
	Thu, 15 Jun 2006 23:14:37 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FqzB1-0007vS-40; Thu, 15 Jun 2006 23:14:55 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21914>

On Thu, Jun 15, 2006 at 10:02:10AM -0700, Linus Torvalds wrote:
> Too many developers shrug off the "it's hard to use" argument. THEY think 
> it's fine. THEY think it's "lack of training". THEY think the tools are 
> fine, and the problem is the user.
> 
> THEY are wrong.
> 
> Almost every time when a user says "it's hard to use", the user is right. 
> Sometimes it's a lack of documentation, but quite often it's just that the 
> tool interfaces are bad.

In tha case of jam, the doc issue can certainly be raised, but the
most prominent problem is probably that everyone and their dog knows
make, and expects a replacement to work in a similar fashion.  The
current documentation and tutorial unfortunately does not show
precisely how people used to "make" can easily switch to jam.

For those not knowing about jam, I'd say the 1st thing to anchor in
one's mind is that jam gives complete (programmatic) control on the
dependency tree (eg. you just have to write once that the results of a
compilation have to be removed by "jam clean", and everytime you
declare a file to be built with your rule, you don't have to remember
to add it to the Clean rule - and more importantly, as soon as you
remove that declaration, you don't have to fear the Clean target to
remove it, in case it would be precious).


> Sometimes the problem space makes the interfaces fundamentally hard. But 
> sometimes the program itself just makes things ugly and hard, and autoconf 
> and automake definitely didn't make it easier for users - they were 
> designed for people who knew fifteen different versions of UNIX, and not 
> for sane people.
> 
> These days, there aren't fifteen different versions of UNIX. There's a 
> couple, and it's perfectly ok to actually say "fix your damn system and 
> just install GNU make". It's easier to install GNU make than it is to 
> install autoconf/automake.

Right, autoconf would be much more sane if it would not insist on
supporting vintage unices. OTOH, people having to work on these
systems (eg. for professional reason - not everyone has the luck to
work with modern systems all the time) are more than happy to be able
to build some recent tools to make there task easier.  Except when it
fails in that task (eg. a configure script for the bash package
failing to run on an years-old lynxos version because of a sh bug on
the OS), it still does a wonderful job in the end.

But I agree having to carry all this compat stuff, when one just wants
to benefit from higher-level features (like those mentionned by
Oliver), is annoying.  Maybe the support for legacy platforms could be
restricted in some way to the bare minimum.  Eg. using a "legacy"
backend where the cruft would go, and stubs for modern things, that
would generate a hopefully-more-portable-but-limited
./configure-simple script, and a "modern" backend generating a sane
full-fledged bash script.

But I'm going off-topic :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
