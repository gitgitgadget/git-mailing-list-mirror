From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 0/2] Add support for sending additional HTTP headers
Date: Wed, 4 May 2016 13:20:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041316160.9313@virtualbox>
References: <cover.1461837783.git.johannes.schindelin@gmx.de> <cover.1462342213.git.johannes.schindelin@gmx.de> <20160504062618.GA9849@sigill.intra.peff.net> <xmqq7ffajmvz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:20:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axurK-0002AX-PC
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbcEDLUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:20:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:54179 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbcEDLUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:20:46 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lskr7-1bdG2v0vGb-012L6Z; Wed, 04 May 2016 13:20:36
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq7ffajmvz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:W64UKy3IFBrcV9zlTocucBBT0jBt+y54iqoOIj4krF5n7a6cumb
 nHeGXPybYxAqqJFH9Pw4K6Z2WEDYXiUujBNeXijAPtONBRWI3JqrHww7pfDvxthDHf12tIu
 FIdLTutC99cS4H/NZa5zYG+cugKR1bh7z0ev5ipXHlu0FFWBb5CuvztHhLtEwlX2r7LX93h
 CjjHcbJqcLK/fGXCDUnYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fotGmDYmWHQ=:kcwPRc2dqdIsx7vyxA9VVp
 zkWanhJC8gGPYLwRjBYM2hID+q006+N+vIfXxmOBgKW/mo/4uNssLA837nBIV50A5I/PxAlxZ
 U2rR9heFtKKHsVnuqA9a9Afmv5KwsjI6AbuseoHFLSwm24KnpgiXYewLY8HQfjGZJUtM42Sf0
 T+0hLQ+mXI1fsaLEUmV5olDPPnCSMeMv+N/ekO4VLiWJBlQWxmmmR5z1804RJAmdDBjJfK7AY
 M+bvG5PXDK0O2j08HRKoR7PuTWvKwMMn07S1dkygpBThlOF2iJ9rOYnDTrjo7nF5o8AYBoQWl
 2ukUpwU8iqgAfb3NdMUFN3p86P5cwUqBcUvQF82XDJqQMBQWs/k5w0684yTEkOAy73lJ2WaM/
 LMtI8LgtGeo8ufd7T0id0nGxQ8zv14K+AV4mq7uurnIIcj5GxfDinh69E+2KLUHftQR2Ws73q
 nA3U4Ry2MJbLjr64J87I2jx2VgtrA/QM7pecQW/fWoR3zbDAvIGckrybL1xXF4IJctAhBjfuk
 4BFS+V2wS1Yx5WPkkLEtFi0ZSrDDPyE0M+tYT825GO2YNpbp8Ha7aV1dD/dNeJv+uYqHJi30i
 lOKQzn2U65ZVzhVEluK4o1EwdvPRZiZ1QposkuwtVx2KFF0b1Ut4L8SfyXVUu2ZqFQLyj1DRw
 qdgSw7wxsWjLrlVSL4aUoITKy9bHgH30ZQXLxQf8WeyMnm9UVIkGygemJGVEZ1lckgp/oHcNH
 Mw0thMZ0TxRru2NJ2FQ6BsFMRMmumor6dKsYRnHywTtrTTMJg287pNEPrzf0HMGdFpMETg35 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293534>

Hi Junio,

On Wed, 4 May 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>   submodule: pass on http.extraheader config settings
> >
> > IMHO this should come on top of jk/submodule-config-sanitize-fix (I was
> > surprised at first that your test worked at all, but that is because it
> > is using "clone", which is the one code path that works).
> 
> Yes.

Okay.

> > But I think we are waiting on going one of two paths:
> >
> >   1. drop sanitizing entirely
> >
> >   2. fix sanitizing and add more variables to it
> >
> > If we go the route of (2), then we'd want my fix topic and this patch.
> > And if not, then we don't need any of it (just a patch dropping the
> > filtering, which AFAIK nobody has written yet).
> 
> Doubly yes.  That is why I didn't pick up 2/2 in the previous round
> and also jk/submodule-config-sanitize-fix is not in 'next' for the
> same reason.

Okay. It was not clear to me that the indentation was not the reason it
was ignored.

> I agree with you that we have not yet reached concensus on which one
> of the two we would want to take.  I was sort of surprised to see
> 2/2 sent again, after seeing that Dscho sounded strongly in favor of
> not filtering the passed configuration variables, which would make
> the patch unnecessary.

Hah, my opinion matters after all.

Yes, I am in favor of not filtering any config settings passed through the
command-line.

But traditionally, I did not always get what I strongly preferred, and in
this case it is really important to me that support for `git -c
http.extraheader=... submodule ...` be part of an official Git version
soon.

I just *really* would hate for, say, 2.9.0 to be released with `git -c
http.extraheader=Hello:\ Junio submodule update --init` not working as
intended.

Ciao,
Dscho
