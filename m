From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Mon, 15 Feb 2010 00:23:56 -0500
Message-ID: <20100215052356.GI3336@coredump.intra.peff.net>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
 <20100214064408.GB20630@coredump.intra.peff.net>
 <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
 <20100215011803.GA15966@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:24:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgtRI-0007mz-Hc
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab0BOFXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:23:53 -0500
Received: from peff.net ([208.65.91.99]:40067 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab0BOFXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:23:51 -0500
Received: (qmail 14648 invoked by uid 107); 15 Feb 2010 05:24:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 00:24:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 00:23:56 -0500
Content-Disposition: inline
In-Reply-To: <20100215011803.GA15966@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139979>

On Sun, Feb 14, 2010 at 07:18:04PM -0600, Jonathan Nieder wrote:

> > Perhaps I can throw the tests in Jonathan's "tests for automatic use
> > of pager", t7006-pager?  Or, create a new test that mimics his?
> 
> I would suggest copying whatever functions you need to a new
> lib-terminal.sh and sourcing that with . from a new test.  Then I
> could adapt t7006-pager to use your library and avoid duplication of
> code.

Yes, I think that is a reasonable way to go.

> I am also interested in feedback on the techniques used in that test.
> Should it just rely on redirects to /dev/tty instead, and work to
> avoid sending any actual output there?  Is there an easier way to
> detect use of color?

Keep in mind that you might not even have a terminal at all (e.g., tests
run from a cron job), so redirecting /dev/tty won't help there. It is
easy enough to fake, as I posted in the other thread, so I think that is
probably simplest (unless we go with the "it only works under
--verbose" scheme).

-Peff
