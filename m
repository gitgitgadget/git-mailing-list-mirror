From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 16:11:52 -0500
Message-ID: <20141223211152.GB13304@peff.net>
References: <20141223084536.GA25190@peff.net>
 <5499D10E.5050704@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 22:11:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3WkH-0006l8-SD
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 22:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbaLWVLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 16:11:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:56807 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751365AbaLWVLw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 16:11:52 -0500
Received: (qmail 20679 invoked by uid 102); 23 Dec 2014 21:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 15:11:52 -0600
Received: (qmail 24177 invoked by uid 107); 23 Dec 2014 21:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 16:12:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2014 16:11:52 -0500
Content-Disposition: inline
In-Reply-To: <5499D10E.5050704@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261775>

On Tue, Dec 23, 2014 at 09:31:10PM +0100, Johannes Sixt wrote:

> Am 23.12.2014 um 09:45 schrieb Jeff King:
> > @@ -606,7 +606,7 @@ static ucs_char_t next_hfs_char(const char **in)
> >  		 * but this is enough to catch anything that will convert
> >  		 * to ".git"
> >  		 */
> > -		return tolower(out);
> > +		return out;
> 
> Did you consider changing the comment that we see in the pre-context here?

I did consider it, but the comment that is there was actually written
for the _original_ version, before I added tolower in the first place
(it also applied equally to the tolower() version, so I left it).

So it was clear either way, at least in my brain. :)

Of course that does not say anything about people's brains who did not
write the patch.  The changes Junio suggested elsewhere in the thread do
make it more clear.

-Peff
