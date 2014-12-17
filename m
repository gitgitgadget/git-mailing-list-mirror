From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] remote: add --fetch and --both options to set-url
Date: Wed, 17 Dec 2014 09:28:00 -0500
Message-ID: <20141217142800.GA20766@peff.net>
References: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
 <54915607.9020304@web.de>
 <5257945.aZPNBJ6Uhr@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Dec 17 15:28:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1FaB-0004hc-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 15:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaLQO2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 09:28:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:53773 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbaLQO2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 09:28:03 -0500
Received: (qmail 14019 invoked by uid 102); 17 Dec 2014 14:28:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Dec 2014 08:28:02 -0600
Received: (qmail 31105 invoked by uid 107); 17 Dec 2014 14:28:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Dec 2014 09:28:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2014 09:28:00 -0500
Content-Disposition: inline
In-Reply-To: <5257945.aZPNBJ6Uhr@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261485>

On Wed, Dec 17, 2014 at 03:20:58PM +0100, Peter Wu wrote:

> > There are 2 warning  "dangling else", line 1570 and 1578
> > I think we should use:
> > 
> > 			for (i = 0; i < remote->pushurl_nr; i++) {
> > 				if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
> > 					matches++;
> > 				else
> > 					negative_matches++;
> > 			}
> > 
> 
> Good catch, strange enough I did not get any warnings from my compiler
> or Clang's static analyzer. I have submitted a new patch which treats
> the accumulated comments.

Yeah, gcc does not seem to care, but compiling with clang (3.5.0 here)
does notice it.

C's parser matches what your indentation indicates, so it is just a
style fixup, not a bug (but one I agree is worth addressing).

-Peff
