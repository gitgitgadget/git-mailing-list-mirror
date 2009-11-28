From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to
 installed bindir
Date: Sat, 28 Nov 2009 14:49:11 -0500
Message-ID: <20091128194910.GA17605@coredump.intra.peff.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
 <7vtywefn88.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 20:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETIF-0008Oi-RG
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbZK1TtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbZK1TtG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:49:06 -0500
Received: from peff.net ([208.65.91.99]:59831 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbZK1TtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:49:05 -0500
Received: (qmail 1580 invoked by uid 107); 28 Nov 2009 19:53:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Nov 2009 14:53:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2009 14:49:11 -0500
Content-Disposition: inline
In-Reply-To: <7vtywefn88.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133972>

On Sat, Nov 28, 2009 at 11:44:39AM -0800, Junio C Hamano wrote:

>    . Advertising this forces the Makefile build test-bin/ contents from
>      "all" target.  I think test-bin/ should only depend on "test" (iow,
>      after "make all && make install" there shouldn't have to be "test-bin"
>      directory.

Would implementing it that way mean that:

  make && cd t && make

does not work (or worse, might silently use stale information in
test-bin)? Dealing with this is part of the reason the valgrind code
(which similarly sets up a pseudo-installed directory) does everything
in test-lib.sh, and not as part of the make process.

-Peff
