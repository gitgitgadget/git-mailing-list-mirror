From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Fri, 3 Apr 2009 06:14:26 +0200
Message-ID: <200904030614.26310.chriscool@tuxfamily.org>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <7v8wmjk4p6.fsf@gitster.siamese.dyndns.org> <20090402112705.GD14599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 06:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpapz-00044k-NJ
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 06:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbZDCEPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2009 00:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbZDCEPc
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 00:15:32 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:38381 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbZDCEPc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2009 00:15:32 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 727AB4B004B;
	Fri,  3 Apr 2009 06:15:21 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 6F5E64B0069;
	Fri,  3 Apr 2009 06:15:19 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090402112705.GD14599@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115516>

Hi,

Le jeudi 2 avril 2009, Jeff King a =C3=A9crit :
> On Wed, Apr 01, 2009 at 10:25:09PM -0700, Junio C Hamano wrote:
> > > - a header file should be included in a C file only if it is need=
ed
> > > to compile the C file (it is not ok to include it only because it
> > > includes many other headers that are needed)
> >
> > If that is the rule, perhaps the problem lies not in a .c program t=
hat
> > includes such a .h header, but in the .h itself that includes many
> > other header files.
>
> If this were combined with splitting gigantic .h files (like cache.h)
> into smaller logical units, then we could in theory speed up
> recompilation times with make (we would also need to correctly track
> header dependencies, but gcc -M can do this fairly easily).
>
> But it does come at the price of actually having to consider which
> include files are necessary. I can't think of more than half a dozen
> times in the last year I have actually had to add a #include while
> working on a git .c file, mostly because everything and the kitchen s=
ink
> is included by cache.h.

Yeah, I think the best feature of the actual design is the simplicity, =
and=20
that's why we don't have to add new #include very often. So let's keep =
this=20
simplicity by having and applying rules to keep things simple for the=20
developer.

> So I don't know if it is worth it.

I am not sure what you are talking about here, but if you mean that you=
=20
don't think it's worth splitting gigantic .h files (like cache.h) into=20
smaller logical units, then I agree.

Best regards,
Christian.
