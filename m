From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Mon, 16 Nov 2015 11:34:05 -0500
Message-ID: <20151116163404.GB15046@sigill.intra.peff.net>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
 <20151113062534.GE32157@sigill.intra.peff.net>
 <CABA5-zk+RVBxfmuLyK8CcCFUpMXEzbHRKeWWV2SKsJqjnG-nfA@mail.gmail.com>
 <20151113222748.GA14830@sigill.intra.peff.net>
 <CABA5-zmmKeeDDhSdan9sTppRVeDNuPiR8WX=P4Umdbq=ELafqw@mail.gmail.com>
 <20151113230933.GA16173@sigill.intra.peff.net>
 <alpine.DEB.1.00.1511161656480.1686@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 16 17:34:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyMjO-00081c-8w
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 17:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbbKPQeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 11:34:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:58152 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752024AbbKPQeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 11:34:07 -0500
Received: (qmail 5193 invoked by uid 102); 16 Nov 2015 16:34:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 10:34:07 -0600
Received: (qmail 13966 invoked by uid 107); 16 Nov 2015 16:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 11:34:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2015 11:34:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1511161656480.1686@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281348>

On Mon, Nov 16, 2015 at 05:01:03PM +0100, Johannes Schindelin wrote:

> To clarify the Git for Windows scenario: SHELL_PATH is indeed set to
> `/bin/sh`, but reportedly it is converted into a full Windows path when we
> leave the POSIX emulation layer, i.e. when `git.exe` is called (which has
> *no* idea about POSIX paths, or at least next to none).
> 
> The reason is, of course, that regular Windows programs would not know
> what to do with the path /bin/sh.
> 
> The problem arises when we re-enter the POSIX realm, i.e. when we run a
> script (such as `git-rebase`): the path is not converted back!

Ah, thanks for this explanation. The whole thing seems much more clear
to me now.

Even if later versions give us back the POSIX name, I think Fredrik's
patch is a sane solution (and arguably how it should have been written
in the first place, even leaving aside this issue).

-Peff
