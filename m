From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 05:04:37 -0400
Message-ID: <20080613090437.GA4474@sigill.intra.peff.net>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil> <20080612041847.GB24868@sigill.intra.peff.net> <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil> <20080613054840.GA27122@sigill.intra.peff.net> <CA1D4ABE-0B83-44CC-B582-1E85784330AB@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 11:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K75E0-0004Un-Vf
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 11:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbYFMJEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 05:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755030AbYFMJEm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 05:04:42 -0400
Received: from peff.net ([208.65.91.99]:3230 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbYFMJEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 05:04:41 -0400
Received: (qmail 8414 invoked by uid 111); 13 Jun 2008 09:04:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 05:04:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 05:04:37 -0400
Content-Disposition: inline
In-Reply-To: <CA1D4ABE-0B83-44CC-B582-1E85784330AB@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84853>

On Fri, Jun 13, 2008 at 10:41:42AM +0200, Wincent Colaiuta wrote:

> For me it is quite clear that stashing something _is_ asking for Git to 
> remember it. It's an explicit user action. It's a request to remember 
> something. Whether or not this is actually the best tool for the job of 
> long-term storage is much less important than the fact that the user 
> explicitly requested it. IMO this trumps all other factors. Just because 
> "stash" sounds quicker than "commit" doesn't make it any less of an 
> instruction to Git to store something.

I think you missed the point of my email. I understand that it is clear
to you that you are asking for permanent storage. However, it is equally
clear to me (and to people involved in the design of git stash) that you
are not asking for permanent storage, because that is not what git stash
does.

In other words, we are both proceeding from impressions of what the tool
is meant to do, and what we are asking it to do.

If you are making the argument that new users will be confused, that the
documentation is insufficient, or that this is inconsistent with other
aspects of git's interface, then those are good reasons to argue what
stash _should_ do.

That being said, see the exchanges between Andreas and myself elsewhere
in the thread. I think there is a reasonable argument that "git stash"
_is_ useful for long term storage, and that one way we can support that
is removing the expiration.

So while I prefer the expiration behavior, I think it is reasonable to
sacrifice that to help adapt the tool for a different workflow.

-Peff
