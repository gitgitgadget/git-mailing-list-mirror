From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 15:07:07 +0100
Message-ID: <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
	 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
	 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	 <43FDB8CC.5000503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 15:07:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCH7m-00041K-3V
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 15:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWBWOHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 09:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWBWOHM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 09:07:12 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:1745 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751211AbWBWOHL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 09:07:11 -0500
Received: by nproxy.gmail.com with SMTP id l24so37092nfc
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 06:07:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ghuLJuhtjuSndt2OMr1KGxQhlxEEE8RIwVxF6mqwD0Jbs5Hxfit5hFa7gSB6jzSOMoxGXvE/HjVFzPsn0286pdL6yv58kBh2SzrhxqQozVg3oW9U91GlKPt2AJWAJxJZ0wqs9ccFq2C4MnTSXog9joY6tUspawTX2fxmpgmTQiY=
Received: by 10.49.33.14 with SMTP id l14mr2357025nfj;
        Thu, 23 Feb 2006 06:07:07 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 06:07:07 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <43FDB8CC.5000503@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16647>

On 2/23/06, Andreas Ericsson <ae@op5.se> wrote:
> >
> >>Not to be unhelpful or anything, but activestate perl seems to be quite
> >>a lot of bother. Is it worth supporting it?
> >
> >
> > It's not activestate perl actually. It's only one platform it also
> > _has_ to support.
> > Is it worth supporting Windows?
>
> With or without cygwin? With cygwin, I'd say "yes, unless it makes
> things terribly difficult to maintain and so long as we don't take
> performance hits on unices". Without cygwin, I'd say "What? It runs on
> windows?".

There not much difference with or without cygwin. The penalties of
doing any kind of support for it will pile up (as they started to do
with pipes).
Someday we'll have to start dropping features on Windows or restrict them
beyond their usefullness. The fork emulation in cygwin isn't perfect,
signals do not work reliably (if at all), filesystem is slow and locked down,
and exec-attribute is NOT really useful even on NTFS (it is somehow related
to execute permission and open files. I still cannot figure out how exactly
are they related).

> If we claim to support windows but do a poor job of it, no-one else will
> start working on a windows-port. If we don't claim to support windows
> but say that "it's known to work with cygwin, although be aware of these
> performance penalties...", eventually someone will come along with their
> shiny Visual Express and hack up support for it, even if some tools will
> be missing and others unnecessarily complicated.

That seem to be the case, except for shiny.
(I really don't know what could possibly mean by that. It stinks, smears,
and sometimes bounces. Never saw it shining).
