From: Jeff King <peff@peff.net>
Subject: Re: Possible bug: --ext-diff ignored with --cc in git log
Date: Fri, 11 Mar 2016 14:45:18 -0500
Message-ID: <20160311194518.GA1269@sigill.intra.peff.net>
References: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com>
 <xmqqlh5qc698.fsf@gitster.mtv.corp.google.com>
 <E1aeCRp-0005Jn-C1@smtp.tt-solutions.com>
 <xmqqziu4anb9.fsf@gitster.mtv.corp.google.com>
 <20160311185828.GA31750@sigill.intra.peff.net>
 <xmqqr3fgal3j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 20:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeT04-0001iP-4g
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 20:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbcCKTpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 14:45:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:58567 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932232AbcCKTpW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 14:45:22 -0500
Received: (qmail 13399 invoked by uid 102); 11 Mar 2016 19:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 14:45:21 -0500
Received: (qmail 6247 invoked by uid 107); 11 Mar 2016 19:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 14:45:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 14:45:18 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3fgal3j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288701>

On Fri, Mar 11, 2016 at 11:08:32AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> It happens that the above is fairly easily doable with today's Git
> >> without any modification.  Here is how.
> >> [...]
> >
> > I think an even easier way is:
> >
> >   git log --cc --raw
> >
> > I know that is somewhat beside the point you are making, which is how we
> > should handle "--cc" with ext-diff. But I would much rather have us
> > show nothing for that case, and let the user turn on "--raw", than to
> > invent a diff-looking format that does not actually represent the file
> > contents.
> 
> Sorry, but I am not sure where you are trying to go with this.
> 
> I understand that the original issue was that Vadim wants to
> suppress reams of differences for _some_ paths but still wants to
> benefit from the textual summarized diff for all the other paths.
> Giving "--raw" would be global, and would affect other paths, no?

Ah, sorry, I thought the problem was the opposite: that there was no
output for ext-diff paths, and we needed to add something back in. Doing
"--raw" is a much easier way than textconv of the "add back in" part,
but it does not suppress the ordinary combined diff.

-Peff
