From: Jeff King <peff@peff.net>
Subject: Re: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 12:54:20 -0400
Message-ID: <20090415165420.GB24528@coredump.intra.peff.net>
References: <49E61067.6060802@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8P1-0002ON-H0
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbZDOQy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbZDOQy0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:54:26 -0400
Received: from peff.net ([208.65.91.99]:46357 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbZDOQyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:54:25 -0400
Received: (qmail 26979 invoked by uid 107); 15 Apr 2009 16:54:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 12:54:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 12:54:20 -0400
Content-Disposition: inline
In-Reply-To: <49E61067.6060802@hartwork.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116628>

On Wed, Apr 15, 2009 at 06:50:47PM +0200, Sebastian Pipping wrote:

> Here is what I did:
> 
> $ git cat-file -t b8c11fbbffbe171c4960058fa2d96f708e57a80c
> commit
> 
> $ git cat-file b8c11fbbffbe171c4960058fa2d96f708e57a80c
> usage: git cat-file [-t|-s|-e|-p|<type>] <sha1>
>    or: git cat-file [--batch|--batch-check] < <list_of_sha1s>
> [..]

That usage message is misleading. You need to use one of -t, -s, -e, -p,
or <type>. So it should perhaps just be:

  git cat-file -t|-s|-e|-p|<type> <sha1>

though that looks terribly ugly. Suggestions welcome.

-Peff

P.S. Depending on what you're trying to accomplish, "git show <sha1>"
     may be a better choice.
