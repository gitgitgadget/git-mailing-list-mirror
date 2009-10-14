From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 01:13:19 -0400
Message-ID: <20091014051319.GF31810@coredump.intra.peff.net>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, elliot@catalyst.net.nz
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:16:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxwE9-0001J1-7b
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZJNFN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZJNFN5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:13:57 -0400
Received: from peff.net ([208.65.91.99]:39316 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbZJNFN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:13:56 -0400
Received: (qmail 24606 invoked by uid 107); 14 Oct 2009 05:16:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 01:16:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 01:13:19 -0400
Content-Disposition: inline
In-Reply-To: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130251>

On Wed, Oct 14, 2009 at 05:45:25PM +1300, Sam Vilain wrote:

> Add a simple hook that will run before checkouts.

What is the use case that makes it useful as a hook, and not simply as
something people can do before running checkout?

I guess you can use it to block a checkout, but only after finding out
_what_ you are going to checkout, but an exact use case escapes me.

> -post-checkout
> -~~~~~~~~~~~~~
> -
> -This hook is invoked when a 'git-checkout' is run after having updated the
> +This hook is invoked when a 'git-checkout' is run after before updating the

Did you mean "before having" here?

>  worktree.  The hook is given three parameters: the ref of the previous HEAD,
>  the ref of the new HEAD (which may or may not have changed), and a flag
>  indicating whether the checkout was a branch checkout (changing branches,
>  flag=1) or a file checkout (retrieving a file from the index, flag=0).
> -This hook cannot affect the outcome of 'git-checkout'.
> +This hook can prevent the checkout from proceeding by exiting with an
> +error code.
>  
>  It is also run after 'git-clone', unless the --no-checkout (-n) option is
>  used. The first parameter given to the hook is the null-ref, the second the
>  ref of the new HEAD and the flag is always 1.

Should this "after" in the bottom paragraph perhaps become "during"?

-Peff
