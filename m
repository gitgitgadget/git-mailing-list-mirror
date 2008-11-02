From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git send-email: allow any rev-list option as an
	argument.
Date: Sun, 2 Nov 2008 13:02:21 -0500
Message-ID: <20081102180220.GA5726@sigio.intra.peff.net>
References: <1225450632-7230-3-git-send-email-madcoder@debian.org> <1225471925-2750-1-git-send-email-madcoder@debian.org> <20081102043523.GE5261@coredump.intra.peff.net> <20081102093907.GF4066@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 19:04:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwhIs-0002oA-60
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 19:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbYKBSCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbYKBSCQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 13:02:16 -0500
Received: from peff.net ([208.65.91.99]:2938 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbYKBSCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 13:02:14 -0500
Received: (qmail 26412 invoked by uid 111); 2 Nov 2008 18:02:12 -0000
Received: from sigio.intra.peff.net (HELO sigio.intra.peff.net) (10.0.0.10)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Nov 2008 13:02:12 -0500
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Nov 2008 13:02:21 -0500
Content-Disposition: inline
In-Reply-To: <20081102093907.GF4066@artemis>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99858>

On Sun, Nov 02, 2008 at 10:39:07AM +0100, Pierre Habouzit wrote:

> Well it still messes the file/reference name conflict with no way to
> prevent it because of the backward compatibility, and even if unlikely
> it's still possible.

Hmm. As Junio mentioned, this is really an easier way of doing:

  git format-patch -o tmp "$@"
  $EDITOR tmp/*
  git send-email tmp

So I guess a wrapper program would suffice, that just called send-email.
But of course then you would have to think of a new name, and explain
the confusion between it and send-email.

-Peff
