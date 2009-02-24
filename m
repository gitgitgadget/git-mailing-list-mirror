From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
	commits older than a year
Date: Tue, 24 Feb 2009 02:07:22 -0500
Message-ID: <20090224070722.GA16566@coredump.intra.peff.net>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com> <20090222230620.GB19011@coredump.intra.peff.net> <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org> <20090223031631.GC22348@coredump.intra.peff.net> <7v8wnxun8e.fsf@gitster.siamese.dyndns.org> <20090224054216.GD4615@coredump.intra.peff.net> <7v63j0mib5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: eletuchy@gmail.com, git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrPR-0005HR-Lj
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbZBXHH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 02:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbZBXHH0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 02:07:26 -0500
Received: from peff.net ([208.65.91.99]:37777 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbZBXHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 02:07:25 -0500
Received: (qmail 11911 invoked by uid 107); 24 Feb 2009 07:07:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 02:07:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 02:07:22 -0500
Content-Disposition: inline
In-Reply-To: <7v63j0mib5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111229>

On Mon, Feb 23, 2009 at 10:59:26PM -0800, Junio C Hamano wrote:

> That was what I thought.  There may be some very convincing reasoning I am
> not seeing in the proposals to make it ultra-short like "Y yr M mo" or
> "Y.x years" (i.e. "we _have_ to keep it under N characters"threshold), but
> I doubt there is a particular place "Y years, M months" would make the
> output too long to be acceptable.

Yeah, anything like blame that deals with arbitrary date formats has to
know how to handle at least

  strlen("Sun Feb 22 15:08:25 2009 -0500") = 30

anyway.  Even the default blame format is:

  strlen("2009-02-24 02:03:25 -0500") = 25

So "Y years, M months ago" is at least that short for the next ten
thousand years. I can live with setting the cutoff to just "years"
somewhere lower than 10,000. :)

-Peff
