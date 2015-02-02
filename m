From: Jeff King <peff@peff.net>
Subject: Re: RFD: should we do another 2.3-rc for t9001-noxmailer? I'd say not
Date: Mon, 2 Feb 2015 15:38:38 -0500
Message-ID: <20150202203838.GA30001@peff.net>
References: <xmqqr3u98d0f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:38:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINld-0007cE-OT
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933483AbbBBUim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:38:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:44244 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933243AbbBBUil (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:38:41 -0500
Received: (qmail 17990 invoked by uid 102); 2 Feb 2015 20:38:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 14:38:41 -0600
Received: (qmail 11748 invoked by uid 107); 2 Feb 2015 20:39:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 15:39:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 15:38:38 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3u98d0f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263287>

On Sun, Feb 01, 2015 at 02:48:00PM -0800, Junio C Hamano wrote:

> I was reviewing the recent bugs and fixes for the last time, and was
> wondering if we want to do 2.3-rc3 with build fix for those with
> ancient cURL (tc/curl-vernum-output-broken-in-7.11) and workaround
> for those with Perl with older Getopt::Long (tc/t9001-noxmailer).
> 
>  - The former is not a regression between 2.2 and 2.3 (i.e. 2.2
>    already had the same use of curl-config output).
> 
>  - The latter, strictly speaking, is a regression in that tests used
>    to pass but tests in 2.3 no longer pass for those with older
>    Getopt::Long.
> 
> But the latter is about a test script that lacks work-around, and
> more importantly, everybody has lived with unconditional X-mailer:
> output, and the minority with ancient Getopt::Long will survive
> without being to able to give the new --no-xmailer (or --noxmailer)
> option just fine.
> 
> So currently I am leaning to keep these two fixes where they are and
> tag 2.3 final without them in a few days.

Yeah, I think that is sensible, especially given that the ancient
--noxmailer platform reportedly cannot even fully build with v2.2.

I thought at first that we also had a regression in pruning with
alternates, but it looks like that bug actually went into v2.2.  I still
think we would want the fix fairly promptly, but it does not need to
happen before v2.3 is released.

-Peff
