From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 19:39:59 -0400
Message-ID: <20140613233958.GD23078@sigill>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
 <20140613065942.GB7908@sigill.intra.peff.net>
 <20140613163644.GB85151@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Sat Jun 14 01:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wvb4s-0000O2-Ko
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 01:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbaFMXkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 19:40:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:43907 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753502AbaFMXkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 19:40:03 -0400
Received: (qmail 2076 invoked by uid 102); 13 Jun 2014 23:40:02 -0000
Received: from mobile-166-198-031-023.mycingular.net (HELO sigill.intra.peff.net) (166.198.31.23)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 18:40:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:39:59 -0400
Content-Disposition: inline
In-Reply-To: <20140613163644.GB85151@sirius.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251652>

On Fri, Jun 13, 2014 at 11:36:44AM -0500, Caleb Thompson wrote:

> > Or did you just mean that the new rule is "every test sets the editor as
> > they need", which means that we do not have to worry anymore about
> > polluting the environment for other tests?
> 
> That's exactly what I meant. We can stop relying on the global state *as
> it is initially set* and instead move the setup into the tests which
> rely on it.

Ah, OK, it was just me mis-reading, then.

The rewording you included below is clearer to me. Thanks.

> > [1] It might make sense for test_set_editor, when run from within a
> >     test, to behave more like test_config, and do:
> >
> >       test_when_finished '
> >         sane_unset FAKE_EDITOR &&
> >         sane_unset EDITOR
> >       '
> 
> It might, but it's a little out of scope in addition to your concern
> about other test scripts.

Yeah, I agree it does not need to block this series.

-Peff
