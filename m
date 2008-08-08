From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Teach git diff-tree --stdin to diff trees
Date: Fri, 8 Aug 2008 17:45:23 -0400
Message-ID: <20080808214523.GA31424@sigill.intra.peff.net>
References: <20080808204348.7744.46006.stgit@yoghurt> <20080808204829.7744.11661.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 23:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRZnC-0007il-HB
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 23:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758475AbYHHVp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 17:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759230AbYHHVp0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 17:45:26 -0400
Received: from peff.net ([208.65.91.99]:3373 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759011AbYHHVpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 17:45:25 -0400
Received: (qmail 23651 invoked by uid 111); 8 Aug 2008 21:45:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 08 Aug 2008 17:45:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Aug 2008 17:45:23 -0400
Content-Disposition: inline
In-Reply-To: <20080808204829.7744.11661.stgit@yoghurt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91719>

On Fri, Aug 08, 2008 at 10:48:29PM +0200, Karl Hasselstr=C3=B6m wrote:

>  --stdin::
>  	When '--stdin' is specified, the command does not take
>  	<tree-ish> arguments from the command line.  Instead, it
> -	reads either one <commit> or a list of <commit>
> -	separated with a single space from its standard input.
> +	reads lines containing either two <tree>, one <commit>, or a
> +	list of <commit> from its standard input.  (Use a single space
> +	as separator.)

Hmm. Just looking at this as a git user, I would have expected it to
take one or more hashes, separated by spaces. If only one, then it must
be a commit, and it is diffed against its parents. If more than one,
then each must be a tree-ish. So you could diff a commit against a tree
(or a tag against a commit, or...).

And I think it might even be easier to code. ;)

-Peff
