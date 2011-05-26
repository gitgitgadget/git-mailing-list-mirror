From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Whitespace and '&nbsp'
Date: Fri, 27 May 2011 00:21:07 +0200
Message-ID: <vpqpqn5m7cc.fsf@bauges.imag.fr>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
	<7vzkm9unu0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 00:21:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPivl-0004S3-Dy
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536Ab1EZWVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 18:21:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60621 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758426Ab1EZWVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:21:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p4QML5b2009615
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2011 00:21:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QPivT-0001xA-IO; Fri, 27 May 2011 00:21:07 +0200
In-Reply-To: <7vzkm9unu0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 26 May 2011 14:57:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 27 May 2011 00:21:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4QML5b2009615
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1307053267.59798@jtARIm4PXpRtd0QpdnXMuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174584>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think people deliberately put these things to their editor,

I never put them in C code, but I do often have some in text and LaTeX
files: the French typography rules uses more spaces than the english
ones, in places where one shouldn't break lines (before :, !, ? and
inside =AB=A0French quotes=A0=BB). Real typographers would distinguish =
short
non-breaking spaces and normal ones, but I usually don't ;-).

My editor shows them as a space underlined in slight color. One can
reproduce this in a terminal with things like

echo -e '\033[3;4m '           # no color

or

echo -e '\033[1;4m\033[1;31m ' # red underline space

That's lighter than full red background, hence acceptable as a warning
that people who purposely use &nbsp can ignore.

> But in the longer term, I think we should find what MUA causes this
> breakage and yell at them.

A common typo for French people is to type

foo |=A0bar
     ^
   &nbsp;

since the | needs Alt-gr on azerty keyboard, and Alt-gr + Space gives a
&nbsp;. Particularly painfull to diagnose since the shell answers e.g.

zsh: command not found: =A0bar

{ and } also requires Alt-gr, so I can imagine someone typing

if (foo)=A0{
        ^
      &nbsp;

by mistake.

> It might be some mail relays, but I am not sure where these come from=
=2E
> I often see alternating real whitespace and nbsp in "> " indented
> quotes.

I often see them too, I guess the mailer does this to prevent other
(broken) mailers from rewrapping, but I don't like it either.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
