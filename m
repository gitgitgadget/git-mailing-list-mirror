From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/4] replace: use OPT_CMDMODE to handle modes
Date: Thu, 6 Mar 2014 13:48:01 -0500
Message-ID: <20140306184801.GA30890@sigill.intra.peff.net>
References: <20140306174803.GA30486@sigill.intra.peff.net>
 <20140306174921.GB30691@sigill.intra.peff.net>
 <CAP8UFD2c0UKT8Uyw4j9SzKGx2oLn=o7N-dtvQHPaaBtLT6ggcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 19:48:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdL1-0000Hz-Ne
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 19:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbaCFSsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 13:48:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:34230 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751837AbaCFSsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 13:48:04 -0500
Received: (qmail 23827 invoked by uid 102); 6 Mar 2014 18:48:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 12:48:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 13:48:01 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD2c0UKT8Uyw4j9SzKGx2oLn=o7N-dtvQHPaaBtLT6ggcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243531>

On Thu, Mar 06, 2014 at 07:35:19PM +0100, Christian Couder wrote:

> > +       if (!cmdmode)
> > +               cmdmode = argc ? MODE_REPLACE : MODE_DELETE;
> 
> Shouldn't it be MODE_LIST instead of MODE_DELETE?

Argh, yes, thank you for catching. My original iteration used chars like
'd' and 'l' (similar to other uses of OPT_CMDMODE). I switched it at the
last minute to an enum, and somehow thinko'd that completely (and
obviously did not run the tests again afterwards).

-Peff
