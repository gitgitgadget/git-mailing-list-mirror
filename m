From: Jeff King <peff@peff.net>
Subject: Re: How to extract files out of a "git bundle", no matter what?
Date: Fri, 19 Dec 2008 15:51:00 -0500
Message-ID: <20081219205100.GA26671@coredump.intra.peff.net>
References: <20081219202118.GA26513@coredump.intra.peff.net> <87vdtfc389.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 21:52:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDmKn-0003mK-Jr
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 21:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbYLSUvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYLSUvG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 15:51:06 -0500
Received: from peff.net ([208.65.91.99]:3488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbYLSUvE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 15:51:04 -0500
Received: (qmail 19744 invoked by uid 111); 19 Dec 2008 20:51:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Dec 2008 15:51:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Dec 2008 15:51:00 -0500
Content-Disposition: inline
In-Reply-To: <87vdtfc389.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103583>

On Sat, Dec 20, 2008 at 04:35:50AM +0800, jidanni@jidanni.org wrote:

> JK>   - the object pack in the bundle is "thin", meaning it may contain
> JK>     deltas against objects that are reachable from A, but not B. So even
> JK>     _within_ a changed file, you may see only the changes from A to B.
> 
> OK, we here at the police forensics department would be very happy if
> we could at least get some ASCII out of that .BDL file, even if it is
> just a diff shred,
> -       The password to the time bomb was BLORFZ
> +       The password to the time bomb is  NORFLZ
> that would be fine. All we know is after the work PACK it is all
> binary, and git-unpack-objects and git-unpack-file don't work on it.

AFAIK, there is no tool to try salvaging strings from an incomplete pack
(and you can't just run "strings" because the deltas are zlib
compressed). So if I were in the police forensics department, I think I
would read Documentation/technical/pack-format.txt and start hacking a
solution as quickly as possible.

-Peff
