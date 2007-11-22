From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Suppress spurious linefeeds in git-add--interactive
Date: Thu, 22 Nov 2007 03:59:20 -0500
Message-ID: <20071122085919.GB7153@sigill.intra.peff.net>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <1195689773-28601-1-git-send-email-win@wincent.com> <1195689773-28601-2-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7uP-0006Y2-SU
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXKVI7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXKVI7X
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:59:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3886 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXKVI7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:59:22 -0500
Received: (qmail 20890 invoked by uid 111); 22 Nov 2007 08:59:21 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 03:59:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 03:59:20 -0500
Content-Disposition: inline
In-Reply-To: <1195689773-28601-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65759>

On Thu, Nov 22, 2007 at 01:02:50AM +0100, Wincent Colaiuta wrote:

> +	return undef if ($#diff == -1);

Style nit: I think the rest of the code generally uses (and I prefer)
"@diff" to get the number of elements. So:

  return undef unless @diff;

or I might even have written

  my @diff = ...
    or return undef;

but perhaps I am the only one who finds $#array comparisons to -1 hard
on the eyes.

-Peff
