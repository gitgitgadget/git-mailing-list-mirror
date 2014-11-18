From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 13:49:24 -0500
Message-ID: <20141118184924.GB13479@peff.net>
References: <20141118172231.GA16387@peff.net>
 <20141118174309.GB31672@peff.net>
 <20141118183838.GD6527@google.com>
 <20141118184347.GE6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqnqE-0002ZC-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbaKRSt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:49:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:41850 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754994AbaKRSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:49:26 -0500
Received: (qmail 24603 invoked by uid 102); 18 Nov 2014 18:49:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 12:49:26 -0600
Received: (qmail 19276 invoked by uid 107); 18 Nov 2014 18:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 13:49:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 13:49:24 -0500
Content-Disposition: inline
In-Reply-To: <20141118184347.GE6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 10:43:47AM -0800, Jonathan Nieder wrote:

> ... and here's a patch on top to give git-p4 the same treatment.
> 
> -- >8 --
> Subject: Makefile: have python scripts depend on NO_PYTHON setting
> 
> Like the perl scripts, python scripts need a dependency to ensure they
> are rebuilt when switching between the "dummy" versions that run
> without Python and the real thing.

Thanks, I didn't think to look for similar cases. It seems python is the
only other thing that gets the "unimplemented" treatment. If you do:

  make
  make NO_TCLTK=Yes

I think you'll still end up with a crufty gitk build, but the fix there
is much more involved (it would have to create a "Sorry, gitk wasn't
built" script). I don't think it's worth the effort.

-Peff
