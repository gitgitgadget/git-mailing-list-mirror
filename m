From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/6] t0021: use $SHELL_PATH for the filter script
Date: Sun, 3 Jan 2010 02:24:08 -0500
Message-ID: <20100103072408.GA23031@sigill.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
 <20091230110335.GF22959@coredump.intra.peff.net>
 <4B3E73AE.6050003@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 03 08:24:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRKpN-0001sA-1l
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 08:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab0ACHYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 02:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096Ab0ACHYM
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 02:24:12 -0500
Received: from peff.net ([208.65.91.99]:42164 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab0ACHYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 02:24:11 -0500
Received: (qmail 31727 invoked by uid 107); 3 Jan 2010 07:28:55 -0000
Received: from 97-81-72-200.dhcp.athn.ga.charter.com (HELO sigill.intra.peff.net) (97.81.72.200)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 03 Jan 2010 02:28:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Jan 2010 02:24:08 -0500
Content-Disposition: inline
In-Reply-To: <4B3E73AE.6050003@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136067>

On Fri, Jan 01, 2010 at 11:14:06PM +0100, Johannes Sixt wrote:

> On Windows, we need the shbang line to correctly invoke shell scripts via
> a POSIX shell, except when the script is invoked via 'sh -c' because
> sh (a bash) does "the right thing". Since nowadays the clean and smudge
> filters are not always invoked via 'sh -c' anymore, we have to mark the
> the one in t0021-conversion with #!$SHELL_PATH.

Hrm. This does mean we might be breaking users who have helper scripts
in a similar state to those in the test suite (of course, so does your
pager hack, or anything which might optimize out a shell call).  But
perhaps given that scripts without a shebang generally don't work on
Windows, they are not too common and we don't need to worry about it.

-Peff
