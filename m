From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stop putting argv[0] dirname at front of PATH
Date: Wed, 22 Apr 2015 16:00:19 -0400
Message-ID: <20150422200019.GE27656@peff.net>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
 <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
 <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
 <20150416061732.GA5612@peff.net>
 <xmqq1tjcf432.fsf@gitster.dls.corp.google.com>
 <20150422181402.GB3535@peff.net>
 <20150422192317.GI5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David =?utf-8?Q?Rodr=C3=ADguez?= <deivid.rodriguez@gmail.com>,
	Matthew Rothenberg <mroth@khanacademy.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0pH-0002eI-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323AbbDVUAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:00:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:48816 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751676AbbDVUAW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:00:22 -0400
Received: (qmail 13747 invoked by uid 102); 22 Apr 2015 20:00:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:00:21 -0500
Received: (qmail 13590 invoked by uid 107); 22 Apr 2015 20:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 16:00:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 16:00:19 -0400
Content-Disposition: inline
In-Reply-To: <20150422192317.GI5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267631>

On Wed, Apr 22, 2015 at 12:23:17PM -0700, Jonathan Nieder wrote:

> >                                                          And
> > not just for finding binaries; we want to find $(sharedir),
> > etc, the same way.  The RUNTIME_PREFIX build knob does this
> > the right way
> 
> Makes sense.  For the reason you say (templatedir, etc) I am surprised
> to hear that that was the motivation, but I can't find any other.

The Makefile was much less mature, then, so I wondered if maybe those
things came later (certainly the munging of $PATH that introduced the
problems came later, as at the time we had a special "we are exec-ing a
git command" custom version of execvp).

But no, the template directory did indeed exist then. I think it was
always a half-baked idea (and got much worse when we stopped putting
git-foo into $bindir).

The relevant thread (which I think I linked the other day) is:

  http://article.gmane.org/gmane.comp.version-control.git/16798

-Peff
