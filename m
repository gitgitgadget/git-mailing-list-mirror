From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] solaris test fixups
Date: Thu, 23 Jan 2014 15:54:04 -0500
Message-ID: <20140123205404.GA12757@sigill.intra.peff.net>
References: <20140123195404.GA31314@sigill.intra.peff.net>
 <xmqqeh3yto8h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6RHw-0005op-F9
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbaAWUyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:54:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:37763 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751331AbaAWUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:54:06 -0500
Received: (qmail 31359 invoked by uid 102); 23 Jan 2014 20:54:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 14:54:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 15:54:04 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh3yto8h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240951>

On Thu, Jan 23, 2014 at 12:52:30PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > and assume that it will fail. It doesn't. Solaris happily renames
> > some-file to a regular file named "no-such-dir". So we fail later during
> > the index-update, complaining about adding the entry "no-such-dir/", but
> > still exit(0) at the end. I'm mostly willing to just call Solaris crazy
> > for allowing the rename (Linux returns ENOTDIR), but I do wonder if
> > the index codepath could be improved (and especially to return an
> > error).
> 
> I think j6t has a patch for that, a8933469 (mv: let 'git mv file
> no-such-dir/' error out on Windows, too, 2014-01-08).

Ah yeah, that looks like exactly the same issue (and the fix looks sane
from my cursory investigation). Thanks for the pointer. I wasn't
planning to look further into it, but now I can do so without feeling
guilty. :)

-Peff
