From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 01:25:27 -0400
Message-ID: <20091014052527.GH31810@coredump.intra.peff.net>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
 <7vr5t6lfr0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org,
	elliot@catalyst.net.nz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxwRH-0001cU-Bf
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbZJNF0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbZJNF0F
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:26:05 -0400
Received: from peff.net ([208.65.91.99]:41567 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbZJNF0E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:26:04 -0400
Received: (qmail 24745 invoked by uid 107); 14 Oct 2009 05:28:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 01:28:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 01:25:27 -0400
Content-Disposition: inline
In-Reply-To: <7vr5t6lfr0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130255>

On Tue, Oct 13, 2009 at 10:13:39PM -0700, Junio C Hamano wrote:

> >  worktree.  The hook is given three parameters: the ref of the previous HEAD,
> >  the ref of the new HEAD (which may or may not have changed), and a flag
> >  indicating whether the checkout was a branch checkout (changing branches,
> >  flag=1) or a file checkout (retrieving a file from the index, flag=0).
> > -This hook cannot affect the outcome of 'git-checkout'.
> > +This hook can prevent the checkout from proceeding by exiting with an
> > +error code.
> >  
> >  It is also run after 'git-clone', unless the --no-checkout (-n) option is
> >  used. The first parameter given to the hook is the null-ref, the second the
> >  ref of the new HEAD and the flag is always 1.
> >  
> > +This hook can be used to perform any clean-up deemed necessary before
> > +checking out the new branch/files.
> > +
> > +post-checkout
> > +-----------
> 
> This is not about your patch, but the patch text shows that our diff
> algorithm seems to have a room for improvement.  I expected to see a
> straight insersion of block of text, not touching anything in the original
> section on post-checkout hook.

I think it's right as-is. He changed the title of the section, made a
few tweaks in the text to make it appropriate for "pre-checkout", and
then made a new post-checkout section that says "This is just like
pre-checkout". So most of the lines were left untouched. Short of our
diff understanding the block-formatting of asciidoc, I think it's as
good as we can get.

-Peff
