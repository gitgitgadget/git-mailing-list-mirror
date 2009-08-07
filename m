From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] mailinfo: allow individual e-mail files as input
Date: Thu, 6 Aug 2009 21:18:20 -0400
Message-ID: <20090807011820.GA16472@coredump.intra.peff.net>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
 <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil>
 <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, ni.s@laposte.net, giuseppe.bilotta@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:18:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZE6M-0006jK-0k
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbZHGBS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756879AbZHGBS0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:18:26 -0400
Received: from peff.net ([208.65.91.99]:48145 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867AbZHGBSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:18:25 -0400
Received: (qmail 3041 invoked by uid 107); 7 Aug 2009 01:20:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 Aug 2009 21:20:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2009 21:18:20 -0400
Content-Disposition: inline
In-Reply-To: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125152>

On Thu, Aug 06, 2009 at 08:08:12PM -0500, Brandon Casey wrote:

> You'll notice that I changed your grep -E to an egrep and dropped the -e.
> I do not see any other grep which uses -e, and I seem to recall Jeff King
> actively removing -e claiming that some greps do not recognize it.  I do not
> have a perfect memory though, so apologies to Jeff if I am mistaken.

Fortunately git does have a perfect memory:

  $ git log -1 --all-match --author=peff --grep=grep
  commit 759ad19e772a79a2a5ae6b7377d57eb21d29e6a0
  Author: Jeff King <peff@peff.net>
  Date:   Wed Oct 22 15:22:53 2008 -0400

      submodule: fix some non-portable grep invocations

      Not all greps support "-e", but in this case we can easily
      convert it to a single extended regex.

The grep in question is Solaris 8's /usr/bin/grep (which also needs
"egrep" instead of "-E", as you already did).

-Peff
