From: Jeff King <peff@peff.net>
Subject: Re: GPG signing for git commit?
Date: Fri, 17 Apr 2009 08:01:10 -0400
Message-ID: <20090417120110.GC29121@coredump.intra.peff.net>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int> <20090415192054.GE23604@spearce.org> <20090415T220710Z@curie.orbis-terrarum.net> <20090416142728.GG23604@spearce.org> <slrngufuke.1am.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 14:02:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LummQ-0006HF-SU
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 14:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760880AbZDQMBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 08:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760856AbZDQMBS
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 08:01:18 -0400
Received: from peff.net ([208.65.91.99]:36607 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760700AbZDQMBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 08:01:17 -0400
Received: (qmail 16162 invoked by uid 107); 17 Apr 2009 12:01:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Apr 2009 08:01:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2009 08:01:10 -0400
Content-Disposition: inline
In-Reply-To: <slrngufuke.1am.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2009 at 03:42:07AM +0000, Sitaram Chamarty wrote:

> > Uhm, yea.  That's a fault of gitosis then.  It knows the key that
> > was used, and has that mapped back to some token that identifies that
> > account in the configuration file.  Why it doesn't push that into the
> > GIT_COMMITTER_* environment before launching git-shell, I don't know.
> 
> If you set GIT_COMMITTER_*, won't it change the SHA of the
> commit itself?  I always thought so...

No. Pushing will never create a new commit, so there are no new SHA-1s
calculated. But the reflog entry will contain GIT_COMMITTER_*, and is a
simple text file.

-Peff
