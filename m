From: Pavel Roskin <proski@gnu.org>
Subject: Re: git on HP-UX
Date: Thu, 06 Jul 2006 10:53:49 -0400
Message-ID: <1152197629.7720.10.camel@dv>
References: <200607060950.34558.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 16:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyVEz-0002Bl-VH
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 16:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWGFOyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 10:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWGFOyA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 10:54:00 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:53738 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030302AbWGFOx5
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 10:53:57 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FyVEq-0001i1-M9
	for git@vger.kernel.org; Thu, 06 Jul 2006 10:53:56 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FyVEj-00035Y-Fc; Thu, 06 Jul 2006 10:53:49 -0400
To: Michal Rokos <michal.rokos@nextsoft.cz>
In-Reply-To: <200607060950.34558.michal.rokos@nextsoft.cz>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23393>

Hello!

On Thu, 2006-07-06 at 09:50 +0200, Michal Rokos wrote:
> Hello,
> 
> I needed following changes in order to make git compile on HP-UX:
> +ifeq ($(uname_S),HP-UX)
> +	NO_IPV6 = YesPlease
> +	NO_CURL = YesPlease

Is there any fundamental problem with curl and IPv6 on HP-UX?  I don't
think so.

Sorry for using your path as a bad example, but the appearance of such
patches is a perfect argument for a real configure script.  If we
continue patching Makefile, we'll drown in such conditionals.  And the
worst thing is, nobody without access to an HP-UX system will know why
IPv6 isn't working there.  Makefile will become a pile of code that
cannot be easily verified for correctness.

Autoconf based tests can actually test if certain code can be compiled
and linked.  If HP-UX fixed IPv6, the test would enable it.  If some
genius manages to compile curl on HP-UX, http support will be enabled on
that machine with no manual changes in Makefile.

I hope the Autoconf based configure is on its way to git, but I don't
see in in the "pu" branch yet.  I'm not very keen about reinventing
Autoconf and hacking a hand-made configure script.

-- 
Regards,
Pavel Roskin
