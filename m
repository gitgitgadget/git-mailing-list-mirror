From: Jeff King <peff@peff.net>
Subject: Re: How to install and use a custom merge driver
Date: Thu, 29 Jan 2009 00:03:48 -0500
Message-ID: <20090129050348.GA31202@coredump.intra.peff.net>
References: <497FCC9A.9080008@gmail.com> <20090128061848.GA19165@coredump.intra.peff.net> <loom.20090128T230123-889@post.gmane.org> <20090129032531.GA11836@coredump.intra.peff.net> <loom.20090129T044425-689@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alec Clews <alecclews@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 06:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSP5a-0002r5-GW
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 06:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZA2FDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 00:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbZA2FDw
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 00:03:52 -0500
Received: from peff.net ([208.65.91.99]:56446 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbZA2FDv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 00:03:51 -0500
Received: (qmail 28906 invoked by uid 107); 29 Jan 2009 05:04:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 00:04:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 00:03:48 -0500
Content-Disposition: inline
In-Reply-To: <loom.20090129T044425-689@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107632>

On Thu, Jan 29, 2009 at 04:47:19AM +0000, Alec Clews wrote:

> It appears that TAB is not supported as white space in either attributes or 
> config files? I removed all the tabs and it works as described on the box

That's odd. It should be fine. And if I repeat the test I posted with:

  printf '*\tmerge=overwrite\n' >.git/info/attributes
  (printf '[merge "overwrite"]\n'
   printf '\tname = overwrite using cp\n'
   printf '\tdriver = cp %%B %%A\n'
  ) >>.git/config

it works as before.

What git version are you using? Can you post a shell snippet that breaks
reliably?

-Peff
