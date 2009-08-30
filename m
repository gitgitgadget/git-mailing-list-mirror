From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add date formatting and parsing functions relative
 to a given time
Date: Sun, 30 Aug 2009 06:08:26 -0400
Message-ID: <20090830100826.GA31543@coredump.intra.peff.net>
References: <20090828191521.GA12292@coredump.intra.peff.net>
 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
 <20090828193302.GB9233@blimp.localdomain>
 <20090828205232.GD9233@blimp.localdomain>
 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
 <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
 <20090830091346.GA14928@blimp.localdomain>
 <20090830091557.GA28531@coredump.intra.peff.net>
 <20090830093642.GA30922@coredump.intra.peff.net>
 <81b0412b0908300256l13d308d9oc30172a20a9f6108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 12:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhhLh-0006PI-Mh
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 12:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZH3KI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 06:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZH3KI3
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 06:08:29 -0400
Received: from peff.net ([208.65.91.99]:59767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbZH3KI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 06:08:28 -0400
Received: (qmail 16859 invoked by uid 107); 30 Aug 2009 10:08:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 06:08:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 06:08:26 -0400
Content-Disposition: inline
In-Reply-To: <81b0412b0908300256l13d308d9oc30172a20a9f6108@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127407>

On Sun, Aug 30, 2009 at 11:56:37AM +0200, Alex Riesen wrote:

> > +check_show 5 '5 seconds ago'
> > +check_show 300 '5 minutes ago'
> > +check_show 18000 '5 hours ago'
> > +check_show 432000 '5 days ago'
> > +check_show 1728000 '3 weeks ago'
> > +check_show 13000000 '5 months ago'
> > +check_show 37500000 '1 year, 2 months ago'
> > +check_show 55188000 '1 year, 9 months ago'
> > +check_show 630000000 '20 years ago'
> 
> check_show 630000000 '20.years.ago'?
> (Arbitrary, non-whitespace delimiters, which was an
> advertised feature, to make shell's life easier)

This part is about checking what show_date produces (the first number is
an offset from now in seconds, and the second is what we expect), so it
always has spaces.

See the check_approxidate section further down for an example of parsing
what you are talking about.

-Peff
