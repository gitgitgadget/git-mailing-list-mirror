From: Jeff King <peff@peff.net>
Subject: Re: pretty placeholders for reflog entries
Date: Mon, 7 Nov 2011 16:13:25 -0500
Message-ID: <20111107211325.GB7380@sigill.intra.peff.net>
References: <CAMYxyaWPWVGUHz0qQOnARb9wexHCx73a04Bu_UhrJR=xrinX7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jack Nagel <jacknagel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:13:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWVa-0007gZ-3v
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab1KGVN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 16:13:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35927
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1KGVN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 16:13:27 -0500
Received: (qmail 30036 invoked by uid 107); 7 Nov 2011 21:13:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 16:13:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 16:13:25 -0500
Content-Disposition: inline
In-Reply-To: <CAMYxyaWPWVGUHz0qQOnARb9wexHCx73a04Bu_UhrJR=xrinX7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185026>

On Sun, Nov 06, 2011 at 11:49:48PM -0600, Jack Nagel wrote:

> I have the reflog enabled on a bare repo so that I can have a record of
> "who pushed what, when". I'd like to define a custom pretty format for
> use with "git log -g" for reading it, but unfortunately the placeholders
> for reflog information are somewhat limited. In particular, I'd like to
> be able to access the identity (i.e., name and email) and date from each
> reflog entry.
> 
> Is it possible to extract this information in current git? Perhaps I
> overlooked something.

Sorry, but there aren't convenient placeholders for that. There probably
should be.

As a workaround, you can get the reflog selector ("%gD"), and then
cross-reference it with the output of "git log -g". But obviously that's
inefficient and a giant pain. We really should have "%gn" and "%ge" for
the reflog name and email. And related date options, though annoyingly
"%gd" is already taken for the default format.

I doubt it would be a very big patch. Want to get your feet wet in git
development? :)

-Peff
