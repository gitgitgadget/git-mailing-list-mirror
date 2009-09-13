From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 16:42:31 -0400
Message-ID: <20090913204231.GA8654@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 22:42:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmvuB-0006q2-BB
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 22:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbZIMUmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755062AbZIMUmb
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 16:42:31 -0400
Received: from peff.net ([208.65.91.99]:38306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754393AbZIMUma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 16:42:30 -0400
Received: (qmail 20191 invoked by uid 107); 13 Sep 2009 20:42:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 16:42:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 16:42:31 -0400
Content-Disposition: inline
In-Reply-To: <7v1vmar353.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128410>

On Sun, Sep 13, 2009 at 01:38:48PM -0700, Junio C Hamano wrote:

> I saw some discussion on improving the wording.  Here is what I plan to
> commit.

Thanks for picking this up, I meant to re-post with improvements.

> +	else
> +		echo "Your configuration specifies to merge the ref"
> +		echo "'${upstream#refs/heads/}' from the remote, but no such ref"
> +		echo "was fetched."

What you have here is precisely what we observed. But I think one of the
complaints was to say more explicitly "that ref doesn't exist on the
remote", which I think should be the case if we have got to this point
(anything else would have triggered an error in fetch).

I don't have a strong feeling either way, though.

-Peff
