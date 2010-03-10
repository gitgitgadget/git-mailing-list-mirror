From: Jeff King <peff@peff.net>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 17:36:50 -0500
Message-ID: <20100310223650.GA4710@sigill.intra.peff.net>
References: <loom.20100310T203316-38@post.gmane.org>
 <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
 <20100310200728.GD21994@spearce.org>
 <loom.20100310T225229-469@post.gmane.org>
 <20100310221228.GA4223@sigill.intra.peff.net>
 <20100310221403.GF21994@spearce.org>
 <20100310223210.GC4223@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Higgins <patrick133t@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 23:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpUWR-000269-3U
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378Ab0CJWgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 17:36:53 -0500
Received: from peff.net ([208.65.91.99]:44749 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757342Ab0CJWgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 17:36:53 -0500
Received: (qmail 20304 invoked by uid 107); 10 Mar 2010 22:37:16 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 10 Mar 2010 17:37:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Mar 2010 17:36:50 -0500
Content-Disposition: inline
In-Reply-To: <20100310223210.GC4223@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141930>

On Wed, Mar 10, 2010 at 05:32:10PM -0500, Jeff King wrote:

> It depends on the shell. Bash will expand it in _some_ cases (but not
> this one). Dash never will:
> 
>   $ echo $BASH_VERSION
>   4.1.0(1)-release
>   $ echo foo=~/foo ;# expands
>   foo=/home/peff/foo
>   $ echo --foo=~/foo ;# does not
>   --foo=~/foo
>   $ dash -c 'echo foo=~/foo' ;# does not
>   foo=~/foo
> 
> That being said, my gut feeling is for git-gui to fix it, too. Shell
> callers can use $HOME if they want.

By the way, the only reason I hesitated on that in the first mail is
that it feels a little unelegant. If a config variable grows --path
semantics, _all_ script callers have to be updated. It might be nice to
have "git config --dwim core.excludesfile" which does the "normal"
expansion. But that would mean a central DWIM-list, and git config is
sprinkled throughout the codebase, so it's probably not worth the
refactoring effort.

-Peff
