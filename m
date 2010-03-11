From: Jeff King <peff@peff.net>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Thu, 11 Mar 2010 02:11:45 -0500
Message-ID: <20100311071145.GA5919@sigill.intra.peff.net>
References: <loom.20100310T203316-38@post.gmane.org>
 <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
 <20100310200728.GD21994@spearce.org>
 <loom.20100310T225229-469@post.gmane.org>
 <20100310221228.GA4223@sigill.intra.peff.net>
 <20100310221403.GF21994@spearce.org>
 <20100310223210.GC4223@sigill.intra.peff.net>
 <4B9896D4.2020106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Patrick Higgins <patrick133t@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 11 08:11:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpcYj-0003lC-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 08:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab0CKHLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 02:11:49 -0500
Received: from peff.net ([208.65.91.99]:45278 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab0CKHLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 02:11:48 -0500
Received: (qmail 26450 invoked by uid 107); 11 Mar 2010 07:12:12 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 11 Mar 2010 02:12:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Mar 2010 02:11:45 -0500
Content-Disposition: inline
In-Reply-To: <4B9896D4.2020106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141936>

On Thu, Mar 11, 2010 at 08:08:04AM +0100, Johannes Sixt wrote:

> > It depends on the shell. Bash will expand it in _some_ cases (but not
> > this one). Dash never will:
> > 
> >   $ echo $BASH_VERSION
> >   4.1.0(1)-release
> >   $ echo foo=~/foo ;# expands
> >   foo=/home/peff/foo
> 
> This is wrong, FWIW. Tilde expansion must happen only at the beginning of
> a word or, when in an assignment, at the beginning of the assigned value
> or after any unquoted ':'. Note that in `echo foo=~/foo`, what looks like
> an assignment is *not* an assignment in POSIX shell lingo because it comes
> after the command name.

Thanks for the reference. I thought it was a bit funny when I wrote the
above, but just assumed it was implementation defined.

I think it doesn't change our outcome, though. Even though we cannot
rely on the shell to do such an expansion, it is still probably not sane
to assume ls-files will do it. Git's expansion is connected with the
config entry, not the use in ls-files, and it is git-gui's
responsibility to correctly expand as it reads the config.

-Peff
