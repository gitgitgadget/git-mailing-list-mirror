From: Jeff King <peff@peff.net>
Subject: Re: [RFC] remarks about custom diff driver
Date: Mon, 27 Aug 2007 06:45:29 -0400
Message-ID: <20070827104529.GA25685@coredump.intra.peff.net>
References: <vpq8x7x5knh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 27 12:46:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPc6a-00025Y-6X
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbXH0Kpc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbXH0Kpc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:45:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2135 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbXH0Kpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:45:31 -0400
Received: (qmail 30628 invoked by uid 111); 27 Aug 2007 10:45:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 27 Aug 2007 06:45:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2007 06:45:29 -0400
Content-Disposition: inline
In-Reply-To: <vpq8x7x5knh.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56809>

On Mon, Aug 27, 2007 at 12:36:34PM +0200, Matthieu Moy wrote:

> Indeed, what I would have needed is a custum text converter. In my
> case, I would have said something like
> 
> [...]
>
> Any opinion? Do you think that's overkill? Anyone else have a
> particuliar experience with custom diff engine?

Interestingly enough, I tried using a custom diff for the first time
earlier today and came to the exact same conclusion (I was diff'ing
photos that were tagged with exif keywords). I suspect a large number of
diff engines will simply want to convert content into a canonical text
format.

I wonder if you could simply use a "diff-filter" attribute that would
clean and smudge in the same way as "filter", except it would only do so
when creating or applying diffs. In most cases, you wouldn't have a
"clean" component (since the conversion to text is lossy).

-Peff
