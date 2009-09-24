From: Jeff King <peff@peff.net>
Subject: Re: Per-remote tracking branch
Date: Thu, 24 Sep 2009 02:29:12 -0400
Message-ID: <20090924062911.GC24486@coredump.intra.peff.net>
References: <vpq4or48bux.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:29:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqhpH-0005Ds-E2
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 08:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZIXG3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 02:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbZIXG3B
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 02:29:01 -0400
Received: from peff.net ([208.65.91.99]:43259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbZIXG3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 02:29:00 -0400
Received: (qmail 3137 invoked by uid 107); 24 Sep 2009 06:32:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 24 Sep 2009 02:32:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2009 02:29:12 -0400
Content-Disposition: inline
In-Reply-To: <vpq4or48bux.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129023>

On Tue, Sep 15, 2009 at 05:29:58PM +0200, Matthieu Moy wrote:

> Is there a way, with Git, to specify a tracking branch on a per-remote
> basis?

I don't think so, and I'm not sure there is an easy way to extend the
current configuration scheme. Adding multiple config options like this:

  [branch "master"]
    remote = origin
    merge = refs/heads/master
    remote = alternate
    merge = refs/heads/master

looks a bit hack-ish to me, as there is an implicit correlation between
the ordering of 'merge' entries and 'remote' entries.

And it feels a little backwards. When I say "git pull foo", I would find
it equally likely to discover the pulled branch under "remote.foo" as it
would to find it under "branch.master". Of course, in either case, you
have to combine the context (current branch _and_ selected remote)
to come up with the actual information. So I guess either is "equally
correct" in a sense.

Anyway, mostly just my idle speculation.

-Peff
