From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push --signed: tighten what the receiving end can ask to
 sign
Date: Thu, 2 Apr 2015 18:16:03 -0400
Message-ID: <20150402221603.GA13077@peff.net>
References: <xmqqlhiagp2s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jann Horn <jann@thejh.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 00:16:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdnPM-0001wK-D5
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 00:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbbDBWQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 18:16:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:41635 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751659AbbDBWQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 18:16:07 -0400
Received: (qmail 29983 invoked by uid 102); 2 Apr 2015 22:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 17:16:06 -0500
Received: (qmail 16426 invoked by uid 107); 2 Apr 2015 22:16:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 18:16:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 18:16:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhiagp2s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266688>

On Thu, Apr 02, 2015 at 03:09:15PM -0700, Junio C Hamano wrote:

> +		if (isalnum(ch) ||
> +		    ch == '-' || ch == '.' ||
> +		    ch == '/' || ch == '+' ||
> +		    ch == '=' || ch == '_')
> +			continue;

I think this looks good. Earlier I suggested reducing the set of
allowable punctuation characters, but if we want to allow base64, that's
"+/=" right there. We use "-" ourselves, leaving only "." and "_" as
possible extras. But both of those are as useful as "-" for separators,
and are fairly innocuous, so I don't mind leaving them.

-Peff
