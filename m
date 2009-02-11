From: Jeff King <peff@peff.net>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 13:05:59 -0500
Message-ID: <20090211180559.GC19749@coredump.intra.peff.net>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:07:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJUg-00006L-29
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbZBKSGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756187AbZBKSGD
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:06:03 -0500
Received: from peff.net ([208.65.91.99]:35178 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755677AbZBKSGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:06:01 -0500
Received: (qmail 31989 invoked by uid 107); 11 Feb 2009 18:06:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 13:06:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 13:05:59 -0500
Content-Disposition: inline
In-Reply-To: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109465>

On Wed, Feb 11, 2009 at 06:24:29PM +0200, Ciprian Dorin, Craciun wrote:

>    15  git push file:///tmp/r2 master
> Counting objects: 3, done.
> Writing objects: 100% (3/3), 197 bytes, done.
> Total 3 (delta 0), reused 0 (delta 0)
> error: unpack should have generated
> ea8c5601f49a4bdeea03db3adb909d590ea730d3, but I can't find it!
> To file:///tmp/r2
>  ! [remote rejected] master -> master (bad pack)
> error: failed to push some refs to 'file:///tmp/r2'

I can't reproduce the problem here. It looks like your receive-pack is
somehow broken (which should be the only difference between pushing to a
local repo and a remote one).

Can you try with a vanilla version of git to be sure it is not your
add-on patch responsible?

-Peff
