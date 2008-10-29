From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file
	modification time
Date: Wed, 29 Oct 2008 17:54:45 -0400
Message-ID: <20081029215444.GA19874@sigill.intra.peff.net>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 22:56:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvJ1W-0004ez-Du
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 22:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbYJ2Vyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYJ2Vys
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 17:54:48 -0400
Received: from peff.net ([208.65.91.99]:3808 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655AbYJ2Vys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 17:54:48 -0400
Received: (qmail 31490 invoked by uid 111); 29 Oct 2008 21:54:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 29 Oct 2008 17:54:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2008 17:54:45 -0400
Content-Disposition: inline
In-Reply-To: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99417>

On Wed, Oct 29, 2008 at 11:38:32AM +0100, Alex Riesen wrote:

> There can be a problem with "-printf": Open Group SUS does not specify
> -printf for find(1), so it is probably a problem somewhere. I just don't know.
> [...]
> +     find extract/a/a -printf "%T@\\n" >b.mtime &&

$ uname -sr
FreeBSD 6.1-RELEASE-p17-jc1
$ find . -printf "%T@\\n"
find: -printf: unknown option

> There is always a fallback, which is to write a small program which calls
> native stat(2). Or modify test-chmtime to just print mtime when asked.

I think that makes the most sense.

-Peff
