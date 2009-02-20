From: Jeff King <peff@peff.net>
Subject: Re: Recovering from missing objects?
Date: Fri, 20 Feb 2009 01:10:46 -0500
Message-ID: <20090220061046.GA28122@coredump.intra.peff.net>
References: <alpine.LRH.2.00.0902191447040.16988@vixen.sonytel.be> <7vvdr6j6hz.fsf@gitster.siamese.dyndns.org> <20090220025810.GB22419@coredump.intra.peff.net> <7vmychiqr3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 07:12:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaOcY-000569-6q
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 07:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZBTGKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 01:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbZBTGKu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 01:10:50 -0500
Received: from peff.net ([208.65.91.99]:56956 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbZBTGKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 01:10:48 -0500
Received: (qmail 32432 invoked by uid 107); 20 Feb 2009 06:11:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 01:11:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 01:10:46 -0500
Content-Disposition: inline
In-Reply-To: <7vmychiqr3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110800>

On Thu, Feb 19, 2009 at 10:09:20PM -0800, Junio C Hamano wrote:

> > Might it not be simpler to just copy or hardlink the pack from the new
> > clone into the old directory's .git/objects/pack? That will get more
> > than you need, but things should start working, at which point a "git
> > repack -a -d" will make it small again.
> >
> > Or am I misunderstanding something?
> 
> If you already have a good clone and a half-broken one locally, of course,
> what you said is the easiest.
> 
> I just assumed that Geert did not really want to copy the whole pack.
> Maybe he doesn't mind in this particular case, but the next breakage may
> involve gigapacks he'd rather not re-clone.

Ah, OK. I had the impression that he had already made a new valid clone
on the local box.

> I also assumed that anybody who is reading the message can easily guess
> that the copy I was demonstrating in the description could be done across
> machines, instead of via local /var/tmp/, and "In the new clone" steps
> could even be done in the original one.  Presenting the knowledge that
> way, the solution hopefully would be adjustable for more people who are
> reading this thread.

Makes sense. Thanks.

-Peff
