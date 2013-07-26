From: Jeff King <peff@peff.net>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Fri, 26 Jul 2013 18:27:32 -0400
Message-ID: <20130726222732.GA3444@sigill.intra.peff.net>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
 <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79>
 <20130726043748.GA20286@sigill.intra.peff.net>
 <0A68F4A5-22B0-4629-8693-73258566E218@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 00:27:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2qU7-0003Iy-7t
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 00:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759775Ab3GZW1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 18:27:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:32973 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758055Ab3GZW1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 18:27:34 -0400
Received: (qmail 12194 invoked by uid 102); 26 Jul 2013 22:27:35 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 17:27:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 18:27:32 -0400
Content-Disposition: inline
In-Reply-To: <0A68F4A5-22B0-4629-8693-73258566E218@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231210>

On Thu, Jul 25, 2013 at 11:23:23PM -0700, Kyle J. McKay wrote:

> >IMHO, this would be more clear as a single item, like:
> >
> > . User name (e.g., `user` in `https://user@example.com/repo.git`). If
> >   the config key has a user name it must match the user name in the
> >   URL exactly. If the config key does not have a user name, that
> >   config key will match a URL with any user name (including none).
> 
> The only problem I have with a single item is what's the precedence?
> Does an exact user match have the same precedence as an any-user
> match?  That would seem to be implied by having them as the same item
> number.  Separating them would appear to make it clearer that an
> exact user match wins over an any user match, but if you have some
> alternate text as a suggestion for the single item that clears that
> up...  :)

Ah, I see your thinking now. You want to say "no username has less
precedence than some username, which has less precedence than a path",
so they are all elements of a single list.  My thinking was "username
has precedence less than path, and like a shorter path has less
precedence than a longer path, an empty username has less precedence
than a non-empty username".

I agree my suggested wording would need to mention that explicitly.
Like:

  . User name (e.g., `user` in `https://user@example.com/repo.git`). If
    the config key has a user name it must match the user name in the
    URL exactly. If the config key does not have a user name, that
    config key will match a URL with any user name (including none), but
    at lower precedence than a config key with a user name.

I can live with it either way, though. They are just two ways of
considering the same thing.

> I am considering this text to address that:
> 
> >All URLs are normalized (%-encodings are standardized, case-insensitive
> >parts are lowercased, `./` and `../` path components are resolved)
> >before
> >attempting any matching (the password part, if embedded in the URL,
> 
> but I'm not sure the extra verbiage makes it better.  I think it may
> just complicate the explanation unnecessarily?

Yeah, I think I agree. Let's leave it out.

-Peff
