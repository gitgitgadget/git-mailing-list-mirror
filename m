From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'git log --quiet' doesn't suppress the output
Date: Fri, 6 Feb 2009 14:11:46 -0500
Message-ID: <20090206191146.GC19494@coredump.intra.peff.net>
References: <885649360902041819k4a168407wc57017e6a1c7d00a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVW91-0003RN-Ad
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbZBFTLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbZBFTLt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:11:49 -0500
Received: from peff.net ([208.65.91.99]:55719 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbZBFTLt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:11:49 -0500
Received: (qmail 24191 invoked by uid 107); 6 Feb 2009 19:12:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 14:12:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 14:11:46 -0500
Content-Disposition: inline
In-Reply-To: <885649360902041819k4a168407wc57017e6a1c7d00a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108773>

On Wed, Feb 04, 2009 at 07:19:28PM -0700, James Pickens wrote:

> The --quiet switch to 'git log' doesn't suppress the output.  It only
> does the same as --exit-code.

It suppresses the diff output (which is why it supports --quiet at all:
it is a diff option). So

  git log -p --quiet

looks just like

  git log

making it largely pointless.

It would probably be trivial to for "git log" to see that the quiet
switch was given and silence the commit output. But I am having trouble
envisioning exactly what that would be useful for (except for being a
slower version of "cat /dev/null"). Care to elaborate?

-Peff
