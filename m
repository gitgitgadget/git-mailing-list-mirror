From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Mon, 5 May 2008 13:14:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051312560.30431@racer>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com> <1209815828-6548-1-git-send-email-pkufranky@gmail.com> <1209815828-6548-2-git-send-email-pkufranky@gmail.com> <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com> <1209815828-6548-5-git-send-email-pkufranky@gmail.com> <7vy76rtfns.fsf@gitster.siamese.dyndns.org> <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com> <alpine.DEB.1.00.0805041040560.30431@racer>
 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com> <7v63ttq0y8.fsf@gitster.siamese.dyndns.org> <m3ve1t6bli.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, Ping Yin <pkufranky@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 14:15:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JszbV-0003uX-FW
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 14:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbYEEMOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 08:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYEEMOt
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 08:14:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:59731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751731AbYEEMOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 08:14:48 -0400
Received: (qmail invoked by alias); 05 May 2008 12:14:47 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp054) with SMTP; 05 May 2008 14:14:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GjX8vwnSGEf05hcNvuTciXjytfnrAJCQY9IeMES
	PnYT+CxNVt/08O
X-X-Sender: gene099@racer
In-Reply-To: <m3ve1t6bli.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81276>

Hi,

On Sun, 4 May 2008, Jakub Narebski wrote:

> Junio C Hamano <junio@pobox.com> writes:
> 
> > Let's step back a bit and try to clarify the problem with a bit of
> > illustration.
> > 
> > The motivation behind "word diff" is because line oriented diff is
> > sometimes unwieldy.
> > 
> >     -Hello world.
> >     +Hi, world.
> [...]
> > We instead can do this word by word (note that I am doing this as a
> > thought experiment, to illustrate what the problem is and what should
> > conceptually happen, not suggesting this particular implementation):
> > 
> >     preimage        postimage       word-diff
> >     48656c6c6f                      -48656c6c6f Hello
> >                     4869            +4869       Hi
> >                     2c              +2c         ,
> >     20              20               20         ' '
> >     776f726c64      776f726c64       776f726c64 world      
> >     2e              2e               2e         .
> >     0a              0a               0a         '\n'
> > 
> > Which would give you "/Hello/Hi,/ world.\n".
> 
> Would it be possible instead of in-line word diff, use word coloring
> to enhance traditional diff format?  Something like
> 
>      -/Hello/ world.
>      +/Hi,/ world.
> 
> (We could use bold, or reverse for marking changed fragment, or use
> color only for changed fragment).
> 
> IMHO current output is nice, unless you have long lines and not very
> wide screen...

-S ;-)

IIRC the code to display was not too complicated for the current mode, so 
it should be relatively simple for the mode you desire.

But first let's agree on the semantics of the "tokens", as Junio calls 
them, okay?

Ciao,
Dscho
