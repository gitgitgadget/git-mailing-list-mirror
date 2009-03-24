From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 04:42:36 -0400
Message-ID: <20090324084236.GC660@coredump.intra.peff.net>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com> <20090323064242.GB1119@coredump.intra.peff.net> <94a0d4530903231720r620e44fu90dd77a3231bd4d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2F7-0001GJ-Ko
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbZCXImr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZCXImr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:42:47 -0400
Received: from peff.net ([208.65.91.99]:52349 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbZCXImq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:42:46 -0400
Received: (qmail 28132 invoked by uid 107); 24 Mar 2009 08:42:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 04:42:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 04:42:36 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903231720r620e44fu90dd77a3231bd4d1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114427>

On Tue, Mar 24, 2009 at 02:20:13AM +0200, Felipe Contreras wrote:

> I've updated the CSS. Can you take a look again?
> 
> I changed the font-size to normal, except for the code chunks. Also, I

Well, it looks better to me, in that the body text isn't small and
scrunched. The code chunks are, of course, noticeably smaller. I really
don't see what you're trying to accomplish with that. Are you trying to
make it fit into browsers where we are somehow wrapping in the code
chunks?

> changed the font of the in-paragrah code tags to sans-serif, that's
> the most sane way I can think to fix the problem with different
> font-size configured for monospace font.

Hrm. I'm not sure that is particularly sane. You have the style for a
<tt> tag rendering as a sans-serif font. But the _definition_ of tt is
to render as a monospace font.

As it happens, there are no <tt> tags at all in the document, so that
change is irrelevant (and I wonder if we should ditch the tt.literal
specifier entirely). But I tend to think that <code> tags generally
follow the same principle. Looking over the document, I didn't find
anything that looked broken by it (at least in Firefox using my set of
fonts). But it just seems counterintuitive.

If you are unsatisfied with the size of the text in <code> blocks,
can't you set some variant of an em (e.g., 1.1em)?


Looking at all of these <code> examples did make me notice one thing:
there are some special characters used that are probably
counterintuitive. For instance, "--not" is rendered with a single long
dash instead of two short dashes. A code snippet has a right-arrow
character instead of "->". I assume this is asciidoc trying to be
clever, but I haven't looked into it.

-Peff
