From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t6000lib.sh: tr portability fix fix
Date: Fri, 14 Mar 2008 17:45:50 -0400
Message-ID: <20080314214550.GA18326@coredump.intra.peff.net>
References: <20080314205415.GA17728@coredump.intra.peff.net> <47DAED87.1000408@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: armstrong.whit@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:46:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHjT-0006yj-NM
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbYCNVpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbYCNVpw
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:45:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1429 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754799AbYCNVpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:45:52 -0400
Received: (qmail 851 invoked by uid 111); 14 Mar 2008 21:45:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 17:45:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 17:45:50 -0400
Content-Disposition: inline
In-Reply-To: <47DAED87.1000408@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77289>

On Fri, Mar 14, 2008 at 04:26:31PM -0500, Brandon Casey wrote:

> Here's the version with escaped dashes. If you do the sed version, it's
> something to compare to for readability.
>
> [...]
>
> -		   '------------------------------' |
> +		   '\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-' |

Ugh. How about:

  sed 'yA~`!@#$%^&*()_+={}[]|\;:"<>,/? A------------------------------A'

The 'A' delimiter is because in my test, Solaris sed didn't seem to
understand \/ to include the literal '/'. And all of the other
punctuation is already used in the pattern. ;)

-Peff
