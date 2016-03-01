From: Jeff King <peff@peff.net>
Subject: Re: git config --get-urlmatch does not set exit code 1 when no match
 is found
Date: Tue, 1 Mar 2016 10:03:21 -0500
Message-ID: <20160301150321.GM12887@sigill.intra.peff.net>
References: <CAMDzUtzNKAYSKYkt3WagkUrA2mKaoDu1rT6Nhf89pXSMg0wZwA@mail.gmail.com>
 <20160229115355.GA31273@sigill.intra.peff.net>
 <CAMDzUtwJVyaQbjgdQLi17_4ejGofpRFBDxXxjseaVcHLXCAwRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 16:03:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aalpj-0003dt-LN
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 16:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbcCAPD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 10:03:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:52488 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753859AbcCAPDY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 10:03:24 -0500
Received: (qmail 28862 invoked by uid 102); 1 Mar 2016 15:03:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 10:03:24 -0500
Received: (qmail 8490 invoked by uid 107); 1 Mar 2016 15:03:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 10:03:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 10:03:21 -0500
Content-Disposition: inline
In-Reply-To: <CAMDzUtwJVyaQbjgdQLi17_4ejGofpRFBDxXxjseaVcHLXCAwRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288031>

On Mon, Feb 29, 2016 at 06:38:28PM +0530, Guilherme wrote:

> @Peff Thank you for the heads up.
> 
> I'm trying to find out if there are any credential helpers configured
> in the system that will be running tests. On the dedicated test
> machines that is not a problem but the developer machines are.

Do you need to do it in an automated way, or just once?

If manual is OK, I suspect running:

  GIT_TRACE=1 git credential </dev/null

will give you a list of what gets run. That's awfully hacky, though.
Probably a "git credential list" command would be useful. Or just
adapting it to use the urlmatch stuff.

> Should I already post a pre-emptive email asking about the corner cases?
> 
> More importantly for me is if there is a case where get-url would not
> show a match where git clone would. If git clone skips a configuration
> that config url-match doesn't then it's not so bad.

Sorry, I don't recall the details. I feel like we discussed it a little
on the list, but I can't find it now. The closest I could find is:

  http://article.gmane.org/gmane.comp.version-control.git/267895

I think the main differences would be in ordering, not in what is
selected.

-Peff
