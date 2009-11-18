From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 09:23:21 -0500
Message-ID: <20091118142320.GA1220@coredump.intra.peff.net>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 15:23:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAlRR-00064c-GF
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 15:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117AbZKROXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 09:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757104AbZKROXR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 09:23:17 -0500
Received: from peff.net ([208.65.91.99]:35087 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083AbZKROXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 09:23:17 -0500
Received: (qmail 30245 invoked by uid 107); 18 Nov 2009 14:27:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Nov 2009 09:27:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2009 09:23:21 -0500
Content-Disposition: inline
In-Reply-To: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133177>

On Wed, Nov 18, 2009 at 12:30:36PM +0100, Bert Wesarg wrote:

> Insired by the coloring of quilt.
> 
> Introduce a separate color for the hunk comment part, i.e. the current
> function.  Whitespace between hunk header and hunk comment is now
> printed as plain.
> 
> The current default is magenta. But I'm not settled on this. My
> favorite would be bold yellow.

I don't see any reason not to add this, as it is simply introducing one
extra knob to tweak for people who care. However, after some
experimentation, I found that I don't personally really like it. I ended
up wanting it set to the same color as the hunk header.

I wonder how hard it would be to make it backwards-compatible; that is,
to inherit the color value of the hunk header (be it the original or one
set by the user) unless the func color is set by the user. But maybe
that is over-engineering. It is not like we are breaking scripts, and it
is not that hard for people to see the new behavior and then tweak their
config if they don't like it.

-Peff

PS I almost complained about your default of "magenta" as the same as
the meta color before I remembered that magenta meta is a personal
setting I use. Personally I find the bold meta color to be distractingly
ugly. Blaming it, the default seems to come from Linus, who even in his
commit message (50f575f) seems to indicate that it is somewhat arbitrary
(mostly just dropping the purple from the bold purple).

I'm not sure what is the best way to arrive at a default color for
something like this. Arguing about it really is almost the definition of
bikeshedding.  Maybe next year's git survey should contain a special
section on colors, and majority should rule.  :)
