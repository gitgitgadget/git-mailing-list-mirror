From: Jeff King <peff@peff.net>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 25 Feb 2015 09:31:16 -0500
Message-ID: <20150225143116.GA13567@peff.net>
References: <54EDBEC2.8090107@peralex.com>
 <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 15:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQczo-0002H0-U9
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 15:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbBYObT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 09:31:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:53179 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752401AbbBYObT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 09:31:19 -0500
Received: (qmail 26464 invoked by uid 102); 25 Feb 2015 14:31:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 08:31:18 -0600
Received: (qmail 15565 invoked by uid 107); 25 Feb 2015 14:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 09:31:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2015 09:31:16 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264395>

On Wed, Feb 25, 2015 at 08:46:37PM +0700, Duy Nguyen wrote:

> On Wed, Feb 25, 2015 at 7:23 PM, Noel Grandin <noel@peralex.com> wrote:
> > What would be nice is a per-user/repo config setting that excludes certain
> > files and paths from the 'git grep' search.
> >
> > Does this sound reasonable/acceptable?
> 
> There is no config setting to do that, but since v1.9.5 you can use
> ':!' or ':(exclude) to exclude paths, for example
> 
> git grep foo -- '*.c' ':!src/ ':!*foo*.c'
> 
> will exclude .c files in src directory or contains "foo". If you use
> some exclude patterns often, you can write a short script. Perhaps we
> could support pathspec macros (similar to git-attr macros), stored in
> config file. You still need to type, but it'll be a lot shorter.

If it's an attribute of the file, and not the request, maybe
gitattributes would be a better fit. You can already do this with:

  *.foo -diff

in your .gitattributes file, though that _also_ marks the files as "not
for diffing", which may not be desired. There's not a separate "grep"
attribute, but I do not think it would be unreasonable to add one.

-Peff
