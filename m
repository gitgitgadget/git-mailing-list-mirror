From: Jim Meyering <jim@meyering.net>
Subject: Re: (resend) [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Sun, 24 Jun 2007 21:13:35 +0200
Message-ID: <87abupyxls.fsf@rho.meyering.net>
References: <87abuq1z6f.fsf@rho.meyering.net>
	<7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 24 21:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2XWj-0000KZ-MK
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 21:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbXFXTNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXFXTNg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 15:13:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47362 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbXFXTNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 15:13:36 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 34EE35A272
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 21:13:35 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 146C426108; Sun, 24 Jun 2007 21:13:35 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 24 Jun 2007 10\:08\:01 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50812>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
...
> I also don't think it's very _pretty_ code, and it violates my personal
> coding standards by adding way too deep indentation for the new error
> cases. It was already three indents deep (reasonably fine, but that
> NOT_BARE test wass already pretty ugly), but now it becomes five
> indentation levels deep at its deepest, which is just a sign that things
> should be split up.

I too disliked the form of my patch, and said so.

> I'd also like to know why it does that fcntl() is done,

In the quoted message, I explained that stdout was already
closed in some cases.  The fcntl test avoids the EINVAL you'd
get for closing an already-closed file descriptor.
