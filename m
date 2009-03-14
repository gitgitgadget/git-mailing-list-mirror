From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-push.txt: describe how to default to pushing only
	current branch
Date: Sat, 14 Mar 2009 16:34:35 -0400
Message-ID: <20090314203434.GA15444@coredump.intra.peff.net>
References: <20090313164941.GA16504@sigill.intra.peff.net> <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com> <7vd4cjc3da.fsf@gitster.siamese.dyndns.org> <20090313164941.GA16504@sigill.intra.peff.net> <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiaaY-0004oK-2D
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbZCNUem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755448AbZCNUel
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:34:41 -0400
Received: from peff.net ([208.65.91.99]:60117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbZCNUek (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:34:40 -0400
Received: (qmail 14816 invoked by uid 107); 14 Mar 2009 20:34:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 14 Mar 2009 16:34:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Mar 2009 16:34:35 -0400
Content-Disposition: inline
In-Reply-To: <7vd4cjc3da.fsf@gitster.siamese.dyndns.org> <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113260>

On Fri, Mar 13, 2009 at 08:27:31PM -0500, Chris Johnsen wrote:

> In the resulting manpage the inline commands are not very
> obvious (the HTML looks OK though). There is some sort of
> formatting in there, but it does not seem to display any
> differently from the surrounding text when I use man to view it
> on my system.  Would it be better to do something like wrap
> double quotes around the inline commands to help readers viewing
> the manpage?

The problem is that they are supposed to set in a monospaced font, but
most terminals are already monospaced. This is actually a problem
throughout the documentation, although it is usually only for
single-word phrases (like `git-foo`), which don't look nearly as bad as
multi-word ones.

Actually, looking closer, the information seems to be lost entirely.
Asciidoc renders this to <literal> in the XML, but docbook seems to
throw it away when converting to a manpage. In theory it's possible to
apply our own xsl style to turn this into something else, and I think
that is a better solution than just trying to fix this one spot.

The question is how it _should_ be rendered. Monospace isn't really
useful for terminals. Maybe simply putting quotation marks around it
would cover all situations (I'm worried it will look funny for
single-word instances).


On Sat, Mar 14, 2009 at 12:26:41PM -0700, Junio C Hamano wrote:

> The new text looks reasonable.  Sign-off?
> 
> Any improvement suggestions from others?

It looks fine to me; my only concern is the typesetting, but I think
that should be fixed elsewhere, as outlined above.

-Peff
