From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v7 1/4] make poll available for other platforms lacking it
Date: Tue, 18 Sep 2012 09:02:24 +0200
Message-ID: <000301cd956b$8f29c110$ad7d4330$@schmitz-digital.de>
References: <004b01cd9519$ba991cd0$2fcb5670$@schmitz-digital.de> <7vmx0oqner.fsf@alter.siamese.dyndns.org> <000101cd9566$df8b8d00$9ea2a700$@schmitz-digital.de> <7vehlzq0r3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrpZ-0003Vj-I3
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 09:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046Ab2IRHCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 03:02:41 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:57061 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756609Ab2IRHCk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 03:02:40 -0400
Received: from DualCore (dsdf-4d0a151d.pool.mediaWays.net [77.10.21.29])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MJ0M1-1TBw164BnV-002jhi; Tue, 18 Sep 2012 09:02:39 +0200
In-Reply-To: <7vehlzq0r3.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQE7S4bKL3XYacfchY9p2RUlHA0wYQMPaYwWAtZhX5cCNduA5phzYpEA
Content-Language: de
X-Provags-ID: V02:K0:rDYI/Q+dPpbZKnn+ZtR3vXfnZWdojnHwGZQlt1xLW4B
 rsHFoOIj0E7ryy8hOHFo+SyrOYGnfKzVWjmgCNMfUzi0uYDgjS
 x5lVESxD6ESDwXFD2iF/p3oYPGxblnO41BEwYBS5QiNTqT16De
 IuS1dAzI3g0J47hUU6d/peK4SuxpwOyI2ywyzBNzpe55aKQ0YL
 xYOUMU6/95MELWccHFR/ZEiwZOAEpkXf+V9sU70jeu1XFHdQ8E
 yX58bJUjgB4faIfYh/SiuWgYxj/COsDy7vUFoBTHGLUMZKmiKd
 QGjaPxavl7DLykw1C97Vu3Sjh35UoC4dMy4OL0eqC+fcQhdClK
 wIb898xaCCIUZD7SLREKWKQH96sO5IcgB5z9w2y1WB55MzFprz
 p173JhXsEiW2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205803>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 18, 2012 8:55 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v7 1/4] make poll available for other platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> > @@ -1605,6 +1610,11 @@ ifdef NO_GETTEXT
> >> >  	BASIC_CFLAGS += -DNO_GETTEXT
> >> >  	USE_GETTEXT_SCHEME ?= fallthrough
> >> >  endif
> >> > +ifdef NO_POLL
> >> > +	NO_SYS_POLL_H = YesPlease
> >> > +	COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
> >> > +	COMPAT_OBJS += compat/poll/poll.o
> >> > +endif
> >>
> >> I think my guesses above are correct, so will queue with the trivial
> >> and obvious fixup.
> >
> > Well I was unde the impression that is <sys/poll.h> isn't
> > available, there might be a <poll.h> and it that isn't available
> > either we use compat/.../poll.[ch]. But rethinking your changed
> > does makes perfect sense.
> 
> Heh, my comment was not about names between NO_POLL_H vs NO_POLL.
> With the way you wrote the code, the symbols defined for Windows and
> MINGW must match what controls the hunk around ll.1610, so what
> makes perfect sense to you is indeed your code ;-)

Yeah, I do understand myself pretty good ;-)
Now I see my typo...
