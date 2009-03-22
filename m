From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git gui doesn't call post-checkout hook on checkout or
	clone
Date: Sun, 22 Mar 2009 18:33:09 -0400
Message-ID: <20090322223309.GA22428@sigill.intra.peff.net>
References: <49C65DF1.8030608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:38:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWJ3-0004bD-HM
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbZCVWdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbZCVWdL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 18:33:11 -0400
Received: from peff.net ([208.65.91.99]:44327 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbZCVWdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 18:33:11 -0400
Received: (qmail 16608 invoked by uid 107); 22 Mar 2009 22:33:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 22 Mar 2009 18:33:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 18:33:09 -0400
Content-Disposition: inline
In-Reply-To: <49C65DF1.8030608@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114189>

On Sun, Mar 22, 2009 at 04:49:05PM +0100, Jens Lehmann wrote:

> When checking out or cloning via git gui, the post-checkout
> hook is not called. This is a bit unexpected ...
> 
> The reason is that git gui uses git read-tree with the -u
> option and not git checkout and git clone. I changed git
> read-tree to call the post-checkout hook when called with
> -u and it seems to solve the problem. I would make a patch
> for that if you want.
> 
> But is this the right way to do this? Seems like we could
> surprise some users of git read-tree with this change in
> behaviour.

No, I think plumbing should not generally call hooks. The right solution
would be to have git-gui call the post-checkout hook.

-Peff
