From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 01:23:11 -0500
Message-ID: <20160225062311.GA5541@sigill.intra.peff.net>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cROoc+Y-V_6hw6Hx4X9pFGmRjfhpzYGKhswwa=bA5b=+g@mail.gmail.com>
 <CA+P7+xpkbZyuQ7gpC+_KzJPfGo+xHpVFWEmr1oS7FD30jjJSOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 07:23:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYpKY-0002UF-G7
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 07:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbcBYGXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 01:23:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:48846 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753847AbcBYGXO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 01:23:14 -0500
Received: (qmail 16869 invoked by uid 102); 25 Feb 2016 06:23:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 01:23:13 -0500
Received: (qmail 16958 invoked by uid 107); 25 Feb 2016 06:23:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 01:23:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 01:23:11 -0500
Content-Disposition: inline
In-Reply-To: <CA+P7+xpkbZyuQ7gpC+_KzJPfGo+xHpVFWEmr1oS7FD30jjJSOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287333>

On Wed, Feb 24, 2016 at 10:19:05PM -0800, Jacob Keller wrote:

> >> +               /* combined all the values before we quote them */
> >
> > Comment repeats what the code already says, thus not terribly useful.
> >
> > Also: s/combined/combine/
> >
> I tend to make comments like this when I change the obvious way it was
> done, I commented this because I based it on a scratch patch from Jeff
> that didn't have them put together before quoting.

That's a good point. The _what_ is not interesting here, but the _why_
might be. Namely that we must quote the whole thing as a unit, or the
parser on the receiving end will not be able to read it.

I'd also be amenable to relaxing the parser (which is as strict as it is
only out of laziness, and the fact that it was reading the output only
of its nearby generator function). But I can understand if you don't
feel like digging into that.

-Peff
