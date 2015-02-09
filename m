From: Jeff King <peff@peff.net>
Subject: Re: Fwd: segmentation fault 11
Date: Sun, 8 Feb 2015 20:36:57 -0500
Message-ID: <20150209013657.GC21072@peff.net>
References: <CAOFaZ+5=bkWZpy1vFZjqMCgkWQySxGhLyfKhyH-VWDLJ28nTVQ@mail.gmail.com>
 <CAOFaZ+42Wbk8t_UmLGwxhRo+ZZOhpUT32o5wuj+LcJhaELOu5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Krmpotic <david.krmpotic@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:37:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKdHg-0000Do-AS
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 02:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbbBIBhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 20:37:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:46626 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750831AbbBIBhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 20:37:00 -0500
Received: (qmail 17328 invoked by uid 102); 9 Feb 2015 01:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 19:37:00 -0600
Received: (qmail 26971 invoked by uid 107); 9 Feb 2015 01:37:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 20:37:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:36:57 -0500
Content-Disposition: inline
In-Reply-To: <CAOFaZ+42Wbk8t_UmLGwxhRo+ZZOhpUT32o5wuj+LcJhaELOu5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263543>

On Sun, Feb 08, 2015 at 06:56:14PM +0100, David Krmpotic wrote:

> I updated to 2.3.0 on my OSX 10.9.5 and when trying to push to github
> (git push -u origin master), I get:
> 
> Segmentation fault: 11
> 
> Switched back to 1.8.5.5 and it works...

Is this reproducible easily? If so, can you do one or both of:

  1. Get a backtrace by running git-push under gdb (and/or loading gdb
     on the core file if you have it). The report you linked mentions
     that we were in "0x0000000102b70ebe cmd_push + 2466", but without
     having your binary, that only gives a vague sense of the line
     that caused the problem.

  2. Bisect the bug between v1.8.5.5 and v2.3.0. I can walk you through
     the specific steps if you've never bisected before.

Thanks.

-Peff
