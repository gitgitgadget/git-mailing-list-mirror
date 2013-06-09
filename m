From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git.txt: document GIT_TRACE_PACKET
Date: Sun, 9 Jun 2013 01:36:21 -0400
Message-ID: <20130609053621.GA1854@sigill.intra.peff.net>
References: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
 <1370755369-30868-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 07:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlYIr-0007VU-0l
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 07:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab3FIFgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 01:36:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:60298 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3FIFgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 01:36:23 -0400
Received: (qmail 13785 invoked by uid 102); 9 Jun 2013 05:37:12 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 00:37:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 01:36:21 -0400
Content-Disposition: inline
In-Reply-To: <1370755369-30868-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226887>

On Sun, Jun 09, 2013 at 12:22:49PM +0700, Nguyen Thai Ngoc Duy wrote:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index c760918..72e9045 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -845,6 +845,11 @@ for further details.
>  	recorded. This may be helpful for troubleshooting some
>  	pack-related performance problems.
>  
> +'GIT_TRACE_PACKET'::
> +	If this variable is set, it shows a trace of all packets
> +	coming in or out of a given program. This can help with
> +	debugging object negotiation or other protocol issues.

This is not quite true. It stops showing packets after it sees a packet
starting with "PACK" (optionally with a sideband prefix). So you would
miss, for example, a sideband error that came after the pack had
started. So it is really only useful for looking at the ref and object
negotiation phases.

I know that probably sounds a bit nit-picky, but it might be worth
making the distinction in case somebody is trying to track down such
messages.

-Peff
