From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Fri, 27 Jan 2012 00:42:16 -0500
Message-ID: <20120127054216.GA23633@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
 <20120126230054.GC12855@sigill.intra.peff.net>
 <7vsjj20yog.fsf@alter.siamese.dyndns.org>
 <20120127004902.GA15257@sigill.intra.peff.net>
 <7vd3a51zlb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:42:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqeZu-0002qP-10
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab2A0FmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:42:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46313
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab2A0FmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:42:20 -0500
Received: (qmail 2222 invoked by uid 107); 27 Jan 2012 05:49:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jan 2012 00:49:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2012 00:42:16 -0500
Content-Disposition: inline
In-Reply-To: <7vd3a51zlb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189193>

On Thu, Jan 26, 2012 at 09:30:56PM -0800, Junio C Hamano wrote:

> While I do not think origin/meta:config is a sensible default, I actually
> do think that:
> 
> 	[include]
>         	ref = meta:gitconfig
>         [branch "meta"]
> 		remote = origin
>         	merge = refs/heads/meta
> 
> makes some sense. The earlier example with the in-tree dev_tools/config in
> the same line of history as the usual source material to keep track of
> private changes ("this single user hating it") was not realistic as it
> forbids the user from sharing the rest of the source once she decides to
> fork the config preference.

I don't think having it in-tree makes a difference. I can fork the
regular tree into my config branch, and it contains only my config
changes. If I want to share config changes with people, then I do so by
sharing that branch. But it need not have any impact on the "real"
branch I create from the regular tree. The fact that the rest of the
source files are in the config branch are irrelevant.

That being said, I think it would be nicer for projects to carry meta
information like this out-of-tree in a special ref. It's just simpler to
work with, and it means the project's source isn't polluted with extra
junk.

-Peff
